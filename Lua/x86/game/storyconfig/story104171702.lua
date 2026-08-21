return {
	Play417172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417172001
		arg_1_1.duration_ = 16.23

		local var_1_0 = {
			zh = 11.3,
			ja = 16.233
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
				arg_1_0:Play417172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.633333333333332

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "I07a"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.I07a

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_24 = "10113"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

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

			local var_4_28 = arg_1_1.actors_["10113"]
			local var_4_29 = 1.66666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10113 == nil then
				arg_1_1.var_.actorSpriteComps10113 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10113 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10113 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10113 = nil
			end

			local var_4_36 = arg_1_1.actors_["10113"].transform
			local var_4_37 = 1.66666666666667

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10113 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10113", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_6" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(-30.38, -328.4, -517.4)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10113, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_4_43 = arg_1_1.actors_["10113"]
			local var_4_44 = 1.66666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10113 = var_4_45.alpha
					arg_1_1.var_.characterEffect10113 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10113 = 0
			end

			local var_4_46 = 0.333333333333333

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10113, 1, var_4_47)

				if arg_1_1.var_.characterEffect10113 then
					arg_1_1.var_.characterEffect10113.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10113 then
				arg_1_1.var_.characterEffect10113.alpha = 1
			end

			local var_4_49 = 0

			arg_1_1.isInRecall_ = true

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")
				arg_1_1.hightColor1 = Color.New(0.8980392, 0.8980392, 0.8980392)
				arg_1_1.hightColor2 = Color.New(0.3411765, 0.3411765, 0.3411765)

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					local var_4_50 = iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_11, iter_4_12 in ipairs(var_4_50) do
						if iter_4_12.color.r > 0.51 then
							iter_4_12.color = Color.New(0.8980392, 0.8980392, 0.8980392)
						else
							iter_4_12.color = Color.New(0.3411765, 0.3411765, 0.3411765)
						end
					end
				end
			end

			local var_4_51 = 0.0666666666666667

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_51 then
				local var_4_52 = (arg_1_1.time_ - var_4_49) / var_4_51

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_52)
			end

			if arg_1_1.time_ >= var_4_49 + var_4_51 and arg_1_1.time_ < var_4_49 + var_4_51 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			local var_4_53 = 0

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_54 = 0.666666666666667

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 then
				local var_4_55 = (arg_1_1.time_ - var_4_53) / var_4_54
				local var_4_56 = Color.New(0, 0, 0)

				var_4_56.a = Mathf.Lerp(1, 0, var_4_55)
				arg_1_1.mask_.color = var_4_56
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				local var_4_57 = Color.New(0, 0, 0)
				local var_4_58 = 0

				arg_1_1.mask_.enabled = false
				var_4_57.a = var_4_58
				arg_1_1.mask_.color = var_4_57
			end

			local var_4_59 = 0
			local var_4_60 = 0.2

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				local var_4_61 = "play"
				local var_4_62 = "music"

				arg_1_1:AudioAction(var_4_61, var_4_62, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_63 = ""
				local var_4_64 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_65 = 0.3
			local var_4_66 = 1

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				local var_4_67 = "play"
				local var_4_68 = "music"

				arg_1_1:AudioAction(var_4_67, var_4_68, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_4_69 = ""
				local var_4_70 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if var_4_70 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_70 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_70

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_70
						arg_1_1.bgmTxt2_.text = var_4_70
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

			local var_4_71 = 2
			local var_4_72 = 1.225

			if var_4_71 < arg_1_1.time_ and arg_1_1.time_ <= var_4_71 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_73 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_73:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_74 = arg_1_1:FormatText(StoryNameCfg[1117].name)

				arg_1_1.leftNameTxt_.text = var_4_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_75 = arg_1_1:GetWordFromCfg(417172001)
				local var_4_76 = arg_1_1:FormatText(var_4_75.content)

				arg_1_1.text_.text = var_4_76

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_77 = 49
				local var_4_78 = utf8.len(var_4_76)
				local var_4_79 = var_4_77 <= 0 and var_4_72 or var_4_72 * (var_4_78 / var_4_77)

				if var_4_79 > 0 and var_4_72 < var_4_79 then
					arg_1_1.talkMaxDuration = var_4_79
					var_4_71 = var_4_71 + 0.3

					if var_4_79 + var_4_71 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_79 + var_4_71
					end
				end

				arg_1_1.text_.text = var_4_76
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172001", "story_v_out_417172.awb") ~= 0 then
					local var_4_80 = manager.audio:GetVoiceLength("story_v_out_417172", "417172001", "story_v_out_417172.awb") / 1000

					if var_4_80 + var_4_71 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_80 + var_4_71
					end

					if var_4_75.prefab_name ~= "" and arg_1_1.actors_[var_4_75.prefab_name] ~= nil then
						local var_4_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_75.prefab_name].transform, "story_v_out_417172", "417172001", "story_v_out_417172.awb")

						arg_1_1:RecordAudio("417172001", var_4_81)
						arg_1_1:RecordAudio("417172001", var_4_81)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417172", "417172001", "story_v_out_417172.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417172", "417172001", "story_v_out_417172.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_82 = var_4_71 + 0.3
			local var_4_83 = math.max(var_4_72, arg_1_1.talkMaxDuration)

			if var_4_82 <= arg_1_1.time_ and arg_1_1.time_ < var_4_82 + var_4_83 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_82) / var_4_83

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_82 + var_4_83 and arg_1_1.time_ < var_4_82 + var_4_83 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417172002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 417172002
		arg_9_1.duration_ = 9.7

		local var_9_0 = {
			zh = 9.7,
			ja = 8
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
				arg_9_0:Play417172003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.925

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[1117].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(417172002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172002", "story_v_out_417172.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172002", "story_v_out_417172.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_417172", "417172002", "story_v_out_417172.awb")

						arg_9_1:RecordAudio("417172002", var_12_9)
						arg_9_1:RecordAudio("417172002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_417172", "417172002", "story_v_out_417172.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_417172", "417172002", "story_v_out_417172.awb")
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
	Play417172003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 417172003
		arg_13_1.duration_ = 9.07

		local var_13_0 = {
			zh = 6.266,
			ja = 9.066
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
				arg_13_0:Play417172004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.8

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[1117].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(417172003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 32
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172003", "story_v_out_417172.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172003", "story_v_out_417172.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_417172", "417172003", "story_v_out_417172.awb")

						arg_13_1:RecordAudio("417172003", var_16_9)
						arg_13_1:RecordAudio("417172003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_417172", "417172003", "story_v_out_417172.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_417172", "417172003", "story_v_out_417172.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play417172004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 417172004
		arg_17_1.duration_ = 5.2

		local var_17_0 = {
			zh = 4,
			ja = 5.2
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
				arg_17_0:Play417172005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10128"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(var_20_1, arg_17_1.canvasGo_.transform)

					var_20_2.transform:SetSiblingIndex(1)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs(var_20_3) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_4 = arg_17_1.actors_["10128"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps10128 == nil then
				arg_17_1.var_.actorSpriteComps10128 = var_20_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.actorSpriteComps10128 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								local var_20_8 = Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, var_20_7)
								local var_20_9 = Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, var_20_7)
								local var_20_10 = Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, var_20_7)

								iter_20_3.color = Color.New(var_20_8, var_20_9, var_20_10)
							else
								local var_20_11 = Mathf.Lerp(iter_20_3.color.r, 1, var_20_7)

								iter_20_3.color = Color.New(var_20_11, var_20_11, var_20_11)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps10128 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10128 = nil
			end

			local var_20_12 = arg_17_1.actors_["10113"]
			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps10113 == nil then
				arg_17_1.var_.actorSpriteComps10113 = var_20_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_14 = 0.2

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_14 and not isNil(var_20_12) then
				local var_20_15 = (arg_17_1.time_ - var_20_13) / var_20_14

				if arg_17_1.var_.actorSpriteComps10113 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_16 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor2.r, var_20_15)
								local var_20_17 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor2.g, var_20_15)
								local var_20_18 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor2.b, var_20_15)

								iter_20_7.color = Color.New(var_20_16, var_20_17, var_20_18)
							else
								local var_20_19 = Mathf.Lerp(iter_20_7.color.r, 0.5, var_20_15)

								iter_20_7.color = Color.New(var_20_19, var_20_19, var_20_19)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_13 + var_20_14 and arg_17_1.time_ < var_20_13 + var_20_14 + arg_20_0 and not isNil(var_20_12) and arg_17_1.var_.actorSpriteComps10113 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10113 = nil
			end

			local var_20_20 = arg_17_1.actors_["10113"].transform
			local var_20_21 = 0

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.var_.moveOldPos10113 = var_20_20.localPosition
				var_20_20.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10113", 2)

				local var_20_22 = var_20_20.childCount

				for iter_20_10 = 0, var_20_22 - 1 do
					local var_20_23 = var_20_20:GetChild(iter_20_10)

					if var_20_23.name == "" or not string.find(var_20_23.name, "split") then
						var_20_23.gameObject:SetActive(true)
					else
						var_20_23.gameObject:SetActive(false)
					end
				end
			end

			local var_20_24 = 0.001

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_24 then
				local var_20_25 = (arg_17_1.time_ - var_20_21) / var_20_24
				local var_20_26 = Vector3.New(-403.26, -328.4, -517.4)

				var_20_20.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10113, var_20_26, var_20_25)
			end

			if arg_17_1.time_ >= var_20_21 + var_20_24 and arg_17_1.time_ < var_20_21 + var_20_24 + arg_20_0 then
				var_20_20.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_20_27 = arg_17_1.actors_["10128"].transform
			local var_20_28 = 0

			if var_20_28 < arg_17_1.time_ and arg_17_1.time_ <= var_20_28 + arg_20_0 then
				arg_17_1.var_.moveOldPos10128 = var_20_27.localPosition
				var_20_27.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10128", 4)

				local var_20_29 = var_20_27.childCount

				for iter_20_11 = 0, var_20_29 - 1 do
					local var_20_30 = var_20_27:GetChild(iter_20_11)

					if var_20_30.name == "" or not string.find(var_20_30.name, "split") then
						var_20_30.gameObject:SetActive(true)
					else
						var_20_30.gameObject:SetActive(false)
					end
				end
			end

			local var_20_31 = 0.001

			if var_20_28 <= arg_17_1.time_ and arg_17_1.time_ < var_20_28 + var_20_31 then
				local var_20_32 = (arg_17_1.time_ - var_20_28) / var_20_31
				local var_20_33 = Vector3.New(390, -347, -300)

				var_20_27.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10128, var_20_33, var_20_32)
			end

			if arg_17_1.time_ >= var_20_28 + var_20_31 and arg_17_1.time_ < var_20_28 + var_20_31 + arg_20_0 then
				var_20_27.localPosition = Vector3.New(390, -347, -300)
			end

			local var_20_34 = 0
			local var_20_35 = 0.475

			if var_20_34 < arg_17_1.time_ and arg_17_1.time_ <= var_20_34 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_36 = arg_17_1:FormatText(StoryNameCfg[595].name)

				arg_17_1.leftNameTxt_.text = var_20_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_37 = arg_17_1:GetWordFromCfg(417172004)
				local var_20_38 = arg_17_1:FormatText(var_20_37.content)

				arg_17_1.text_.text = var_20_38

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_39 = 19
				local var_20_40 = utf8.len(var_20_38)
				local var_20_41 = var_20_39 <= 0 and var_20_35 or var_20_35 * (var_20_40 / var_20_39)

				if var_20_41 > 0 and var_20_35 < var_20_41 then
					arg_17_1.talkMaxDuration = var_20_41

					if var_20_41 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_41 + var_20_34
					end
				end

				arg_17_1.text_.text = var_20_38
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172004", "story_v_out_417172.awb") ~= 0 then
					local var_20_42 = manager.audio:GetVoiceLength("story_v_out_417172", "417172004", "story_v_out_417172.awb") / 1000

					if var_20_42 + var_20_34 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_42 + var_20_34
					end

					if var_20_37.prefab_name ~= "" and arg_17_1.actors_[var_20_37.prefab_name] ~= nil then
						local var_20_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_37.prefab_name].transform, "story_v_out_417172", "417172004", "story_v_out_417172.awb")

						arg_17_1:RecordAudio("417172004", var_20_43)
						arg_17_1:RecordAudio("417172004", var_20_43)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_417172", "417172004", "story_v_out_417172.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_417172", "417172004", "story_v_out_417172.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_44 = math.max(var_20_35, arg_17_1.talkMaxDuration)

			if var_20_34 <= arg_17_1.time_ and arg_17_1.time_ < var_20_34 + var_20_44 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_34) / var_20_44

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_34 + var_20_44 and arg_17_1.time_ < var_20_34 + var_20_44 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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

		arg_17_1:InitPlayNodeList()
	end,
	Play417172005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 417172005
		arg_21_1.duration_ = 10.93

		local var_21_0 = {
			zh = 9.6,
			ja = 10.933
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
				arg_21_0:Play417172006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10113"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10113 == nil then
				arg_21_1.var_.actorSpriteComps10113 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10113 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10113 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10113 = nil
			end

			local var_24_8 = arg_21_1.actors_["10128"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10128 == nil then
				arg_21_1.var_.actorSpriteComps10128 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.2

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps10128 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								local var_24_12 = Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, var_24_11)
								local var_24_13 = Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, var_24_11)
								local var_24_14 = Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, var_24_11)

								iter_24_5.color = Color.New(var_24_12, var_24_13, var_24_14)
							else
								local var_24_15 = Mathf.Lerp(iter_24_5.color.r, 0.5, var_24_11)

								iter_24_5.color = Color.New(var_24_15, var_24_15, var_24_15)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps10128 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10128 = nil
			end

			local var_24_16 = 0
			local var_24_17 = 1.025

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_18 = arg_21_1:FormatText(StoryNameCfg[1117].name)

				arg_21_1.leftNameTxt_.text = var_24_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_19 = arg_21_1:GetWordFromCfg(417172005)
				local var_24_20 = arg_21_1:FormatText(var_24_19.content)

				arg_21_1.text_.text = var_24_20

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_21 = 41
				local var_24_22 = utf8.len(var_24_20)
				local var_24_23 = var_24_21 <= 0 and var_24_17 or var_24_17 * (var_24_22 / var_24_21)

				if var_24_23 > 0 and var_24_17 < var_24_23 then
					arg_21_1.talkMaxDuration = var_24_23

					if var_24_23 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_16
					end
				end

				arg_21_1.text_.text = var_24_20
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172005", "story_v_out_417172.awb") ~= 0 then
					local var_24_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172005", "story_v_out_417172.awb") / 1000

					if var_24_24 + var_24_16 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_16
					end

					if var_24_19.prefab_name ~= "" and arg_21_1.actors_[var_24_19.prefab_name] ~= nil then
						local var_24_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_19.prefab_name].transform, "story_v_out_417172", "417172005", "story_v_out_417172.awb")

						arg_21_1:RecordAudio("417172005", var_24_25)
						arg_21_1:RecordAudio("417172005", var_24_25)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_417172", "417172005", "story_v_out_417172.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_417172", "417172005", "story_v_out_417172.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_26 = math.max(var_24_17, arg_21_1.talkMaxDuration)

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_26 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_16) / var_24_26

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_16 + var_24_26 and arg_21_1.time_ < var_24_16 + var_24_26 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play417172006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 417172006
		arg_25_1.duration_ = 7.4

		local var_25_0 = {
			zh = 6.533,
			ja = 7.4
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
				arg_25_0:Play417172007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10113"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10113 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10113", 2)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_5" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(-403.26, -328.4, -517.4)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10113, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_28_7 = 0
			local var_28_8 = 0.65

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_9 = arg_25_1:FormatText(StoryNameCfg[1117].name)

				arg_25_1.leftNameTxt_.text = var_28_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(417172006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 26
				local var_28_13 = utf8.len(var_28_11)
				local var_28_14 = var_28_12 <= 0 and var_28_8 or var_28_8 * (var_28_13 / var_28_12)

				if var_28_14 > 0 and var_28_8 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172006", "story_v_out_417172.awb") ~= 0 then
					local var_28_15 = manager.audio:GetVoiceLength("story_v_out_417172", "417172006", "story_v_out_417172.awb") / 1000

					if var_28_15 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_7
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_417172", "417172006", "story_v_out_417172.awb")

						arg_25_1:RecordAudio("417172006", var_28_16)
						arg_25_1:RecordAudio("417172006", var_28_16)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_417172", "417172006", "story_v_out_417172.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_417172", "417172006", "story_v_out_417172.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_17 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_17 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_17

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_17 and arg_25_1.time_ < var_28_7 + var_28_17 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
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
	Play417172007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 417172007
		arg_29_1.duration_ = 4.93

		local var_29_0 = {
			zh = 4.933,
			ja = 4.2
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
				arg_29_0:Play417172008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10128"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10128 == nil then
				arg_29_1.var_.actorSpriteComps10128 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10128 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10128 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10128 = nil
			end

			local var_32_8 = arg_29_1.actors_["10113"]
			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10113 == nil then
				arg_29_1.var_.actorSpriteComps10113 = var_32_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_10 = 0.2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 and not isNil(var_32_8) then
				local var_32_11 = (arg_29_1.time_ - var_32_9) / var_32_10

				if arg_29_1.var_.actorSpriteComps10113 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								local var_32_12 = Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, var_32_11)
								local var_32_13 = Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, var_32_11)
								local var_32_14 = Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, var_32_11)

								iter_32_5.color = Color.New(var_32_12, var_32_13, var_32_14)
							else
								local var_32_15 = Mathf.Lerp(iter_32_5.color.r, 0.5, var_32_11)

								iter_32_5.color = Color.New(var_32_15, var_32_15, var_32_15)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 and not isNil(var_32_8) and arg_29_1.var_.actorSpriteComps10113 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_32_7 then
						if arg_29_1.isInRecall_ then
							iter_32_7.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10113 = nil
			end

			local var_32_16 = 0
			local var_32_17 = 0.45

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_18 = arg_29_1:FormatText(StoryNameCfg[595].name)

				arg_29_1.leftNameTxt_.text = var_32_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_19 = arg_29_1:GetWordFromCfg(417172007)
				local var_32_20 = arg_29_1:FormatText(var_32_19.content)

				arg_29_1.text_.text = var_32_20

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 18
				local var_32_22 = utf8.len(var_32_20)
				local var_32_23 = var_32_21 <= 0 and var_32_17 or var_32_17 * (var_32_22 / var_32_21)

				if var_32_23 > 0 and var_32_17 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23

					if var_32_23 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_16
					end
				end

				arg_29_1.text_.text = var_32_20
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172007", "story_v_out_417172.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172007", "story_v_out_417172.awb") / 1000

					if var_32_24 + var_32_16 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_16
					end

					if var_32_19.prefab_name ~= "" and arg_29_1.actors_[var_32_19.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_19.prefab_name].transform, "story_v_out_417172", "417172007", "story_v_out_417172.awb")

						arg_29_1:RecordAudio("417172007", var_32_25)
						arg_29_1:RecordAudio("417172007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_417172", "417172007", "story_v_out_417172.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_417172", "417172007", "story_v_out_417172.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = math.max(var_32_17, arg_29_1.talkMaxDuration)

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_26 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_16) / var_32_26

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_16 + var_32_26 and arg_29_1.time_ < var_32_16 + var_32_26 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play417172008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 417172008
		arg_33_1.duration_ = 8.03

		local var_33_0 = {
			zh = 5.733,
			ja = 8.033
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
				arg_33_0:Play417172009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10113"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10113 == nil then
				arg_33_1.var_.actorSpriteComps10113 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10113 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10113 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10113 = nil
			end

			local var_36_8 = arg_33_1.actors_["10128"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10128 == nil then
				arg_33_1.var_.actorSpriteComps10128 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.2

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps10128 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								local var_36_12 = Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, var_36_11)
								local var_36_13 = Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, var_36_11)
								local var_36_14 = Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, var_36_11)

								iter_36_5.color = Color.New(var_36_12, var_36_13, var_36_14)
							else
								local var_36_15 = Mathf.Lerp(iter_36_5.color.r, 0.5, var_36_11)

								iter_36_5.color = Color.New(var_36_15, var_36_15, var_36_15)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps10128 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10128 = nil
			end

			local var_36_16 = 0
			local var_36_17 = 0.6

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_18 = arg_33_1:FormatText(StoryNameCfg[1117].name)

				arg_33_1.leftNameTxt_.text = var_36_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_19 = arg_33_1:GetWordFromCfg(417172008)
				local var_36_20 = arg_33_1:FormatText(var_36_19.content)

				arg_33_1.text_.text = var_36_20

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_21 = 24
				local var_36_22 = utf8.len(var_36_20)
				local var_36_23 = var_36_21 <= 0 and var_36_17 or var_36_17 * (var_36_22 / var_36_21)

				if var_36_23 > 0 and var_36_17 < var_36_23 then
					arg_33_1.talkMaxDuration = var_36_23

					if var_36_23 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_16
					end
				end

				arg_33_1.text_.text = var_36_20
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172008", "story_v_out_417172.awb") ~= 0 then
					local var_36_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172008", "story_v_out_417172.awb") / 1000

					if var_36_24 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_16
					end

					if var_36_19.prefab_name ~= "" and arg_33_1.actors_[var_36_19.prefab_name] ~= nil then
						local var_36_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_19.prefab_name].transform, "story_v_out_417172", "417172008", "story_v_out_417172.awb")

						arg_33_1:RecordAudio("417172008", var_36_25)
						arg_33_1:RecordAudio("417172008", var_36_25)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_417172", "417172008", "story_v_out_417172.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_417172", "417172008", "story_v_out_417172.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_26 = math.max(var_36_17, arg_33_1.talkMaxDuration)

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_26 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_16) / var_36_26

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_16 + var_36_26 and arg_33_1.time_ < var_36_16 + var_36_26 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play417172009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 417172009
		arg_37_1.duration_ = 4.3

		local var_37_0 = {
			zh = 3.433,
			ja = 4.3
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
				arg_37_0:Play417172010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.35

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1117].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(417172009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172009", "story_v_out_417172.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172009", "story_v_out_417172.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_417172", "417172009", "story_v_out_417172.awb")

						arg_37_1:RecordAudio("417172009", var_40_9)
						arg_37_1:RecordAudio("417172009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_417172", "417172009", "story_v_out_417172.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_417172", "417172009", "story_v_out_417172.awb")
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
	Play417172010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 417172010
		arg_41_1.duration_ = 1.5

		local var_41_0 = {
			zh = 1.466,
			ja = 1.5
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
				arg_41_0:Play417172011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10128"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10128 == nil then
				arg_41_1.var_.actorSpriteComps10128 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10128 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10128 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10128 = nil
			end

			local var_44_8 = arg_41_1.actors_["10113"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10113 == nil then
				arg_41_1.var_.actorSpriteComps10113 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10113 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 0.5, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10113 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10113 = nil
			end

			local var_44_16 = arg_41_1.actors_["10113"].transform
			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.var_.moveOldPos10113 = var_44_16.localPosition
				var_44_16.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10113", 7)

				local var_44_18 = var_44_16.childCount

				for iter_44_8 = 0, var_44_18 - 1 do
					local var_44_19 = var_44_16:GetChild(iter_44_8)

					if var_44_19.name == "" or not string.find(var_44_19.name, "split") then
						var_44_19.gameObject:SetActive(true)
					else
						var_44_19.gameObject:SetActive(false)
					end
				end
			end

			local var_44_20 = 0.001

			if var_44_17 <= arg_41_1.time_ and arg_41_1.time_ < var_44_17 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_17) / var_44_20
				local var_44_22 = Vector3.New(0, -2000, 0)

				var_44_16.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10113, var_44_22, var_44_21)
			end

			if arg_41_1.time_ >= var_44_17 + var_44_20 and arg_41_1.time_ < var_44_17 + var_44_20 + arg_44_0 then
				var_44_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_23 = arg_41_1.actors_["10128"].transform
			local var_44_24 = 0

			if var_44_24 < arg_41_1.time_ and arg_41_1.time_ <= var_44_24 + arg_44_0 then
				arg_41_1.var_.moveOldPos10128 = var_44_23.localPosition
				var_44_23.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10128", 3)

				local var_44_25 = var_44_23.childCount

				for iter_44_9 = 0, var_44_25 - 1 do
					local var_44_26 = var_44_23:GetChild(iter_44_9)

					if var_44_26.name == "" or not string.find(var_44_26.name, "split") then
						var_44_26.gameObject:SetActive(true)
					else
						var_44_26.gameObject:SetActive(false)
					end
				end
			end

			local var_44_27 = 0.001

			if var_44_24 <= arg_41_1.time_ and arg_41_1.time_ < var_44_24 + var_44_27 then
				local var_44_28 = (arg_41_1.time_ - var_44_24) / var_44_27
				local var_44_29 = Vector3.New(0, -347, -300)

				var_44_23.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10128, var_44_29, var_44_28)
			end

			if arg_41_1.time_ >= var_44_24 + var_44_27 and arg_41_1.time_ < var_44_24 + var_44_27 + arg_44_0 then
				var_44_23.localPosition = Vector3.New(0, -347, -300)
			end

			local var_44_30 = 0
			local var_44_31 = 0.1

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[595].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(417172010)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172010", "story_v_out_417172.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_417172", "417172010", "story_v_out_417172.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_417172", "417172010", "story_v_out_417172.awb")

						arg_41_1:RecordAudio("417172010", var_44_39)
						arg_41_1:RecordAudio("417172010", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_417172", "417172010", "story_v_out_417172.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_417172", "417172010", "story_v_out_417172.awb")
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
				actorName = "10113",
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

		arg_41_1:InitPlayNodeList()
	end,
	Play417172011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 417172011
		arg_45_1.duration_ = 6.93

		local var_45_0 = {
			zh = 4.433,
			ja = 6.933
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
				arg_45_0:Play417172012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10128"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10128 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10128", 3)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "split_6" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(0, -347, -300)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10128, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -347, -300)
			end

			local var_48_7 = 0
			local var_48_8 = 0.4

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_9 = arg_45_1:FormatText(StoryNameCfg[595].name)

				arg_45_1.leftNameTxt_.text = var_48_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(417172011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 16
				local var_48_13 = utf8.len(var_48_11)
				local var_48_14 = var_48_12 <= 0 and var_48_8 or var_48_8 * (var_48_13 / var_48_12)

				if var_48_14 > 0 and var_48_8 < var_48_14 then
					arg_45_1.talkMaxDuration = var_48_14

					if var_48_14 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_7
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172011", "story_v_out_417172.awb") ~= 0 then
					local var_48_15 = manager.audio:GetVoiceLength("story_v_out_417172", "417172011", "story_v_out_417172.awb") / 1000

					if var_48_15 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_7
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_417172", "417172011", "story_v_out_417172.awb")

						arg_45_1:RecordAudio("417172011", var_48_16)
						arg_45_1:RecordAudio("417172011", var_48_16)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_417172", "417172011", "story_v_out_417172.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_417172", "417172011", "story_v_out_417172.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_17 = math.max(var_48_8, arg_45_1.talkMaxDuration)

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_17 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_7) / var_48_17

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_7 + var_48_17 and arg_45_1.time_ < var_48_7 + var_48_17 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play417172012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 417172012
		arg_49_1.duration_ = 11.07

		local var_49_0 = {
			zh = 10.2,
			ja = 11.066
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
				arg_49_0:Play417172013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 7.4

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_1 = 0.3

			if arg_49_1.time_ >= var_52_0 + var_52_1 and arg_49_1.time_ < var_52_0 + var_52_1 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_2 = 0
			local var_52_3 = 5
			local var_52_4 = "I17j"

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.timestampController_:SetSelectedState("show")
				arg_49_1.timestampAni_:Play("in")

				arg_49_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_4)

				arg_49_1.timestampColorController_:SetSelectedState("cold")
				arg_49_1.timeColdImg_:SetAlpha(0.031)

				local var_52_5 = arg_49_1:GetWordFromCfg(501055)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_timeText_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_timeText_)

				local var_52_7 = arg_49_1:GetWordFromCfg(501056)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_siteText_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_siteText_)
			end

			if arg_49_1.time_ >= var_52_2 + var_52_3 and arg_49_1.time_ < var_52_2 + var_52_3 + arg_52_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_49_1.timestampAni_, "out", function()
					arg_49_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_52_9 = 5

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = false

				arg_49_1:SetGaussion(false)
			end

			local var_52_10 = 1.2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10
				local var_52_12 = Color.New(0, 0, 0)

				var_52_12.a = Mathf.Lerp(0, 1, var_52_11)
				arg_49_1.mask_.color = var_52_12
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 then
				local var_52_13 = Color.New(0, 0, 0)

				var_52_13.a = 1
				arg_49_1.mask_.color = var_52_13
			end

			local var_52_14 = 6.2

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = false

				arg_49_1:SetGaussion(false)
			end

			local var_52_15 = 1.2

			if var_52_14 <= arg_49_1.time_ and arg_49_1.time_ < var_52_14 + var_52_15 then
				local var_52_16 = (arg_49_1.time_ - var_52_14) / var_52_15
				local var_52_17 = Color.New(0, 0, 0)

				var_52_17.a = Mathf.Lerp(1, 0, var_52_16)
				arg_49_1.mask_.color = var_52_17
			end

			if arg_49_1.time_ >= var_52_14 + var_52_15 and arg_49_1.time_ < var_52_14 + var_52_15 + arg_52_0 then
				local var_52_18 = Color.New(0, 0, 0)
				local var_52_19 = 0

				arg_49_1.mask_.enabled = false
				var_52_18.a = var_52_19
				arg_49_1.mask_.color = var_52_18
			end

			local var_52_20 = "I17j"

			if arg_49_1.bgs_[var_52_20] == nil then
				local var_52_21 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_20)
				var_52_21.name = var_52_20
				var_52_21.transform.parent = arg_49_1.stage_.transform
				var_52_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_20] = var_52_21
			end

			local var_52_22 = 0

			if var_52_22 < arg_49_1.time_ and arg_49_1.time_ <= var_52_22 + arg_52_0 then
				local var_52_23 = manager.ui.mainCamera.transform.localPosition
				local var_52_24 = Vector3.New(0, 0, 10) + Vector3.New(var_52_23.x, var_52_23.y, 0)
				local var_52_25 = arg_49_1.bgs_.I17j

				var_52_25.transform.localPosition = var_52_24
				var_52_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_26 = var_52_25:GetComponent("SpriteRenderer")

				if var_52_26 and var_52_26.sprite then
					local var_52_27 = (var_52_25.transform.localPosition - var_52_23).z
					local var_52_28 = manager.ui.mainCameraCom_
					local var_52_29 = 2 * var_52_27 * Mathf.Tan(var_52_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_30 = var_52_29 * var_52_28.aspect
					local var_52_31 = var_52_26.sprite.bounds.size.x
					local var_52_32 = var_52_26.sprite.bounds.size.y
					local var_52_33 = var_52_30 / var_52_31
					local var_52_34 = var_52_29 / var_52_32
					local var_52_35 = var_52_34 < var_52_33 and var_52_33 or var_52_34

					var_52_25.transform.localScale = Vector3.New(var_52_35, var_52_35, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "I17j" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_36 = arg_49_1.actors_["10128"].transform
			local var_52_37 = 0.0326666666666666

			if var_52_37 < arg_49_1.time_ and arg_49_1.time_ <= var_52_37 + arg_52_0 then
				arg_49_1.var_.moveOldPos10128 = var_52_36.localPosition
				var_52_36.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10128", 7)

				local var_52_38 = var_52_36.childCount

				for iter_52_2 = 0, var_52_38 - 1 do
					local var_52_39 = var_52_36:GetChild(iter_52_2)

					if var_52_39.name == "" or not string.find(var_52_39.name, "split") then
						var_52_39.gameObject:SetActive(true)
					else
						var_52_39.gameObject:SetActive(false)
					end
				end
			end

			local var_52_40 = 0.001

			if var_52_37 <= arg_49_1.time_ and arg_49_1.time_ < var_52_37 + var_52_40 then
				local var_52_41 = (arg_49_1.time_ - var_52_37) / var_52_40
				local var_52_42 = Vector3.New(0, -2000, -300)

				var_52_36.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10128, var_52_42, var_52_41)
			end

			if arg_49_1.time_ >= var_52_37 + var_52_40 and arg_49_1.time_ < var_52_37 + var_52_40 + arg_52_0 then
				var_52_36.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_52_43 = 0

			arg_49_1.isInRecall_ = false

			if var_52_43 < arg_49_1.time_ and arg_49_1.time_ <= var_52_43 + arg_52_0 then
				arg_49_1.screenFilterGo_:SetActive(false)

				for iter_52_3, iter_52_4 in pairs(arg_49_1.actors_) do
					local var_52_44 = iter_52_4:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_52_5, iter_52_6 in ipairs(var_52_44) do
						if iter_52_6.color.r > 0.51 then
							iter_52_6.color = Color.New(1, 1, 1)
						else
							iter_52_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_52_45 = 0.0666666666666667

			if var_52_43 <= arg_49_1.time_ and arg_49_1.time_ < var_52_43 + var_52_45 then
				local var_52_46 = (arg_49_1.time_ - var_52_43) / var_52_45

				arg_49_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_52_46)
			end

			if arg_49_1.time_ >= var_52_43 + var_52_45 and arg_49_1.time_ < var_52_43 + var_52_45 + arg_52_0 then
				arg_49_1.screenFilterEffect_.weight = 0
			end

			local var_52_47 = 0

			if var_52_47 < arg_49_1.time_ and arg_49_1.time_ <= var_52_47 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = false

				arg_49_1:SetGaussion(false)
			end

			local var_52_48 = 1

			if var_52_47 <= arg_49_1.time_ and arg_49_1.time_ < var_52_47 + var_52_48 then
				local var_52_49 = (arg_49_1.time_ - var_52_47) / var_52_48
				local var_52_50 = Color.New(0, 0, 0)

				var_52_50.a = Mathf.Lerp(1, 0, var_52_49)
				arg_49_1.mask_.color = var_52_50
			end

			if arg_49_1.time_ >= var_52_47 + var_52_48 and arg_49_1.time_ < var_52_47 + var_52_48 + arg_52_0 then
				local var_52_51 = Color.New(0, 0, 0)
				local var_52_52 = 0

				arg_49_1.mask_.enabled = false
				var_52_51.a = var_52_52
				arg_49_1.mask_.color = var_52_51
			end

			local var_52_53 = 0
			local var_52_54 = 0.2

			if var_52_53 < arg_49_1.time_ and arg_49_1.time_ <= var_52_53 + arg_52_0 then
				local var_52_55 = "play"
				local var_52_56 = "music"

				arg_49_1:AudioAction(var_52_55, var_52_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_52_57 = ""
				local var_52_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_52_58 ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_58 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_58

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_58
						arg_49_1.bgmTxt2_.text = var_52_58
					end

					if arg_49_1.bgmTimer then
						arg_49_1.bgmTimer:Stop()

						arg_49_1.bgmTimer = nil
					end

					if arg_49_1.settingData.show_music_name == 1 then
						arg_49_1.musicController:SetSelectedState("show")
						arg_49_1.musicAnimator_:Play("open", 0, 0)

						if arg_49_1.settingData.music_time ~= 0 then
							arg_49_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_49_1.settingData.music_time), function()
								if arg_49_1 == nil or isNil(arg_49_1.bgmTxt_) then
									return
								end

								arg_49_1.musicController:SetSelectedState("hide")
								arg_49_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_52_59 = 5.76666666666667
			local var_52_60 = 1

			if var_52_59 < arg_49_1.time_ and arg_49_1.time_ <= var_52_59 + arg_52_0 then
				local var_52_61 = "play"
				local var_52_62 = "music"

				arg_49_1:AudioAction(var_52_61, var_52_62, "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain.awb")

				local var_52_63 = ""
				local var_52_64 = manager.audio:GetAudioName("bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain")

				if var_52_64 ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_64 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_64

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_64
						arg_49_1.bgmTxt2_.text = var_52_64
					end

					if arg_49_1.bgmTimer then
						arg_49_1.bgmTimer:Stop()

						arg_49_1.bgmTimer = nil
					end

					if arg_49_1.settingData.show_music_name == 1 then
						arg_49_1.musicController:SetSelectedState("show")
						arg_49_1.musicAnimator_:Play("open", 0, 0)

						if arg_49_1.settingData.music_time ~= 0 then
							arg_49_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_49_1.settingData.music_time), function()
								if arg_49_1 == nil or isNil(arg_49_1.bgmTxt_) then
									return
								end

								arg_49_1.musicController:SetSelectedState("hide")
								arg_49_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_65 = 7.4
			local var_52_66 = 0.375

			if var_52_65 < arg_49_1.time_ and arg_49_1.time_ <= var_52_65 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_67 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_67:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_49_1.dialogCg_.alpha = arg_56_0
				end))
				var_52_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_68 = arg_49_1:FormatText(StoryNameCfg[1129].name)

				arg_49_1.leftNameTxt_.text = var_52_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_69 = arg_49_1:GetWordFromCfg(417172012)
				local var_52_70 = arg_49_1:FormatText(var_52_69.content)

				arg_49_1.text_.text = var_52_70

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_71 = 15
				local var_52_72 = utf8.len(var_52_70)
				local var_52_73 = var_52_71 <= 0 and var_52_66 or var_52_66 * (var_52_72 / var_52_71)

				if var_52_73 > 0 and var_52_66 < var_52_73 then
					arg_49_1.talkMaxDuration = var_52_73
					var_52_65 = var_52_65 + 0.3

					if var_52_73 + var_52_65 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_73 + var_52_65
					end
				end

				arg_49_1.text_.text = var_52_70
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172012", "story_v_out_417172.awb") ~= 0 then
					local var_52_74 = manager.audio:GetVoiceLength("story_v_out_417172", "417172012", "story_v_out_417172.awb") / 1000

					if var_52_74 + var_52_65 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_74 + var_52_65
					end

					if var_52_69.prefab_name ~= "" and arg_49_1.actors_[var_52_69.prefab_name] ~= nil then
						local var_52_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_69.prefab_name].transform, "story_v_out_417172", "417172012", "story_v_out_417172.awb")

						arg_49_1:RecordAudio("417172012", var_52_75)
						arg_49_1:RecordAudio("417172012", var_52_75)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_417172", "417172012", "story_v_out_417172.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_417172", "417172012", "story_v_out_417172.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_76 = var_52_65 + 0.3
			local var_52_77 = math.max(var_52_66, arg_49_1.talkMaxDuration)

			if var_52_76 <= arg_49_1.time_ and arg_49_1.time_ < var_52_76 + var_52_77 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_76) / var_52_77

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_76 + var_52_77 and arg_49_1.time_ < var_52_76 + var_52_77 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0326666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play417172013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417172013
		arg_58_1.duration_ = 4.43

		local var_58_0 = {
			zh = 3.433,
			ja = 4.433
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play417172014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "2078"

			if arg_58_1.actors_[var_61_0] == nil then
				local var_61_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "2078")

				if not isNil(var_61_1) then
					local var_61_2 = Object.Instantiate(var_61_1, arg_58_1.canvasGo_.transform)

					var_61_2.transform:SetSiblingIndex(1)

					var_61_2.name = var_61_0
					var_61_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_58_1.actors_[var_61_0] = var_61_2

					local var_61_3 = var_61_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_58_1.isInRecall_ then
						for iter_61_0, iter_61_1 in ipairs(var_61_3) do
							iter_61_1.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_61_4 = arg_58_1.actors_["2078"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.actorSpriteComps2078 == nil then
				arg_58_1.var_.actorSpriteComps2078 = var_61_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_6 = 0.2

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.actorSpriteComps2078 then
					for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_61_3 then
							if arg_58_1.isInRecall_ then
								local var_61_8 = Mathf.Lerp(iter_61_3.color.r, arg_58_1.hightColor2.r, var_61_7)
								local var_61_9 = Mathf.Lerp(iter_61_3.color.g, arg_58_1.hightColor2.g, var_61_7)
								local var_61_10 = Mathf.Lerp(iter_61_3.color.b, arg_58_1.hightColor2.b, var_61_7)

								iter_61_3.color = Color.New(var_61_8, var_61_9, var_61_10)
							else
								local var_61_11 = Mathf.Lerp(iter_61_3.color.r, 0.5, var_61_7)

								iter_61_3.color = Color.New(var_61_11, var_61_11, var_61_11)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.actorSpriteComps2078 then
				for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_61_5 then
						if arg_58_1.isInRecall_ then
							iter_61_5.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps2078 = nil
			end

			local var_61_12 = 0
			local var_61_13 = 0.475

			if var_61_12 < arg_58_1.time_ and arg_58_1.time_ <= var_61_12 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_14 = arg_58_1:FormatText(StoryNameCfg[1143].name)

				arg_58_1.leftNameTxt_.text = var_61_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_58_1.callingController_:SetSelectedState("calling")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_15 = arg_58_1:GetWordFromCfg(417172013)
				local var_61_16 = arg_58_1:FormatText(var_61_15.content)

				arg_58_1.text_.text = var_61_16

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_17 = 19
				local var_61_18 = utf8.len(var_61_16)
				local var_61_19 = var_61_17 <= 0 and var_61_13 or var_61_13 * (var_61_18 / var_61_17)

				if var_61_19 > 0 and var_61_13 < var_61_19 then
					arg_58_1.talkMaxDuration = var_61_19

					if var_61_19 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_19 + var_61_12
					end
				end

				arg_58_1.text_.text = var_61_16
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172013", "story_v_out_417172.awb") ~= 0 then
					local var_61_20 = manager.audio:GetVoiceLength("story_v_out_417172", "417172013", "story_v_out_417172.awb") / 1000

					if var_61_20 + var_61_12 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_20 + var_61_12
					end

					if var_61_15.prefab_name ~= "" and arg_58_1.actors_[var_61_15.prefab_name] ~= nil then
						local var_61_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_15.prefab_name].transform, "story_v_out_417172", "417172013", "story_v_out_417172.awb")

						arg_58_1:RecordAudio("417172013", var_61_21)
						arg_58_1:RecordAudio("417172013", var_61_21)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417172", "417172013", "story_v_out_417172.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417172", "417172013", "story_v_out_417172.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_22 = math.max(var_61_13, arg_58_1.talkMaxDuration)

			if var_61_12 <= arg_58_1.time_ and arg_58_1.time_ < var_61_12 + var_61_22 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_12) / var_61_22

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_12 + var_61_22 and arg_58_1.time_ < var_61_12 + var_61_22 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417172014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417172014
		arg_62_1.duration_ = 2.1

		local var_62_0 = {
			zh = 1.6,
			ja = 2.1
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play417172015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["2078"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps2078 == nil then
				arg_62_1.var_.actorSpriteComps2078 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps2078 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps2078:ToTable()) do
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

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps2078 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps2078 = nil
			end

			local var_65_8 = 0
			local var_65_9 = 0.2

			if var_65_8 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_10 = arg_62_1:FormatText(StoryNameCfg[1129].name)

				arg_62_1.leftNameTxt_.text = var_65_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_11 = arg_62_1:GetWordFromCfg(417172014)
				local var_65_12 = arg_62_1:FormatText(var_65_11.content)

				arg_62_1.text_.text = var_65_12

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 8
				local var_65_14 = utf8.len(var_65_12)
				local var_65_15 = var_65_13 <= 0 and var_65_9 or var_65_9 * (var_65_14 / var_65_13)

				if var_65_15 > 0 and var_65_9 < var_65_15 then
					arg_62_1.talkMaxDuration = var_65_15

					if var_65_15 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_15 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_12
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172014", "story_v_out_417172.awb") ~= 0 then
					local var_65_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172014", "story_v_out_417172.awb") / 1000

					if var_65_16 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_16 + var_65_8
					end

					if var_65_11.prefab_name ~= "" and arg_62_1.actors_[var_65_11.prefab_name] ~= nil then
						local var_65_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_11.prefab_name].transform, "story_v_out_417172", "417172014", "story_v_out_417172.awb")

						arg_62_1:RecordAudio("417172014", var_65_17)
						arg_62_1:RecordAudio("417172014", var_65_17)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417172", "417172014", "story_v_out_417172.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417172", "417172014", "story_v_out_417172.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_18 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_18 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_18

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_18 and arg_62_1.time_ < var_65_8 + var_65_18 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417172015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417172015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play417172016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["2078"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps2078 == nil then
				arg_66_1.var_.actorSpriteComps2078 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps2078 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps2078:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								local var_69_4 = Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor2.r, var_69_3)
								local var_69_5 = Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor2.g, var_69_3)
								local var_69_6 = Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor2.b, var_69_3)

								iter_69_1.color = Color.New(var_69_4, var_69_5, var_69_6)
							else
								local var_69_7 = Mathf.Lerp(iter_69_1.color.r, 0.5, var_69_3)

								iter_69_1.color = Color.New(var_69_7, var_69_7, var_69_7)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps2078 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps2078:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps2078 = nil
			end

			local var_69_8 = 0
			local var_69_9 = 0.925

			if var_69_8 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_10 = arg_66_1:GetWordFromCfg(417172015)
				local var_69_11 = arg_66_1:FormatText(var_69_10.content)

				arg_66_1.text_.text = var_69_11

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_12 = 37
				local var_69_13 = utf8.len(var_69_11)
				local var_69_14 = var_69_12 <= 0 and var_69_9 or var_69_9 * (var_69_13 / var_69_12)

				if var_69_14 > 0 and var_69_9 < var_69_14 then
					arg_66_1.talkMaxDuration = var_69_14

					if var_69_14 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_8
					end
				end

				arg_66_1.text_.text = var_69_11
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_15 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_15 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_15

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_15 and arg_66_1.time_ < var_69_8 + var_69_15 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417172016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417172016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play417172017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.275

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_2 = arg_70_1:GetWordFromCfg(417172016)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 51
				local var_73_5 = utf8.len(var_73_3)
				local var_73_6 = var_73_4 <= 0 and var_73_1 or var_73_1 * (var_73_5 / var_73_4)

				if var_73_6 > 0 and var_73_1 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_7 and arg_70_1.time_ < var_73_0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417172017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417172017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417172018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.45

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(417172017)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 58
				local var_77_5 = utf8.len(var_77_3)
				local var_77_6 = var_77_4 <= 0 and var_77_1 or var_77_1 * (var_77_5 / var_77_4)

				if var_77_6 > 0 and var_77_1 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_7 and arg_74_1.time_ < var_77_0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417172018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417172018
		arg_78_1.duration_ = 6.9

		local var_78_0 = {
			zh = 6.133,
			ja = 6.9
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417172019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10128"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10128 == nil then
				arg_78_1.var_.actorSpriteComps10128 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps10128 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10128 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10128 = nil
			end

			local var_81_8 = arg_78_1.actors_["10128"].transform
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.var_.moveOldPos10128 = var_81_8.localPosition
				var_81_8.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10128", 3)

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
				local var_81_14 = Vector3.New(0, -347, -300)

				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10128, var_81_14, var_81_13)
			end

			if arg_78_1.time_ >= var_81_9 + var_81_12 and arg_78_1.time_ < var_81_9 + var_81_12 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_81_15 = 0
			local var_81_16 = 0.8

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_17 = arg_78_1:FormatText(StoryNameCfg[595].name)

				arg_78_1.leftNameTxt_.text = var_81_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(417172018)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 32
				local var_81_21 = utf8.len(var_81_19)
				local var_81_22 = var_81_20 <= 0 and var_81_16 or var_81_16 * (var_81_21 / var_81_20)

				if var_81_22 > 0 and var_81_16 < var_81_22 then
					arg_78_1.talkMaxDuration = var_81_22

					if var_81_22 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_22 + var_81_15
					end
				end

				arg_78_1.text_.text = var_81_19
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172018", "story_v_out_417172.awb") ~= 0 then
					local var_81_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172018", "story_v_out_417172.awb") / 1000

					if var_81_23 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_15
					end

					if var_81_18.prefab_name ~= "" and arg_78_1.actors_[var_81_18.prefab_name] ~= nil then
						local var_81_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_18.prefab_name].transform, "story_v_out_417172", "417172018", "story_v_out_417172.awb")

						arg_78_1:RecordAudio("417172018", var_81_24)
						arg_78_1:RecordAudio("417172018", var_81_24)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417172", "417172018", "story_v_out_417172.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417172", "417172018", "story_v_out_417172.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_25 = math.max(var_81_16, arg_78_1.talkMaxDuration)

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_25 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_15) / var_81_25

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_15 + var_81_25 and arg_78_1.time_ < var_81_15 + var_81_25 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play417172019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417172019
		arg_82_1.duration_ = 4.43

		local var_82_0 = {
			zh = 2.9,
			ja = 4.433
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417172020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.35

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[595].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(417172019)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 14
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172019", "story_v_out_417172.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172019", "story_v_out_417172.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_417172", "417172019", "story_v_out_417172.awb")

						arg_82_1:RecordAudio("417172019", var_85_9)
						arg_82_1:RecordAudio("417172019", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417172", "417172019", "story_v_out_417172.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417172", "417172019", "story_v_out_417172.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417172020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417172020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417172021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10128"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10128 == nil then
				arg_86_1.var_.actorSpriteComps10128 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps10128 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 0.5, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10128 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps10128 = nil
			end

			local var_89_8 = arg_86_1.actors_["10128"].transform
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.var_.moveOldPos10128 = var_89_8.localPosition
				var_89_8.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10128", 7)

				local var_89_10 = var_89_8.childCount

				for iter_89_4 = 0, var_89_10 - 1 do
					local var_89_11 = var_89_8:GetChild(iter_89_4)

					if var_89_11.name == "" or not string.find(var_89_11.name, "split") then
						var_89_11.gameObject:SetActive(true)
					else
						var_89_11.gameObject:SetActive(false)
					end
				end
			end

			local var_89_12 = 0.001

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_9) / var_89_12
				local var_89_14 = Vector3.New(0, -2000, -300)

				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10128, var_89_14, var_89_13)
			end

			if arg_86_1.time_ >= var_89_9 + var_89_12 and arg_86_1.time_ < var_89_9 + var_89_12 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_89_15 = 0
			local var_89_16 = 1.2

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_17 = arg_86_1:GetWordFromCfg(417172020)
				local var_89_18 = arg_86_1:FormatText(var_89_17.content)

				arg_86_1.text_.text = var_89_18

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_19 = 48
				local var_89_20 = utf8.len(var_89_18)
				local var_89_21 = var_89_19 <= 0 and var_89_16 or var_89_16 * (var_89_20 / var_89_19)

				if var_89_21 > 0 and var_89_16 < var_89_21 then
					arg_86_1.talkMaxDuration = var_89_21

					if var_89_21 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_21 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_18
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_22 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_22

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_22 and arg_86_1.time_ < var_89_15 + var_89_22 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play417172021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417172021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play417172022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1.15

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(417172021)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 46
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417172022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417172022
		arg_94_1.duration_ = 9

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play417172023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 4

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			local var_97_1 = 0.3

			if arg_94_1.time_ >= var_97_0 + var_97_1 and arg_94_1.time_ < var_97_0 + var_97_1 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			local var_97_2 = "ST2104a"

			if arg_94_1.bgs_[var_97_2] == nil then
				local var_97_3 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_97_2)
				var_97_3.name = var_97_2
				var_97_3.transform.parent = arg_94_1.stage_.transform
				var_97_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_[var_97_2] = var_97_3
			end

			local var_97_4 = 2

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				local var_97_5 = manager.ui.mainCamera.transform.localPosition
				local var_97_6 = Vector3.New(0, 0, 10) + Vector3.New(var_97_5.x, var_97_5.y, 0)
				local var_97_7 = arg_94_1.bgs_.ST2104a

				var_97_7.transform.localPosition = var_97_6
				var_97_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_8 = var_97_7:GetComponent("SpriteRenderer")

				if var_97_8 and var_97_8.sprite then
					local var_97_9 = (var_97_7.transform.localPosition - var_97_5).z
					local var_97_10 = manager.ui.mainCameraCom_
					local var_97_11 = 2 * var_97_9 * Mathf.Tan(var_97_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_97_12 = var_97_11 * var_97_10.aspect
					local var_97_13 = var_97_8.sprite.bounds.size.x
					local var_97_14 = var_97_8.sprite.bounds.size.y
					local var_97_15 = var_97_12 / var_97_13
					local var_97_16 = var_97_11 / var_97_14
					local var_97_17 = var_97_16 < var_97_15 and var_97_15 or var_97_16

					var_97_7.transform.localScale = Vector3.New(var_97_17, var_97_17, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "ST2104a" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_18 = 0

			if var_97_18 < arg_94_1.time_ and arg_94_1.time_ <= var_97_18 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_19 = 2

			if var_97_18 <= arg_94_1.time_ and arg_94_1.time_ < var_97_18 + var_97_19 then
				local var_97_20 = (arg_94_1.time_ - var_97_18) / var_97_19
				local var_97_21 = Color.New(0, 0, 0)

				var_97_21.a = Mathf.Lerp(0, 1, var_97_20)
				arg_94_1.mask_.color = var_97_21
			end

			if arg_94_1.time_ >= var_97_18 + var_97_19 and arg_94_1.time_ < var_97_18 + var_97_19 + arg_97_0 then
				local var_97_22 = Color.New(0, 0, 0)

				var_97_22.a = 1
				arg_94_1.mask_.color = var_97_22
			end

			local var_97_23 = 2

			if var_97_23 < arg_94_1.time_ and arg_94_1.time_ <= var_97_23 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_24 = 2

			if var_97_23 <= arg_94_1.time_ and arg_94_1.time_ < var_97_23 + var_97_24 then
				local var_97_25 = (arg_94_1.time_ - var_97_23) / var_97_24
				local var_97_26 = Color.New(0, 0, 0)

				var_97_26.a = Mathf.Lerp(1, 0, var_97_25)
				arg_94_1.mask_.color = var_97_26
			end

			if arg_94_1.time_ >= var_97_23 + var_97_24 and arg_94_1.time_ < var_97_23 + var_97_24 + arg_97_0 then
				local var_97_27 = Color.New(0, 0, 0)
				local var_97_28 = 0

				arg_94_1.mask_.enabled = false
				var_97_27.a = var_97_28
				arg_94_1.mask_.color = var_97_27
			end

			local var_97_29 = arg_94_1.actors_["10128"].transform
			local var_97_30 = 1.966

			if var_97_30 < arg_94_1.time_ and arg_94_1.time_ <= var_97_30 + arg_97_0 then
				arg_94_1.var_.moveOldPos10128 = var_97_29.localPosition
				var_97_29.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("10128", 7)

				local var_97_31 = var_97_29.childCount

				for iter_97_2 = 0, var_97_31 - 1 do
					local var_97_32 = var_97_29:GetChild(iter_97_2)

					if var_97_32.name == "" or not string.find(var_97_32.name, "split") then
						var_97_32.gameObject:SetActive(true)
					else
						var_97_32.gameObject:SetActive(false)
					end
				end
			end

			local var_97_33 = 0.001

			if var_97_30 <= arg_94_1.time_ and arg_94_1.time_ < var_97_30 + var_97_33 then
				local var_97_34 = (arg_94_1.time_ - var_97_30) / var_97_33
				local var_97_35 = Vector3.New(0, -2000, -300)

				var_97_29.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10128, var_97_35, var_97_34)
			end

			if arg_94_1.time_ >= var_97_30 + var_97_33 and arg_94_1.time_ < var_97_30 + var_97_33 + arg_97_0 then
				var_97_29.localPosition = Vector3.New(0, -2000, -300)
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_36 = 4
			local var_97_37 = 1.375

			if var_97_36 < arg_94_1.time_ and arg_94_1.time_ <= var_97_36 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_38 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_38:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_39 = arg_94_1:GetWordFromCfg(417172022)
				local var_97_40 = arg_94_1:FormatText(var_97_39.content)

				arg_94_1.text_.text = var_97_40

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_41 = 55
				local var_97_42 = utf8.len(var_97_40)
				local var_97_43 = var_97_41 <= 0 and var_97_37 or var_97_37 * (var_97_42 / var_97_41)

				if var_97_43 > 0 and var_97_37 < var_97_43 then
					arg_94_1.talkMaxDuration = var_97_43
					var_97_36 = var_97_36 + 0.3

					if var_97_43 + var_97_36 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_43 + var_97_36
					end
				end

				arg_94_1.text_.text = var_97_40
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_44 = var_97_36 + 0.3
			local var_97_45 = math.max(var_97_37, arg_94_1.talkMaxDuration)

			if var_97_44 <= arg_94_1.time_ and arg_94_1.time_ < var_97_44 + var_97_45 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_44) / var_97_45

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_44 + var_97_45 and arg_94_1.time_ < var_97_44 + var_97_45 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play417172023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417172023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play417172024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.1
			local var_103_1 = 1

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				local var_103_2 = "play"
				local var_103_3 = "effect"

				arg_100_1:AudioAction(var_103_2, var_103_3, "se_story_1310", "se_story_1310_footstep08", "")
			end

			local var_103_4 = 0
			local var_103_5 = 0.925

			if var_103_4 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(417172023)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_8 = 37
				local var_103_9 = utf8.len(var_103_7)
				local var_103_10 = var_103_8 <= 0 and var_103_5 or var_103_5 * (var_103_9 / var_103_8)

				if var_103_10 > 0 and var_103_5 < var_103_10 then
					arg_100_1.talkMaxDuration = var_103_10

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_11 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_11 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_11

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_11 and arg_100_1.time_ < var_103_4 + var_103_11 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play417172024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417172024
		arg_104_1.duration_ = 3.27

		local var_104_0 = {
			zh = 2.066,
			ja = 3.266
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play417172025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.125

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[36].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(417172024)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 5
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172024", "story_v_out_417172.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172024", "story_v_out_417172.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_417172", "417172024", "story_v_out_417172.awb")

						arg_104_1:RecordAudio("417172024", var_107_9)
						arg_104_1:RecordAudio("417172024", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417172", "417172024", "story_v_out_417172.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417172", "417172024", "story_v_out_417172.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play417172025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417172025
		arg_108_1.duration_ = 4.97

		local var_108_0 = {
			zh = 2.7,
			ja = 4.966
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play417172026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10128"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps10128 == nil then
				arg_108_1.var_.actorSpriteComps10128 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps10128 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								local var_111_4 = Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, var_111_3)
								local var_111_5 = Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, var_111_3)
								local var_111_6 = Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, var_111_3)

								iter_111_1.color = Color.New(var_111_4, var_111_5, var_111_6)
							else
								local var_111_7 = Mathf.Lerp(iter_111_1.color.r, 1, var_111_3)

								iter_111_1.color = Color.New(var_111_7, var_111_7, var_111_7)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps10128 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10128 = nil
			end

			local var_111_8 = arg_108_1.actors_["10128"].transform
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 then
				arg_108_1.var_.moveOldPos10128 = var_111_8.localPosition
				var_111_8.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("10128", 3)

				local var_111_10 = var_111_8.childCount

				for iter_111_4 = 0, var_111_10 - 1 do
					local var_111_11 = var_111_8:GetChild(iter_111_4)

					if var_111_11.name == "" or not string.find(var_111_11.name, "split") then
						var_111_11.gameObject:SetActive(true)
					else
						var_111_11.gameObject:SetActive(false)
					end
				end
			end

			local var_111_12 = 0.001

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_12 then
				local var_111_13 = (arg_108_1.time_ - var_111_9) / var_111_12
				local var_111_14 = Vector3.New(0, -347, -300)

				var_111_8.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10128, var_111_14, var_111_13)
			end

			if arg_108_1.time_ >= var_111_9 + var_111_12 and arg_108_1.time_ < var_111_9 + var_111_12 + arg_111_0 then
				var_111_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_111_15 = 0
			local var_111_16 = 0.275

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[595].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(417172025)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 11
				local var_111_21 = utf8.len(var_111_19)
				local var_111_22 = var_111_20 <= 0 and var_111_16 or var_111_16 * (var_111_21 / var_111_20)

				if var_111_22 > 0 and var_111_16 < var_111_22 then
					arg_108_1.talkMaxDuration = var_111_22

					if var_111_22 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_22 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172025", "story_v_out_417172.awb") ~= 0 then
					local var_111_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172025", "story_v_out_417172.awb") / 1000

					if var_111_23 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_15
					end

					if var_111_18.prefab_name ~= "" and arg_108_1.actors_[var_111_18.prefab_name] ~= nil then
						local var_111_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_18.prefab_name].transform, "story_v_out_417172", "417172025", "story_v_out_417172.awb")

						arg_108_1:RecordAudio("417172025", var_111_24)
						arg_108_1:RecordAudio("417172025", var_111_24)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417172", "417172025", "story_v_out_417172.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417172", "417172025", "story_v_out_417172.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_25 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_25 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_25

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_25 and arg_108_1.time_ < var_111_15 + var_111_25 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play417172026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417172026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417172027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10128"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10128 == nil then
				arg_112_1.var_.actorSpriteComps10128 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps10128 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor2.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor2.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor2.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 0.5, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10128 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10128 = nil
			end

			local var_115_8 = arg_112_1.actors_["10128"].transform
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1.var_.moveOldPos10128 = var_115_8.localPosition
				var_115_8.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10128", 7)

				local var_115_10 = var_115_8.childCount

				for iter_115_4 = 0, var_115_10 - 1 do
					local var_115_11 = var_115_8:GetChild(iter_115_4)

					if var_115_11.name == "" or not string.find(var_115_11.name, "split") then
						var_115_11.gameObject:SetActive(true)
					else
						var_115_11.gameObject:SetActive(false)
					end
				end
			end

			local var_115_12 = 0.001

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_12 then
				local var_115_13 = (arg_112_1.time_ - var_115_9) / var_115_12
				local var_115_14 = Vector3.New(0, -2000, -300)

				var_115_8.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10128, var_115_14, var_115_13)
			end

			if arg_112_1.time_ >= var_115_9 + var_115_12 and arg_112_1.time_ < var_115_9 + var_115_12 + arg_115_0 then
				var_115_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_115_15 = 0.2
			local var_115_16 = 1

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				local var_115_17 = "play"
				local var_115_18 = "effect"

				arg_112_1:AudioAction(var_115_17, var_115_18, "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_115_19 = 0
			local var_115_20 = 1.025

			if var_115_19 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_21 = arg_112_1:GetWordFromCfg(417172026)
				local var_115_22 = arg_112_1:FormatText(var_115_21.content)

				arg_112_1.text_.text = var_115_22

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_23 = 41
				local var_115_24 = utf8.len(var_115_22)
				local var_115_25 = var_115_23 <= 0 and var_115_20 or var_115_20 * (var_115_24 / var_115_23)

				if var_115_25 > 0 and var_115_20 < var_115_25 then
					arg_112_1.talkMaxDuration = var_115_25

					if var_115_25 + var_115_19 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_25 + var_115_19
					end
				end

				arg_112_1.text_.text = var_115_22
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_26 = math.max(var_115_20, arg_112_1.talkMaxDuration)

			if var_115_19 <= arg_112_1.time_ and arg_112_1.time_ < var_115_19 + var_115_26 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_19) / var_115_26

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_19 + var_115_26 and arg_112_1.time_ < var_115_19 + var_115_26 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play417172027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417172027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play417172028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1.15

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(417172027)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 46
				local var_119_5 = utf8.len(var_119_3)
				local var_119_6 = var_119_4 <= 0 and var_119_1 or var_119_1 * (var_119_5 / var_119_4)

				if var_119_6 > 0 and var_119_1 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_7 and arg_116_1.time_ < var_119_0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417172028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417172028
		arg_120_1.duration_ = 7.67

		local var_120_0 = {
			zh = 7.066,
			ja = 7.666
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play417172029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[1144].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(417172028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 40
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172028", "story_v_out_417172.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172028", "story_v_out_417172.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_417172", "417172028", "story_v_out_417172.awb")

						arg_120_1:RecordAudio("417172028", var_123_9)
						arg_120_1:RecordAudio("417172028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417172", "417172028", "story_v_out_417172.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417172", "417172028", "story_v_out_417172.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417172029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417172029
		arg_124_1.duration_ = 3.63

		local var_124_0 = {
			zh = 2.666,
			ja = 3.633
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play417172030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10128"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10128 == nil then
				arg_124_1.var_.actorSpriteComps10128 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps10128 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 1, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10128 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10128 = nil
			end

			local var_127_8 = arg_124_1.actors_["10128"].transform
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.var_.moveOldPos10128 = var_127_8.localPosition
				var_127_8.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10128", 3)

				local var_127_10 = var_127_8.childCount

				for iter_127_4 = 0, var_127_10 - 1 do
					local var_127_11 = var_127_8:GetChild(iter_127_4)

					if var_127_11.name == "" or not string.find(var_127_11.name, "split") then
						var_127_11.gameObject:SetActive(true)
					else
						var_127_11.gameObject:SetActive(false)
					end
				end
			end

			local var_127_12 = 0.001

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_12 then
				local var_127_13 = (arg_124_1.time_ - var_127_9) / var_127_12
				local var_127_14 = Vector3.New(0, -347, -300)

				var_127_8.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10128, var_127_14, var_127_13)
			end

			if arg_124_1.time_ >= var_127_9 + var_127_12 and arg_124_1.time_ < var_127_9 + var_127_12 + arg_127_0 then
				var_127_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_127_15 = 0
			local var_127_16 = 0.35

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_17 = arg_124_1:FormatText(StoryNameCfg[595].name)

				arg_124_1.leftNameTxt_.text = var_127_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(417172029)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 14
				local var_127_21 = utf8.len(var_127_19)
				local var_127_22 = var_127_20 <= 0 and var_127_16 or var_127_16 * (var_127_21 / var_127_20)

				if var_127_22 > 0 and var_127_16 < var_127_22 then
					arg_124_1.talkMaxDuration = var_127_22

					if var_127_22 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_22 + var_127_15
					end
				end

				arg_124_1.text_.text = var_127_19
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172029", "story_v_out_417172.awb") ~= 0 then
					local var_127_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172029", "story_v_out_417172.awb") / 1000

					if var_127_23 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_15
					end

					if var_127_18.prefab_name ~= "" and arg_124_1.actors_[var_127_18.prefab_name] ~= nil then
						local var_127_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_18.prefab_name].transform, "story_v_out_417172", "417172029", "story_v_out_417172.awb")

						arg_124_1:RecordAudio("417172029", var_127_24)
						arg_124_1:RecordAudio("417172029", var_127_24)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417172", "417172029", "story_v_out_417172.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417172", "417172029", "story_v_out_417172.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_25 = math.max(var_127_16, arg_124_1.talkMaxDuration)

			if var_127_15 <= arg_124_1.time_ and arg_124_1.time_ < var_127_15 + var_127_25 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_15) / var_127_25

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_15 + var_127_25 and arg_124_1.time_ < var_127_15 + var_127_25 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play417172030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417172030
		arg_128_1.duration_ = 4.27

		local var_128_0 = {
			zh = 3.733,
			ja = 4.266
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play417172031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["10128"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10128 == nil then
				arg_128_1.var_.actorSpriteComps10128 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps10128 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor2.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor2.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor2.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 0.5, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps10128 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10128 = nil
			end

			local var_131_8 = arg_128_1.actors_["10128"].transform
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 then
				arg_128_1.var_.moveOldPos10128 = var_131_8.localPosition
				var_131_8.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10128", 7)

				local var_131_10 = var_131_8.childCount

				for iter_131_4 = 0, var_131_10 - 1 do
					local var_131_11 = var_131_8:GetChild(iter_131_4)

					if var_131_11.name == "" or not string.find(var_131_11.name, "split") then
						var_131_11.gameObject:SetActive(true)
					else
						var_131_11.gameObject:SetActive(false)
					end
				end
			end

			local var_131_12 = 0.001

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_12 then
				local var_131_13 = (arg_128_1.time_ - var_131_9) / var_131_12
				local var_131_14 = Vector3.New(0, -2000, -300)

				var_131_8.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10128, var_131_14, var_131_13)
			end

			if arg_128_1.time_ >= var_131_9 + var_131_12 and arg_128_1.time_ < var_131_9 + var_131_12 + arg_131_0 then
				var_131_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_131_15 = 0
			local var_131_16 = 0.4

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[1144].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_18 = arg_128_1:GetWordFromCfg(417172030)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 16
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172030", "story_v_out_417172.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172030", "story_v_out_417172.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_417172", "417172030", "story_v_out_417172.awb")

						arg_128_1:RecordAudio("417172030", var_131_24)
						arg_128_1:RecordAudio("417172030", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417172", "417172030", "story_v_out_417172.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417172", "417172030", "story_v_out_417172.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play417172031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417172031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play417172032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.675

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(417172031)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 27
				local var_135_5 = utf8.len(var_135_3)
				local var_135_6 = var_135_4 <= 0 and var_135_1 or var_135_1 * (var_135_5 / var_135_4)

				if var_135_6 > 0 and var_135_1 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_7 and arg_132_1.time_ < var_135_0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417172032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417172032
		arg_136_1.duration_ = 3.2

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417172033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 1

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.fswbg_:SetActive(true)
				arg_136_1.dialog_:SetActive(false)

				arg_136_1.fswtw_.percent = 0

				local var_139_1 = arg_136_1:GetWordFromCfg(417172032)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.fswt_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.fswt_)

				arg_136_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_136_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_136_1.fswtw_:SetDirty()

				arg_136_1.typewritterCharCountI18N = 0

				SetActive(arg_136_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_136_1:ShowNextGo(false)
			end

			local var_139_3 = 1.33333333333333

			if var_139_3 < arg_136_1.time_ and arg_136_1.time_ <= var_139_3 + arg_139_0 then
				arg_136_1.var_.oldValueTypewriter = arg_136_1.fswtw_.percent

				SetActive(arg_136_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_136_1:ShowNextGo(false)
			end

			local var_139_4 = 27
			local var_139_5 = 1.86666666666667
			local var_139_6 = arg_136_1:GetWordFromCfg(417172032)
			local var_139_7 = arg_136_1:FormatText(var_139_6.content)
			local var_139_8, var_139_9 = arg_136_1:GetPercentByPara(var_139_7, 2)

			if var_139_3 < arg_136_1.time_ and arg_136_1.time_ <= var_139_3 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				local var_139_10 = var_139_4 <= 0 and var_139_5 or var_139_5 * ((var_139_9 - arg_136_1.typewritterCharCountI18N) / var_139_4)

				if var_139_10 > 0 and var_139_5 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_3 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_3
					end
				end
			end

			local var_139_11 = 1.86666666666667
			local var_139_12 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_3 + var_139_12 then
				local var_139_13 = (arg_136_1.time_ - var_139_3) / var_139_12

				arg_136_1.fswtw_.percent = Mathf.Lerp(arg_136_1.var_.oldValueTypewriter, var_139_8, var_139_13)
				arg_136_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_136_1.fswtw_:SetDirty()
			end

			if arg_136_1.time_ >= var_139_3 + var_139_12 and arg_136_1.time_ < var_139_3 + var_139_12 + arg_139_0 then
				arg_136_1.fswtw_.percent = var_139_8

				arg_136_1.fswtw_:SetDirty()
				arg_136_1:ShowNextGo(true)

				arg_136_1.typewritterCharCountI18N = var_139_9
			end

			local var_139_14 = 1.33333333333333

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 then
				local var_139_15 = arg_136_1.fswbg_.transform:Find("textbox/adapt/content") or arg_136_1.fswbg_.transform:Find("textbox/content")
				local var_139_16 = arg_136_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_139_17 = var_139_15:GetComponent("Text")
				local var_139_18 = var_139_15:GetComponent("RectTransform")

				var_139_17.alignment = UnityEngine.TextAnchor.MiddleLeft
				var_139_18.offsetMin = Vector2.New(0, 0)
				var_139_18.offsetMax = Vector2.New(0, 0)
			end

			local var_139_19 = 0

			if var_139_19 < arg_136_1.time_ and arg_136_1.time_ <= var_139_19 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = false

				arg_136_1:SetGaussion(false)
			end

			local var_139_20 = 1

			if var_139_19 <= arg_136_1.time_ and arg_136_1.time_ < var_139_19 + var_139_20 then
				local var_139_21 = (arg_136_1.time_ - var_139_19) / var_139_20
				local var_139_22 = Color.New(0, 0, 0)

				var_139_22.a = Mathf.Lerp(0, 1, var_139_21)
				arg_136_1.mask_.color = var_139_22
			end

			if arg_136_1.time_ >= var_139_19 + var_139_20 and arg_136_1.time_ < var_139_19 + var_139_20 + arg_139_0 then
				local var_139_23 = Color.New(0, 0, 0)

				var_139_23.a = 1
				arg_136_1.mask_.color = var_139_23
			end

			local var_139_24 = 1

			if var_139_24 < arg_136_1.time_ and arg_136_1.time_ <= var_139_24 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = false

				arg_136_1:SetGaussion(false)
			end

			local var_139_25 = 1

			if var_139_24 <= arg_136_1.time_ and arg_136_1.time_ < var_139_24 + var_139_25 then
				local var_139_26 = (arg_136_1.time_ - var_139_24) / var_139_25
				local var_139_27 = Color.New(0, 0, 0)

				var_139_27.a = Mathf.Lerp(1, 0, var_139_26)
				arg_136_1.mask_.color = var_139_27
			end

			if arg_136_1.time_ >= var_139_24 + var_139_25 and arg_136_1.time_ < var_139_24 + var_139_25 + arg_139_0 then
				local var_139_28 = Color.New(0, 0, 0)
				local var_139_29 = 0

				arg_136_1.mask_.enabled = false
				var_139_28.a = var_139_29
				arg_136_1.mask_.color = var_139_28
			end

			local var_139_30 = "STblack"

			if arg_136_1.bgs_[var_139_30] == nil then
				local var_139_31 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_31:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_139_30)
				var_139_31.name = var_139_30
				var_139_31.transform.parent = arg_136_1.stage_.transform
				var_139_31.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_[var_139_30] = var_139_31
			end

			local var_139_32 = 1

			if var_139_32 < arg_136_1.time_ and arg_136_1.time_ <= var_139_32 + arg_139_0 then
				local var_139_33 = manager.ui.mainCamera.transform.localPosition
				local var_139_34 = Vector3.New(0, 0, 10) + Vector3.New(var_139_33.x, var_139_33.y, 0)
				local var_139_35 = arg_136_1.bgs_.STblack

				var_139_35.transform.localPosition = var_139_34
				var_139_35.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_36 = var_139_35:GetComponent("SpriteRenderer")

				if var_139_36 and var_139_36.sprite then
					local var_139_37 = (var_139_35.transform.localPosition - var_139_33).z
					local var_139_38 = manager.ui.mainCameraCom_
					local var_139_39 = 2 * var_139_37 * Mathf.Tan(var_139_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_139_40 = var_139_39 * var_139_38.aspect
					local var_139_41 = var_139_36.sprite.bounds.size.x
					local var_139_42 = var_139_36.sprite.bounds.size.y
					local var_139_43 = var_139_40 / var_139_41
					local var_139_44 = var_139_39 / var_139_42
					local var_139_45 = var_139_44 < var_139_43 and var_139_43 or var_139_44

					var_139_35.transform.localScale = Vector3.New(var_139_45, var_139_45, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "STblack" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_139_46 = 0

			if var_139_46 < arg_136_1.time_ and arg_136_1.time_ <= var_139_46 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			local var_139_47 = 3.18333333333333

			if arg_136_1.time_ >= var_139_46 + var_139_47 and arg_136_1.time_ < var_139_46 + var_139_47 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_48 = 1.2

			if var_139_48 < arg_136_1.time_ and arg_136_1.time_ <= var_139_48 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			local var_139_49 = 2

			if arg_136_1.time_ >= var_139_48 + var_139_49 and arg_136_1.time_ < var_139_48 + var_139_49 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play417172033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417172033
		arg_140_1.duration_ = 4.87

		local var_140_0 = {
			zh = 4.866,
			ja = 4.133
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play417172034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				local var_143_1 = manager.ui.mainCamera.transform.localPosition
				local var_143_2 = Vector3.New(0, 0, 10) + Vector3.New(var_143_1.x, var_143_1.y, 0)
				local var_143_3 = arg_140_1.bgs_.ST2104a

				var_143_3.transform.localPosition = var_143_2
				var_143_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_4 = var_143_3:GetComponent("SpriteRenderer")

				if var_143_4 and var_143_4.sprite then
					local var_143_5 = (var_143_3.transform.localPosition - var_143_1).z
					local var_143_6 = manager.ui.mainCameraCom_
					local var_143_7 = 2 * var_143_5 * Mathf.Tan(var_143_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_143_8 = var_143_7 * var_143_6.aspect
					local var_143_9 = var_143_4.sprite.bounds.size.x
					local var_143_10 = var_143_4.sprite.bounds.size.y
					local var_143_11 = var_143_8 / var_143_9
					local var_143_12 = var_143_7 / var_143_10
					local var_143_13 = var_143_12 < var_143_11 and var_143_11 or var_143_12

					var_143_3.transform.localScale = Vector3.New(var_143_13, var_143_13, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "ST2104a" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_14 = 0

			if var_143_14 < arg_140_1.time_ and arg_140_1.time_ <= var_143_14 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = false

				arg_140_1:SetGaussion(false)
			end

			local var_143_15 = 1.2

			if var_143_14 <= arg_140_1.time_ and arg_140_1.time_ < var_143_14 + var_143_15 then
				local var_143_16 = (arg_140_1.time_ - var_143_14) / var_143_15
				local var_143_17 = Color.New(0, 0, 0)

				var_143_17.a = Mathf.Lerp(1, 0, var_143_16)
				arg_140_1.mask_.color = var_143_17
			end

			if arg_140_1.time_ >= var_143_14 + var_143_15 and arg_140_1.time_ < var_143_14 + var_143_15 + arg_143_0 then
				local var_143_18 = Color.New(0, 0, 0)
				local var_143_19 = 0

				arg_140_1.mask_.enabled = false
				var_143_18.a = var_143_19
				arg_140_1.mask_.color = var_143_18
			end

			local var_143_20 = 0

			if var_143_20 < arg_140_1.time_ and arg_140_1.time_ <= var_143_20 + arg_143_0 then
				arg_140_1.fswbg_:SetActive(false)
				arg_140_1.dialog_:SetActive(false)
				SetActive(arg_140_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_140_1:ShowNextGo(false)
			end

			local var_143_21 = arg_140_1.actors_["10128"]
			local var_143_22 = 0.866666666666667

			if var_143_22 < arg_140_1.time_ and arg_140_1.time_ <= var_143_22 + arg_143_0 and not isNil(var_143_21) and arg_140_1.var_.actorSpriteComps10128 == nil then
				arg_140_1.var_.actorSpriteComps10128 = var_143_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_23 = 0.2

			if var_143_22 <= arg_140_1.time_ and arg_140_1.time_ < var_143_22 + var_143_23 and not isNil(var_143_21) then
				local var_143_24 = (arg_140_1.time_ - var_143_22) / var_143_23

				if arg_140_1.var_.actorSpriteComps10128 then
					for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_143_3 then
							if arg_140_1.isInRecall_ then
								local var_143_25 = Mathf.Lerp(iter_143_3.color.r, arg_140_1.hightColor1.r, var_143_24)
								local var_143_26 = Mathf.Lerp(iter_143_3.color.g, arg_140_1.hightColor1.g, var_143_24)
								local var_143_27 = Mathf.Lerp(iter_143_3.color.b, arg_140_1.hightColor1.b, var_143_24)

								iter_143_3.color = Color.New(var_143_25, var_143_26, var_143_27)
							else
								local var_143_28 = Mathf.Lerp(iter_143_3.color.r, 1, var_143_24)

								iter_143_3.color = Color.New(var_143_28, var_143_28, var_143_28)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_22 + var_143_23 and arg_140_1.time_ < var_143_22 + var_143_23 + arg_143_0 and not isNil(var_143_21) and arg_140_1.var_.actorSpriteComps10128 then
				for iter_143_4, iter_143_5 in pairs(arg_140_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_143_5 then
						if arg_140_1.isInRecall_ then
							iter_143_5.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps10128 = nil
			end

			local var_143_29 = arg_140_1.actors_["10128"].transform
			local var_143_30 = 0.866666666666667

			if var_143_30 < arg_140_1.time_ and arg_140_1.time_ <= var_143_30 + arg_143_0 then
				arg_140_1.var_.moveOldPos10128 = var_143_29.localPosition
				var_143_29.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10128", 3)

				local var_143_31 = var_143_29.childCount

				for iter_143_6 = 0, var_143_31 - 1 do
					local var_143_32 = var_143_29:GetChild(iter_143_6)

					if var_143_32.name == "" or not string.find(var_143_32.name, "split") then
						var_143_32.gameObject:SetActive(true)
					else
						var_143_32.gameObject:SetActive(false)
					end
				end
			end

			local var_143_33 = 0.001

			if var_143_30 <= arg_140_1.time_ and arg_140_1.time_ < var_143_30 + var_143_33 then
				local var_143_34 = (arg_140_1.time_ - var_143_30) / var_143_33
				local var_143_35 = Vector3.New(0, -347, -300)

				var_143_29.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10128, var_143_35, var_143_34)
			end

			if arg_140_1.time_ >= var_143_30 + var_143_33 and arg_140_1.time_ < var_143_30 + var_143_33 + arg_143_0 then
				var_143_29.localPosition = Vector3.New(0, -347, -300)
			end

			local var_143_36 = arg_140_1.actors_["10128"]
			local var_143_37 = 0.866666666666667

			if var_143_37 < arg_140_1.time_ and arg_140_1.time_ <= var_143_37 + arg_143_0 then
				local var_143_38 = var_143_36:GetComponentInChildren(typeof(CanvasGroup))

				if var_143_38 then
					arg_140_1.var_.alphaOldValue10128 = var_143_38.alpha
					arg_140_1.var_.characterEffect10128 = var_143_38
				end

				arg_140_1.var_.alphaOldValue10128 = 0
			end

			local var_143_39 = 0.333333333333333

			if var_143_37 <= arg_140_1.time_ and arg_140_1.time_ < var_143_37 + var_143_39 then
				local var_143_40 = (arg_140_1.time_ - var_143_37) / var_143_39
				local var_143_41 = Mathf.Lerp(arg_140_1.var_.alphaOldValue10128, 1, var_143_40)

				if arg_140_1.var_.characterEffect10128 then
					arg_140_1.var_.characterEffect10128.alpha = var_143_41
				end
			end

			if arg_140_1.time_ >= var_143_37 + var_143_39 and arg_140_1.time_ < var_143_37 + var_143_39 + arg_143_0 and arg_140_1.var_.characterEffect10128 then
				arg_140_1.var_.characterEffect10128.alpha = 1
			end

			local var_143_42 = 1.2
			local var_143_43 = 0.2

			if var_143_42 < arg_140_1.time_ and arg_140_1.time_ <= var_143_42 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_44 = arg_140_1:FormatText(StoryNameCfg[595].name)

				arg_140_1.leftNameTxt_.text = var_143_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_45 = arg_140_1:GetWordFromCfg(417172033)
				local var_143_46 = arg_140_1:FormatText(var_143_45.content)

				arg_140_1.text_.text = var_143_46

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_47 = 8
				local var_143_48 = utf8.len(var_143_46)
				local var_143_49 = var_143_47 <= 0 and var_143_43 or var_143_43 * (var_143_48 / var_143_47)

				if var_143_49 > 0 and var_143_43 < var_143_49 then
					arg_140_1.talkMaxDuration = var_143_49

					if var_143_49 + var_143_42 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_49 + var_143_42
					end
				end

				arg_140_1.text_.text = var_143_46
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172033", "story_v_out_417172.awb") ~= 0 then
					local var_143_50 = manager.audio:GetVoiceLength("story_v_out_417172", "417172033", "story_v_out_417172.awb") / 1000

					if var_143_50 + var_143_42 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_50 + var_143_42
					end

					if var_143_45.prefab_name ~= "" and arg_140_1.actors_[var_143_45.prefab_name] ~= nil then
						local var_143_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_45.prefab_name].transform, "story_v_out_417172", "417172033", "story_v_out_417172.awb")

						arg_140_1:RecordAudio("417172033", var_143_51)
						arg_140_1:RecordAudio("417172033", var_143_51)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417172", "417172033", "story_v_out_417172.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417172", "417172033", "story_v_out_417172.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_52 = math.max(var_143_43, arg_140_1.talkMaxDuration)

			if var_143_42 <= arg_140_1.time_ and arg_140_1.time_ < var_143_42 + var_143_52 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_42) / var_143_52

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_42 + var_143_52 and arg_140_1.time_ < var_143_42 + var_143_52 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.866666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play417172034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417172034
		arg_144_1.duration_ = 6.43

		local var_144_0 = {
			zh = 5.633,
			ja = 6.433
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play417172035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10128"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10128 == nil then
				arg_144_1.var_.actorSpriteComps10128 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps10128 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor2.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor2.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor2.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 0.5, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps10128 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_147_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps10128 = nil
			end

			local var_147_8 = 0
			local var_147_9 = 0.75

			if var_147_8 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_10 = arg_144_1:FormatText(StoryNameCfg[1144].name)

				arg_144_1.leftNameTxt_.text = var_147_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_11 = arg_144_1:GetWordFromCfg(417172034)
				local var_147_12 = arg_144_1:FormatText(var_147_11.content)

				arg_144_1.text_.text = var_147_12

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 30
				local var_147_14 = utf8.len(var_147_12)
				local var_147_15 = var_147_13 <= 0 and var_147_9 or var_147_9 * (var_147_14 / var_147_13)

				if var_147_15 > 0 and var_147_9 < var_147_15 then
					arg_144_1.talkMaxDuration = var_147_15

					if var_147_15 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_15 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_12
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172034", "story_v_out_417172.awb") ~= 0 then
					local var_147_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172034", "story_v_out_417172.awb") / 1000

					if var_147_16 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_8
					end

					if var_147_11.prefab_name ~= "" and arg_144_1.actors_[var_147_11.prefab_name] ~= nil then
						local var_147_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_11.prefab_name].transform, "story_v_out_417172", "417172034", "story_v_out_417172.awb")

						arg_144_1:RecordAudio("417172034", var_147_17)
						arg_144_1:RecordAudio("417172034", var_147_17)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417172", "417172034", "story_v_out_417172.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417172", "417172034", "story_v_out_417172.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_18 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_18 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_18

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_18 and arg_144_1.time_ < var_147_8 + var_147_18 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417172035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417172035
		arg_148_1.duration_ = 2.07

		local var_148_0 = {
			zh = 2.066,
			ja = 2.033
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play417172036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10128"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10128 == nil then
				arg_148_1.var_.actorSpriteComps10128 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps10128 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 1, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10128 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10128 = nil
			end

			local var_151_8 = arg_148_1.actors_["10128"].transform
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.var_.moveOldPos10128 = var_151_8.localPosition
				var_151_8.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10128", 3)

				local var_151_10 = var_151_8.childCount

				for iter_151_4 = 0, var_151_10 - 1 do
					local var_151_11 = var_151_8:GetChild(iter_151_4)

					if var_151_11.name == "split_6" or not string.find(var_151_11.name, "split") then
						var_151_11.gameObject:SetActive(true)
					else
						var_151_11.gameObject:SetActive(false)
					end
				end
			end

			local var_151_12 = 0.001

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_12 then
				local var_151_13 = (arg_148_1.time_ - var_151_9) / var_151_12
				local var_151_14 = Vector3.New(0, -347, -300)

				var_151_8.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10128, var_151_14, var_151_13)
			end

			if arg_148_1.time_ >= var_151_9 + var_151_12 and arg_148_1.time_ < var_151_9 + var_151_12 + arg_151_0 then
				var_151_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_151_15 = 0
			local var_151_16 = 0.225

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[595].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(417172035)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 9
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172035", "story_v_out_417172.awb") ~= 0 then
					local var_151_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172035", "story_v_out_417172.awb") / 1000

					if var_151_23 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_15
					end

					if var_151_18.prefab_name ~= "" and arg_148_1.actors_[var_151_18.prefab_name] ~= nil then
						local var_151_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_18.prefab_name].transform, "story_v_out_417172", "417172035", "story_v_out_417172.awb")

						arg_148_1:RecordAudio("417172035", var_151_24)
						arg_148_1:RecordAudio("417172035", var_151_24)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417172", "417172035", "story_v_out_417172.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417172", "417172035", "story_v_out_417172.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_25 and arg_148_1.time_ < var_151_15 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play417172036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417172036
		arg_152_1.duration_ = 9.13

		local var_152_0 = {
			zh = 6.466,
			ja = 9.133
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play417172037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10128"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps10128 == nil then
				arg_152_1.var_.actorSpriteComps10128 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps10128 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								local var_155_4 = Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor2.r, var_155_3)
								local var_155_5 = Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor2.g, var_155_3)
								local var_155_6 = Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor2.b, var_155_3)

								iter_155_1.color = Color.New(var_155_4, var_155_5, var_155_6)
							else
								local var_155_7 = Mathf.Lerp(iter_155_1.color.r, 0.5, var_155_3)

								iter_155_1.color = Color.New(var_155_7, var_155_7, var_155_7)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps10128 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_155_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps10128 = nil
			end

			local var_155_8 = 0
			local var_155_9 = 0.9

			if var_155_8 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_10 = arg_152_1:FormatText(StoryNameCfg[1144].name)

				arg_152_1.leftNameTxt_.text = var_155_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_11 = arg_152_1:GetWordFromCfg(417172036)
				local var_155_12 = arg_152_1:FormatText(var_155_11.content)

				arg_152_1.text_.text = var_155_12

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_13 = 36
				local var_155_14 = utf8.len(var_155_12)
				local var_155_15 = var_155_13 <= 0 and var_155_9 or var_155_9 * (var_155_14 / var_155_13)

				if var_155_15 > 0 and var_155_9 < var_155_15 then
					arg_152_1.talkMaxDuration = var_155_15

					if var_155_15 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_15 + var_155_8
					end
				end

				arg_152_1.text_.text = var_155_12
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172036", "story_v_out_417172.awb") ~= 0 then
					local var_155_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172036", "story_v_out_417172.awb") / 1000

					if var_155_16 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_16 + var_155_8
					end

					if var_155_11.prefab_name ~= "" and arg_152_1.actors_[var_155_11.prefab_name] ~= nil then
						local var_155_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_11.prefab_name].transform, "story_v_out_417172", "417172036", "story_v_out_417172.awb")

						arg_152_1:RecordAudio("417172036", var_155_17)
						arg_152_1:RecordAudio("417172036", var_155_17)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417172", "417172036", "story_v_out_417172.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417172", "417172036", "story_v_out_417172.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_18 = math.max(var_155_9, arg_152_1.talkMaxDuration)

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_18 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_8) / var_155_18

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_8 + var_155_18 and arg_152_1.time_ < var_155_8 + var_155_18 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417172037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417172037
		arg_156_1.duration_ = 4.03

		local var_156_0 = {
			zh = 3.7,
			ja = 4.033
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417172038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10128"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps10128 == nil then
				arg_156_1.var_.actorSpriteComps10128 = var_159_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.actorSpriteComps10128 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								local var_159_4 = Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor1.r, var_159_3)
								local var_159_5 = Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor1.g, var_159_3)
								local var_159_6 = Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor1.b, var_159_3)

								iter_159_1.color = Color.New(var_159_4, var_159_5, var_159_6)
							else
								local var_159_7 = Mathf.Lerp(iter_159_1.color.r, 1, var_159_3)

								iter_159_1.color = Color.New(var_159_7, var_159_7, var_159_7)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps10128 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_159_3 then
						if arg_156_1.isInRecall_ then
							iter_159_3.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_159_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps10128 = nil
			end

			local var_159_8 = 0
			local var_159_9 = 0.425

			if var_159_8 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_10 = arg_156_1:FormatText(StoryNameCfg[595].name)

				arg_156_1.leftNameTxt_.text = var_159_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_11 = arg_156_1:GetWordFromCfg(417172037)
				local var_159_12 = arg_156_1:FormatText(var_159_11.content)

				arg_156_1.text_.text = var_159_12

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_13 = 17
				local var_159_14 = utf8.len(var_159_12)
				local var_159_15 = var_159_13 <= 0 and var_159_9 or var_159_9 * (var_159_14 / var_159_13)

				if var_159_15 > 0 and var_159_9 < var_159_15 then
					arg_156_1.talkMaxDuration = var_159_15

					if var_159_15 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_15 + var_159_8
					end
				end

				arg_156_1.text_.text = var_159_12
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172037", "story_v_out_417172.awb") ~= 0 then
					local var_159_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172037", "story_v_out_417172.awb") / 1000

					if var_159_16 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_16 + var_159_8
					end

					if var_159_11.prefab_name ~= "" and arg_156_1.actors_[var_159_11.prefab_name] ~= nil then
						local var_159_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_11.prefab_name].transform, "story_v_out_417172", "417172037", "story_v_out_417172.awb")

						arg_156_1:RecordAudio("417172037", var_159_17)
						arg_156_1:RecordAudio("417172037", var_159_17)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417172", "417172037", "story_v_out_417172.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417172", "417172037", "story_v_out_417172.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_18 = math.max(var_159_9, arg_156_1.talkMaxDuration)

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_18 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_8) / var_159_18

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_8 + var_159_18 and arg_156_1.time_ < var_159_8 + var_159_18 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417172038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417172038
		arg_160_1.duration_ = 1.8

		local var_160_0 = {
			zh = 1.466,
			ja = 1.8
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417172039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10128"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps10128 == nil then
				arg_160_1.var_.actorSpriteComps10128 = var_163_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.actorSpriteComps10128 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								local var_163_4 = Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor2.r, var_163_3)
								local var_163_5 = Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor2.g, var_163_3)
								local var_163_6 = Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor2.b, var_163_3)

								iter_163_1.color = Color.New(var_163_4, var_163_5, var_163_6)
							else
								local var_163_7 = Mathf.Lerp(iter_163_1.color.r, 0.5, var_163_3)

								iter_163_1.color = Color.New(var_163_7, var_163_7, var_163_7)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps10128 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_163_3 then
						if arg_160_1.isInRecall_ then
							iter_163_3.color = arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_163_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps10128 = nil
			end

			local var_163_8 = 0
			local var_163_9 = 0.15

			if var_163_8 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_10 = arg_160_1:FormatText(StoryNameCfg[1144].name)

				arg_160_1.leftNameTxt_.text = var_163_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_11 = arg_160_1:GetWordFromCfg(417172038)
				local var_163_12 = arg_160_1:FormatText(var_163_11.content)

				arg_160_1.text_.text = var_163_12

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_13 = 6
				local var_163_14 = utf8.len(var_163_12)
				local var_163_15 = var_163_13 <= 0 and var_163_9 or var_163_9 * (var_163_14 / var_163_13)

				if var_163_15 > 0 and var_163_9 < var_163_15 then
					arg_160_1.talkMaxDuration = var_163_15

					if var_163_15 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_15 + var_163_8
					end
				end

				arg_160_1.text_.text = var_163_12
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172038", "story_v_out_417172.awb") ~= 0 then
					local var_163_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172038", "story_v_out_417172.awb") / 1000

					if var_163_16 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_16 + var_163_8
					end

					if var_163_11.prefab_name ~= "" and arg_160_1.actors_[var_163_11.prefab_name] ~= nil then
						local var_163_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_11.prefab_name].transform, "story_v_out_417172", "417172038", "story_v_out_417172.awb")

						arg_160_1:RecordAudio("417172038", var_163_17)
						arg_160_1:RecordAudio("417172038", var_163_17)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_417172", "417172038", "story_v_out_417172.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_417172", "417172038", "story_v_out_417172.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_18 = math.max(var_163_9, arg_160_1.talkMaxDuration)

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_18 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_8) / var_163_18

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_8 + var_163_18 and arg_160_1.time_ < var_163_8 + var_163_18 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417172039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417172039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play417172040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10128"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos10128 = var_167_0.localPosition
				var_167_0.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10128", 7)

				local var_167_2 = var_167_0.childCount

				for iter_167_0 = 0, var_167_2 - 1 do
					local var_167_3 = var_167_0:GetChild(iter_167_0)

					if var_167_3.name == "" or not string.find(var_167_3.name, "split") then
						var_167_3.gameObject:SetActive(true)
					else
						var_167_3.gameObject:SetActive(false)
					end
				end
			end

			local var_167_4 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_4 then
				local var_167_5 = (arg_164_1.time_ - var_167_1) / var_167_4
				local var_167_6 = Vector3.New(0, -2000, -300)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10128, var_167_6, var_167_5)
			end

			if arg_164_1.time_ >= var_167_1 + var_167_4 and arg_164_1.time_ < var_167_1 + var_167_4 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_167_7 = 0
			local var_167_8 = 1

			if var_167_7 < arg_164_1.time_ and arg_164_1.time_ <= var_167_7 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_9 = arg_164_1:GetWordFromCfg(417172039)
				local var_167_10 = arg_164_1:FormatText(var_167_9.content)

				arg_164_1.text_.text = var_167_10

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 40
				local var_167_12 = utf8.len(var_167_10)
				local var_167_13 = var_167_11 <= 0 and var_167_8 or var_167_8 * (var_167_12 / var_167_11)

				if var_167_13 > 0 and var_167_8 < var_167_13 then
					arg_164_1.talkMaxDuration = var_167_13

					if var_167_13 + var_167_7 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_7
					end
				end

				arg_164_1.text_.text = var_167_10
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_8, arg_164_1.talkMaxDuration)

			if var_167_7 <= arg_164_1.time_ and arg_164_1.time_ < var_167_7 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_7) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_7 + var_167_14 and arg_164_1.time_ < var_167_7 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play417172040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417172040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play417172041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.625

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_2 = arg_168_1:GetWordFromCfg(417172040)
				local var_171_3 = arg_168_1:FormatText(var_171_2.content)

				arg_168_1.text_.text = var_171_3

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 25
				local var_171_5 = utf8.len(var_171_3)
				local var_171_6 = var_171_4 <= 0 and var_171_1 or var_171_1 * (var_171_5 / var_171_4)

				if var_171_6 > 0 and var_171_1 < var_171_6 then
					arg_168_1.talkMaxDuration = var_171_6

					if var_171_6 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_6 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_3
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_7 and arg_168_1.time_ < var_171_0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play417172041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417172041
		arg_172_1.duration_ = 5.77

		local var_172_0 = {
			zh = 4.233,
			ja = 5.766
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play417172042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10128"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps10128 == nil then
				arg_172_1.var_.actorSpriteComps10128 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps10128 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								local var_175_4 = Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor1.r, var_175_3)
								local var_175_5 = Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor1.g, var_175_3)
								local var_175_6 = Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor1.b, var_175_3)

								iter_175_1.color = Color.New(var_175_4, var_175_5, var_175_6)
							else
								local var_175_7 = Mathf.Lerp(iter_175_1.color.r, 1, var_175_3)

								iter_175_1.color = Color.New(var_175_7, var_175_7, var_175_7)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps10128 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_175_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps10128 = nil
			end

			local var_175_8 = arg_172_1.actors_["10128"].transform
			local var_175_9 = 0

			if var_175_9 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 then
				arg_172_1.var_.moveOldPos10128 = var_175_8.localPosition
				var_175_8.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("10128", 3)

				local var_175_10 = var_175_8.childCount

				for iter_175_4 = 0, var_175_10 - 1 do
					local var_175_11 = var_175_8:GetChild(iter_175_4)

					if var_175_11.name == "" or not string.find(var_175_11.name, "split") then
						var_175_11.gameObject:SetActive(true)
					else
						var_175_11.gameObject:SetActive(false)
					end
				end
			end

			local var_175_12 = 0.001

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_12 then
				local var_175_13 = (arg_172_1.time_ - var_175_9) / var_175_12
				local var_175_14 = Vector3.New(0, -347, -300)

				var_175_8.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10128, var_175_14, var_175_13)
			end

			if arg_172_1.time_ >= var_175_9 + var_175_12 and arg_172_1.time_ < var_175_9 + var_175_12 + arg_175_0 then
				var_175_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_175_15 = 0
			local var_175_16 = 0.575

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_17 = arg_172_1:FormatText(StoryNameCfg[595].name)

				arg_172_1.leftNameTxt_.text = var_175_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_18 = arg_172_1:GetWordFromCfg(417172041)
				local var_175_19 = arg_172_1:FormatText(var_175_18.content)

				arg_172_1.text_.text = var_175_19

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_20 = 23
				local var_175_21 = utf8.len(var_175_19)
				local var_175_22 = var_175_20 <= 0 and var_175_16 or var_175_16 * (var_175_21 / var_175_20)

				if var_175_22 > 0 and var_175_16 < var_175_22 then
					arg_172_1.talkMaxDuration = var_175_22

					if var_175_22 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_15
					end
				end

				arg_172_1.text_.text = var_175_19
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172041", "story_v_out_417172.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172041", "story_v_out_417172.awb") / 1000

					if var_175_23 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_15
					end

					if var_175_18.prefab_name ~= "" and arg_172_1.actors_[var_175_18.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_18.prefab_name].transform, "story_v_out_417172", "417172041", "story_v_out_417172.awb")

						arg_172_1:RecordAudio("417172041", var_175_24)
						arg_172_1:RecordAudio("417172041", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417172", "417172041", "story_v_out_417172.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417172", "417172041", "story_v_out_417172.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = math.max(var_175_16, arg_172_1.talkMaxDuration)

			if var_175_15 <= arg_172_1.time_ and arg_172_1.time_ < var_175_15 + var_175_25 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_15) / var_175_25

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_15 + var_175_25 and arg_172_1.time_ < var_175_15 + var_175_25 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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

		arg_172_1:InitPlayNodeList()
	end,
	Play417172042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417172042
		arg_176_1.duration_ = 3.57

		local var_176_0 = {
			zh = 2.466,
			ja = 3.566
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play417172043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10128"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps10128 == nil then
				arg_176_1.var_.actorSpriteComps10128 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps10128 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								local var_179_4 = Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor2.r, var_179_3)
								local var_179_5 = Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor2.g, var_179_3)
								local var_179_6 = Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor2.b, var_179_3)

								iter_179_1.color = Color.New(var_179_4, var_179_5, var_179_6)
							else
								local var_179_7 = Mathf.Lerp(iter_179_1.color.r, 0.5, var_179_3)

								iter_179_1.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps10128 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10128 = nil
			end

			local var_179_8 = 0
			local var_179_9 = 0.3

			if var_179_8 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_10 = arg_176_1:FormatText(StoryNameCfg[1144].name)

				arg_176_1.leftNameTxt_.text = var_179_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_11 = arg_176_1:GetWordFromCfg(417172042)
				local var_179_12 = arg_176_1:FormatText(var_179_11.content)

				arg_176_1.text_.text = var_179_12

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_13 = 12
				local var_179_14 = utf8.len(var_179_12)
				local var_179_15 = var_179_13 <= 0 and var_179_9 or var_179_9 * (var_179_14 / var_179_13)

				if var_179_15 > 0 and var_179_9 < var_179_15 then
					arg_176_1.talkMaxDuration = var_179_15

					if var_179_15 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_15 + var_179_8
					end
				end

				arg_176_1.text_.text = var_179_12
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172042", "story_v_out_417172.awb") ~= 0 then
					local var_179_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172042", "story_v_out_417172.awb") / 1000

					if var_179_16 + var_179_8 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_16 + var_179_8
					end

					if var_179_11.prefab_name ~= "" and arg_176_1.actors_[var_179_11.prefab_name] ~= nil then
						local var_179_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_11.prefab_name].transform, "story_v_out_417172", "417172042", "story_v_out_417172.awb")

						arg_176_1:RecordAudio("417172042", var_179_17)
						arg_176_1:RecordAudio("417172042", var_179_17)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417172", "417172042", "story_v_out_417172.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417172", "417172042", "story_v_out_417172.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_18 = math.max(var_179_9, arg_176_1.talkMaxDuration)

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_18 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_8) / var_179_18

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_8 + var_179_18 and arg_176_1.time_ < var_179_8 + var_179_18 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play417172043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417172043
		arg_180_1.duration_ = 8.5

		local var_180_0 = {
			zh = 6.033,
			ja = 8.5
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play417172044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10128"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10128 == nil then
				arg_180_1.var_.actorSpriteComps10128 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps10128 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 1, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10128 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10128 = nil
			end

			local var_183_8 = 0
			local var_183_9 = 0.825

			if var_183_8 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_10 = arg_180_1:FormatText(StoryNameCfg[595].name)

				arg_180_1.leftNameTxt_.text = var_183_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_11 = arg_180_1:GetWordFromCfg(417172043)
				local var_183_12 = arg_180_1:FormatText(var_183_11.content)

				arg_180_1.text_.text = var_183_12

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 33
				local var_183_14 = utf8.len(var_183_12)
				local var_183_15 = var_183_13 <= 0 and var_183_9 or var_183_9 * (var_183_14 / var_183_13)

				if var_183_15 > 0 and var_183_9 < var_183_15 then
					arg_180_1.talkMaxDuration = var_183_15

					if var_183_15 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_15 + var_183_8
					end
				end

				arg_180_1.text_.text = var_183_12
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172043", "story_v_out_417172.awb") ~= 0 then
					local var_183_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172043", "story_v_out_417172.awb") / 1000

					if var_183_16 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_16 + var_183_8
					end

					if var_183_11.prefab_name ~= "" and arg_180_1.actors_[var_183_11.prefab_name] ~= nil then
						local var_183_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_11.prefab_name].transform, "story_v_out_417172", "417172043", "story_v_out_417172.awb")

						arg_180_1:RecordAudio("417172043", var_183_17)
						arg_180_1:RecordAudio("417172043", var_183_17)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417172", "417172043", "story_v_out_417172.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417172", "417172043", "story_v_out_417172.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_18 = math.max(var_183_9, arg_180_1.talkMaxDuration)

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_18 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_8) / var_183_18

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_8 + var_183_18 and arg_180_1.time_ < var_183_8 + var_183_18 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417172044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417172044
		arg_184_1.duration_ = 7.33

		local var_184_0 = {
			zh = 6.366,
			ja = 7.333
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417172045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.825

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[595].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_3 = arg_184_1:GetWordFromCfg(417172044)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 33
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172044", "story_v_out_417172.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172044", "story_v_out_417172.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_417172", "417172044", "story_v_out_417172.awb")

						arg_184_1:RecordAudio("417172044", var_187_9)
						arg_184_1:RecordAudio("417172044", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417172", "417172044", "story_v_out_417172.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417172", "417172044", "story_v_out_417172.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_10 and arg_184_1.time_ < var_187_0 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417172045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417172045
		arg_188_1.duration_ = 7.63

		local var_188_0 = {
			zh = 6,
			ja = 7.633
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play417172046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10128"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10128 == nil then
				arg_188_1.var_.actorSpriteComps10128 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps10128 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								local var_191_4 = Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor2.r, var_191_3)
								local var_191_5 = Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor2.g, var_191_3)
								local var_191_6 = Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor2.b, var_191_3)

								iter_191_1.color = Color.New(var_191_4, var_191_5, var_191_6)
							else
								local var_191_7 = Mathf.Lerp(iter_191_1.color.r, 0.5, var_191_3)

								iter_191_1.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10128 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10128 = nil
			end

			local var_191_8 = 0
			local var_191_9 = 0.8

			if var_191_8 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_10 = arg_188_1:FormatText(StoryNameCfg[1144].name)

				arg_188_1.leftNameTxt_.text = var_191_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_11 = arg_188_1:GetWordFromCfg(417172045)
				local var_191_12 = arg_188_1:FormatText(var_191_11.content)

				arg_188_1.text_.text = var_191_12

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 32
				local var_191_14 = utf8.len(var_191_12)
				local var_191_15 = var_191_13 <= 0 and var_191_9 or var_191_9 * (var_191_14 / var_191_13)

				if var_191_15 > 0 and var_191_9 < var_191_15 then
					arg_188_1.talkMaxDuration = var_191_15

					if var_191_15 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_15 + var_191_8
					end
				end

				arg_188_1.text_.text = var_191_12
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172045", "story_v_out_417172.awb") ~= 0 then
					local var_191_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172045", "story_v_out_417172.awb") / 1000

					if var_191_16 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_16 + var_191_8
					end

					if var_191_11.prefab_name ~= "" and arg_188_1.actors_[var_191_11.prefab_name] ~= nil then
						local var_191_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_11.prefab_name].transform, "story_v_out_417172", "417172045", "story_v_out_417172.awb")

						arg_188_1:RecordAudio("417172045", var_191_17)
						arg_188_1:RecordAudio("417172045", var_191_17)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417172", "417172045", "story_v_out_417172.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417172", "417172045", "story_v_out_417172.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_18 = math.max(var_191_9, arg_188_1.talkMaxDuration)

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_18 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_8) / var_191_18

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_8 + var_191_18 and arg_188_1.time_ < var_191_8 + var_191_18 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play417172046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417172046
		arg_192_1.duration_ = 6.2

		local var_192_0 = {
			zh = 5.2,
			ja = 6.2
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play417172047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10128"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps10128 == nil then
				arg_192_1.var_.actorSpriteComps10128 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps10128 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								local var_195_4 = Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, var_195_3)
								local var_195_5 = Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, var_195_3)
								local var_195_6 = Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, var_195_3)

								iter_195_1.color = Color.New(var_195_4, var_195_5, var_195_6)
							else
								local var_195_7 = Mathf.Lerp(iter_195_1.color.r, 1, var_195_3)

								iter_195_1.color = Color.New(var_195_7, var_195_7, var_195_7)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps10128 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10128 = nil
			end

			local var_195_8 = 0
			local var_195_9 = 0.675

			if var_195_8 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_10 = arg_192_1:FormatText(StoryNameCfg[595].name)

				arg_192_1.leftNameTxt_.text = var_195_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_11 = arg_192_1:GetWordFromCfg(417172046)
				local var_195_12 = arg_192_1:FormatText(var_195_11.content)

				arg_192_1.text_.text = var_195_12

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_13 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172046", "story_v_out_417172.awb") ~= 0 then
					local var_195_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172046", "story_v_out_417172.awb") / 1000

					if var_195_16 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_16 + var_195_8
					end

					if var_195_11.prefab_name ~= "" and arg_192_1.actors_[var_195_11.prefab_name] ~= nil then
						local var_195_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_11.prefab_name].transform, "story_v_out_417172", "417172046", "story_v_out_417172.awb")

						arg_192_1:RecordAudio("417172046", var_195_17)
						arg_192_1:RecordAudio("417172046", var_195_17)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417172", "417172046", "story_v_out_417172.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417172", "417172046", "story_v_out_417172.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_18 = math.max(var_195_9, arg_192_1.talkMaxDuration)

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_18 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_8) / var_195_18

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_8 + var_195_18 and arg_192_1.time_ < var_195_8 + var_195_18 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play417172047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417172047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play417172048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10128"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos10128 = var_199_0.localPosition
				var_199_0.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10128", 7)

				local var_199_2 = var_199_0.childCount

				for iter_199_0 = 0, var_199_2 - 1 do
					local var_199_3 = var_199_0:GetChild(iter_199_0)

					if var_199_3.name == "" or not string.find(var_199_3.name, "split") then
						var_199_3.gameObject:SetActive(true)
					else
						var_199_3.gameObject:SetActive(false)
					end
				end
			end

			local var_199_4 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_4 then
				local var_199_5 = (arg_196_1.time_ - var_199_1) / var_199_4
				local var_199_6 = Vector3.New(0, -2000, -300)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10128, var_199_6, var_199_5)
			end

			if arg_196_1.time_ >= var_199_1 + var_199_4 and arg_196_1.time_ < var_199_1 + var_199_4 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_199_7 = 0
			local var_199_8 = 0.55

			if var_199_7 < arg_196_1.time_ and arg_196_1.time_ <= var_199_7 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_9 = arg_196_1:GetWordFromCfg(417172047)
				local var_199_10 = arg_196_1:FormatText(var_199_9.content)

				arg_196_1.text_.text = var_199_10

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 22
				local var_199_12 = utf8.len(var_199_10)
				local var_199_13 = var_199_11 <= 0 and var_199_8 or var_199_8 * (var_199_12 / var_199_11)

				if var_199_13 > 0 and var_199_8 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_7 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_7
					end
				end

				arg_196_1.text_.text = var_199_10
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_8, arg_196_1.talkMaxDuration)

			if var_199_7 <= arg_196_1.time_ and arg_196_1.time_ < var_199_7 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_7) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_7 + var_199_14 and arg_196_1.time_ < var_199_7 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
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

		arg_196_1:InitPlayNodeList()
	end,
	Play417172048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417172048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417172049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1.4

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(417172048)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 56
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play417172049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417172049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play417172050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 1.375

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_2 = arg_204_1:GetWordFromCfg(417172049)
				local var_207_3 = arg_204_1:FormatText(var_207_2.content)

				arg_204_1.text_.text = var_207_3

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 55
				local var_207_5 = utf8.len(var_207_3)
				local var_207_6 = var_207_4 <= 0 and var_207_1 or var_207_1 * (var_207_5 / var_207_4)

				if var_207_6 > 0 and var_207_1 < var_207_6 then
					arg_204_1.talkMaxDuration = var_207_6

					if var_207_6 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_6 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_3
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_7 and arg_204_1.time_ < var_207_0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play417172050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417172050
		arg_208_1.duration_ = 9

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play417172051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 4

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			local var_211_1 = 0.666666666666667

			if arg_208_1.time_ >= var_211_0 + var_211_1 and arg_208_1.time_ < var_211_0 + var_211_1 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			local var_211_2 = "ST17"

			if arg_208_1.bgs_[var_211_2] == nil then
				local var_211_3 = Object.Instantiate(arg_208_1.paintGo_)

				var_211_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_211_2)
				var_211_3.name = var_211_2
				var_211_3.transform.parent = arg_208_1.stage_.transform
				var_211_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_208_1.bgs_[var_211_2] = var_211_3
			end

			local var_211_4 = 2

			if var_211_4 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				local var_211_5 = manager.ui.mainCamera.transform.localPosition
				local var_211_6 = Vector3.New(0, 0, 10) + Vector3.New(var_211_5.x, var_211_5.y, 0)
				local var_211_7 = arg_208_1.bgs_.ST17

				var_211_7.transform.localPosition = var_211_6
				var_211_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_211_8 = var_211_7:GetComponent("SpriteRenderer")

				if var_211_8 and var_211_8.sprite then
					local var_211_9 = (var_211_7.transform.localPosition - var_211_5).z
					local var_211_10 = manager.ui.mainCameraCom_
					local var_211_11 = 2 * var_211_9 * Mathf.Tan(var_211_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_211_12 = var_211_11 * var_211_10.aspect
					local var_211_13 = var_211_8.sprite.bounds.size.x
					local var_211_14 = var_211_8.sprite.bounds.size.y
					local var_211_15 = var_211_12 / var_211_13
					local var_211_16 = var_211_11 / var_211_14
					local var_211_17 = var_211_16 < var_211_15 and var_211_15 or var_211_16

					var_211_7.transform.localScale = Vector3.New(var_211_17, var_211_17, 0)
				end

				for iter_211_0, iter_211_1 in pairs(arg_208_1.bgs_) do
					if iter_211_0 ~= "ST17" then
						iter_211_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_211_18 = 0

			if var_211_18 < arg_208_1.time_ and arg_208_1.time_ <= var_211_18 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_19 = 2

			if var_211_18 <= arg_208_1.time_ and arg_208_1.time_ < var_211_18 + var_211_19 then
				local var_211_20 = (arg_208_1.time_ - var_211_18) / var_211_19
				local var_211_21 = Color.New(0, 0, 0)

				var_211_21.a = Mathf.Lerp(0, 1, var_211_20)
				arg_208_1.mask_.color = var_211_21
			end

			if arg_208_1.time_ >= var_211_18 + var_211_19 and arg_208_1.time_ < var_211_18 + var_211_19 + arg_211_0 then
				local var_211_22 = Color.New(0, 0, 0)

				var_211_22.a = 1
				arg_208_1.mask_.color = var_211_22
			end

			local var_211_23 = 2

			if var_211_23 < arg_208_1.time_ and arg_208_1.time_ <= var_211_23 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_24 = 2

			if var_211_23 <= arg_208_1.time_ and arg_208_1.time_ < var_211_23 + var_211_24 then
				local var_211_25 = (arg_208_1.time_ - var_211_23) / var_211_24
				local var_211_26 = Color.New(0, 0, 0)

				var_211_26.a = Mathf.Lerp(1, 0, var_211_25)
				arg_208_1.mask_.color = var_211_26
			end

			if arg_208_1.time_ >= var_211_23 + var_211_24 and arg_208_1.time_ < var_211_23 + var_211_24 + arg_211_0 then
				local var_211_27 = Color.New(0, 0, 0)
				local var_211_28 = 0

				arg_208_1.mask_.enabled = false
				var_211_27.a = var_211_28
				arg_208_1.mask_.color = var_211_27
			end

			local var_211_29 = 4.93333333333333
			local var_211_30 = 1

			if var_211_29 < arg_208_1.time_ and arg_208_1.time_ <= var_211_29 + arg_211_0 then
				local var_211_31 = "play"
				local var_211_32 = "effect"

				arg_208_1:AudioAction(var_211_31, var_211_32, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_33 = 4
			local var_211_34 = 1.05

			if var_211_33 < arg_208_1.time_ and arg_208_1.time_ <= var_211_33 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_35 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_35:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_36 = arg_208_1:GetWordFromCfg(417172050)
				local var_211_37 = arg_208_1:FormatText(var_211_36.content)

				arg_208_1.text_.text = var_211_37

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_38 = 42
				local var_211_39 = utf8.len(var_211_37)
				local var_211_40 = var_211_38 <= 0 and var_211_34 or var_211_34 * (var_211_39 / var_211_38)

				if var_211_40 > 0 and var_211_34 < var_211_40 then
					arg_208_1.talkMaxDuration = var_211_40
					var_211_33 = var_211_33 + 0.3

					if var_211_40 + var_211_33 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_40 + var_211_33
					end
				end

				arg_208_1.text_.text = var_211_37
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_41 = var_211_33 + 0.3
			local var_211_42 = math.max(var_211_34, arg_208_1.talkMaxDuration)

			if var_211_41 <= arg_208_1.time_ and arg_208_1.time_ < var_211_41 + var_211_42 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_41) / var_211_42

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_41 + var_211_42 and arg_208_1.time_ < var_211_41 + var_211_42 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play417172051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417172051
		arg_214_1.duration_ = 5.7

		local var_214_0 = {
			zh = 3.7,
			ja = 5.7
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play417172052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.575

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[1110].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(417172051)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 21
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172051", "story_v_out_417172.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172051", "story_v_out_417172.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_417172", "417172051", "story_v_out_417172.awb")

						arg_214_1:RecordAudio("417172051", var_217_9)
						arg_214_1:RecordAudio("417172051", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417172", "417172051", "story_v_out_417172.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417172", "417172051", "story_v_out_417172.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417172052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417172052
		arg_218_1.duration_ = 7.57

		local var_218_0 = {
			zh = 5.933,
			ja = 7.566
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play417172053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.6

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[1110].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:GetWordFromCfg(417172052)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 24
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172052", "story_v_out_417172.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172052", "story_v_out_417172.awb") / 1000

					if var_221_8 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_0
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_417172", "417172052", "story_v_out_417172.awb")

						arg_218_1:RecordAudio("417172052", var_221_9)
						arg_218_1:RecordAudio("417172052", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417172", "417172052", "story_v_out_417172.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417172", "417172052", "story_v_out_417172.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_10 and arg_218_1.time_ < var_221_0 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play417172053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417172053
		arg_222_1.duration_ = 9.17

		local var_222_0 = {
			zh = 9.166,
			ja = 7.466
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play417172054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.825

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[1110].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(417172053)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 33
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172053", "story_v_out_417172.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172053", "story_v_out_417172.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_417172", "417172053", "story_v_out_417172.awb")

						arg_222_1:RecordAudio("417172053", var_225_9)
						arg_222_1:RecordAudio("417172053", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417172", "417172053", "story_v_out_417172.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417172", "417172053", "story_v_out_417172.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play417172054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417172054
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417172055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 1.75

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_2 = arg_226_1:GetWordFromCfg(417172054)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 70
				local var_229_5 = utf8.len(var_229_3)
				local var_229_6 = var_229_4 <= 0 and var_229_1 or var_229_1 * (var_229_5 / var_229_4)

				if var_229_6 > 0 and var_229_1 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_7 and arg_226_1.time_ < var_229_0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417172055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417172055
		arg_230_1.duration_ = 10.47

		local var_230_0 = {
			zh = 10.465999999999,
			ja = 10.132999999999
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417172056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 3.999999999999

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			local var_233_1 = 0.3

			if arg_230_1.time_ >= var_233_0 + var_233_1 and arg_230_1.time_ < var_233_0 + var_233_1 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			local var_233_2 = "ST73"

			if arg_230_1.bgs_[var_233_2] == nil then
				local var_233_3 = Object.Instantiate(arg_230_1.paintGo_)

				var_233_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_233_2)
				var_233_3.name = var_233_2
				var_233_3.transform.parent = arg_230_1.stage_.transform
				var_233_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.bgs_[var_233_2] = var_233_3
			end

			local var_233_4 = 1.999999999999

			if var_233_4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				local var_233_5 = manager.ui.mainCamera.transform.localPosition
				local var_233_6 = Vector3.New(0, 0, 10) + Vector3.New(var_233_5.x, var_233_5.y, 0)
				local var_233_7 = arg_230_1.bgs_.ST73

				var_233_7.transform.localPosition = var_233_6
				var_233_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_8 = var_233_7:GetComponent("SpriteRenderer")

				if var_233_8 and var_233_8.sprite then
					local var_233_9 = (var_233_7.transform.localPosition - var_233_5).z
					local var_233_10 = manager.ui.mainCameraCom_
					local var_233_11 = 2 * var_233_9 * Mathf.Tan(var_233_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_233_12 = var_233_11 * var_233_10.aspect
					local var_233_13 = var_233_8.sprite.bounds.size.x
					local var_233_14 = var_233_8.sprite.bounds.size.y
					local var_233_15 = var_233_12 / var_233_13
					local var_233_16 = var_233_11 / var_233_14
					local var_233_17 = var_233_16 < var_233_15 and var_233_15 or var_233_16

					var_233_7.transform.localScale = Vector3.New(var_233_17, var_233_17, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST73" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_18 = 0

			if var_233_18 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_19 = 2

			if var_233_18 <= arg_230_1.time_ and arg_230_1.time_ < var_233_18 + var_233_19 then
				local var_233_20 = (arg_230_1.time_ - var_233_18) / var_233_19
				local var_233_21 = Color.New(0, 0, 0)

				var_233_21.a = Mathf.Lerp(0, 1, var_233_20)
				arg_230_1.mask_.color = var_233_21
			end

			if arg_230_1.time_ >= var_233_18 + var_233_19 and arg_230_1.time_ < var_233_18 + var_233_19 + arg_233_0 then
				local var_233_22 = Color.New(0, 0, 0)

				var_233_22.a = 1
				arg_230_1.mask_.color = var_233_22
			end

			local var_233_23 = 1.999999999999

			if var_233_23 < arg_230_1.time_ and arg_230_1.time_ <= var_233_23 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_24 = 2

			if var_233_23 <= arg_230_1.time_ and arg_230_1.time_ < var_233_23 + var_233_24 then
				local var_233_25 = (arg_230_1.time_ - var_233_23) / var_233_24
				local var_233_26 = Color.New(0, 0, 0)

				var_233_26.a = Mathf.Lerp(1, 0, var_233_25)
				arg_230_1.mask_.color = var_233_26
			end

			if arg_230_1.time_ >= var_233_23 + var_233_24 and arg_230_1.time_ < var_233_23 + var_233_24 + arg_233_0 then
				local var_233_27 = Color.New(0, 0, 0)
				local var_233_28 = 0

				arg_230_1.mask_.enabled = false
				var_233_27.a = var_233_28
				arg_230_1.mask_.color = var_233_27
			end

			local var_233_29 = "10115"

			if arg_230_1.actors_[var_233_29] == nil then
				local var_233_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_233_30) then
					local var_233_31 = Object.Instantiate(var_233_30, arg_230_1.canvasGo_.transform)

					var_233_31.transform:SetSiblingIndex(1)

					var_233_31.name = var_233_29
					var_233_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_230_1.actors_[var_233_29] = var_233_31

					local var_233_32 = var_233_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_230_1.isInRecall_ then
						for iter_233_2, iter_233_3 in ipairs(var_233_32) do
							iter_233_3.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_233_33 = arg_230_1.actors_["10115"]
			local var_233_34 = 3.799999999999

			if var_233_34 < arg_230_1.time_ and arg_230_1.time_ <= var_233_34 + arg_233_0 and not isNil(var_233_33) and arg_230_1.var_.actorSpriteComps10115 == nil then
				arg_230_1.var_.actorSpriteComps10115 = var_233_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_35 = 0.2

			if var_233_34 <= arg_230_1.time_ and arg_230_1.time_ < var_233_34 + var_233_35 and not isNil(var_233_33) then
				local var_233_36 = (arg_230_1.time_ - var_233_34) / var_233_35

				if arg_230_1.var_.actorSpriteComps10115 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								local var_233_37 = Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor1.r, var_233_36)
								local var_233_38 = Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor1.g, var_233_36)
								local var_233_39 = Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor1.b, var_233_36)

								iter_233_5.color = Color.New(var_233_37, var_233_38, var_233_39)
							else
								local var_233_40 = Mathf.Lerp(iter_233_5.color.r, 1, var_233_36)

								iter_233_5.color = Color.New(var_233_40, var_233_40, var_233_40)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_34 + var_233_35 and arg_230_1.time_ < var_233_34 + var_233_35 + arg_233_0 and not isNil(var_233_33) and arg_230_1.var_.actorSpriteComps10115 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_233_7 then
						if arg_230_1.isInRecall_ then
							iter_233_7.color = arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_233_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10115 = nil
			end

			local var_233_41 = arg_230_1.actors_["10115"].transform
			local var_233_42 = 3.799999999999

			if var_233_42 < arg_230_1.time_ and arg_230_1.time_ <= var_233_42 + arg_233_0 then
				arg_230_1.var_.moveOldPos10115 = var_233_41.localPosition
				var_233_41.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10115", 3)

				local var_233_43 = var_233_41.childCount

				for iter_233_8 = 0, var_233_43 - 1 do
					local var_233_44 = var_233_41:GetChild(iter_233_8)

					if var_233_44.name == "split_1" or not string.find(var_233_44.name, "split") then
						var_233_44.gameObject:SetActive(true)
					else
						var_233_44.gameObject:SetActive(false)
					end
				end
			end

			local var_233_45 = 0.001

			if var_233_42 <= arg_230_1.time_ and arg_230_1.time_ < var_233_42 + var_233_45 then
				local var_233_46 = (arg_230_1.time_ - var_233_42) / var_233_45
				local var_233_47 = Vector3.New(0, -387.3, -246.2)

				var_233_41.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10115, var_233_47, var_233_46)
			end

			if arg_230_1.time_ >= var_233_42 + var_233_45 and arg_230_1.time_ < var_233_42 + var_233_45 + arg_233_0 then
				var_233_41.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_233_48 = 0
			local var_233_49 = 0.2

			if var_233_48 < arg_230_1.time_ and arg_230_1.time_ <= var_233_48 + arg_233_0 then
				local var_233_50 = "play"
				local var_233_51 = "music"

				arg_230_1:AudioAction(var_233_50, var_233_51, "ui_battle", "ui_battle_stopbgm", "")

				local var_233_52 = ""
				local var_233_53 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_233_53 ~= "" then
					if arg_230_1.bgmTxt_.text ~= var_233_53 and arg_230_1.bgmTxt_.text ~= "" then
						if arg_230_1.bgmTxt2_.text ~= "" then
							arg_230_1.bgmTxt_.text = arg_230_1.bgmTxt2_.text
						end

						arg_230_1.bgmTxt2_.text = var_233_53

						arg_230_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_230_1.bgmTxt_.text = var_233_53
						arg_230_1.bgmTxt2_.text = var_233_53
					end

					if arg_230_1.bgmTimer then
						arg_230_1.bgmTimer:Stop()

						arg_230_1.bgmTimer = nil
					end

					if arg_230_1.settingData.show_music_name == 1 then
						arg_230_1.musicController:SetSelectedState("show")
						arg_230_1.musicAnimator_:Play("open", 0, 0)

						if arg_230_1.settingData.music_time ~= 0 then
							arg_230_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_230_1.settingData.music_time), function()
								if arg_230_1 == nil or isNil(arg_230_1.bgmTxt_) then
									return
								end

								arg_230_1.musicController:SetSelectedState("hide")
								arg_230_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_233_54 = 0.5
			local var_233_55 = 1

			if var_233_54 < arg_230_1.time_ and arg_230_1.time_ <= var_233_54 + arg_233_0 then
				local var_233_56 = "play"
				local var_233_57 = "music"

				arg_230_1:AudioAction(var_233_56, var_233_57, "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_233_58 = ""
				local var_233_59 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if var_233_59 ~= "" then
					if arg_230_1.bgmTxt_.text ~= var_233_59 and arg_230_1.bgmTxt_.text ~= "" then
						if arg_230_1.bgmTxt2_.text ~= "" then
							arg_230_1.bgmTxt_.text = arg_230_1.bgmTxt2_.text
						end

						arg_230_1.bgmTxt2_.text = var_233_59

						arg_230_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_230_1.bgmTxt_.text = var_233_59
						arg_230_1.bgmTxt2_.text = var_233_59
					end

					if arg_230_1.bgmTimer then
						arg_230_1.bgmTimer:Stop()

						arg_230_1.bgmTimer = nil
					end

					if arg_230_1.settingData.show_music_name == 1 then
						arg_230_1.musicController:SetSelectedState("show")
						arg_230_1.musicAnimator_:Play("open", 0, 0)

						if arg_230_1.settingData.music_time ~= 0 then
							arg_230_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_230_1.settingData.music_time), function()
								if arg_230_1 == nil or isNil(arg_230_1.bgmTxt_) then
									return
								end

								arg_230_1.musicController:SetSelectedState("hide")
								arg_230_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_60 = 3.999999999999
			local var_233_61 = 0.75

			if var_233_60 < arg_230_1.time_ and arg_230_1.time_ <= var_233_60 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_62 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_62:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_230_1.dialogCg_.alpha = arg_236_0
				end))
				var_233_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_63 = arg_230_1:FormatText(StoryNameCfg[1113].name)

				arg_230_1.leftNameTxt_.text = var_233_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_64 = arg_230_1:GetWordFromCfg(417172055)
				local var_233_65 = arg_230_1:FormatText(var_233_64.content)

				arg_230_1.text_.text = var_233_65

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_66 = 30
				local var_233_67 = utf8.len(var_233_65)
				local var_233_68 = var_233_66 <= 0 and var_233_61 or var_233_61 * (var_233_67 / var_233_66)

				if var_233_68 > 0 and var_233_61 < var_233_68 then
					arg_230_1.talkMaxDuration = var_233_68
					var_233_60 = var_233_60 + 0.3

					if var_233_68 + var_233_60 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_68 + var_233_60
					end
				end

				arg_230_1.text_.text = var_233_65
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172055", "story_v_out_417172.awb") ~= 0 then
					local var_233_69 = manager.audio:GetVoiceLength("story_v_out_417172", "417172055", "story_v_out_417172.awb") / 1000

					if var_233_69 + var_233_60 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_69 + var_233_60
					end

					if var_233_64.prefab_name ~= "" and arg_230_1.actors_[var_233_64.prefab_name] ~= nil then
						local var_233_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_64.prefab_name].transform, "story_v_out_417172", "417172055", "story_v_out_417172.awb")

						arg_230_1:RecordAudio("417172055", var_233_70)
						arg_230_1:RecordAudio("417172055", var_233_70)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_417172", "417172055", "story_v_out_417172.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_417172", "417172055", "story_v_out_417172.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_71 = var_233_60 + 0.3
			local var_233_72 = math.max(var_233_61, arg_230_1.talkMaxDuration)

			if var_233_71 <= arg_230_1.time_ and arg_230_1.time_ < var_233_71 + var_233_72 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_71) / var_233_72

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_71 + var_233_72 and arg_230_1.time_ < var_233_71 + var_233_72 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.799999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play417172056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 417172056
		arg_238_1.duration_ = 5.63

		local var_238_0 = {
			zh = 3.8,
			ja = 5.633
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play417172057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.475

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[1113].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:GetWordFromCfg(417172056)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 19
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172056", "story_v_out_417172.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172056", "story_v_out_417172.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_417172", "417172056", "story_v_out_417172.awb")

						arg_238_1:RecordAudio("417172056", var_241_9)
						arg_238_1:RecordAudio("417172056", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_417172", "417172056", "story_v_out_417172.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_417172", "417172056", "story_v_out_417172.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play417172057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 417172057
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play417172058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10115"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos10115 = var_245_0.localPosition
				var_245_0.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10115", 7)

				local var_245_2 = var_245_0.childCount

				for iter_245_0 = 0, var_245_2 - 1 do
					local var_245_3 = var_245_0:GetChild(iter_245_0)

					if var_245_3.name == "" or not string.find(var_245_3.name, "split") then
						var_245_3.gameObject:SetActive(true)
					else
						var_245_3.gameObject:SetActive(false)
					end
				end
			end

			local var_245_4 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_4 then
				local var_245_5 = (arg_242_1.time_ - var_245_1) / var_245_4
				local var_245_6 = Vector3.New(0, -2000, 0)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10115, var_245_6, var_245_5)
			end

			if arg_242_1.time_ >= var_245_1 + var_245_4 and arg_242_1.time_ < var_245_1 + var_245_4 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_245_7 = 0
			local var_245_8 = 1

			if var_245_7 < arg_242_1.time_ and arg_242_1.time_ <= var_245_7 + arg_245_0 then
				local var_245_9 = "play"
				local var_245_10 = "effect"

				arg_242_1:AudioAction(var_245_9, var_245_10, "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_245_11 = 0
			local var_245_12 = 0.925

			if var_245_11 < arg_242_1.time_ and arg_242_1.time_ <= var_245_11 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_13 = arg_242_1:GetWordFromCfg(417172057)
				local var_245_14 = arg_242_1:FormatText(var_245_13.content)

				arg_242_1.text_.text = var_245_14

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_15 = 37
				local var_245_16 = utf8.len(var_245_14)
				local var_245_17 = var_245_15 <= 0 and var_245_12 or var_245_12 * (var_245_16 / var_245_15)

				if var_245_17 > 0 and var_245_12 < var_245_17 then
					arg_242_1.talkMaxDuration = var_245_17

					if var_245_17 + var_245_11 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_17 + var_245_11
					end
				end

				arg_242_1.text_.text = var_245_14
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_18 = math.max(var_245_12, arg_242_1.talkMaxDuration)

			if var_245_11 <= arg_242_1.time_ and arg_242_1.time_ < var_245_11 + var_245_18 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_11) / var_245_18

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_11 + var_245_18 and arg_242_1.time_ < var_245_11 + var_245_18 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play417172058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 417172058
		arg_246_1.duration_ = 2.2

		local var_246_0 = {
			zh = 1.2,
			ja = 2.2
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play417172059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = "10110"

			if arg_246_1.actors_[var_249_0] == nil then
				local var_249_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10110")

				if not isNil(var_249_1) then
					local var_249_2 = Object.Instantiate(var_249_1, arg_246_1.canvasGo_.transform)

					var_249_2.transform:SetSiblingIndex(1)

					var_249_2.name = var_249_0
					var_249_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_246_1.actors_[var_249_0] = var_249_2

					local var_249_3 = var_249_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_246_1.isInRecall_ then
						for iter_249_0, iter_249_1 in ipairs(var_249_3) do
							iter_249_1.color = arg_246_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_249_4 = arg_246_1.actors_["10110"]
			local var_249_5 = 0

			if var_249_5 < arg_246_1.time_ and arg_246_1.time_ <= var_249_5 + arg_249_0 and not isNil(var_249_4) and arg_246_1.var_.actorSpriteComps10110 == nil then
				arg_246_1.var_.actorSpriteComps10110 = var_249_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_6 = 0.2

			if var_249_5 <= arg_246_1.time_ and arg_246_1.time_ < var_249_5 + var_249_6 and not isNil(var_249_4) then
				local var_249_7 = (arg_246_1.time_ - var_249_5) / var_249_6

				if arg_246_1.var_.actorSpriteComps10110 then
					for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_249_3 then
							if arg_246_1.isInRecall_ then
								local var_249_8 = Mathf.Lerp(iter_249_3.color.r, arg_246_1.hightColor1.r, var_249_7)
								local var_249_9 = Mathf.Lerp(iter_249_3.color.g, arg_246_1.hightColor1.g, var_249_7)
								local var_249_10 = Mathf.Lerp(iter_249_3.color.b, arg_246_1.hightColor1.b, var_249_7)

								iter_249_3.color = Color.New(var_249_8, var_249_9, var_249_10)
							else
								local var_249_11 = Mathf.Lerp(iter_249_3.color.r, 1, var_249_7)

								iter_249_3.color = Color.New(var_249_11, var_249_11, var_249_11)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_5 + var_249_6 and arg_246_1.time_ < var_249_5 + var_249_6 + arg_249_0 and not isNil(var_249_4) and arg_246_1.var_.actorSpriteComps10110 then
				for iter_249_4, iter_249_5 in pairs(arg_246_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_249_5 then
						if arg_246_1.isInRecall_ then
							iter_249_5.color = arg_246_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_249_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps10110 = nil
			end

			local var_249_12 = 0
			local var_249_13 = 0.166666666666667

			if var_249_12 < arg_246_1.time_ and arg_246_1.time_ <= var_249_12 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_14 = arg_246_1:FormatText(StoryNameCfg[36].name)

				arg_246_1.leftNameTxt_.text = var_249_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_15 = arg_246_1:GetWordFromCfg(417172058)
				local var_249_16 = arg_246_1:FormatText(var_249_15.content)

				arg_246_1.text_.text = var_249_16

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_17 = 4
				local var_249_18 = utf8.len(var_249_16)
				local var_249_19 = var_249_17 <= 0 and var_249_13 or var_249_13 * (var_249_18 / var_249_17)

				if var_249_19 > 0 and var_249_13 < var_249_19 then
					arg_246_1.talkMaxDuration = var_249_19

					if var_249_19 + var_249_12 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_19 + var_249_12
					end
				end

				arg_246_1.text_.text = var_249_16
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172058", "story_v_out_417172.awb") ~= 0 then
					local var_249_20 = manager.audio:GetVoiceLength("story_v_out_417172", "417172058", "story_v_out_417172.awb") / 1000

					if var_249_20 + var_249_12 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_20 + var_249_12
					end

					if var_249_15.prefab_name ~= "" and arg_246_1.actors_[var_249_15.prefab_name] ~= nil then
						local var_249_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_15.prefab_name].transform, "story_v_out_417172", "417172058", "story_v_out_417172.awb")

						arg_246_1:RecordAudio("417172058", var_249_21)
						arg_246_1:RecordAudio("417172058", var_249_21)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_417172", "417172058", "story_v_out_417172.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_417172", "417172058", "story_v_out_417172.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_22 = math.max(var_249_13, arg_246_1.talkMaxDuration)

			if var_249_12 <= arg_246_1.time_ and arg_246_1.time_ < var_249_12 + var_249_22 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_12) / var_249_22

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_12 + var_249_22 and arg_246_1.time_ < var_249_12 + var_249_22 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play417172059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 417172059
		arg_250_1.duration_ = 5

		local var_250_0 = {
			zh = 3.8,
			ja = 5
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play417172060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10115"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps10115 == nil then
				arg_250_1.var_.actorSpriteComps10115 = var_253_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.actorSpriteComps10115 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								local var_253_4 = Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, var_253_3)
								local var_253_5 = Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, var_253_3)
								local var_253_6 = Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, var_253_3)

								iter_253_1.color = Color.New(var_253_4, var_253_5, var_253_6)
							else
								local var_253_7 = Mathf.Lerp(iter_253_1.color.r, 1, var_253_3)

								iter_253_1.color = Color.New(var_253_7, var_253_7, var_253_7)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps10115 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_253_3 then
						if arg_250_1.isInRecall_ then
							iter_253_3.color = arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_253_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps10115 = nil
			end

			local var_253_8 = arg_250_1.actors_["10115"].transform
			local var_253_9 = 0

			if var_253_9 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 then
				arg_250_1.var_.moveOldPos10115 = var_253_8.localPosition
				var_253_8.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10115", 3)

				local var_253_10 = var_253_8.childCount

				for iter_253_4 = 0, var_253_10 - 1 do
					local var_253_11 = var_253_8:GetChild(iter_253_4)

					if var_253_11.name == "split_1" or not string.find(var_253_11.name, "split") then
						var_253_11.gameObject:SetActive(true)
					else
						var_253_11.gameObject:SetActive(false)
					end
				end
			end

			local var_253_12 = 0.001

			if var_253_9 <= arg_250_1.time_ and arg_250_1.time_ < var_253_9 + var_253_12 then
				local var_253_13 = (arg_250_1.time_ - var_253_9) / var_253_12
				local var_253_14 = Vector3.New(0, -387.3, -246.2)

				var_253_8.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10115, var_253_14, var_253_13)
			end

			if arg_250_1.time_ >= var_253_9 + var_253_12 and arg_250_1.time_ < var_253_9 + var_253_12 + arg_253_0 then
				var_253_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_253_15 = 0
			local var_253_16 = 0.425

			if var_253_15 < arg_250_1.time_ and arg_250_1.time_ <= var_253_15 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_17 = arg_250_1:FormatText(StoryNameCfg[1113].name)

				arg_250_1.leftNameTxt_.text = var_253_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_18 = arg_250_1:GetWordFromCfg(417172059)
				local var_253_19 = arg_250_1:FormatText(var_253_18.content)

				arg_250_1.text_.text = var_253_19

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_20 = 17
				local var_253_21 = utf8.len(var_253_19)
				local var_253_22 = var_253_20 <= 0 and var_253_16 or var_253_16 * (var_253_21 / var_253_20)

				if var_253_22 > 0 and var_253_16 < var_253_22 then
					arg_250_1.talkMaxDuration = var_253_22

					if var_253_22 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_22 + var_253_15
					end
				end

				arg_250_1.text_.text = var_253_19
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172059", "story_v_out_417172.awb") ~= 0 then
					local var_253_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172059", "story_v_out_417172.awb") / 1000

					if var_253_23 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_15
					end

					if var_253_18.prefab_name ~= "" and arg_250_1.actors_[var_253_18.prefab_name] ~= nil then
						local var_253_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_18.prefab_name].transform, "story_v_out_417172", "417172059", "story_v_out_417172.awb")

						arg_250_1:RecordAudio("417172059", var_253_24)
						arg_250_1:RecordAudio("417172059", var_253_24)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_417172", "417172059", "story_v_out_417172.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_417172", "417172059", "story_v_out_417172.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_25 = math.max(var_253_16, arg_250_1.talkMaxDuration)

			if var_253_15 <= arg_250_1.time_ and arg_250_1.time_ < var_253_15 + var_253_25 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_15) / var_253_25

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_15 + var_253_25 and arg_250_1.time_ < var_253_15 + var_253_25 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play417172060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 417172060
		arg_254_1.duration_ = 8.47

		local var_254_0 = {
			zh = 5.2,
			ja = 8.466
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play417172061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10115"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps10115 == nil then
				arg_254_1.var_.actorSpriteComps10115 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps10115 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								local var_257_4 = Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor2.r, var_257_3)
								local var_257_5 = Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor2.g, var_257_3)
								local var_257_6 = Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor2.b, var_257_3)

								iter_257_1.color = Color.New(var_257_4, var_257_5, var_257_6)
							else
								local var_257_7 = Mathf.Lerp(iter_257_1.color.r, 0.5, var_257_3)

								iter_257_1.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps10115 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps10115 = nil
			end

			local var_257_8 = 0
			local var_257_9 = 0.475

			if var_257_8 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_10 = arg_254_1:FormatText(StoryNameCfg[36].name)

				arg_254_1.leftNameTxt_.text = var_257_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_11 = arg_254_1:GetWordFromCfg(417172060)
				local var_257_12 = arg_254_1:FormatText(var_257_11.content)

				arg_254_1.text_.text = var_257_12

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_13 = 19
				local var_257_14 = utf8.len(var_257_12)
				local var_257_15 = var_257_13 <= 0 and var_257_9 or var_257_9 * (var_257_14 / var_257_13)

				if var_257_15 > 0 and var_257_9 < var_257_15 then
					arg_254_1.talkMaxDuration = var_257_15

					if var_257_15 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_15 + var_257_8
					end
				end

				arg_254_1.text_.text = var_257_12
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172060", "story_v_out_417172.awb") ~= 0 then
					local var_257_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172060", "story_v_out_417172.awb") / 1000

					if var_257_16 + var_257_8 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_16 + var_257_8
					end

					if var_257_11.prefab_name ~= "" and arg_254_1.actors_[var_257_11.prefab_name] ~= nil then
						local var_257_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_11.prefab_name].transform, "story_v_out_417172", "417172060", "story_v_out_417172.awb")

						arg_254_1:RecordAudio("417172060", var_257_17)
						arg_254_1:RecordAudio("417172060", var_257_17)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_417172", "417172060", "story_v_out_417172.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_417172", "417172060", "story_v_out_417172.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_18 = math.max(var_257_9, arg_254_1.talkMaxDuration)

			if var_257_8 <= arg_254_1.time_ and arg_254_1.time_ < var_257_8 + var_257_18 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_8) / var_257_18

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_8 + var_257_18 and arg_254_1.time_ < var_257_8 + var_257_18 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play417172061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 417172061
		arg_258_1.duration_ = 7

		local var_258_0 = {
			zh = 3.833,
			ja = 7
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play417172062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10115"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps10115 == nil then
				arg_258_1.var_.actorSpriteComps10115 = var_261_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_2 = 0.2

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.actorSpriteComps10115 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								local var_261_4 = Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor1.r, var_261_3)
								local var_261_5 = Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor1.g, var_261_3)
								local var_261_6 = Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor1.b, var_261_3)

								iter_261_1.color = Color.New(var_261_4, var_261_5, var_261_6)
							else
								local var_261_7 = Mathf.Lerp(iter_261_1.color.r, 1, var_261_3)

								iter_261_1.color = Color.New(var_261_7, var_261_7, var_261_7)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps10115 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_261_3 then
						if arg_258_1.isInRecall_ then
							iter_261_3.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps10115 = nil
			end

			local var_261_8 = arg_258_1.actors_["10110"]
			local var_261_9 = 0

			if var_261_9 < arg_258_1.time_ and arg_258_1.time_ <= var_261_9 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.actorSpriteComps10110 == nil then
				arg_258_1.var_.actorSpriteComps10110 = var_261_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_10 = 0.2

			if var_261_9 <= arg_258_1.time_ and arg_258_1.time_ < var_261_9 + var_261_10 and not isNil(var_261_8) then
				local var_261_11 = (arg_258_1.time_ - var_261_9) / var_261_10

				if arg_258_1.var_.actorSpriteComps10110 then
					for iter_261_4, iter_261_5 in pairs(arg_258_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_261_5 then
							if arg_258_1.isInRecall_ then
								local var_261_12 = Mathf.Lerp(iter_261_5.color.r, arg_258_1.hightColor2.r, var_261_11)
								local var_261_13 = Mathf.Lerp(iter_261_5.color.g, arg_258_1.hightColor2.g, var_261_11)
								local var_261_14 = Mathf.Lerp(iter_261_5.color.b, arg_258_1.hightColor2.b, var_261_11)

								iter_261_5.color = Color.New(var_261_12, var_261_13, var_261_14)
							else
								local var_261_15 = Mathf.Lerp(iter_261_5.color.r, 0.5, var_261_11)

								iter_261_5.color = Color.New(var_261_15, var_261_15, var_261_15)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_9 + var_261_10 and arg_258_1.time_ < var_261_9 + var_261_10 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.actorSpriteComps10110 then
				for iter_261_6, iter_261_7 in pairs(arg_258_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_261_7 then
						if arg_258_1.isInRecall_ then
							iter_261_7.color = arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_261_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps10110 = nil
			end

			local var_261_16 = arg_258_1.actors_["10115"].transform
			local var_261_17 = 0

			if var_261_17 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 then
				arg_258_1.var_.moveOldPos10115 = var_261_16.localPosition
				var_261_16.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("10115", 3)

				local var_261_18 = var_261_16.childCount

				for iter_261_8 = 0, var_261_18 - 1 do
					local var_261_19 = var_261_16:GetChild(iter_261_8)

					if var_261_19.name == "split_6" or not string.find(var_261_19.name, "split") then
						var_261_19.gameObject:SetActive(true)
					else
						var_261_19.gameObject:SetActive(false)
					end
				end
			end

			local var_261_20 = 0.001

			if var_261_17 <= arg_258_1.time_ and arg_258_1.time_ < var_261_17 + var_261_20 then
				local var_261_21 = (arg_258_1.time_ - var_261_17) / var_261_20
				local var_261_22 = Vector3.New(0, -387.3, -246.2)

				var_261_16.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10115, var_261_22, var_261_21)
			end

			if arg_258_1.time_ >= var_261_17 + var_261_20 and arg_258_1.time_ < var_261_17 + var_261_20 + arg_261_0 then
				var_261_16.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_261_23 = 0
			local var_261_24 = 0.525

			if var_261_23 < arg_258_1.time_ and arg_258_1.time_ <= var_261_23 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_25 = arg_258_1:FormatText(StoryNameCfg[1113].name)

				arg_258_1.leftNameTxt_.text = var_261_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_26 = arg_258_1:GetWordFromCfg(417172061)
				local var_261_27 = arg_258_1:FormatText(var_261_26.content)

				arg_258_1.text_.text = var_261_27

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_28 = 21
				local var_261_29 = utf8.len(var_261_27)
				local var_261_30 = var_261_28 <= 0 and var_261_24 or var_261_24 * (var_261_29 / var_261_28)

				if var_261_30 > 0 and var_261_24 < var_261_30 then
					arg_258_1.talkMaxDuration = var_261_30

					if var_261_30 + var_261_23 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_30 + var_261_23
					end
				end

				arg_258_1.text_.text = var_261_27
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172061", "story_v_out_417172.awb") ~= 0 then
					local var_261_31 = manager.audio:GetVoiceLength("story_v_out_417172", "417172061", "story_v_out_417172.awb") / 1000

					if var_261_31 + var_261_23 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_31 + var_261_23
					end

					if var_261_26.prefab_name ~= "" and arg_258_1.actors_[var_261_26.prefab_name] ~= nil then
						local var_261_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_26.prefab_name].transform, "story_v_out_417172", "417172061", "story_v_out_417172.awb")

						arg_258_1:RecordAudio("417172061", var_261_32)
						arg_258_1:RecordAudio("417172061", var_261_32)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_417172", "417172061", "story_v_out_417172.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_417172", "417172061", "story_v_out_417172.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_33 = math.max(var_261_24, arg_258_1.talkMaxDuration)

			if var_261_23 <= arg_258_1.time_ and arg_258_1.time_ < var_261_23 + var_261_33 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_23) / var_261_33

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_23 + var_261_33 and arg_258_1.time_ < var_261_23 + var_261_33 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play417172062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 417172062
		arg_262_1.duration_ = 8.6

		local var_262_0 = {
			zh = 8.3,
			ja = 8.6
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play417172063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["10110"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps10110 == nil then
				arg_262_1.var_.actorSpriteComps10110 = var_265_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_2 = 0.2

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.actorSpriteComps10110 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								local var_265_4 = Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, var_265_3)
								local var_265_5 = Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, var_265_3)
								local var_265_6 = Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, var_265_3)

								iter_265_1.color = Color.New(var_265_4, var_265_5, var_265_6)
							else
								local var_265_7 = Mathf.Lerp(iter_265_1.color.r, 1, var_265_3)

								iter_265_1.color = Color.New(var_265_7, var_265_7, var_265_7)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps10110 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_265_3 then
						if arg_262_1.isInRecall_ then
							iter_265_3.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps10110 = nil
			end

			local var_265_8 = arg_262_1.actors_["10115"]
			local var_265_9 = 0

			if var_265_9 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps10115 == nil then
				arg_262_1.var_.actorSpriteComps10115 = var_265_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_10 = 0.2

			if var_265_9 <= arg_262_1.time_ and arg_262_1.time_ < var_265_9 + var_265_10 and not isNil(var_265_8) then
				local var_265_11 = (arg_262_1.time_ - var_265_9) / var_265_10

				if arg_262_1.var_.actorSpriteComps10115 then
					for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_265_5 then
							if arg_262_1.isInRecall_ then
								local var_265_12 = Mathf.Lerp(iter_265_5.color.r, arg_262_1.hightColor2.r, var_265_11)
								local var_265_13 = Mathf.Lerp(iter_265_5.color.g, arg_262_1.hightColor2.g, var_265_11)
								local var_265_14 = Mathf.Lerp(iter_265_5.color.b, arg_262_1.hightColor2.b, var_265_11)

								iter_265_5.color = Color.New(var_265_12, var_265_13, var_265_14)
							else
								local var_265_15 = Mathf.Lerp(iter_265_5.color.r, 0.5, var_265_11)

								iter_265_5.color = Color.New(var_265_15, var_265_15, var_265_15)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_9 + var_265_10 and arg_262_1.time_ < var_265_9 + var_265_10 + arg_265_0 and not isNil(var_265_8) and arg_262_1.var_.actorSpriteComps10115 then
				for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_265_7 then
						if arg_262_1.isInRecall_ then
							iter_265_7.color = arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_265_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps10115 = nil
			end

			local var_265_16 = 0
			local var_265_17 = 0.725

			if var_265_16 < arg_262_1.time_ and arg_262_1.time_ <= var_265_16 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_18 = arg_262_1:FormatText(StoryNameCfg[36].name)

				arg_262_1.leftNameTxt_.text = var_265_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_19 = arg_262_1:GetWordFromCfg(417172062)
				local var_265_20 = arg_262_1:FormatText(var_265_19.content)

				arg_262_1.text_.text = var_265_20

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_21 = 29
				local var_265_22 = utf8.len(var_265_20)
				local var_265_23 = var_265_21 <= 0 and var_265_17 or var_265_17 * (var_265_22 / var_265_21)

				if var_265_23 > 0 and var_265_17 < var_265_23 then
					arg_262_1.talkMaxDuration = var_265_23

					if var_265_23 + var_265_16 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_23 + var_265_16
					end
				end

				arg_262_1.text_.text = var_265_20
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172062", "story_v_out_417172.awb") ~= 0 then
					local var_265_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172062", "story_v_out_417172.awb") / 1000

					if var_265_24 + var_265_16 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_24 + var_265_16
					end

					if var_265_19.prefab_name ~= "" and arg_262_1.actors_[var_265_19.prefab_name] ~= nil then
						local var_265_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_19.prefab_name].transform, "story_v_out_417172", "417172062", "story_v_out_417172.awb")

						arg_262_1:RecordAudio("417172062", var_265_25)
						arg_262_1:RecordAudio("417172062", var_265_25)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_417172", "417172062", "story_v_out_417172.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_417172", "417172062", "story_v_out_417172.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_26 = math.max(var_265_17, arg_262_1.talkMaxDuration)

			if var_265_16 <= arg_262_1.time_ and arg_262_1.time_ < var_265_16 + var_265_26 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_16) / var_265_26

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_16 + var_265_26 and arg_262_1.time_ < var_265_16 + var_265_26 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play417172063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 417172063
		arg_266_1.duration_ = 11.93

		local var_266_0 = {
			zh = 11.933,
			ja = 10.566
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play417172064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 1.125

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[36].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(417172063)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 45
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172063", "story_v_out_417172.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172063", "story_v_out_417172.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_417172", "417172063", "story_v_out_417172.awb")

						arg_266_1:RecordAudio("417172063", var_269_9)
						arg_266_1:RecordAudio("417172063", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_417172", "417172063", "story_v_out_417172.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_417172", "417172063", "story_v_out_417172.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play417172064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417172064
		arg_270_1.duration_ = 11.83

		local var_270_0 = {
			zh = 11.833,
			ja = 11.733
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play417172065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 1.15

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[36].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(417172064)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 46
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172064", "story_v_out_417172.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172064", "story_v_out_417172.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_417172", "417172064", "story_v_out_417172.awb")

						arg_270_1:RecordAudio("417172064", var_273_9)
						arg_270_1:RecordAudio("417172064", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417172", "417172064", "story_v_out_417172.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417172", "417172064", "story_v_out_417172.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_10 and arg_270_1.time_ < var_273_0 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play417172065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 417172065
		arg_274_1.duration_ = 10.07

		local var_274_0 = {
			zh = 10.066,
			ja = 8.9
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play417172066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.875

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[36].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(417172065)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 35
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172065", "story_v_out_417172.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172065", "story_v_out_417172.awb") / 1000

					if var_277_8 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_0
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_out_417172", "417172065", "story_v_out_417172.awb")

						arg_274_1:RecordAudio("417172065", var_277_9)
						arg_274_1:RecordAudio("417172065", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_417172", "417172065", "story_v_out_417172.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_417172", "417172065", "story_v_out_417172.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_10 and arg_274_1.time_ < var_277_0 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play417172066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417172066
		arg_278_1.duration_ = 10.47

		local var_278_0 = {
			zh = 6.6,
			ja = 10.466
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play417172067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["10115"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps10115 == nil then
				arg_278_1.var_.actorSpriteComps10115 = var_281_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_2 = 0.2

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.actorSpriteComps10115 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								local var_281_4 = Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor1.r, var_281_3)
								local var_281_5 = Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor1.g, var_281_3)
								local var_281_6 = Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor1.b, var_281_3)

								iter_281_1.color = Color.New(var_281_4, var_281_5, var_281_6)
							else
								local var_281_7 = Mathf.Lerp(iter_281_1.color.r, 1, var_281_3)

								iter_281_1.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps10115 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_281_3 then
						if arg_278_1.isInRecall_ then
							iter_281_3.color = arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_281_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps10115 = nil
			end

			local var_281_8 = arg_278_1.actors_["10110"]
			local var_281_9 = 0

			if var_281_9 < arg_278_1.time_ and arg_278_1.time_ <= var_281_9 + arg_281_0 and not isNil(var_281_8) and arg_278_1.var_.actorSpriteComps10110 == nil then
				arg_278_1.var_.actorSpriteComps10110 = var_281_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_10 = 0.2

			if var_281_9 <= arg_278_1.time_ and arg_278_1.time_ < var_281_9 + var_281_10 and not isNil(var_281_8) then
				local var_281_11 = (arg_278_1.time_ - var_281_9) / var_281_10

				if arg_278_1.var_.actorSpriteComps10110 then
					for iter_281_4, iter_281_5 in pairs(arg_278_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_281_5 then
							if arg_278_1.isInRecall_ then
								local var_281_12 = Mathf.Lerp(iter_281_5.color.r, arg_278_1.hightColor2.r, var_281_11)
								local var_281_13 = Mathf.Lerp(iter_281_5.color.g, arg_278_1.hightColor2.g, var_281_11)
								local var_281_14 = Mathf.Lerp(iter_281_5.color.b, arg_278_1.hightColor2.b, var_281_11)

								iter_281_5.color = Color.New(var_281_12, var_281_13, var_281_14)
							else
								local var_281_15 = Mathf.Lerp(iter_281_5.color.r, 0.5, var_281_11)

								iter_281_5.color = Color.New(var_281_15, var_281_15, var_281_15)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_9 + var_281_10 and arg_278_1.time_ < var_281_9 + var_281_10 + arg_281_0 and not isNil(var_281_8) and arg_278_1.var_.actorSpriteComps10110 then
				for iter_281_6, iter_281_7 in pairs(arg_278_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_281_7 then
						if arg_278_1.isInRecall_ then
							iter_281_7.color = arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_281_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps10110 = nil
			end

			local var_281_16 = arg_278_1.actors_["10115"].transform
			local var_281_17 = 0

			if var_281_17 < arg_278_1.time_ and arg_278_1.time_ <= var_281_17 + arg_281_0 then
				arg_278_1.var_.moveOldPos10115 = var_281_16.localPosition
				var_281_16.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10115", 3)

				local var_281_18 = var_281_16.childCount

				for iter_281_8 = 0, var_281_18 - 1 do
					local var_281_19 = var_281_16:GetChild(iter_281_8)

					if var_281_19.name == "split_2" or not string.find(var_281_19.name, "split") then
						var_281_19.gameObject:SetActive(true)
					else
						var_281_19.gameObject:SetActive(false)
					end
				end
			end

			local var_281_20 = 0.001

			if var_281_17 <= arg_278_1.time_ and arg_278_1.time_ < var_281_17 + var_281_20 then
				local var_281_21 = (arg_278_1.time_ - var_281_17) / var_281_20
				local var_281_22 = Vector3.New(0, -387.3, -246.2)

				var_281_16.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10115, var_281_22, var_281_21)
			end

			if arg_278_1.time_ >= var_281_17 + var_281_20 and arg_278_1.time_ < var_281_17 + var_281_20 + arg_281_0 then
				var_281_16.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_281_23 = 0
			local var_281_24 = 0.75

			if var_281_23 < arg_278_1.time_ and arg_278_1.time_ <= var_281_23 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_25 = arg_278_1:FormatText(StoryNameCfg[1113].name)

				arg_278_1.leftNameTxt_.text = var_281_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_26 = arg_278_1:GetWordFromCfg(417172066)
				local var_281_27 = arg_278_1:FormatText(var_281_26.content)

				arg_278_1.text_.text = var_281_27

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_28 = 30
				local var_281_29 = utf8.len(var_281_27)
				local var_281_30 = var_281_28 <= 0 and var_281_24 or var_281_24 * (var_281_29 / var_281_28)

				if var_281_30 > 0 and var_281_24 < var_281_30 then
					arg_278_1.talkMaxDuration = var_281_30

					if var_281_30 + var_281_23 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_30 + var_281_23
					end
				end

				arg_278_1.text_.text = var_281_27
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172066", "story_v_out_417172.awb") ~= 0 then
					local var_281_31 = manager.audio:GetVoiceLength("story_v_out_417172", "417172066", "story_v_out_417172.awb") / 1000

					if var_281_31 + var_281_23 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_31 + var_281_23
					end

					if var_281_26.prefab_name ~= "" and arg_278_1.actors_[var_281_26.prefab_name] ~= nil then
						local var_281_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_26.prefab_name].transform, "story_v_out_417172", "417172066", "story_v_out_417172.awb")

						arg_278_1:RecordAudio("417172066", var_281_32)
						arg_278_1:RecordAudio("417172066", var_281_32)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_417172", "417172066", "story_v_out_417172.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_417172", "417172066", "story_v_out_417172.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_33 = math.max(var_281_24, arg_278_1.talkMaxDuration)

			if var_281_23 <= arg_278_1.time_ and arg_278_1.time_ < var_281_23 + var_281_33 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_23) / var_281_33

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_23 + var_281_33 and arg_278_1.time_ < var_281_23 + var_281_33 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play417172067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 417172067
		arg_282_1.duration_ = 8.57

		local var_282_0 = {
			zh = 8.566,
			ja = 8.533
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play417172068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10110"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps10110 == nil then
				arg_282_1.var_.actorSpriteComps10110 = var_285_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_2 = 0.2

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.actorSpriteComps10110 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								local var_285_4 = Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor1.r, var_285_3)
								local var_285_5 = Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor1.g, var_285_3)
								local var_285_6 = Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor1.b, var_285_3)

								iter_285_1.color = Color.New(var_285_4, var_285_5, var_285_6)
							else
								local var_285_7 = Mathf.Lerp(iter_285_1.color.r, 1, var_285_3)

								iter_285_1.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps10110 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_285_3 then
						if arg_282_1.isInRecall_ then
							iter_285_3.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps10110 = nil
			end

			local var_285_8 = arg_282_1.actors_["10115"]
			local var_285_9 = 0

			if var_285_9 < arg_282_1.time_ and arg_282_1.time_ <= var_285_9 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps10115 == nil then
				arg_282_1.var_.actorSpriteComps10115 = var_285_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_10 = 0.2

			if var_285_9 <= arg_282_1.time_ and arg_282_1.time_ < var_285_9 + var_285_10 and not isNil(var_285_8) then
				local var_285_11 = (arg_282_1.time_ - var_285_9) / var_285_10

				if arg_282_1.var_.actorSpriteComps10115 then
					for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_285_5 then
							if arg_282_1.isInRecall_ then
								local var_285_12 = Mathf.Lerp(iter_285_5.color.r, arg_282_1.hightColor2.r, var_285_11)
								local var_285_13 = Mathf.Lerp(iter_285_5.color.g, arg_282_1.hightColor2.g, var_285_11)
								local var_285_14 = Mathf.Lerp(iter_285_5.color.b, arg_282_1.hightColor2.b, var_285_11)

								iter_285_5.color = Color.New(var_285_12, var_285_13, var_285_14)
							else
								local var_285_15 = Mathf.Lerp(iter_285_5.color.r, 0.5, var_285_11)

								iter_285_5.color = Color.New(var_285_15, var_285_15, var_285_15)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_9 + var_285_10 and arg_282_1.time_ < var_285_9 + var_285_10 + arg_285_0 and not isNil(var_285_8) and arg_282_1.var_.actorSpriteComps10115 then
				for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_285_7 then
						if arg_282_1.isInRecall_ then
							iter_285_7.color = arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_285_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps10115 = nil
			end

			local var_285_16 = 0
			local var_285_17 = 0.775

			if var_285_16 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_18 = arg_282_1:FormatText(StoryNameCfg[36].name)

				arg_282_1.leftNameTxt_.text = var_285_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_19 = arg_282_1:GetWordFromCfg(417172067)
				local var_285_20 = arg_282_1:FormatText(var_285_19.content)

				arg_282_1.text_.text = var_285_20

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_21 = 31
				local var_285_22 = utf8.len(var_285_20)
				local var_285_23 = var_285_21 <= 0 and var_285_17 or var_285_17 * (var_285_22 / var_285_21)

				if var_285_23 > 0 and var_285_17 < var_285_23 then
					arg_282_1.talkMaxDuration = var_285_23

					if var_285_23 + var_285_16 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_16
					end
				end

				arg_282_1.text_.text = var_285_20
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172067", "story_v_out_417172.awb") ~= 0 then
					local var_285_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172067", "story_v_out_417172.awb") / 1000

					if var_285_24 + var_285_16 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_24 + var_285_16
					end

					if var_285_19.prefab_name ~= "" and arg_282_1.actors_[var_285_19.prefab_name] ~= nil then
						local var_285_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_19.prefab_name].transform, "story_v_out_417172", "417172067", "story_v_out_417172.awb")

						arg_282_1:RecordAudio("417172067", var_285_25)
						arg_282_1:RecordAudio("417172067", var_285_25)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_417172", "417172067", "story_v_out_417172.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_417172", "417172067", "story_v_out_417172.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_26 = math.max(var_285_17, arg_282_1.talkMaxDuration)

			if var_285_16 <= arg_282_1.time_ and arg_282_1.time_ < var_285_16 + var_285_26 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_16) / var_285_26

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_16 + var_285_26 and arg_282_1.time_ < var_285_16 + var_285_26 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play417172068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 417172068
		arg_286_1.duration_ = 11.43

		local var_286_0 = {
			zh = 7.666,
			ja = 11.433
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play417172069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.775

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[36].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(417172068)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 31
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172068", "story_v_out_417172.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172068", "story_v_out_417172.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_417172", "417172068", "story_v_out_417172.awb")

						arg_286_1:RecordAudio("417172068", var_289_9)
						arg_286_1:RecordAudio("417172068", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_417172", "417172068", "story_v_out_417172.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_417172", "417172068", "story_v_out_417172.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play417172069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 417172069
		arg_290_1.duration_ = 10.03

		local var_290_0 = {
			zh = 10.033,
			ja = 8.766
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play417172070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 1.075

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[36].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(417172069)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172069", "story_v_out_417172.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172069", "story_v_out_417172.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_417172", "417172069", "story_v_out_417172.awb")

						arg_290_1:RecordAudio("417172069", var_293_9)
						arg_290_1:RecordAudio("417172069", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_417172", "417172069", "story_v_out_417172.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_417172", "417172069", "story_v_out_417172.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play417172070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 417172070
		arg_294_1.duration_ = 14.5

		local var_294_0 = {
			zh = 14.5,
			ja = 13.4
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play417172071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 1.275

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[36].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:GetWordFromCfg(417172070)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172070", "story_v_out_417172.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172070", "story_v_out_417172.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_417172", "417172070", "story_v_out_417172.awb")

						arg_294_1:RecordAudio("417172070", var_297_9)
						arg_294_1:RecordAudio("417172070", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_417172", "417172070", "story_v_out_417172.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_417172", "417172070", "story_v_out_417172.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_10 and arg_294_1.time_ < var_297_0 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play417172071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 417172071
		arg_298_1.duration_ = 3.37

		local var_298_0 = {
			zh = 2.233,
			ja = 3.366
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play417172072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["10115"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps10115 == nil then
				arg_298_1.var_.actorSpriteComps10115 = var_301_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_2 = 0.2

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.actorSpriteComps10115 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								local var_301_4 = Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor1.r, var_301_3)
								local var_301_5 = Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor1.g, var_301_3)
								local var_301_6 = Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor1.b, var_301_3)

								iter_301_1.color = Color.New(var_301_4, var_301_5, var_301_6)
							else
								local var_301_7 = Mathf.Lerp(iter_301_1.color.r, 1, var_301_3)

								iter_301_1.color = Color.New(var_301_7, var_301_7, var_301_7)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps10115 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_301_3 then
						if arg_298_1.isInRecall_ then
							iter_301_3.color = arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_301_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps10115 = nil
			end

			local var_301_8 = arg_298_1.actors_["10110"]
			local var_301_9 = 0

			if var_301_9 < arg_298_1.time_ and arg_298_1.time_ <= var_301_9 + arg_301_0 and not isNil(var_301_8) and arg_298_1.var_.actorSpriteComps10110 == nil then
				arg_298_1.var_.actorSpriteComps10110 = var_301_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_10 = 0.2

			if var_301_9 <= arg_298_1.time_ and arg_298_1.time_ < var_301_9 + var_301_10 and not isNil(var_301_8) then
				local var_301_11 = (arg_298_1.time_ - var_301_9) / var_301_10

				if arg_298_1.var_.actorSpriteComps10110 then
					for iter_301_4, iter_301_5 in pairs(arg_298_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_301_5 then
							if arg_298_1.isInRecall_ then
								local var_301_12 = Mathf.Lerp(iter_301_5.color.r, arg_298_1.hightColor2.r, var_301_11)
								local var_301_13 = Mathf.Lerp(iter_301_5.color.g, arg_298_1.hightColor2.g, var_301_11)
								local var_301_14 = Mathf.Lerp(iter_301_5.color.b, arg_298_1.hightColor2.b, var_301_11)

								iter_301_5.color = Color.New(var_301_12, var_301_13, var_301_14)
							else
								local var_301_15 = Mathf.Lerp(iter_301_5.color.r, 0.5, var_301_11)

								iter_301_5.color = Color.New(var_301_15, var_301_15, var_301_15)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_9 + var_301_10 and arg_298_1.time_ < var_301_9 + var_301_10 + arg_301_0 and not isNil(var_301_8) and arg_298_1.var_.actorSpriteComps10110 then
				for iter_301_6, iter_301_7 in pairs(arg_298_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_301_7 then
						if arg_298_1.isInRecall_ then
							iter_301_7.color = arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_301_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps10110 = nil
			end

			local var_301_16 = arg_298_1.actors_["10115"].transform
			local var_301_17 = 0

			if var_301_17 < arg_298_1.time_ and arg_298_1.time_ <= var_301_17 + arg_301_0 then
				arg_298_1.var_.moveOldPos10115 = var_301_16.localPosition
				var_301_16.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("10115", 3)

				local var_301_18 = var_301_16.childCount

				for iter_301_8 = 0, var_301_18 - 1 do
					local var_301_19 = var_301_16:GetChild(iter_301_8)

					if var_301_19.name == "split_6" or not string.find(var_301_19.name, "split") then
						var_301_19.gameObject:SetActive(true)
					else
						var_301_19.gameObject:SetActive(false)
					end
				end
			end

			local var_301_20 = 0.001

			if var_301_17 <= arg_298_1.time_ and arg_298_1.time_ < var_301_17 + var_301_20 then
				local var_301_21 = (arg_298_1.time_ - var_301_17) / var_301_20
				local var_301_22 = Vector3.New(0, -387.3, -246.2)

				var_301_16.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10115, var_301_22, var_301_21)
			end

			if arg_298_1.time_ >= var_301_17 + var_301_20 and arg_298_1.time_ < var_301_17 + var_301_20 + arg_301_0 then
				var_301_16.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_301_23 = 0
			local var_301_24 = 0.3

			if var_301_23 < arg_298_1.time_ and arg_298_1.time_ <= var_301_23 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_25 = arg_298_1:FormatText(StoryNameCfg[1113].name)

				arg_298_1.leftNameTxt_.text = var_301_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_26 = arg_298_1:GetWordFromCfg(417172071)
				local var_301_27 = arg_298_1:FormatText(var_301_26.content)

				arg_298_1.text_.text = var_301_27

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_28 = 12
				local var_301_29 = utf8.len(var_301_27)
				local var_301_30 = var_301_28 <= 0 and var_301_24 or var_301_24 * (var_301_29 / var_301_28)

				if var_301_30 > 0 and var_301_24 < var_301_30 then
					arg_298_1.talkMaxDuration = var_301_30

					if var_301_30 + var_301_23 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_30 + var_301_23
					end
				end

				arg_298_1.text_.text = var_301_27
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172071", "story_v_out_417172.awb") ~= 0 then
					local var_301_31 = manager.audio:GetVoiceLength("story_v_out_417172", "417172071", "story_v_out_417172.awb") / 1000

					if var_301_31 + var_301_23 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_31 + var_301_23
					end

					if var_301_26.prefab_name ~= "" and arg_298_1.actors_[var_301_26.prefab_name] ~= nil then
						local var_301_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_26.prefab_name].transform, "story_v_out_417172", "417172071", "story_v_out_417172.awb")

						arg_298_1:RecordAudio("417172071", var_301_32)
						arg_298_1:RecordAudio("417172071", var_301_32)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_417172", "417172071", "story_v_out_417172.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_417172", "417172071", "story_v_out_417172.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_33 = math.max(var_301_24, arg_298_1.talkMaxDuration)

			if var_301_23 <= arg_298_1.time_ and arg_298_1.time_ < var_301_23 + var_301_33 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_23) / var_301_33

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_23 + var_301_33 and arg_298_1.time_ < var_301_23 + var_301_33 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play417172072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 417172072
		arg_302_1.duration_ = 6.47

		local var_302_0 = {
			zh = 5.5,
			ja = 6.466
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play417172073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["10110"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps10110 == nil then
				arg_302_1.var_.actorSpriteComps10110 = var_305_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_2 = 0.2

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.actorSpriteComps10110 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								local var_305_4 = Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, var_305_3)
								local var_305_5 = Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, var_305_3)
								local var_305_6 = Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, var_305_3)

								iter_305_1.color = Color.New(var_305_4, var_305_5, var_305_6)
							else
								local var_305_7 = Mathf.Lerp(iter_305_1.color.r, 1, var_305_3)

								iter_305_1.color = Color.New(var_305_7, var_305_7, var_305_7)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps10110 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_305_3 then
						if arg_302_1.isInRecall_ then
							iter_305_3.color = arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_305_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps10110 = nil
			end

			local var_305_8 = arg_302_1.actors_["10115"]
			local var_305_9 = 0

			if var_305_9 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 and not isNil(var_305_8) and arg_302_1.var_.actorSpriteComps10115 == nil then
				arg_302_1.var_.actorSpriteComps10115 = var_305_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_10 = 0.2

			if var_305_9 <= arg_302_1.time_ and arg_302_1.time_ < var_305_9 + var_305_10 and not isNil(var_305_8) then
				local var_305_11 = (arg_302_1.time_ - var_305_9) / var_305_10

				if arg_302_1.var_.actorSpriteComps10115 then
					for iter_305_4, iter_305_5 in pairs(arg_302_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_305_5 then
							if arg_302_1.isInRecall_ then
								local var_305_12 = Mathf.Lerp(iter_305_5.color.r, arg_302_1.hightColor2.r, var_305_11)
								local var_305_13 = Mathf.Lerp(iter_305_5.color.g, arg_302_1.hightColor2.g, var_305_11)
								local var_305_14 = Mathf.Lerp(iter_305_5.color.b, arg_302_1.hightColor2.b, var_305_11)

								iter_305_5.color = Color.New(var_305_12, var_305_13, var_305_14)
							else
								local var_305_15 = Mathf.Lerp(iter_305_5.color.r, 0.5, var_305_11)

								iter_305_5.color = Color.New(var_305_15, var_305_15, var_305_15)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_9 + var_305_10 and arg_302_1.time_ < var_305_9 + var_305_10 + arg_305_0 and not isNil(var_305_8) and arg_302_1.var_.actorSpriteComps10115 then
				for iter_305_6, iter_305_7 in pairs(arg_302_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_305_7 then
						if arg_302_1.isInRecall_ then
							iter_305_7.color = arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_305_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps10115 = nil
			end

			local var_305_16 = 0
			local var_305_17 = 0.4

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_18 = arg_302_1:FormatText(StoryNameCfg[36].name)

				arg_302_1.leftNameTxt_.text = var_305_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_19 = arg_302_1:GetWordFromCfg(417172072)
				local var_305_20 = arg_302_1:FormatText(var_305_19.content)

				arg_302_1.text_.text = var_305_20

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_21 = 16
				local var_305_22 = utf8.len(var_305_20)
				local var_305_23 = var_305_21 <= 0 and var_305_17 or var_305_17 * (var_305_22 / var_305_21)

				if var_305_23 > 0 and var_305_17 < var_305_23 then
					arg_302_1.talkMaxDuration = var_305_23

					if var_305_23 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_23 + var_305_16
					end
				end

				arg_302_1.text_.text = var_305_20
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172072", "story_v_out_417172.awb") ~= 0 then
					local var_305_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172072", "story_v_out_417172.awb") / 1000

					if var_305_24 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_24 + var_305_16
					end

					if var_305_19.prefab_name ~= "" and arg_302_1.actors_[var_305_19.prefab_name] ~= nil then
						local var_305_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_19.prefab_name].transform, "story_v_out_417172", "417172072", "story_v_out_417172.awb")

						arg_302_1:RecordAudio("417172072", var_305_25)
						arg_302_1:RecordAudio("417172072", var_305_25)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_417172", "417172072", "story_v_out_417172.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_417172", "417172072", "story_v_out_417172.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_26 = math.max(var_305_17, arg_302_1.talkMaxDuration)

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_26 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_16) / var_305_26

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_16 + var_305_26 and arg_302_1.time_ < var_305_16 + var_305_26 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play417172073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417172073
		arg_306_1.duration_ = 3.6

		local var_306_0 = {
			zh = 2.1,
			ja = 3.6
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play417172074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["10115"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps10115 == nil then
				arg_306_1.var_.actorSpriteComps10115 = var_309_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_2 = 0.2

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.actorSpriteComps10115 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								local var_309_4 = Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, var_309_3)
								local var_309_5 = Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, var_309_3)
								local var_309_6 = Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, var_309_3)

								iter_309_1.color = Color.New(var_309_4, var_309_5, var_309_6)
							else
								local var_309_7 = Mathf.Lerp(iter_309_1.color.r, 1, var_309_3)

								iter_309_1.color = Color.New(var_309_7, var_309_7, var_309_7)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.actorSpriteComps10115 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_309_3 then
						if arg_306_1.isInRecall_ then
							iter_309_3.color = arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_309_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps10115 = nil
			end

			local var_309_8 = arg_306_1.actors_["10110"]
			local var_309_9 = 0

			if var_309_9 < arg_306_1.time_ and arg_306_1.time_ <= var_309_9 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.actorSpriteComps10110 == nil then
				arg_306_1.var_.actorSpriteComps10110 = var_309_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_10 = 0.2

			if var_309_9 <= arg_306_1.time_ and arg_306_1.time_ < var_309_9 + var_309_10 and not isNil(var_309_8) then
				local var_309_11 = (arg_306_1.time_ - var_309_9) / var_309_10

				if arg_306_1.var_.actorSpriteComps10110 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								local var_309_12 = Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor2.r, var_309_11)
								local var_309_13 = Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor2.g, var_309_11)
								local var_309_14 = Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor2.b, var_309_11)

								iter_309_5.color = Color.New(var_309_12, var_309_13, var_309_14)
							else
								local var_309_15 = Mathf.Lerp(iter_309_5.color.r, 0.5, var_309_11)

								iter_309_5.color = Color.New(var_309_15, var_309_15, var_309_15)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= var_309_9 + var_309_10 and arg_306_1.time_ < var_309_9 + var_309_10 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.actorSpriteComps10110 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_309_7 then
						if arg_306_1.isInRecall_ then
							iter_309_7.color = arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_309_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_306_1.var_.actorSpriteComps10110 = nil
			end

			local var_309_16 = 0
			local var_309_17 = 0.275

			if var_309_16 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_18 = arg_306_1:FormatText(StoryNameCfg[1113].name)

				arg_306_1.leftNameTxt_.text = var_309_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_19 = arg_306_1:GetWordFromCfg(417172073)
				local var_309_20 = arg_306_1:FormatText(var_309_19.content)

				arg_306_1.text_.text = var_309_20

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_21 = 11
				local var_309_22 = utf8.len(var_309_20)
				local var_309_23 = var_309_21 <= 0 and var_309_17 or var_309_17 * (var_309_22 / var_309_21)

				if var_309_23 > 0 and var_309_17 < var_309_23 then
					arg_306_1.talkMaxDuration = var_309_23

					if var_309_23 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_23 + var_309_16
					end
				end

				arg_306_1.text_.text = var_309_20
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172073", "story_v_out_417172.awb") ~= 0 then
					local var_309_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172073", "story_v_out_417172.awb") / 1000

					if var_309_24 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_24 + var_309_16
					end

					if var_309_19.prefab_name ~= "" and arg_306_1.actors_[var_309_19.prefab_name] ~= nil then
						local var_309_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_19.prefab_name].transform, "story_v_out_417172", "417172073", "story_v_out_417172.awb")

						arg_306_1:RecordAudio("417172073", var_309_25)
						arg_306_1:RecordAudio("417172073", var_309_25)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_417172", "417172073", "story_v_out_417172.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_417172", "417172073", "story_v_out_417172.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_26 = math.max(var_309_17, arg_306_1.talkMaxDuration)

			if var_309_16 <= arg_306_1.time_ and arg_306_1.time_ < var_309_16 + var_309_26 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_16) / var_309_26

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_16 + var_309_26 and arg_306_1.time_ < var_309_16 + var_309_26 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play417172074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 417172074
		arg_310_1.duration_ = 12.5

		local var_310_0 = {
			zh = 10.033,
			ja = 12.5
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play417172075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10110"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10110 == nil then
				arg_310_1.var_.actorSpriteComps10110 = var_313_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_2 = 0.2

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.actorSpriteComps10110 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								local var_313_4 = Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor1.r, var_313_3)
								local var_313_5 = Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor1.g, var_313_3)
								local var_313_6 = Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor1.b, var_313_3)

								iter_313_1.color = Color.New(var_313_4, var_313_5, var_313_6)
							else
								local var_313_7 = Mathf.Lerp(iter_313_1.color.r, 1, var_313_3)

								iter_313_1.color = Color.New(var_313_7, var_313_7, var_313_7)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10110 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_313_3 then
						if arg_310_1.isInRecall_ then
							iter_313_3.color = arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_313_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10110 = nil
			end

			local var_313_8 = arg_310_1.actors_["10115"]
			local var_313_9 = 0

			if var_313_9 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 and not isNil(var_313_8) and arg_310_1.var_.actorSpriteComps10115 == nil then
				arg_310_1.var_.actorSpriteComps10115 = var_313_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_10 = 0.2

			if var_313_9 <= arg_310_1.time_ and arg_310_1.time_ < var_313_9 + var_313_10 and not isNil(var_313_8) then
				local var_313_11 = (arg_310_1.time_ - var_313_9) / var_313_10

				if arg_310_1.var_.actorSpriteComps10115 then
					for iter_313_4, iter_313_5 in pairs(arg_310_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_313_5 then
							if arg_310_1.isInRecall_ then
								local var_313_12 = Mathf.Lerp(iter_313_5.color.r, arg_310_1.hightColor2.r, var_313_11)
								local var_313_13 = Mathf.Lerp(iter_313_5.color.g, arg_310_1.hightColor2.g, var_313_11)
								local var_313_14 = Mathf.Lerp(iter_313_5.color.b, arg_310_1.hightColor2.b, var_313_11)

								iter_313_5.color = Color.New(var_313_12, var_313_13, var_313_14)
							else
								local var_313_15 = Mathf.Lerp(iter_313_5.color.r, 0.5, var_313_11)

								iter_313_5.color = Color.New(var_313_15, var_313_15, var_313_15)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_9 + var_313_10 and arg_310_1.time_ < var_313_9 + var_313_10 + arg_313_0 and not isNil(var_313_8) and arg_310_1.var_.actorSpriteComps10115 then
				for iter_313_6, iter_313_7 in pairs(arg_310_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_313_7 then
						if arg_310_1.isInRecall_ then
							iter_313_7.color = arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_313_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10115 = nil
			end

			local var_313_16 = 0
			local var_313_17 = 0.825

			if var_313_16 < arg_310_1.time_ and arg_310_1.time_ <= var_313_16 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_18 = arg_310_1:FormatText(StoryNameCfg[36].name)

				arg_310_1.leftNameTxt_.text = var_313_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_19 = arg_310_1:GetWordFromCfg(417172074)
				local var_313_20 = arg_310_1:FormatText(var_313_19.content)

				arg_310_1.text_.text = var_313_20

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_21 = 33
				local var_313_22 = utf8.len(var_313_20)
				local var_313_23 = var_313_21 <= 0 and var_313_17 or var_313_17 * (var_313_22 / var_313_21)

				if var_313_23 > 0 and var_313_17 < var_313_23 then
					arg_310_1.talkMaxDuration = var_313_23

					if var_313_23 + var_313_16 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_23 + var_313_16
					end
				end

				arg_310_1.text_.text = var_313_20
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172074", "story_v_out_417172.awb") ~= 0 then
					local var_313_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172074", "story_v_out_417172.awb") / 1000

					if var_313_24 + var_313_16 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_24 + var_313_16
					end

					if var_313_19.prefab_name ~= "" and arg_310_1.actors_[var_313_19.prefab_name] ~= nil then
						local var_313_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_19.prefab_name].transform, "story_v_out_417172", "417172074", "story_v_out_417172.awb")

						arg_310_1:RecordAudio("417172074", var_313_25)
						arg_310_1:RecordAudio("417172074", var_313_25)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_417172", "417172074", "story_v_out_417172.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_417172", "417172074", "story_v_out_417172.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_26 = math.max(var_313_17, arg_310_1.talkMaxDuration)

			if var_313_16 <= arg_310_1.time_ and arg_310_1.time_ < var_313_16 + var_313_26 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_16) / var_313_26

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_16 + var_313_26 and arg_310_1.time_ < var_313_16 + var_313_26 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play417172075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 417172075
		arg_314_1.duration_ = 14.67

		local var_314_0 = {
			zh = 14.4,
			ja = 14.666
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play417172076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 1.275

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_2 = arg_314_1:FormatText(StoryNameCfg[36].name)

				arg_314_1.leftNameTxt_.text = var_317_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:GetWordFromCfg(417172075)
				local var_317_4 = arg_314_1:FormatText(var_317_3.content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 51
				local var_317_6 = utf8.len(var_317_4)
				local var_317_7 = var_317_5 <= 0 and var_317_1 or var_317_1 * (var_317_6 / var_317_5)

				if var_317_7 > 0 and var_317_1 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172075", "story_v_out_417172.awb") ~= 0 then
					local var_317_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172075", "story_v_out_417172.awb") / 1000

					if var_317_8 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_0
					end

					if var_317_3.prefab_name ~= "" and arg_314_1.actors_[var_317_3.prefab_name] ~= nil then
						local var_317_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_3.prefab_name].transform, "story_v_out_417172", "417172075", "story_v_out_417172.awb")

						arg_314_1:RecordAudio("417172075", var_317_9)
						arg_314_1:RecordAudio("417172075", var_317_9)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_417172", "417172075", "story_v_out_417172.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_417172", "417172075", "story_v_out_417172.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_10 and arg_314_1.time_ < var_317_0 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play417172076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 417172076
		arg_318_1.duration_ = 12.9

		local var_318_0 = {
			zh = 12.9,
			ja = 12.666
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play417172077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 1.175

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[36].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(417172076)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 47
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172076", "story_v_out_417172.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172076", "story_v_out_417172.awb") / 1000

					if var_321_8 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_0
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_out_417172", "417172076", "story_v_out_417172.awb")

						arg_318_1:RecordAudio("417172076", var_321_9)
						arg_318_1:RecordAudio("417172076", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_417172", "417172076", "story_v_out_417172.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_417172", "417172076", "story_v_out_417172.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_10 and arg_318_1.time_ < var_321_0 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play417172077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417172077
		arg_322_1.duration_ = 9.53

		local var_322_0 = {
			zh = 7.833,
			ja = 9.533
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play417172078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0
			local var_325_1 = 0.725

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_2 = arg_322_1:FormatText(StoryNameCfg[36].name)

				arg_322_1.leftNameTxt_.text = var_325_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_3 = arg_322_1:GetWordFromCfg(417172077)
				local var_325_4 = arg_322_1:FormatText(var_325_3.content)

				arg_322_1.text_.text = var_325_4

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 29
				local var_325_6 = utf8.len(var_325_4)
				local var_325_7 = var_325_5 <= 0 and var_325_1 or var_325_1 * (var_325_6 / var_325_5)

				if var_325_7 > 0 and var_325_1 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7

					if var_325_7 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_0
					end
				end

				arg_322_1.text_.text = var_325_4
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172077", "story_v_out_417172.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172077", "story_v_out_417172.awb") / 1000

					if var_325_8 + var_325_0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_0
					end

					if var_325_3.prefab_name ~= "" and arg_322_1.actors_[var_325_3.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_3.prefab_name].transform, "story_v_out_417172", "417172077", "story_v_out_417172.awb")

						arg_322_1:RecordAudio("417172077", var_325_9)
						arg_322_1:RecordAudio("417172077", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_417172", "417172077", "story_v_out_417172.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_417172", "417172077", "story_v_out_417172.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_1, arg_322_1.talkMaxDuration)

			if var_325_0 <= arg_322_1.time_ and arg_322_1.time_ < var_325_0 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_0) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_0 + var_325_10 and arg_322_1.time_ < var_325_0 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play417172078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417172078
		arg_326_1.duration_ = 11.83

		local var_326_0 = {
			zh = 10,
			ja = 11.833
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play417172079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 1

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[36].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(417172078)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 40
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172078", "story_v_out_417172.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172078", "story_v_out_417172.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_417172", "417172078", "story_v_out_417172.awb")

						arg_326_1:RecordAudio("417172078", var_329_9)
						arg_326_1:RecordAudio("417172078", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_417172", "417172078", "story_v_out_417172.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_417172", "417172078", "story_v_out_417172.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play417172079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 417172079
		arg_330_1.duration_ = 7.03

		local var_330_0 = {
			zh = 6.333,
			ja = 7.033
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play417172080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.575

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[36].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(417172079)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 23
				local var_333_6 = utf8.len(var_333_4)
				local var_333_7 = var_333_5 <= 0 and var_333_1 or var_333_1 * (var_333_6 / var_333_5)

				if var_333_7 > 0 and var_333_1 < var_333_7 then
					arg_330_1.talkMaxDuration = var_333_7

					if var_333_7 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_7 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_4
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172079", "story_v_out_417172.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172079", "story_v_out_417172.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_417172", "417172079", "story_v_out_417172.awb")

						arg_330_1:RecordAudio("417172079", var_333_9)
						arg_330_1:RecordAudio("417172079", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_417172", "417172079", "story_v_out_417172.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_417172", "417172079", "story_v_out_417172.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_10 and arg_330_1.time_ < var_333_0 + var_333_10 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play417172080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417172080
		arg_334_1.duration_ = 3.5

		local var_334_0 = {
			zh = 1.466,
			ja = 3.5
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play417172081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["10115"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps10115 == nil then
				arg_334_1.var_.actorSpriteComps10115 = var_337_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_2 = 0.2

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.actorSpriteComps10115 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								local var_337_4 = Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor1.r, var_337_3)
								local var_337_5 = Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor1.g, var_337_3)
								local var_337_6 = Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor1.b, var_337_3)

								iter_337_1.color = Color.New(var_337_4, var_337_5, var_337_6)
							else
								local var_337_7 = Mathf.Lerp(iter_337_1.color.r, 1, var_337_3)

								iter_337_1.color = Color.New(var_337_7, var_337_7, var_337_7)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.actorSpriteComps10115 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_337_3 then
						if arg_334_1.isInRecall_ then
							iter_337_3.color = arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_337_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps10115 = nil
			end

			local var_337_8 = arg_334_1.actors_["10110"]
			local var_337_9 = 0

			if var_337_9 < arg_334_1.time_ and arg_334_1.time_ <= var_337_9 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.actorSpriteComps10110 == nil then
				arg_334_1.var_.actorSpriteComps10110 = var_337_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_10 = 0.2

			if var_337_9 <= arg_334_1.time_ and arg_334_1.time_ < var_337_9 + var_337_10 and not isNil(var_337_8) then
				local var_337_11 = (arg_334_1.time_ - var_337_9) / var_337_10

				if arg_334_1.var_.actorSpriteComps10110 then
					for iter_337_4, iter_337_5 in pairs(arg_334_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_337_5 then
							if arg_334_1.isInRecall_ then
								local var_337_12 = Mathf.Lerp(iter_337_5.color.r, arg_334_1.hightColor2.r, var_337_11)
								local var_337_13 = Mathf.Lerp(iter_337_5.color.g, arg_334_1.hightColor2.g, var_337_11)
								local var_337_14 = Mathf.Lerp(iter_337_5.color.b, arg_334_1.hightColor2.b, var_337_11)

								iter_337_5.color = Color.New(var_337_12, var_337_13, var_337_14)
							else
								local var_337_15 = Mathf.Lerp(iter_337_5.color.r, 0.5, var_337_11)

								iter_337_5.color = Color.New(var_337_15, var_337_15, var_337_15)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= var_337_9 + var_337_10 and arg_334_1.time_ < var_337_9 + var_337_10 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.actorSpriteComps10110 then
				for iter_337_6, iter_337_7 in pairs(arg_334_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_337_7 then
						if arg_334_1.isInRecall_ then
							iter_337_7.color = arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_337_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_334_1.var_.actorSpriteComps10110 = nil
			end

			local var_337_16 = 0
			local var_337_17 = 0.2

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_18 = arg_334_1:FormatText(StoryNameCfg[1113].name)

				arg_334_1.leftNameTxt_.text = var_337_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_19 = arg_334_1:GetWordFromCfg(417172080)
				local var_337_20 = arg_334_1:FormatText(var_337_19.content)

				arg_334_1.text_.text = var_337_20

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_21 = 8
				local var_337_22 = utf8.len(var_337_20)
				local var_337_23 = var_337_21 <= 0 and var_337_17 or var_337_17 * (var_337_22 / var_337_21)

				if var_337_23 > 0 and var_337_17 < var_337_23 then
					arg_334_1.talkMaxDuration = var_337_23

					if var_337_23 + var_337_16 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_23 + var_337_16
					end
				end

				arg_334_1.text_.text = var_337_20
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172080", "story_v_out_417172.awb") ~= 0 then
					local var_337_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172080", "story_v_out_417172.awb") / 1000

					if var_337_24 + var_337_16 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_24 + var_337_16
					end

					if var_337_19.prefab_name ~= "" and arg_334_1.actors_[var_337_19.prefab_name] ~= nil then
						local var_337_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_19.prefab_name].transform, "story_v_out_417172", "417172080", "story_v_out_417172.awb")

						arg_334_1:RecordAudio("417172080", var_337_25)
						arg_334_1:RecordAudio("417172080", var_337_25)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417172", "417172080", "story_v_out_417172.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417172", "417172080", "story_v_out_417172.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_26 = math.max(var_337_17, arg_334_1.talkMaxDuration)

			if var_337_16 <= arg_334_1.time_ and arg_334_1.time_ < var_337_16 + var_337_26 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_16) / var_337_26

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_16 + var_337_26 and arg_334_1.time_ < var_337_16 + var_337_26 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play417172081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417172081
		arg_338_1.duration_ = 4.17

		local var_338_0 = {
			zh = 3.133,
			ja = 4.166
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play417172082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["10110"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps10110 == nil then
				arg_338_1.var_.actorSpriteComps10110 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.2

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps10110 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 1, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps10110 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_341_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps10110 = nil
			end

			local var_341_8 = arg_338_1.actors_["10115"]
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 and not isNil(var_341_8) and arg_338_1.var_.actorSpriteComps10115 == nil then
				arg_338_1.var_.actorSpriteComps10115 = var_341_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_10 = 0.2

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_10 and not isNil(var_341_8) then
				local var_341_11 = (arg_338_1.time_ - var_341_9) / var_341_10

				if arg_338_1.var_.actorSpriteComps10115 then
					for iter_341_4, iter_341_5 in pairs(arg_338_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_341_5 then
							if arg_338_1.isInRecall_ then
								local var_341_12 = Mathf.Lerp(iter_341_5.color.r, arg_338_1.hightColor2.r, var_341_11)
								local var_341_13 = Mathf.Lerp(iter_341_5.color.g, arg_338_1.hightColor2.g, var_341_11)
								local var_341_14 = Mathf.Lerp(iter_341_5.color.b, arg_338_1.hightColor2.b, var_341_11)

								iter_341_5.color = Color.New(var_341_12, var_341_13, var_341_14)
							else
								local var_341_15 = Mathf.Lerp(iter_341_5.color.r, 0.5, var_341_11)

								iter_341_5.color = Color.New(var_341_15, var_341_15, var_341_15)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_9 + var_341_10 and arg_338_1.time_ < var_341_9 + var_341_10 + arg_341_0 and not isNil(var_341_8) and arg_338_1.var_.actorSpriteComps10115 then
				for iter_341_6, iter_341_7 in pairs(arg_338_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_341_7 then
						if arg_338_1.isInRecall_ then
							iter_341_7.color = arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_341_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps10115 = nil
			end

			local var_341_16 = 0
			local var_341_17 = 0.225

			if var_341_16 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_18 = arg_338_1:FormatText(StoryNameCfg[36].name)

				arg_338_1.leftNameTxt_.text = var_341_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_19 = arg_338_1:GetWordFromCfg(417172081)
				local var_341_20 = arg_338_1:FormatText(var_341_19.content)

				arg_338_1.text_.text = var_341_20

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_21 = 9
				local var_341_22 = utf8.len(var_341_20)
				local var_341_23 = var_341_21 <= 0 and var_341_17 or var_341_17 * (var_341_22 / var_341_21)

				if var_341_23 > 0 and var_341_17 < var_341_23 then
					arg_338_1.talkMaxDuration = var_341_23

					if var_341_23 + var_341_16 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_23 + var_341_16
					end
				end

				arg_338_1.text_.text = var_341_20
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172081", "story_v_out_417172.awb") ~= 0 then
					local var_341_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172081", "story_v_out_417172.awb") / 1000

					if var_341_24 + var_341_16 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_24 + var_341_16
					end

					if var_341_19.prefab_name ~= "" and arg_338_1.actors_[var_341_19.prefab_name] ~= nil then
						local var_341_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_19.prefab_name].transform, "story_v_out_417172", "417172081", "story_v_out_417172.awb")

						arg_338_1:RecordAudio("417172081", var_341_25)
						arg_338_1:RecordAudio("417172081", var_341_25)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_417172", "417172081", "story_v_out_417172.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_417172", "417172081", "story_v_out_417172.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_26 = math.max(var_341_17, arg_338_1.talkMaxDuration)

			if var_341_16 <= arg_338_1.time_ and arg_338_1.time_ < var_341_16 + var_341_26 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_16) / var_341_26

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_16 + var_341_26 and arg_338_1.time_ < var_341_16 + var_341_26 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play417172082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 417172082
		arg_342_1.duration_ = 10.4

		local var_342_0 = {
			zh = 10.4,
			ja = 8.533
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play417172083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["10115"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10115 == nil then
				arg_342_1.var_.actorSpriteComps10115 = var_345_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_2 = 0.2

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.actorSpriteComps10115 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								local var_345_4 = Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor1.r, var_345_3)
								local var_345_5 = Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor1.g, var_345_3)
								local var_345_6 = Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor1.b, var_345_3)

								iter_345_1.color = Color.New(var_345_4, var_345_5, var_345_6)
							else
								local var_345_7 = Mathf.Lerp(iter_345_1.color.r, 1, var_345_3)

								iter_345_1.color = Color.New(var_345_7, var_345_7, var_345_7)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.actorSpriteComps10115 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_345_3 then
						if arg_342_1.isInRecall_ then
							iter_345_3.color = arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_345_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps10115 = nil
			end

			local var_345_8 = arg_342_1.actors_["10110"]
			local var_345_9 = 0

			if var_345_9 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 and not isNil(var_345_8) and arg_342_1.var_.actorSpriteComps10110 == nil then
				arg_342_1.var_.actorSpriteComps10110 = var_345_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_10 = 0.2

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_10 and not isNil(var_345_8) then
				local var_345_11 = (arg_342_1.time_ - var_345_9) / var_345_10

				if arg_342_1.var_.actorSpriteComps10110 then
					for iter_345_4, iter_345_5 in pairs(arg_342_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_345_5 then
							if arg_342_1.isInRecall_ then
								local var_345_12 = Mathf.Lerp(iter_345_5.color.r, arg_342_1.hightColor2.r, var_345_11)
								local var_345_13 = Mathf.Lerp(iter_345_5.color.g, arg_342_1.hightColor2.g, var_345_11)
								local var_345_14 = Mathf.Lerp(iter_345_5.color.b, arg_342_1.hightColor2.b, var_345_11)

								iter_345_5.color = Color.New(var_345_12, var_345_13, var_345_14)
							else
								local var_345_15 = Mathf.Lerp(iter_345_5.color.r, 0.5, var_345_11)

								iter_345_5.color = Color.New(var_345_15, var_345_15, var_345_15)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= var_345_9 + var_345_10 and arg_342_1.time_ < var_345_9 + var_345_10 + arg_345_0 and not isNil(var_345_8) and arg_342_1.var_.actorSpriteComps10110 then
				for iter_345_6, iter_345_7 in pairs(arg_342_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_345_7 then
						if arg_342_1.isInRecall_ then
							iter_345_7.color = arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_345_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_342_1.var_.actorSpriteComps10110 = nil
			end

			local var_345_16 = 0
			local var_345_17 = 1.15

			if var_345_16 < arg_342_1.time_ and arg_342_1.time_ <= var_345_16 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_18 = arg_342_1:FormatText(StoryNameCfg[1113].name)

				arg_342_1.leftNameTxt_.text = var_345_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_19 = arg_342_1:GetWordFromCfg(417172082)
				local var_345_20 = arg_342_1:FormatText(var_345_19.content)

				arg_342_1.text_.text = var_345_20

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_21 = 46
				local var_345_22 = utf8.len(var_345_20)
				local var_345_23 = var_345_21 <= 0 and var_345_17 or var_345_17 * (var_345_22 / var_345_21)

				if var_345_23 > 0 and var_345_17 < var_345_23 then
					arg_342_1.talkMaxDuration = var_345_23

					if var_345_23 + var_345_16 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_23 + var_345_16
					end
				end

				arg_342_1.text_.text = var_345_20
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172082", "story_v_out_417172.awb") ~= 0 then
					local var_345_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172082", "story_v_out_417172.awb") / 1000

					if var_345_24 + var_345_16 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_24 + var_345_16
					end

					if var_345_19.prefab_name ~= "" and arg_342_1.actors_[var_345_19.prefab_name] ~= nil then
						local var_345_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_19.prefab_name].transform, "story_v_out_417172", "417172082", "story_v_out_417172.awb")

						arg_342_1:RecordAudio("417172082", var_345_25)
						arg_342_1:RecordAudio("417172082", var_345_25)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_417172", "417172082", "story_v_out_417172.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_417172", "417172082", "story_v_out_417172.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_26 = math.max(var_345_17, arg_342_1.talkMaxDuration)

			if var_345_16 <= arg_342_1.time_ and arg_342_1.time_ < var_345_16 + var_345_26 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_16) / var_345_26

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_16 + var_345_26 and arg_342_1.time_ < var_345_16 + var_345_26 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play417172083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 417172083
		arg_346_1.duration_ = 7.33

		local var_346_0 = {
			zh = 4.8,
			ja = 7.333
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play417172084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.575

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[1113].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_3 = arg_346_1:GetWordFromCfg(417172083)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 24
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172083", "story_v_out_417172.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172083", "story_v_out_417172.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_out_417172", "417172083", "story_v_out_417172.awb")

						arg_346_1:RecordAudio("417172083", var_349_9)
						arg_346_1:RecordAudio("417172083", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_417172", "417172083", "story_v_out_417172.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_417172", "417172083", "story_v_out_417172.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_10 and arg_346_1.time_ < var_349_0 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play417172084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417172084
		arg_350_1.duration_ = 3.7

		local var_350_0 = {
			zh = 1.766,
			ja = 3.7
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417172085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["10110"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps10110 == nil then
				arg_350_1.var_.actorSpriteComps10110 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.2

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps10110 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								local var_353_4 = Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, var_353_3)
								local var_353_5 = Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, var_353_3)
								local var_353_6 = Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, var_353_3)

								iter_353_1.color = Color.New(var_353_4, var_353_5, var_353_6)
							else
								local var_353_7 = Mathf.Lerp(iter_353_1.color.r, 1, var_353_3)

								iter_353_1.color = Color.New(var_353_7, var_353_7, var_353_7)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps10110 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_353_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps10110 = nil
			end

			local var_353_8 = arg_350_1.actors_["10115"]
			local var_353_9 = 0

			if var_353_9 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 and not isNil(var_353_8) and arg_350_1.var_.actorSpriteComps10115 == nil then
				arg_350_1.var_.actorSpriteComps10115 = var_353_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_10 = 0.2

			if var_353_9 <= arg_350_1.time_ and arg_350_1.time_ < var_353_9 + var_353_10 and not isNil(var_353_8) then
				local var_353_11 = (arg_350_1.time_ - var_353_9) / var_353_10

				if arg_350_1.var_.actorSpriteComps10115 then
					for iter_353_4, iter_353_5 in pairs(arg_350_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_353_5 then
							if arg_350_1.isInRecall_ then
								local var_353_12 = Mathf.Lerp(iter_353_5.color.r, arg_350_1.hightColor2.r, var_353_11)
								local var_353_13 = Mathf.Lerp(iter_353_5.color.g, arg_350_1.hightColor2.g, var_353_11)
								local var_353_14 = Mathf.Lerp(iter_353_5.color.b, arg_350_1.hightColor2.b, var_353_11)

								iter_353_5.color = Color.New(var_353_12, var_353_13, var_353_14)
							else
								local var_353_15 = Mathf.Lerp(iter_353_5.color.r, 0.5, var_353_11)

								iter_353_5.color = Color.New(var_353_15, var_353_15, var_353_15)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_9 + var_353_10 and arg_350_1.time_ < var_353_9 + var_353_10 + arg_353_0 and not isNil(var_353_8) and arg_350_1.var_.actorSpriteComps10115 then
				for iter_353_6, iter_353_7 in pairs(arg_350_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_353_7 then
						if arg_350_1.isInRecall_ then
							iter_353_7.color = arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_353_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps10115 = nil
			end

			local var_353_16 = 0
			local var_353_17 = 0.15

			if var_353_16 < arg_350_1.time_ and arg_350_1.time_ <= var_353_16 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_18 = arg_350_1:FormatText(StoryNameCfg[36].name)

				arg_350_1.leftNameTxt_.text = var_353_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_19 = arg_350_1:GetWordFromCfg(417172084)
				local var_353_20 = arg_350_1:FormatText(var_353_19.content)

				arg_350_1.text_.text = var_353_20

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_21 = 6
				local var_353_22 = utf8.len(var_353_20)
				local var_353_23 = var_353_21 <= 0 and var_353_17 or var_353_17 * (var_353_22 / var_353_21)

				if var_353_23 > 0 and var_353_17 < var_353_23 then
					arg_350_1.talkMaxDuration = var_353_23

					if var_353_23 + var_353_16 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_23 + var_353_16
					end
				end

				arg_350_1.text_.text = var_353_20
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172084", "story_v_out_417172.awb") ~= 0 then
					local var_353_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172084", "story_v_out_417172.awb") / 1000

					if var_353_24 + var_353_16 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_24 + var_353_16
					end

					if var_353_19.prefab_name ~= "" and arg_350_1.actors_[var_353_19.prefab_name] ~= nil then
						local var_353_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_19.prefab_name].transform, "story_v_out_417172", "417172084", "story_v_out_417172.awb")

						arg_350_1:RecordAudio("417172084", var_353_25)
						arg_350_1:RecordAudio("417172084", var_353_25)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_417172", "417172084", "story_v_out_417172.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_417172", "417172084", "story_v_out_417172.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_26 = math.max(var_353_17, arg_350_1.talkMaxDuration)

			if var_353_16 <= arg_350_1.time_ and arg_350_1.time_ < var_353_16 + var_353_26 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_16) / var_353_26

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_16 + var_353_26 and arg_350_1.time_ < var_353_16 + var_353_26 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play417172085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417172085
		arg_354_1.duration_ = 10.6

		local var_354_0 = {
			zh = 7.933,
			ja = 10.6
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417172086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["10115"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps10115 == nil then
				arg_354_1.var_.actorSpriteComps10115 = var_357_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_2 = 0.2

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.actorSpriteComps10115 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								local var_357_4 = Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor1.r, var_357_3)
								local var_357_5 = Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor1.g, var_357_3)
								local var_357_6 = Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor1.b, var_357_3)

								iter_357_1.color = Color.New(var_357_4, var_357_5, var_357_6)
							else
								local var_357_7 = Mathf.Lerp(iter_357_1.color.r, 1, var_357_3)

								iter_357_1.color = Color.New(var_357_7, var_357_7, var_357_7)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.actorSpriteComps10115 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_357_3 then
						if arg_354_1.isInRecall_ then
							iter_357_3.color = arg_354_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_357_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps10115 = nil
			end

			local var_357_8 = arg_354_1.actors_["10110"]
			local var_357_9 = 0

			if var_357_9 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 and not isNil(var_357_8) and arg_354_1.var_.actorSpriteComps10110 == nil then
				arg_354_1.var_.actorSpriteComps10110 = var_357_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_10 = 0.2

			if var_357_9 <= arg_354_1.time_ and arg_354_1.time_ < var_357_9 + var_357_10 and not isNil(var_357_8) then
				local var_357_11 = (arg_354_1.time_ - var_357_9) / var_357_10

				if arg_354_1.var_.actorSpriteComps10110 then
					for iter_357_4, iter_357_5 in pairs(arg_354_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_357_5 then
							if arg_354_1.isInRecall_ then
								local var_357_12 = Mathf.Lerp(iter_357_5.color.r, arg_354_1.hightColor2.r, var_357_11)
								local var_357_13 = Mathf.Lerp(iter_357_5.color.g, arg_354_1.hightColor2.g, var_357_11)
								local var_357_14 = Mathf.Lerp(iter_357_5.color.b, arg_354_1.hightColor2.b, var_357_11)

								iter_357_5.color = Color.New(var_357_12, var_357_13, var_357_14)
							else
								local var_357_15 = Mathf.Lerp(iter_357_5.color.r, 0.5, var_357_11)

								iter_357_5.color = Color.New(var_357_15, var_357_15, var_357_15)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= var_357_9 + var_357_10 and arg_354_1.time_ < var_357_9 + var_357_10 + arg_357_0 and not isNil(var_357_8) and arg_354_1.var_.actorSpriteComps10110 then
				for iter_357_6, iter_357_7 in pairs(arg_354_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_357_7 then
						if arg_354_1.isInRecall_ then
							iter_357_7.color = arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_357_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_354_1.var_.actorSpriteComps10110 = nil
			end

			local var_357_16 = 0
			local var_357_17 = 0.7

			if var_357_16 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_18 = arg_354_1:FormatText(StoryNameCfg[1113].name)

				arg_354_1.leftNameTxt_.text = var_357_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_19 = arg_354_1:GetWordFromCfg(417172085)
				local var_357_20 = arg_354_1:FormatText(var_357_19.content)

				arg_354_1.text_.text = var_357_20

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_21 = 28
				local var_357_22 = utf8.len(var_357_20)
				local var_357_23 = var_357_21 <= 0 and var_357_17 or var_357_17 * (var_357_22 / var_357_21)

				if var_357_23 > 0 and var_357_17 < var_357_23 then
					arg_354_1.talkMaxDuration = var_357_23

					if var_357_23 + var_357_16 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_23 + var_357_16
					end
				end

				arg_354_1.text_.text = var_357_20
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172085", "story_v_out_417172.awb") ~= 0 then
					local var_357_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172085", "story_v_out_417172.awb") / 1000

					if var_357_24 + var_357_16 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_24 + var_357_16
					end

					if var_357_19.prefab_name ~= "" and arg_354_1.actors_[var_357_19.prefab_name] ~= nil then
						local var_357_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_19.prefab_name].transform, "story_v_out_417172", "417172085", "story_v_out_417172.awb")

						arg_354_1:RecordAudio("417172085", var_357_25)
						arg_354_1:RecordAudio("417172085", var_357_25)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_417172", "417172085", "story_v_out_417172.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_417172", "417172085", "story_v_out_417172.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_26 = math.max(var_357_17, arg_354_1.talkMaxDuration)

			if var_357_16 <= arg_354_1.time_ and arg_354_1.time_ < var_357_16 + var_357_26 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_16) / var_357_26

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_16 + var_357_26 and arg_354_1.time_ < var_357_16 + var_357_26 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play417172086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417172086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417172087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["10115"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps10115 == nil then
				arg_358_1.var_.actorSpriteComps10115 = var_361_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_2 = 0.2

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.actorSpriteComps10115 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								local var_361_4 = Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor2.r, var_361_3)
								local var_361_5 = Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor2.g, var_361_3)
								local var_361_6 = Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor2.b, var_361_3)

								iter_361_1.color = Color.New(var_361_4, var_361_5, var_361_6)
							else
								local var_361_7 = Mathf.Lerp(iter_361_1.color.r, 0.5, var_361_3)

								iter_361_1.color = Color.New(var_361_7, var_361_7, var_361_7)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.actorSpriteComps10115 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_361_3 then
						if arg_358_1.isInRecall_ then
							iter_361_3.color = arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_361_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_358_1.var_.actorSpriteComps10115 = nil
			end

			local var_361_8 = arg_358_1.actors_["10115"].transform
			local var_361_9 = 0

			if var_361_9 < arg_358_1.time_ and arg_358_1.time_ <= var_361_9 + arg_361_0 then
				arg_358_1.var_.moveOldPos10115 = var_361_8.localPosition
				var_361_8.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10115", 7)

				local var_361_10 = var_361_8.childCount

				for iter_361_4 = 0, var_361_10 - 1 do
					local var_361_11 = var_361_8:GetChild(iter_361_4)

					if var_361_11.name == "" or not string.find(var_361_11.name, "split") then
						var_361_11.gameObject:SetActive(true)
					else
						var_361_11.gameObject:SetActive(false)
					end
				end
			end

			local var_361_12 = 0.001

			if var_361_9 <= arg_358_1.time_ and arg_358_1.time_ < var_361_9 + var_361_12 then
				local var_361_13 = (arg_358_1.time_ - var_361_9) / var_361_12
				local var_361_14 = Vector3.New(0, -2000, 0)

				var_361_8.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10115, var_361_14, var_361_13)
			end

			if arg_358_1.time_ >= var_361_9 + var_361_12 and arg_358_1.time_ < var_361_9 + var_361_12 + arg_361_0 then
				var_361_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_361_15 = 0.05
			local var_361_16 = 1

			if var_361_15 < arg_358_1.time_ and arg_358_1.time_ <= var_361_15 + arg_361_0 then
				local var_361_17 = "play"
				local var_361_18 = "effect"

				arg_358_1:AudioAction(var_361_17, var_361_18, "se_story_side_1094", "se_story_1094_alarmclock", "")
			end

			local var_361_19 = 0
			local var_361_20 = 0.95

			if var_361_19 < arg_358_1.time_ and arg_358_1.time_ <= var_361_19 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_21 = arg_358_1:GetWordFromCfg(417172086)
				local var_361_22 = arg_358_1:FormatText(var_361_21.content)

				arg_358_1.text_.text = var_361_22

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_23 = 38
				local var_361_24 = utf8.len(var_361_22)
				local var_361_25 = var_361_23 <= 0 and var_361_20 or var_361_20 * (var_361_24 / var_361_23)

				if var_361_25 > 0 and var_361_20 < var_361_25 then
					arg_358_1.talkMaxDuration = var_361_25

					if var_361_25 + var_361_19 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_25 + var_361_19
					end
				end

				arg_358_1.text_.text = var_361_22
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_26 = math.max(var_361_20, arg_358_1.talkMaxDuration)

			if var_361_19 <= arg_358_1.time_ and arg_358_1.time_ < var_361_19 + var_361_26 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_19) / var_361_26

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_19 + var_361_26 and arg_358_1.time_ < var_361_19 + var_361_26 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play417172087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417172087
		arg_362_1.duration_ = 6.3

		local var_362_0 = {
			zh = 6.3,
			ja = 5.766
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play417172088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["10115"]
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps10115 == nil then
				arg_362_1.var_.actorSpriteComps10115 = var_365_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_2 = 0.2

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 and not isNil(var_365_0) then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2

				if arg_362_1.var_.actorSpriteComps10115 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								local var_365_4 = Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, var_365_3)
								local var_365_5 = Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, var_365_3)
								local var_365_6 = Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, var_365_3)

								iter_365_1.color = Color.New(var_365_4, var_365_5, var_365_6)
							else
								local var_365_7 = Mathf.Lerp(iter_365_1.color.r, 1, var_365_3)

								iter_365_1.color = Color.New(var_365_7, var_365_7, var_365_7)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 and not isNil(var_365_0) and arg_362_1.var_.actorSpriteComps10115 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_365_3 then
						if arg_362_1.isInRecall_ then
							iter_365_3.color = arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_365_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_362_1.var_.actorSpriteComps10115 = nil
			end

			local var_365_8 = arg_362_1.actors_["10115"].transform
			local var_365_9 = 0

			if var_365_9 < arg_362_1.time_ and arg_362_1.time_ <= var_365_9 + arg_365_0 then
				arg_362_1.var_.moveOldPos10115 = var_365_8.localPosition
				var_365_8.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("10115", 3)

				local var_365_10 = var_365_8.childCount

				for iter_365_4 = 0, var_365_10 - 1 do
					local var_365_11 = var_365_8:GetChild(iter_365_4)

					if var_365_11.name == "" or not string.find(var_365_11.name, "split") then
						var_365_11.gameObject:SetActive(true)
					else
						var_365_11.gameObject:SetActive(false)
					end
				end
			end

			local var_365_12 = 0.001

			if var_365_9 <= arg_362_1.time_ and arg_362_1.time_ < var_365_9 + var_365_12 then
				local var_365_13 = (arg_362_1.time_ - var_365_9) / var_365_12
				local var_365_14 = Vector3.New(0, -387.3, -246.2)

				var_365_8.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos10115, var_365_14, var_365_13)
			end

			if arg_362_1.time_ >= var_365_9 + var_365_12 and arg_362_1.time_ < var_365_9 + var_365_12 + arg_365_0 then
				var_365_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_365_15 = 0
			local var_365_16 = 0.75

			if var_365_15 < arg_362_1.time_ and arg_362_1.time_ <= var_365_15 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_17 = arg_362_1:FormatText(StoryNameCfg[1113].name)

				arg_362_1.leftNameTxt_.text = var_365_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_18 = arg_362_1:GetWordFromCfg(417172087)
				local var_365_19 = arg_362_1:FormatText(var_365_18.content)

				arg_362_1.text_.text = var_365_19

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_20 = 30
				local var_365_21 = utf8.len(var_365_19)
				local var_365_22 = var_365_20 <= 0 and var_365_16 or var_365_16 * (var_365_21 / var_365_20)

				if var_365_22 > 0 and var_365_16 < var_365_22 then
					arg_362_1.talkMaxDuration = var_365_22

					if var_365_22 + var_365_15 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_22 + var_365_15
					end
				end

				arg_362_1.text_.text = var_365_19
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172087", "story_v_out_417172.awb") ~= 0 then
					local var_365_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172087", "story_v_out_417172.awb") / 1000

					if var_365_23 + var_365_15 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_23 + var_365_15
					end

					if var_365_18.prefab_name ~= "" and arg_362_1.actors_[var_365_18.prefab_name] ~= nil then
						local var_365_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_18.prefab_name].transform, "story_v_out_417172", "417172087", "story_v_out_417172.awb")

						arg_362_1:RecordAudio("417172087", var_365_24)
						arg_362_1:RecordAudio("417172087", var_365_24)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_417172", "417172087", "story_v_out_417172.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_417172", "417172087", "story_v_out_417172.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_25 = math.max(var_365_16, arg_362_1.talkMaxDuration)

			if var_365_15 <= arg_362_1.time_ and arg_362_1.time_ < var_365_15 + var_365_25 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_15) / var_365_25

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_15 + var_365_25 and arg_362_1.time_ < var_365_15 + var_365_25 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play417172088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417172088
		arg_366_1.duration_ = 3.63

		local var_366_0 = {
			zh = 1.433,
			ja = 3.633
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play417172089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["10115"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps10115 == nil then
				arg_366_1.var_.actorSpriteComps10115 = var_369_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_2 = 0.2

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.actorSpriteComps10115 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								local var_369_4 = Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor2.r, var_369_3)
								local var_369_5 = Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor2.g, var_369_3)
								local var_369_6 = Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor2.b, var_369_3)

								iter_369_1.color = Color.New(var_369_4, var_369_5, var_369_6)
							else
								local var_369_7 = Mathf.Lerp(iter_369_1.color.r, 0.5, var_369_3)

								iter_369_1.color = Color.New(var_369_7, var_369_7, var_369_7)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.actorSpriteComps10115 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_369_3 then
						if arg_366_1.isInRecall_ then
							iter_369_3.color = arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_369_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_366_1.var_.actorSpriteComps10115 = nil
			end

			local var_369_8 = 0
			local var_369_9 = 0.15

			if var_369_8 < arg_366_1.time_ and arg_366_1.time_ <= var_369_8 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_10 = arg_366_1:FormatText(StoryNameCfg[36].name)

				arg_366_1.leftNameTxt_.text = var_369_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_11 = arg_366_1:GetWordFromCfg(417172088)
				local var_369_12 = arg_366_1:FormatText(var_369_11.content)

				arg_366_1.text_.text = var_369_12

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 6
				local var_369_14 = utf8.len(var_369_12)
				local var_369_15 = var_369_13 <= 0 and var_369_9 or var_369_9 * (var_369_14 / var_369_13)

				if var_369_15 > 0 and var_369_9 < var_369_15 then
					arg_366_1.talkMaxDuration = var_369_15

					if var_369_15 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_15 + var_369_8
					end
				end

				arg_366_1.text_.text = var_369_12
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172088", "story_v_out_417172.awb") ~= 0 then
					local var_369_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172088", "story_v_out_417172.awb") / 1000

					if var_369_16 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_16 + var_369_8
					end

					if var_369_11.prefab_name ~= "" and arg_366_1.actors_[var_369_11.prefab_name] ~= nil then
						local var_369_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_11.prefab_name].transform, "story_v_out_417172", "417172088", "story_v_out_417172.awb")

						arg_366_1:RecordAudio("417172088", var_369_17)
						arg_366_1:RecordAudio("417172088", var_369_17)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417172", "417172088", "story_v_out_417172.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417172", "417172088", "story_v_out_417172.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_18 = math.max(var_369_9, arg_366_1.talkMaxDuration)

			if var_369_8 <= arg_366_1.time_ and arg_366_1.time_ < var_369_8 + var_369_18 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_8) / var_369_18

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_8 + var_369_18 and arg_366_1.time_ < var_369_8 + var_369_18 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play417172089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417172089
		arg_370_1.duration_ = 4.83

		local var_370_0 = {
			zh = 3.833,
			ja = 4.833
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play417172090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["10115"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps10115 == nil then
				arg_370_1.var_.actorSpriteComps10115 = var_373_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_2 = 0.2

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.actorSpriteComps10115 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								local var_373_4 = Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, var_373_3)
								local var_373_5 = Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, var_373_3)
								local var_373_6 = Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, var_373_3)

								iter_373_1.color = Color.New(var_373_4, var_373_5, var_373_6)
							else
								local var_373_7 = Mathf.Lerp(iter_373_1.color.r, 1, var_373_3)

								iter_373_1.color = Color.New(var_373_7, var_373_7, var_373_7)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.actorSpriteComps10115 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_373_3 then
						if arg_370_1.isInRecall_ then
							iter_373_3.color = arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_373_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps10115 = nil
			end

			local var_373_8 = arg_370_1.actors_["10110"]
			local var_373_9 = 0

			if var_373_9 < arg_370_1.time_ and arg_370_1.time_ <= var_373_9 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps10110 == nil then
				arg_370_1.var_.actorSpriteComps10110 = var_373_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_10 = 0.2

			if var_373_9 <= arg_370_1.time_ and arg_370_1.time_ < var_373_9 + var_373_10 and not isNil(var_373_8) then
				local var_373_11 = (arg_370_1.time_ - var_373_9) / var_373_10

				if arg_370_1.var_.actorSpriteComps10110 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps10110:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								local var_373_12 = Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, var_373_11)
								local var_373_13 = Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, var_373_11)
								local var_373_14 = Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, var_373_11)

								iter_373_5.color = Color.New(var_373_12, var_373_13, var_373_14)
							else
								local var_373_15 = Mathf.Lerp(iter_373_5.color.r, 0.5, var_373_11)

								iter_373_5.color = Color.New(var_373_15, var_373_15, var_373_15)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= var_373_9 + var_373_10 and arg_370_1.time_ < var_373_9 + var_373_10 + arg_373_0 and not isNil(var_373_8) and arg_370_1.var_.actorSpriteComps10110 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps10110:ToTable()) do
					if iter_373_7 then
						if arg_370_1.isInRecall_ then
							iter_373_7.color = arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_373_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_370_1.var_.actorSpriteComps10110 = nil
			end

			local var_373_16 = 0
			local var_373_17 = 0.45

			if var_373_16 < arg_370_1.time_ and arg_370_1.time_ <= var_373_16 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_18 = arg_370_1:FormatText(StoryNameCfg[1113].name)

				arg_370_1.leftNameTxt_.text = var_373_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_19 = arg_370_1:GetWordFromCfg(417172089)
				local var_373_20 = arg_370_1:FormatText(var_373_19.content)

				arg_370_1.text_.text = var_373_20

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_21 = 18
				local var_373_22 = utf8.len(var_373_20)
				local var_373_23 = var_373_21 <= 0 and var_373_17 or var_373_17 * (var_373_22 / var_373_21)

				if var_373_23 > 0 and var_373_17 < var_373_23 then
					arg_370_1.talkMaxDuration = var_373_23

					if var_373_23 + var_373_16 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_23 + var_373_16
					end
				end

				arg_370_1.text_.text = var_373_20
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172089", "story_v_out_417172.awb") ~= 0 then
					local var_373_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172089", "story_v_out_417172.awb") / 1000

					if var_373_24 + var_373_16 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_24 + var_373_16
					end

					if var_373_19.prefab_name ~= "" and arg_370_1.actors_[var_373_19.prefab_name] ~= nil then
						local var_373_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_19.prefab_name].transform, "story_v_out_417172", "417172089", "story_v_out_417172.awb")

						arg_370_1:RecordAudio("417172089", var_373_25)
						arg_370_1:RecordAudio("417172089", var_373_25)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417172", "417172089", "story_v_out_417172.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417172", "417172089", "story_v_out_417172.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_26 = math.max(var_373_17, arg_370_1.talkMaxDuration)

			if var_373_16 <= arg_370_1.time_ and arg_370_1.time_ < var_373_16 + var_373_26 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_16) / var_373_26

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_16 + var_373_26 and arg_370_1.time_ < var_373_16 + var_373_26 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play417172090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417172090
		arg_374_1.duration_ = 6.3

		local var_374_0 = {
			zh = 5,
			ja = 6.3
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play417172091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 2

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				local var_377_1 = manager.ui.mainCamera.transform.localPosition
				local var_377_2 = Vector3.New(0, 0, 10) + Vector3.New(var_377_1.x, var_377_1.y, 0)
				local var_377_3 = arg_374_1.bgs_.ST2104a

				var_377_3.transform.localPosition = var_377_2
				var_377_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_377_4 = var_377_3:GetComponent("SpriteRenderer")

				if var_377_4 and var_377_4.sprite then
					local var_377_5 = (var_377_3.transform.localPosition - var_377_1).z
					local var_377_6 = manager.ui.mainCameraCom_
					local var_377_7 = 2 * var_377_5 * Mathf.Tan(var_377_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_377_8 = var_377_7 * var_377_6.aspect
					local var_377_9 = var_377_4.sprite.bounds.size.x
					local var_377_10 = var_377_4.sprite.bounds.size.y
					local var_377_11 = var_377_8 / var_377_9
					local var_377_12 = var_377_7 / var_377_10
					local var_377_13 = var_377_12 < var_377_11 and var_377_11 or var_377_12

					var_377_3.transform.localScale = Vector3.New(var_377_13, var_377_13, 0)
				end

				for iter_377_0, iter_377_1 in pairs(arg_374_1.bgs_) do
					if iter_377_0 ~= "ST2104a" then
						iter_377_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_377_14 = 4

			if var_377_14 < arg_374_1.time_ and arg_374_1.time_ <= var_377_14 + arg_377_0 then
				arg_374_1.allBtn_.enabled = false
			end

			local var_377_15 = 0.3

			if arg_374_1.time_ >= var_377_14 + var_377_15 and arg_374_1.time_ < var_377_14 + var_377_15 + arg_377_0 then
				arg_374_1.allBtn_.enabled = true
			end

			local var_377_16 = 0

			if var_377_16 < arg_374_1.time_ and arg_374_1.time_ <= var_377_16 + arg_377_0 then
				arg_374_1.mask_.enabled = true
				arg_374_1.mask_.raycastTarget = true

				arg_374_1:SetGaussion(false)
			end

			local var_377_17 = 2

			if var_377_16 <= arg_374_1.time_ and arg_374_1.time_ < var_377_16 + var_377_17 then
				local var_377_18 = (arg_374_1.time_ - var_377_16) / var_377_17
				local var_377_19 = Color.New(0, 0, 0)

				var_377_19.a = Mathf.Lerp(0, 1, var_377_18)
				arg_374_1.mask_.color = var_377_19
			end

			if arg_374_1.time_ >= var_377_16 + var_377_17 and arg_374_1.time_ < var_377_16 + var_377_17 + arg_377_0 then
				local var_377_20 = Color.New(0, 0, 0)

				var_377_20.a = 1
				arg_374_1.mask_.color = var_377_20
			end

			local var_377_21 = 2

			if var_377_21 < arg_374_1.time_ and arg_374_1.time_ <= var_377_21 + arg_377_0 then
				arg_374_1.mask_.enabled = true
				arg_374_1.mask_.raycastTarget = true

				arg_374_1:SetGaussion(false)
			end

			local var_377_22 = 2

			if var_377_21 <= arg_374_1.time_ and arg_374_1.time_ < var_377_21 + var_377_22 then
				local var_377_23 = (arg_374_1.time_ - var_377_21) / var_377_22
				local var_377_24 = Color.New(0, 0, 0)

				var_377_24.a = Mathf.Lerp(1, 0, var_377_23)
				arg_374_1.mask_.color = var_377_24
			end

			if arg_374_1.time_ >= var_377_21 + var_377_22 and arg_374_1.time_ < var_377_21 + var_377_22 + arg_377_0 then
				local var_377_25 = Color.New(0, 0, 0)
				local var_377_26 = 0

				arg_374_1.mask_.enabled = false
				var_377_25.a = var_377_26
				arg_374_1.mask_.color = var_377_25
			end

			local var_377_27 = arg_374_1.actors_["10115"].transform
			local var_377_28 = 1.966

			if var_377_28 < arg_374_1.time_ and arg_374_1.time_ <= var_377_28 + arg_377_0 then
				arg_374_1.var_.moveOldPos10115 = var_377_27.localPosition
				var_377_27.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("10115", 7)

				local var_377_29 = var_377_27.childCount

				for iter_377_2 = 0, var_377_29 - 1 do
					local var_377_30 = var_377_27:GetChild(iter_377_2)

					if var_377_30.name == "" or not string.find(var_377_30.name, "split") then
						var_377_30.gameObject:SetActive(true)
					else
						var_377_30.gameObject:SetActive(false)
					end
				end
			end

			local var_377_31 = 0.001

			if var_377_28 <= arg_374_1.time_ and arg_374_1.time_ < var_377_28 + var_377_31 then
				local var_377_32 = (arg_374_1.time_ - var_377_28) / var_377_31
				local var_377_33 = Vector3.New(0, -2000, 0)

				var_377_27.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos10115, var_377_33, var_377_32)
			end

			if arg_374_1.time_ >= var_377_28 + var_377_31 and arg_374_1.time_ < var_377_28 + var_377_31 + arg_377_0 then
				var_377_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_377_34 = 0
			local var_377_35 = 0.2

			if var_377_34 < arg_374_1.time_ and arg_374_1.time_ <= var_377_34 + arg_377_0 then
				local var_377_36 = "play"
				local var_377_37 = "music"

				arg_374_1:AudioAction(var_377_36, var_377_37, "ui_battle", "ui_battle_stopbgm", "")

				local var_377_38 = ""
				local var_377_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_377_39 ~= "" then
					if arg_374_1.bgmTxt_.text ~= var_377_39 and arg_374_1.bgmTxt_.text ~= "" then
						if arg_374_1.bgmTxt2_.text ~= "" then
							arg_374_1.bgmTxt_.text = arg_374_1.bgmTxt2_.text
						end

						arg_374_1.bgmTxt2_.text = var_377_39

						arg_374_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_374_1.bgmTxt_.text = var_377_39
						arg_374_1.bgmTxt2_.text = var_377_39
					end

					if arg_374_1.bgmTimer then
						arg_374_1.bgmTimer:Stop()

						arg_374_1.bgmTimer = nil
					end

					if arg_374_1.settingData.show_music_name == 1 then
						arg_374_1.musicController:SetSelectedState("show")
						arg_374_1.musicAnimator_:Play("open", 0, 0)

						if arg_374_1.settingData.music_time ~= 0 then
							arg_374_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_374_1.settingData.music_time), function()
								if arg_374_1 == nil or isNil(arg_374_1.bgmTxt_) then
									return
								end

								arg_374_1.musicController:SetSelectedState("hide")
								arg_374_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_377_40 = 1.53333333333333
			local var_377_41 = 1

			if var_377_40 < arg_374_1.time_ and arg_374_1.time_ <= var_377_40 + arg_377_0 then
				local var_377_42 = "play"
				local var_377_43 = "music"

				arg_374_1:AudioAction(var_377_42, var_377_43, "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain.awb")

				local var_377_44 = ""
				local var_377_45 = manager.audio:GetAudioName("bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain")

				if var_377_45 ~= "" then
					if arg_374_1.bgmTxt_.text ~= var_377_45 and arg_374_1.bgmTxt_.text ~= "" then
						if arg_374_1.bgmTxt2_.text ~= "" then
							arg_374_1.bgmTxt_.text = arg_374_1.bgmTxt2_.text
						end

						arg_374_1.bgmTxt2_.text = var_377_45

						arg_374_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_374_1.bgmTxt_.text = var_377_45
						arg_374_1.bgmTxt2_.text = var_377_45
					end

					if arg_374_1.bgmTimer then
						arg_374_1.bgmTimer:Stop()

						arg_374_1.bgmTimer = nil
					end

					if arg_374_1.settingData.show_music_name == 1 then
						arg_374_1.musicController:SetSelectedState("show")
						arg_374_1.musicAnimator_:Play("open", 0, 0)

						if arg_374_1.settingData.music_time ~= 0 then
							arg_374_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_374_1.settingData.music_time), function()
								if arg_374_1 == nil or isNil(arg_374_1.bgmTxt_) then
									return
								end

								arg_374_1.musicController:SetSelectedState("hide")
								arg_374_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_374_1.frameCnt_ <= 1 then
				arg_374_1.dialog_:SetActive(false)
			end

			local var_377_46 = 4
			local var_377_47 = 0.133333333333334

			if var_377_46 < arg_374_1.time_ and arg_374_1.time_ <= var_377_46 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				arg_374_1.dialog_:SetActive(true)

				arg_374_1.dialogCg_.alpha = 0

				local var_377_48 = LeanTween.value(arg_374_1.dialog_, 0, 1, 0.3)

				var_377_48:setOnUpdate(LuaHelper.FloatAction(function(arg_380_0)
					arg_374_1.dialogCg_.alpha = arg_380_0
				end))
				var_377_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_374_1.dialog_)
					var_377_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_374_1.duration_ = arg_374_1.duration_ + 0.3

				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_49 = arg_374_1:FormatText(StoryNameCfg[595].name)

				arg_374_1.leftNameTxt_.text = var_377_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, true)
				arg_374_1.iconController_:SetSelectedState("hero")

				arg_374_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_3")

				arg_374_1.callingController_:SetSelectedState("normal")

				arg_374_1.keyicon_.color = Color.New(1, 1, 1)
				arg_374_1.icon_.color = Color.New(1, 1, 1)

				local var_377_50 = arg_374_1:GetWordFromCfg(417172090)
				local var_377_51 = arg_374_1:FormatText(var_377_50.content)

				arg_374_1.text_.text = var_377_51

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_52 = 4
				local var_377_53 = utf8.len(var_377_51)
				local var_377_54 = var_377_52 <= 0 and var_377_47 or var_377_47 * (var_377_53 / var_377_52)

				if var_377_54 > 0 and var_377_47 < var_377_54 then
					arg_374_1.talkMaxDuration = var_377_54
					var_377_46 = var_377_46 + 0.3

					if var_377_54 + var_377_46 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_54 + var_377_46
					end
				end

				arg_374_1.text_.text = var_377_51
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172090", "story_v_out_417172.awb") ~= 0 then
					local var_377_55 = manager.audio:GetVoiceLength("story_v_out_417172", "417172090", "story_v_out_417172.awb") / 1000

					if var_377_55 + var_377_46 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_55 + var_377_46
					end

					if var_377_50.prefab_name ~= "" and arg_374_1.actors_[var_377_50.prefab_name] ~= nil then
						local var_377_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_50.prefab_name].transform, "story_v_out_417172", "417172090", "story_v_out_417172.awb")

						arg_374_1:RecordAudio("417172090", var_377_56)
						arg_374_1:RecordAudio("417172090", var_377_56)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_417172", "417172090", "story_v_out_417172.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_417172", "417172090", "story_v_out_417172.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_57 = var_377_46 + 0.3
			local var_377_58 = math.max(var_377_47, arg_374_1.talkMaxDuration)

			if var_377_57 <= arg_374_1.time_ and arg_374_1.time_ < var_377_57 + var_377_58 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_57) / var_377_58

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_57 + var_377_58 and arg_374_1.time_ < var_377_57 + var_377_58 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play417172091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 417172091
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play417172092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["10128"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps10128 == nil then
				arg_382_1.var_.actorSpriteComps10128 = var_385_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_2 = 0.2

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.actorSpriteComps10128 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								local var_385_4 = Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor2.r, var_385_3)
								local var_385_5 = Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor2.g, var_385_3)
								local var_385_6 = Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor2.b, var_385_3)

								iter_385_1.color = Color.New(var_385_4, var_385_5, var_385_6)
							else
								local var_385_7 = Mathf.Lerp(iter_385_1.color.r, 0.5, var_385_3)

								iter_385_1.color = Color.New(var_385_7, var_385_7, var_385_7)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps10128 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_385_3 then
						if arg_382_1.isInRecall_ then
							iter_385_3.color = arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_385_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps10128 = nil
			end

			local var_385_8 = 1.73333333333333
			local var_385_9 = 1

			if var_385_8 < arg_382_1.time_ and arg_382_1.time_ <= var_385_8 + arg_385_0 then
				local var_385_10 = "play"
				local var_385_11 = "effect"

				arg_382_1:AudioAction(var_385_10, var_385_11, "se_story_1311", "se_story_1311_beetle01", "")
			end

			local var_385_12 = 0.1
			local var_385_13 = 1

			if var_385_12 < arg_382_1.time_ and arg_382_1.time_ <= var_385_12 + arg_385_0 then
				local var_385_14 = "play"
				local var_385_15 = "effect"

				arg_382_1:AudioAction(var_385_14, var_385_15, "se_story_1311", "se_story_1311_footstep02", "")
			end

			local var_385_16 = 0
			local var_385_17 = 1.6

			if var_385_16 < arg_382_1.time_ and arg_382_1.time_ <= var_385_16 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_18 = arg_382_1:GetWordFromCfg(417172091)
				local var_385_19 = arg_382_1:FormatText(var_385_18.content)

				arg_382_1.text_.text = var_385_19

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_20 = 64
				local var_385_21 = utf8.len(var_385_19)
				local var_385_22 = var_385_20 <= 0 and var_385_17 or var_385_17 * (var_385_21 / var_385_20)

				if var_385_22 > 0 and var_385_17 < var_385_22 then
					arg_382_1.talkMaxDuration = var_385_22

					if var_385_22 + var_385_16 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_22 + var_385_16
					end
				end

				arg_382_1.text_.text = var_385_19
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_23 = math.max(var_385_17, arg_382_1.talkMaxDuration)

			if var_385_16 <= arg_382_1.time_ and arg_382_1.time_ < var_385_16 + var_385_23 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_16) / var_385_23

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_16 + var_385_23 and arg_382_1.time_ < var_385_16 + var_385_23 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play417172092 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 417172092
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play417172093(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.1
			local var_389_1 = 1

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				local var_389_2 = "play"
				local var_389_3 = "effect"

				arg_386_1:AudioAction(var_389_2, var_389_3, "se_story_1311", "se_story_1311_beetle02", "")
			end

			local var_389_4 = 0
			local var_389_5 = 1.275

			if var_389_4 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_6 = arg_386_1:GetWordFromCfg(417172092)
				local var_389_7 = arg_386_1:FormatText(var_389_6.content)

				arg_386_1.text_.text = var_389_7

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_8 = 51
				local var_389_9 = utf8.len(var_389_7)
				local var_389_10 = var_389_8 <= 0 and var_389_5 or var_389_5 * (var_389_9 / var_389_8)

				if var_389_10 > 0 and var_389_5 < var_389_10 then
					arg_386_1.talkMaxDuration = var_389_10

					if var_389_10 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_4
					end
				end

				arg_386_1.text_.text = var_389_7
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_11 = math.max(var_389_5, arg_386_1.talkMaxDuration)

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_11 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_4) / var_389_11

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_4 + var_389_11 and arg_386_1.time_ < var_389_4 + var_389_11 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play417172093 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 417172093
		arg_390_1.duration_ = 9.07

		local var_390_0 = {
			zh = 7.833,
			ja = 9.066
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play417172094(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.85

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[672].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_3 = arg_390_1:GetWordFromCfg(417172093)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 34
				local var_393_6 = utf8.len(var_393_4)
				local var_393_7 = var_393_5 <= 0 and var_393_1 or var_393_1 * (var_393_6 / var_393_5)

				if var_393_7 > 0 and var_393_1 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172093", "story_v_out_417172.awb") ~= 0 then
					local var_393_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172093", "story_v_out_417172.awb") / 1000

					if var_393_8 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_8 + var_393_0
					end

					if var_393_3.prefab_name ~= "" and arg_390_1.actors_[var_393_3.prefab_name] ~= nil then
						local var_393_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_3.prefab_name].transform, "story_v_out_417172", "417172093", "story_v_out_417172.awb")

						arg_390_1:RecordAudio("417172093", var_393_9)
						arg_390_1:RecordAudio("417172093", var_393_9)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_417172", "417172093", "story_v_out_417172.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_417172", "417172093", "story_v_out_417172.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_10 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_10 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_10

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_10 and arg_390_1.time_ < var_393_0 + var_393_10 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play417172094 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 417172094
		arg_394_1.duration_ = 9.73

		local var_394_0 = {
			zh = 6.433,
			ja = 9.733
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play417172095(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.775

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_2 = arg_394_1:FormatText(StoryNameCfg[672].name)

				arg_394_1.leftNameTxt_.text = var_397_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:GetWordFromCfg(417172094)
				local var_397_4 = arg_394_1:FormatText(var_397_3.content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 31
				local var_397_6 = utf8.len(var_397_4)
				local var_397_7 = var_397_5 <= 0 and var_397_1 or var_397_1 * (var_397_6 / var_397_5)

				if var_397_7 > 0 and var_397_1 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172094", "story_v_out_417172.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172094", "story_v_out_417172.awb") / 1000

					if var_397_8 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_0
					end

					if var_397_3.prefab_name ~= "" and arg_394_1.actors_[var_397_3.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_3.prefab_name].transform, "story_v_out_417172", "417172094", "story_v_out_417172.awb")

						arg_394_1:RecordAudio("417172094", var_397_9)
						arg_394_1:RecordAudio("417172094", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_417172", "417172094", "story_v_out_417172.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_417172", "417172094", "story_v_out_417172.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_10 and arg_394_1.time_ < var_397_0 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play417172095 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 417172095
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play417172096(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 1.15

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_2 = arg_398_1:GetWordFromCfg(417172095)
				local var_401_3 = arg_398_1:FormatText(var_401_2.content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 46
				local var_401_5 = utf8.len(var_401_3)
				local var_401_6 = var_401_4 <= 0 and var_401_1 or var_401_1 * (var_401_5 / var_401_4)

				if var_401_6 > 0 and var_401_1 < var_401_6 then
					arg_398_1.talkMaxDuration = var_401_6

					if var_401_6 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_7 and arg_398_1.time_ < var_401_0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play417172096 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 417172096
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play417172097(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 1.075

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, false)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_2 = arg_402_1:GetWordFromCfg(417172096)
				local var_405_3 = arg_402_1:FormatText(var_405_2.content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 43
				local var_405_5 = utf8.len(var_405_3)
				local var_405_6 = var_405_4 <= 0 and var_405_1 or var_405_1 * (var_405_5 / var_405_4)

				if var_405_6 > 0 and var_405_1 < var_405_6 then
					arg_402_1.talkMaxDuration = var_405_6

					if var_405_6 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_6 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_7 and arg_402_1.time_ < var_405_0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play417172097 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 417172097
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play417172098(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 1.325

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_2 = arg_406_1:GetWordFromCfg(417172097)
				local var_409_3 = arg_406_1:FormatText(var_409_2.content)

				arg_406_1.text_.text = var_409_3

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 53
				local var_409_5 = utf8.len(var_409_3)
				local var_409_6 = var_409_4 <= 0 and var_409_1 or var_409_1 * (var_409_5 / var_409_4)

				if var_409_6 > 0 and var_409_1 < var_409_6 then
					arg_406_1.talkMaxDuration = var_409_6

					if var_409_6 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_6 + var_409_0
					end
				end

				arg_406_1.text_.text = var_409_3
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_1, arg_406_1.talkMaxDuration)

			if var_409_0 <= arg_406_1.time_ and arg_406_1.time_ < var_409_0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_0 + var_409_7 and arg_406_1.time_ < var_409_0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play417172098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 417172098
		arg_410_1.duration_ = 9.47

		local var_410_0 = {
			zh = 9.466,
			ja = 9.3
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play417172099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 4

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.allBtn_.enabled = false
			end

			local var_413_1 = 0.3

			if arg_410_1.time_ >= var_413_0 + var_413_1 and arg_410_1.time_ < var_413_0 + var_413_1 + arg_413_0 then
				arg_410_1.allBtn_.enabled = true
			end

			local var_413_2 = 2

			if var_413_2 < arg_410_1.time_ and arg_410_1.time_ <= var_413_2 + arg_413_0 then
				local var_413_3 = manager.ui.mainCamera.transform.localPosition
				local var_413_4 = Vector3.New(0, 0, 10) + Vector3.New(var_413_3.x, var_413_3.y, 0)
				local var_413_5 = arg_410_1.bgs_.I17j

				var_413_5.transform.localPosition = var_413_4
				var_413_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_413_6 = var_413_5:GetComponent("SpriteRenderer")

				if var_413_6 and var_413_6.sprite then
					local var_413_7 = (var_413_5.transform.localPosition - var_413_3).z
					local var_413_8 = manager.ui.mainCameraCom_
					local var_413_9 = 2 * var_413_7 * Mathf.Tan(var_413_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_413_10 = var_413_9 * var_413_8.aspect
					local var_413_11 = var_413_6.sprite.bounds.size.x
					local var_413_12 = var_413_6.sprite.bounds.size.y
					local var_413_13 = var_413_10 / var_413_11
					local var_413_14 = var_413_9 / var_413_12
					local var_413_15 = var_413_14 < var_413_13 and var_413_13 or var_413_14

					var_413_5.transform.localScale = Vector3.New(var_413_15, var_413_15, 0)
				end

				for iter_413_0, iter_413_1 in pairs(arg_410_1.bgs_) do
					if iter_413_0 ~= "I17j" then
						iter_413_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_413_16 = 0

			if var_413_16 < arg_410_1.time_ and arg_410_1.time_ <= var_413_16 + arg_413_0 then
				arg_410_1.mask_.enabled = true
				arg_410_1.mask_.raycastTarget = true

				arg_410_1:SetGaussion(false)
			end

			local var_413_17 = 2

			if var_413_16 <= arg_410_1.time_ and arg_410_1.time_ < var_413_16 + var_413_17 then
				local var_413_18 = (arg_410_1.time_ - var_413_16) / var_413_17
				local var_413_19 = Color.New(0, 0, 0)

				var_413_19.a = Mathf.Lerp(0, 1, var_413_18)
				arg_410_1.mask_.color = var_413_19
			end

			if arg_410_1.time_ >= var_413_16 + var_413_17 and arg_410_1.time_ < var_413_16 + var_413_17 + arg_413_0 then
				local var_413_20 = Color.New(0, 0, 0)

				var_413_20.a = 1
				arg_410_1.mask_.color = var_413_20
			end

			local var_413_21 = 2

			if var_413_21 < arg_410_1.time_ and arg_410_1.time_ <= var_413_21 + arg_413_0 then
				arg_410_1.mask_.enabled = true
				arg_410_1.mask_.raycastTarget = true

				arg_410_1:SetGaussion(false)
			end

			local var_413_22 = 2

			if var_413_21 <= arg_410_1.time_ and arg_410_1.time_ < var_413_21 + var_413_22 then
				local var_413_23 = (arg_410_1.time_ - var_413_21) / var_413_22
				local var_413_24 = Color.New(0, 0, 0)

				var_413_24.a = Mathf.Lerp(1, 0, var_413_23)
				arg_410_1.mask_.color = var_413_24
			end

			if arg_410_1.time_ >= var_413_21 + var_413_22 and arg_410_1.time_ < var_413_21 + var_413_22 + arg_413_0 then
				local var_413_25 = Color.New(0, 0, 0)
				local var_413_26 = 0

				arg_410_1.mask_.enabled = false
				var_413_25.a = var_413_26
				arg_410_1.mask_.color = var_413_25
			end

			local var_413_27 = arg_410_1.actors_["10128"]
			local var_413_28 = 3.66666666666667

			if var_413_28 < arg_410_1.time_ and arg_410_1.time_ <= var_413_28 + arg_413_0 and not isNil(var_413_27) and arg_410_1.var_.actorSpriteComps10128 == nil then
				arg_410_1.var_.actorSpriteComps10128 = var_413_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_29 = 0.2

			if var_413_28 <= arg_410_1.time_ and arg_410_1.time_ < var_413_28 + var_413_29 and not isNil(var_413_27) then
				local var_413_30 = (arg_410_1.time_ - var_413_28) / var_413_29

				if arg_410_1.var_.actorSpriteComps10128 then
					for iter_413_2, iter_413_3 in pairs(arg_410_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_413_3 then
							if arg_410_1.isInRecall_ then
								local var_413_31 = Mathf.Lerp(iter_413_3.color.r, arg_410_1.hightColor1.r, var_413_30)
								local var_413_32 = Mathf.Lerp(iter_413_3.color.g, arg_410_1.hightColor1.g, var_413_30)
								local var_413_33 = Mathf.Lerp(iter_413_3.color.b, arg_410_1.hightColor1.b, var_413_30)

								iter_413_3.color = Color.New(var_413_31, var_413_32, var_413_33)
							else
								local var_413_34 = Mathf.Lerp(iter_413_3.color.r, 1, var_413_30)

								iter_413_3.color = Color.New(var_413_34, var_413_34, var_413_34)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= var_413_28 + var_413_29 and arg_410_1.time_ < var_413_28 + var_413_29 + arg_413_0 and not isNil(var_413_27) and arg_410_1.var_.actorSpriteComps10128 then
				for iter_413_4, iter_413_5 in pairs(arg_410_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_413_5 then
						if arg_410_1.isInRecall_ then
							iter_413_5.color = arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_413_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_410_1.var_.actorSpriteComps10128 = nil
			end

			local var_413_35 = arg_410_1.actors_["10128"].transform
			local var_413_36 = 3.66666666666667

			if var_413_36 < arg_410_1.time_ and arg_410_1.time_ <= var_413_36 + arg_413_0 then
				arg_410_1.var_.moveOldPos10128 = var_413_35.localPosition
				var_413_35.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("10128", 3)

				local var_413_37 = var_413_35.childCount

				for iter_413_6 = 0, var_413_37 - 1 do
					local var_413_38 = var_413_35:GetChild(iter_413_6)

					if var_413_38.name == "" or not string.find(var_413_38.name, "split") then
						var_413_38.gameObject:SetActive(true)
					else
						var_413_38.gameObject:SetActive(false)
					end
				end
			end

			local var_413_39 = 0.001

			if var_413_36 <= arg_410_1.time_ and arg_410_1.time_ < var_413_36 + var_413_39 then
				local var_413_40 = (arg_410_1.time_ - var_413_36) / var_413_39
				local var_413_41 = Vector3.New(0, -347, -300)

				var_413_35.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos10128, var_413_41, var_413_40)
			end

			if arg_410_1.time_ >= var_413_36 + var_413_39 and arg_410_1.time_ < var_413_36 + var_413_39 + arg_413_0 then
				var_413_35.localPosition = Vector3.New(0, -347, -300)
			end

			local var_413_42 = arg_410_1.actors_["10128"]
			local var_413_43 = 3.66666666666667

			if var_413_43 < arg_410_1.time_ and arg_410_1.time_ <= var_413_43 + arg_413_0 then
				local var_413_44 = var_413_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_413_44 then
					arg_410_1.var_.alphaOldValue10128 = var_413_44.alpha
					arg_410_1.var_.characterEffect10128 = var_413_44
				end

				arg_410_1.var_.alphaOldValue10128 = 0
			end

			local var_413_45 = 0.333333333333333

			if var_413_43 <= arg_410_1.time_ and arg_410_1.time_ < var_413_43 + var_413_45 then
				local var_413_46 = (arg_410_1.time_ - var_413_43) / var_413_45
				local var_413_47 = Mathf.Lerp(arg_410_1.var_.alphaOldValue10128, 1, var_413_46)

				if arg_410_1.var_.characterEffect10128 then
					arg_410_1.var_.characterEffect10128.alpha = var_413_47
				end
			end

			if arg_410_1.time_ >= var_413_43 + var_413_45 and arg_410_1.time_ < var_413_43 + var_413_45 + arg_413_0 and arg_410_1.var_.characterEffect10128 then
				arg_410_1.var_.characterEffect10128.alpha = 1
			end

			if arg_410_1.frameCnt_ <= 1 then
				arg_410_1.dialog_:SetActive(false)
			end

			local var_413_48 = 4
			local var_413_49 = 0.575

			if var_413_48 < arg_410_1.time_ and arg_410_1.time_ <= var_413_48 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0

				arg_410_1.dialog_:SetActive(true)

				arg_410_1.dialogCg_.alpha = 0

				local var_413_50 = LeanTween.value(arg_410_1.dialog_, 0, 1, 0.3)

				var_413_50:setOnUpdate(LuaHelper.FloatAction(function(arg_414_0)
					arg_410_1.dialogCg_.alpha = arg_414_0
				end))
				var_413_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_410_1.dialog_)
					var_413_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_410_1.duration_ = arg_410_1.duration_ + 0.3

				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_51 = arg_410_1:FormatText(StoryNameCfg[595].name)

				arg_410_1.leftNameTxt_.text = var_413_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_52 = arg_410_1:GetWordFromCfg(417172098)
				local var_413_53 = arg_410_1:FormatText(var_413_52.content)

				arg_410_1.text_.text = var_413_53

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_54 = 23
				local var_413_55 = utf8.len(var_413_53)
				local var_413_56 = var_413_54 <= 0 and var_413_49 or var_413_49 * (var_413_55 / var_413_54)

				if var_413_56 > 0 and var_413_49 < var_413_56 then
					arg_410_1.talkMaxDuration = var_413_56
					var_413_48 = var_413_48 + 0.3

					if var_413_56 + var_413_48 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_56 + var_413_48
					end
				end

				arg_410_1.text_.text = var_413_53
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172098", "story_v_out_417172.awb") ~= 0 then
					local var_413_57 = manager.audio:GetVoiceLength("story_v_out_417172", "417172098", "story_v_out_417172.awb") / 1000

					if var_413_57 + var_413_48 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_57 + var_413_48
					end

					if var_413_52.prefab_name ~= "" and arg_410_1.actors_[var_413_52.prefab_name] ~= nil then
						local var_413_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_52.prefab_name].transform, "story_v_out_417172", "417172098", "story_v_out_417172.awb")

						arg_410_1:RecordAudio("417172098", var_413_58)
						arg_410_1:RecordAudio("417172098", var_413_58)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_417172", "417172098", "story_v_out_417172.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_417172", "417172098", "story_v_out_417172.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_59 = var_413_48 + 0.3
			local var_413_60 = math.max(var_413_49, arg_410_1.talkMaxDuration)

			if var_413_59 <= arg_410_1.time_ and arg_410_1.time_ < var_413_59 + var_413_60 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_59) / var_413_60

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_59 + var_413_60 and arg_410_1.time_ < var_413_59 + var_413_60 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play417172099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 417172099
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play417172100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["10128"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps10128 == nil then
				arg_416_1.var_.actorSpriteComps10128 = var_419_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_2 = 0.2

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.actorSpriteComps10128 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								local var_419_4 = Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor2.r, var_419_3)
								local var_419_5 = Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor2.g, var_419_3)
								local var_419_6 = Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor2.b, var_419_3)

								iter_419_1.color = Color.New(var_419_4, var_419_5, var_419_6)
							else
								local var_419_7 = Mathf.Lerp(iter_419_1.color.r, 0.5, var_419_3)

								iter_419_1.color = Color.New(var_419_7, var_419_7, var_419_7)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps10128 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_419_3 then
						if arg_416_1.isInRecall_ then
							iter_419_3.color = arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_419_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps10128 = nil
			end

			local var_419_8 = 0
			local var_419_9 = 1

			if var_419_8 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				local var_419_10 = "play"
				local var_419_11 = "effect"

				arg_416_1:AudioAction(var_419_10, var_419_11, "se_story_side_1080", "se_story_1080_door", "")
			end

			local var_419_12 = 0
			local var_419_13 = 1

			if var_419_12 < arg_416_1.time_ and arg_416_1.time_ <= var_419_12 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, false)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_14 = arg_416_1:GetWordFromCfg(417172099)
				local var_419_15 = arg_416_1:FormatText(var_419_14.content)

				arg_416_1.text_.text = var_419_15

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_16 = 40
				local var_419_17 = utf8.len(var_419_15)
				local var_419_18 = var_419_16 <= 0 and var_419_13 or var_419_13 * (var_419_17 / var_419_16)

				if var_419_18 > 0 and var_419_13 < var_419_18 then
					arg_416_1.talkMaxDuration = var_419_18

					if var_419_18 + var_419_12 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_18 + var_419_12
					end
				end

				arg_416_1.text_.text = var_419_15
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_19 = math.max(var_419_13, arg_416_1.talkMaxDuration)

			if var_419_12 <= arg_416_1.time_ and arg_416_1.time_ < var_419_12 + var_419_19 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_12) / var_419_19

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_12 + var_419_19 and arg_416_1.time_ < var_419_12 + var_419_19 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play417172100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 417172100
		arg_420_1.duration_ = 7.5

		local var_420_0 = {
			zh = 7,
			ja = 7.5
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
				arg_420_0:Play417172101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10128"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.actorSpriteComps10128 == nil then
				arg_420_1.var_.actorSpriteComps10128 = var_423_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_2 = 0.2

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.actorSpriteComps10128 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_423_1 then
							if arg_420_1.isInRecall_ then
								local var_423_4 = Mathf.Lerp(iter_423_1.color.r, arg_420_1.hightColor1.r, var_423_3)
								local var_423_5 = Mathf.Lerp(iter_423_1.color.g, arg_420_1.hightColor1.g, var_423_3)
								local var_423_6 = Mathf.Lerp(iter_423_1.color.b, arg_420_1.hightColor1.b, var_423_3)

								iter_423_1.color = Color.New(var_423_4, var_423_5, var_423_6)
							else
								local var_423_7 = Mathf.Lerp(iter_423_1.color.r, 1, var_423_3)

								iter_423_1.color = Color.New(var_423_7, var_423_7, var_423_7)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.actorSpriteComps10128 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_423_3 then
						if arg_420_1.isInRecall_ then
							iter_423_3.color = arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_423_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_420_1.var_.actorSpriteComps10128 = nil
			end

			local var_423_8 = 0
			local var_423_9 = 0.8

			if var_423_8 < arg_420_1.time_ and arg_420_1.time_ <= var_423_8 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_10 = arg_420_1:FormatText(StoryNameCfg[595].name)

				arg_420_1.leftNameTxt_.text = var_423_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_11 = arg_420_1:GetWordFromCfg(417172100)
				local var_423_12 = arg_420_1:FormatText(var_423_11.content)

				arg_420_1.text_.text = var_423_12

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_13 = 32
				local var_423_14 = utf8.len(var_423_12)
				local var_423_15 = var_423_13 <= 0 and var_423_9 or var_423_9 * (var_423_14 / var_423_13)

				if var_423_15 > 0 and var_423_9 < var_423_15 then
					arg_420_1.talkMaxDuration = var_423_15

					if var_423_15 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_15 + var_423_8
					end
				end

				arg_420_1.text_.text = var_423_12
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172100", "story_v_out_417172.awb") ~= 0 then
					local var_423_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172100", "story_v_out_417172.awb") / 1000

					if var_423_16 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_16 + var_423_8
					end

					if var_423_11.prefab_name ~= "" and arg_420_1.actors_[var_423_11.prefab_name] ~= nil then
						local var_423_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_11.prefab_name].transform, "story_v_out_417172", "417172100", "story_v_out_417172.awb")

						arg_420_1:RecordAudio("417172100", var_423_17)
						arg_420_1:RecordAudio("417172100", var_423_17)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_417172", "417172100", "story_v_out_417172.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_417172", "417172100", "story_v_out_417172.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_18 = math.max(var_423_9, arg_420_1.talkMaxDuration)

			if var_423_8 <= arg_420_1.time_ and arg_420_1.time_ < var_423_8 + var_423_18 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_8) / var_423_18

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_8 + var_423_18 and arg_420_1.time_ < var_423_8 + var_423_18 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play417172101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 417172101
		arg_424_1.duration_ = 2.3

		local var_424_0 = {
			zh = 1.83266666666667,
			ja = 2.29966666666667
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
				arg_424_0:Play417172102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = "10120"

			if arg_424_1.actors_[var_427_0] == nil then
				local var_427_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10120")

				if not isNil(var_427_1) then
					local var_427_2 = Object.Instantiate(var_427_1, arg_424_1.canvasGo_.transform)

					var_427_2.transform:SetSiblingIndex(1)

					var_427_2.name = var_427_0
					var_427_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_424_1.actors_[var_427_0] = var_427_2

					local var_427_3 = var_427_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_424_1.isInRecall_ then
						for iter_427_0, iter_427_1 in ipairs(var_427_3) do
							iter_427_1.color = arg_424_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_427_4 = arg_424_1.actors_["10120"]
			local var_427_5 = 0.166666666666667

			if var_427_5 < arg_424_1.time_ and arg_424_1.time_ <= var_427_5 + arg_427_0 and not isNil(var_427_4) and arg_424_1.var_.actorSpriteComps10120 == nil then
				arg_424_1.var_.actorSpriteComps10120 = var_427_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_427_6 = 0.2

			if var_427_5 <= arg_424_1.time_ and arg_424_1.time_ < var_427_5 + var_427_6 and not isNil(var_427_4) then
				local var_427_7 = (arg_424_1.time_ - var_427_5) / var_427_6

				if arg_424_1.var_.actorSpriteComps10120 then
					for iter_427_2, iter_427_3 in pairs(arg_424_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_427_3 then
							if arg_424_1.isInRecall_ then
								local var_427_8 = Mathf.Lerp(iter_427_3.color.r, arg_424_1.hightColor1.r, var_427_7)
								local var_427_9 = Mathf.Lerp(iter_427_3.color.g, arg_424_1.hightColor1.g, var_427_7)
								local var_427_10 = Mathf.Lerp(iter_427_3.color.b, arg_424_1.hightColor1.b, var_427_7)

								iter_427_3.color = Color.New(var_427_8, var_427_9, var_427_10)
							else
								local var_427_11 = Mathf.Lerp(iter_427_3.color.r, 1, var_427_7)

								iter_427_3.color = Color.New(var_427_11, var_427_11, var_427_11)
							end
						end
					end
				end
			end

			if arg_424_1.time_ >= var_427_5 + var_427_6 and arg_424_1.time_ < var_427_5 + var_427_6 + arg_427_0 and not isNil(var_427_4) and arg_424_1.var_.actorSpriteComps10120 then
				for iter_427_4, iter_427_5 in pairs(arg_424_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_427_5 then
						if arg_424_1.isInRecall_ then
							iter_427_5.color = arg_424_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_427_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_424_1.var_.actorSpriteComps10120 = nil
			end

			local var_427_12 = arg_424_1.actors_["10120"].transform
			local var_427_13 = 0.166666666666667

			if var_427_13 < arg_424_1.time_ and arg_424_1.time_ <= var_427_13 + arg_427_0 then
				arg_424_1.var_.moveOldPos10120 = var_427_12.localPosition
				var_427_12.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10120", 3)

				local var_427_14 = var_427_12.childCount

				for iter_427_6 = 0, var_427_14 - 1 do
					local var_427_15 = var_427_12:GetChild(iter_427_6)

					if var_427_15.name == "" or not string.find(var_427_15.name, "split") then
						var_427_15.gameObject:SetActive(true)
					else
						var_427_15.gameObject:SetActive(false)
					end
				end
			end

			local var_427_16 = 0.001

			if var_427_13 <= arg_424_1.time_ and arg_424_1.time_ < var_427_13 + var_427_16 then
				local var_427_17 = (arg_424_1.time_ - var_427_13) / var_427_16
				local var_427_18 = Vector3.New(0, -260.5, -275)

				var_427_12.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10120, var_427_18, var_427_17)
			end

			if arg_424_1.time_ >= var_427_13 + var_427_16 and arg_424_1.time_ < var_427_13 + var_427_16 + arg_427_0 then
				var_427_12.localPosition = Vector3.New(0, -260.5, -275)
			end

			local var_427_19 = manager.ui.mainCamera.transform
			local var_427_20 = 0

			if var_427_20 < arg_424_1.time_ and arg_424_1.time_ <= var_427_20 + arg_427_0 then
				arg_424_1.var_.shakeOldPos = var_427_19.localPosition
			end

			local var_427_21 = 0.5

			if var_427_20 <= arg_424_1.time_ and arg_424_1.time_ < var_427_20 + var_427_21 then
				local var_427_22 = (arg_424_1.time_ - var_427_20) / 0.066
				local var_427_23, var_427_24 = math.modf(var_427_22)

				var_427_19.localPosition = Vector3.New(var_427_24 * 0.13, var_427_24 * 0.13, var_427_24 * 0.13) + arg_424_1.var_.shakeOldPos
			end

			if arg_424_1.time_ >= var_427_20 + var_427_21 and arg_424_1.time_ < var_427_20 + var_427_21 + arg_427_0 then
				var_427_19.localPosition = arg_424_1.var_.shakeOldPos
			end

			local var_427_25 = 0.566666666666667
			local var_427_26 = 0.166666666666667

			if var_427_25 < arg_424_1.time_ and arg_424_1.time_ <= var_427_25 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_27 = arg_424_1:FormatText(StoryNameCfg[1145].name)

				arg_424_1.leftNameTxt_.text = var_427_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_28 = arg_424_1:GetWordFromCfg(417172101)
				local var_427_29 = arg_424_1:FormatText(var_427_28.content)

				arg_424_1.text_.text = var_427_29

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_30 = 3
				local var_427_31 = utf8.len(var_427_29)
				local var_427_32 = var_427_30 <= 0 and var_427_26 or var_427_26 * (var_427_31 / var_427_30)

				if var_427_32 > 0 and var_427_26 < var_427_32 then
					arg_424_1.talkMaxDuration = var_427_32

					if var_427_32 + var_427_25 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_32 + var_427_25
					end
				end

				arg_424_1.text_.text = var_427_29
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172101", "story_v_out_417172.awb") ~= 0 then
					local var_427_33 = manager.audio:GetVoiceLength("story_v_out_417172", "417172101", "story_v_out_417172.awb") / 1000

					if var_427_33 + var_427_25 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_33 + var_427_25
					end

					if var_427_28.prefab_name ~= "" and arg_424_1.actors_[var_427_28.prefab_name] ~= nil then
						local var_427_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_28.prefab_name].transform, "story_v_out_417172", "417172101", "story_v_out_417172.awb")

						arg_424_1:RecordAudio("417172101", var_427_34)
						arg_424_1:RecordAudio("417172101", var_427_34)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_417172", "417172101", "story_v_out_417172.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_417172", "417172101", "story_v_out_417172.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_35 = math.max(var_427_26, arg_424_1.talkMaxDuration)

			if var_427_25 <= arg_424_1.time_ and arg_424_1.time_ < var_427_25 + var_427_35 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_25) / var_427_35

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_25 + var_427_35 and arg_424_1.time_ < var_427_25 + var_427_35 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play417172102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 417172102
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play417172103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["10120"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.actorSpriteComps10120 == nil then
				arg_428_1.var_.actorSpriteComps10120 = var_431_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_431_2 = 0.2

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.actorSpriteComps10120 then
					for iter_431_0, iter_431_1 in pairs(arg_428_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_431_1 then
							if arg_428_1.isInRecall_ then
								local var_431_4 = Mathf.Lerp(iter_431_1.color.r, arg_428_1.hightColor2.r, var_431_3)
								local var_431_5 = Mathf.Lerp(iter_431_1.color.g, arg_428_1.hightColor2.g, var_431_3)
								local var_431_6 = Mathf.Lerp(iter_431_1.color.b, arg_428_1.hightColor2.b, var_431_3)

								iter_431_1.color = Color.New(var_431_4, var_431_5, var_431_6)
							else
								local var_431_7 = Mathf.Lerp(iter_431_1.color.r, 0.5, var_431_3)

								iter_431_1.color = Color.New(var_431_7, var_431_7, var_431_7)
							end
						end
					end
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.actorSpriteComps10120 then
				for iter_431_2, iter_431_3 in pairs(arg_428_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_431_3 then
						if arg_428_1.isInRecall_ then
							iter_431_3.color = arg_428_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_431_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_428_1.var_.actorSpriteComps10120 = nil
			end

			local var_431_8 = arg_428_1.actors_["10120"].transform
			local var_431_9 = 0

			if var_431_9 < arg_428_1.time_ and arg_428_1.time_ <= var_431_9 + arg_431_0 then
				arg_428_1.var_.moveOldPos10120 = var_431_8.localPosition
				var_431_8.localScale = Vector3.New(1, 1, 1)

				arg_428_1:CheckSpriteTmpPos("10120", 7)

				local var_431_10 = var_431_8.childCount

				for iter_431_4 = 0, var_431_10 - 1 do
					local var_431_11 = var_431_8:GetChild(iter_431_4)

					if var_431_11.name == "" or not string.find(var_431_11.name, "split") then
						var_431_11.gameObject:SetActive(true)
					else
						var_431_11.gameObject:SetActive(false)
					end
				end
			end

			local var_431_12 = 0.001

			if var_431_9 <= arg_428_1.time_ and arg_428_1.time_ < var_431_9 + var_431_12 then
				local var_431_13 = (arg_428_1.time_ - var_431_9) / var_431_12
				local var_431_14 = Vector3.New(0, -2000, 0)

				var_431_8.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos10120, var_431_14, var_431_13)
			end

			if arg_428_1.time_ >= var_431_9 + var_431_12 and arg_428_1.time_ < var_431_9 + var_431_12 + arg_431_0 then
				var_431_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_431_15 = 0
			local var_431_16 = 0.75

			if var_431_15 < arg_428_1.time_ and arg_428_1.time_ <= var_431_15 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_17 = arg_428_1:GetWordFromCfg(417172102)
				local var_431_18 = arg_428_1:FormatText(var_431_17.content)

				arg_428_1.text_.text = var_431_18

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_19 = 30
				local var_431_20 = utf8.len(var_431_18)
				local var_431_21 = var_431_19 <= 0 and var_431_16 or var_431_16 * (var_431_20 / var_431_19)

				if var_431_21 > 0 and var_431_16 < var_431_21 then
					arg_428_1.talkMaxDuration = var_431_21

					if var_431_21 + var_431_15 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_21 + var_431_15
					end
				end

				arg_428_1.text_.text = var_431_18
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_22 = math.max(var_431_16, arg_428_1.talkMaxDuration)

			if var_431_15 <= arg_428_1.time_ and arg_428_1.time_ < var_431_15 + var_431_22 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_15) / var_431_22

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_15 + var_431_22 and arg_428_1.time_ < var_431_15 + var_431_22 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
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
	Play417172103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 417172103
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play417172104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 1.025

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_2 = arg_432_1:GetWordFromCfg(417172103)
				local var_435_3 = arg_432_1:FormatText(var_435_2.content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 41
				local var_435_5 = utf8.len(var_435_3)
				local var_435_6 = var_435_4 <= 0 and var_435_1 or var_435_1 * (var_435_5 / var_435_4)

				if var_435_6 > 0 and var_435_1 < var_435_6 then
					arg_432_1.talkMaxDuration = var_435_6

					if var_435_6 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_6 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_7 and arg_432_1.time_ < var_435_0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play417172104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 417172104
		arg_436_1.duration_ = 2.3

		local var_436_0 = {
			zh = 2.3,
			ja = 1.833
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
				arg_436_0:Play417172105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["10128"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps10128 == nil then
				arg_436_1.var_.actorSpriteComps10128 = var_439_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_439_2 = 0.2

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.actorSpriteComps10128 then
					for iter_439_0, iter_439_1 in pairs(arg_436_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_439_1 then
							if arg_436_1.isInRecall_ then
								local var_439_4 = Mathf.Lerp(iter_439_1.color.r, arg_436_1.hightColor1.r, var_439_3)
								local var_439_5 = Mathf.Lerp(iter_439_1.color.g, arg_436_1.hightColor1.g, var_439_3)
								local var_439_6 = Mathf.Lerp(iter_439_1.color.b, arg_436_1.hightColor1.b, var_439_3)

								iter_439_1.color = Color.New(var_439_4, var_439_5, var_439_6)
							else
								local var_439_7 = Mathf.Lerp(iter_439_1.color.r, 1, var_439_3)

								iter_439_1.color = Color.New(var_439_7, var_439_7, var_439_7)
							end
						end
					end
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.actorSpriteComps10128 then
				for iter_439_2, iter_439_3 in pairs(arg_436_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_439_3 then
						if arg_436_1.isInRecall_ then
							iter_439_3.color = arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_439_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_436_1.var_.actorSpriteComps10128 = nil
			end

			local var_439_8 = arg_436_1.actors_["10128"].transform
			local var_439_9 = 0

			if var_439_9 < arg_436_1.time_ and arg_436_1.time_ <= var_439_9 + arg_439_0 then
				arg_436_1.var_.moveOldPos10128 = var_439_8.localPosition
				var_439_8.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("10128", 3)

				local var_439_10 = var_439_8.childCount

				for iter_439_4 = 0, var_439_10 - 1 do
					local var_439_11 = var_439_8:GetChild(iter_439_4)

					if var_439_11.name == "split_2" or not string.find(var_439_11.name, "split") then
						var_439_11.gameObject:SetActive(true)
					else
						var_439_11.gameObject:SetActive(false)
					end
				end
			end

			local var_439_12 = 0.001

			if var_439_9 <= arg_436_1.time_ and arg_436_1.time_ < var_439_9 + var_439_12 then
				local var_439_13 = (arg_436_1.time_ - var_439_9) / var_439_12
				local var_439_14 = Vector3.New(0, -347, -300)

				var_439_8.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10128, var_439_14, var_439_13)
			end

			if arg_436_1.time_ >= var_439_9 + var_439_12 and arg_436_1.time_ < var_439_9 + var_439_12 + arg_439_0 then
				var_439_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_439_15 = 0
			local var_439_16 = 0.3

			if var_439_15 < arg_436_1.time_ and arg_436_1.time_ <= var_439_15 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_17 = arg_436_1:FormatText(StoryNameCfg[595].name)

				arg_436_1.leftNameTxt_.text = var_439_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_18 = arg_436_1:GetWordFromCfg(417172104)
				local var_439_19 = arg_436_1:FormatText(var_439_18.content)

				arg_436_1.text_.text = var_439_19

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_20 = 12
				local var_439_21 = utf8.len(var_439_19)
				local var_439_22 = var_439_20 <= 0 and var_439_16 or var_439_16 * (var_439_21 / var_439_20)

				if var_439_22 > 0 and var_439_16 < var_439_22 then
					arg_436_1.talkMaxDuration = var_439_22

					if var_439_22 + var_439_15 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_22 + var_439_15
					end
				end

				arg_436_1.text_.text = var_439_19
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172104", "story_v_out_417172.awb") ~= 0 then
					local var_439_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172104", "story_v_out_417172.awb") / 1000

					if var_439_23 + var_439_15 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_23 + var_439_15
					end

					if var_439_18.prefab_name ~= "" and arg_436_1.actors_[var_439_18.prefab_name] ~= nil then
						local var_439_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_18.prefab_name].transform, "story_v_out_417172", "417172104", "story_v_out_417172.awb")

						arg_436_1:RecordAudio("417172104", var_439_24)
						arg_436_1:RecordAudio("417172104", var_439_24)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_417172", "417172104", "story_v_out_417172.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_417172", "417172104", "story_v_out_417172.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_25 = math.max(var_439_16, arg_436_1.talkMaxDuration)

			if var_439_15 <= arg_436_1.time_ and arg_436_1.time_ < var_439_15 + var_439_25 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_15) / var_439_25

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_15 + var_439_25 and arg_436_1.time_ < var_439_15 + var_439_25 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
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

		arg_436_1:InitPlayNodeList()
	end,
	Play417172105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 417172105
		arg_440_1.duration_ = 2.13

		local var_440_0 = {
			zh = 1.366,
			ja = 2.133
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
				arg_440_0:Play417172106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["10120"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.actorSpriteComps10120 == nil then
				arg_440_1.var_.actorSpriteComps10120 = var_443_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_2 = 0.2

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.actorSpriteComps10120 then
					for iter_443_0, iter_443_1 in pairs(arg_440_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_443_1 then
							if arg_440_1.isInRecall_ then
								local var_443_4 = Mathf.Lerp(iter_443_1.color.r, arg_440_1.hightColor1.r, var_443_3)
								local var_443_5 = Mathf.Lerp(iter_443_1.color.g, arg_440_1.hightColor1.g, var_443_3)
								local var_443_6 = Mathf.Lerp(iter_443_1.color.b, arg_440_1.hightColor1.b, var_443_3)

								iter_443_1.color = Color.New(var_443_4, var_443_5, var_443_6)
							else
								local var_443_7 = Mathf.Lerp(iter_443_1.color.r, 1, var_443_3)

								iter_443_1.color = Color.New(var_443_7, var_443_7, var_443_7)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.actorSpriteComps10120 then
				for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_443_3 then
						if arg_440_1.isInRecall_ then
							iter_443_3.color = arg_440_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_443_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_440_1.var_.actorSpriteComps10120 = nil
			end

			local var_443_8 = arg_440_1.actors_["10128"]
			local var_443_9 = 0

			if var_443_9 < arg_440_1.time_ and arg_440_1.time_ <= var_443_9 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps10128 == nil then
				arg_440_1.var_.actorSpriteComps10128 = var_443_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_10 = 0.2

			if var_443_9 <= arg_440_1.time_ and arg_440_1.time_ < var_443_9 + var_443_10 and not isNil(var_443_8) then
				local var_443_11 = (arg_440_1.time_ - var_443_9) / var_443_10

				if arg_440_1.var_.actorSpriteComps10128 then
					for iter_443_4, iter_443_5 in pairs(arg_440_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_443_5 then
							if arg_440_1.isInRecall_ then
								local var_443_12 = Mathf.Lerp(iter_443_5.color.r, arg_440_1.hightColor2.r, var_443_11)
								local var_443_13 = Mathf.Lerp(iter_443_5.color.g, arg_440_1.hightColor2.g, var_443_11)
								local var_443_14 = Mathf.Lerp(iter_443_5.color.b, arg_440_1.hightColor2.b, var_443_11)

								iter_443_5.color = Color.New(var_443_12, var_443_13, var_443_14)
							else
								local var_443_15 = Mathf.Lerp(iter_443_5.color.r, 0.5, var_443_11)

								iter_443_5.color = Color.New(var_443_15, var_443_15, var_443_15)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= var_443_9 + var_443_10 and arg_440_1.time_ < var_443_9 + var_443_10 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps10128 then
				for iter_443_6, iter_443_7 in pairs(arg_440_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_443_7 then
						if arg_440_1.isInRecall_ then
							iter_443_7.color = arg_440_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_443_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_440_1.var_.actorSpriteComps10128 = nil
			end

			local var_443_16 = arg_440_1.actors_["10128"].transform
			local var_443_17 = 0

			if var_443_17 < arg_440_1.time_ and arg_440_1.time_ <= var_443_17 + arg_443_0 then
				arg_440_1.var_.moveOldPos10128 = var_443_16.localPosition
				var_443_16.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10128", 2)

				local var_443_18 = var_443_16.childCount

				for iter_443_8 = 0, var_443_18 - 1 do
					local var_443_19 = var_443_16:GetChild(iter_443_8)

					if var_443_19.name == "" or not string.find(var_443_19.name, "split") then
						var_443_19.gameObject:SetActive(true)
					else
						var_443_19.gameObject:SetActive(false)
					end
				end
			end

			local var_443_20 = 0.001

			if var_443_17 <= arg_440_1.time_ and arg_440_1.time_ < var_443_17 + var_443_20 then
				local var_443_21 = (arg_440_1.time_ - var_443_17) / var_443_20
				local var_443_22 = Vector3.New(-390, -347, -300)

				var_443_16.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10128, var_443_22, var_443_21)
			end

			if arg_440_1.time_ >= var_443_17 + var_443_20 and arg_440_1.time_ < var_443_17 + var_443_20 + arg_443_0 then
				var_443_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_443_23 = arg_440_1.actors_["10120"].transform
			local var_443_24 = 0

			if var_443_24 < arg_440_1.time_ and arg_440_1.time_ <= var_443_24 + arg_443_0 then
				arg_440_1.var_.moveOldPos10120 = var_443_23.localPosition
				var_443_23.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10120", 4)

				local var_443_25 = var_443_23.childCount

				for iter_443_9 = 0, var_443_25 - 1 do
					local var_443_26 = var_443_23:GetChild(iter_443_9)

					if var_443_26.name == "" or not string.find(var_443_26.name, "split") then
						var_443_26.gameObject:SetActive(true)
					else
						var_443_26.gameObject:SetActive(false)
					end
				end
			end

			local var_443_27 = 0.001

			if var_443_24 <= arg_440_1.time_ and arg_440_1.time_ < var_443_24 + var_443_27 then
				local var_443_28 = (arg_440_1.time_ - var_443_24) / var_443_27
				local var_443_29 = Vector3.New(390, -260.5, -275)

				var_443_23.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10120, var_443_29, var_443_28)
			end

			if arg_440_1.time_ >= var_443_24 + var_443_27 and arg_440_1.time_ < var_443_24 + var_443_27 + arg_443_0 then
				var_443_23.localPosition = Vector3.New(390, -260.5, -275)
			end

			local var_443_30 = 0
			local var_443_31 = 0.175

			if var_443_30 < arg_440_1.time_ and arg_440_1.time_ <= var_443_30 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_32 = arg_440_1:FormatText(StoryNameCfg[1145].name)

				arg_440_1.leftNameTxt_.text = var_443_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_33 = arg_440_1:GetWordFromCfg(417172105)
				local var_443_34 = arg_440_1:FormatText(var_443_33.content)

				arg_440_1.text_.text = var_443_34

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_35 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172105", "story_v_out_417172.awb") ~= 0 then
					local var_443_38 = manager.audio:GetVoiceLength("story_v_out_417172", "417172105", "story_v_out_417172.awb") / 1000

					if var_443_38 + var_443_30 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_38 + var_443_30
					end

					if var_443_33.prefab_name ~= "" and arg_440_1.actors_[var_443_33.prefab_name] ~= nil then
						local var_443_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_33.prefab_name].transform, "story_v_out_417172", "417172105", "story_v_out_417172.awb")

						arg_440_1:RecordAudio("417172105", var_443_39)
						arg_440_1:RecordAudio("417172105", var_443_39)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_417172", "417172105", "story_v_out_417172.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_417172", "417172105", "story_v_out_417172.awb")
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
				actorName = "10120",
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
	Play417172106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 417172106
		arg_444_1.duration_ = 7.9

		local var_444_0 = {
			zh = 7.9,
			ja = 7.466
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
				arg_444_0:Play417172107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["10128"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps10128 == nil then
				arg_444_1.var_.actorSpriteComps10128 = var_447_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_2 = 0.2

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.actorSpriteComps10128 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_447_1 then
							if arg_444_1.isInRecall_ then
								local var_447_4 = Mathf.Lerp(iter_447_1.color.r, arg_444_1.hightColor1.r, var_447_3)
								local var_447_5 = Mathf.Lerp(iter_447_1.color.g, arg_444_1.hightColor1.g, var_447_3)
								local var_447_6 = Mathf.Lerp(iter_447_1.color.b, arg_444_1.hightColor1.b, var_447_3)

								iter_447_1.color = Color.New(var_447_4, var_447_5, var_447_6)
							else
								local var_447_7 = Mathf.Lerp(iter_447_1.color.r, 1, var_447_3)

								iter_447_1.color = Color.New(var_447_7, var_447_7, var_447_7)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.actorSpriteComps10128 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_447_3 then
						if arg_444_1.isInRecall_ then
							iter_447_3.color = arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_447_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps10128 = nil
			end

			local var_447_8 = arg_444_1.actors_["10120"]
			local var_447_9 = 0

			if var_447_9 < arg_444_1.time_ and arg_444_1.time_ <= var_447_9 + arg_447_0 and not isNil(var_447_8) and arg_444_1.var_.actorSpriteComps10120 == nil then
				arg_444_1.var_.actorSpriteComps10120 = var_447_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_10 = 0.2

			if var_447_9 <= arg_444_1.time_ and arg_444_1.time_ < var_447_9 + var_447_10 and not isNil(var_447_8) then
				local var_447_11 = (arg_444_1.time_ - var_447_9) / var_447_10

				if arg_444_1.var_.actorSpriteComps10120 then
					for iter_447_4, iter_447_5 in pairs(arg_444_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_447_5 then
							if arg_444_1.isInRecall_ then
								local var_447_12 = Mathf.Lerp(iter_447_5.color.r, arg_444_1.hightColor2.r, var_447_11)
								local var_447_13 = Mathf.Lerp(iter_447_5.color.g, arg_444_1.hightColor2.g, var_447_11)
								local var_447_14 = Mathf.Lerp(iter_447_5.color.b, arg_444_1.hightColor2.b, var_447_11)

								iter_447_5.color = Color.New(var_447_12, var_447_13, var_447_14)
							else
								local var_447_15 = Mathf.Lerp(iter_447_5.color.r, 0.5, var_447_11)

								iter_447_5.color = Color.New(var_447_15, var_447_15, var_447_15)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= var_447_9 + var_447_10 and arg_444_1.time_ < var_447_9 + var_447_10 + arg_447_0 and not isNil(var_447_8) and arg_444_1.var_.actorSpriteComps10120 then
				for iter_447_6, iter_447_7 in pairs(arg_444_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_447_7 then
						if arg_444_1.isInRecall_ then
							iter_447_7.color = arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_447_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_444_1.var_.actorSpriteComps10120 = nil
			end

			local var_447_16 = 0
			local var_447_17 = 0.975

			if var_447_16 < arg_444_1.time_ and arg_444_1.time_ <= var_447_16 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_18 = arg_444_1:FormatText(StoryNameCfg[595].name)

				arg_444_1.leftNameTxt_.text = var_447_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_19 = arg_444_1:GetWordFromCfg(417172106)
				local var_447_20 = arg_444_1:FormatText(var_447_19.content)

				arg_444_1.text_.text = var_447_20

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_21 = 39
				local var_447_22 = utf8.len(var_447_20)
				local var_447_23 = var_447_21 <= 0 and var_447_17 or var_447_17 * (var_447_22 / var_447_21)

				if var_447_23 > 0 and var_447_17 < var_447_23 then
					arg_444_1.talkMaxDuration = var_447_23

					if var_447_23 + var_447_16 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_23 + var_447_16
					end
				end

				arg_444_1.text_.text = var_447_20
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172106", "story_v_out_417172.awb") ~= 0 then
					local var_447_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172106", "story_v_out_417172.awb") / 1000

					if var_447_24 + var_447_16 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_24 + var_447_16
					end

					if var_447_19.prefab_name ~= "" and arg_444_1.actors_[var_447_19.prefab_name] ~= nil then
						local var_447_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_19.prefab_name].transform, "story_v_out_417172", "417172106", "story_v_out_417172.awb")

						arg_444_1:RecordAudio("417172106", var_447_25)
						arg_444_1:RecordAudio("417172106", var_447_25)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_417172", "417172106", "story_v_out_417172.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_417172", "417172106", "story_v_out_417172.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_26 = math.max(var_447_17, arg_444_1.talkMaxDuration)

			if var_447_16 <= arg_444_1.time_ and arg_444_1.time_ < var_447_16 + var_447_26 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_16) / var_447_26

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_16 + var_447_26 and arg_444_1.time_ < var_447_16 + var_447_26 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play417172107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 417172107
		arg_448_1.duration_ = 5.27

		local var_448_0 = {
			zh = 4.166,
			ja = 5.266
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
				arg_448_0:Play417172108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["10120"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps10120 == nil then
				arg_448_1.var_.actorSpriteComps10120 = var_451_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_2 = 0.2

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.actorSpriteComps10120 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps10120:ToTable()) do
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

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.actorSpriteComps10120 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_451_3 then
						if arg_448_1.isInRecall_ then
							iter_451_3.color = arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_451_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps10120 = nil
			end

			local var_451_8 = arg_448_1.actors_["10128"]
			local var_451_9 = 0

			if var_451_9 < arg_448_1.time_ and arg_448_1.time_ <= var_451_9 + arg_451_0 and not isNil(var_451_8) and arg_448_1.var_.actorSpriteComps10128 == nil then
				arg_448_1.var_.actorSpriteComps10128 = var_451_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_10 = 0.2

			if var_451_9 <= arg_448_1.time_ and arg_448_1.time_ < var_451_9 + var_451_10 and not isNil(var_451_8) then
				local var_451_11 = (arg_448_1.time_ - var_451_9) / var_451_10

				if arg_448_1.var_.actorSpriteComps10128 then
					for iter_451_4, iter_451_5 in pairs(arg_448_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_448_1.time_ >= var_451_9 + var_451_10 and arg_448_1.time_ < var_451_9 + var_451_10 + arg_451_0 and not isNil(var_451_8) and arg_448_1.var_.actorSpriteComps10128 then
				for iter_451_6, iter_451_7 in pairs(arg_448_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_451_7 then
						if arg_448_1.isInRecall_ then
							iter_451_7.color = arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_451_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_448_1.var_.actorSpriteComps10128 = nil
			end

			local var_451_16 = 0
			local var_451_17 = 0.45

			if var_451_16 < arg_448_1.time_ and arg_448_1.time_ <= var_451_16 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_18 = arg_448_1:FormatText(StoryNameCfg[1145].name)

				arg_448_1.leftNameTxt_.text = var_451_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_19 = arg_448_1:GetWordFromCfg(417172107)
				local var_451_20 = arg_448_1:FormatText(var_451_19.content)

				arg_448_1.text_.text = var_451_20

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_21 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172107", "story_v_out_417172.awb") ~= 0 then
					local var_451_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172107", "story_v_out_417172.awb") / 1000

					if var_451_24 + var_451_16 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_24 + var_451_16
					end

					if var_451_19.prefab_name ~= "" and arg_448_1.actors_[var_451_19.prefab_name] ~= nil then
						local var_451_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_19.prefab_name].transform, "story_v_out_417172", "417172107", "story_v_out_417172.awb")

						arg_448_1:RecordAudio("417172107", var_451_25)
						arg_448_1:RecordAudio("417172107", var_451_25)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_417172", "417172107", "story_v_out_417172.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_417172", "417172107", "story_v_out_417172.awb")
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
	Play417172108 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 417172108
		arg_452_1.duration_ = 9.8

		local var_452_0 = {
			zh = 6.9,
			ja = 9.8
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
				arg_452_0:Play417172109(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["10128"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps10128 == nil then
				arg_452_1.var_.actorSpriteComps10128 = var_455_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_2 = 0.2

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.actorSpriteComps10128 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								local var_455_4 = Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor1.r, var_455_3)
								local var_455_5 = Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor1.g, var_455_3)
								local var_455_6 = Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor1.b, var_455_3)

								iter_455_1.color = Color.New(var_455_4, var_455_5, var_455_6)
							else
								local var_455_7 = Mathf.Lerp(iter_455_1.color.r, 1, var_455_3)

								iter_455_1.color = Color.New(var_455_7, var_455_7, var_455_7)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.actorSpriteComps10128 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_455_3 then
						if arg_452_1.isInRecall_ then
							iter_455_3.color = arg_452_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_455_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_452_1.var_.actorSpriteComps10128 = nil
			end

			local var_455_8 = arg_452_1.actors_["10120"]
			local var_455_9 = 0

			if var_455_9 < arg_452_1.time_ and arg_452_1.time_ <= var_455_9 + arg_455_0 and not isNil(var_455_8) and arg_452_1.var_.actorSpriteComps10120 == nil then
				arg_452_1.var_.actorSpriteComps10120 = var_455_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_10 = 0.2

			if var_455_9 <= arg_452_1.time_ and arg_452_1.time_ < var_455_9 + var_455_10 and not isNil(var_455_8) then
				local var_455_11 = (arg_452_1.time_ - var_455_9) / var_455_10

				if arg_452_1.var_.actorSpriteComps10120 then
					for iter_455_4, iter_455_5 in pairs(arg_452_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_455_5 then
							if arg_452_1.isInRecall_ then
								local var_455_12 = Mathf.Lerp(iter_455_5.color.r, arg_452_1.hightColor2.r, var_455_11)
								local var_455_13 = Mathf.Lerp(iter_455_5.color.g, arg_452_1.hightColor2.g, var_455_11)
								local var_455_14 = Mathf.Lerp(iter_455_5.color.b, arg_452_1.hightColor2.b, var_455_11)

								iter_455_5.color = Color.New(var_455_12, var_455_13, var_455_14)
							else
								local var_455_15 = Mathf.Lerp(iter_455_5.color.r, 0.5, var_455_11)

								iter_455_5.color = Color.New(var_455_15, var_455_15, var_455_15)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= var_455_9 + var_455_10 and arg_452_1.time_ < var_455_9 + var_455_10 + arg_455_0 and not isNil(var_455_8) and arg_452_1.var_.actorSpriteComps10120 then
				for iter_455_6, iter_455_7 in pairs(arg_452_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_455_7 then
						if arg_452_1.isInRecall_ then
							iter_455_7.color = arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_455_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_452_1.var_.actorSpriteComps10120 = nil
			end

			local var_455_16 = 0
			local var_455_17 = 0.975

			if var_455_16 < arg_452_1.time_ and arg_452_1.time_ <= var_455_16 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_18 = arg_452_1:FormatText(StoryNameCfg[595].name)

				arg_452_1.leftNameTxt_.text = var_455_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_19 = arg_452_1:GetWordFromCfg(417172108)
				local var_455_20 = arg_452_1:FormatText(var_455_19.content)

				arg_452_1.text_.text = var_455_20

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_21 = 39
				local var_455_22 = utf8.len(var_455_20)
				local var_455_23 = var_455_21 <= 0 and var_455_17 or var_455_17 * (var_455_22 / var_455_21)

				if var_455_23 > 0 and var_455_17 < var_455_23 then
					arg_452_1.talkMaxDuration = var_455_23

					if var_455_23 + var_455_16 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_23 + var_455_16
					end
				end

				arg_452_1.text_.text = var_455_20
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172108", "story_v_out_417172.awb") ~= 0 then
					local var_455_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172108", "story_v_out_417172.awb") / 1000

					if var_455_24 + var_455_16 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_24 + var_455_16
					end

					if var_455_19.prefab_name ~= "" and arg_452_1.actors_[var_455_19.prefab_name] ~= nil then
						local var_455_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_19.prefab_name].transform, "story_v_out_417172", "417172108", "story_v_out_417172.awb")

						arg_452_1:RecordAudio("417172108", var_455_25)
						arg_452_1:RecordAudio("417172108", var_455_25)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_417172", "417172108", "story_v_out_417172.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_417172", "417172108", "story_v_out_417172.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_26 = math.max(var_455_17, arg_452_1.talkMaxDuration)

			if var_455_16 <= arg_452_1.time_ and arg_452_1.time_ < var_455_16 + var_455_26 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_16) / var_455_26

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_16 + var_455_26 and arg_452_1.time_ < var_455_16 + var_455_26 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play417172109 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 417172109
		arg_456_1.duration_ = 9.57

		local var_456_0 = {
			zh = 6.033,
			ja = 9.566
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
				arg_456_0:Play417172110(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 0.95

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[595].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_3 = arg_456_1:GetWordFromCfg(417172109)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172109", "story_v_out_417172.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172109", "story_v_out_417172.awb") / 1000

					if var_459_8 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_0
					end

					if var_459_3.prefab_name ~= "" and arg_456_1.actors_[var_459_3.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_3.prefab_name].transform, "story_v_out_417172", "417172109", "story_v_out_417172.awb")

						arg_456_1:RecordAudio("417172109", var_459_9)
						arg_456_1:RecordAudio("417172109", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_417172", "417172109", "story_v_out_417172.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_417172", "417172109", "story_v_out_417172.awb")
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
	Play417172110 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 417172110
		arg_460_1.duration_ = 7.63

		local var_460_0 = {
			zh = 6.066,
			ja = 7.633
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
				arg_460_0:Play417172111(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["10120"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps10120 == nil then
				arg_460_1.var_.actorSpriteComps10120 = var_463_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_2 = 0.2

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.actorSpriteComps10120 then
					for iter_463_0, iter_463_1 in pairs(arg_460_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_463_1 then
							if arg_460_1.isInRecall_ then
								local var_463_4 = Mathf.Lerp(iter_463_1.color.r, arg_460_1.hightColor1.r, var_463_3)
								local var_463_5 = Mathf.Lerp(iter_463_1.color.g, arg_460_1.hightColor1.g, var_463_3)
								local var_463_6 = Mathf.Lerp(iter_463_1.color.b, arg_460_1.hightColor1.b, var_463_3)

								iter_463_1.color = Color.New(var_463_4, var_463_5, var_463_6)
							else
								local var_463_7 = Mathf.Lerp(iter_463_1.color.r, 1, var_463_3)

								iter_463_1.color = Color.New(var_463_7, var_463_7, var_463_7)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.actorSpriteComps10120 then
				for iter_463_2, iter_463_3 in pairs(arg_460_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_463_3 then
						if arg_460_1.isInRecall_ then
							iter_463_3.color = arg_460_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_463_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps10120 = nil
			end

			local var_463_8 = arg_460_1.actors_["10128"]
			local var_463_9 = 0

			if var_463_9 < arg_460_1.time_ and arg_460_1.time_ <= var_463_9 + arg_463_0 and not isNil(var_463_8) and arg_460_1.var_.actorSpriteComps10128 == nil then
				arg_460_1.var_.actorSpriteComps10128 = var_463_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_10 = 0.2

			if var_463_9 <= arg_460_1.time_ and arg_460_1.time_ < var_463_9 + var_463_10 and not isNil(var_463_8) then
				local var_463_11 = (arg_460_1.time_ - var_463_9) / var_463_10

				if arg_460_1.var_.actorSpriteComps10128 then
					for iter_463_4, iter_463_5 in pairs(arg_460_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_463_5 then
							if arg_460_1.isInRecall_ then
								local var_463_12 = Mathf.Lerp(iter_463_5.color.r, arg_460_1.hightColor2.r, var_463_11)
								local var_463_13 = Mathf.Lerp(iter_463_5.color.g, arg_460_1.hightColor2.g, var_463_11)
								local var_463_14 = Mathf.Lerp(iter_463_5.color.b, arg_460_1.hightColor2.b, var_463_11)

								iter_463_5.color = Color.New(var_463_12, var_463_13, var_463_14)
							else
								local var_463_15 = Mathf.Lerp(iter_463_5.color.r, 0.5, var_463_11)

								iter_463_5.color = Color.New(var_463_15, var_463_15, var_463_15)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= var_463_9 + var_463_10 and arg_460_1.time_ < var_463_9 + var_463_10 + arg_463_0 and not isNil(var_463_8) and arg_460_1.var_.actorSpriteComps10128 then
				for iter_463_6, iter_463_7 in pairs(arg_460_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_463_7 then
						if arg_460_1.isInRecall_ then
							iter_463_7.color = arg_460_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_463_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_460_1.var_.actorSpriteComps10128 = nil
			end

			local var_463_16 = 0
			local var_463_17 = 0.6

			if var_463_16 < arg_460_1.time_ and arg_460_1.time_ <= var_463_16 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_18 = arg_460_1:FormatText(StoryNameCfg[1145].name)

				arg_460_1.leftNameTxt_.text = var_463_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_19 = arg_460_1:GetWordFromCfg(417172110)
				local var_463_20 = arg_460_1:FormatText(var_463_19.content)

				arg_460_1.text_.text = var_463_20

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_21 = 24
				local var_463_22 = utf8.len(var_463_20)
				local var_463_23 = var_463_21 <= 0 and var_463_17 or var_463_17 * (var_463_22 / var_463_21)

				if var_463_23 > 0 and var_463_17 < var_463_23 then
					arg_460_1.talkMaxDuration = var_463_23

					if var_463_23 + var_463_16 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_23 + var_463_16
					end
				end

				arg_460_1.text_.text = var_463_20
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172110", "story_v_out_417172.awb") ~= 0 then
					local var_463_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172110", "story_v_out_417172.awb") / 1000

					if var_463_24 + var_463_16 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_24 + var_463_16
					end

					if var_463_19.prefab_name ~= "" and arg_460_1.actors_[var_463_19.prefab_name] ~= nil then
						local var_463_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_19.prefab_name].transform, "story_v_out_417172", "417172110", "story_v_out_417172.awb")

						arg_460_1:RecordAudio("417172110", var_463_25)
						arg_460_1:RecordAudio("417172110", var_463_25)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_417172", "417172110", "story_v_out_417172.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_417172", "417172110", "story_v_out_417172.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_26 = math.max(var_463_17, arg_460_1.talkMaxDuration)

			if var_463_16 <= arg_460_1.time_ and arg_460_1.time_ < var_463_16 + var_463_26 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_16) / var_463_26

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_16 + var_463_26 and arg_460_1.time_ < var_463_16 + var_463_26 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play417172111 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 417172111
		arg_464_1.duration_ = 8.47

		local var_464_0 = {
			zh = 5.433,
			ja = 8.466
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
				arg_464_0:Play417172112(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["10128"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps10128 == nil then
				arg_464_1.var_.actorSpriteComps10128 = var_467_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_2 = 0.2

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.actorSpriteComps10128 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								local var_467_4 = Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor1.r, var_467_3)
								local var_467_5 = Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor1.g, var_467_3)
								local var_467_6 = Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor1.b, var_467_3)

								iter_467_1.color = Color.New(var_467_4, var_467_5, var_467_6)
							else
								local var_467_7 = Mathf.Lerp(iter_467_1.color.r, 1, var_467_3)

								iter_467_1.color = Color.New(var_467_7, var_467_7, var_467_7)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.actorSpriteComps10128 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_467_3 then
						if arg_464_1.isInRecall_ then
							iter_467_3.color = arg_464_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_467_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps10128 = nil
			end

			local var_467_8 = arg_464_1.actors_["10120"]
			local var_467_9 = 0

			if var_467_9 < arg_464_1.time_ and arg_464_1.time_ <= var_467_9 + arg_467_0 and not isNil(var_467_8) and arg_464_1.var_.actorSpriteComps10120 == nil then
				arg_464_1.var_.actorSpriteComps10120 = var_467_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_10 = 0.2

			if var_467_9 <= arg_464_1.time_ and arg_464_1.time_ < var_467_9 + var_467_10 and not isNil(var_467_8) then
				local var_467_11 = (arg_464_1.time_ - var_467_9) / var_467_10

				if arg_464_1.var_.actorSpriteComps10120 then
					for iter_467_4, iter_467_5 in pairs(arg_464_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_467_5 then
							if arg_464_1.isInRecall_ then
								local var_467_12 = Mathf.Lerp(iter_467_5.color.r, arg_464_1.hightColor2.r, var_467_11)
								local var_467_13 = Mathf.Lerp(iter_467_5.color.g, arg_464_1.hightColor2.g, var_467_11)
								local var_467_14 = Mathf.Lerp(iter_467_5.color.b, arg_464_1.hightColor2.b, var_467_11)

								iter_467_5.color = Color.New(var_467_12, var_467_13, var_467_14)
							else
								local var_467_15 = Mathf.Lerp(iter_467_5.color.r, 0.5, var_467_11)

								iter_467_5.color = Color.New(var_467_15, var_467_15, var_467_15)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= var_467_9 + var_467_10 and arg_464_1.time_ < var_467_9 + var_467_10 + arg_467_0 and not isNil(var_467_8) and arg_464_1.var_.actorSpriteComps10120 then
				for iter_467_6, iter_467_7 in pairs(arg_464_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_467_7 then
						if arg_464_1.isInRecall_ then
							iter_467_7.color = arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_467_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_464_1.var_.actorSpriteComps10120 = nil
			end

			local var_467_16 = 0
			local var_467_17 = 0.75

			if var_467_16 < arg_464_1.time_ and arg_464_1.time_ <= var_467_16 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_18 = arg_464_1:FormatText(StoryNameCfg[595].name)

				arg_464_1.leftNameTxt_.text = var_467_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_19 = arg_464_1:GetWordFromCfg(417172111)
				local var_467_20 = arg_464_1:FormatText(var_467_19.content)

				arg_464_1.text_.text = var_467_20

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_21 = 30
				local var_467_22 = utf8.len(var_467_20)
				local var_467_23 = var_467_21 <= 0 and var_467_17 or var_467_17 * (var_467_22 / var_467_21)

				if var_467_23 > 0 and var_467_17 < var_467_23 then
					arg_464_1.talkMaxDuration = var_467_23

					if var_467_23 + var_467_16 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_23 + var_467_16
					end
				end

				arg_464_1.text_.text = var_467_20
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172111", "story_v_out_417172.awb") ~= 0 then
					local var_467_24 = manager.audio:GetVoiceLength("story_v_out_417172", "417172111", "story_v_out_417172.awb") / 1000

					if var_467_24 + var_467_16 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_24 + var_467_16
					end

					if var_467_19.prefab_name ~= "" and arg_464_1.actors_[var_467_19.prefab_name] ~= nil then
						local var_467_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_19.prefab_name].transform, "story_v_out_417172", "417172111", "story_v_out_417172.awb")

						arg_464_1:RecordAudio("417172111", var_467_25)
						arg_464_1:RecordAudio("417172111", var_467_25)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_417172", "417172111", "story_v_out_417172.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_417172", "417172111", "story_v_out_417172.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_26 = math.max(var_467_17, arg_464_1.talkMaxDuration)

			if var_467_16 <= arg_464_1.time_ and arg_464_1.time_ < var_467_16 + var_467_26 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_16) / var_467_26

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_16 + var_467_26 and arg_464_1.time_ < var_467_16 + var_467_26 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play417172112 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 417172112
		arg_468_1.duration_ = 7.1

		local var_468_0 = {
			zh = 4.766,
			ja = 7.1
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
				arg_468_0:Play417172113(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.65

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_2 = arg_468_1:FormatText(StoryNameCfg[595].name)

				arg_468_1.leftNameTxt_.text = var_471_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_3 = arg_468_1:GetWordFromCfg(417172112)
				local var_471_4 = arg_468_1:FormatText(var_471_3.content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 26
				local var_471_6 = utf8.len(var_471_4)
				local var_471_7 = var_471_5 <= 0 and var_471_1 or var_471_1 * (var_471_6 / var_471_5)

				if var_471_7 > 0 and var_471_1 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_4
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172112", "story_v_out_417172.awb") ~= 0 then
					local var_471_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172112", "story_v_out_417172.awb") / 1000

					if var_471_8 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_8 + var_471_0
					end

					if var_471_3.prefab_name ~= "" and arg_468_1.actors_[var_471_3.prefab_name] ~= nil then
						local var_471_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_3.prefab_name].transform, "story_v_out_417172", "417172112", "story_v_out_417172.awb")

						arg_468_1:RecordAudio("417172112", var_471_9)
						arg_468_1:RecordAudio("417172112", var_471_9)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_417172", "417172112", "story_v_out_417172.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_417172", "417172112", "story_v_out_417172.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_10 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_10 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_10

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_10 and arg_468_1.time_ < var_471_0 + var_471_10 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play417172113 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 417172113
		arg_472_1.duration_ = 4.23

		local var_472_0 = {
			zh = 2.433,
			ja = 4.233
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
				arg_472_0:Play417172114(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.35

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_2 = arg_472_1:FormatText(StoryNameCfg[595].name)

				arg_472_1.leftNameTxt_.text = var_475_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_3 = arg_472_1:GetWordFromCfg(417172113)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 14
				local var_475_6 = utf8.len(var_475_4)
				local var_475_7 = var_475_5 <= 0 and var_475_1 or var_475_1 * (var_475_6 / var_475_5)

				if var_475_7 > 0 and var_475_1 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172113", "story_v_out_417172.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172113", "story_v_out_417172.awb") / 1000

					if var_475_8 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_0
					end

					if var_475_3.prefab_name ~= "" and arg_472_1.actors_[var_475_3.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_3.prefab_name].transform, "story_v_out_417172", "417172113", "story_v_out_417172.awb")

						arg_472_1:RecordAudio("417172113", var_475_9)
						arg_472_1:RecordAudio("417172113", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_417172", "417172113", "story_v_out_417172.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_417172", "417172113", "story_v_out_417172.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_10 and arg_472_1.time_ < var_475_0 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play417172114 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 417172114
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play417172115(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = arg_476_1.actors_["10128"]
			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.actorSpriteComps10128 == nil then
				arg_476_1.var_.actorSpriteComps10128 = var_479_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_479_2 = 0.2

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_2 and not isNil(var_479_0) then
				local var_479_3 = (arg_476_1.time_ - var_479_1) / var_479_2

				if arg_476_1.var_.actorSpriteComps10128 then
					for iter_479_0, iter_479_1 in pairs(arg_476_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_479_1 then
							if arg_476_1.isInRecall_ then
								local var_479_4 = Mathf.Lerp(iter_479_1.color.r, arg_476_1.hightColor2.r, var_479_3)
								local var_479_5 = Mathf.Lerp(iter_479_1.color.g, arg_476_1.hightColor2.g, var_479_3)
								local var_479_6 = Mathf.Lerp(iter_479_1.color.b, arg_476_1.hightColor2.b, var_479_3)

								iter_479_1.color = Color.New(var_479_4, var_479_5, var_479_6)
							else
								local var_479_7 = Mathf.Lerp(iter_479_1.color.r, 0.5, var_479_3)

								iter_479_1.color = Color.New(var_479_7, var_479_7, var_479_7)
							end
						end
					end
				end
			end

			if arg_476_1.time_ >= var_479_1 + var_479_2 and arg_476_1.time_ < var_479_1 + var_479_2 + arg_479_0 and not isNil(var_479_0) and arg_476_1.var_.actorSpriteComps10128 then
				for iter_479_2, iter_479_3 in pairs(arg_476_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_479_3 then
						if arg_476_1.isInRecall_ then
							iter_479_3.color = arg_476_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_479_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_476_1.var_.actorSpriteComps10128 = nil
			end

			local var_479_8 = arg_476_1.actors_["10128"].transform
			local var_479_9 = 0

			if var_479_9 < arg_476_1.time_ and arg_476_1.time_ <= var_479_9 + arg_479_0 then
				arg_476_1.var_.moveOldPos10128 = var_479_8.localPosition
				var_479_8.localScale = Vector3.New(1, 1, 1)

				arg_476_1:CheckSpriteTmpPos("10128", 7)

				local var_479_10 = var_479_8.childCount

				for iter_479_4 = 0, var_479_10 - 1 do
					local var_479_11 = var_479_8:GetChild(iter_479_4)

					if var_479_11.name == "" or not string.find(var_479_11.name, "split") then
						var_479_11.gameObject:SetActive(true)
					else
						var_479_11.gameObject:SetActive(false)
					end
				end
			end

			local var_479_12 = 0.001

			if var_479_9 <= arg_476_1.time_ and arg_476_1.time_ < var_479_9 + var_479_12 then
				local var_479_13 = (arg_476_1.time_ - var_479_9) / var_479_12
				local var_479_14 = Vector3.New(0, -2000, -300)

				var_479_8.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos10128, var_479_14, var_479_13)
			end

			if arg_476_1.time_ >= var_479_9 + var_479_12 and arg_476_1.time_ < var_479_9 + var_479_12 + arg_479_0 then
				var_479_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_479_15 = arg_476_1.actors_["10120"].transform
			local var_479_16 = 0

			if var_479_16 < arg_476_1.time_ and arg_476_1.time_ <= var_479_16 + arg_479_0 then
				arg_476_1.var_.moveOldPos10120 = var_479_15.localPosition
				var_479_15.localScale = Vector3.New(1, 1, 1)

				arg_476_1:CheckSpriteTmpPos("10120", 7)

				local var_479_17 = var_479_15.childCount

				for iter_479_5 = 0, var_479_17 - 1 do
					local var_479_18 = var_479_15:GetChild(iter_479_5)

					if var_479_18.name == "" or not string.find(var_479_18.name, "split") then
						var_479_18.gameObject:SetActive(true)
					else
						var_479_18.gameObject:SetActive(false)
					end
				end
			end

			local var_479_19 = 0.001

			if var_479_16 <= arg_476_1.time_ and arg_476_1.time_ < var_479_16 + var_479_19 then
				local var_479_20 = (arg_476_1.time_ - var_479_16) / var_479_19
				local var_479_21 = Vector3.New(0, -2000, 0)

				var_479_15.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos10120, var_479_21, var_479_20)
			end

			if arg_476_1.time_ >= var_479_16 + var_479_19 and arg_476_1.time_ < var_479_16 + var_479_19 + arg_479_0 then
				var_479_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_479_22 = 0
			local var_479_23 = 1.375

			if var_479_22 < arg_476_1.time_ and arg_476_1.time_ <= var_479_22 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_24 = arg_476_1:GetWordFromCfg(417172114)
				local var_479_25 = arg_476_1:FormatText(var_479_24.content)

				arg_476_1.text_.text = var_479_25

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_26 = 55
				local var_479_27 = utf8.len(var_479_25)
				local var_479_28 = var_479_26 <= 0 and var_479_23 or var_479_23 * (var_479_27 / var_479_26)

				if var_479_28 > 0 and var_479_23 < var_479_28 then
					arg_476_1.talkMaxDuration = var_479_28

					if var_479_28 + var_479_22 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_28 + var_479_22
					end
				end

				arg_476_1.text_.text = var_479_25
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_29 = math.max(var_479_23, arg_476_1.talkMaxDuration)

			if var_479_22 <= arg_476_1.time_ and arg_476_1.time_ < var_479_22 + var_479_29 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_22) / var_479_29

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_22 + var_479_29 and arg_476_1.time_ < var_479_22 + var_479_29 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
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
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_476_1:InitPlayNodeList()
	end,
	Play417172115 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 417172115
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play417172116(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0.05
			local var_483_1 = 1

			if var_483_0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_0 + arg_483_0 then
				local var_483_2 = "play"
				local var_483_3 = "effect"

				arg_480_1:AudioAction(var_483_2, var_483_3, "se_story_1311", "se_story_1311_attack02", "")
			end

			local var_483_4 = 0
			local var_483_5 = 1.025

			if var_483_4 < arg_480_1.time_ and arg_480_1.time_ <= var_483_4 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_6 = arg_480_1:GetWordFromCfg(417172115)
				local var_483_7 = arg_480_1:FormatText(var_483_6.content)

				arg_480_1.text_.text = var_483_7

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_8 = 41
				local var_483_9 = utf8.len(var_483_7)
				local var_483_10 = var_483_8 <= 0 and var_483_5 or var_483_5 * (var_483_9 / var_483_8)

				if var_483_10 > 0 and var_483_5 < var_483_10 then
					arg_480_1.talkMaxDuration = var_483_10

					if var_483_10 + var_483_4 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_10 + var_483_4
					end
				end

				arg_480_1.text_.text = var_483_7
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_11 = math.max(var_483_5, arg_480_1.talkMaxDuration)

			if var_483_4 <= arg_480_1.time_ and arg_480_1.time_ < var_483_4 + var_483_11 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_4) / var_483_11

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_4 + var_483_11 and arg_480_1.time_ < var_483_4 + var_483_11 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play417172116 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 417172116
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play417172117(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0.866666666666667
			local var_487_1 = 1

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				local var_487_2 = "play"
				local var_487_3 = "effect"

				arg_484_1:AudioAction(var_487_2, var_487_3, "se_story_1311", "se_story_1311_button", "")
			end

			local var_487_4 = 0
			local var_487_5 = 1.25

			if var_487_4 < arg_484_1.time_ and arg_484_1.time_ <= var_487_4 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_6 = arg_484_1:GetWordFromCfg(417172116)
				local var_487_7 = arg_484_1:FormatText(var_487_6.content)

				arg_484_1.text_.text = var_487_7

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_8 = 50
				local var_487_9 = utf8.len(var_487_7)
				local var_487_10 = var_487_8 <= 0 and var_487_5 or var_487_5 * (var_487_9 / var_487_8)

				if var_487_10 > 0 and var_487_5 < var_487_10 then
					arg_484_1.talkMaxDuration = var_487_10

					if var_487_10 + var_487_4 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_10 + var_487_4
					end
				end

				arg_484_1.text_.text = var_487_7
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_11 = math.max(var_487_5, arg_484_1.talkMaxDuration)

			if var_487_4 <= arg_484_1.time_ and arg_484_1.time_ < var_487_4 + var_487_11 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_4) / var_487_11

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_4 + var_487_11 and arg_484_1.time_ < var_487_4 + var_487_11 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play417172117 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 417172117
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play417172118(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 1

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_2 = arg_488_1:GetWordFromCfg(417172117)
				local var_491_3 = arg_488_1:FormatText(var_491_2.content)

				arg_488_1.text_.text = var_491_3

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_4 = 40
				local var_491_5 = utf8.len(var_491_3)
				local var_491_6 = var_491_4 <= 0 and var_491_1 or var_491_1 * (var_491_5 / var_491_4)

				if var_491_6 > 0 and var_491_1 < var_491_6 then
					arg_488_1.talkMaxDuration = var_491_6

					if var_491_6 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_6 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_3
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_7 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_7 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_7

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_7 and arg_488_1.time_ < var_491_0 + var_491_7 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play417172118 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 417172118
		arg_492_1.duration_ = 5

		local var_492_0 = {
			zh = 3.733,
			ja = 5
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
				arg_492_0:Play417172119(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0
			local var_495_1 = 0.55

			if var_495_0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_2 = arg_492_1:FormatText(StoryNameCfg[1146].name)

				arg_492_1.leftNameTxt_.text = var_495_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_3 = arg_492_1:GetWordFromCfg(417172118)
				local var_495_4 = arg_492_1:FormatText(var_495_3.content)

				arg_492_1.text_.text = var_495_4

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 22
				local var_495_6 = utf8.len(var_495_4)
				local var_495_7 = var_495_5 <= 0 and var_495_1 or var_495_1 * (var_495_6 / var_495_5)

				if var_495_7 > 0 and var_495_1 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_0
					end
				end

				arg_492_1.text_.text = var_495_4
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172118", "story_v_out_417172.awb") ~= 0 then
					local var_495_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172118", "story_v_out_417172.awb") / 1000

					if var_495_8 + var_495_0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_8 + var_495_0
					end

					if var_495_3.prefab_name ~= "" and arg_492_1.actors_[var_495_3.prefab_name] ~= nil then
						local var_495_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_3.prefab_name].transform, "story_v_out_417172", "417172118", "story_v_out_417172.awb")

						arg_492_1:RecordAudio("417172118", var_495_9)
						arg_492_1:RecordAudio("417172118", var_495_9)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_417172", "417172118", "story_v_out_417172.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_417172", "417172118", "story_v_out_417172.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_10 = math.max(var_495_1, arg_492_1.talkMaxDuration)

			if var_495_0 <= arg_492_1.time_ and arg_492_1.time_ < var_495_0 + var_495_10 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_0) / var_495_10

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_0 + var_495_10 and arg_492_1.time_ < var_495_0 + var_495_10 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play417172119 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 417172119
		arg_496_1.duration_ = 1.4

		local var_496_0 = {
			zh = 1.066,
			ja = 1.4
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play417172120(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["10128"]
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.actorSpriteComps10128 == nil then
				arg_496_1.var_.actorSpriteComps10128 = var_499_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_2 = 0.2

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_2 and not isNil(var_499_0) then
				local var_499_3 = (arg_496_1.time_ - var_499_1) / var_499_2

				if arg_496_1.var_.actorSpriteComps10128 then
					for iter_499_0, iter_499_1 in pairs(arg_496_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_499_1 then
							if arg_496_1.isInRecall_ then
								local var_499_4 = Mathf.Lerp(iter_499_1.color.r, arg_496_1.hightColor1.r, var_499_3)
								local var_499_5 = Mathf.Lerp(iter_499_1.color.g, arg_496_1.hightColor1.g, var_499_3)
								local var_499_6 = Mathf.Lerp(iter_499_1.color.b, arg_496_1.hightColor1.b, var_499_3)

								iter_499_1.color = Color.New(var_499_4, var_499_5, var_499_6)
							else
								local var_499_7 = Mathf.Lerp(iter_499_1.color.r, 1, var_499_3)

								iter_499_1.color = Color.New(var_499_7, var_499_7, var_499_7)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= var_499_1 + var_499_2 and arg_496_1.time_ < var_499_1 + var_499_2 + arg_499_0 and not isNil(var_499_0) and arg_496_1.var_.actorSpriteComps10128 then
				for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_499_3 then
						if arg_496_1.isInRecall_ then
							iter_499_3.color = arg_496_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_499_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_496_1.var_.actorSpriteComps10128 = nil
			end

			local var_499_8 = arg_496_1.actors_["10128"].transform
			local var_499_9 = 0

			if var_499_9 < arg_496_1.time_ and arg_496_1.time_ <= var_499_9 + arg_499_0 then
				arg_496_1.var_.moveOldPos10128 = var_499_8.localPosition
				var_499_8.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10128", 3)

				local var_499_10 = var_499_8.childCount

				for iter_499_4 = 0, var_499_10 - 1 do
					local var_499_11 = var_499_8:GetChild(iter_499_4)

					if var_499_11.name == "" or not string.find(var_499_11.name, "split") then
						var_499_11.gameObject:SetActive(true)
					else
						var_499_11.gameObject:SetActive(false)
					end
				end
			end

			local var_499_12 = 0.001

			if var_499_9 <= arg_496_1.time_ and arg_496_1.time_ < var_499_9 + var_499_12 then
				local var_499_13 = (arg_496_1.time_ - var_499_9) / var_499_12
				local var_499_14 = Vector3.New(0, -347, -300)

				var_499_8.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10128, var_499_14, var_499_13)
			end

			if arg_496_1.time_ >= var_499_9 + var_499_12 and arg_496_1.time_ < var_499_9 + var_499_12 + arg_499_0 then
				var_499_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_499_15 = 0
			local var_499_16 = 0.075

			if var_499_15 < arg_496_1.time_ and arg_496_1.time_ <= var_499_15 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_17 = arg_496_1:FormatText(StoryNameCfg[595].name)

				arg_496_1.leftNameTxt_.text = var_499_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_18 = arg_496_1:GetWordFromCfg(417172119)
				local var_499_19 = arg_496_1:FormatText(var_499_18.content)

				arg_496_1.text_.text = var_499_19

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_20 = 3
				local var_499_21 = utf8.len(var_499_19)
				local var_499_22 = var_499_20 <= 0 and var_499_16 or var_499_16 * (var_499_21 / var_499_20)

				if var_499_22 > 0 and var_499_16 < var_499_22 then
					arg_496_1.talkMaxDuration = var_499_22

					if var_499_22 + var_499_15 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_22 + var_499_15
					end
				end

				arg_496_1.text_.text = var_499_19
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172119", "story_v_out_417172.awb") ~= 0 then
					local var_499_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172119", "story_v_out_417172.awb") / 1000

					if var_499_23 + var_499_15 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_23 + var_499_15
					end

					if var_499_18.prefab_name ~= "" and arg_496_1.actors_[var_499_18.prefab_name] ~= nil then
						local var_499_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_18.prefab_name].transform, "story_v_out_417172", "417172119", "story_v_out_417172.awb")

						arg_496_1:RecordAudio("417172119", var_499_24)
						arg_496_1:RecordAudio("417172119", var_499_24)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_417172", "417172119", "story_v_out_417172.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_417172", "417172119", "story_v_out_417172.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_25 = math.max(var_499_16, arg_496_1.talkMaxDuration)

			if var_499_15 <= arg_496_1.time_ and arg_496_1.time_ < var_499_15 + var_499_25 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_15) / var_499_25

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_15 + var_499_25 and arg_496_1.time_ < var_499_15 + var_499_25 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
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

		arg_496_1:InitPlayNodeList()
	end,
	Play417172120 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 417172120
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play417172121(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = arg_500_1.actors_["10128"].transform
			local var_503_1 = 0

			if var_503_1 < arg_500_1.time_ and arg_500_1.time_ <= var_503_1 + arg_503_0 then
				arg_500_1.var_.moveOldPos10128 = var_503_0.localPosition
				var_503_0.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("10128", 7)

				local var_503_2 = var_503_0.childCount

				for iter_503_0 = 0, var_503_2 - 1 do
					local var_503_3 = var_503_0:GetChild(iter_503_0)

					if var_503_3.name == "" or not string.find(var_503_3.name, "split") then
						var_503_3.gameObject:SetActive(true)
					else
						var_503_3.gameObject:SetActive(false)
					end
				end
			end

			local var_503_4 = 0.001

			if var_503_1 <= arg_500_1.time_ and arg_500_1.time_ < var_503_1 + var_503_4 then
				local var_503_5 = (arg_500_1.time_ - var_503_1) / var_503_4
				local var_503_6 = Vector3.New(0, -2000, -300)

				var_503_0.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos10128, var_503_6, var_503_5)
			end

			if arg_500_1.time_ >= var_503_1 + var_503_4 and arg_500_1.time_ < var_503_1 + var_503_4 + arg_503_0 then
				var_503_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_503_7 = 0
			local var_503_8 = 1.05

			if var_503_7 < arg_500_1.time_ and arg_500_1.time_ <= var_503_7 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_9 = arg_500_1:GetWordFromCfg(417172120)
				local var_503_10 = arg_500_1:FormatText(var_503_9.content)

				arg_500_1.text_.text = var_503_10

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_11 = 42
				local var_503_12 = utf8.len(var_503_10)
				local var_503_13 = var_503_11 <= 0 and var_503_8 or var_503_8 * (var_503_12 / var_503_11)

				if var_503_13 > 0 and var_503_8 < var_503_13 then
					arg_500_1.talkMaxDuration = var_503_13

					if var_503_13 + var_503_7 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_13 + var_503_7
					end
				end

				arg_500_1.text_.text = var_503_10
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_14 = math.max(var_503_8, arg_500_1.talkMaxDuration)

			if var_503_7 <= arg_500_1.time_ and arg_500_1.time_ < var_503_7 + var_503_14 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_7) / var_503_14

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_7 + var_503_14 and arg_500_1.time_ < var_503_7 + var_503_14 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
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

		arg_500_1:InitPlayNodeList()
	end,
	Play417172121 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 417172121
		arg_504_1.duration_ = 6.2

		local var_504_0 = {
			zh = 6.2,
			ja = 6.1
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play417172122(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.95

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[1146].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_3 = arg_504_1:GetWordFromCfg(417172121)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 38
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172121", "story_v_out_417172.awb") ~= 0 then
					local var_507_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172121", "story_v_out_417172.awb") / 1000

					if var_507_8 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_8 + var_507_0
					end

					if var_507_3.prefab_name ~= "" and arg_504_1.actors_[var_507_3.prefab_name] ~= nil then
						local var_507_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_3.prefab_name].transform, "story_v_out_417172", "417172121", "story_v_out_417172.awb")

						arg_504_1:RecordAudio("417172121", var_507_9)
						arg_504_1:RecordAudio("417172121", var_507_9)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_417172", "417172121", "story_v_out_417172.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_417172", "417172121", "story_v_out_417172.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_10 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_10 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_10

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_10 and arg_504_1.time_ < var_507_0 + var_507_10 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play417172122 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 417172122
		arg_508_1.duration_ = 7.4

		local var_508_0 = {
			zh = 5,
			ja = 7.4
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play417172123(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["10128"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.actorSpriteComps10128 == nil then
				arg_508_1.var_.actorSpriteComps10128 = var_511_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_2 = 0.2

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.actorSpriteComps10128 then
					for iter_511_0, iter_511_1 in pairs(arg_508_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_511_1 then
							if arg_508_1.isInRecall_ then
								local var_511_4 = Mathf.Lerp(iter_511_1.color.r, arg_508_1.hightColor1.r, var_511_3)
								local var_511_5 = Mathf.Lerp(iter_511_1.color.g, arg_508_1.hightColor1.g, var_511_3)
								local var_511_6 = Mathf.Lerp(iter_511_1.color.b, arg_508_1.hightColor1.b, var_511_3)

								iter_511_1.color = Color.New(var_511_4, var_511_5, var_511_6)
							else
								local var_511_7 = Mathf.Lerp(iter_511_1.color.r, 1, var_511_3)

								iter_511_1.color = Color.New(var_511_7, var_511_7, var_511_7)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.actorSpriteComps10128 then
				for iter_511_2, iter_511_3 in pairs(arg_508_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_511_3 then
						if arg_508_1.isInRecall_ then
							iter_511_3.color = arg_508_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_511_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_508_1.var_.actorSpriteComps10128 = nil
			end

			local var_511_8 = arg_508_1.actors_["10128"].transform
			local var_511_9 = 0

			if var_511_9 < arg_508_1.time_ and arg_508_1.time_ <= var_511_9 + arg_511_0 then
				arg_508_1.var_.moveOldPos10128 = var_511_8.localPosition
				var_511_8.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("10128", 3)

				local var_511_10 = var_511_8.childCount

				for iter_511_4 = 0, var_511_10 - 1 do
					local var_511_11 = var_511_8:GetChild(iter_511_4)

					if var_511_11.name == "" or not string.find(var_511_11.name, "split") then
						var_511_11.gameObject:SetActive(true)
					else
						var_511_11.gameObject:SetActive(false)
					end
				end
			end

			local var_511_12 = 0.001

			if var_511_9 <= arg_508_1.time_ and arg_508_1.time_ < var_511_9 + var_511_12 then
				local var_511_13 = (arg_508_1.time_ - var_511_9) / var_511_12
				local var_511_14 = Vector3.New(0, -347, -300)

				var_511_8.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos10128, var_511_14, var_511_13)
			end

			if arg_508_1.time_ >= var_511_9 + var_511_12 and arg_508_1.time_ < var_511_9 + var_511_12 + arg_511_0 then
				var_511_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_511_15 = 0
			local var_511_16 = 0.7

			if var_511_15 < arg_508_1.time_ and arg_508_1.time_ <= var_511_15 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_17 = arg_508_1:FormatText(StoryNameCfg[595].name)

				arg_508_1.leftNameTxt_.text = var_511_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_18 = arg_508_1:GetWordFromCfg(417172122)
				local var_511_19 = arg_508_1:FormatText(var_511_18.content)

				arg_508_1.text_.text = var_511_19

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_20 = 28
				local var_511_21 = utf8.len(var_511_19)
				local var_511_22 = var_511_20 <= 0 and var_511_16 or var_511_16 * (var_511_21 / var_511_20)

				if var_511_22 > 0 and var_511_16 < var_511_22 then
					arg_508_1.talkMaxDuration = var_511_22

					if var_511_22 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_22 + var_511_15
					end
				end

				arg_508_1.text_.text = var_511_19
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172122", "story_v_out_417172.awb") ~= 0 then
					local var_511_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172122", "story_v_out_417172.awb") / 1000

					if var_511_23 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_23 + var_511_15
					end

					if var_511_18.prefab_name ~= "" and arg_508_1.actors_[var_511_18.prefab_name] ~= nil then
						local var_511_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_18.prefab_name].transform, "story_v_out_417172", "417172122", "story_v_out_417172.awb")

						arg_508_1:RecordAudio("417172122", var_511_24)
						arg_508_1:RecordAudio("417172122", var_511_24)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_417172", "417172122", "story_v_out_417172.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_417172", "417172122", "story_v_out_417172.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_25 = math.max(var_511_16, arg_508_1.talkMaxDuration)

			if var_511_15 <= arg_508_1.time_ and arg_508_1.time_ < var_511_15 + var_511_25 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_15) / var_511_25

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_15 + var_511_25 and arg_508_1.time_ < var_511_15 + var_511_25 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
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

		arg_508_1:InitPlayNodeList()
	end,
	Play417172123 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 417172123
		arg_512_1.duration_ = 3.27

		local var_512_0 = {
			zh = 3.266,
			ja = 2.8
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play417172124(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0
			local var_515_1 = 0.45

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_2 = arg_512_1:FormatText(StoryNameCfg[595].name)

				arg_512_1.leftNameTxt_.text = var_515_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_3 = arg_512_1:GetWordFromCfg(417172123)
				local var_515_4 = arg_512_1:FormatText(var_515_3.content)

				arg_512_1.text_.text = var_515_4

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_5 = 18
				local var_515_6 = utf8.len(var_515_4)
				local var_515_7 = var_515_5 <= 0 and var_515_1 or var_515_1 * (var_515_6 / var_515_5)

				if var_515_7 > 0 and var_515_1 < var_515_7 then
					arg_512_1.talkMaxDuration = var_515_7

					if var_515_7 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_7 + var_515_0
					end
				end

				arg_512_1.text_.text = var_515_4
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172123", "story_v_out_417172.awb") ~= 0 then
					local var_515_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172123", "story_v_out_417172.awb") / 1000

					if var_515_8 + var_515_0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_8 + var_515_0
					end

					if var_515_3.prefab_name ~= "" and arg_512_1.actors_[var_515_3.prefab_name] ~= nil then
						local var_515_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_3.prefab_name].transform, "story_v_out_417172", "417172123", "story_v_out_417172.awb")

						arg_512_1:RecordAudio("417172123", var_515_9)
						arg_512_1:RecordAudio("417172123", var_515_9)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_417172", "417172123", "story_v_out_417172.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_417172", "417172123", "story_v_out_417172.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_10 = math.max(var_515_1, arg_512_1.talkMaxDuration)

			if var_515_0 <= arg_512_1.time_ and arg_512_1.time_ < var_515_0 + var_515_10 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_0) / var_515_10

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_0 + var_515_10 and arg_512_1.time_ < var_515_0 + var_515_10 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play417172124 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 417172124
		arg_516_1.duration_ = 3.97

		local var_516_0 = {
			zh = 2.866,
			ja = 3.966
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play417172125(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["10128"].transform
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.var_.moveOldPos10128 = var_519_0.localPosition
				var_519_0.localScale = Vector3.New(1, 1, 1)

				arg_516_1:CheckSpriteTmpPos("10128", 7)

				local var_519_2 = var_519_0.childCount

				for iter_519_0 = 0, var_519_2 - 1 do
					local var_519_3 = var_519_0:GetChild(iter_519_0)

					if var_519_3.name == "" or not string.find(var_519_3.name, "split") then
						var_519_3.gameObject:SetActive(true)
					else
						var_519_3.gameObject:SetActive(false)
					end
				end
			end

			local var_519_4 = 0.001

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_4 then
				local var_519_5 = (arg_516_1.time_ - var_519_1) / var_519_4
				local var_519_6 = Vector3.New(0, -2000, -300)

				var_519_0.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos10128, var_519_6, var_519_5)
			end

			if arg_516_1.time_ >= var_519_1 + var_519_4 and arg_516_1.time_ < var_519_1 + var_519_4 + arg_519_0 then
				var_519_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_519_7 = 0
			local var_519_8 = 0.375

			if var_519_7 < arg_516_1.time_ and arg_516_1.time_ <= var_519_7 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_9 = arg_516_1:FormatText(StoryNameCfg[1146].name)

				arg_516_1.leftNameTxt_.text = var_519_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_10 = arg_516_1:GetWordFromCfg(417172124)
				local var_519_11 = arg_516_1:FormatText(var_519_10.content)

				arg_516_1.text_.text = var_519_11

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_12 = 15
				local var_519_13 = utf8.len(var_519_11)
				local var_519_14 = var_519_12 <= 0 and var_519_8 or var_519_8 * (var_519_13 / var_519_12)

				if var_519_14 > 0 and var_519_8 < var_519_14 then
					arg_516_1.talkMaxDuration = var_519_14

					if var_519_14 + var_519_7 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_14 + var_519_7
					end
				end

				arg_516_1.text_.text = var_519_11
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172124", "story_v_out_417172.awb") ~= 0 then
					local var_519_15 = manager.audio:GetVoiceLength("story_v_out_417172", "417172124", "story_v_out_417172.awb") / 1000

					if var_519_15 + var_519_7 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_15 + var_519_7
					end

					if var_519_10.prefab_name ~= "" and arg_516_1.actors_[var_519_10.prefab_name] ~= nil then
						local var_519_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_10.prefab_name].transform, "story_v_out_417172", "417172124", "story_v_out_417172.awb")

						arg_516_1:RecordAudio("417172124", var_519_16)
						arg_516_1:RecordAudio("417172124", var_519_16)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_417172", "417172124", "story_v_out_417172.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_417172", "417172124", "story_v_out_417172.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_17 = math.max(var_519_8, arg_516_1.talkMaxDuration)

			if var_519_7 <= arg_516_1.time_ and arg_516_1.time_ < var_519_7 + var_519_17 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_7) / var_519_17

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_7 + var_519_17 and arg_516_1.time_ < var_519_7 + var_519_17 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
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

		arg_516_1:InitPlayNodeList()
	end,
	Play417172125 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 417172125
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play417172126(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0.466666666666667
			local var_523_1 = 1

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				local var_523_2 = "play"
				local var_523_3 = "effect"

				arg_520_1:AudioAction(var_523_2, var_523_3, "se_story_1310", "se_story_1310_uimap", "")
			end

			local var_523_4 = 0
			local var_523_5 = 0.75

			if var_523_4 < arg_520_1.time_ and arg_520_1.time_ <= var_523_4 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, false)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_6 = arg_520_1:GetWordFromCfg(417172125)
				local var_523_7 = arg_520_1:FormatText(var_523_6.content)

				arg_520_1.text_.text = var_523_7

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_8 = 30
				local var_523_9 = utf8.len(var_523_7)
				local var_523_10 = var_523_8 <= 0 and var_523_5 or var_523_5 * (var_523_9 / var_523_8)

				if var_523_10 > 0 and var_523_5 < var_523_10 then
					arg_520_1.talkMaxDuration = var_523_10

					if var_523_10 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_10 + var_523_4
					end
				end

				arg_520_1.text_.text = var_523_7
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_11 = math.max(var_523_5, arg_520_1.talkMaxDuration)

			if var_523_4 <= arg_520_1.time_ and arg_520_1.time_ < var_523_4 + var_523_11 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_4) / var_523_11

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_4 + var_523_11 and arg_520_1.time_ < var_523_4 + var_523_11 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play417172126 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 417172126
		arg_524_1.duration_ = 4.13

		local var_524_0 = {
			zh = 4.1,
			ja = 4.133
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play417172127(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["10128"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.actorSpriteComps10128 == nil then
				arg_524_1.var_.actorSpriteComps10128 = var_527_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_527_2 = 0.2

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.actorSpriteComps10128 then
					for iter_527_0, iter_527_1 in pairs(arg_524_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_527_1 then
							if arg_524_1.isInRecall_ then
								local var_527_4 = Mathf.Lerp(iter_527_1.color.r, arg_524_1.hightColor1.r, var_527_3)
								local var_527_5 = Mathf.Lerp(iter_527_1.color.g, arg_524_1.hightColor1.g, var_527_3)
								local var_527_6 = Mathf.Lerp(iter_527_1.color.b, arg_524_1.hightColor1.b, var_527_3)

								iter_527_1.color = Color.New(var_527_4, var_527_5, var_527_6)
							else
								local var_527_7 = Mathf.Lerp(iter_527_1.color.r, 1, var_527_3)

								iter_527_1.color = Color.New(var_527_7, var_527_7, var_527_7)
							end
						end
					end
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.actorSpriteComps10128 then
				for iter_527_2, iter_527_3 in pairs(arg_524_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_527_3 then
						if arg_524_1.isInRecall_ then
							iter_527_3.color = arg_524_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_527_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_524_1.var_.actorSpriteComps10128 = nil
			end

			local var_527_8 = arg_524_1.actors_["10128"].transform
			local var_527_9 = 0

			if var_527_9 < arg_524_1.time_ and arg_524_1.time_ <= var_527_9 + arg_527_0 then
				arg_524_1.var_.moveOldPos10128 = var_527_8.localPosition
				var_527_8.localScale = Vector3.New(1, 1, 1)

				arg_524_1:CheckSpriteTmpPos("10128", 3)

				local var_527_10 = var_527_8.childCount

				for iter_527_4 = 0, var_527_10 - 1 do
					local var_527_11 = var_527_8:GetChild(iter_527_4)

					if var_527_11.name == "" or not string.find(var_527_11.name, "split") then
						var_527_11.gameObject:SetActive(true)
					else
						var_527_11.gameObject:SetActive(false)
					end
				end
			end

			local var_527_12 = 0.001

			if var_527_9 <= arg_524_1.time_ and arg_524_1.time_ < var_527_9 + var_527_12 then
				local var_527_13 = (arg_524_1.time_ - var_527_9) / var_527_12
				local var_527_14 = Vector3.New(0, -347, -300)

				var_527_8.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos10128, var_527_14, var_527_13)
			end

			if arg_524_1.time_ >= var_527_9 + var_527_12 and arg_524_1.time_ < var_527_9 + var_527_12 + arg_527_0 then
				var_527_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_527_15 = 0
			local var_527_16 = 0.4

			if var_527_15 < arg_524_1.time_ and arg_524_1.time_ <= var_527_15 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_17 = arg_524_1:FormatText(StoryNameCfg[595].name)

				arg_524_1.leftNameTxt_.text = var_527_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_18 = arg_524_1:GetWordFromCfg(417172126)
				local var_527_19 = arg_524_1:FormatText(var_527_18.content)

				arg_524_1.text_.text = var_527_19

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_20 = 16
				local var_527_21 = utf8.len(var_527_19)
				local var_527_22 = var_527_20 <= 0 and var_527_16 or var_527_16 * (var_527_21 / var_527_20)

				if var_527_22 > 0 and var_527_16 < var_527_22 then
					arg_524_1.talkMaxDuration = var_527_22

					if var_527_22 + var_527_15 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_22 + var_527_15
					end
				end

				arg_524_1.text_.text = var_527_19
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172126", "story_v_out_417172.awb") ~= 0 then
					local var_527_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172126", "story_v_out_417172.awb") / 1000

					if var_527_23 + var_527_15 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_23 + var_527_15
					end

					if var_527_18.prefab_name ~= "" and arg_524_1.actors_[var_527_18.prefab_name] ~= nil then
						local var_527_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_18.prefab_name].transform, "story_v_out_417172", "417172126", "story_v_out_417172.awb")

						arg_524_1:RecordAudio("417172126", var_527_24)
						arg_524_1:RecordAudio("417172126", var_527_24)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_417172", "417172126", "story_v_out_417172.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_417172", "417172126", "story_v_out_417172.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_25 = math.max(var_527_16, arg_524_1.talkMaxDuration)

			if var_527_15 <= arg_524_1.time_ and arg_524_1.time_ < var_527_15 + var_527_25 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_15) / var_527_25

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_15 + var_527_25 and arg_524_1.time_ < var_527_15 + var_527_25 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
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

		arg_524_1:InitPlayNodeList()
	end,
	Play417172127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 417172127
		arg_528_1.duration_ = 7.07

		local var_528_0 = {
			zh = 5.633,
			ja = 7.066
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play417172128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0
			local var_531_1 = 0.675

			if var_531_0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_2 = arg_528_1:FormatText(StoryNameCfg[595].name)

				arg_528_1.leftNameTxt_.text = var_531_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_3 = arg_528_1:GetWordFromCfg(417172127)
				local var_531_4 = arg_528_1:FormatText(var_531_3.content)

				arg_528_1.text_.text = var_531_4

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_5 = 27
				local var_531_6 = utf8.len(var_531_4)
				local var_531_7 = var_531_5 <= 0 and var_531_1 or var_531_1 * (var_531_6 / var_531_5)

				if var_531_7 > 0 and var_531_1 < var_531_7 then
					arg_528_1.talkMaxDuration = var_531_7

					if var_531_7 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_7 + var_531_0
					end
				end

				arg_528_1.text_.text = var_531_4
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172127", "story_v_out_417172.awb") ~= 0 then
					local var_531_8 = manager.audio:GetVoiceLength("story_v_out_417172", "417172127", "story_v_out_417172.awb") / 1000

					if var_531_8 + var_531_0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_8 + var_531_0
					end

					if var_531_3.prefab_name ~= "" and arg_528_1.actors_[var_531_3.prefab_name] ~= nil then
						local var_531_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_3.prefab_name].transform, "story_v_out_417172", "417172127", "story_v_out_417172.awb")

						arg_528_1:RecordAudio("417172127", var_531_9)
						arg_528_1:RecordAudio("417172127", var_531_9)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_417172", "417172127", "story_v_out_417172.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_417172", "417172127", "story_v_out_417172.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_10 = math.max(var_531_1, arg_528_1.talkMaxDuration)

			if var_531_0 <= arg_528_1.time_ and arg_528_1.time_ < var_531_0 + var_531_10 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_0) / var_531_10

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_0 + var_531_10 and arg_528_1.time_ < var_531_0 + var_531_10 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play417172128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 417172128
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play417172129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = arg_532_1.actors_["10128"]
			local var_535_1 = 0

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 and not isNil(var_535_0) and arg_532_1.var_.actorSpriteComps10128 == nil then
				arg_532_1.var_.actorSpriteComps10128 = var_535_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_535_2 = 0.2

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_2 and not isNil(var_535_0) then
				local var_535_3 = (arg_532_1.time_ - var_535_1) / var_535_2

				if arg_532_1.var_.actorSpriteComps10128 then
					for iter_535_0, iter_535_1 in pairs(arg_532_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_535_1 then
							if arg_532_1.isInRecall_ then
								local var_535_4 = Mathf.Lerp(iter_535_1.color.r, arg_532_1.hightColor2.r, var_535_3)
								local var_535_5 = Mathf.Lerp(iter_535_1.color.g, arg_532_1.hightColor2.g, var_535_3)
								local var_535_6 = Mathf.Lerp(iter_535_1.color.b, arg_532_1.hightColor2.b, var_535_3)

								iter_535_1.color = Color.New(var_535_4, var_535_5, var_535_6)
							else
								local var_535_7 = Mathf.Lerp(iter_535_1.color.r, 0.5, var_535_3)

								iter_535_1.color = Color.New(var_535_7, var_535_7, var_535_7)
							end
						end
					end
				end
			end

			if arg_532_1.time_ >= var_535_1 + var_535_2 and arg_532_1.time_ < var_535_1 + var_535_2 + arg_535_0 and not isNil(var_535_0) and arg_532_1.var_.actorSpriteComps10128 then
				for iter_535_2, iter_535_3 in pairs(arg_532_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_535_3 then
						if arg_532_1.isInRecall_ then
							iter_535_3.color = arg_532_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_535_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_532_1.var_.actorSpriteComps10128 = nil
			end

			local var_535_8 = 0
			local var_535_9 = 0.95

			if var_535_8 < arg_532_1.time_ and arg_532_1.time_ <= var_535_8 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, false)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_10 = arg_532_1:GetWordFromCfg(417172128)
				local var_535_11 = arg_532_1:FormatText(var_535_10.content)

				arg_532_1.text_.text = var_535_11

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_12 = 38
				local var_535_13 = utf8.len(var_535_11)
				local var_535_14 = var_535_12 <= 0 and var_535_9 or var_535_9 * (var_535_13 / var_535_12)

				if var_535_14 > 0 and var_535_9 < var_535_14 then
					arg_532_1.talkMaxDuration = var_535_14

					if var_535_14 + var_535_8 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_14 + var_535_8
					end
				end

				arg_532_1.text_.text = var_535_11
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_15 = math.max(var_535_9, arg_532_1.talkMaxDuration)

			if var_535_8 <= arg_532_1.time_ and arg_532_1.time_ < var_535_8 + var_535_15 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_8) / var_535_15

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_8 + var_535_15 and arg_532_1.time_ < var_535_8 + var_535_15 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play417172129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 417172129
		arg_536_1.duration_ = 5.8

		local var_536_0 = {
			zh = 5.8,
			ja = 3.466
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
				arg_536_0:Play417172130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["10128"]
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.actorSpriteComps10128 == nil then
				arg_536_1.var_.actorSpriteComps10128 = var_539_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_539_2 = 0.2

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 and not isNil(var_539_0) then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2

				if arg_536_1.var_.actorSpriteComps10128 then
					for iter_539_0, iter_539_1 in pairs(arg_536_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_539_1 then
							if arg_536_1.isInRecall_ then
								local var_539_4 = Mathf.Lerp(iter_539_1.color.r, arg_536_1.hightColor1.r, var_539_3)
								local var_539_5 = Mathf.Lerp(iter_539_1.color.g, arg_536_1.hightColor1.g, var_539_3)
								local var_539_6 = Mathf.Lerp(iter_539_1.color.b, arg_536_1.hightColor1.b, var_539_3)

								iter_539_1.color = Color.New(var_539_4, var_539_5, var_539_6)
							else
								local var_539_7 = Mathf.Lerp(iter_539_1.color.r, 1, var_539_3)

								iter_539_1.color = Color.New(var_539_7, var_539_7, var_539_7)
							end
						end
					end
				end
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.actorSpriteComps10128 then
				for iter_539_2, iter_539_3 in pairs(arg_536_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_539_3 then
						if arg_536_1.isInRecall_ then
							iter_539_3.color = arg_536_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_539_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_536_1.var_.actorSpriteComps10128 = nil
			end

			local var_539_8 = 0
			local var_539_9 = 0.375

			if var_539_8 < arg_536_1.time_ and arg_536_1.time_ <= var_539_8 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_10 = arg_536_1:FormatText(StoryNameCfg[595].name)

				arg_536_1.leftNameTxt_.text = var_539_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_11 = arg_536_1:GetWordFromCfg(417172129)
				local var_539_12 = arg_536_1:FormatText(var_539_11.content)

				arg_536_1.text_.text = var_539_12

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_13 = 15
				local var_539_14 = utf8.len(var_539_12)
				local var_539_15 = var_539_13 <= 0 and var_539_9 or var_539_9 * (var_539_14 / var_539_13)

				if var_539_15 > 0 and var_539_9 < var_539_15 then
					arg_536_1.talkMaxDuration = var_539_15

					if var_539_15 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_15 + var_539_8
					end
				end

				arg_536_1.text_.text = var_539_12
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172129", "story_v_out_417172.awb") ~= 0 then
					local var_539_16 = manager.audio:GetVoiceLength("story_v_out_417172", "417172129", "story_v_out_417172.awb") / 1000

					if var_539_16 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_16 + var_539_8
					end

					if var_539_11.prefab_name ~= "" and arg_536_1.actors_[var_539_11.prefab_name] ~= nil then
						local var_539_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_11.prefab_name].transform, "story_v_out_417172", "417172129", "story_v_out_417172.awb")

						arg_536_1:RecordAudio("417172129", var_539_17)
						arg_536_1:RecordAudio("417172129", var_539_17)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_417172", "417172129", "story_v_out_417172.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_417172", "417172129", "story_v_out_417172.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_18 = math.max(var_539_9, arg_536_1.talkMaxDuration)

			if var_539_8 <= arg_536_1.time_ and arg_536_1.time_ < var_539_8 + var_539_18 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_8) / var_539_18

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_8 + var_539_18 and arg_536_1.time_ < var_539_8 + var_539_18 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play417172130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 417172130
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play417172131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["10128"]
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.actorSpriteComps10128 == nil then
				arg_540_1.var_.actorSpriteComps10128 = var_543_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_543_2 = 0.2

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 and not isNil(var_543_0) then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2

				if arg_540_1.var_.actorSpriteComps10128 then
					for iter_543_0, iter_543_1 in pairs(arg_540_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_543_1 then
							if arg_540_1.isInRecall_ then
								local var_543_4 = Mathf.Lerp(iter_543_1.color.r, arg_540_1.hightColor2.r, var_543_3)
								local var_543_5 = Mathf.Lerp(iter_543_1.color.g, arg_540_1.hightColor2.g, var_543_3)
								local var_543_6 = Mathf.Lerp(iter_543_1.color.b, arg_540_1.hightColor2.b, var_543_3)

								iter_543_1.color = Color.New(var_543_4, var_543_5, var_543_6)
							else
								local var_543_7 = Mathf.Lerp(iter_543_1.color.r, 0.5, var_543_3)

								iter_543_1.color = Color.New(var_543_7, var_543_7, var_543_7)
							end
						end
					end
				end
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.actorSpriteComps10128 then
				for iter_543_2, iter_543_3 in pairs(arg_540_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_543_3 then
						if arg_540_1.isInRecall_ then
							iter_543_3.color = arg_540_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_543_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_540_1.var_.actorSpriteComps10128 = nil
			end

			local var_543_8 = arg_540_1.actors_["10128"].transform
			local var_543_9 = 0

			if var_543_9 < arg_540_1.time_ and arg_540_1.time_ <= var_543_9 + arg_543_0 then
				arg_540_1.var_.moveOldPos10128 = var_543_8.localPosition
				var_543_8.localScale = Vector3.New(1, 1, 1)

				arg_540_1:CheckSpriteTmpPos("10128", 7)

				local var_543_10 = var_543_8.childCount

				for iter_543_4 = 0, var_543_10 - 1 do
					local var_543_11 = var_543_8:GetChild(iter_543_4)

					if var_543_11.name == "" or not string.find(var_543_11.name, "split") then
						var_543_11.gameObject:SetActive(true)
					else
						var_543_11.gameObject:SetActive(false)
					end
				end
			end

			local var_543_12 = 0.001

			if var_543_9 <= arg_540_1.time_ and arg_540_1.time_ < var_543_9 + var_543_12 then
				local var_543_13 = (arg_540_1.time_ - var_543_9) / var_543_12
				local var_543_14 = Vector3.New(0, -2000, -300)

				var_543_8.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos10128, var_543_14, var_543_13)
			end

			if arg_540_1.time_ >= var_543_9 + var_543_12 and arg_540_1.time_ < var_543_9 + var_543_12 + arg_543_0 then
				var_543_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_543_15 = 0
			local var_543_16 = 1.275

			if var_543_15 < arg_540_1.time_ and arg_540_1.time_ <= var_543_15 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_17 = arg_540_1:GetWordFromCfg(417172130)
				local var_543_18 = arg_540_1:FormatText(var_543_17.content)

				arg_540_1.text_.text = var_543_18

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_19 = 51
				local var_543_20 = utf8.len(var_543_18)
				local var_543_21 = var_543_19 <= 0 and var_543_16 or var_543_16 * (var_543_20 / var_543_19)

				if var_543_21 > 0 and var_543_16 < var_543_21 then
					arg_540_1.talkMaxDuration = var_543_21

					if var_543_21 + var_543_15 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_21 + var_543_15
					end
				end

				arg_540_1.text_.text = var_543_18
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_22 = math.max(var_543_16, arg_540_1.talkMaxDuration)

			if var_543_15 <= arg_540_1.time_ and arg_540_1.time_ < var_543_15 + var_543_22 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_15) / var_543_22

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_15 + var_543_22 and arg_540_1.time_ < var_543_15 + var_543_22 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
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

		arg_540_1:InitPlayNodeList()
	end,
	Play417172131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 417172131
		arg_544_1.duration_ = 9

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play417172132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 3.999999999998

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.allBtn_.enabled = false
			end

			local var_547_1 = 0.666666666668667

			if arg_544_1.time_ >= var_547_0 + var_547_1 and arg_544_1.time_ < var_547_0 + var_547_1 + arg_547_0 then
				arg_544_1.allBtn_.enabled = true
			end

			local var_547_2 = "B01"

			if arg_544_1.bgs_[var_547_2] == nil then
				local var_547_3 = Object.Instantiate(arg_544_1.paintGo_)

				var_547_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_547_2)
				var_547_3.name = var_547_2
				var_547_3.transform.parent = arg_544_1.stage_.transform
				var_547_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_544_1.bgs_[var_547_2] = var_547_3
			end

			local var_547_4 = 1.999999999999

			if var_547_4 < arg_544_1.time_ and arg_544_1.time_ <= var_547_4 + arg_547_0 then
				local var_547_5 = manager.ui.mainCamera.transform.localPosition
				local var_547_6 = Vector3.New(0, 0, 10) + Vector3.New(var_547_5.x, var_547_5.y, 0)
				local var_547_7 = arg_544_1.bgs_.B01

				var_547_7.transform.localPosition = var_547_6
				var_547_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_547_8 = var_547_7:GetComponent("SpriteRenderer")

				if var_547_8 and var_547_8.sprite then
					local var_547_9 = (var_547_7.transform.localPosition - var_547_5).z
					local var_547_10 = manager.ui.mainCameraCom_
					local var_547_11 = 2 * var_547_9 * Mathf.Tan(var_547_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_547_12 = var_547_11 * var_547_10.aspect
					local var_547_13 = var_547_8.sprite.bounds.size.x
					local var_547_14 = var_547_8.sprite.bounds.size.y
					local var_547_15 = var_547_12 / var_547_13
					local var_547_16 = var_547_11 / var_547_14
					local var_547_17 = var_547_16 < var_547_15 and var_547_15 or var_547_16

					var_547_7.transform.localScale = Vector3.New(var_547_17, var_547_17, 0)
				end

				for iter_547_0, iter_547_1 in pairs(arg_544_1.bgs_) do
					if iter_547_0 ~= "B01" then
						iter_547_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_547_18 = 0

			if var_547_18 < arg_544_1.time_ and arg_544_1.time_ <= var_547_18 + arg_547_0 then
				arg_544_1.mask_.enabled = true
				arg_544_1.mask_.raycastTarget = true

				arg_544_1:SetGaussion(false)
			end

			local var_547_19 = 2

			if var_547_18 <= arg_544_1.time_ and arg_544_1.time_ < var_547_18 + var_547_19 then
				local var_547_20 = (arg_544_1.time_ - var_547_18) / var_547_19
				local var_547_21 = Color.New(0, 0, 0)

				var_547_21.a = Mathf.Lerp(0, 1, var_547_20)
				arg_544_1.mask_.color = var_547_21
			end

			if arg_544_1.time_ >= var_547_18 + var_547_19 and arg_544_1.time_ < var_547_18 + var_547_19 + arg_547_0 then
				local var_547_22 = Color.New(0, 0, 0)

				var_547_22.a = 1
				arg_544_1.mask_.color = var_547_22
			end

			local var_547_23 = 1.999999999998

			if var_547_23 < arg_544_1.time_ and arg_544_1.time_ <= var_547_23 + arg_547_0 then
				arg_544_1.mask_.enabled = true
				arg_544_1.mask_.raycastTarget = true

				arg_544_1:SetGaussion(false)
			end

			local var_547_24 = 2

			if var_547_23 <= arg_544_1.time_ and arg_544_1.time_ < var_547_23 + var_547_24 then
				local var_547_25 = (arg_544_1.time_ - var_547_23) / var_547_24
				local var_547_26 = Color.New(0, 0, 0)

				var_547_26.a = Mathf.Lerp(1, 0, var_547_25)
				arg_544_1.mask_.color = var_547_26
			end

			if arg_544_1.time_ >= var_547_23 + var_547_24 and arg_544_1.time_ < var_547_23 + var_547_24 + arg_547_0 then
				local var_547_27 = Color.New(0, 0, 0)
				local var_547_28 = 0

				arg_544_1.mask_.enabled = false
				var_547_27.a = var_547_28
				arg_544_1.mask_.color = var_547_27
			end

			local var_547_29 = 0
			local var_547_30 = 0.2

			if var_547_29 < arg_544_1.time_ and arg_544_1.time_ <= var_547_29 + arg_547_0 then
				local var_547_31 = "play"
				local var_547_32 = "music"

				arg_544_1:AudioAction(var_547_31, var_547_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_547_33 = ""
				local var_547_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_547_34 ~= "" then
					if arg_544_1.bgmTxt_.text ~= var_547_34 and arg_544_1.bgmTxt_.text ~= "" then
						if arg_544_1.bgmTxt2_.text ~= "" then
							arg_544_1.bgmTxt_.text = arg_544_1.bgmTxt2_.text
						end

						arg_544_1.bgmTxt2_.text = var_547_34

						arg_544_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_544_1.bgmTxt_.text = var_547_34
						arg_544_1.bgmTxt2_.text = var_547_34
					end

					if arg_544_1.bgmTimer then
						arg_544_1.bgmTimer:Stop()

						arg_544_1.bgmTimer = nil
					end

					if arg_544_1.settingData.show_music_name == 1 then
						arg_544_1.musicController:SetSelectedState("show")
						arg_544_1.musicAnimator_:Play("open", 0, 0)

						if arg_544_1.settingData.music_time ~= 0 then
							arg_544_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_544_1.settingData.music_time), function()
								if arg_544_1 == nil or isNil(arg_544_1.bgmTxt_) then
									return
								end

								arg_544_1.musicController:SetSelectedState("hide")
								arg_544_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_547_35 = 1.46666666666667
			local var_547_36 = 1

			if var_547_35 < arg_544_1.time_ and arg_544_1.time_ <= var_547_35 + arg_547_0 then
				local var_547_37 = "play"
				local var_547_38 = "music"

				arg_544_1:AudioAction(var_547_37, var_547_38, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_547_39 = ""
				local var_547_40 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if var_547_40 ~= "" then
					if arg_544_1.bgmTxt_.text ~= var_547_40 and arg_544_1.bgmTxt_.text ~= "" then
						if arg_544_1.bgmTxt2_.text ~= "" then
							arg_544_1.bgmTxt_.text = arg_544_1.bgmTxt2_.text
						end

						arg_544_1.bgmTxt2_.text = var_547_40

						arg_544_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_544_1.bgmTxt_.text = var_547_40
						arg_544_1.bgmTxt2_.text = var_547_40
					end

					if arg_544_1.bgmTimer then
						arg_544_1.bgmTimer:Stop()

						arg_544_1.bgmTimer = nil
					end

					if arg_544_1.settingData.show_music_name == 1 then
						arg_544_1.musicController:SetSelectedState("show")
						arg_544_1.musicAnimator_:Play("open", 0, 0)

						if arg_544_1.settingData.music_time ~= 0 then
							arg_544_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_544_1.settingData.music_time), function()
								if arg_544_1 == nil or isNil(arg_544_1.bgmTxt_) then
									return
								end

								arg_544_1.musicController:SetSelectedState("hide")
								arg_544_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_544_1.frameCnt_ <= 1 then
				arg_544_1.dialog_:SetActive(false)
			end

			local var_547_41 = 3.999999999998
			local var_547_42 = 1.25

			if var_547_41 < arg_544_1.time_ and arg_544_1.time_ <= var_547_41 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0

				arg_544_1.dialog_:SetActive(true)

				arg_544_1.dialogCg_.alpha = 0

				local var_547_43 = LeanTween.value(arg_544_1.dialog_, 0, 1, 0.3)

				var_547_43:setOnUpdate(LuaHelper.FloatAction(function(arg_550_0)
					arg_544_1.dialogCg_.alpha = arg_550_0
				end))
				var_547_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_544_1.dialog_)
					var_547_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_544_1.duration_ = arg_544_1.duration_ + 0.3

				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_44 = arg_544_1:GetWordFromCfg(417172131)
				local var_547_45 = arg_544_1:FormatText(var_547_44.content)

				arg_544_1.text_.text = var_547_45

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_46 = 50
				local var_547_47 = utf8.len(var_547_45)
				local var_547_48 = var_547_46 <= 0 and var_547_42 or var_547_42 * (var_547_47 / var_547_46)

				if var_547_48 > 0 and var_547_42 < var_547_48 then
					arg_544_1.talkMaxDuration = var_547_48
					var_547_41 = var_547_41 + 0.3

					if var_547_48 + var_547_41 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_48 + var_547_41
					end
				end

				arg_544_1.text_.text = var_547_45
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_49 = var_547_41 + 0.3
			local var_547_50 = math.max(var_547_42, arg_544_1.talkMaxDuration)

			if var_547_49 <= arg_544_1.time_ and arg_544_1.time_ < var_547_49 + var_547_50 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_49) / var_547_50

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_49 + var_547_50 and arg_544_1.time_ < var_547_49 + var_547_50 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play417172132 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 417172132
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play417172133(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0
			local var_555_1 = 1.55

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, false)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_2 = arg_552_1:GetWordFromCfg(417172132)
				local var_555_3 = arg_552_1:FormatText(var_555_2.content)

				arg_552_1.text_.text = var_555_3

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 62
				local var_555_5 = utf8.len(var_555_3)
				local var_555_6 = var_555_4 <= 0 and var_555_1 or var_555_1 * (var_555_5 / var_555_4)

				if var_555_6 > 0 and var_555_1 < var_555_6 then
					arg_552_1.talkMaxDuration = var_555_6

					if var_555_6 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_6 + var_555_0
					end
				end

				arg_552_1.text_.text = var_555_3
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_7 = math.max(var_555_1, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_7 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_0) / var_555_7

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_7 and arg_552_1.time_ < var_555_0 + var_555_7 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play417172133 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 417172133
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play417172134(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0
			local var_559_1 = 1.25

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, false)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_2 = arg_556_1:GetWordFromCfg(417172133)
				local var_559_3 = arg_556_1:FormatText(var_559_2.content)

				arg_556_1.text_.text = var_559_3

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_4 = 50
				local var_559_5 = utf8.len(var_559_3)
				local var_559_6 = var_559_4 <= 0 and var_559_1 or var_559_1 * (var_559_5 / var_559_4)

				if var_559_6 > 0 and var_559_1 < var_559_6 then
					arg_556_1.talkMaxDuration = var_559_6

					if var_559_6 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_6 + var_559_0
					end
				end

				arg_556_1.text_.text = var_559_3
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_7 = math.max(var_559_1, arg_556_1.talkMaxDuration)

			if var_559_0 <= arg_556_1.time_ and arg_556_1.time_ < var_559_0 + var_559_7 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_0) / var_559_7

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_0 + var_559_7 and arg_556_1.time_ < var_559_0 + var_559_7 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play417172134 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 417172134
		arg_560_1.duration_ = 3.5

		local var_560_0 = {
			zh = 2.433,
			ja = 3.5
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
				arg_560_0:Play417172135(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = arg_560_1.actors_["10128"]
			local var_563_1 = 0

			if var_563_1 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.actorSpriteComps10128 == nil then
				arg_560_1.var_.actorSpriteComps10128 = var_563_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_563_2 = 0.2

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_2 and not isNil(var_563_0) then
				local var_563_3 = (arg_560_1.time_ - var_563_1) / var_563_2

				if arg_560_1.var_.actorSpriteComps10128 then
					for iter_563_0, iter_563_1 in pairs(arg_560_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_563_1 then
							if arg_560_1.isInRecall_ then
								local var_563_4 = Mathf.Lerp(iter_563_1.color.r, arg_560_1.hightColor1.r, var_563_3)
								local var_563_5 = Mathf.Lerp(iter_563_1.color.g, arg_560_1.hightColor1.g, var_563_3)
								local var_563_6 = Mathf.Lerp(iter_563_1.color.b, arg_560_1.hightColor1.b, var_563_3)

								iter_563_1.color = Color.New(var_563_4, var_563_5, var_563_6)
							else
								local var_563_7 = Mathf.Lerp(iter_563_1.color.r, 1, var_563_3)

								iter_563_1.color = Color.New(var_563_7, var_563_7, var_563_7)
							end
						end
					end
				end
			end

			if arg_560_1.time_ >= var_563_1 + var_563_2 and arg_560_1.time_ < var_563_1 + var_563_2 + arg_563_0 and not isNil(var_563_0) and arg_560_1.var_.actorSpriteComps10128 then
				for iter_563_2, iter_563_3 in pairs(arg_560_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_563_3 then
						if arg_560_1.isInRecall_ then
							iter_563_3.color = arg_560_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_563_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_560_1.var_.actorSpriteComps10128 = nil
			end

			local var_563_8 = arg_560_1.actors_["10128"].transform
			local var_563_9 = 0

			if var_563_9 < arg_560_1.time_ and arg_560_1.time_ <= var_563_9 + arg_563_0 then
				arg_560_1.var_.moveOldPos10128 = var_563_8.localPosition
				var_563_8.localScale = Vector3.New(1, 1, 1)

				arg_560_1:CheckSpriteTmpPos("10128", 3)

				local var_563_10 = var_563_8.childCount

				for iter_563_4 = 0, var_563_10 - 1 do
					local var_563_11 = var_563_8:GetChild(iter_563_4)

					if var_563_11.name == "split_6" or not string.find(var_563_11.name, "split") then
						var_563_11.gameObject:SetActive(true)
					else
						var_563_11.gameObject:SetActive(false)
					end
				end
			end

			local var_563_12 = 0.001

			if var_563_9 <= arg_560_1.time_ and arg_560_1.time_ < var_563_9 + var_563_12 then
				local var_563_13 = (arg_560_1.time_ - var_563_9) / var_563_12
				local var_563_14 = Vector3.New(0, -347, -300)

				var_563_8.localPosition = Vector3.Lerp(arg_560_1.var_.moveOldPos10128, var_563_14, var_563_13)
			end

			if arg_560_1.time_ >= var_563_9 + var_563_12 and arg_560_1.time_ < var_563_9 + var_563_12 + arg_563_0 then
				var_563_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_563_15 = 0
			local var_563_16 = 0.325

			if var_563_15 < arg_560_1.time_ and arg_560_1.time_ <= var_563_15 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				local var_563_17 = arg_560_1:FormatText(StoryNameCfg[595].name)

				arg_560_1.leftNameTxt_.text = var_563_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_18 = arg_560_1:GetWordFromCfg(417172134)
				local var_563_19 = arg_560_1:FormatText(var_563_18.content)

				arg_560_1.text_.text = var_563_19

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_20 = 13
				local var_563_21 = utf8.len(var_563_19)
				local var_563_22 = var_563_20 <= 0 and var_563_16 or var_563_16 * (var_563_21 / var_563_20)

				if var_563_22 > 0 and var_563_16 < var_563_22 then
					arg_560_1.talkMaxDuration = var_563_22

					if var_563_22 + var_563_15 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_22 + var_563_15
					end
				end

				arg_560_1.text_.text = var_563_19
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172134", "story_v_out_417172.awb") ~= 0 then
					local var_563_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172134", "story_v_out_417172.awb") / 1000

					if var_563_23 + var_563_15 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_23 + var_563_15
					end

					if var_563_18.prefab_name ~= "" and arg_560_1.actors_[var_563_18.prefab_name] ~= nil then
						local var_563_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_18.prefab_name].transform, "story_v_out_417172", "417172134", "story_v_out_417172.awb")

						arg_560_1:RecordAudio("417172134", var_563_24)
						arg_560_1:RecordAudio("417172134", var_563_24)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_417172", "417172134", "story_v_out_417172.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_417172", "417172134", "story_v_out_417172.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_25 = math.max(var_563_16, arg_560_1.talkMaxDuration)

			if var_563_15 <= arg_560_1.time_ and arg_560_1.time_ < var_563_15 + var_563_25 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_15) / var_563_25

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_15 + var_563_25 and arg_560_1.time_ < var_563_15 + var_563_25 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {
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

		arg_560_1:InitPlayNodeList()
	end,
	Play417172135 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 417172135
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play417172136(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = arg_564_1.actors_["10128"]
			local var_567_1 = 0

			if var_567_1 < arg_564_1.time_ and arg_564_1.time_ <= var_567_1 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.actorSpriteComps10128 == nil then
				arg_564_1.var_.actorSpriteComps10128 = var_567_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_567_2 = 0.2

			if var_567_1 <= arg_564_1.time_ and arg_564_1.time_ < var_567_1 + var_567_2 and not isNil(var_567_0) then
				local var_567_3 = (arg_564_1.time_ - var_567_1) / var_567_2

				if arg_564_1.var_.actorSpriteComps10128 then
					for iter_567_0, iter_567_1 in pairs(arg_564_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_567_1 then
							if arg_564_1.isInRecall_ then
								local var_567_4 = Mathf.Lerp(iter_567_1.color.r, arg_564_1.hightColor2.r, var_567_3)
								local var_567_5 = Mathf.Lerp(iter_567_1.color.g, arg_564_1.hightColor2.g, var_567_3)
								local var_567_6 = Mathf.Lerp(iter_567_1.color.b, arg_564_1.hightColor2.b, var_567_3)

								iter_567_1.color = Color.New(var_567_4, var_567_5, var_567_6)
							else
								local var_567_7 = Mathf.Lerp(iter_567_1.color.r, 0.5, var_567_3)

								iter_567_1.color = Color.New(var_567_7, var_567_7, var_567_7)
							end
						end
					end
				end
			end

			if arg_564_1.time_ >= var_567_1 + var_567_2 and arg_564_1.time_ < var_567_1 + var_567_2 + arg_567_0 and not isNil(var_567_0) and arg_564_1.var_.actorSpriteComps10128 then
				for iter_567_2, iter_567_3 in pairs(arg_564_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_567_3 then
						if arg_564_1.isInRecall_ then
							iter_567_3.color = arg_564_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_567_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_564_1.var_.actorSpriteComps10128 = nil
			end

			local var_567_8 = arg_564_1.actors_["10128"].transform
			local var_567_9 = 0

			if var_567_9 < arg_564_1.time_ and arg_564_1.time_ <= var_567_9 + arg_567_0 then
				arg_564_1.var_.moveOldPos10128 = var_567_8.localPosition
				var_567_8.localScale = Vector3.New(1, 1, 1)

				arg_564_1:CheckSpriteTmpPos("10128", 7)

				local var_567_10 = var_567_8.childCount

				for iter_567_4 = 0, var_567_10 - 1 do
					local var_567_11 = var_567_8:GetChild(iter_567_4)

					if var_567_11.name == "" or not string.find(var_567_11.name, "split") then
						var_567_11.gameObject:SetActive(true)
					else
						var_567_11.gameObject:SetActive(false)
					end
				end
			end

			local var_567_12 = 0.001

			if var_567_9 <= arg_564_1.time_ and arg_564_1.time_ < var_567_9 + var_567_12 then
				local var_567_13 = (arg_564_1.time_ - var_567_9) / var_567_12
				local var_567_14 = Vector3.New(0, -2000, -300)

				var_567_8.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos10128, var_567_14, var_567_13)
			end

			if arg_564_1.time_ >= var_567_9 + var_567_12 and arg_564_1.time_ < var_567_9 + var_567_12 + arg_567_0 then
				var_567_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_567_15 = 0
			local var_567_16 = 0.975

			if var_567_15 < arg_564_1.time_ and arg_564_1.time_ <= var_567_15 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, false)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_17 = arg_564_1:GetWordFromCfg(417172135)
				local var_567_18 = arg_564_1:FormatText(var_567_17.content)

				arg_564_1.text_.text = var_567_18

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_19 = 39
				local var_567_20 = utf8.len(var_567_18)
				local var_567_21 = var_567_19 <= 0 and var_567_16 or var_567_16 * (var_567_20 / var_567_19)

				if var_567_21 > 0 and var_567_16 < var_567_21 then
					arg_564_1.talkMaxDuration = var_567_21

					if var_567_21 + var_567_15 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_21 + var_567_15
					end
				end

				arg_564_1.text_.text = var_567_18
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_22 = math.max(var_567_16, arg_564_1.talkMaxDuration)

			if var_567_15 <= arg_564_1.time_ and arg_564_1.time_ < var_567_15 + var_567_22 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_15) / var_567_22

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_15 + var_567_22 and arg_564_1.time_ < var_567_15 + var_567_22 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {
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

		arg_564_1:InitPlayNodeList()
	end,
	Play417172136 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 417172136
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play417172137(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0
			local var_571_1 = 1

			if var_571_0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_0 + arg_571_0 then
				local var_571_2 = "play"
				local var_571_3 = "effect"

				arg_568_1:AudioAction(var_571_2, var_571_3, "se_story_1311", "se_story_1311_opensafe", "")
			end

			local var_571_4 = 0
			local var_571_5 = 1.1

			if var_571_4 < arg_568_1.time_ and arg_568_1.time_ <= var_571_4 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_6 = arg_568_1:GetWordFromCfg(417172136)
				local var_571_7 = arg_568_1:FormatText(var_571_6.content)

				arg_568_1.text_.text = var_571_7

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_8 = 44
				local var_571_9 = utf8.len(var_571_7)
				local var_571_10 = var_571_8 <= 0 and var_571_5 or var_571_5 * (var_571_9 / var_571_8)

				if var_571_10 > 0 and var_571_5 < var_571_10 then
					arg_568_1.talkMaxDuration = var_571_10

					if var_571_10 + var_571_4 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_10 + var_571_4
					end
				end

				arg_568_1.text_.text = var_571_7
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_11 = math.max(var_571_5, arg_568_1.talkMaxDuration)

			if var_571_4 <= arg_568_1.time_ and arg_568_1.time_ < var_571_4 + var_571_11 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_4) / var_571_11

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_4 + var_571_11 and arg_568_1.time_ < var_571_4 + var_571_11 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play417172137 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 417172137
		arg_572_1.duration_ = 10.47

		local var_572_0 = {
			zh = 6.666,
			ja = 10.466
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
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play417172138(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = arg_572_1.actors_["10128"]
			local var_575_1 = 0

			if var_575_1 < arg_572_1.time_ and arg_572_1.time_ <= var_575_1 + arg_575_0 and not isNil(var_575_0) and arg_572_1.var_.actorSpriteComps10128 == nil then
				arg_572_1.var_.actorSpriteComps10128 = var_575_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_575_2 = 0.2

			if var_575_1 <= arg_572_1.time_ and arg_572_1.time_ < var_575_1 + var_575_2 and not isNil(var_575_0) then
				local var_575_3 = (arg_572_1.time_ - var_575_1) / var_575_2

				if arg_572_1.var_.actorSpriteComps10128 then
					for iter_575_0, iter_575_1 in pairs(arg_572_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_575_1 then
							if arg_572_1.isInRecall_ then
								local var_575_4 = Mathf.Lerp(iter_575_1.color.r, arg_572_1.hightColor1.r, var_575_3)
								local var_575_5 = Mathf.Lerp(iter_575_1.color.g, arg_572_1.hightColor1.g, var_575_3)
								local var_575_6 = Mathf.Lerp(iter_575_1.color.b, arg_572_1.hightColor1.b, var_575_3)

								iter_575_1.color = Color.New(var_575_4, var_575_5, var_575_6)
							else
								local var_575_7 = Mathf.Lerp(iter_575_1.color.r, 1, var_575_3)

								iter_575_1.color = Color.New(var_575_7, var_575_7, var_575_7)
							end
						end
					end
				end
			end

			if arg_572_1.time_ >= var_575_1 + var_575_2 and arg_572_1.time_ < var_575_1 + var_575_2 + arg_575_0 and not isNil(var_575_0) and arg_572_1.var_.actorSpriteComps10128 then
				for iter_575_2, iter_575_3 in pairs(arg_572_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_575_3 then
						if arg_572_1.isInRecall_ then
							iter_575_3.color = arg_572_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_575_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_572_1.var_.actorSpriteComps10128 = nil
			end

			local var_575_8 = arg_572_1.actors_["10128"].transform
			local var_575_9 = 0

			if var_575_9 < arg_572_1.time_ and arg_572_1.time_ <= var_575_9 + arg_575_0 then
				arg_572_1.var_.moveOldPos10128 = var_575_8.localPosition
				var_575_8.localScale = Vector3.New(1, 1, 1)

				arg_572_1:CheckSpriteTmpPos("10128", 3)

				local var_575_10 = var_575_8.childCount

				for iter_575_4 = 0, var_575_10 - 1 do
					local var_575_11 = var_575_8:GetChild(iter_575_4)

					if var_575_11.name == "" or not string.find(var_575_11.name, "split") then
						var_575_11.gameObject:SetActive(true)
					else
						var_575_11.gameObject:SetActive(false)
					end
				end
			end

			local var_575_12 = 0.001

			if var_575_9 <= arg_572_1.time_ and arg_572_1.time_ < var_575_9 + var_575_12 then
				local var_575_13 = (arg_572_1.time_ - var_575_9) / var_575_12
				local var_575_14 = Vector3.New(0, -347, -300)

				var_575_8.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos10128, var_575_14, var_575_13)
			end

			if arg_572_1.time_ >= var_575_9 + var_575_12 and arg_572_1.time_ < var_575_9 + var_575_12 + arg_575_0 then
				var_575_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_575_15 = 0
			local var_575_16 = 0.725

			if var_575_15 < arg_572_1.time_ and arg_572_1.time_ <= var_575_15 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				local var_575_17 = arg_572_1:FormatText(StoryNameCfg[595].name)

				arg_572_1.leftNameTxt_.text = var_575_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_18 = arg_572_1:GetWordFromCfg(417172137)
				local var_575_19 = arg_572_1:FormatText(var_575_18.content)

				arg_572_1.text_.text = var_575_19

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_20 = 29
				local var_575_21 = utf8.len(var_575_19)
				local var_575_22 = var_575_20 <= 0 and var_575_16 or var_575_16 * (var_575_21 / var_575_20)

				if var_575_22 > 0 and var_575_16 < var_575_22 then
					arg_572_1.talkMaxDuration = var_575_22

					if var_575_22 + var_575_15 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_22 + var_575_15
					end
				end

				arg_572_1.text_.text = var_575_19
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172137", "story_v_out_417172.awb") ~= 0 then
					local var_575_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172137", "story_v_out_417172.awb") / 1000

					if var_575_23 + var_575_15 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_23 + var_575_15
					end

					if var_575_18.prefab_name ~= "" and arg_572_1.actors_[var_575_18.prefab_name] ~= nil then
						local var_575_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_18.prefab_name].transform, "story_v_out_417172", "417172137", "story_v_out_417172.awb")

						arg_572_1:RecordAudio("417172137", var_575_24)
						arg_572_1:RecordAudio("417172137", var_575_24)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_417172", "417172137", "story_v_out_417172.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_417172", "417172137", "story_v_out_417172.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_25 = math.max(var_575_16, arg_572_1.talkMaxDuration)

			if var_575_15 <= arg_572_1.time_ and arg_572_1.time_ < var_575_15 + var_575_25 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_15) / var_575_25

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_15 + var_575_25 and arg_572_1.time_ < var_575_15 + var_575_25 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
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

		arg_572_1:InitPlayNodeList()
	end,
	Play417172138 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 417172138
		arg_576_1.duration_ = 5

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play417172139(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			local var_579_0 = arg_576_1.actors_["10128"]
			local var_579_1 = 0

			if var_579_1 < arg_576_1.time_ and arg_576_1.time_ <= var_579_1 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.actorSpriteComps10128 == nil then
				arg_576_1.var_.actorSpriteComps10128 = var_579_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_579_2 = 0.2

			if var_579_1 <= arg_576_1.time_ and arg_576_1.time_ < var_579_1 + var_579_2 and not isNil(var_579_0) then
				local var_579_3 = (arg_576_1.time_ - var_579_1) / var_579_2

				if arg_576_1.var_.actorSpriteComps10128 then
					for iter_579_0, iter_579_1 in pairs(arg_576_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_579_1 then
							if arg_576_1.isInRecall_ then
								local var_579_4 = Mathf.Lerp(iter_579_1.color.r, arg_576_1.hightColor2.r, var_579_3)
								local var_579_5 = Mathf.Lerp(iter_579_1.color.g, arg_576_1.hightColor2.g, var_579_3)
								local var_579_6 = Mathf.Lerp(iter_579_1.color.b, arg_576_1.hightColor2.b, var_579_3)

								iter_579_1.color = Color.New(var_579_4, var_579_5, var_579_6)
							else
								local var_579_7 = Mathf.Lerp(iter_579_1.color.r, 0.5, var_579_3)

								iter_579_1.color = Color.New(var_579_7, var_579_7, var_579_7)
							end
						end
					end
				end
			end

			if arg_576_1.time_ >= var_579_1 + var_579_2 and arg_576_1.time_ < var_579_1 + var_579_2 + arg_579_0 and not isNil(var_579_0) and arg_576_1.var_.actorSpriteComps10128 then
				for iter_579_2, iter_579_3 in pairs(arg_576_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_579_3 then
						if arg_576_1.isInRecall_ then
							iter_579_3.color = arg_576_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_579_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_576_1.var_.actorSpriteComps10128 = nil
			end

			local var_579_8 = arg_576_1.actors_["10128"].transform
			local var_579_9 = 0

			if var_579_9 < arg_576_1.time_ and arg_576_1.time_ <= var_579_9 + arg_579_0 then
				arg_576_1.var_.moveOldPos10128 = var_579_8.localPosition
				var_579_8.localScale = Vector3.New(1, 1, 1)

				arg_576_1:CheckSpriteTmpPos("10128", 7)

				local var_579_10 = var_579_8.childCount

				for iter_579_4 = 0, var_579_10 - 1 do
					local var_579_11 = var_579_8:GetChild(iter_579_4)

					if var_579_11.name == "" or not string.find(var_579_11.name, "split") then
						var_579_11.gameObject:SetActive(true)
					else
						var_579_11.gameObject:SetActive(false)
					end
				end
			end

			local var_579_12 = 0.001

			if var_579_9 <= arg_576_1.time_ and arg_576_1.time_ < var_579_9 + var_579_12 then
				local var_579_13 = (arg_576_1.time_ - var_579_9) / var_579_12
				local var_579_14 = Vector3.New(0, -2000, -300)

				var_579_8.localPosition = Vector3.Lerp(arg_576_1.var_.moveOldPos10128, var_579_14, var_579_13)
			end

			if arg_576_1.time_ >= var_579_9 + var_579_12 and arg_576_1.time_ < var_579_9 + var_579_12 + arg_579_0 then
				var_579_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_579_15 = 0
			local var_579_16 = 0.7

			if var_579_15 < arg_576_1.time_ and arg_576_1.time_ <= var_579_15 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_17 = arg_576_1:GetWordFromCfg(417172138)
				local var_579_18 = arg_576_1:FormatText(var_579_17.content)

				arg_576_1.text_.text = var_579_18

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_19 = 28
				local var_579_20 = utf8.len(var_579_18)
				local var_579_21 = var_579_19 <= 0 and var_579_16 or var_579_16 * (var_579_20 / var_579_19)

				if var_579_21 > 0 and var_579_16 < var_579_21 then
					arg_576_1.talkMaxDuration = var_579_21

					if var_579_21 + var_579_15 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_21 + var_579_15
					end
				end

				arg_576_1.text_.text = var_579_18
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_22 = math.max(var_579_16, arg_576_1.talkMaxDuration)

			if var_579_15 <= arg_576_1.time_ and arg_576_1.time_ < var_579_15 + var_579_22 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_15) / var_579_22

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_15 + var_579_22 and arg_576_1.time_ < var_579_15 + var_579_22 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {
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

		arg_576_1:InitPlayNodeList()
	end,
	Play417172139 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 417172139
		arg_580_1.duration_ = 5

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play417172140(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			local var_583_0 = 0
			local var_583_1 = 1.275

			if var_583_0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_0 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, false)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_2 = arg_580_1:GetWordFromCfg(417172139)
				local var_583_3 = arg_580_1:FormatText(var_583_2.content)

				arg_580_1.text_.text = var_583_3

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_4 = 51
				local var_583_5 = utf8.len(var_583_3)
				local var_583_6 = var_583_4 <= 0 and var_583_1 or var_583_1 * (var_583_5 / var_583_4)

				if var_583_6 > 0 and var_583_1 < var_583_6 then
					arg_580_1.talkMaxDuration = var_583_6

					if var_583_6 + var_583_0 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_6 + var_583_0
					end
				end

				arg_580_1.text_.text = var_583_3
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)
				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_7 = math.max(var_583_1, arg_580_1.talkMaxDuration)

			if var_583_0 <= arg_580_1.time_ and arg_580_1.time_ < var_583_0 + var_583_7 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_0) / var_583_7

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_0 + var_583_7 and arg_580_1.time_ < var_583_0 + var_583_7 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play417172140 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 417172140
		arg_584_1.duration_ = 4.63

		local var_584_0 = {
			zh = 4.633,
			ja = 3.4
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play417172141(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = arg_584_1.actors_["10128"]
			local var_587_1 = 0

			if var_587_1 < arg_584_1.time_ and arg_584_1.time_ <= var_587_1 + arg_587_0 and not isNil(var_587_0) and arg_584_1.var_.actorSpriteComps10128 == nil then
				arg_584_1.var_.actorSpriteComps10128 = var_587_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_587_2 = 0.2

			if var_587_1 <= arg_584_1.time_ and arg_584_1.time_ < var_587_1 + var_587_2 and not isNil(var_587_0) then
				local var_587_3 = (arg_584_1.time_ - var_587_1) / var_587_2

				if arg_584_1.var_.actorSpriteComps10128 then
					for iter_587_0, iter_587_1 in pairs(arg_584_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_587_1 then
							if arg_584_1.isInRecall_ then
								local var_587_4 = Mathf.Lerp(iter_587_1.color.r, arg_584_1.hightColor1.r, var_587_3)
								local var_587_5 = Mathf.Lerp(iter_587_1.color.g, arg_584_1.hightColor1.g, var_587_3)
								local var_587_6 = Mathf.Lerp(iter_587_1.color.b, arg_584_1.hightColor1.b, var_587_3)

								iter_587_1.color = Color.New(var_587_4, var_587_5, var_587_6)
							else
								local var_587_7 = Mathf.Lerp(iter_587_1.color.r, 1, var_587_3)

								iter_587_1.color = Color.New(var_587_7, var_587_7, var_587_7)
							end
						end
					end
				end
			end

			if arg_584_1.time_ >= var_587_1 + var_587_2 and arg_584_1.time_ < var_587_1 + var_587_2 + arg_587_0 and not isNil(var_587_0) and arg_584_1.var_.actorSpriteComps10128 then
				for iter_587_2, iter_587_3 in pairs(arg_584_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_587_3 then
						if arg_584_1.isInRecall_ then
							iter_587_3.color = arg_584_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_587_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_584_1.var_.actorSpriteComps10128 = nil
			end

			local var_587_8 = arg_584_1.actors_["10128"].transform
			local var_587_9 = 0

			if var_587_9 < arg_584_1.time_ and arg_584_1.time_ <= var_587_9 + arg_587_0 then
				arg_584_1.var_.moveOldPos10128 = var_587_8.localPosition
				var_587_8.localScale = Vector3.New(1, 1, 1)

				arg_584_1:CheckSpriteTmpPos("10128", 3)

				local var_587_10 = var_587_8.childCount

				for iter_587_4 = 0, var_587_10 - 1 do
					local var_587_11 = var_587_8:GetChild(iter_587_4)

					if var_587_11.name == "" or not string.find(var_587_11.name, "split") then
						var_587_11.gameObject:SetActive(true)
					else
						var_587_11.gameObject:SetActive(false)
					end
				end
			end

			local var_587_12 = 0.001

			if var_587_9 <= arg_584_1.time_ and arg_584_1.time_ < var_587_9 + var_587_12 then
				local var_587_13 = (arg_584_1.time_ - var_587_9) / var_587_12
				local var_587_14 = Vector3.New(0, -347, -300)

				var_587_8.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos10128, var_587_14, var_587_13)
			end

			if arg_584_1.time_ >= var_587_9 + var_587_12 and arg_584_1.time_ < var_587_9 + var_587_12 + arg_587_0 then
				var_587_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_587_15 = 0
			local var_587_16 = 0.45

			if var_587_15 < arg_584_1.time_ and arg_584_1.time_ <= var_587_15 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				local var_587_17 = arg_584_1:FormatText(StoryNameCfg[595].name)

				arg_584_1.leftNameTxt_.text = var_587_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_18 = arg_584_1:GetWordFromCfg(417172140)
				local var_587_19 = arg_584_1:FormatText(var_587_18.content)

				arg_584_1.text_.text = var_587_19

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_20 = 18
				local var_587_21 = utf8.len(var_587_19)
				local var_587_22 = var_587_20 <= 0 and var_587_16 or var_587_16 * (var_587_21 / var_587_20)

				if var_587_22 > 0 and var_587_16 < var_587_22 then
					arg_584_1.talkMaxDuration = var_587_22

					if var_587_22 + var_587_15 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_22 + var_587_15
					end
				end

				arg_584_1.text_.text = var_587_19
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172140", "story_v_out_417172.awb") ~= 0 then
					local var_587_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172140", "story_v_out_417172.awb") / 1000

					if var_587_23 + var_587_15 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_23 + var_587_15
					end

					if var_587_18.prefab_name ~= "" and arg_584_1.actors_[var_587_18.prefab_name] ~= nil then
						local var_587_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_18.prefab_name].transform, "story_v_out_417172", "417172140", "story_v_out_417172.awb")

						arg_584_1:RecordAudio("417172140", var_587_24)
						arg_584_1:RecordAudio("417172140", var_587_24)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_417172", "417172140", "story_v_out_417172.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_417172", "417172140", "story_v_out_417172.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_25 = math.max(var_587_16, arg_584_1.talkMaxDuration)

			if var_587_15 <= arg_584_1.time_ and arg_584_1.time_ < var_587_15 + var_587_25 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_15) / var_587_25

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_15 + var_587_25 and arg_584_1.time_ < var_587_15 + var_587_25 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
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

		arg_584_1:InitPlayNodeList()
	end,
	Play417172141 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 417172141
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play417172142(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = arg_588_1.actors_["10128"]
			local var_591_1 = 0

			if var_591_1 < arg_588_1.time_ and arg_588_1.time_ <= var_591_1 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.actorSpriteComps10128 == nil then
				arg_588_1.var_.actorSpriteComps10128 = var_591_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_591_2 = 0.2

			if var_591_1 <= arg_588_1.time_ and arg_588_1.time_ < var_591_1 + var_591_2 and not isNil(var_591_0) then
				local var_591_3 = (arg_588_1.time_ - var_591_1) / var_591_2

				if arg_588_1.var_.actorSpriteComps10128 then
					for iter_591_0, iter_591_1 in pairs(arg_588_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_591_1 then
							if arg_588_1.isInRecall_ then
								local var_591_4 = Mathf.Lerp(iter_591_1.color.r, arg_588_1.hightColor2.r, var_591_3)
								local var_591_5 = Mathf.Lerp(iter_591_1.color.g, arg_588_1.hightColor2.g, var_591_3)
								local var_591_6 = Mathf.Lerp(iter_591_1.color.b, arg_588_1.hightColor2.b, var_591_3)

								iter_591_1.color = Color.New(var_591_4, var_591_5, var_591_6)
							else
								local var_591_7 = Mathf.Lerp(iter_591_1.color.r, 0.5, var_591_3)

								iter_591_1.color = Color.New(var_591_7, var_591_7, var_591_7)
							end
						end
					end
				end
			end

			if arg_588_1.time_ >= var_591_1 + var_591_2 and arg_588_1.time_ < var_591_1 + var_591_2 + arg_591_0 and not isNil(var_591_0) and arg_588_1.var_.actorSpriteComps10128 then
				for iter_591_2, iter_591_3 in pairs(arg_588_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_591_3 then
						if arg_588_1.isInRecall_ then
							iter_591_3.color = arg_588_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_591_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_588_1.var_.actorSpriteComps10128 = nil
			end

			local var_591_8 = arg_588_1.actors_["10128"].transform
			local var_591_9 = 0

			if var_591_9 < arg_588_1.time_ and arg_588_1.time_ <= var_591_9 + arg_591_0 then
				arg_588_1.var_.moveOldPos10128 = var_591_8.localPosition
				var_591_8.localScale = Vector3.New(1, 1, 1)

				arg_588_1:CheckSpriteTmpPos("10128", 7)

				local var_591_10 = var_591_8.childCount

				for iter_591_4 = 0, var_591_10 - 1 do
					local var_591_11 = var_591_8:GetChild(iter_591_4)

					if var_591_11.name == "" or not string.find(var_591_11.name, "split") then
						var_591_11.gameObject:SetActive(true)
					else
						var_591_11.gameObject:SetActive(false)
					end
				end
			end

			local var_591_12 = 0.001

			if var_591_9 <= arg_588_1.time_ and arg_588_1.time_ < var_591_9 + var_591_12 then
				local var_591_13 = (arg_588_1.time_ - var_591_9) / var_591_12
				local var_591_14 = Vector3.New(0, -2000, -300)

				var_591_8.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos10128, var_591_14, var_591_13)
			end

			if arg_588_1.time_ >= var_591_9 + var_591_12 and arg_588_1.time_ < var_591_9 + var_591_12 + arg_591_0 then
				var_591_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_591_15 = 0
			local var_591_16 = 1.675

			if var_591_15 < arg_588_1.time_ and arg_588_1.time_ <= var_591_15 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, false)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_17 = arg_588_1:GetWordFromCfg(417172141)
				local var_591_18 = arg_588_1:FormatText(var_591_17.content)

				arg_588_1.text_.text = var_591_18

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_19 = 67
				local var_591_20 = utf8.len(var_591_18)
				local var_591_21 = var_591_19 <= 0 and var_591_16 or var_591_16 * (var_591_20 / var_591_19)

				if var_591_21 > 0 and var_591_16 < var_591_21 then
					arg_588_1.talkMaxDuration = var_591_21

					if var_591_21 + var_591_15 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_21 + var_591_15
					end
				end

				arg_588_1.text_.text = var_591_18
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_22 = math.max(var_591_16, arg_588_1.talkMaxDuration)

			if var_591_15 <= arg_588_1.time_ and arg_588_1.time_ < var_591_15 + var_591_22 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_15) / var_591_22

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_15 + var_591_22 and arg_588_1.time_ < var_591_15 + var_591_22 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
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

		arg_588_1:InitPlayNodeList()
	end,
	Play417172142 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 417172142
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play417172143(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0
			local var_595_1 = 1.325

			if var_595_0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, false)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_2 = arg_592_1:GetWordFromCfg(417172142)
				local var_595_3 = arg_592_1:FormatText(var_595_2.content)

				arg_592_1.text_.text = var_595_3

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_4 = 53
				local var_595_5 = utf8.len(var_595_3)
				local var_595_6 = var_595_4 <= 0 and var_595_1 or var_595_1 * (var_595_5 / var_595_4)

				if var_595_6 > 0 and var_595_1 < var_595_6 then
					arg_592_1.talkMaxDuration = var_595_6

					if var_595_6 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_6 + var_595_0
					end
				end

				arg_592_1.text_.text = var_595_3
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_7 = math.max(var_595_1, arg_592_1.talkMaxDuration)

			if var_595_0 <= arg_592_1.time_ and arg_592_1.time_ < var_595_0 + var_595_7 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_0) / var_595_7

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_0 + var_595_7 and arg_592_1.time_ < var_595_0 + var_595_7 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play417172143 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 417172143
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play417172144(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0
			local var_599_1 = 0.9

			if var_599_0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, false)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_2 = arg_596_1:GetWordFromCfg(417172143)
				local var_599_3 = arg_596_1:FormatText(var_599_2.content)

				arg_596_1.text_.text = var_599_3

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_4 = 36
				local var_599_5 = utf8.len(var_599_3)
				local var_599_6 = var_599_4 <= 0 and var_599_1 or var_599_1 * (var_599_5 / var_599_4)

				if var_599_6 > 0 and var_599_1 < var_599_6 then
					arg_596_1.talkMaxDuration = var_599_6

					if var_599_6 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_6 + var_599_0
					end
				end

				arg_596_1.text_.text = var_599_3
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_7 = math.max(var_599_1, arg_596_1.talkMaxDuration)

			if var_599_0 <= arg_596_1.time_ and arg_596_1.time_ < var_599_0 + var_599_7 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_0) / var_599_7

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_0 + var_599_7 and arg_596_1.time_ < var_599_0 + var_599_7 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play417172144 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 417172144
		arg_600_1.duration_ = 2.4

		local var_600_0 = {
			zh = 2.4,
			ja = 1.466
		}
		local var_600_1 = manager.audio:GetLocalizationFlag()

		if var_600_0[var_600_1] ~= nil then
			arg_600_1.duration_ = var_600_0[var_600_1]
		end

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play417172145(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = arg_600_1.actors_["10128"]
			local var_603_1 = 0

			if var_603_1 < arg_600_1.time_ and arg_600_1.time_ <= var_603_1 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.actorSpriteComps10128 == nil then
				arg_600_1.var_.actorSpriteComps10128 = var_603_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_603_2 = 0.2

			if var_603_1 <= arg_600_1.time_ and arg_600_1.time_ < var_603_1 + var_603_2 and not isNil(var_603_0) then
				local var_603_3 = (arg_600_1.time_ - var_603_1) / var_603_2

				if arg_600_1.var_.actorSpriteComps10128 then
					for iter_603_0, iter_603_1 in pairs(arg_600_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_603_1 then
							if arg_600_1.isInRecall_ then
								local var_603_4 = Mathf.Lerp(iter_603_1.color.r, arg_600_1.hightColor1.r, var_603_3)
								local var_603_5 = Mathf.Lerp(iter_603_1.color.g, arg_600_1.hightColor1.g, var_603_3)
								local var_603_6 = Mathf.Lerp(iter_603_1.color.b, arg_600_1.hightColor1.b, var_603_3)

								iter_603_1.color = Color.New(var_603_4, var_603_5, var_603_6)
							else
								local var_603_7 = Mathf.Lerp(iter_603_1.color.r, 1, var_603_3)

								iter_603_1.color = Color.New(var_603_7, var_603_7, var_603_7)
							end
						end
					end
				end
			end

			if arg_600_1.time_ >= var_603_1 + var_603_2 and arg_600_1.time_ < var_603_1 + var_603_2 + arg_603_0 and not isNil(var_603_0) and arg_600_1.var_.actorSpriteComps10128 then
				for iter_603_2, iter_603_3 in pairs(arg_600_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_603_3 then
						if arg_600_1.isInRecall_ then
							iter_603_3.color = arg_600_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_603_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_600_1.var_.actorSpriteComps10128 = nil
			end

			local var_603_8 = arg_600_1.actors_["10128"].transform
			local var_603_9 = 0

			if var_603_9 < arg_600_1.time_ and arg_600_1.time_ <= var_603_9 + arg_603_0 then
				arg_600_1.var_.moveOldPos10128 = var_603_8.localPosition
				var_603_8.localScale = Vector3.New(1, 1, 1)

				arg_600_1:CheckSpriteTmpPos("10128", 3)

				local var_603_10 = var_603_8.childCount

				for iter_603_4 = 0, var_603_10 - 1 do
					local var_603_11 = var_603_8:GetChild(iter_603_4)

					if var_603_11.name == "split_5" or not string.find(var_603_11.name, "split") then
						var_603_11.gameObject:SetActive(true)
					else
						var_603_11.gameObject:SetActive(false)
					end
				end
			end

			local var_603_12 = 0.001

			if var_603_9 <= arg_600_1.time_ and arg_600_1.time_ < var_603_9 + var_603_12 then
				local var_603_13 = (arg_600_1.time_ - var_603_9) / var_603_12
				local var_603_14 = Vector3.New(0, -347, -300)

				var_603_8.localPosition = Vector3.Lerp(arg_600_1.var_.moveOldPos10128, var_603_14, var_603_13)
			end

			if arg_600_1.time_ >= var_603_9 + var_603_12 and arg_600_1.time_ < var_603_9 + var_603_12 + arg_603_0 then
				var_603_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_603_15 = 0
			local var_603_16 = 0.1

			if var_603_15 < arg_600_1.time_ and arg_600_1.time_ <= var_603_15 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				local var_603_17 = arg_600_1:FormatText(StoryNameCfg[595].name)

				arg_600_1.leftNameTxt_.text = var_603_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_18 = arg_600_1:GetWordFromCfg(417172144)
				local var_603_19 = arg_600_1:FormatText(var_603_18.content)

				arg_600_1.text_.text = var_603_19

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_20 = 4
				local var_603_21 = utf8.len(var_603_19)
				local var_603_22 = var_603_20 <= 0 and var_603_16 or var_603_16 * (var_603_21 / var_603_20)

				if var_603_22 > 0 and var_603_16 < var_603_22 then
					arg_600_1.talkMaxDuration = var_603_22

					if var_603_22 + var_603_15 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_22 + var_603_15
					end
				end

				arg_600_1.text_.text = var_603_19
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172144", "story_v_out_417172.awb") ~= 0 then
					local var_603_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172144", "story_v_out_417172.awb") / 1000

					if var_603_23 + var_603_15 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_23 + var_603_15
					end

					if var_603_18.prefab_name ~= "" and arg_600_1.actors_[var_603_18.prefab_name] ~= nil then
						local var_603_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_18.prefab_name].transform, "story_v_out_417172", "417172144", "story_v_out_417172.awb")

						arg_600_1:RecordAudio("417172144", var_603_24)
						arg_600_1:RecordAudio("417172144", var_603_24)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_out_417172", "417172144", "story_v_out_417172.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_out_417172", "417172144", "story_v_out_417172.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_25 = math.max(var_603_16, arg_600_1.talkMaxDuration)

			if var_603_15 <= arg_600_1.time_ and arg_600_1.time_ < var_603_15 + var_603_25 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_15) / var_603_25

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_15 + var_603_25 and arg_600_1.time_ < var_603_15 + var_603_25 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {
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

		arg_600_1:InitPlayNodeList()
	end,
	Play417172145 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 417172145
		arg_604_1.duration_ = 5

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play417172146(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["10128"]
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.actorSpriteComps10128 == nil then
				arg_604_1.var_.actorSpriteComps10128 = var_607_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_607_2 = 0.2

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_2 and not isNil(var_607_0) then
				local var_607_3 = (arg_604_1.time_ - var_607_1) / var_607_2

				if arg_604_1.var_.actorSpriteComps10128 then
					for iter_607_0, iter_607_1 in pairs(arg_604_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_607_1 then
							if arg_604_1.isInRecall_ then
								local var_607_4 = Mathf.Lerp(iter_607_1.color.r, arg_604_1.hightColor2.r, var_607_3)
								local var_607_5 = Mathf.Lerp(iter_607_1.color.g, arg_604_1.hightColor2.g, var_607_3)
								local var_607_6 = Mathf.Lerp(iter_607_1.color.b, arg_604_1.hightColor2.b, var_607_3)

								iter_607_1.color = Color.New(var_607_4, var_607_5, var_607_6)
							else
								local var_607_7 = Mathf.Lerp(iter_607_1.color.r, 0.5, var_607_3)

								iter_607_1.color = Color.New(var_607_7, var_607_7, var_607_7)
							end
						end
					end
				end
			end

			if arg_604_1.time_ >= var_607_1 + var_607_2 and arg_604_1.time_ < var_607_1 + var_607_2 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.actorSpriteComps10128 then
				for iter_607_2, iter_607_3 in pairs(arg_604_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_607_3 then
						if arg_604_1.isInRecall_ then
							iter_607_3.color = arg_604_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_607_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_604_1.var_.actorSpriteComps10128 = nil
			end

			local var_607_8 = 0
			local var_607_9 = 1.45

			if var_607_8 < arg_604_1.time_ and arg_604_1.time_ <= var_607_8 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, false)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_10 = arg_604_1:GetWordFromCfg(417172145)
				local var_607_11 = arg_604_1:FormatText(var_607_10.content)

				arg_604_1.text_.text = var_607_11

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_12 = 58
				local var_607_13 = utf8.len(var_607_11)
				local var_607_14 = var_607_12 <= 0 and var_607_9 or var_607_9 * (var_607_13 / var_607_12)

				if var_607_14 > 0 and var_607_9 < var_607_14 then
					arg_604_1.talkMaxDuration = var_607_14

					if var_607_14 + var_607_8 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_14 + var_607_8
					end
				end

				arg_604_1.text_.text = var_607_11
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)
				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_15 = math.max(var_607_9, arg_604_1.talkMaxDuration)

			if var_607_8 <= arg_604_1.time_ and arg_604_1.time_ < var_607_8 + var_607_15 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_8) / var_607_15

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_8 + var_607_15 and arg_604_1.time_ < var_607_8 + var_607_15 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play417172146 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 417172146
		arg_608_1.duration_ = 1.93

		local var_608_0 = {
			zh = 1.5,
			ja = 1.933
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play417172147(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["10128"]
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.actorSpriteComps10128 == nil then
				arg_608_1.var_.actorSpriteComps10128 = var_611_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_611_2 = 0.2

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 and not isNil(var_611_0) then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2

				if arg_608_1.var_.actorSpriteComps10128 then
					for iter_611_0, iter_611_1 in pairs(arg_608_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_611_1 then
							if arg_608_1.isInRecall_ then
								local var_611_4 = Mathf.Lerp(iter_611_1.color.r, arg_608_1.hightColor1.r, var_611_3)
								local var_611_5 = Mathf.Lerp(iter_611_1.color.g, arg_608_1.hightColor1.g, var_611_3)
								local var_611_6 = Mathf.Lerp(iter_611_1.color.b, arg_608_1.hightColor1.b, var_611_3)

								iter_611_1.color = Color.New(var_611_4, var_611_5, var_611_6)
							else
								local var_611_7 = Mathf.Lerp(iter_611_1.color.r, 1, var_611_3)

								iter_611_1.color = Color.New(var_611_7, var_611_7, var_611_7)
							end
						end
					end
				end
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.actorSpriteComps10128 then
				for iter_611_2, iter_611_3 in pairs(arg_608_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_611_3 then
						if arg_608_1.isInRecall_ then
							iter_611_3.color = arg_608_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_611_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_608_1.var_.actorSpriteComps10128 = nil
			end

			local var_611_8 = arg_608_1.actors_["10128"].transform
			local var_611_9 = 0

			if var_611_9 < arg_608_1.time_ and arg_608_1.time_ <= var_611_9 + arg_611_0 then
				arg_608_1.var_.moveOldPos10128 = var_611_8.localPosition
				var_611_8.localScale = Vector3.New(1, 1, 1)

				arg_608_1:CheckSpriteTmpPos("10128", 3)

				local var_611_10 = var_611_8.childCount

				for iter_611_4 = 0, var_611_10 - 1 do
					local var_611_11 = var_611_8:GetChild(iter_611_4)

					if var_611_11.name == "split_5" or not string.find(var_611_11.name, "split") then
						var_611_11.gameObject:SetActive(true)
					else
						var_611_11.gameObject:SetActive(false)
					end
				end
			end

			local var_611_12 = 0.001

			if var_611_9 <= arg_608_1.time_ and arg_608_1.time_ < var_611_9 + var_611_12 then
				local var_611_13 = (arg_608_1.time_ - var_611_9) / var_611_12
				local var_611_14 = Vector3.New(0, -347, -300)

				var_611_8.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos10128, var_611_14, var_611_13)
			end

			if arg_608_1.time_ >= var_611_9 + var_611_12 and arg_608_1.time_ < var_611_9 + var_611_12 + arg_611_0 then
				var_611_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_611_15 = 0
			local var_611_16 = 0.15

			if var_611_15 < arg_608_1.time_ and arg_608_1.time_ <= var_611_15 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				local var_611_17 = arg_608_1:FormatText(StoryNameCfg[595].name)

				arg_608_1.leftNameTxt_.text = var_611_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_18 = arg_608_1:GetWordFromCfg(417172146)
				local var_611_19 = arg_608_1:FormatText(var_611_18.content)

				arg_608_1.text_.text = var_611_19

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_20 = 6
				local var_611_21 = utf8.len(var_611_19)
				local var_611_22 = var_611_20 <= 0 and var_611_16 or var_611_16 * (var_611_21 / var_611_20)

				if var_611_22 > 0 and var_611_16 < var_611_22 then
					arg_608_1.talkMaxDuration = var_611_22

					if var_611_22 + var_611_15 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_22 + var_611_15
					end
				end

				arg_608_1.text_.text = var_611_19
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417172", "417172146", "story_v_out_417172.awb") ~= 0 then
					local var_611_23 = manager.audio:GetVoiceLength("story_v_out_417172", "417172146", "story_v_out_417172.awb") / 1000

					if var_611_23 + var_611_15 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_23 + var_611_15
					end

					if var_611_18.prefab_name ~= "" and arg_608_1.actors_[var_611_18.prefab_name] ~= nil then
						local var_611_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_18.prefab_name].transform, "story_v_out_417172", "417172146", "story_v_out_417172.awb")

						arg_608_1:RecordAudio("417172146", var_611_24)
						arg_608_1:RecordAudio("417172146", var_611_24)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_out_417172", "417172146", "story_v_out_417172.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_out_417172", "417172146", "story_v_out_417172.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_25 = math.max(var_611_16, arg_608_1.talkMaxDuration)

			if var_611_15 <= arg_608_1.time_ and arg_608_1.time_ < var_611_15 + var_611_25 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_15) / var_611_25

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_15 + var_611_25 and arg_608_1.time_ < var_611_15 + var_611_25 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
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

		arg_608_1:InitPlayNodeList()
	end,
	Play417172147 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 417172147
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
			arg_612_1.auto_ = false
		end

		function arg_612_1.playNext_(arg_614_0)
			arg_612_1.onStoryFinished_()
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = arg_612_1.actors_["10128"].transform
			local var_615_1 = 0

			if var_615_1 < arg_612_1.time_ and arg_612_1.time_ <= var_615_1 + arg_615_0 then
				arg_612_1.var_.moveOldPos10128 = var_615_0.localPosition
				var_615_0.localScale = Vector3.New(1, 1, 1)

				arg_612_1:CheckSpriteTmpPos("10128", 7)

				local var_615_2 = var_615_0.childCount

				for iter_615_0 = 0, var_615_2 - 1 do
					local var_615_3 = var_615_0:GetChild(iter_615_0)

					if var_615_3.name == "" or not string.find(var_615_3.name, "split") then
						var_615_3.gameObject:SetActive(true)
					else
						var_615_3.gameObject:SetActive(false)
					end
				end
			end

			local var_615_4 = 0.001

			if var_615_1 <= arg_612_1.time_ and arg_612_1.time_ < var_615_1 + var_615_4 then
				local var_615_5 = (arg_612_1.time_ - var_615_1) / var_615_4
				local var_615_6 = Vector3.New(0, -2000, -300)

				var_615_0.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos10128, var_615_6, var_615_5)
			end

			if arg_612_1.time_ >= var_615_1 + var_615_4 and arg_612_1.time_ < var_615_1 + var_615_4 + arg_615_0 then
				var_615_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_615_7 = 0.766666666666667
			local var_615_8 = 1

			if var_615_7 < arg_612_1.time_ and arg_612_1.time_ <= var_615_7 + arg_615_0 then
				local var_615_9 = "play"
				local var_615_10 = "effect"

				arg_612_1:AudioAction(var_615_9, var_615_10, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_615_11 = 0
			local var_615_12 = 1.275

			if var_615_11 < arg_612_1.time_ and arg_612_1.time_ <= var_615_11 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, false)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_13 = arg_612_1:GetWordFromCfg(417172147)
				local var_615_14 = arg_612_1:FormatText(var_615_13.content)

				arg_612_1.text_.text = var_615_14

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_15 = 51
				local var_615_16 = utf8.len(var_615_14)
				local var_615_17 = var_615_15 <= 0 and var_615_12 or var_615_12 * (var_615_16 / var_615_15)

				if var_615_17 > 0 and var_615_12 < var_615_17 then
					arg_612_1.talkMaxDuration = var_615_17

					if var_615_17 + var_615_11 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_17 + var_615_11
					end
				end

				arg_612_1.text_.text = var_615_14
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_18 = math.max(var_615_12, arg_612_1.talkMaxDuration)

			if var_615_11 <= arg_612_1.time_ and arg_612_1.time_ < var_615_11 + var_615_18 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_11) / var_615_18

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_11 + var_615_18 and arg_612_1.time_ < var_615_11 + var_615_18 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
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

		arg_612_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/I17j",
		"TextureConfig/Background/ST2104a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/B01"
	},
	voices = {
		"story_v_out_417172.awb"
	}
}
