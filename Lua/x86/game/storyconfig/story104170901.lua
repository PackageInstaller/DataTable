return {
	Play417091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417091001
		arg_1_1.duration_ = 7.13

		local var_1_0 = {
			zh = 5.399999999999,
			ja = 7.132999999999
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
				arg_1_0:Play417091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I07a"

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
				local var_4_5 = arg_1_1.bgs_.I07a

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
					if iter_4_0 ~= "I07a" then
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
			local var_4_29 = 1.799999999999

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
			local var_4_37 = 1.799999999999

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10113 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10113", 3)

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
				local var_4_42 = Vector3.New(-30.38, -328.4, -517.4)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10113, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_4_43 = arg_1_1.actors_["10113"]
			local var_4_44 = 1.799999999999

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10113 = var_4_45.alpha
					arg_1_1.var_.characterEffect10113 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10113 = 0
			end

			local var_4_46 = 0.200000000001

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

			local var_4_55 = 0.466666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

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

			local var_4_61 = 0

			arg_1_1.isInRecall_ = true

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")
				arg_1_1.hightColor1 = Color.New(0.8980392, 0.8980392, 0.8980392)
				arg_1_1.hightColor2 = Color.New(0.3411765, 0.3411765, 0.3411765)

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					local var_4_62 = iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_11, iter_4_12 in ipairs(var_4_62) do
						if iter_4_12.color.r > 0.51 then
							iter_4_12.color = Color.New(0.8980392, 0.8980392, 0.8980392)
						else
							iter_4_12.color = Color.New(0.3411765, 0.3411765, 0.3411765)
						end
					end
				end
			end

			local var_4_63 = 0.1

			if var_4_61 <= arg_1_1.time_ and arg_1_1.time_ < var_4_61 + var_4_63 then
				local var_4_64 = (arg_1_1.time_ - var_4_61) / var_4_63

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_64)
			end

			if arg_1_1.time_ >= var_4_61 + var_4_63 and arg_1_1.time_ < var_4_61 + var_4_63 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_65 = 1.999999999999
			local var_4_66 = 0.325

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_67 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_67:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_68 = arg_1_1:FormatText(StoryNameCfg[1117].name)

				arg_1_1.leftNameTxt_.text = var_4_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_69 = arg_1_1:GetWordFromCfg(417091001)
				local var_4_70 = arg_1_1:FormatText(var_4_69.content)

				arg_1_1.text_.text = var_4_70

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_71 = 13
				local var_4_72 = utf8.len(var_4_70)
				local var_4_73 = var_4_71 <= 0 and var_4_66 or var_4_66 * (var_4_72 / var_4_71)

				if var_4_73 > 0 and var_4_66 < var_4_73 then
					arg_1_1.talkMaxDuration = var_4_73
					var_4_65 = var_4_65 + 0.3

					if var_4_73 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_73 + var_4_65
					end
				end

				arg_1_1.text_.text = var_4_70
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091001", "story_v_out_417091.awb") ~= 0 then
					local var_4_74 = manager.audio:GetVoiceLength("story_v_out_417091", "417091001", "story_v_out_417091.awb") / 1000

					if var_4_74 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_65
					end

					if var_4_69.prefab_name ~= "" and arg_1_1.actors_[var_4_69.prefab_name] ~= nil then
						local var_4_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_69.prefab_name].transform, "story_v_out_417091", "417091001", "story_v_out_417091.awb")

						arg_1_1:RecordAudio("417091001", var_4_75)
						arg_1_1:RecordAudio("417091001", var_4_75)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417091", "417091001", "story_v_out_417091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417091", "417091001", "story_v_out_417091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_76 = var_4_65 + 0.3
			local var_4_77 = math.max(var_4_66, arg_1_1.talkMaxDuration)

			if var_4_76 <= arg_1_1.time_ and arg_1_1.time_ < var_4_76 + var_4_77 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_76) / var_4_77

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_76 + var_4_77 and arg_1_1.time_ < var_4_76 + var_4_77 + arg_4_0 then
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
				startTime = 1.799999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play417091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 417091002
		arg_9_1.duration_ = 9.3

		local var_9_0 = {
			zh = 7.866,
			ja = 9.3
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
				arg_9_0:Play417091003(arg_9_1)
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

				local var_12_3 = arg_9_1:GetWordFromCfg(417091002)
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

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091002", "story_v_out_417091.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091002", "story_v_out_417091.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_417091", "417091002", "story_v_out_417091.awb")

						arg_9_1:RecordAudio("417091002", var_12_9)
						arg_9_1:RecordAudio("417091002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_417091", "417091002", "story_v_out_417091.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_417091", "417091002", "story_v_out_417091.awb")
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
	Play417091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 417091003
		arg_13_1.duration_ = 5.53

		local var_13_0 = {
			zh = 2.866,
			ja = 5.533
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
				arg_13_0:Play417091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1034"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["1034"]
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps1034 == nil then
				arg_13_1.var_.actorSpriteComps1034 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_6 and not isNil(var_16_4) then
				local var_16_7 = (arg_13_1.time_ - var_16_5) / var_16_6

				if arg_13_1.var_.actorSpriteComps1034 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								local var_16_8 = Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, var_16_7)
								local var_16_9 = Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, var_16_7)
								local var_16_10 = Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, var_16_7)

								iter_16_3.color = Color.New(var_16_8, var_16_9, var_16_10)
							else
								local var_16_11 = Mathf.Lerp(iter_16_3.color.r, 1, var_16_7)

								iter_16_3.color = Color.New(var_16_11, var_16_11, var_16_11)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_5 + var_16_6 and arg_13_1.time_ < var_16_5 + var_16_6 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps1034 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_16_5 then
						if arg_13_1.isInRecall_ then
							iter_16_5.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps1034 = nil
			end

			local var_16_12 = arg_13_1.actors_["10113"]
			local var_16_13 = 0

			if var_16_13 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 and not isNil(var_16_12) and arg_13_1.var_.actorSpriteComps10113 == nil then
				arg_13_1.var_.actorSpriteComps10113 = var_16_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_14 = 0.2

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_14 and not isNil(var_16_12) then
				local var_16_15 = (arg_13_1.time_ - var_16_13) / var_16_14

				if arg_13_1.var_.actorSpriteComps10113 then
					for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_16_7 then
							if arg_13_1.isInRecall_ then
								local var_16_16 = Mathf.Lerp(iter_16_7.color.r, arg_13_1.hightColor2.r, var_16_15)
								local var_16_17 = Mathf.Lerp(iter_16_7.color.g, arg_13_1.hightColor2.g, var_16_15)
								local var_16_18 = Mathf.Lerp(iter_16_7.color.b, arg_13_1.hightColor2.b, var_16_15)

								iter_16_7.color = Color.New(var_16_16, var_16_17, var_16_18)
							else
								local var_16_19 = Mathf.Lerp(iter_16_7.color.r, 0.5, var_16_15)

								iter_16_7.color = Color.New(var_16_19, var_16_19, var_16_19)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_13 + var_16_14 and arg_13_1.time_ < var_16_13 + var_16_14 + arg_16_0 and not isNil(var_16_12) and arg_13_1.var_.actorSpriteComps10113 then
				for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_16_9 then
						if arg_13_1.isInRecall_ then
							iter_16_9.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10113 = nil
			end

			local var_16_20 = 0
			local var_16_21 = 0.45

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[1109].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_23 = arg_13_1:GetWordFromCfg(417091003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 18
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091003", "story_v_out_417091.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_417091", "417091003", "story_v_out_417091.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_417091", "417091003", "story_v_out_417091.awb")

						arg_13_1:RecordAudio("417091003", var_16_29)
						arg_13_1:RecordAudio("417091003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_417091", "417091003", "story_v_out_417091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_417091", "417091003", "story_v_out_417091.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_30 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_30 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_30

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_30 and arg_13_1.time_ < var_16_20 + var_16_30 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play417091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 417091004
		arg_17_1.duration_ = 3.67

		local var_17_0 = {
			zh = 3.666,
			ja = 3.133
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
				arg_17_0:Play417091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10113"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10113 == nil then
				arg_17_1.var_.actorSpriteComps10113 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10113 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10113 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10113 = nil
			end

			local var_20_8 = arg_17_1.actors_["1034"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1034 == nil then
				arg_17_1.var_.actorSpriteComps1034 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 0.2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps1034 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_12 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, var_20_11)
								local var_20_13 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, var_20_11)
								local var_20_14 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, var_20_11)

								iter_20_5.color = Color.New(var_20_12, var_20_13, var_20_14)
							else
								local var_20_15 = Mathf.Lerp(iter_20_5.color.r, 0.5, var_20_11)

								iter_20_5.color = Color.New(var_20_15, var_20_15, var_20_15)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps1034 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1034 = nil
			end

			local var_20_16 = arg_17_1.actors_["10113"].transform
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.var_.moveOldPos10113 = var_20_16.localPosition
				var_20_16.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10113", 3)

				local var_20_18 = var_20_16.childCount

				for iter_20_8 = 0, var_20_18 - 1 do
					local var_20_19 = var_20_16:GetChild(iter_20_8)

					if var_20_19.name == "split_4" or not string.find(var_20_19.name, "split") then
						var_20_19.gameObject:SetActive(true)
					else
						var_20_19.gameObject:SetActive(false)
					end
				end
			end

			local var_20_20 = 0.001

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_20 then
				local var_20_21 = (arg_17_1.time_ - var_20_17) / var_20_20
				local var_20_22 = Vector3.New(-30.38, -328.4, -517.4)

				var_20_16.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10113, var_20_22, var_20_21)
			end

			if arg_17_1.time_ >= var_20_17 + var_20_20 and arg_17_1.time_ < var_20_17 + var_20_20 + arg_20_0 then
				var_20_16.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_20_23 = 0
			local var_20_24 = 0.4

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_25 = arg_17_1:FormatText(StoryNameCfg[1117].name)

				arg_17_1.leftNameTxt_.text = var_20_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_26 = arg_17_1:GetWordFromCfg(417091004)
				local var_20_27 = arg_17_1:FormatText(var_20_26.content)

				arg_17_1.text_.text = var_20_27

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_28 = 16
				local var_20_29 = utf8.len(var_20_27)
				local var_20_30 = var_20_28 <= 0 and var_20_24 or var_20_24 * (var_20_29 / var_20_28)

				if var_20_30 > 0 and var_20_24 < var_20_30 then
					arg_17_1.talkMaxDuration = var_20_30

					if var_20_30 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_30 + var_20_23
					end
				end

				arg_17_1.text_.text = var_20_27
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091004", "story_v_out_417091.awb") ~= 0 then
					local var_20_31 = manager.audio:GetVoiceLength("story_v_out_417091", "417091004", "story_v_out_417091.awb") / 1000

					if var_20_31 + var_20_23 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_23
					end

					if var_20_26.prefab_name ~= "" and arg_17_1.actors_[var_20_26.prefab_name] ~= nil then
						local var_20_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_26.prefab_name].transform, "story_v_out_417091", "417091004", "story_v_out_417091.awb")

						arg_17_1:RecordAudio("417091004", var_20_32)
						arg_17_1:RecordAudio("417091004", var_20_32)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_417091", "417091004", "story_v_out_417091.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_417091", "417091004", "story_v_out_417091.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_33 = math.max(var_20_24, arg_17_1.talkMaxDuration)

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_33 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_23) / var_20_33

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_23 + var_20_33 and arg_17_1.time_ < var_20_23 + var_20_33 + arg_20_0 then
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
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play417091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 417091005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play417091006(arg_21_1)
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10113 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10113 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.975

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(417091005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_12 = 39
				local var_24_13 = utf8.len(var_24_11)
				local var_24_14 = var_24_12 <= 0 and var_24_9 or var_24_9 * (var_24_13 / var_24_12)

				if var_24_14 > 0 and var_24_9 < var_24_14 then
					arg_21_1.talkMaxDuration = var_24_14

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_15 and arg_21_1.time_ < var_24_8 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play417091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 417091006
		arg_25_1.duration_ = 8.03

		local var_25_0 = {
			zh = 6.833,
			ja = 8.033
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
				arg_25_0:Play417091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10113"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10113 == nil then
				arg_25_1.var_.actorSpriteComps10113 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10113 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 1, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10113 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10113 = nil
			end

			local var_28_8 = arg_25_1.actors_["10113"].transform
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.var_.moveOldPos10113 = var_28_8.localPosition
				var_28_8.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10113", 3)

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
				local var_28_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10113, var_28_14, var_28_13)
			end

			if arg_25_1.time_ >= var_28_9 + var_28_12 and arg_25_1.time_ < var_28_9 + var_28_12 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_28_15 = 0
			local var_28_16 = 0.55

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[1117].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(417091006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091006", "story_v_out_417091.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091006", "story_v_out_417091.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_417091", "417091006", "story_v_out_417091.awb")

						arg_25_1:RecordAudio("417091006", var_28_24)
						arg_25_1:RecordAudio("417091006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_417091", "417091006", "story_v_out_417091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_417091", "417091006", "story_v_out_417091.awb")
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
	Play417091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 417091007
		arg_29_1.duration_ = 9.97

		local var_29_0 = {
			zh = 9.966,
			ja = 9.3
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
				arg_29_0:Play417091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1.05

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1117].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(417091007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091007", "story_v_out_417091.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091007", "story_v_out_417091.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_417091", "417091007", "story_v_out_417091.awb")

						arg_29_1:RecordAudio("417091007", var_32_9)
						arg_29_1:RecordAudio("417091007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_417091", "417091007", "story_v_out_417091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_417091", "417091007", "story_v_out_417091.awb")
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
	Play417091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 417091008
		arg_33_1.duration_ = 12.1

		local var_33_0 = {
			zh = 12.1,
			ja = 8.733
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
				arg_33_0:Play417091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.375

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[1117].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(417091008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 55
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091008", "story_v_out_417091.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091008", "story_v_out_417091.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_417091", "417091008", "story_v_out_417091.awb")

						arg_33_1:RecordAudio("417091008", var_36_9)
						arg_33_1:RecordAudio("417091008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_417091", "417091008", "story_v_out_417091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_417091", "417091008", "story_v_out_417091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play417091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 417091009
		arg_37_1.duration_ = 11.47

		local var_37_0 = {
			zh = 8.266,
			ja = 11.466
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
				arg_37_0:Play417091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10113"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10113 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10113", 3)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(-30.38, -328.4, -517.4)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10113, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_40_7 = 0
			local var_40_8 = 0.875

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_9 = arg_37_1:FormatText(StoryNameCfg[1117].name)

				arg_37_1.leftNameTxt_.text = var_40_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(417091009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 35
				local var_40_13 = utf8.len(var_40_11)
				local var_40_14 = var_40_12 <= 0 and var_40_8 or var_40_8 * (var_40_13 / var_40_12)

				if var_40_14 > 0 and var_40_8 < var_40_14 then
					arg_37_1.talkMaxDuration = var_40_14

					if var_40_14 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091009", "story_v_out_417091.awb") ~= 0 then
					local var_40_15 = manager.audio:GetVoiceLength("story_v_out_417091", "417091009", "story_v_out_417091.awb") / 1000

					if var_40_15 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_7
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_out_417091", "417091009", "story_v_out_417091.awb")

						arg_37_1:RecordAudio("417091009", var_40_16)
						arg_37_1:RecordAudio("417091009", var_40_16)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_417091", "417091009", "story_v_out_417091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_417091", "417091009", "story_v_out_417091.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_17 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_17 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_17

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_17 and arg_37_1.time_ < var_40_7 + var_40_17 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play417091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 417091010
		arg_41_1.duration_ = 7.1

		local var_41_0 = {
			zh = 4.7,
			ja = 7.1
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
				arg_41_0:Play417091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.6

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1117].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(417091010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 24
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091010", "story_v_out_417091.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091010", "story_v_out_417091.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_417091", "417091010", "story_v_out_417091.awb")

						arg_41_1:RecordAudio("417091010", var_44_9)
						arg_41_1:RecordAudio("417091010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_417091", "417091010", "story_v_out_417091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_417091", "417091010", "story_v_out_417091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play417091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 417091011
		arg_45_1.duration_ = 7

		local var_45_0 = {
			zh = 4.033,
			ja = 7
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
				arg_45_0:Play417091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10113"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10113 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10113", 3)

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
				local var_48_6 = Vector3.New(-30.38, -328.4, -517.4)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10113, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_48_7 = 0
			local var_48_8 = 0.375

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_9 = arg_45_1:FormatText(StoryNameCfg[1117].name)

				arg_45_1.leftNameTxt_.text = var_48_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(417091011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091011", "story_v_out_417091.awb") ~= 0 then
					local var_48_15 = manager.audio:GetVoiceLength("story_v_out_417091", "417091011", "story_v_out_417091.awb") / 1000

					if var_48_15 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_7
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_417091", "417091011", "story_v_out_417091.awb")

						arg_45_1:RecordAudio("417091011", var_48_16)
						arg_45_1:RecordAudio("417091011", var_48_16)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_417091", "417091011", "story_v_out_417091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_417091", "417091011", "story_v_out_417091.awb")
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
				actorName = "10113",
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
	Play417091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 417091012
		arg_49_1.duration_ = 12.4

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play417091013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "ST73"

			if arg_49_1.bgs_[var_52_0] == nil then
				local var_52_1 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_0)
				var_52_1.name = var_52_0
				var_52_1.transform.parent = arg_49_1.stage_.transform
				var_52_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_0] = var_52_1
			end

			local var_52_2 = 1.999999999999

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				local var_52_3 = manager.ui.mainCamera.transform.localPosition
				local var_52_4 = Vector3.New(0, 0, 10) + Vector3.New(var_52_3.x, var_52_3.y, 0)
				local var_52_5 = arg_49_1.bgs_.ST73

				var_52_5.transform.localPosition = var_52_4
				var_52_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_6 = var_52_5:GetComponent("SpriteRenderer")

				if var_52_6 and var_52_6.sprite then
					local var_52_7 = (var_52_5.transform.localPosition - var_52_3).z
					local var_52_8 = manager.ui.mainCameraCom_
					local var_52_9 = 2 * var_52_7 * Mathf.Tan(var_52_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_10 = var_52_9 * var_52_8.aspect
					local var_52_11 = var_52_6.sprite.bounds.size.x
					local var_52_12 = var_52_6.sprite.bounds.size.y
					local var_52_13 = var_52_10 / var_52_11
					local var_52_14 = var_52_9 / var_52_12
					local var_52_15 = var_52_14 < var_52_13 and var_52_13 or var_52_14

					var_52_5.transform.localScale = Vector3.New(var_52_15, var_52_15, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "ST73" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_17 = 2

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Color.New(0, 0, 0)

				var_52_19.a = Mathf.Lerp(0, 1, var_52_18)
				arg_49_1.mask_.color = var_52_19
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				local var_52_20 = Color.New(0, 0, 0)

				var_52_20.a = 1
				arg_49_1.mask_.color = var_52_20
			end

			local var_52_21 = 7.399999999999

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_22 = 0.3

			if arg_49_1.time_ >= var_52_21 + var_52_22 and arg_49_1.time_ < var_52_21 + var_52_22 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_23 = arg_49_1.actors_["10113"]
			local var_52_24 = 1.999999999999

			if var_52_24 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 and not isNil(var_52_23) and arg_49_1.var_.actorSpriteComps10113 == nil then
				arg_49_1.var_.actorSpriteComps10113 = var_52_23:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_25 = 0.0339999999999998

			if var_52_24 <= arg_49_1.time_ and arg_49_1.time_ < var_52_24 + var_52_25 and not isNil(var_52_23) then
				local var_52_26 = (arg_49_1.time_ - var_52_24) / var_52_25

				if arg_49_1.var_.actorSpriteComps10113 then
					for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_52_3 then
							if arg_49_1.isInRecall_ then
								local var_52_27 = Mathf.Lerp(iter_52_3.color.r, arg_49_1.hightColor2.r, var_52_26)
								local var_52_28 = Mathf.Lerp(iter_52_3.color.g, arg_49_1.hightColor2.g, var_52_26)
								local var_52_29 = Mathf.Lerp(iter_52_3.color.b, arg_49_1.hightColor2.b, var_52_26)

								iter_52_3.color = Color.New(var_52_27, var_52_28, var_52_29)
							else
								local var_52_30 = Mathf.Lerp(iter_52_3.color.r, 0.5, var_52_26)

								iter_52_3.color = Color.New(var_52_30, var_52_30, var_52_30)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_24 + var_52_25 and arg_49_1.time_ < var_52_24 + var_52_25 + arg_52_0 and not isNil(var_52_23) and arg_49_1.var_.actorSpriteComps10113 then
				for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_52_5 then
						if arg_49_1.isInRecall_ then
							iter_52_5.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10113 = nil
			end

			local var_52_31 = arg_49_1.actors_["10113"].transform
			local var_52_32 = 1.999999999999

			if var_52_32 < arg_49_1.time_ and arg_49_1.time_ <= var_52_32 + arg_52_0 then
				arg_49_1.var_.moveOldPos10113 = var_52_31.localPosition
				var_52_31.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10113", 7)

				local var_52_33 = var_52_31.childCount

				for iter_52_6 = 0, var_52_33 - 1 do
					local var_52_34 = var_52_31:GetChild(iter_52_6)

					if var_52_34.name == "" or not string.find(var_52_34.name, "split") then
						var_52_34.gameObject:SetActive(true)
					else
						var_52_34.gameObject:SetActive(false)
					end
				end
			end

			local var_52_35 = 0.001

			if var_52_32 <= arg_49_1.time_ and arg_49_1.time_ < var_52_32 + var_52_35 then
				local var_52_36 = (arg_49_1.time_ - var_52_32) / var_52_35
				local var_52_37 = Vector3.New(0, -2000, 0)

				var_52_31.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10113, var_52_37, var_52_36)
			end

			if arg_49_1.time_ >= var_52_32 + var_52_35 and arg_49_1.time_ < var_52_32 + var_52_35 + arg_52_0 then
				var_52_31.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_38 = 0
			local var_52_39 = 0.2

			if var_52_38 < arg_49_1.time_ and arg_49_1.time_ <= var_52_38 + arg_52_0 then
				local var_52_40 = "play"
				local var_52_41 = "music"

				arg_49_1:AudioAction(var_52_40, var_52_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_52_42 = ""
				local var_52_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_52_43 ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_43 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_43

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_43
						arg_49_1.bgmTxt2_.text = var_52_43
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

			local var_52_44 = 1.83333333333333
			local var_52_45 = 1

			if var_52_44 < arg_49_1.time_ and arg_49_1.time_ <= var_52_44 + arg_52_0 then
				local var_52_46 = "play"
				local var_52_47 = "music"

				arg_49_1:AudioAction(var_52_46, var_52_47, "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_52_48 = ""
				local var_52_49 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if var_52_49 ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_49 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_49

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_49
						arg_49_1.bgmTxt2_.text = var_52_49
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

			local var_52_50 = 7.399999999999
			local var_52_51 = 1

			if var_52_50 < arg_49_1.time_ and arg_49_1.time_ <= var_52_50 + arg_52_0 then
				local var_52_52 = "play"
				local var_52_53 = "effect"

				arg_49_1:AudioAction(var_52_52, var_52_53, "se_story_1310", "se_story_1310_footstep08", "")
			end

			local var_52_54 = 1.999999999999
			local var_52_55 = 3
			local var_52_56 = "ST73"

			if var_52_54 < arg_49_1.time_ and arg_49_1.time_ <= var_52_54 + arg_52_0 then
				arg_49_1.timestampController_:SetSelectedState("show")
				arg_49_1.timestampAni_:Play("in")

				arg_49_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_56)

				arg_49_1.timestampColorController_:SetSelectedState("cold")
				arg_49_1.timeColdImg_:SetAlpha(0.031)

				local var_52_57 = arg_49_1:GetWordFromCfg(501033)
				local var_52_58 = arg_49_1:FormatText(var_52_57.content)

				arg_49_1.text_timeText_.text = var_52_58

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_timeText_)

				local var_52_59 = arg_49_1:GetWordFromCfg(501034)
				local var_52_60 = arg_49_1:FormatText(var_52_59.content)

				arg_49_1.text_siteText_.text = var_52_60

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_siteText_)
			end

			if arg_49_1.time_ >= var_52_54 + var_52_55 and arg_49_1.time_ < var_52_54 + var_52_55 + arg_52_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_49_1.timestampAni_, "out", function()
					arg_49_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_52_61 = 4.999999999999

			if var_52_61 < arg_49_1.time_ and arg_49_1.time_ <= var_52_61 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_62 = 1.2

			if var_52_61 <= arg_49_1.time_ and arg_49_1.time_ < var_52_61 + var_52_62 then
				local var_52_63 = (arg_49_1.time_ - var_52_61) / var_52_62
				local var_52_64 = Color.New(0, 0, 0)

				var_52_64.a = Mathf.Lerp(0, 1, var_52_63)
				arg_49_1.mask_.color = var_52_64
			end

			if arg_49_1.time_ >= var_52_61 + var_52_62 and arg_49_1.time_ < var_52_61 + var_52_62 + arg_52_0 then
				local var_52_65 = Color.New(0, 0, 0)

				var_52_65.a = 1
				arg_49_1.mask_.color = var_52_65
			end

			local var_52_66 = 6.199999999999

			if var_52_66 < arg_49_1.time_ and arg_49_1.time_ <= var_52_66 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_67 = 1.2

			if var_52_66 <= arg_49_1.time_ and arg_49_1.time_ < var_52_66 + var_52_67 then
				local var_52_68 = (arg_49_1.time_ - var_52_66) / var_52_67
				local var_52_69 = Color.New(0, 0, 0)

				var_52_69.a = Mathf.Lerp(1, 0, var_52_68)
				arg_49_1.mask_.color = var_52_69
			end

			if arg_49_1.time_ >= var_52_66 + var_52_67 and arg_49_1.time_ < var_52_66 + var_52_67 + arg_52_0 then
				local var_52_70 = Color.New(0, 0, 0)
				local var_52_71 = 0

				arg_49_1.mask_.enabled = false
				var_52_70.a = var_52_71
				arg_49_1.mask_.color = var_52_70
			end

			local var_52_72 = 1.999999999999

			if var_52_72 < arg_49_1.time_ and arg_49_1.time_ <= var_52_72 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = false

				arg_49_1:SetGaussion(false)
			end

			local var_52_73 = 1

			if var_52_72 <= arg_49_1.time_ and arg_49_1.time_ < var_52_72 + var_52_73 then
				local var_52_74 = (arg_49_1.time_ - var_52_72) / var_52_73
				local var_52_75 = Color.New(0, 0, 0)

				var_52_75.a = Mathf.Lerp(1, 0, var_52_74)
				arg_49_1.mask_.color = var_52_75
			end

			if arg_49_1.time_ >= var_52_72 + var_52_73 and arg_49_1.time_ < var_52_72 + var_52_73 + arg_52_0 then
				local var_52_76 = Color.New(0, 0, 0)
				local var_52_77 = 0

				arg_49_1.mask_.enabled = false
				var_52_76.a = var_52_77
				arg_49_1.mask_.color = var_52_76
			end

			local var_52_78 = 1.999999999999

			arg_49_1.isInRecall_ = false

			if var_52_78 < arg_49_1.time_ and arg_49_1.time_ <= var_52_78 + arg_52_0 then
				arg_49_1.screenFilterGo_:SetActive(false)

				for iter_52_7, iter_52_8 in pairs(arg_49_1.actors_) do
					local var_52_79 = iter_52_8:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_52_9, iter_52_10 in ipairs(var_52_79) do
						if iter_52_10.color.r > 0.51 then
							iter_52_10.color = Color.New(1, 1, 1)
						else
							iter_52_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_52_80 = 0.1

			if var_52_78 <= arg_49_1.time_ and arg_49_1.time_ < var_52_78 + var_52_80 then
				local var_52_81 = (arg_49_1.time_ - var_52_78) / var_52_80

				arg_49_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_52_81)
			end

			if arg_49_1.time_ >= var_52_78 + var_52_80 and arg_49_1.time_ < var_52_78 + var_52_80 + arg_52_0 then
				arg_49_1.screenFilterEffect_.weight = 0
			end

			local var_52_82 = 1.999999999999

			if var_52_82 < arg_49_1.time_ and arg_49_1.time_ <= var_52_82 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			local var_52_83 = 3

			if arg_49_1.time_ >= var_52_82 + var_52_83 and arg_49_1.time_ < var_52_82 + var_52_83 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_84 = 7.399999999999
			local var_52_85 = 1.425

			if var_52_84 < arg_49_1.time_ and arg_49_1.time_ <= var_52_84 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_86 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_86:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_49_1.dialogCg_.alpha = arg_56_0
				end))
				var_52_86:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_86:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_87 = arg_49_1:GetWordFromCfg(417091012)
				local var_52_88 = arg_49_1:FormatText(var_52_87.content)

				arg_49_1.text_.text = var_52_88

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_89 = 57
				local var_52_90 = utf8.len(var_52_88)
				local var_52_91 = var_52_89 <= 0 and var_52_85 or var_52_85 * (var_52_90 / var_52_89)

				if var_52_91 > 0 and var_52_85 < var_52_91 then
					arg_49_1.talkMaxDuration = var_52_91
					var_52_84 = var_52_84 + 0.3

					if var_52_91 + var_52_84 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_91 + var_52_84
					end
				end

				arg_49_1.text_.text = var_52_88
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_92 = var_52_84 + 0.3
			local var_52_93 = math.max(var_52_85, arg_49_1.talkMaxDuration)

			if var_52_92 <= arg_49_1.time_ and arg_49_1.time_ < var_52_92 + var_52_93 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_92) / var_52_93

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_92 + var_52_93 and arg_49_1.time_ < var_52_92 + var_52_93 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play417091013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417091013
		arg_58_1.duration_ = 8.23

		local var_58_0 = {
			zh = 4.066,
			ja = 8.233
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
				arg_58_0:Play417091014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1034"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1034 == nil then
				arg_58_1.var_.actorSpriteComps1034 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps1034 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								local var_61_4 = Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, var_61_3)
								local var_61_5 = Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, var_61_3)
								local var_61_6 = Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, var_61_3)

								iter_61_1.color = Color.New(var_61_4, var_61_5, var_61_6)
							else
								local var_61_7 = Mathf.Lerp(iter_61_1.color.r, 1, var_61_3)

								iter_61_1.color = Color.New(var_61_7, var_61_7, var_61_7)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1034 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1034 = nil
			end

			local var_61_8 = arg_58_1.actors_["1034"].transform
			local var_61_9 = 0

			if var_61_9 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 then
				arg_58_1.var_.moveOldPos1034 = var_61_8.localPosition
				var_61_8.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("1034", 3)

				local var_61_10 = var_61_8.childCount

				for iter_61_4 = 0, var_61_10 - 1 do
					local var_61_11 = var_61_8:GetChild(iter_61_4)

					if var_61_11.name == "" or not string.find(var_61_11.name, "split") then
						var_61_11.gameObject:SetActive(true)
					else
						var_61_11.gameObject:SetActive(false)
					end
				end
			end

			local var_61_12 = 0.001

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_12 then
				local var_61_13 = (arg_58_1.time_ - var_61_9) / var_61_12
				local var_61_14 = Vector3.New(0, -331.9, -324)

				var_61_8.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1034, var_61_14, var_61_13)
			end

			if arg_58_1.time_ >= var_61_9 + var_61_12 and arg_58_1.time_ < var_61_9 + var_61_12 + arg_61_0 then
				var_61_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_61_15 = 0
			local var_61_16 = 0.5

			if var_61_15 < arg_58_1.time_ and arg_58_1.time_ <= var_61_15 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_17 = arg_58_1:FormatText(StoryNameCfg[1109].name)

				arg_58_1.leftNameTxt_.text = var_61_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_18 = arg_58_1:GetWordFromCfg(417091013)
				local var_61_19 = arg_58_1:FormatText(var_61_18.content)

				arg_58_1.text_.text = var_61_19

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_20 = 20
				local var_61_21 = utf8.len(var_61_19)
				local var_61_22 = var_61_20 <= 0 and var_61_16 or var_61_16 * (var_61_21 / var_61_20)

				if var_61_22 > 0 and var_61_16 < var_61_22 then
					arg_58_1.talkMaxDuration = var_61_22

					if var_61_22 + var_61_15 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_22 + var_61_15
					end
				end

				arg_58_1.text_.text = var_61_19
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091013", "story_v_out_417091.awb") ~= 0 then
					local var_61_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091013", "story_v_out_417091.awb") / 1000

					if var_61_23 + var_61_15 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_23 + var_61_15
					end

					if var_61_18.prefab_name ~= "" and arg_58_1.actors_[var_61_18.prefab_name] ~= nil then
						local var_61_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_18.prefab_name].transform, "story_v_out_417091", "417091013", "story_v_out_417091.awb")

						arg_58_1:RecordAudio("417091013", var_61_24)
						arg_58_1:RecordAudio("417091013", var_61_24)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417091", "417091013", "story_v_out_417091.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417091", "417091013", "story_v_out_417091.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_25 = math.max(var_61_16, arg_58_1.talkMaxDuration)

			if var_61_15 <= arg_58_1.time_ and arg_58_1.time_ < var_61_15 + var_61_25 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_15) / var_61_25

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_15 + var_61_25 and arg_58_1.time_ < var_61_15 + var_61_25 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play417091014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417091014
		arg_62_1.duration_ = 5.5

		local var_62_0 = {
			zh = 2.633,
			ja = 5.5
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
				arg_62_0:Play417091015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1034"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1034 == nil then
				arg_62_1.var_.actorSpriteComps1034 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps1034 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								local var_65_4 = Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor2.r, var_65_3)
								local var_65_5 = Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor2.g, var_65_3)
								local var_65_6 = Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor2.b, var_65_3)

								iter_65_1.color = Color.New(var_65_4, var_65_5, var_65_6)
							else
								local var_65_7 = Mathf.Lerp(iter_65_1.color.r, 0.5, var_65_3)

								iter_65_1.color = Color.New(var_65_7, var_65_7, var_65_7)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1034 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_65_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps1034 = nil
			end

			local var_65_8 = 0
			local var_65_9 = 0.25

			if var_65_8 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_10 = arg_62_1:FormatText(StoryNameCfg[1110].name)

				arg_62_1.leftNameTxt_.text = var_65_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_11 = arg_62_1:GetWordFromCfg(417091014)
				local var_65_12 = arg_62_1:FormatText(var_65_11.content)

				arg_62_1.text_.text = var_65_12

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091014", "story_v_out_417091.awb") ~= 0 then
					local var_65_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091014", "story_v_out_417091.awb") / 1000

					if var_65_16 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_16 + var_65_8
					end

					if var_65_11.prefab_name ~= "" and arg_62_1.actors_[var_65_11.prefab_name] ~= nil then
						local var_65_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_11.prefab_name].transform, "story_v_out_417091", "417091014", "story_v_out_417091.awb")

						arg_62_1:RecordAudio("417091014", var_65_17)
						arg_62_1:RecordAudio("417091014", var_65_17)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417091", "417091014", "story_v_out_417091.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417091", "417091014", "story_v_out_417091.awb")
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
	Play417091015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417091015
		arg_66_1.duration_ = 9.77

		local var_66_0 = {
			zh = 5.5,
			ja = 9.766
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play417091016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1034"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1034 == nil then
				arg_66_1.var_.actorSpriteComps1034 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps1034 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								local var_69_4 = Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor1.r, var_69_3)
								local var_69_5 = Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor1.g, var_69_3)
								local var_69_6 = Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor1.b, var_69_3)

								iter_69_1.color = Color.New(var_69_4, var_69_5, var_69_6)
							else
								local var_69_7 = Mathf.Lerp(iter_69_1.color.r, 1, var_69_3)

								iter_69_1.color = Color.New(var_69_7, var_69_7, var_69_7)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1034 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_69_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1034 = nil
			end

			local var_69_8 = arg_66_1.actors_["1034"].transform
			local var_69_9 = 0

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				arg_66_1.var_.moveOldPos1034 = var_69_8.localPosition
				var_69_8.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1034", 3)

				local var_69_10 = var_69_8.childCount

				for iter_69_4 = 0, var_69_10 - 1 do
					local var_69_11 = var_69_8:GetChild(iter_69_4)

					if var_69_11.name == "split_3" or not string.find(var_69_11.name, "split") then
						var_69_11.gameObject:SetActive(true)
					else
						var_69_11.gameObject:SetActive(false)
					end
				end
			end

			local var_69_12 = 0.001

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_12 then
				local var_69_13 = (arg_66_1.time_ - var_69_9) / var_69_12
				local var_69_14 = Vector3.New(0, -331.9, -324)

				var_69_8.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1034, var_69_14, var_69_13)
			end

			if arg_66_1.time_ >= var_69_9 + var_69_12 and arg_66_1.time_ < var_69_9 + var_69_12 + arg_69_0 then
				var_69_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_69_15 = 0
			local var_69_16 = 0.75

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_17 = arg_66_1:FormatText(StoryNameCfg[1109].name)

				arg_66_1.leftNameTxt_.text = var_69_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_18 = arg_66_1:GetWordFromCfg(417091015)
				local var_69_19 = arg_66_1:FormatText(var_69_18.content)

				arg_66_1.text_.text = var_69_19

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_20 = 30
				local var_69_21 = utf8.len(var_69_19)
				local var_69_22 = var_69_20 <= 0 and var_69_16 or var_69_16 * (var_69_21 / var_69_20)

				if var_69_22 > 0 and var_69_16 < var_69_22 then
					arg_66_1.talkMaxDuration = var_69_22

					if var_69_22 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_19
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091015", "story_v_out_417091.awb") ~= 0 then
					local var_69_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091015", "story_v_out_417091.awb") / 1000

					if var_69_23 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_15
					end

					if var_69_18.prefab_name ~= "" and arg_66_1.actors_[var_69_18.prefab_name] ~= nil then
						local var_69_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_18.prefab_name].transform, "story_v_out_417091", "417091015", "story_v_out_417091.awb")

						arg_66_1:RecordAudio("417091015", var_69_24)
						arg_66_1:RecordAudio("417091015", var_69_24)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417091", "417091015", "story_v_out_417091.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417091", "417091015", "story_v_out_417091.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_25 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_15) / var_69_25

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_15 + var_69_25 and arg_66_1.time_ < var_69_15 + var_69_25 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play417091016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417091016
		arg_70_1.duration_ = 1.17

		local var_70_0 = {
			zh = 1,
			ja = 1.166
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play417091017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1034"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1034 == nil then
				arg_70_1.var_.actorSpriteComps1034 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps1034 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor2.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor2.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor2.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 0.5, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1034 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps1034 = nil
			end

			local var_73_8 = 0
			local var_73_9 = 0.075

			if var_73_8 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_10 = arg_70_1:FormatText(StoryNameCfg[1110].name)

				arg_70_1.leftNameTxt_.text = var_73_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_11 = arg_70_1:GetWordFromCfg(417091016)
				local var_73_12 = arg_70_1:FormatText(var_73_11.content)

				arg_70_1.text_.text = var_73_12

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_13 = 3
				local var_73_14 = utf8.len(var_73_12)
				local var_73_15 = var_73_13 <= 0 and var_73_9 or var_73_9 * (var_73_14 / var_73_13)

				if var_73_15 > 0 and var_73_9 < var_73_15 then
					arg_70_1.talkMaxDuration = var_73_15

					if var_73_15 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_15 + var_73_8
					end
				end

				arg_70_1.text_.text = var_73_12
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091016", "story_v_out_417091.awb") ~= 0 then
					local var_73_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091016", "story_v_out_417091.awb") / 1000

					if var_73_16 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_16 + var_73_8
					end

					if var_73_11.prefab_name ~= "" and arg_70_1.actors_[var_73_11.prefab_name] ~= nil then
						local var_73_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_11.prefab_name].transform, "story_v_out_417091", "417091016", "story_v_out_417091.awb")

						arg_70_1:RecordAudio("417091016", var_73_17)
						arg_70_1:RecordAudio("417091016", var_73_17)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417091", "417091016", "story_v_out_417091.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417091", "417091016", "story_v_out_417091.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_18 = math.max(var_73_9, arg_70_1.talkMaxDuration)

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_18 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_8) / var_73_18

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_8 + var_73_18 and arg_70_1.time_ < var_73_8 + var_73_18 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417091017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417091017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417091018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1034"].transform
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.var_.moveOldPos1034 = var_77_0.localPosition
				var_77_0.localScale = Vector3.New(1, 1, 1)

				arg_74_1:CheckSpriteTmpPos("1034", 7)

				local var_77_2 = var_77_0.childCount

				for iter_77_0 = 0, var_77_2 - 1 do
					local var_77_3 = var_77_0:GetChild(iter_77_0)

					if var_77_3.name == "" or not string.find(var_77_3.name, "split") then
						var_77_3.gameObject:SetActive(true)
					else
						var_77_3.gameObject:SetActive(false)
					end
				end
			end

			local var_77_4 = 0.001

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_4 then
				local var_77_5 = (arg_74_1.time_ - var_77_1) / var_77_4
				local var_77_6 = Vector3.New(0, -2000, 0)

				var_77_0.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1034, var_77_6, var_77_5)
			end

			if arg_74_1.time_ >= var_77_1 + var_77_4 and arg_74_1.time_ < var_77_1 + var_77_4 + arg_77_0 then
				var_77_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_77_7 = 0
			local var_77_8 = 1.4

			if var_77_7 < arg_74_1.time_ and arg_74_1.time_ <= var_77_7 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_9 = arg_74_1:GetWordFromCfg(417091017)
				local var_77_10 = arg_74_1:FormatText(var_77_9.content)

				arg_74_1.text_.text = var_77_10

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 56
				local var_77_12 = utf8.len(var_77_10)
				local var_77_13 = var_77_11 <= 0 and var_77_8 or var_77_8 * (var_77_12 / var_77_11)

				if var_77_13 > 0 and var_77_8 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_7 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_7
					end
				end

				arg_74_1.text_.text = var_77_10
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_14 = math.max(var_77_8, arg_74_1.talkMaxDuration)

			if var_77_7 <= arg_74_1.time_ and arg_74_1.time_ < var_77_7 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_7) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_7 + var_77_14 and arg_74_1.time_ < var_77_7 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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

		arg_74_1:InitPlayNodeList()
	end,
	Play417091018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417091018
		arg_78_1.duration_ = 9.93

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417091019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1034"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps1034 == nil then
				arg_78_1.var_.actorSpriteComps1034 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps1034 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps1034 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps1034 = nil
			end

			local var_81_8 = arg_78_1.actors_["1034"].transform
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.var_.moveOldPos1034 = var_81_8.localPosition
				var_81_8.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1034", 3)

				local var_81_10 = var_81_8.childCount

				for iter_81_4 = 0, var_81_10 - 1 do
					local var_81_11 = var_81_8:GetChild(iter_81_4)

					if var_81_11.name == "split_7" or not string.find(var_81_11.name, "split") then
						var_81_11.gameObject:SetActive(true)
					else
						var_81_11.gameObject:SetActive(false)
					end
				end
			end

			local var_81_12 = 0.001

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_12 then
				local var_81_13 = (arg_78_1.time_ - var_81_9) / var_81_12
				local var_81_14 = Vector3.New(0, -331.9, -324)

				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1034, var_81_14, var_81_13)
			end

			if arg_78_1.time_ >= var_81_9 + var_81_12 and arg_78_1.time_ < var_81_9 + var_81_12 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_81_15 = 0
			local var_81_16 = 1.275

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_17 = arg_78_1:FormatText(StoryNameCfg[1109].name)

				arg_78_1.leftNameTxt_.text = var_81_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(417091018)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 50
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

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091018", "story_v_out_417091.awb") ~= 0 then
					local var_81_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091018", "story_v_out_417091.awb") / 1000

					if var_81_23 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_15
					end

					if var_81_18.prefab_name ~= "" and arg_78_1.actors_[var_81_18.prefab_name] ~= nil then
						local var_81_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_18.prefab_name].transform, "story_v_out_417091", "417091018", "story_v_out_417091.awb")

						arg_78_1:RecordAudio("417091018", var_81_24)
						arg_78_1:RecordAudio("417091018", var_81_24)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417091", "417091018", "story_v_out_417091.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417091", "417091018", "story_v_out_417091.awb")
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
				actorName = "1034",
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
	Play417091019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417091019
		arg_82_1.duration_ = 2.53

		local var_82_0 = {
			zh = 2.533,
			ja = 2
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
				arg_82_0:Play417091020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1034"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1034 == nil then
				arg_82_1.var_.actorSpriteComps1034 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps1034 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								local var_85_4 = Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor2.r, var_85_3)
								local var_85_5 = Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor2.g, var_85_3)
								local var_85_6 = Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor2.b, var_85_3)

								iter_85_1.color = Color.New(var_85_4, var_85_5, var_85_6)
							else
								local var_85_7 = Mathf.Lerp(iter_85_1.color.r, 0.5, var_85_3)

								iter_85_1.color = Color.New(var_85_7, var_85_7, var_85_7)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1034 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_85_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps1034 = nil
			end

			local var_85_8 = 0
			local var_85_9 = 0.25

			if var_85_8 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_10 = arg_82_1:FormatText(StoryNameCfg[1110].name)

				arg_82_1.leftNameTxt_.text = var_85_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_11 = arg_82_1:GetWordFromCfg(417091019)
				local var_85_12 = arg_82_1:FormatText(var_85_11.content)

				arg_82_1.text_.text = var_85_12

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_13 = 10
				local var_85_14 = utf8.len(var_85_12)
				local var_85_15 = var_85_13 <= 0 and var_85_9 or var_85_9 * (var_85_14 / var_85_13)

				if var_85_15 > 0 and var_85_9 < var_85_15 then
					arg_82_1.talkMaxDuration = var_85_15

					if var_85_15 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_15 + var_85_8
					end
				end

				arg_82_1.text_.text = var_85_12
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091019", "story_v_out_417091.awb") ~= 0 then
					local var_85_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091019", "story_v_out_417091.awb") / 1000

					if var_85_16 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_16 + var_85_8
					end

					if var_85_11.prefab_name ~= "" and arg_82_1.actors_[var_85_11.prefab_name] ~= nil then
						local var_85_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_11.prefab_name].transform, "story_v_out_417091", "417091019", "story_v_out_417091.awb")

						arg_82_1:RecordAudio("417091019", var_85_17)
						arg_82_1:RecordAudio("417091019", var_85_17)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417091", "417091019", "story_v_out_417091.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417091", "417091019", "story_v_out_417091.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_18 = math.max(var_85_9, arg_82_1.talkMaxDuration)

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_18 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_8) / var_85_18

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_8 + var_85_18 and arg_82_1.time_ < var_85_8 + var_85_18 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417091020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417091020
		arg_86_1.duration_ = 7.8

		local var_86_0 = {
			zh = 5.766,
			ja = 7.8
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417091021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1034"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1034 == nil then
				arg_86_1.var_.actorSpriteComps1034 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps1034 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor1.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor1.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor1.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 1, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1034 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps1034 = nil
			end

			local var_89_8 = 0
			local var_89_9 = 0.8

			if var_89_8 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_10 = arg_86_1:FormatText(StoryNameCfg[1109].name)

				arg_86_1.leftNameTxt_.text = var_89_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_11 = arg_86_1:GetWordFromCfg(417091020)
				local var_89_12 = arg_86_1:FormatText(var_89_11.content)

				arg_86_1.text_.text = var_89_12

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 32
				local var_89_14 = utf8.len(var_89_12)
				local var_89_15 = var_89_13 <= 0 and var_89_9 or var_89_9 * (var_89_14 / var_89_13)

				if var_89_15 > 0 and var_89_9 < var_89_15 then
					arg_86_1.talkMaxDuration = var_89_15

					if var_89_15 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_15 + var_89_8
					end
				end

				arg_86_1.text_.text = var_89_12
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091020", "story_v_out_417091.awb") ~= 0 then
					local var_89_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091020", "story_v_out_417091.awb") / 1000

					if var_89_16 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_8
					end

					if var_89_11.prefab_name ~= "" and arg_86_1.actors_[var_89_11.prefab_name] ~= nil then
						local var_89_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_11.prefab_name].transform, "story_v_out_417091", "417091020", "story_v_out_417091.awb")

						arg_86_1:RecordAudio("417091020", var_89_17)
						arg_86_1:RecordAudio("417091020", var_89_17)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417091", "417091020", "story_v_out_417091.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417091", "417091020", "story_v_out_417091.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_18 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_18 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_18

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_18 and arg_86_1.time_ < var_89_8 + var_89_18 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417091021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417091021
		arg_90_1.duration_ = 6.4

		local var_90_0 = {
			zh = 4.833,
			ja = 6.4
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play417091022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1034"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos1034 = var_93_0.localPosition
				var_93_0.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("1034", 3)

				local var_93_2 = var_93_0.childCount

				for iter_93_0 = 0, var_93_2 - 1 do
					local var_93_3 = var_93_0:GetChild(iter_93_0)

					if var_93_3.name == "" or not string.find(var_93_3.name, "split") then
						var_93_3.gameObject:SetActive(true)
					else
						var_93_3.gameObject:SetActive(false)
					end
				end
			end

			local var_93_4 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_4 then
				local var_93_5 = (arg_90_1.time_ - var_93_1) / var_93_4
				local var_93_6 = Vector3.New(0, -331.9, -324)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1034, var_93_6, var_93_5)
			end

			if arg_90_1.time_ >= var_93_1 + var_93_4 and arg_90_1.time_ < var_93_1 + var_93_4 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_93_7 = 0
			local var_93_8 = 0.625

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_9 = arg_90_1:FormatText(StoryNameCfg[1109].name)

				arg_90_1.leftNameTxt_.text = var_93_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(417091021)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_12 = 25
				local var_93_13 = utf8.len(var_93_11)
				local var_93_14 = var_93_12 <= 0 and var_93_8 or var_93_8 * (var_93_13 / var_93_12)

				if var_93_14 > 0 and var_93_8 < var_93_14 then
					arg_90_1.talkMaxDuration = var_93_14

					if var_93_14 + var_93_7 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_7
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091021", "story_v_out_417091.awb") ~= 0 then
					local var_93_15 = manager.audio:GetVoiceLength("story_v_out_417091", "417091021", "story_v_out_417091.awb") / 1000

					if var_93_15 + var_93_7 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_15 + var_93_7
					end

					if var_93_10.prefab_name ~= "" and arg_90_1.actors_[var_93_10.prefab_name] ~= nil then
						local var_93_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_10.prefab_name].transform, "story_v_out_417091", "417091021", "story_v_out_417091.awb")

						arg_90_1:RecordAudio("417091021", var_93_16)
						arg_90_1:RecordAudio("417091021", var_93_16)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417091", "417091021", "story_v_out_417091.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417091", "417091021", "story_v_out_417091.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_17 = math.max(var_93_8, arg_90_1.talkMaxDuration)

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_17 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_7) / var_93_17

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_7 + var_93_17 and arg_90_1.time_ < var_93_7 + var_93_17 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play417091022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417091022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play417091023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1034"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1034 == nil then
				arg_94_1.var_.actorSpriteComps1034 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps1034 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								local var_97_4 = Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, var_97_3)
								local var_97_5 = Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, var_97_3)
								local var_97_6 = Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, var_97_3)

								iter_97_1.color = Color.New(var_97_4, var_97_5, var_97_6)
							else
								local var_97_7 = Mathf.Lerp(iter_97_1.color.r, 0.5, var_97_3)

								iter_97_1.color = Color.New(var_97_7, var_97_7, var_97_7)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1034 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_97_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps1034 = nil
			end

			local var_97_8 = 0
			local var_97_9 = 1.225

			if var_97_8 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(417091022)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_12 = 49
				local var_97_13 = utf8.len(var_97_11)
				local var_97_14 = var_97_12 <= 0 and var_97_9 or var_97_9 * (var_97_13 / var_97_12)

				if var_97_14 > 0 and var_97_9 < var_97_14 then
					arg_94_1.talkMaxDuration = var_97_14

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_15 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_15 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_15

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_15 and arg_94_1.time_ < var_97_8 + var_97_15 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417091023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417091023
		arg_98_1.duration_ = 8.43

		local var_98_0 = {
			zh = 5.866,
			ja = 8.433
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417091024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1034"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1034 == nil then
				arg_98_1.var_.actorSpriteComps1034 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps1034 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								local var_101_4 = Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, var_101_3)
								local var_101_5 = Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, var_101_3)
								local var_101_6 = Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, var_101_3)

								iter_101_1.color = Color.New(var_101_4, var_101_5, var_101_6)
							else
								local var_101_7 = Mathf.Lerp(iter_101_1.color.r, 1, var_101_3)

								iter_101_1.color = Color.New(var_101_7, var_101_7, var_101_7)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1034 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_101_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps1034 = nil
			end

			local var_101_8 = 0
			local var_101_9 = 0.775

			if var_101_8 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_10 = arg_98_1:FormatText(StoryNameCfg[1109].name)

				arg_98_1.leftNameTxt_.text = var_101_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_11 = arg_98_1:GetWordFromCfg(417091023)
				local var_101_12 = arg_98_1:FormatText(var_101_11.content)

				arg_98_1.text_.text = var_101_12

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 31
				local var_101_14 = utf8.len(var_101_12)
				local var_101_15 = var_101_13 <= 0 and var_101_9 or var_101_9 * (var_101_14 / var_101_13)

				if var_101_15 > 0 and var_101_9 < var_101_15 then
					arg_98_1.talkMaxDuration = var_101_15

					if var_101_15 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_15 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_12
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091023", "story_v_out_417091.awb") ~= 0 then
					local var_101_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091023", "story_v_out_417091.awb") / 1000

					if var_101_16 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_16 + var_101_8
					end

					if var_101_11.prefab_name ~= "" and arg_98_1.actors_[var_101_11.prefab_name] ~= nil then
						local var_101_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_11.prefab_name].transform, "story_v_out_417091", "417091023", "story_v_out_417091.awb")

						arg_98_1:RecordAudio("417091023", var_101_17)
						arg_98_1:RecordAudio("417091023", var_101_17)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417091", "417091023", "story_v_out_417091.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417091", "417091023", "story_v_out_417091.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_18 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_18 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_18

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_18 and arg_98_1.time_ < var_101_8 + var_101_18 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417091024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417091024
		arg_102_1.duration_ = 3.73

		local var_102_0 = {
			zh = 2.033,
			ja = 3.733
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play417091025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1034"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1034 == nil then
				arg_102_1.var_.actorSpriteComps1034 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps1034 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor2.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor2.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor2.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 0.5, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1034 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps1034 = nil
			end

			local var_105_8 = 0
			local var_105_9 = 0.175

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_10 = arg_102_1:FormatText(StoryNameCfg[1110].name)

				arg_102_1.leftNameTxt_.text = var_105_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_11 = arg_102_1:GetWordFromCfg(417091024)
				local var_105_12 = arg_102_1:FormatText(var_105_11.content)

				arg_102_1.text_.text = var_105_12

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 7
				local var_105_14 = utf8.len(var_105_12)
				local var_105_15 = var_105_13 <= 0 and var_105_9 or var_105_9 * (var_105_14 / var_105_13)

				if var_105_15 > 0 and var_105_9 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_8
					end
				end

				arg_102_1.text_.text = var_105_12
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091024", "story_v_out_417091.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091024", "story_v_out_417091.awb") / 1000

					if var_105_16 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_8
					end

					if var_105_11.prefab_name ~= "" and arg_102_1.actors_[var_105_11.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_11.prefab_name].transform, "story_v_out_417091", "417091024", "story_v_out_417091.awb")

						arg_102_1:RecordAudio("417091024", var_105_17)
						arg_102_1:RecordAudio("417091024", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417091", "417091024", "story_v_out_417091.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417091", "417091024", "story_v_out_417091.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_18 = math.max(var_105_9, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_18 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_8) / var_105_18

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_18 and arg_102_1.time_ < var_105_8 + var_105_18 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417091025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417091025
		arg_106_1.duration_ = 7.13

		local var_106_0 = {
			zh = 2.7,
			ja = 7.133
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play417091026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1034"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps1034 == nil then
				arg_106_1.var_.actorSpriteComps1034 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps1034 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 1, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps1034 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps1034 = nil
			end

			local var_109_8 = arg_106_1.actors_["1034"].transform
			local var_109_9 = 0

			if var_109_9 < arg_106_1.time_ and arg_106_1.time_ <= var_109_9 + arg_109_0 then
				arg_106_1.var_.moveOldPos1034 = var_109_8.localPosition
				var_109_8.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("1034", 3)

				local var_109_10 = var_109_8.childCount

				for iter_109_4 = 0, var_109_10 - 1 do
					local var_109_11 = var_109_8:GetChild(iter_109_4)

					if var_109_11.name == "" or not string.find(var_109_11.name, "split") then
						var_109_11.gameObject:SetActive(true)
					else
						var_109_11.gameObject:SetActive(false)
					end
				end
			end

			local var_109_12 = 0.001

			if var_109_9 <= arg_106_1.time_ and arg_106_1.time_ < var_109_9 + var_109_12 then
				local var_109_13 = (arg_106_1.time_ - var_109_9) / var_109_12
				local var_109_14 = Vector3.New(0, -331.9, -324)

				var_109_8.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1034, var_109_14, var_109_13)
			end

			if arg_106_1.time_ >= var_109_9 + var_109_12 and arg_106_1.time_ < var_109_9 + var_109_12 + arg_109_0 then
				var_109_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_109_15 = 0
			local var_109_16 = 0.35

			if var_109_15 < arg_106_1.time_ and arg_106_1.time_ <= var_109_15 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_17 = arg_106_1:FormatText(StoryNameCfg[1109].name)

				arg_106_1.leftNameTxt_.text = var_109_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_18 = arg_106_1:GetWordFromCfg(417091025)
				local var_109_19 = arg_106_1:FormatText(var_109_18.content)

				arg_106_1.text_.text = var_109_19

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_20 = 14
				local var_109_21 = utf8.len(var_109_19)
				local var_109_22 = var_109_20 <= 0 and var_109_16 or var_109_16 * (var_109_21 / var_109_20)

				if var_109_22 > 0 and var_109_16 < var_109_22 then
					arg_106_1.talkMaxDuration = var_109_22

					if var_109_22 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_22 + var_109_15
					end
				end

				arg_106_1.text_.text = var_109_19
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091025", "story_v_out_417091.awb") ~= 0 then
					local var_109_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091025", "story_v_out_417091.awb") / 1000

					if var_109_23 + var_109_15 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_23 + var_109_15
					end

					if var_109_18.prefab_name ~= "" and arg_106_1.actors_[var_109_18.prefab_name] ~= nil then
						local var_109_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_18.prefab_name].transform, "story_v_out_417091", "417091025", "story_v_out_417091.awb")

						arg_106_1:RecordAudio("417091025", var_109_24)
						arg_106_1:RecordAudio("417091025", var_109_24)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417091", "417091025", "story_v_out_417091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417091", "417091025", "story_v_out_417091.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_25 = math.max(var_109_16, arg_106_1.talkMaxDuration)

			if var_109_15 <= arg_106_1.time_ and arg_106_1.time_ < var_109_15 + var_109_25 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_15) / var_109_25

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_15 + var_109_25 and arg_106_1.time_ < var_109_15 + var_109_25 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play417091026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417091026
		arg_110_1.duration_ = 6.13

		local var_110_0 = {
			zh = 3.9,
			ja = 6.133
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play417091027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1034"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps1034 == nil then
				arg_110_1.var_.actorSpriteComps1034 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps1034 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								local var_113_4 = Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor2.r, var_113_3)
								local var_113_5 = Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor2.g, var_113_3)
								local var_113_6 = Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor2.b, var_113_3)

								iter_113_1.color = Color.New(var_113_4, var_113_5, var_113_6)
							else
								local var_113_7 = Mathf.Lerp(iter_113_1.color.r, 0.5, var_113_3)

								iter_113_1.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps1034 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps1034 = nil
			end

			local var_113_8 = 0
			local var_113_9 = 0.55

			if var_113_8 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_10 = arg_110_1:FormatText(StoryNameCfg[1110].name)

				arg_110_1.leftNameTxt_.text = var_113_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_11 = arg_110_1:GetWordFromCfg(417091026)
				local var_113_12 = arg_110_1:FormatText(var_113_11.content)

				arg_110_1.text_.text = var_113_12

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_13 = 22
				local var_113_14 = utf8.len(var_113_12)
				local var_113_15 = var_113_13 <= 0 and var_113_9 or var_113_9 * (var_113_14 / var_113_13)

				if var_113_15 > 0 and var_113_9 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_8
					end
				end

				arg_110_1.text_.text = var_113_12
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091026", "story_v_out_417091.awb") ~= 0 then
					local var_113_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091026", "story_v_out_417091.awb") / 1000

					if var_113_16 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_16 + var_113_8
					end

					if var_113_11.prefab_name ~= "" and arg_110_1.actors_[var_113_11.prefab_name] ~= nil then
						local var_113_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_11.prefab_name].transform, "story_v_out_417091", "417091026", "story_v_out_417091.awb")

						arg_110_1:RecordAudio("417091026", var_113_17)
						arg_110_1:RecordAudio("417091026", var_113_17)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417091", "417091026", "story_v_out_417091.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417091", "417091026", "story_v_out_417091.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_18 = math.max(var_113_9, arg_110_1.talkMaxDuration)

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_18 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_8) / var_113_18

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_8 + var_113_18 and arg_110_1.time_ < var_113_8 + var_113_18 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play417091027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417091027
		arg_114_1.duration_ = 11.7

		local var_114_0 = {
			zh = 9.433,
			ja = 11.7
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play417091028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0
			local var_117_1 = 1.325

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[1110].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:GetWordFromCfg(417091027)
				local var_117_4 = arg_114_1:FormatText(var_117_3.content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 53
				local var_117_6 = utf8.len(var_117_4)
				local var_117_7 = var_117_5 <= 0 and var_117_1 or var_117_1 * (var_117_6 / var_117_5)

				if var_117_7 > 0 and var_117_1 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091027", "story_v_out_417091.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091027", "story_v_out_417091.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_417091", "417091027", "story_v_out_417091.awb")

						arg_114_1:RecordAudio("417091027", var_117_9)
						arg_114_1:RecordAudio("417091027", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_417091", "417091027", "story_v_out_417091.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_417091", "417091027", "story_v_out_417091.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_10 and arg_114_1.time_ < var_117_0 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play417091028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417091028
		arg_118_1.duration_ = 6.13

		local var_118_0 = {
			zh = 4.4,
			ja = 6.133
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play417091029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1034"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps1034 == nil then
				arg_118_1.var_.actorSpriteComps1034 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps1034 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor1.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor1.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor1.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 1, var_121_3)

								iter_121_1.color = Color.New(var_121_7, var_121_7, var_121_7)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps1034 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_121_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps1034 = nil
			end

			local var_121_8 = 0
			local var_121_9 = 0.425

			if var_121_8 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_10 = arg_118_1:FormatText(StoryNameCfg[1109].name)

				arg_118_1.leftNameTxt_.text = var_121_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_11 = arg_118_1:GetWordFromCfg(417091028)
				local var_121_12 = arg_118_1:FormatText(var_121_11.content)

				arg_118_1.text_.text = var_121_12

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 17
				local var_121_14 = utf8.len(var_121_12)
				local var_121_15 = var_121_13 <= 0 and var_121_9 or var_121_9 * (var_121_14 / var_121_13)

				if var_121_15 > 0 and var_121_9 < var_121_15 then
					arg_118_1.talkMaxDuration = var_121_15

					if var_121_15 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_15 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_12
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091028", "story_v_out_417091.awb") ~= 0 then
					local var_121_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091028", "story_v_out_417091.awb") / 1000

					if var_121_16 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_16 + var_121_8
					end

					if var_121_11.prefab_name ~= "" and arg_118_1.actors_[var_121_11.prefab_name] ~= nil then
						local var_121_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_11.prefab_name].transform, "story_v_out_417091", "417091028", "story_v_out_417091.awb")

						arg_118_1:RecordAudio("417091028", var_121_17)
						arg_118_1:RecordAudio("417091028", var_121_17)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417091", "417091028", "story_v_out_417091.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417091", "417091028", "story_v_out_417091.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_18 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_18 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_18

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_18 and arg_118_1.time_ < var_121_8 + var_121_18 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play417091029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417091029
		arg_122_1.duration_ = 6.63

		local var_122_0 = {
			zh = 6.1,
			ja = 6.633
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play417091030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1034"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps1034 == nil then
				arg_122_1.var_.actorSpriteComps1034 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps1034 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor2.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor2.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor2.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 0.5, var_125_3)

								iter_125_1.color = Color.New(var_125_7, var_125_7, var_125_7)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps1034 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_125_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps1034 = nil
			end

			local var_125_8 = 0
			local var_125_9 = 0.65

			if var_125_8 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_10 = arg_122_1:FormatText(StoryNameCfg[1110].name)

				arg_122_1.leftNameTxt_.text = var_125_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_11 = arg_122_1:GetWordFromCfg(417091029)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 26
				local var_125_14 = utf8.len(var_125_12)
				local var_125_15 = var_125_13 <= 0 and var_125_9 or var_125_9 * (var_125_14 / var_125_13)

				if var_125_15 > 0 and var_125_9 < var_125_15 then
					arg_122_1.talkMaxDuration = var_125_15

					if var_125_15 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_12
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091029", "story_v_out_417091.awb") ~= 0 then
					local var_125_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091029", "story_v_out_417091.awb") / 1000

					if var_125_16 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_16 + var_125_8
					end

					if var_125_11.prefab_name ~= "" and arg_122_1.actors_[var_125_11.prefab_name] ~= nil then
						local var_125_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_11.prefab_name].transform, "story_v_out_417091", "417091029", "story_v_out_417091.awb")

						arg_122_1:RecordAudio("417091029", var_125_17)
						arg_122_1:RecordAudio("417091029", var_125_17)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417091", "417091029", "story_v_out_417091.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417091", "417091029", "story_v_out_417091.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_18 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_18 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_18

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_18 and arg_122_1.time_ < var_125_8 + var_125_18 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417091030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417091030
		arg_126_1.duration_ = 11.67

		local var_126_0 = {
			zh = 8.7,
			ja = 11.666
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play417091031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1034"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps1034 == nil then
				arg_126_1.var_.actorSpriteComps1034 = var_129_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.actorSpriteComps1034 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								local var_129_4 = Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor1.r, var_129_3)
								local var_129_5 = Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor1.g, var_129_3)
								local var_129_6 = Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor1.b, var_129_3)

								iter_129_1.color = Color.New(var_129_4, var_129_5, var_129_6)
							else
								local var_129_7 = Mathf.Lerp(iter_129_1.color.r, 1, var_129_3)

								iter_129_1.color = Color.New(var_129_7, var_129_7, var_129_7)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps1034 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_129_3 then
						if arg_126_1.isInRecall_ then
							iter_129_3.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps1034 = nil
			end

			local var_129_8 = arg_126_1.actors_["1034"].transform
			local var_129_9 = 0

			if var_129_9 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 then
				arg_126_1.var_.moveOldPos1034 = var_129_8.localPosition
				var_129_8.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("1034", 3)

				local var_129_10 = var_129_8.childCount

				for iter_129_4 = 0, var_129_10 - 1 do
					local var_129_11 = var_129_8:GetChild(iter_129_4)

					if var_129_11.name == "split_4" or not string.find(var_129_11.name, "split") then
						var_129_11.gameObject:SetActive(true)
					else
						var_129_11.gameObject:SetActive(false)
					end
				end
			end

			local var_129_12 = 0.001

			if var_129_9 <= arg_126_1.time_ and arg_126_1.time_ < var_129_9 + var_129_12 then
				local var_129_13 = (arg_126_1.time_ - var_129_9) / var_129_12
				local var_129_14 = Vector3.New(0, -331.9, -324)

				var_129_8.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1034, var_129_14, var_129_13)
			end

			if arg_126_1.time_ >= var_129_9 + var_129_12 and arg_126_1.time_ < var_129_9 + var_129_12 + arg_129_0 then
				var_129_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_129_15 = 0
			local var_129_16 = 1

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_17 = arg_126_1:FormatText(StoryNameCfg[1109].name)

				arg_126_1.leftNameTxt_.text = var_129_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_18 = arg_126_1:GetWordFromCfg(417091030)
				local var_129_19 = arg_126_1:FormatText(var_129_18.content)

				arg_126_1.text_.text = var_129_19

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_20 = 40
				local var_129_21 = utf8.len(var_129_19)
				local var_129_22 = var_129_20 <= 0 and var_129_16 or var_129_16 * (var_129_21 / var_129_20)

				if var_129_22 > 0 and var_129_16 < var_129_22 then
					arg_126_1.talkMaxDuration = var_129_22

					if var_129_22 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_22 + var_129_15
					end
				end

				arg_126_1.text_.text = var_129_19
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091030", "story_v_out_417091.awb") ~= 0 then
					local var_129_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091030", "story_v_out_417091.awb") / 1000

					if var_129_23 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_15
					end

					if var_129_18.prefab_name ~= "" and arg_126_1.actors_[var_129_18.prefab_name] ~= nil then
						local var_129_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_18.prefab_name].transform, "story_v_out_417091", "417091030", "story_v_out_417091.awb")

						arg_126_1:RecordAudio("417091030", var_129_24)
						arg_126_1:RecordAudio("417091030", var_129_24)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_417091", "417091030", "story_v_out_417091.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_417091", "417091030", "story_v_out_417091.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_25 = math.max(var_129_16, arg_126_1.talkMaxDuration)

			if var_129_15 <= arg_126_1.time_ and arg_126_1.time_ < var_129_15 + var_129_25 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_15) / var_129_25

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_15 + var_129_25 and arg_126_1.time_ < var_129_15 + var_129_25 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play417091031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417091031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play417091032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1034"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps1034 == nil then
				arg_130_1.var_.actorSpriteComps1034 = var_133_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.actorSpriteComps1034 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								local var_133_4 = Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor2.r, var_133_3)
								local var_133_5 = Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor2.g, var_133_3)
								local var_133_6 = Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor2.b, var_133_3)

								iter_133_1.color = Color.New(var_133_4, var_133_5, var_133_6)
							else
								local var_133_7 = Mathf.Lerp(iter_133_1.color.r, 0.5, var_133_3)

								iter_133_1.color = Color.New(var_133_7, var_133_7, var_133_7)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps1034 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_133_3 then
						if arg_130_1.isInRecall_ then
							iter_133_3.color = arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_133_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps1034 = nil
			end

			local var_133_8 = 0
			local var_133_9 = 1.125

			if var_133_8 < arg_130_1.time_ and arg_130_1.time_ <= var_133_8 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_10 = arg_130_1:GetWordFromCfg(417091031)
				local var_133_11 = arg_130_1:FormatText(var_133_10.content)

				arg_130_1.text_.text = var_133_11

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_12 = 45
				local var_133_13 = utf8.len(var_133_11)
				local var_133_14 = var_133_12 <= 0 and var_133_9 or var_133_9 * (var_133_13 / var_133_12)

				if var_133_14 > 0 and var_133_9 < var_133_14 then
					arg_130_1.talkMaxDuration = var_133_14

					if var_133_14 + var_133_8 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_14 + var_133_8
					end
				end

				arg_130_1.text_.text = var_133_11
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_15 = math.max(var_133_9, arg_130_1.talkMaxDuration)

			if var_133_8 <= arg_130_1.time_ and arg_130_1.time_ < var_133_8 + var_133_15 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_8) / var_133_15

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_8 + var_133_15 and arg_130_1.time_ < var_133_8 + var_133_15 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play417091032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417091032
		arg_134_1.duration_ = 2.2

		local var_134_0 = {
			zh = 1.366,
			ja = 2.2
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play417091033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1034"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps1034 == nil then
				arg_134_1.var_.actorSpriteComps1034 = var_137_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.actorSpriteComps1034 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								local var_137_4 = Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor1.r, var_137_3)
								local var_137_5 = Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor1.g, var_137_3)
								local var_137_6 = Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor1.b, var_137_3)

								iter_137_1.color = Color.New(var_137_4, var_137_5, var_137_6)
							else
								local var_137_7 = Mathf.Lerp(iter_137_1.color.r, 1, var_137_3)

								iter_137_1.color = Color.New(var_137_7, var_137_7, var_137_7)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps1034 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_137_3 then
						if arg_134_1.isInRecall_ then
							iter_137_3.color = arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_137_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps1034 = nil
			end

			local var_137_8 = 0
			local var_137_9 = 0.125

			if var_137_8 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_10 = arg_134_1:FormatText(StoryNameCfg[1109].name)

				arg_134_1.leftNameTxt_.text = var_137_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_11 = arg_134_1:GetWordFromCfg(417091032)
				local var_137_12 = arg_134_1:FormatText(var_137_11.content)

				arg_134_1.text_.text = var_137_12

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_13 = 5
				local var_137_14 = utf8.len(var_137_12)
				local var_137_15 = var_137_13 <= 0 and var_137_9 or var_137_9 * (var_137_14 / var_137_13)

				if var_137_15 > 0 and var_137_9 < var_137_15 then
					arg_134_1.talkMaxDuration = var_137_15

					if var_137_15 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_15 + var_137_8
					end
				end

				arg_134_1.text_.text = var_137_12
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091032", "story_v_out_417091.awb") ~= 0 then
					local var_137_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091032", "story_v_out_417091.awb") / 1000

					if var_137_16 + var_137_8 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_16 + var_137_8
					end

					if var_137_11.prefab_name ~= "" and arg_134_1.actors_[var_137_11.prefab_name] ~= nil then
						local var_137_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_11.prefab_name].transform, "story_v_out_417091", "417091032", "story_v_out_417091.awb")

						arg_134_1:RecordAudio("417091032", var_137_17)
						arg_134_1:RecordAudio("417091032", var_137_17)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_417091", "417091032", "story_v_out_417091.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_417091", "417091032", "story_v_out_417091.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_18 = math.max(var_137_9, arg_134_1.talkMaxDuration)

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_18 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_8) / var_137_18

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_8 + var_137_18 and arg_134_1.time_ < var_137_8 + var_137_18 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417091033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417091033
		arg_138_1.duration_ = 8.8

		local var_138_0 = {
			zh = 5.9,
			ja = 8.8
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play417091034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1034"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps1034 == nil then
				arg_138_1.var_.actorSpriteComps1034 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps1034 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								local var_141_4 = Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor2.r, var_141_3)
								local var_141_5 = Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor2.g, var_141_3)
								local var_141_6 = Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor2.b, var_141_3)

								iter_141_1.color = Color.New(var_141_4, var_141_5, var_141_6)
							else
								local var_141_7 = Mathf.Lerp(iter_141_1.color.r, 0.5, var_141_3)

								iter_141_1.color = Color.New(var_141_7, var_141_7, var_141_7)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps1034 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps1034 = nil
			end

			local var_141_8 = 0
			local var_141_9 = 0.625

			if var_141_8 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_10 = arg_138_1:FormatText(StoryNameCfg[1110].name)

				arg_138_1.leftNameTxt_.text = var_141_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_11 = arg_138_1:GetWordFromCfg(417091033)
				local var_141_12 = arg_138_1:FormatText(var_141_11.content)

				arg_138_1.text_.text = var_141_12

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_13 = 25
				local var_141_14 = utf8.len(var_141_12)
				local var_141_15 = var_141_13 <= 0 and var_141_9 or var_141_9 * (var_141_14 / var_141_13)

				if var_141_15 > 0 and var_141_9 < var_141_15 then
					arg_138_1.talkMaxDuration = var_141_15

					if var_141_15 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_15 + var_141_8
					end
				end

				arg_138_1.text_.text = var_141_12
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091033", "story_v_out_417091.awb") ~= 0 then
					local var_141_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091033", "story_v_out_417091.awb") / 1000

					if var_141_16 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_16 + var_141_8
					end

					if var_141_11.prefab_name ~= "" and arg_138_1.actors_[var_141_11.prefab_name] ~= nil then
						local var_141_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_11.prefab_name].transform, "story_v_out_417091", "417091033", "story_v_out_417091.awb")

						arg_138_1:RecordAudio("417091033", var_141_17)
						arg_138_1:RecordAudio("417091033", var_141_17)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417091", "417091033", "story_v_out_417091.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417091", "417091033", "story_v_out_417091.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_18 = math.max(var_141_9, arg_138_1.talkMaxDuration)

			if var_141_8 <= arg_138_1.time_ and arg_138_1.time_ < var_141_8 + var_141_18 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_8) / var_141_18

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_8 + var_141_18 and arg_138_1.time_ < var_141_8 + var_141_18 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play417091034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417091034
		arg_142_1.duration_ = 1.57

		local var_142_0 = {
			zh = 1.233,
			ja = 1.566
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play417091035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1034"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps1034 == nil then
				arg_142_1.var_.actorSpriteComps1034 = var_145_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.actorSpriteComps1034 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								local var_145_4 = Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, var_145_3)
								local var_145_5 = Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, var_145_3)
								local var_145_6 = Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, var_145_3)

								iter_145_1.color = Color.New(var_145_4, var_145_5, var_145_6)
							else
								local var_145_7 = Mathf.Lerp(iter_145_1.color.r, 1, var_145_3)

								iter_145_1.color = Color.New(var_145_7, var_145_7, var_145_7)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps1034 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_145_3 then
						if arg_142_1.isInRecall_ then
							iter_145_3.color = arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_145_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps1034 = nil
			end

			local var_145_8 = arg_142_1.actors_["1034"].transform
			local var_145_9 = 0

			if var_145_9 < arg_142_1.time_ and arg_142_1.time_ <= var_145_9 + arg_145_0 then
				arg_142_1.var_.moveOldPos1034 = var_145_8.localPosition
				var_145_8.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("1034", 3)

				local var_145_10 = var_145_8.childCount

				for iter_145_4 = 0, var_145_10 - 1 do
					local var_145_11 = var_145_8:GetChild(iter_145_4)

					if var_145_11.name == "split_5" or not string.find(var_145_11.name, "split") then
						var_145_11.gameObject:SetActive(true)
					else
						var_145_11.gameObject:SetActive(false)
					end
				end
			end

			local var_145_12 = 0.001

			if var_145_9 <= arg_142_1.time_ and arg_142_1.time_ < var_145_9 + var_145_12 then
				local var_145_13 = (arg_142_1.time_ - var_145_9) / var_145_12
				local var_145_14 = Vector3.New(0, -331.9, -324)

				var_145_8.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1034, var_145_14, var_145_13)
			end

			if arg_142_1.time_ >= var_145_9 + var_145_12 and arg_142_1.time_ < var_145_9 + var_145_12 + arg_145_0 then
				var_145_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_145_15 = 0
			local var_145_16 = 0.05

			if var_145_15 < arg_142_1.time_ and arg_142_1.time_ <= var_145_15 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_17 = arg_142_1:FormatText(StoryNameCfg[1109].name)

				arg_142_1.leftNameTxt_.text = var_145_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_18 = arg_142_1:GetWordFromCfg(417091034)
				local var_145_19 = arg_142_1:FormatText(var_145_18.content)

				arg_142_1.text_.text = var_145_19

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_20 = 2
				local var_145_21 = utf8.len(var_145_19)
				local var_145_22 = var_145_20 <= 0 and var_145_16 or var_145_16 * (var_145_21 / var_145_20)

				if var_145_22 > 0 and var_145_16 < var_145_22 then
					arg_142_1.talkMaxDuration = var_145_22

					if var_145_22 + var_145_15 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_22 + var_145_15
					end
				end

				arg_142_1.text_.text = var_145_19
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091034", "story_v_out_417091.awb") ~= 0 then
					local var_145_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091034", "story_v_out_417091.awb") / 1000

					if var_145_23 + var_145_15 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_23 + var_145_15
					end

					if var_145_18.prefab_name ~= "" and arg_142_1.actors_[var_145_18.prefab_name] ~= nil then
						local var_145_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_18.prefab_name].transform, "story_v_out_417091", "417091034", "story_v_out_417091.awb")

						arg_142_1:RecordAudio("417091034", var_145_24)
						arg_142_1:RecordAudio("417091034", var_145_24)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417091", "417091034", "story_v_out_417091.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417091", "417091034", "story_v_out_417091.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_25 = math.max(var_145_16, arg_142_1.talkMaxDuration)

			if var_145_15 <= arg_142_1.time_ and arg_142_1.time_ < var_145_15 + var_145_25 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_15) / var_145_25

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_15 + var_145_25 and arg_142_1.time_ < var_145_15 + var_145_25 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play417091035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417091035
		arg_146_1.duration_ = 13.2

		local var_146_0 = {
			zh = 10.8,
			ja = 13.2
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play417091036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1034"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps1034 == nil then
				arg_146_1.var_.actorSpriteComps1034 = var_149_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.actorSpriteComps1034 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								local var_149_4 = Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, var_149_3)
								local var_149_5 = Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, var_149_3)
								local var_149_6 = Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, var_149_3)

								iter_149_1.color = Color.New(var_149_4, var_149_5, var_149_6)
							else
								local var_149_7 = Mathf.Lerp(iter_149_1.color.r, 0.5, var_149_3)

								iter_149_1.color = Color.New(var_149_7, var_149_7, var_149_7)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps1034 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_149_3 then
						if arg_146_1.isInRecall_ then
							iter_149_3.color = arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_149_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps1034 = nil
			end

			local var_149_8 = 0
			local var_149_9 = 1.45

			if var_149_8 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_10 = arg_146_1:FormatText(StoryNameCfg[1110].name)

				arg_146_1.leftNameTxt_.text = var_149_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_11 = arg_146_1:GetWordFromCfg(417091035)
				local var_149_12 = arg_146_1:FormatText(var_149_11.content)

				arg_146_1.text_.text = var_149_12

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_13 = 58
				local var_149_14 = utf8.len(var_149_12)
				local var_149_15 = var_149_13 <= 0 and var_149_9 or var_149_9 * (var_149_14 / var_149_13)

				if var_149_15 > 0 and var_149_9 < var_149_15 then
					arg_146_1.talkMaxDuration = var_149_15

					if var_149_15 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_15 + var_149_8
					end
				end

				arg_146_1.text_.text = var_149_12
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091035", "story_v_out_417091.awb") ~= 0 then
					local var_149_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091035", "story_v_out_417091.awb") / 1000

					if var_149_16 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_16 + var_149_8
					end

					if var_149_11.prefab_name ~= "" and arg_146_1.actors_[var_149_11.prefab_name] ~= nil then
						local var_149_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_11.prefab_name].transform, "story_v_out_417091", "417091035", "story_v_out_417091.awb")

						arg_146_1:RecordAudio("417091035", var_149_17)
						arg_146_1:RecordAudio("417091035", var_149_17)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417091", "417091035", "story_v_out_417091.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417091", "417091035", "story_v_out_417091.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_18 = math.max(var_149_9, arg_146_1.talkMaxDuration)

			if var_149_8 <= arg_146_1.time_ and arg_146_1.time_ < var_149_8 + var_149_18 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_8) / var_149_18

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_8 + var_149_18 and arg_146_1.time_ < var_149_8 + var_149_18 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play417091036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417091036
		arg_150_1.duration_ = 8.7

		local var_150_0 = {
			zh = 5.7,
			ja = 8.7
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417091037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.775

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[1110].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:GetWordFromCfg(417091036)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 31
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091036", "story_v_out_417091.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091036", "story_v_out_417091.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_417091", "417091036", "story_v_out_417091.awb")

						arg_150_1:RecordAudio("417091036", var_153_9)
						arg_150_1:RecordAudio("417091036", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417091", "417091036", "story_v_out_417091.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417091", "417091036", "story_v_out_417091.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play417091037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417091037
		arg_154_1.duration_ = 3.33

		local var_154_0 = {
			zh = 1.4,
			ja = 3.333
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play417091038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1034"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps1034 == nil then
				arg_154_1.var_.actorSpriteComps1034 = var_157_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.actorSpriteComps1034 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								local var_157_4 = Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor1.r, var_157_3)
								local var_157_5 = Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor1.g, var_157_3)
								local var_157_6 = Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor1.b, var_157_3)

								iter_157_1.color = Color.New(var_157_4, var_157_5, var_157_6)
							else
								local var_157_7 = Mathf.Lerp(iter_157_1.color.r, 1, var_157_3)

								iter_157_1.color = Color.New(var_157_7, var_157_7, var_157_7)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps1034 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_157_3 then
						if arg_154_1.isInRecall_ then
							iter_157_3.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_157_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps1034 = nil
			end

			local var_157_8 = arg_154_1.actors_["1034"].transform
			local var_157_9 = 0

			if var_157_9 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 then
				arg_154_1.var_.moveOldPos1034 = var_157_8.localPosition
				var_157_8.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1034", 3)

				local var_157_10 = var_157_8.childCount

				for iter_157_4 = 0, var_157_10 - 1 do
					local var_157_11 = var_157_8:GetChild(iter_157_4)

					if var_157_11.name == "split_4" or not string.find(var_157_11.name, "split") then
						var_157_11.gameObject:SetActive(true)
					else
						var_157_11.gameObject:SetActive(false)
					end
				end
			end

			local var_157_12 = 0.001

			if var_157_9 <= arg_154_1.time_ and arg_154_1.time_ < var_157_9 + var_157_12 then
				local var_157_13 = (arg_154_1.time_ - var_157_9) / var_157_12
				local var_157_14 = Vector3.New(0, -331.9, -324)

				var_157_8.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1034, var_157_14, var_157_13)
			end

			if arg_154_1.time_ >= var_157_9 + var_157_12 and arg_154_1.time_ < var_157_9 + var_157_12 + arg_157_0 then
				var_157_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_157_15 = 0
			local var_157_16 = 0.125

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_17 = arg_154_1:FormatText(StoryNameCfg[1109].name)

				arg_154_1.leftNameTxt_.text = var_157_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_18 = arg_154_1:GetWordFromCfg(417091037)
				local var_157_19 = arg_154_1:FormatText(var_157_18.content)

				arg_154_1.text_.text = var_157_19

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_20 = 5
				local var_157_21 = utf8.len(var_157_19)
				local var_157_22 = var_157_20 <= 0 and var_157_16 or var_157_16 * (var_157_21 / var_157_20)

				if var_157_22 > 0 and var_157_16 < var_157_22 then
					arg_154_1.talkMaxDuration = var_157_22

					if var_157_22 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_22 + var_157_15
					end
				end

				arg_154_1.text_.text = var_157_19
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091037", "story_v_out_417091.awb") ~= 0 then
					local var_157_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091037", "story_v_out_417091.awb") / 1000

					if var_157_23 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_23 + var_157_15
					end

					if var_157_18.prefab_name ~= "" and arg_154_1.actors_[var_157_18.prefab_name] ~= nil then
						local var_157_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_18.prefab_name].transform, "story_v_out_417091", "417091037", "story_v_out_417091.awb")

						arg_154_1:RecordAudio("417091037", var_157_24)
						arg_154_1:RecordAudio("417091037", var_157_24)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417091", "417091037", "story_v_out_417091.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417091", "417091037", "story_v_out_417091.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_25 = math.max(var_157_16, arg_154_1.talkMaxDuration)

			if var_157_15 <= arg_154_1.time_ and arg_154_1.time_ < var_157_15 + var_157_25 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_15) / var_157_25

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_15 + var_157_25 and arg_154_1.time_ < var_157_15 + var_157_25 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play417091038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417091038
		arg_158_1.duration_ = 6.9

		local var_158_0 = {
			zh = 5.666,
			ja = 6.9
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417091039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1034"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps1034 == nil then
				arg_158_1.var_.actorSpriteComps1034 = var_161_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_2 = 0.2

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.actorSpriteComps1034 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								local var_161_4 = Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor2.r, var_161_3)
								local var_161_5 = Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor2.g, var_161_3)
								local var_161_6 = Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor2.b, var_161_3)

								iter_161_1.color = Color.New(var_161_4, var_161_5, var_161_6)
							else
								local var_161_7 = Mathf.Lerp(iter_161_1.color.r, 0.5, var_161_3)

								iter_161_1.color = Color.New(var_161_7, var_161_7, var_161_7)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps1034 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_161_3 then
						if arg_158_1.isInRecall_ then
							iter_161_3.color = arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_161_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_158_1.var_.actorSpriteComps1034 = nil
			end

			local var_161_8 = 0
			local var_161_9 = 0.625

			if var_161_8 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_10 = arg_158_1:FormatText(StoryNameCfg[1110].name)

				arg_158_1.leftNameTxt_.text = var_161_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_11 = arg_158_1:GetWordFromCfg(417091038)
				local var_161_12 = arg_158_1:FormatText(var_161_11.content)

				arg_158_1.text_.text = var_161_12

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_13 = 25
				local var_161_14 = utf8.len(var_161_12)
				local var_161_15 = var_161_13 <= 0 and var_161_9 or var_161_9 * (var_161_14 / var_161_13)

				if var_161_15 > 0 and var_161_9 < var_161_15 then
					arg_158_1.talkMaxDuration = var_161_15

					if var_161_15 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_15 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_12
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091038", "story_v_out_417091.awb") ~= 0 then
					local var_161_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091038", "story_v_out_417091.awb") / 1000

					if var_161_16 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_16 + var_161_8
					end

					if var_161_11.prefab_name ~= "" and arg_158_1.actors_[var_161_11.prefab_name] ~= nil then
						local var_161_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_11.prefab_name].transform, "story_v_out_417091", "417091038", "story_v_out_417091.awb")

						arg_158_1:RecordAudio("417091038", var_161_17)
						arg_158_1:RecordAudio("417091038", var_161_17)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_417091", "417091038", "story_v_out_417091.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_417091", "417091038", "story_v_out_417091.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_18 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_18 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_18

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_18 and arg_158_1.time_ < var_161_8 + var_161_18 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417091039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417091039
		arg_162_1.duration_ = 16.4

		local var_162_0 = {
			zh = 11.666,
			ja = 16.4
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417091040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.55

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[1110].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_3 = arg_162_1:GetWordFromCfg(417091039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 62
				local var_165_6 = utf8.len(var_165_4)
				local var_165_7 = var_165_5 <= 0 and var_165_1 or var_165_1 * (var_165_6 / var_165_5)

				if var_165_7 > 0 and var_165_1 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091039", "story_v_out_417091.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091039", "story_v_out_417091.awb") / 1000

					if var_165_8 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_0
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_417091", "417091039", "story_v_out_417091.awb")

						arg_162_1:RecordAudio("417091039", var_165_9)
						arg_162_1:RecordAudio("417091039", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417091", "417091039", "story_v_out_417091.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417091", "417091039", "story_v_out_417091.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_10 and arg_162_1.time_ < var_165_0 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play417091040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417091040
		arg_166_1.duration_ = 11.7

		local var_166_0 = {
			zh = 11,
			ja = 11.7
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play417091041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 1.475

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[1110].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:GetWordFromCfg(417091040)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 59
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091040", "story_v_out_417091.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091040", "story_v_out_417091.awb") / 1000

					if var_169_8 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_0
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_out_417091", "417091040", "story_v_out_417091.awb")

						arg_166_1:RecordAudio("417091040", var_169_9)
						arg_166_1:RecordAudio("417091040", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_417091", "417091040", "story_v_out_417091.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_417091", "417091040", "story_v_out_417091.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_10 and arg_166_1.time_ < var_169_0 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play417091041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417091041
		arg_170_1.duration_ = 5

		local var_170_0 = {
			zh = 3.933,
			ja = 5
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play417091042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1034"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps1034 == nil then
				arg_170_1.var_.actorSpriteComps1034 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps1034 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								local var_173_4 = Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, var_173_3)
								local var_173_5 = Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, var_173_3)
								local var_173_6 = Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, var_173_3)

								iter_173_1.color = Color.New(var_173_4, var_173_5, var_173_6)
							else
								local var_173_7 = Mathf.Lerp(iter_173_1.color.r, 1, var_173_3)

								iter_173_1.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps1034 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps1034 = nil
			end

			local var_173_8 = arg_170_1.actors_["1034"].transform
			local var_173_9 = 0

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.var_.moveOldPos1034 = var_173_8.localPosition
				var_173_8.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("1034", 3)

				local var_173_10 = var_173_8.childCount

				for iter_173_4 = 0, var_173_10 - 1 do
					local var_173_11 = var_173_8:GetChild(iter_173_4)

					if var_173_11.name == "" or not string.find(var_173_11.name, "split") then
						var_173_11.gameObject:SetActive(true)
					else
						var_173_11.gameObject:SetActive(false)
					end
				end
			end

			local var_173_12 = 0.001

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_12 then
				local var_173_13 = (arg_170_1.time_ - var_173_9) / var_173_12
				local var_173_14 = Vector3.New(0, -331.9, -324)

				var_173_8.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1034, var_173_14, var_173_13)
			end

			if arg_170_1.time_ >= var_173_9 + var_173_12 and arg_170_1.time_ < var_173_9 + var_173_12 + arg_173_0 then
				var_173_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_173_15 = 0
			local var_173_16 = 0.4

			if var_173_15 < arg_170_1.time_ and arg_170_1.time_ <= var_173_15 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_17 = arg_170_1:FormatText(StoryNameCfg[1109].name)

				arg_170_1.leftNameTxt_.text = var_173_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_18 = arg_170_1:GetWordFromCfg(417091041)
				local var_173_19 = arg_170_1:FormatText(var_173_18.content)

				arg_170_1.text_.text = var_173_19

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_20 = 16
				local var_173_21 = utf8.len(var_173_19)
				local var_173_22 = var_173_20 <= 0 and var_173_16 or var_173_16 * (var_173_21 / var_173_20)

				if var_173_22 > 0 and var_173_16 < var_173_22 then
					arg_170_1.talkMaxDuration = var_173_22

					if var_173_22 + var_173_15 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_22 + var_173_15
					end
				end

				arg_170_1.text_.text = var_173_19
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091041", "story_v_out_417091.awb") ~= 0 then
					local var_173_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091041", "story_v_out_417091.awb") / 1000

					if var_173_23 + var_173_15 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_23 + var_173_15
					end

					if var_173_18.prefab_name ~= "" and arg_170_1.actors_[var_173_18.prefab_name] ~= nil then
						local var_173_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_18.prefab_name].transform, "story_v_out_417091", "417091041", "story_v_out_417091.awb")

						arg_170_1:RecordAudio("417091041", var_173_24)
						arg_170_1:RecordAudio("417091041", var_173_24)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417091", "417091041", "story_v_out_417091.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417091", "417091041", "story_v_out_417091.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_25 = math.max(var_173_16, arg_170_1.talkMaxDuration)

			if var_173_15 <= arg_170_1.time_ and arg_170_1.time_ < var_173_15 + var_173_25 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_15) / var_173_25

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_15 + var_173_25 and arg_170_1.time_ < var_173_15 + var_173_25 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play417091042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417091042
		arg_174_1.duration_ = 5.4

		local var_174_0 = {
			zh = 4.633,
			ja = 5.4
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417091043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1034"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps1034 == nil then
				arg_174_1.var_.actorSpriteComps1034 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps1034 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 0.5, var_177_3)

								iter_177_1.color = Color.New(var_177_7, var_177_7, var_177_7)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps1034 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps1034 = nil
			end

			local var_177_8 = 0
			local var_177_9 = 0.55

			if var_177_8 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_10 = arg_174_1:FormatText(StoryNameCfg[1110].name)

				arg_174_1.leftNameTxt_.text = var_177_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_11 = arg_174_1:GetWordFromCfg(417091042)
				local var_177_12 = arg_174_1:FormatText(var_177_11.content)

				arg_174_1.text_.text = var_177_12

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 22
				local var_177_14 = utf8.len(var_177_12)
				local var_177_15 = var_177_13 <= 0 and var_177_9 or var_177_9 * (var_177_14 / var_177_13)

				if var_177_15 > 0 and var_177_9 < var_177_15 then
					arg_174_1.talkMaxDuration = var_177_15

					if var_177_15 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_15 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_12
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091042", "story_v_out_417091.awb") ~= 0 then
					local var_177_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091042", "story_v_out_417091.awb") / 1000

					if var_177_16 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_16 + var_177_8
					end

					if var_177_11.prefab_name ~= "" and arg_174_1.actors_[var_177_11.prefab_name] ~= nil then
						local var_177_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_11.prefab_name].transform, "story_v_out_417091", "417091042", "story_v_out_417091.awb")

						arg_174_1:RecordAudio("417091042", var_177_17)
						arg_174_1:RecordAudio("417091042", var_177_17)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417091", "417091042", "story_v_out_417091.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417091", "417091042", "story_v_out_417091.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_18 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_18 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_18

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_18 and arg_174_1.time_ < var_177_8 + var_177_18 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play417091043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417091043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play417091044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1034"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1034 = var_181_0.localPosition
				var_181_0.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1034", 7)

				local var_181_2 = var_181_0.childCount

				for iter_181_0 = 0, var_181_2 - 1 do
					local var_181_3 = var_181_0:GetChild(iter_181_0)

					if var_181_3.name == "" or not string.find(var_181_3.name, "split") then
						var_181_3.gameObject:SetActive(true)
					else
						var_181_3.gameObject:SetActive(false)
					end
				end
			end

			local var_181_4 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_4 then
				local var_181_5 = (arg_178_1.time_ - var_181_1) / var_181_4
				local var_181_6 = Vector3.New(0, -2000, 0)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1034, var_181_6, var_181_5)
			end

			if arg_178_1.time_ >= var_181_1 + var_181_4 and arg_178_1.time_ < var_181_1 + var_181_4 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_7 = 0.05
			local var_181_8 = 1

			if var_181_7 < arg_178_1.time_ and arg_178_1.time_ <= var_181_7 + arg_181_0 then
				local var_181_9 = "play"
				local var_181_10 = "effect"

				arg_178_1:AudioAction(var_181_9, var_181_10, "se_story_side_1011", "se_story_side_1011_doorhandle", "")
			end

			local var_181_11 = 0
			local var_181_12 = 1.3

			if var_181_11 < arg_178_1.time_ and arg_178_1.time_ <= var_181_11 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_13 = arg_178_1:GetWordFromCfg(417091043)
				local var_181_14 = arg_178_1:FormatText(var_181_13.content)

				arg_178_1.text_.text = var_181_14

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_15 = 52
				local var_181_16 = utf8.len(var_181_14)
				local var_181_17 = var_181_15 <= 0 and var_181_12 or var_181_12 * (var_181_16 / var_181_15)

				if var_181_17 > 0 and var_181_12 < var_181_17 then
					arg_178_1.talkMaxDuration = var_181_17

					if var_181_17 + var_181_11 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_17 + var_181_11
					end
				end

				arg_178_1.text_.text = var_181_14
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_18 = math.max(var_181_12, arg_178_1.talkMaxDuration)

			if var_181_11 <= arg_178_1.time_ and arg_178_1.time_ < var_181_11 + var_181_18 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_11) / var_181_18

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_11 + var_181_18 and arg_178_1.time_ < var_181_11 + var_181_18 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play417091044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417091044
		arg_182_1.duration_ = 3.13

		local var_182_0 = {
			zh = 0.999999999999,
			ja = 3.133
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play417091045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = "10128"

			if arg_182_1.actors_[var_185_0] == nil then
				local var_185_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_185_1) then
					local var_185_2 = Object.Instantiate(var_185_1, arg_182_1.canvasGo_.transform)

					var_185_2.transform:SetSiblingIndex(1)

					var_185_2.name = var_185_0
					var_185_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_182_1.actors_[var_185_0] = var_185_2

					local var_185_3 = var_185_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_182_1.isInRecall_ then
						for iter_185_0, iter_185_1 in ipairs(var_185_3) do
							iter_185_1.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_185_4 = arg_182_1.actors_["10128"]
			local var_185_5 = 0

			if var_185_5 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.actorSpriteComps10128 == nil then
				arg_182_1.var_.actorSpriteComps10128 = var_185_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_6 = 0.2

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_6 and not isNil(var_185_4) then
				local var_185_7 = (arg_182_1.time_ - var_185_5) / var_185_6

				if arg_182_1.var_.actorSpriteComps10128 then
					for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_185_3 then
							if arg_182_1.isInRecall_ then
								local var_185_8 = Mathf.Lerp(iter_185_3.color.r, arg_182_1.hightColor1.r, var_185_7)
								local var_185_9 = Mathf.Lerp(iter_185_3.color.g, arg_182_1.hightColor1.g, var_185_7)
								local var_185_10 = Mathf.Lerp(iter_185_3.color.b, arg_182_1.hightColor1.b, var_185_7)

								iter_185_3.color = Color.New(var_185_8, var_185_9, var_185_10)
							else
								local var_185_11 = Mathf.Lerp(iter_185_3.color.r, 1, var_185_7)

								iter_185_3.color = Color.New(var_185_11, var_185_11, var_185_11)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_5 + var_185_6 and arg_182_1.time_ < var_185_5 + var_185_6 + arg_185_0 and not isNil(var_185_4) and arg_182_1.var_.actorSpriteComps10128 then
				for iter_185_4, iter_185_5 in pairs(arg_182_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_185_5 then
						if arg_182_1.isInRecall_ then
							iter_185_5.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_185_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps10128 = nil
			end

			local var_185_12 = 0
			local var_185_13 = 0.075

			if var_185_12 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_14 = arg_182_1:FormatText(StoryNameCfg[595].name)

				arg_182_1.leftNameTxt_.text = var_185_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_15 = arg_182_1:GetWordFromCfg(417091044)
				local var_185_16 = arg_182_1:FormatText(var_185_15.content)

				arg_182_1.text_.text = var_185_16

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_17 = 3
				local var_185_18 = utf8.len(var_185_16)
				local var_185_19 = var_185_17 <= 0 and var_185_13 or var_185_13 * (var_185_18 / var_185_17)

				if var_185_19 > 0 and var_185_13 < var_185_19 then
					arg_182_1.talkMaxDuration = var_185_19

					if var_185_19 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_16
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091044", "story_v_out_417091.awb") ~= 0 then
					local var_185_20 = manager.audio:GetVoiceLength("story_v_out_417091", "417091044", "story_v_out_417091.awb") / 1000

					if var_185_20 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_20 + var_185_12
					end

					if var_185_15.prefab_name ~= "" and arg_182_1.actors_[var_185_15.prefab_name] ~= nil then
						local var_185_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_15.prefab_name].transform, "story_v_out_417091", "417091044", "story_v_out_417091.awb")

						arg_182_1:RecordAudio("417091044", var_185_21)
						arg_182_1:RecordAudio("417091044", var_185_21)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417091", "417091044", "story_v_out_417091.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417091", "417091044", "story_v_out_417091.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_22 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_12) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_12 + var_185_22 and arg_182_1.time_ < var_185_12 + var_185_22 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play417091045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417091045
		arg_186_1.duration_ = 3.77

		local var_186_0 = {
			zh = 1.9,
			ja = 3.766
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play417091046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.275

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[1109].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_7")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(417091045)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 11
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091045", "story_v_out_417091.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091045", "story_v_out_417091.awb") / 1000

					if var_189_8 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_0
					end

					if var_189_3.prefab_name ~= "" and arg_186_1.actors_[var_189_3.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_3.prefab_name].transform, "story_v_out_417091", "417091045", "story_v_out_417091.awb")

						arg_186_1:RecordAudio("417091045", var_189_9)
						arg_186_1:RecordAudio("417091045", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417091", "417091045", "story_v_out_417091.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417091", "417091045", "story_v_out_417091.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_10 and arg_186_1.time_ < var_189_0 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play417091046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417091046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play417091047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1034"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps1034 == nil then
				arg_190_1.var_.actorSpriteComps1034 = var_193_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.actorSpriteComps1034 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								local var_193_4 = Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor2.r, var_193_3)
								local var_193_5 = Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor2.g, var_193_3)
								local var_193_6 = Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor2.b, var_193_3)

								iter_193_1.color = Color.New(var_193_4, var_193_5, var_193_6)
							else
								local var_193_7 = Mathf.Lerp(iter_193_1.color.r, 0.5, var_193_3)

								iter_193_1.color = Color.New(var_193_7, var_193_7, var_193_7)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps1034 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_193_3 then
						if arg_190_1.isInRecall_ then
							iter_193_3.color = arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_193_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps1034 = nil
			end

			local var_193_8 = 0.01
			local var_193_9 = 1

			if var_193_8 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 then
				local var_193_10 = "play"
				local var_193_11 = "effect"

				arg_190_1:AudioAction(var_193_10, var_193_11, "se_story_side_1028", "se_story_side_1028_door", "")
			end

			local var_193_12 = 0
			local var_193_13 = 1.025

			if var_193_12 < arg_190_1.time_ and arg_190_1.time_ <= var_193_12 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_14 = arg_190_1:GetWordFromCfg(417091046)
				local var_193_15 = arg_190_1:FormatText(var_193_14.content)

				arg_190_1.text_.text = var_193_15

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_16 = 46
				local var_193_17 = utf8.len(var_193_15)
				local var_193_18 = var_193_16 <= 0 and var_193_13 or var_193_13 * (var_193_17 / var_193_16)

				if var_193_18 > 0 and var_193_13 < var_193_18 then
					arg_190_1.talkMaxDuration = var_193_18

					if var_193_18 + var_193_12 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_18 + var_193_12
					end
				end

				arg_190_1.text_.text = var_193_15
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_19 = math.max(var_193_13, arg_190_1.talkMaxDuration)

			if var_193_12 <= arg_190_1.time_ and arg_190_1.time_ < var_193_12 + var_193_19 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_12) / var_193_19

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_12 + var_193_19 and arg_190_1.time_ < var_193_12 + var_193_19 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417091047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417091047
		arg_194_1.duration_ = 8.2

		local var_194_0 = {
			zh = 7.466,
			ja = 8.2
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play417091048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1034"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps1034 == nil then
				arg_194_1.var_.actorSpriteComps1034 = var_197_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_2 = 0.2

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.actorSpriteComps1034 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								local var_197_4 = Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, var_197_3)
								local var_197_5 = Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, var_197_3)
								local var_197_6 = Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, var_197_3)

								iter_197_1.color = Color.New(var_197_4, var_197_5, var_197_6)
							else
								local var_197_7 = Mathf.Lerp(iter_197_1.color.r, 1, var_197_3)

								iter_197_1.color = Color.New(var_197_7, var_197_7, var_197_7)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.actorSpriteComps1034 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_197_3 then
						if arg_194_1.isInRecall_ then
							iter_197_3.color = arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_197_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_194_1.var_.actorSpriteComps1034 = nil
			end

			local var_197_8 = arg_194_1.actors_["1034"].transform
			local var_197_9 = 0

			if var_197_9 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 then
				arg_194_1.var_.moveOldPos1034 = var_197_8.localPosition
				var_197_8.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1034", 2)

				local var_197_10 = var_197_8.childCount

				for iter_197_4 = 0, var_197_10 - 1 do
					local var_197_11 = var_197_8:GetChild(iter_197_4)

					if var_197_11.name == "" or not string.find(var_197_11.name, "split") then
						var_197_11.gameObject:SetActive(true)
					else
						var_197_11.gameObject:SetActive(false)
					end
				end
			end

			local var_197_12 = 0.001

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_12 then
				local var_197_13 = (arg_194_1.time_ - var_197_9) / var_197_12
				local var_197_14 = Vector3.New(-390, -331.9, -324)

				var_197_8.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1034, var_197_14, var_197_13)
			end

			if arg_194_1.time_ >= var_197_9 + var_197_12 and arg_194_1.time_ < var_197_9 + var_197_12 + arg_197_0 then
				var_197_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_197_15 = 0
			local var_197_16 = 0.875

			if var_197_15 < arg_194_1.time_ and arg_194_1.time_ <= var_197_15 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_17 = arg_194_1:FormatText(StoryNameCfg[1109].name)

				arg_194_1.leftNameTxt_.text = var_197_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_18 = arg_194_1:GetWordFromCfg(417091047)
				local var_197_19 = arg_194_1:FormatText(var_197_18.content)

				arg_194_1.text_.text = var_197_19

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_20 = 35
				local var_197_21 = utf8.len(var_197_19)
				local var_197_22 = var_197_20 <= 0 and var_197_16 or var_197_16 * (var_197_21 / var_197_20)

				if var_197_22 > 0 and var_197_16 < var_197_22 then
					arg_194_1.talkMaxDuration = var_197_22

					if var_197_22 + var_197_15 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_22 + var_197_15
					end
				end

				arg_194_1.text_.text = var_197_19
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091047", "story_v_out_417091.awb") ~= 0 then
					local var_197_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091047", "story_v_out_417091.awb") / 1000

					if var_197_23 + var_197_15 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_23 + var_197_15
					end

					if var_197_18.prefab_name ~= "" and arg_194_1.actors_[var_197_18.prefab_name] ~= nil then
						local var_197_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_18.prefab_name].transform, "story_v_out_417091", "417091047", "story_v_out_417091.awb")

						arg_194_1:RecordAudio("417091047", var_197_24)
						arg_194_1:RecordAudio("417091047", var_197_24)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417091", "417091047", "story_v_out_417091.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417091", "417091047", "story_v_out_417091.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_25 = math.max(var_197_16, arg_194_1.talkMaxDuration)

			if var_197_15 <= arg_194_1.time_ and arg_194_1.time_ < var_197_15 + var_197_25 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_15) / var_197_25

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_15 + var_197_25 and arg_194_1.time_ < var_197_15 + var_197_25 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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

		arg_194_1:InitPlayNodeList()
	end,
	Play417091048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417091048
		arg_198_1.duration_ = 5.6

		local var_198_0 = {
			zh = 5.233,
			ja = 5.6
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417091049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10128"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps10128 == nil then
				arg_198_1.var_.actorSpriteComps10128 = var_201_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.actorSpriteComps10128 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								local var_201_4 = Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, var_201_3)
								local var_201_5 = Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, var_201_3)
								local var_201_6 = Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, var_201_3)

								iter_201_1.color = Color.New(var_201_4, var_201_5, var_201_6)
							else
								local var_201_7 = Mathf.Lerp(iter_201_1.color.r, 1, var_201_3)

								iter_201_1.color = Color.New(var_201_7, var_201_7, var_201_7)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.actorSpriteComps10128 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_201_3 then
						if arg_198_1.isInRecall_ then
							iter_201_3.color = arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_201_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps10128 = nil
			end

			local var_201_8 = arg_198_1.actors_["1034"]
			local var_201_9 = 0

			if var_201_9 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.actorSpriteComps1034 == nil then
				arg_198_1.var_.actorSpriteComps1034 = var_201_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_10 = 0.2

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_10 and not isNil(var_201_8) then
				local var_201_11 = (arg_198_1.time_ - var_201_9) / var_201_10

				if arg_198_1.var_.actorSpriteComps1034 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								local var_201_12 = Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, var_201_11)
								local var_201_13 = Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, var_201_11)
								local var_201_14 = Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, var_201_11)

								iter_201_5.color = Color.New(var_201_12, var_201_13, var_201_14)
							else
								local var_201_15 = Mathf.Lerp(iter_201_5.color.r, 0.5, var_201_11)

								iter_201_5.color = Color.New(var_201_15, var_201_15, var_201_15)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= var_201_9 + var_201_10 and arg_198_1.time_ < var_201_9 + var_201_10 + arg_201_0 and not isNil(var_201_8) and arg_198_1.var_.actorSpriteComps1034 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_201_7 then
						if arg_198_1.isInRecall_ then
							iter_201_7.color = arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_201_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_198_1.var_.actorSpriteComps1034 = nil
			end

			local var_201_16 = arg_198_1.actors_["10128"].transform
			local var_201_17 = 0

			if var_201_17 < arg_198_1.time_ and arg_198_1.time_ <= var_201_17 + arg_201_0 then
				arg_198_1.var_.moveOldPos10128 = var_201_16.localPosition
				var_201_16.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("10128", 4)

				local var_201_18 = var_201_16.childCount

				for iter_201_8 = 0, var_201_18 - 1 do
					local var_201_19 = var_201_16:GetChild(iter_201_8)

					if var_201_19.name == "" or not string.find(var_201_19.name, "split") then
						var_201_19.gameObject:SetActive(true)
					else
						var_201_19.gameObject:SetActive(false)
					end
				end
			end

			local var_201_20 = 0.001

			if var_201_17 <= arg_198_1.time_ and arg_198_1.time_ < var_201_17 + var_201_20 then
				local var_201_21 = (arg_198_1.time_ - var_201_17) / var_201_20
				local var_201_22 = Vector3.New(390, -347, -300)

				var_201_16.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10128, var_201_22, var_201_21)
			end

			if arg_198_1.time_ >= var_201_17 + var_201_20 and arg_198_1.time_ < var_201_17 + var_201_20 + arg_201_0 then
				var_201_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_201_23 = 0
			local var_201_24 = 0.575

			if var_201_23 < arg_198_1.time_ and arg_198_1.time_ <= var_201_23 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_25 = arg_198_1:FormatText(StoryNameCfg[595].name)

				arg_198_1.leftNameTxt_.text = var_201_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_26 = arg_198_1:GetWordFromCfg(417091048)
				local var_201_27 = arg_198_1:FormatText(var_201_26.content)

				arg_198_1.text_.text = var_201_27

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_28 = 23
				local var_201_29 = utf8.len(var_201_27)
				local var_201_30 = var_201_28 <= 0 and var_201_24 or var_201_24 * (var_201_29 / var_201_28)

				if var_201_30 > 0 and var_201_24 < var_201_30 then
					arg_198_1.talkMaxDuration = var_201_30

					if var_201_30 + var_201_23 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_30 + var_201_23
					end
				end

				arg_198_1.text_.text = var_201_27
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091048", "story_v_out_417091.awb") ~= 0 then
					local var_201_31 = manager.audio:GetVoiceLength("story_v_out_417091", "417091048", "story_v_out_417091.awb") / 1000

					if var_201_31 + var_201_23 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_31 + var_201_23
					end

					if var_201_26.prefab_name ~= "" and arg_198_1.actors_[var_201_26.prefab_name] ~= nil then
						local var_201_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_26.prefab_name].transform, "story_v_out_417091", "417091048", "story_v_out_417091.awb")

						arg_198_1:RecordAudio("417091048", var_201_32)
						arg_198_1:RecordAudio("417091048", var_201_32)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417091", "417091048", "story_v_out_417091.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417091", "417091048", "story_v_out_417091.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_33 = math.max(var_201_24, arg_198_1.talkMaxDuration)

			if var_201_23 <= arg_198_1.time_ and arg_198_1.time_ < var_201_23 + var_201_33 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_23) / var_201_33

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_23 + var_201_33 and arg_198_1.time_ < var_201_23 + var_201_33 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play417091049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417091049
		arg_202_1.duration_ = 2.8

		local var_202_0 = {
			zh = 2.766,
			ja = 2.8
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play417091050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1034"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps1034 == nil then
				arg_202_1.var_.actorSpriteComps1034 = var_205_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.actorSpriteComps1034 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								local var_205_4 = Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, var_205_3)
								local var_205_5 = Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, var_205_3)
								local var_205_6 = Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, var_205_3)

								iter_205_1.color = Color.New(var_205_4, var_205_5, var_205_6)
							else
								local var_205_7 = Mathf.Lerp(iter_205_1.color.r, 1, var_205_3)

								iter_205_1.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps1034 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_205_3 then
						if arg_202_1.isInRecall_ then
							iter_205_3.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_205_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps1034 = nil
			end

			local var_205_8 = arg_202_1.actors_["10128"]
			local var_205_9 = 0

			if var_205_9 < arg_202_1.time_ and arg_202_1.time_ <= var_205_9 + arg_205_0 and not isNil(var_205_8) and arg_202_1.var_.actorSpriteComps10128 == nil then
				arg_202_1.var_.actorSpriteComps10128 = var_205_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_10 = 0.2

			if var_205_9 <= arg_202_1.time_ and arg_202_1.time_ < var_205_9 + var_205_10 and not isNil(var_205_8) then
				local var_205_11 = (arg_202_1.time_ - var_205_9) / var_205_10

				if arg_202_1.var_.actorSpriteComps10128 then
					for iter_205_4, iter_205_5 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_205_5 then
							if arg_202_1.isInRecall_ then
								local var_205_12 = Mathf.Lerp(iter_205_5.color.r, arg_202_1.hightColor2.r, var_205_11)
								local var_205_13 = Mathf.Lerp(iter_205_5.color.g, arg_202_1.hightColor2.g, var_205_11)
								local var_205_14 = Mathf.Lerp(iter_205_5.color.b, arg_202_1.hightColor2.b, var_205_11)

								iter_205_5.color = Color.New(var_205_12, var_205_13, var_205_14)
							else
								local var_205_15 = Mathf.Lerp(iter_205_5.color.r, 0.5, var_205_11)

								iter_205_5.color = Color.New(var_205_15, var_205_15, var_205_15)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_9 + var_205_10 and arg_202_1.time_ < var_205_9 + var_205_10 + arg_205_0 and not isNil(var_205_8) and arg_202_1.var_.actorSpriteComps10128 then
				for iter_205_6, iter_205_7 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_205_7 then
						if arg_202_1.isInRecall_ then
							iter_205_7.color = arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_205_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps10128 = nil
			end

			local var_205_16 = 0
			local var_205_17 = 0.275

			if var_205_16 < arg_202_1.time_ and arg_202_1.time_ <= var_205_16 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_18 = arg_202_1:FormatText(StoryNameCfg[1109].name)

				arg_202_1.leftNameTxt_.text = var_205_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_19 = arg_202_1:GetWordFromCfg(417091049)
				local var_205_20 = arg_202_1:FormatText(var_205_19.content)

				arg_202_1.text_.text = var_205_20

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_21 = 11
				local var_205_22 = utf8.len(var_205_20)
				local var_205_23 = var_205_21 <= 0 and var_205_17 or var_205_17 * (var_205_22 / var_205_21)

				if var_205_23 > 0 and var_205_17 < var_205_23 then
					arg_202_1.talkMaxDuration = var_205_23

					if var_205_23 + var_205_16 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_23 + var_205_16
					end
				end

				arg_202_1.text_.text = var_205_20
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091049", "story_v_out_417091.awb") ~= 0 then
					local var_205_24 = manager.audio:GetVoiceLength("story_v_out_417091", "417091049", "story_v_out_417091.awb") / 1000

					if var_205_24 + var_205_16 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_24 + var_205_16
					end

					if var_205_19.prefab_name ~= "" and arg_202_1.actors_[var_205_19.prefab_name] ~= nil then
						local var_205_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_19.prefab_name].transform, "story_v_out_417091", "417091049", "story_v_out_417091.awb")

						arg_202_1:RecordAudio("417091049", var_205_25)
						arg_202_1:RecordAudio("417091049", var_205_25)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417091", "417091049", "story_v_out_417091.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417091", "417091049", "story_v_out_417091.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_26 = math.max(var_205_17, arg_202_1.talkMaxDuration)

			if var_205_16 <= arg_202_1.time_ and arg_202_1.time_ < var_205_16 + var_205_26 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_16) / var_205_26

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_16 + var_205_26 and arg_202_1.time_ < var_205_16 + var_205_26 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417091050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417091050
		arg_206_1.duration_ = 8.13

		local var_206_0 = {
			zh = 4.433,
			ja = 8.133
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play417091051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10128"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps10128 == nil then
				arg_206_1.var_.actorSpriteComps10128 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps10128 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 1, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps10128 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_209_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps10128 = nil
			end

			local var_209_8 = arg_206_1.actors_["1034"]
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps1034 == nil then
				arg_206_1.var_.actorSpriteComps1034 = var_209_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_10 = 0.2

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_10 and not isNil(var_209_8) then
				local var_209_11 = (arg_206_1.time_ - var_209_9) / var_209_10

				if arg_206_1.var_.actorSpriteComps1034 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								local var_209_12 = Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, var_209_11)
								local var_209_13 = Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, var_209_11)
								local var_209_14 = Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, var_209_11)

								iter_209_5.color = Color.New(var_209_12, var_209_13, var_209_14)
							else
								local var_209_15 = Mathf.Lerp(iter_209_5.color.r, 0.5, var_209_11)

								iter_209_5.color = Color.New(var_209_15, var_209_15, var_209_15)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_9 + var_209_10 and arg_206_1.time_ < var_209_9 + var_209_10 + arg_209_0 and not isNil(var_209_8) and arg_206_1.var_.actorSpriteComps1034 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_209_7 then
						if arg_206_1.isInRecall_ then
							iter_209_7.color = arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_209_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps1034 = nil
			end

			local var_209_16 = arg_206_1.actors_["10128"].transform
			local var_209_17 = 0

			if var_209_17 < arg_206_1.time_ and arg_206_1.time_ <= var_209_17 + arg_209_0 then
				arg_206_1.var_.moveOldPos10128 = var_209_16.localPosition
				var_209_16.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("10128", 4)

				local var_209_18 = var_209_16.childCount

				for iter_209_8 = 0, var_209_18 - 1 do
					local var_209_19 = var_209_16:GetChild(iter_209_8)

					if var_209_19.name == "split_6" or not string.find(var_209_19.name, "split") then
						var_209_19.gameObject:SetActive(true)
					else
						var_209_19.gameObject:SetActive(false)
					end
				end
			end

			local var_209_20 = 0.001

			if var_209_17 <= arg_206_1.time_ and arg_206_1.time_ < var_209_17 + var_209_20 then
				local var_209_21 = (arg_206_1.time_ - var_209_17) / var_209_20
				local var_209_22 = Vector3.New(390, -347, -300)

				var_209_16.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10128, var_209_22, var_209_21)
			end

			if arg_206_1.time_ >= var_209_17 + var_209_20 and arg_206_1.time_ < var_209_17 + var_209_20 + arg_209_0 then
				var_209_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_209_23 = 0
			local var_209_24 = 0.55

			if var_209_23 < arg_206_1.time_ and arg_206_1.time_ <= var_209_23 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_25 = arg_206_1:FormatText(StoryNameCfg[595].name)

				arg_206_1.leftNameTxt_.text = var_209_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_26 = arg_206_1:GetWordFromCfg(417091050)
				local var_209_27 = arg_206_1:FormatText(var_209_26.content)

				arg_206_1.text_.text = var_209_27

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_28 = 22
				local var_209_29 = utf8.len(var_209_27)
				local var_209_30 = var_209_28 <= 0 and var_209_24 or var_209_24 * (var_209_29 / var_209_28)

				if var_209_30 > 0 and var_209_24 < var_209_30 then
					arg_206_1.talkMaxDuration = var_209_30

					if var_209_30 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_30 + var_209_23
					end
				end

				arg_206_1.text_.text = var_209_27
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091050", "story_v_out_417091.awb") ~= 0 then
					local var_209_31 = manager.audio:GetVoiceLength("story_v_out_417091", "417091050", "story_v_out_417091.awb") / 1000

					if var_209_31 + var_209_23 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_31 + var_209_23
					end

					if var_209_26.prefab_name ~= "" and arg_206_1.actors_[var_209_26.prefab_name] ~= nil then
						local var_209_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_26.prefab_name].transform, "story_v_out_417091", "417091050", "story_v_out_417091.awb")

						arg_206_1:RecordAudio("417091050", var_209_32)
						arg_206_1:RecordAudio("417091050", var_209_32)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417091", "417091050", "story_v_out_417091.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417091", "417091050", "story_v_out_417091.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_33 = math.max(var_209_24, arg_206_1.talkMaxDuration)

			if var_209_23 <= arg_206_1.time_ and arg_206_1.time_ < var_209_23 + var_209_33 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_23) / var_209_33

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_23 + var_209_33 and arg_206_1.time_ < var_209_23 + var_209_33 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
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

		arg_206_1:InitPlayNodeList()
	end,
	Play417091051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417091051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417091052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10128"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10128 == nil then
				arg_210_1.var_.actorSpriteComps10128 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps10128 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 0.5, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10128 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_213_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps10128 = nil
			end

			local var_213_8 = 0
			local var_213_9 = 1

			if var_213_8 < arg_210_1.time_ and arg_210_1.time_ <= var_213_8 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_10 = arg_210_1:GetWordFromCfg(417091051)
				local var_213_11 = arg_210_1:FormatText(var_213_10.content)

				arg_210_1.text_.text = var_213_11

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_12 = 40
				local var_213_13 = utf8.len(var_213_11)
				local var_213_14 = var_213_12 <= 0 and var_213_9 or var_213_9 * (var_213_13 / var_213_12)

				if var_213_14 > 0 and var_213_9 < var_213_14 then
					arg_210_1.talkMaxDuration = var_213_14

					if var_213_14 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_14 + var_213_8
					end
				end

				arg_210_1.text_.text = var_213_11
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_15 = math.max(var_213_9, arg_210_1.talkMaxDuration)

			if var_213_8 <= arg_210_1.time_ and arg_210_1.time_ < var_213_8 + var_213_15 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_8) / var_213_15

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_8 + var_213_15 and arg_210_1.time_ < var_213_8 + var_213_15 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play417091052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417091052
		arg_214_1.duration_ = 6.3

		local var_214_0 = {
			zh = 4.366,
			ja = 6.3
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
				arg_214_0:Play417091053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10128"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps10128 == nil then
				arg_214_1.var_.actorSpriteComps10128 = var_217_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_2 = 0.2

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.actorSpriteComps10128 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								local var_217_4 = Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, var_217_3)
								local var_217_5 = Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, var_217_3)
								local var_217_6 = Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, var_217_3)

								iter_217_1.color = Color.New(var_217_4, var_217_5, var_217_6)
							else
								local var_217_7 = Mathf.Lerp(iter_217_1.color.r, 1, var_217_3)

								iter_217_1.color = Color.New(var_217_7, var_217_7, var_217_7)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps10128 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_217_3 then
						if arg_214_1.isInRecall_ then
							iter_217_3.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_217_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps10128 = nil
			end

			local var_217_8 = 0
			local var_217_9 = 0.6

			if var_217_8 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_10 = arg_214_1:FormatText(StoryNameCfg[595].name)

				arg_214_1.leftNameTxt_.text = var_217_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_11 = arg_214_1:GetWordFromCfg(417091052)
				local var_217_12 = arg_214_1:FormatText(var_217_11.content)

				arg_214_1.text_.text = var_217_12

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_13 = 24
				local var_217_14 = utf8.len(var_217_12)
				local var_217_15 = var_217_13 <= 0 and var_217_9 or var_217_9 * (var_217_14 / var_217_13)

				if var_217_15 > 0 and var_217_9 < var_217_15 then
					arg_214_1.talkMaxDuration = var_217_15

					if var_217_15 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_15 + var_217_8
					end
				end

				arg_214_1.text_.text = var_217_12
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091052", "story_v_out_417091.awb") ~= 0 then
					local var_217_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091052", "story_v_out_417091.awb") / 1000

					if var_217_16 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_16 + var_217_8
					end

					if var_217_11.prefab_name ~= "" and arg_214_1.actors_[var_217_11.prefab_name] ~= nil then
						local var_217_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_11.prefab_name].transform, "story_v_out_417091", "417091052", "story_v_out_417091.awb")

						arg_214_1:RecordAudio("417091052", var_217_17)
						arg_214_1:RecordAudio("417091052", var_217_17)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417091", "417091052", "story_v_out_417091.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417091", "417091052", "story_v_out_417091.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_18 = math.max(var_217_9, arg_214_1.talkMaxDuration)

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_18 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_8) / var_217_18

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_8 + var_217_18 and arg_214_1.time_ < var_217_8 + var_217_18 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417091053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417091053
		arg_218_1.duration_ = 15.2

		local var_218_0 = {
			zh = 9.033,
			ja = 15.2
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
				arg_218_0:Play417091054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 1.225

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[595].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_3 = arg_218_1:GetWordFromCfg(417091053)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091053", "story_v_out_417091.awb") ~= 0 then
					local var_221_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091053", "story_v_out_417091.awb") / 1000

					if var_221_8 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_0
					end

					if var_221_3.prefab_name ~= "" and arg_218_1.actors_[var_221_3.prefab_name] ~= nil then
						local var_221_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_3.prefab_name].transform, "story_v_out_417091", "417091053", "story_v_out_417091.awb")

						arg_218_1:RecordAudio("417091053", var_221_9)
						arg_218_1:RecordAudio("417091053", var_221_9)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417091", "417091053", "story_v_out_417091.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417091", "417091053", "story_v_out_417091.awb")
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
	Play417091054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417091054
		arg_222_1.duration_ = 6.67

		local var_222_0 = {
			zh = 4.8,
			ja = 6.666
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
				arg_222_0:Play417091055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10128"].transform
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.var_.moveOldPos10128 = var_225_0.localPosition
				var_225_0.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10128", 4)

				local var_225_2 = var_225_0.childCount

				for iter_225_0 = 0, var_225_2 - 1 do
					local var_225_3 = var_225_0:GetChild(iter_225_0)

					if var_225_3.name == "" or not string.find(var_225_3.name, "split") then
						var_225_3.gameObject:SetActive(true)
					else
						var_225_3.gameObject:SetActive(false)
					end
				end
			end

			local var_225_4 = 0.001

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_4 then
				local var_225_5 = (arg_222_1.time_ - var_225_1) / var_225_4
				local var_225_6 = Vector3.New(390, -347, -300)

				var_225_0.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10128, var_225_6, var_225_5)
			end

			if arg_222_1.time_ >= var_225_1 + var_225_4 and arg_222_1.time_ < var_225_1 + var_225_4 + arg_225_0 then
				var_225_0.localPosition = Vector3.New(390, -347, -300)
			end

			local var_225_7 = 0
			local var_225_8 = 0.6

			if var_225_7 < arg_222_1.time_ and arg_222_1.time_ <= var_225_7 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_9 = arg_222_1:FormatText(StoryNameCfg[595].name)

				arg_222_1.leftNameTxt_.text = var_225_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_10 = arg_222_1:GetWordFromCfg(417091054)
				local var_225_11 = arg_222_1:FormatText(var_225_10.content)

				arg_222_1.text_.text = var_225_11

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_12 = 24
				local var_225_13 = utf8.len(var_225_11)
				local var_225_14 = var_225_12 <= 0 and var_225_8 or var_225_8 * (var_225_13 / var_225_12)

				if var_225_14 > 0 and var_225_8 < var_225_14 then
					arg_222_1.talkMaxDuration = var_225_14

					if var_225_14 + var_225_7 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_7
					end
				end

				arg_222_1.text_.text = var_225_11
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091054", "story_v_out_417091.awb") ~= 0 then
					local var_225_15 = manager.audio:GetVoiceLength("story_v_out_417091", "417091054", "story_v_out_417091.awb") / 1000

					if var_225_15 + var_225_7 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_15 + var_225_7
					end

					if var_225_10.prefab_name ~= "" and arg_222_1.actors_[var_225_10.prefab_name] ~= nil then
						local var_225_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_10.prefab_name].transform, "story_v_out_417091", "417091054", "story_v_out_417091.awb")

						arg_222_1:RecordAudio("417091054", var_225_16)
						arg_222_1:RecordAudio("417091054", var_225_16)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417091", "417091054", "story_v_out_417091.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417091", "417091054", "story_v_out_417091.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_17 = math.max(var_225_8, arg_222_1.talkMaxDuration)

			if var_225_7 <= arg_222_1.time_ and arg_222_1.time_ < var_225_7 + var_225_17 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_7) / var_225_17

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_7 + var_225_17 and arg_222_1.time_ < var_225_7 + var_225_17 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play417091055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417091055
		arg_226_1.duration_ = 8.23

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417091056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = "ST69"

			if arg_226_1.bgs_[var_229_0] == nil then
				local var_229_1 = Object.Instantiate(arg_226_1.paintGo_)

				var_229_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_229_0)
				var_229_1.name = var_229_0
				var_229_1.transform.parent = arg_226_1.stage_.transform
				var_229_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.bgs_[var_229_0] = var_229_1
			end

			local var_229_2 = 1.6

			if var_229_2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				local var_229_3 = manager.ui.mainCamera.transform.localPosition
				local var_229_4 = Vector3.New(0, 0, 10) + Vector3.New(var_229_3.x, var_229_3.y, 0)
				local var_229_5 = arg_226_1.bgs_.ST69

				var_229_5.transform.localPosition = var_229_4
				var_229_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_229_6 = var_229_5:GetComponent("SpriteRenderer")

				if var_229_6 and var_229_6.sprite then
					local var_229_7 = (var_229_5.transform.localPosition - var_229_3).z
					local var_229_8 = manager.ui.mainCameraCom_
					local var_229_9 = 2 * var_229_7 * Mathf.Tan(var_229_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_229_10 = var_229_9 * var_229_8.aspect
					local var_229_11 = var_229_6.sprite.bounds.size.x
					local var_229_12 = var_229_6.sprite.bounds.size.y
					local var_229_13 = var_229_10 / var_229_11
					local var_229_14 = var_229_9 / var_229_12
					local var_229_15 = var_229_14 < var_229_13 and var_229_13 or var_229_14

					var_229_5.transform.localScale = Vector3.New(var_229_15, var_229_15, 0)
				end

				for iter_229_0, iter_229_1 in pairs(arg_226_1.bgs_) do
					if iter_229_0 ~= "ST69" then
						iter_229_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_229_16 = 1.6

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1.allBtn_.enabled = false
			end

			local var_229_17 = 0.3

			if arg_226_1.time_ >= var_229_16 + var_229_17 and arg_226_1.time_ < var_229_16 + var_229_17 + arg_229_0 then
				arg_226_1.allBtn_.enabled = true
			end

			local var_229_18 = 0

			if var_229_18 < arg_226_1.time_ and arg_226_1.time_ <= var_229_18 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_19 = 1.6

			if var_229_18 <= arg_226_1.time_ and arg_226_1.time_ < var_229_18 + var_229_19 then
				local var_229_20 = (arg_226_1.time_ - var_229_18) / var_229_19
				local var_229_21 = Color.New(0, 0, 0)

				var_229_21.a = Mathf.Lerp(0, 1, var_229_20)
				arg_226_1.mask_.color = var_229_21
			end

			if arg_226_1.time_ >= var_229_18 + var_229_19 and arg_226_1.time_ < var_229_18 + var_229_19 + arg_229_0 then
				local var_229_22 = Color.New(0, 0, 0)

				var_229_22.a = 1
				arg_226_1.mask_.color = var_229_22
			end

			local var_229_23 = 1.6

			if var_229_23 < arg_226_1.time_ and arg_226_1.time_ <= var_229_23 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_24 = 1.76666666666667

			if var_229_23 <= arg_226_1.time_ and arg_226_1.time_ < var_229_23 + var_229_24 then
				local var_229_25 = (arg_226_1.time_ - var_229_23) / var_229_24
				local var_229_26 = Color.New(0, 0, 0)

				var_229_26.a = Mathf.Lerp(1, 0, var_229_25)
				arg_226_1.mask_.color = var_229_26
			end

			if arg_226_1.time_ >= var_229_23 + var_229_24 and arg_226_1.time_ < var_229_23 + var_229_24 + arg_229_0 then
				local var_229_27 = Color.New(0, 0, 0)
				local var_229_28 = 0

				arg_226_1.mask_.enabled = false
				var_229_27.a = var_229_28
				arg_226_1.mask_.color = var_229_27
			end

			local var_229_29 = arg_226_1.actors_["10128"]
			local var_229_30 = 1.56666666666667

			if var_229_30 < arg_226_1.time_ and arg_226_1.time_ <= var_229_30 + arg_229_0 and not isNil(var_229_29) and arg_226_1.var_.actorSpriteComps10128 == nil then
				arg_226_1.var_.actorSpriteComps10128 = var_229_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_31 = 0.2

			if var_229_30 <= arg_226_1.time_ and arg_226_1.time_ < var_229_30 + var_229_31 and not isNil(var_229_29) then
				local var_229_32 = (arg_226_1.time_ - var_229_30) / var_229_31

				if arg_226_1.var_.actorSpriteComps10128 then
					for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_229_3 then
							if arg_226_1.isInRecall_ then
								local var_229_33 = Mathf.Lerp(iter_229_3.color.r, arg_226_1.hightColor2.r, var_229_32)
								local var_229_34 = Mathf.Lerp(iter_229_3.color.g, arg_226_1.hightColor2.g, var_229_32)
								local var_229_35 = Mathf.Lerp(iter_229_3.color.b, arg_226_1.hightColor2.b, var_229_32)

								iter_229_3.color = Color.New(var_229_33, var_229_34, var_229_35)
							else
								local var_229_36 = Mathf.Lerp(iter_229_3.color.r, 0.5, var_229_32)

								iter_229_3.color = Color.New(var_229_36, var_229_36, var_229_36)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_30 + var_229_31 and arg_226_1.time_ < var_229_30 + var_229_31 + arg_229_0 and not isNil(var_229_29) and arg_226_1.var_.actorSpriteComps10128 then
				for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_229_5 then
						if arg_226_1.isInRecall_ then
							iter_229_5.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps10128 = nil
			end

			local var_229_37 = arg_226_1.actors_["10128"].transform
			local var_229_38 = 1.56666666666667

			if var_229_38 < arg_226_1.time_ and arg_226_1.time_ <= var_229_38 + arg_229_0 then
				arg_226_1.var_.moveOldPos10128 = var_229_37.localPosition
				var_229_37.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10128", 7)

				local var_229_39 = var_229_37.childCount

				for iter_229_6 = 0, var_229_39 - 1 do
					local var_229_40 = var_229_37:GetChild(iter_229_6)

					if var_229_40.name == "" or not string.find(var_229_40.name, "split") then
						var_229_40.gameObject:SetActive(true)
					else
						var_229_40.gameObject:SetActive(false)
					end
				end
			end

			local var_229_41 = 0.001

			if var_229_38 <= arg_226_1.time_ and arg_226_1.time_ < var_229_38 + var_229_41 then
				local var_229_42 = (arg_226_1.time_ - var_229_38) / var_229_41
				local var_229_43 = Vector3.New(0, -2000, -300)

				var_229_37.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10128, var_229_43, var_229_42)
			end

			if arg_226_1.time_ >= var_229_38 + var_229_41 and arg_226_1.time_ < var_229_38 + var_229_41 + arg_229_0 then
				var_229_37.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_229_44 = arg_226_1.actors_["1034"].transform
			local var_229_45 = 1.56666666666667

			if var_229_45 < arg_226_1.time_ and arg_226_1.time_ <= var_229_45 + arg_229_0 then
				arg_226_1.var_.moveOldPos1034 = var_229_44.localPosition
				var_229_44.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("1034", 7)

				local var_229_46 = var_229_44.childCount

				for iter_229_7 = 0, var_229_46 - 1 do
					local var_229_47 = var_229_44:GetChild(iter_229_7)

					if var_229_47.name == "" or not string.find(var_229_47.name, "split") then
						var_229_47.gameObject:SetActive(true)
					else
						var_229_47.gameObject:SetActive(false)
					end
				end
			end

			local var_229_48 = 0.001

			if var_229_45 <= arg_226_1.time_ and arg_226_1.time_ < var_229_45 + var_229_48 then
				local var_229_49 = (arg_226_1.time_ - var_229_45) / var_229_48
				local var_229_50 = Vector3.New(0, -2000, 0)

				var_229_44.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1034, var_229_50, var_229_49)
			end

			if arg_226_1.time_ >= var_229_45 + var_229_48 and arg_226_1.time_ < var_229_45 + var_229_48 + arg_229_0 then
				var_229_44.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_229_51 = 0
			local var_229_52 = 0.2

			if var_229_51 < arg_226_1.time_ and arg_226_1.time_ <= var_229_51 + arg_229_0 then
				local var_229_53 = "play"
				local var_229_54 = "music"

				arg_226_1:AudioAction(var_229_53, var_229_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_229_55 = ""
				local var_229_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_229_56 ~= "" then
					if arg_226_1.bgmTxt_.text ~= var_229_56 and arg_226_1.bgmTxt_.text ~= "" then
						if arg_226_1.bgmTxt2_.text ~= "" then
							arg_226_1.bgmTxt_.text = arg_226_1.bgmTxt2_.text
						end

						arg_226_1.bgmTxt2_.text = var_229_56

						arg_226_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_226_1.bgmTxt_.text = var_229_56
						arg_226_1.bgmTxt2_.text = var_229_56
					end

					if arg_226_1.bgmTimer then
						arg_226_1.bgmTimer:Stop()

						arg_226_1.bgmTimer = nil
					end

					if arg_226_1.settingData.show_music_name == 1 then
						arg_226_1.musicController:SetSelectedState("show")
						arg_226_1.musicAnimator_:Play("open", 0, 0)

						if arg_226_1.settingData.music_time ~= 0 then
							arg_226_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_226_1.settingData.music_time), function()
								if arg_226_1 == nil or isNil(arg_226_1.bgmTxt_) then
									return
								end

								arg_226_1.musicController:SetSelectedState("hide")
								arg_226_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_229_57 = 1.33333333333333
			local var_229_58 = 1

			if var_229_57 < arg_226_1.time_ and arg_226_1.time_ <= var_229_57 + arg_229_0 then
				local var_229_59 = "play"
				local var_229_60 = "music"

				arg_226_1:AudioAction(var_229_59, var_229_60, "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_229_61 = ""
				local var_229_62 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if var_229_62 ~= "" then
					if arg_226_1.bgmTxt_.text ~= var_229_62 and arg_226_1.bgmTxt_.text ~= "" then
						if arg_226_1.bgmTxt2_.text ~= "" then
							arg_226_1.bgmTxt_.text = arg_226_1.bgmTxt2_.text
						end

						arg_226_1.bgmTxt2_.text = var_229_62

						arg_226_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_226_1.bgmTxt_.text = var_229_62
						arg_226_1.bgmTxt2_.text = var_229_62
					end

					if arg_226_1.bgmTimer then
						arg_226_1.bgmTimer:Stop()

						arg_226_1.bgmTimer = nil
					end

					if arg_226_1.settingData.show_music_name == 1 then
						arg_226_1.musicController:SetSelectedState("show")
						arg_226_1.musicAnimator_:Play("open", 0, 0)

						if arg_226_1.settingData.music_time ~= 0 then
							arg_226_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_226_1.settingData.music_time), function()
								if arg_226_1 == nil or isNil(arg_226_1.bgmTxt_) then
									return
								end

								arg_226_1.musicController:SetSelectedState("hide")
								arg_226_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_226_1.frameCnt_ <= 1 then
				arg_226_1.dialog_:SetActive(false)
			end

			local var_229_63 = 3.23333333333333
			local var_229_64 = 0.7

			if var_229_63 < arg_226_1.time_ and arg_226_1.time_ <= var_229_63 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0

				arg_226_1.dialog_:SetActive(true)

				arg_226_1.dialogCg_.alpha = 0

				local var_229_65 = LeanTween.value(arg_226_1.dialog_, 0, 1, 0.3)

				var_229_65:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_226_1.dialogCg_.alpha = arg_232_0
				end))
				var_229_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_226_1.dialog_)
					var_229_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_226_1.duration_ = arg_226_1.duration_ + 0.3

				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_66 = arg_226_1:GetWordFromCfg(417091055)
				local var_229_67 = arg_226_1:FormatText(var_229_66.content)

				arg_226_1.text_.text = var_229_67

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_68 = 28
				local var_229_69 = utf8.len(var_229_67)
				local var_229_70 = var_229_68 <= 0 and var_229_64 or var_229_64 * (var_229_69 / var_229_68)

				if var_229_70 > 0 and var_229_64 < var_229_70 then
					arg_226_1.talkMaxDuration = var_229_70
					var_229_63 = var_229_63 + 0.3

					if var_229_70 + var_229_63 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_70 + var_229_63
					end
				end

				arg_226_1.text_.text = var_229_67
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_71 = var_229_63 + 0.3
			local var_229_72 = math.max(var_229_64, arg_226_1.talkMaxDuration)

			if var_229_71 <= arg_226_1.time_ and arg_226_1.time_ < var_229_71 + var_229_72 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_71) / var_229_72

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_71 + var_229_72 and arg_226_1.time_ < var_229_71 + var_229_72 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play417091056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417091056
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417091057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 1.15

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_2 = arg_234_1:GetWordFromCfg(417091056)
				local var_237_3 = arg_234_1:FormatText(var_237_2.content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_4 = 46
				local var_237_5 = utf8.len(var_237_3)
				local var_237_6 = var_237_4 <= 0 and var_237_1 or var_237_1 * (var_237_5 / var_237_4)

				if var_237_6 > 0 and var_237_1 < var_237_6 then
					arg_234_1.talkMaxDuration = var_237_6

					if var_237_6 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_7 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_7 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_7

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_7 and arg_234_1.time_ < var_237_0 + var_237_7 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play417091057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 417091057
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play417091058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 1.125

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_2 = arg_238_1:GetWordFromCfg(417091057)
				local var_241_3 = arg_238_1:FormatText(var_241_2.content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 45
				local var_241_5 = utf8.len(var_241_3)
				local var_241_6 = var_241_4 <= 0 and var_241_1 or var_241_1 * (var_241_5 / var_241_4)

				if var_241_6 > 0 and var_241_1 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_7 and arg_238_1.time_ < var_241_0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play417091058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 417091058
		arg_242_1.duration_ = 3.3

		local var_242_0 = {
			zh = 3.3,
			ja = 3.266
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play417091059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1034"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps1034 == nil then
				arg_242_1.var_.actorSpriteComps1034 = var_245_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.actorSpriteComps1034 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								local var_245_4 = Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor1.r, var_245_3)
								local var_245_5 = Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor1.g, var_245_3)
								local var_245_6 = Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor1.b, var_245_3)

								iter_245_1.color = Color.New(var_245_4, var_245_5, var_245_6)
							else
								local var_245_7 = Mathf.Lerp(iter_245_1.color.r, 1, var_245_3)

								iter_245_1.color = Color.New(var_245_7, var_245_7, var_245_7)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps1034 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_245_3 then
						if arg_242_1.isInRecall_ then
							iter_245_3.color = arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_245_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps1034 = nil
			end

			local var_245_8 = arg_242_1.actors_["1034"].transform
			local var_245_9 = 0

			if var_245_9 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 then
				arg_242_1.var_.moveOldPos1034 = var_245_8.localPosition
				var_245_8.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("1034", 3)

				local var_245_10 = var_245_8.childCount

				for iter_245_4 = 0, var_245_10 - 1 do
					local var_245_11 = var_245_8:GetChild(iter_245_4)

					if var_245_11.name == "split_4" or not string.find(var_245_11.name, "split") then
						var_245_11.gameObject:SetActive(true)
					else
						var_245_11.gameObject:SetActive(false)
					end
				end
			end

			local var_245_12 = 0.001

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_12 then
				local var_245_13 = (arg_242_1.time_ - var_245_9) / var_245_12
				local var_245_14 = Vector3.New(0, -331.9, -324)

				var_245_8.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1034, var_245_14, var_245_13)
			end

			if arg_242_1.time_ >= var_245_9 + var_245_12 and arg_242_1.time_ < var_245_9 + var_245_12 + arg_245_0 then
				var_245_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_245_15 = 0
			local var_245_16 = 0.375

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_17 = arg_242_1:FormatText(StoryNameCfg[1109].name)

				arg_242_1.leftNameTxt_.text = var_245_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_18 = arg_242_1:GetWordFromCfg(417091058)
				local var_245_19 = arg_242_1:FormatText(var_245_18.content)

				arg_242_1.text_.text = var_245_19

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_20 = 15
				local var_245_21 = utf8.len(var_245_19)
				local var_245_22 = var_245_20 <= 0 and var_245_16 or var_245_16 * (var_245_21 / var_245_20)

				if var_245_22 > 0 and var_245_16 < var_245_22 then
					arg_242_1.talkMaxDuration = var_245_22

					if var_245_22 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_22 + var_245_15
					end
				end

				arg_242_1.text_.text = var_245_19
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091058", "story_v_out_417091.awb") ~= 0 then
					local var_245_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091058", "story_v_out_417091.awb") / 1000

					if var_245_23 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_23 + var_245_15
					end

					if var_245_18.prefab_name ~= "" and arg_242_1.actors_[var_245_18.prefab_name] ~= nil then
						local var_245_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_18.prefab_name].transform, "story_v_out_417091", "417091058", "story_v_out_417091.awb")

						arg_242_1:RecordAudio("417091058", var_245_24)
						arg_242_1:RecordAudio("417091058", var_245_24)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_417091", "417091058", "story_v_out_417091.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_417091", "417091058", "story_v_out_417091.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_25 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 <= arg_242_1.time_ and arg_242_1.time_ < var_245_15 + var_245_25 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_15) / var_245_25

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_15 + var_245_25 and arg_242_1.time_ < var_245_15 + var_245_25 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play417091059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 417091059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play417091060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1034"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps1034 == nil then
				arg_246_1.var_.actorSpriteComps1034 = var_249_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_2 = 0.2

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.actorSpriteComps1034 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								local var_249_4 = Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor2.r, var_249_3)
								local var_249_5 = Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor2.g, var_249_3)
								local var_249_6 = Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor2.b, var_249_3)

								iter_249_1.color = Color.New(var_249_4, var_249_5, var_249_6)
							else
								local var_249_7 = Mathf.Lerp(iter_249_1.color.r, 0.5, var_249_3)

								iter_249_1.color = Color.New(var_249_7, var_249_7, var_249_7)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.actorSpriteComps1034 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_249_3 then
						if arg_246_1.isInRecall_ then
							iter_249_3.color = arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_249_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_246_1.var_.actorSpriteComps1034 = nil
			end

			local var_249_8 = 0
			local var_249_9 = 1.35

			if var_249_8 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_10 = arg_246_1:GetWordFromCfg(417091059)
				local var_249_11 = arg_246_1:FormatText(var_249_10.content)

				arg_246_1.text_.text = var_249_11

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_12 = 54
				local var_249_13 = utf8.len(var_249_11)
				local var_249_14 = var_249_12 <= 0 and var_249_9 or var_249_9 * (var_249_13 / var_249_12)

				if var_249_14 > 0 and var_249_9 < var_249_14 then
					arg_246_1.talkMaxDuration = var_249_14

					if var_249_14 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_8
					end
				end

				arg_246_1.text_.text = var_249_11
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_15 = math.max(var_249_9, arg_246_1.talkMaxDuration)

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_15 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_8) / var_249_15

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_8 + var_249_15 and arg_246_1.time_ < var_249_8 + var_249_15 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play417091060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 417091060
		arg_250_1.duration_ = 7.6

		local var_250_0 = {
			zh = 3,
			ja = 7.6
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
				arg_250_0:Play417091061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1034"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps1034 == nil then
				arg_250_1.var_.actorSpriteComps1034 = var_253_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.actorSpriteComps1034 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps1034 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_253_3 then
						if arg_250_1.isInRecall_ then
							iter_253_3.color = arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_253_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps1034 = nil
			end

			local var_253_8 = arg_250_1.actors_["1034"].transform
			local var_253_9 = 0

			if var_253_9 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 then
				arg_250_1.var_.moveOldPos1034 = var_253_8.localPosition
				var_253_8.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1034", 3)

				local var_253_10 = var_253_8.childCount

				for iter_253_4 = 0, var_253_10 - 1 do
					local var_253_11 = var_253_8:GetChild(iter_253_4)

					if var_253_11.name == "" or not string.find(var_253_11.name, "split") then
						var_253_11.gameObject:SetActive(true)
					else
						var_253_11.gameObject:SetActive(false)
					end
				end
			end

			local var_253_12 = 0.001

			if var_253_9 <= arg_250_1.time_ and arg_250_1.time_ < var_253_9 + var_253_12 then
				local var_253_13 = (arg_250_1.time_ - var_253_9) / var_253_12
				local var_253_14 = Vector3.New(0, -331.9, -324)

				var_253_8.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1034, var_253_14, var_253_13)
			end

			if arg_250_1.time_ >= var_253_9 + var_253_12 and arg_250_1.time_ < var_253_9 + var_253_12 + arg_253_0 then
				var_253_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_253_15 = 0
			local var_253_16 = 0.35

			if var_253_15 < arg_250_1.time_ and arg_250_1.time_ <= var_253_15 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_17 = arg_250_1:FormatText(StoryNameCfg[1109].name)

				arg_250_1.leftNameTxt_.text = var_253_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_18 = arg_250_1:GetWordFromCfg(417091060)
				local var_253_19 = arg_250_1:FormatText(var_253_18.content)

				arg_250_1.text_.text = var_253_19

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091060", "story_v_out_417091.awb") ~= 0 then
					local var_253_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091060", "story_v_out_417091.awb") / 1000

					if var_253_23 + var_253_15 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_15
					end

					if var_253_18.prefab_name ~= "" and arg_250_1.actors_[var_253_18.prefab_name] ~= nil then
						local var_253_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_18.prefab_name].transform, "story_v_out_417091", "417091060", "story_v_out_417091.awb")

						arg_250_1:RecordAudio("417091060", var_253_24)
						arg_250_1:RecordAudio("417091060", var_253_24)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_417091", "417091060", "story_v_out_417091.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_417091", "417091060", "story_v_out_417091.awb")
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
				actorName = "1034",
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
	Play417091061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 417091061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play417091062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1034"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps1034 == nil then
				arg_254_1.var_.actorSpriteComps1034 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps1034 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps1034 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_257_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps1034 = nil
			end

			local var_257_8 = 0.2
			local var_257_9 = 1

			if var_257_8 < arg_254_1.time_ and arg_254_1.time_ <= var_257_8 + arg_257_0 then
				local var_257_10 = "play"
				local var_257_11 = "effect"

				arg_254_1:AudioAction(var_257_10, var_257_11, "se_story_1310", "se_story_1310_keyboard", "")
			end

			local var_257_12 = 0
			local var_257_13 = 1.4

			if var_257_12 < arg_254_1.time_ and arg_254_1.time_ <= var_257_12 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_14 = arg_254_1:GetWordFromCfg(417091061)
				local var_257_15 = arg_254_1:FormatText(var_257_14.content)

				arg_254_1.text_.text = var_257_15

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_16 = 56
				local var_257_17 = utf8.len(var_257_15)
				local var_257_18 = var_257_16 <= 0 and var_257_13 or var_257_13 * (var_257_17 / var_257_16)

				if var_257_18 > 0 and var_257_13 < var_257_18 then
					arg_254_1.talkMaxDuration = var_257_18

					if var_257_18 + var_257_12 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_18 + var_257_12
					end
				end

				arg_254_1.text_.text = var_257_15
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_19 = math.max(var_257_13, arg_254_1.talkMaxDuration)

			if var_257_12 <= arg_254_1.time_ and arg_254_1.time_ < var_257_12 + var_257_19 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_12) / var_257_19

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_12 + var_257_19 and arg_254_1.time_ < var_257_12 + var_257_19 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play417091062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 417091062
		arg_258_1.duration_ = 12.93

		local var_258_0 = {
			zh = 8.93333333333333,
			ja = 12.9333333333333
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
				arg_258_0:Play417091063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = "B01"

			if arg_258_1.bgs_[var_261_0] == nil then
				local var_261_1 = Object.Instantiate(arg_258_1.paintGo_)

				var_261_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_261_0)
				var_261_1.name = var_261_0
				var_261_1.transform.parent = arg_258_1.stage_.transform
				var_261_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.bgs_[var_261_0] = var_261_1
			end

			local var_261_2 = 1.93333333333333

			if var_261_2 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				local var_261_3 = manager.ui.mainCamera.transform.localPosition
				local var_261_4 = Vector3.New(0, 0, 10) + Vector3.New(var_261_3.x, var_261_3.y, 0)
				local var_261_5 = arg_258_1.bgs_.B01

				var_261_5.transform.localPosition = var_261_4
				var_261_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_6 = var_261_5:GetComponent("SpriteRenderer")

				if var_261_6 and var_261_6.sprite then
					local var_261_7 = (var_261_5.transform.localPosition - var_261_3).z
					local var_261_8 = manager.ui.mainCameraCom_
					local var_261_9 = 2 * var_261_7 * Mathf.Tan(var_261_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_261_10 = var_261_9 * var_261_8.aspect
					local var_261_11 = var_261_6.sprite.bounds.size.x
					local var_261_12 = var_261_6.sprite.bounds.size.y
					local var_261_13 = var_261_10 / var_261_11
					local var_261_14 = var_261_9 / var_261_12
					local var_261_15 = var_261_14 < var_261_13 and var_261_13 or var_261_14

					var_261_5.transform.localScale = Vector3.New(var_261_15, var_261_15, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "B01" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_16 = 1.93333333333333

			if var_261_16 < arg_258_1.time_ and arg_258_1.time_ <= var_261_16 + arg_261_0 then
				arg_258_1.allBtn_.enabled = false
			end

			local var_261_17 = 0.3

			if arg_258_1.time_ >= var_261_16 + var_261_17 and arg_258_1.time_ < var_261_16 + var_261_17 + arg_261_0 then
				arg_258_1.allBtn_.enabled = true
			end

			local var_261_18 = 0

			if var_261_18 < arg_258_1.time_ and arg_258_1.time_ <= var_261_18 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_19 = 1.96733333333333

			if var_261_18 <= arg_258_1.time_ and arg_258_1.time_ < var_261_18 + var_261_19 then
				local var_261_20 = (arg_258_1.time_ - var_261_18) / var_261_19
				local var_261_21 = Color.New(0, 0, 0)

				var_261_21.a = Mathf.Lerp(0, 1, var_261_20)
				arg_258_1.mask_.color = var_261_21
			end

			if arg_258_1.time_ >= var_261_18 + var_261_19 and arg_258_1.time_ < var_261_18 + var_261_19 + arg_261_0 then
				local var_261_22 = Color.New(0, 0, 0)

				var_261_22.a = 1
				arg_258_1.mask_.color = var_261_22
			end

			local var_261_23 = 1.93333333333333

			if var_261_23 < arg_258_1.time_ and arg_258_1.time_ <= var_261_23 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_24 = 2

			if var_261_23 <= arg_258_1.time_ and arg_258_1.time_ < var_261_23 + var_261_24 then
				local var_261_25 = (arg_258_1.time_ - var_261_23) / var_261_24
				local var_261_26 = Color.New(0, 0, 0)

				var_261_26.a = Mathf.Lerp(1, 0, var_261_25)
				arg_258_1.mask_.color = var_261_26
			end

			if arg_258_1.time_ >= var_261_23 + var_261_24 and arg_258_1.time_ < var_261_23 + var_261_24 + arg_261_0 then
				local var_261_27 = Color.New(0, 0, 0)
				local var_261_28 = 0

				arg_258_1.mask_.enabled = false
				var_261_27.a = var_261_28
				arg_258_1.mask_.color = var_261_27
			end

			local var_261_29 = arg_258_1.actors_["10113"]
			local var_261_30 = 3.53333333333233

			if var_261_30 < arg_258_1.time_ and arg_258_1.time_ <= var_261_30 + arg_261_0 and not isNil(var_261_29) and arg_258_1.var_.actorSpriteComps10113 == nil then
				arg_258_1.var_.actorSpriteComps10113 = var_261_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_31 = 0.2

			if var_261_30 <= arg_258_1.time_ and arg_258_1.time_ < var_261_30 + var_261_31 and not isNil(var_261_29) then
				local var_261_32 = (arg_258_1.time_ - var_261_30) / var_261_31

				if arg_258_1.var_.actorSpriteComps10113 then
					for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_261_3 then
							if arg_258_1.isInRecall_ then
								local var_261_33 = Mathf.Lerp(iter_261_3.color.r, arg_258_1.hightColor1.r, var_261_32)
								local var_261_34 = Mathf.Lerp(iter_261_3.color.g, arg_258_1.hightColor1.g, var_261_32)
								local var_261_35 = Mathf.Lerp(iter_261_3.color.b, arg_258_1.hightColor1.b, var_261_32)

								iter_261_3.color = Color.New(var_261_33, var_261_34, var_261_35)
							else
								local var_261_36 = Mathf.Lerp(iter_261_3.color.r, 1, var_261_32)

								iter_261_3.color = Color.New(var_261_36, var_261_36, var_261_36)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_30 + var_261_31 and arg_258_1.time_ < var_261_30 + var_261_31 + arg_261_0 and not isNil(var_261_29) and arg_258_1.var_.actorSpriteComps10113 then
				for iter_261_4, iter_261_5 in pairs(arg_258_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_261_5 then
						if arg_258_1.isInRecall_ then
							iter_261_5.color = arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_261_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps10113 = nil
			end

			local var_261_37 = arg_258_1.actors_["1034"].transform
			local var_261_38 = 1.93333333333333

			if var_261_38 < arg_258_1.time_ and arg_258_1.time_ <= var_261_38 + arg_261_0 then
				arg_258_1.var_.moveOldPos1034 = var_261_37.localPosition
				var_261_37.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1034", 7)

				local var_261_39 = var_261_37.childCount

				for iter_261_6 = 0, var_261_39 - 1 do
					local var_261_40 = var_261_37:GetChild(iter_261_6)

					if var_261_40.name == "" or not string.find(var_261_40.name, "split") then
						var_261_40.gameObject:SetActive(true)
					else
						var_261_40.gameObject:SetActive(false)
					end
				end
			end

			local var_261_41 = 0.001

			if var_261_38 <= arg_258_1.time_ and arg_258_1.time_ < var_261_38 + var_261_41 then
				local var_261_42 = (arg_258_1.time_ - var_261_38) / var_261_41
				local var_261_43 = Vector3.New(0, -2000, 0)

				var_261_37.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1034, var_261_43, var_261_42)
			end

			if arg_258_1.time_ >= var_261_38 + var_261_41 and arg_258_1.time_ < var_261_38 + var_261_41 + arg_261_0 then
				var_261_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_44 = arg_258_1.actors_["10113"].transform
			local var_261_45 = 3.53333333333233

			if var_261_45 < arg_258_1.time_ and arg_258_1.time_ <= var_261_45 + arg_261_0 then
				arg_258_1.var_.moveOldPos10113 = var_261_44.localPosition
				var_261_44.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("10113", 3)

				local var_261_46 = var_261_44.childCount

				for iter_261_7 = 0, var_261_46 - 1 do
					local var_261_47 = var_261_44:GetChild(iter_261_7)

					if var_261_47.name == "" or not string.find(var_261_47.name, "split") then
						var_261_47.gameObject:SetActive(true)
					else
						var_261_47.gameObject:SetActive(false)
					end
				end
			end

			local var_261_48 = 0.001

			if var_261_45 <= arg_258_1.time_ and arg_258_1.time_ < var_261_45 + var_261_48 then
				local var_261_49 = (arg_258_1.time_ - var_261_45) / var_261_48
				local var_261_50 = Vector3.New(-30.38, -328.4, -517.4)

				var_261_44.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10113, var_261_50, var_261_49)
			end

			if arg_258_1.time_ >= var_261_45 + var_261_48 and arg_258_1.time_ < var_261_45 + var_261_48 + arg_261_0 then
				var_261_44.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_261_51 = arg_258_1.actors_["10113"]
			local var_261_52 = 3.53333333333233

			if var_261_52 < arg_258_1.time_ and arg_258_1.time_ <= var_261_52 + arg_261_0 then
				local var_261_53 = var_261_51:GetComponentInChildren(typeof(CanvasGroup))

				if var_261_53 then
					arg_258_1.var_.alphaOldValue10113 = var_261_53.alpha
					arg_258_1.var_.characterEffect10113 = var_261_53
				end

				arg_258_1.var_.alphaOldValue10113 = 0
			end

			local var_261_54 = 0.200000000001

			if var_261_52 <= arg_258_1.time_ and arg_258_1.time_ < var_261_52 + var_261_54 then
				local var_261_55 = (arg_258_1.time_ - var_261_52) / var_261_54
				local var_261_56 = Mathf.Lerp(arg_258_1.var_.alphaOldValue10113, 1, var_261_55)

				if arg_258_1.var_.characterEffect10113 then
					arg_258_1.var_.characterEffect10113.alpha = var_261_56
				end
			end

			if arg_258_1.time_ >= var_261_52 + var_261_54 and arg_258_1.time_ < var_261_52 + var_261_54 + arg_261_0 and arg_258_1.var_.characterEffect10113 then
				arg_258_1.var_.characterEffect10113.alpha = 1
			end

			local var_261_57 = 1.93333333333333

			arg_258_1.isInRecall_ = true

			if var_261_57 < arg_258_1.time_ and arg_258_1.time_ <= var_261_57 + arg_261_0 then
				arg_258_1.screenFilterGo_:SetActive(true)

				arg_258_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_258_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_258_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_261_8, iter_261_9 in pairs(arg_258_1.actors_) do
					local var_261_58 = iter_261_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_261_10, iter_261_11 in ipairs(var_261_58) do
						if iter_261_11.color.r > 0.51 then
							iter_261_11.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_261_11.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_261_59 = 0.034

			if var_261_57 <= arg_258_1.time_ and arg_258_1.time_ < var_261_57 + var_261_59 then
				local var_261_60 = (arg_258_1.time_ - var_261_57) / var_261_59

				arg_258_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_261_60)
			end

			if arg_258_1.time_ >= var_261_57 + var_261_59 and arg_258_1.time_ < var_261_57 + var_261_59 + arg_261_0 then
				arg_258_1.screenFilterEffect_.weight = 1
			end

			if arg_258_1.frameCnt_ <= 1 then
				arg_258_1.dialog_:SetActive(false)
			end

			local var_261_61 = 3.93333333333333
			local var_261_62 = 0.575

			if var_261_61 < arg_258_1.time_ and arg_258_1.time_ <= var_261_61 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				arg_258_1.dialog_:SetActive(true)

				arg_258_1.dialogCg_.alpha = 0

				local var_261_63 = LeanTween.value(arg_258_1.dialog_, 0, 1, 0.3)

				var_261_63:setOnUpdate(LuaHelper.FloatAction(function(arg_262_0)
					arg_258_1.dialogCg_.alpha = arg_262_0
				end))
				var_261_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_258_1.dialog_)
					var_261_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_258_1.duration_ = arg_258_1.duration_ + 0.3

				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_64 = arg_258_1:FormatText(StoryNameCfg[1117].name)

				arg_258_1.leftNameTxt_.text = var_261_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_65 = arg_258_1:GetWordFromCfg(417091062)
				local var_261_66 = arg_258_1:FormatText(var_261_65.content)

				arg_258_1.text_.text = var_261_66

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_67 = 23
				local var_261_68 = utf8.len(var_261_66)
				local var_261_69 = var_261_67 <= 0 and var_261_62 or var_261_62 * (var_261_68 / var_261_67)

				if var_261_69 > 0 and var_261_62 < var_261_69 then
					arg_258_1.talkMaxDuration = var_261_69
					var_261_61 = var_261_61 + 0.3

					if var_261_69 + var_261_61 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_69 + var_261_61
					end
				end

				arg_258_1.text_.text = var_261_66
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091062", "story_v_out_417091.awb") ~= 0 then
					local var_261_70 = manager.audio:GetVoiceLength("story_v_out_417091", "417091062", "story_v_out_417091.awb") / 1000

					if var_261_70 + var_261_61 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_70 + var_261_61
					end

					if var_261_65.prefab_name ~= "" and arg_258_1.actors_[var_261_65.prefab_name] ~= nil then
						local var_261_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_65.prefab_name].transform, "story_v_out_417091", "417091062", "story_v_out_417091.awb")

						arg_258_1:RecordAudio("417091062", var_261_71)
						arg_258_1:RecordAudio("417091062", var_261_71)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_417091", "417091062", "story_v_out_417091.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_417091", "417091062", "story_v_out_417091.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_72 = var_261_61 + 0.3
			local var_261_73 = math.max(var_261_62, arg_258_1.talkMaxDuration)

			if var_261_72 <= arg_258_1.time_ and arg_258_1.time_ < var_261_72 + var_261_73 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_72) / var_261_73

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_72 + var_261_73 and arg_258_1.time_ < var_261_72 + var_261_73 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.93333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.53333333333233,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play417091063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417091063
		arg_264_1.duration_ = 8.57

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play417091064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 1.96733333333333

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				local var_267_1 = manager.ui.mainCamera.transform.localPosition
				local var_267_2 = Vector3.New(0, 0, 10) + Vector3.New(var_267_1.x, var_267_1.y, 0)
				local var_267_3 = arg_264_1.bgs_.ST69

				var_267_3.transform.localPosition = var_267_2
				var_267_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_4 = var_267_3:GetComponent("SpriteRenderer")

				if var_267_4 and var_267_4.sprite then
					local var_267_5 = (var_267_3.transform.localPosition - var_267_1).z
					local var_267_6 = manager.ui.mainCameraCom_
					local var_267_7 = 2 * var_267_5 * Mathf.Tan(var_267_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_267_8 = var_267_7 * var_267_6.aspect
					local var_267_9 = var_267_4.sprite.bounds.size.x
					local var_267_10 = var_267_4.sprite.bounds.size.y
					local var_267_11 = var_267_8 / var_267_9
					local var_267_12 = var_267_7 / var_267_10
					local var_267_13 = var_267_12 < var_267_11 and var_267_11 or var_267_12

					var_267_3.transform.localScale = Vector3.New(var_267_13, var_267_13, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "ST69" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_14 = 1.96733333333333

			if var_267_14 < arg_264_1.time_ and arg_264_1.time_ <= var_267_14 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			local var_267_15 = 0.3

			if arg_264_1.time_ >= var_267_14 + var_267_15 and arg_264_1.time_ < var_267_14 + var_267_15 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			local var_267_16 = 0

			if var_267_16 < arg_264_1.time_ and arg_264_1.time_ <= var_267_16 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_17 = 1.96733333333333

			if var_267_16 <= arg_264_1.time_ and arg_264_1.time_ < var_267_16 + var_267_17 then
				local var_267_18 = (arg_264_1.time_ - var_267_16) / var_267_17
				local var_267_19 = Color.New(0, 0, 0)

				var_267_19.a = Mathf.Lerp(0, 1, var_267_18)
				arg_264_1.mask_.color = var_267_19
			end

			if arg_264_1.time_ >= var_267_16 + var_267_17 and arg_264_1.time_ < var_267_16 + var_267_17 + arg_267_0 then
				local var_267_20 = Color.New(0, 0, 0)

				var_267_20.a = 1
				arg_264_1.mask_.color = var_267_20
			end

			local var_267_21 = 1.96733333333333

			if var_267_21 < arg_264_1.time_ and arg_264_1.time_ <= var_267_21 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_22 = 2.034

			if var_267_21 <= arg_264_1.time_ and arg_264_1.time_ < var_267_21 + var_267_22 then
				local var_267_23 = (arg_264_1.time_ - var_267_21) / var_267_22
				local var_267_24 = Color.New(0, 0, 0)

				var_267_24.a = Mathf.Lerp(1, 0, var_267_23)
				arg_264_1.mask_.color = var_267_24
			end

			if arg_264_1.time_ >= var_267_21 + var_267_22 and arg_264_1.time_ < var_267_21 + var_267_22 + arg_267_0 then
				local var_267_25 = Color.New(0, 0, 0)
				local var_267_26 = 0

				arg_264_1.mask_.enabled = false
				var_267_25.a = var_267_26
				arg_264_1.mask_.color = var_267_25
			end

			local var_267_27 = arg_264_1.actors_["10113"]
			local var_267_28 = 1.96733333333333

			if var_267_28 < arg_264_1.time_ and arg_264_1.time_ <= var_267_28 + arg_267_0 and not isNil(var_267_27) and arg_264_1.var_.actorSpriteComps10113 == nil then
				arg_264_1.var_.actorSpriteComps10113 = var_267_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_29 = 0.2

			if var_267_28 <= arg_264_1.time_ and arg_264_1.time_ < var_267_28 + var_267_29 and not isNil(var_267_27) then
				local var_267_30 = (arg_264_1.time_ - var_267_28) / var_267_29

				if arg_264_1.var_.actorSpriteComps10113 then
					for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_267_3 then
							if arg_264_1.isInRecall_ then
								local var_267_31 = Mathf.Lerp(iter_267_3.color.r, arg_264_1.hightColor2.r, var_267_30)
								local var_267_32 = Mathf.Lerp(iter_267_3.color.g, arg_264_1.hightColor2.g, var_267_30)
								local var_267_33 = Mathf.Lerp(iter_267_3.color.b, arg_264_1.hightColor2.b, var_267_30)

								iter_267_3.color = Color.New(var_267_31, var_267_32, var_267_33)
							else
								local var_267_34 = Mathf.Lerp(iter_267_3.color.r, 0.5, var_267_30)

								iter_267_3.color = Color.New(var_267_34, var_267_34, var_267_34)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= var_267_28 + var_267_29 and arg_264_1.time_ < var_267_28 + var_267_29 + arg_267_0 and not isNil(var_267_27) and arg_264_1.var_.actorSpriteComps10113 then
				for iter_267_4, iter_267_5 in pairs(arg_264_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_267_5 then
						if arg_264_1.isInRecall_ then
							iter_267_5.color = arg_264_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_267_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_264_1.var_.actorSpriteComps10113 = nil
			end

			local var_267_35 = arg_264_1.actors_["10113"].transform
			local var_267_36 = 1.96733333333333

			if var_267_36 < arg_264_1.time_ and arg_264_1.time_ <= var_267_36 + arg_267_0 then
				arg_264_1.var_.moveOldPos10113 = var_267_35.localPosition
				var_267_35.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("10113", 7)

				local var_267_37 = var_267_35.childCount

				for iter_267_6 = 0, var_267_37 - 1 do
					local var_267_38 = var_267_35:GetChild(iter_267_6)

					if var_267_38.name == "" or not string.find(var_267_38.name, "split") then
						var_267_38.gameObject:SetActive(true)
					else
						var_267_38.gameObject:SetActive(false)
					end
				end
			end

			local var_267_39 = 0.001

			if var_267_36 <= arg_264_1.time_ and arg_264_1.time_ < var_267_36 + var_267_39 then
				local var_267_40 = (arg_264_1.time_ - var_267_36) / var_267_39
				local var_267_41 = Vector3.New(0, -2000, 0)

				var_267_35.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10113, var_267_41, var_267_40)
			end

			if arg_264_1.time_ >= var_267_36 + var_267_39 and arg_264_1.time_ < var_267_36 + var_267_39 + arg_267_0 then
				var_267_35.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_267_42 = 1.96733333333333

			arg_264_1.isInRecall_ = false

			if var_267_42 < arg_264_1.time_ and arg_264_1.time_ <= var_267_42 + arg_267_0 then
				arg_264_1.screenFilterGo_:SetActive(false)

				for iter_267_7, iter_267_8 in pairs(arg_264_1.actors_) do
					local var_267_43 = iter_267_8:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_267_9, iter_267_10 in ipairs(var_267_43) do
						if iter_267_10.color.r > 0.51 then
							iter_267_10.color = Color.New(1, 1, 1)
						else
							iter_267_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_267_44 = 0.034

			if var_267_42 <= arg_264_1.time_ and arg_264_1.time_ < var_267_42 + var_267_44 then
				local var_267_45 = (arg_264_1.time_ - var_267_42) / var_267_44

				arg_264_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_267_45)
			end

			if arg_264_1.time_ >= var_267_42 + var_267_44 and arg_264_1.time_ < var_267_42 + var_267_44 + arg_267_0 then
				arg_264_1.screenFilterEffect_.weight = 0
			end

			local var_267_46 = 5
			local var_267_47 = 1

			if var_267_46 < arg_264_1.time_ and arg_264_1.time_ <= var_267_46 + arg_267_0 then
				local var_267_48 = "play"
				local var_267_49 = "effect"

				arg_264_1:AudioAction(var_267_48, var_267_49, "se_story_1310", "se_story_1310_logout", "")
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_50 = 3.56666666666667
			local var_267_51 = 1.725

			if var_267_50 < arg_264_1.time_ and arg_264_1.time_ <= var_267_50 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_52 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_52:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_53 = arg_264_1:GetWordFromCfg(417091063)
				local var_267_54 = arg_264_1:FormatText(var_267_53.content)

				arg_264_1.text_.text = var_267_54

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_55 = 69
				local var_267_56 = utf8.len(var_267_54)
				local var_267_57 = var_267_55 <= 0 and var_267_51 or var_267_51 * (var_267_56 / var_267_55)

				if var_267_57 > 0 and var_267_51 < var_267_57 then
					arg_264_1.talkMaxDuration = var_267_57
					var_267_50 = var_267_50 + 0.3

					if var_267_57 + var_267_50 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_57 + var_267_50
					end
				end

				arg_264_1.text_.text = var_267_54
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_58 = var_267_50 + 0.3
			local var_267_59 = math.max(var_267_51, arg_264_1.talkMaxDuration)

			if var_267_58 <= arg_264_1.time_ and arg_264_1.time_ < var_267_58 + var_267_59 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_58) / var_267_59

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_58 + var_267_59 and arg_264_1.time_ < var_267_58 + var_267_59 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play417091064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417091064
		arg_270_1.duration_ = 4.93

		local var_270_0 = {
			zh = 4.933,
			ja = 2.966
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
				arg_270_0:Play417091065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1034"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps1034 == nil then
				arg_270_1.var_.actorSpriteComps1034 = var_273_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_2 = 0.2

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.actorSpriteComps1034 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								local var_273_4 = Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, var_273_3)
								local var_273_5 = Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, var_273_3)
								local var_273_6 = Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, var_273_3)

								iter_273_1.color = Color.New(var_273_4, var_273_5, var_273_6)
							else
								local var_273_7 = Mathf.Lerp(iter_273_1.color.r, 1, var_273_3)

								iter_273_1.color = Color.New(var_273_7, var_273_7, var_273_7)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.actorSpriteComps1034 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_273_3 then
						if arg_270_1.isInRecall_ then
							iter_273_3.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps1034 = nil
			end

			local var_273_8 = arg_270_1.actors_["1034"].transform
			local var_273_9 = 0

			if var_273_9 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 then
				arg_270_1.var_.moveOldPos1034 = var_273_8.localPosition
				var_273_8.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1034", 3)

				local var_273_10 = var_273_8.childCount

				for iter_273_4 = 0, var_273_10 - 1 do
					local var_273_11 = var_273_8:GetChild(iter_273_4)

					if var_273_11.name == "split_6" or not string.find(var_273_11.name, "split") then
						var_273_11.gameObject:SetActive(true)
					else
						var_273_11.gameObject:SetActive(false)
					end
				end
			end

			local var_273_12 = 0.001

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_12 then
				local var_273_13 = (arg_270_1.time_ - var_273_9) / var_273_12
				local var_273_14 = Vector3.New(0, -331.9, -324)

				var_273_8.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1034, var_273_14, var_273_13)
			end

			if arg_270_1.time_ >= var_273_9 + var_273_12 and arg_270_1.time_ < var_273_9 + var_273_12 + arg_273_0 then
				var_273_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_273_15 = 0
			local var_273_16 = 0.45

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_17 = arg_270_1:FormatText(StoryNameCfg[1109].name)

				arg_270_1.leftNameTxt_.text = var_273_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_18 = arg_270_1:GetWordFromCfg(417091064)
				local var_273_19 = arg_270_1:FormatText(var_273_18.content)

				arg_270_1.text_.text = var_273_19

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 18
				local var_273_21 = utf8.len(var_273_19)
				local var_273_22 = var_273_20 <= 0 and var_273_16 or var_273_16 * (var_273_21 / var_273_20)

				if var_273_22 > 0 and var_273_16 < var_273_22 then
					arg_270_1.talkMaxDuration = var_273_22

					if var_273_22 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_22 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_19
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091064", "story_v_out_417091.awb") ~= 0 then
					local var_273_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091064", "story_v_out_417091.awb") / 1000

					if var_273_23 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_15
					end

					if var_273_18.prefab_name ~= "" and arg_270_1.actors_[var_273_18.prefab_name] ~= nil then
						local var_273_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_18.prefab_name].transform, "story_v_out_417091", "417091064", "story_v_out_417091.awb")

						arg_270_1:RecordAudio("417091064", var_273_24)
						arg_270_1:RecordAudio("417091064", var_273_24)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417091", "417091064", "story_v_out_417091.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417091", "417091064", "story_v_out_417091.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_25 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_25 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_25

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_25 and arg_270_1.time_ < var_273_15 + var_273_25 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
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

		arg_270_1:InitPlayNodeList()
	end,
	Play417091065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 417091065
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play417091066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1034"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps1034 == nil then
				arg_274_1.var_.actorSpriteComps1034 = var_277_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_2 = 0.2

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.actorSpriteComps1034 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								local var_277_4 = Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor2.r, var_277_3)
								local var_277_5 = Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor2.g, var_277_3)
								local var_277_6 = Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor2.b, var_277_3)

								iter_277_1.color = Color.New(var_277_4, var_277_5, var_277_6)
							else
								local var_277_7 = Mathf.Lerp(iter_277_1.color.r, 0.5, var_277_3)

								iter_277_1.color = Color.New(var_277_7, var_277_7, var_277_7)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.actorSpriteComps1034 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_277_3 then
						if arg_274_1.isInRecall_ then
							iter_277_3.color = arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_277_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps1034 = nil
			end

			local var_277_8 = arg_274_1.actors_["1034"].transform
			local var_277_9 = 0

			if var_277_9 < arg_274_1.time_ and arg_274_1.time_ <= var_277_9 + arg_277_0 then
				arg_274_1.var_.moveOldPos1034 = var_277_8.localPosition
				var_277_8.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1034", 7)

				local var_277_10 = var_277_8.childCount

				for iter_277_4 = 0, var_277_10 - 1 do
					local var_277_11 = var_277_8:GetChild(iter_277_4)

					if var_277_11.name == "" or not string.find(var_277_11.name, "split") then
						var_277_11.gameObject:SetActive(true)
					else
						var_277_11.gameObject:SetActive(false)
					end
				end
			end

			local var_277_12 = 0.001

			if var_277_9 <= arg_274_1.time_ and arg_274_1.time_ < var_277_9 + var_277_12 then
				local var_277_13 = (arg_274_1.time_ - var_277_9) / var_277_12
				local var_277_14 = Vector3.New(0, -2000, 0)

				var_277_8.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1034, var_277_14, var_277_13)
			end

			if arg_274_1.time_ >= var_277_9 + var_277_12 and arg_274_1.time_ < var_277_9 + var_277_12 + arg_277_0 then
				var_277_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_277_15 = 0
			local var_277_16 = 0.6

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_17 = arg_274_1:GetWordFromCfg(417091065)
				local var_277_18 = arg_274_1:FormatText(var_277_17.content)

				arg_274_1.text_.text = var_277_18

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_19 = 24
				local var_277_20 = utf8.len(var_277_18)
				local var_277_21 = var_277_19 <= 0 and var_277_16 or var_277_16 * (var_277_20 / var_277_19)

				if var_277_21 > 0 and var_277_16 < var_277_21 then
					arg_274_1.talkMaxDuration = var_277_21

					if var_277_21 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_21 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_18
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_22 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_22 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_22

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_22 and arg_274_1.time_ < var_277_15 + var_277_22 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play417091066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417091066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play417091067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.175

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(417091066)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 47
				local var_281_5 = utf8.len(var_281_3)
				local var_281_6 = var_281_4 <= 0 and var_281_1 or var_281_1 * (var_281_5 / var_281_4)

				if var_281_6 > 0 and var_281_1 < var_281_6 then
					arg_278_1.talkMaxDuration = var_281_6

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_7 and arg_278_1.time_ < var_281_0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play417091067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 417091067
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play417091068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 1.5

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(417091067)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 60
				local var_285_5 = utf8.len(var_285_3)
				local var_285_6 = var_285_4 <= 0 and var_285_1 or var_285_1 * (var_285_5 / var_285_4)

				if var_285_6 > 0 and var_285_1 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_7 and arg_282_1.time_ < var_285_0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play417091068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 417091068
		arg_286_1.duration_ = 6.97

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play417091069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1034"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps1034 == nil then
				arg_286_1.var_.actorSpriteComps1034 = var_289_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_2 = 0.2

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.actorSpriteComps1034 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								local var_289_4 = Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, var_289_3)
								local var_289_5 = Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, var_289_3)
								local var_289_6 = Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, var_289_3)

								iter_289_1.color = Color.New(var_289_4, var_289_5, var_289_6)
							else
								local var_289_7 = Mathf.Lerp(iter_289_1.color.r, 1, var_289_3)

								iter_289_1.color = Color.New(var_289_7, var_289_7, var_289_7)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps1034 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_289_3 then
						if arg_286_1.isInRecall_ then
							iter_289_3.color = arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_289_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps1034 = nil
			end

			local var_289_8 = 1.3

			if var_289_8 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.cswbg_:SetActive(true)

				local var_289_9 = arg_286_1.cswt_:GetComponent("RectTransform")

				arg_286_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_289_9.offsetMin = Vector2.New(400, 105)
				var_289_9.offsetMax = Vector2.New(-400, -200)

				local var_289_10 = arg_286_1:GetWordFromCfg(419102)
				local var_289_11 = arg_286_1:FormatText(var_289_10.content)

				arg_286_1.cswt_.text = var_289_11

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.cswt_)

				arg_286_1.cswt_.fontSize = 120
				arg_286_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_286_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_286_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_289_12 = 1.3

			if var_289_12 < arg_286_1.time_ and arg_286_1.time_ <= var_289_12 + arg_289_0 then
				local var_289_13 = arg_286_1.fswbg_.transform:Find("textbox/adapt/content") or arg_286_1.fswbg_.transform:Find("textbox/content")
				local var_289_14 = arg_286_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_289_15 = var_289_13:GetComponent("Text")
				local var_289_16 = var_289_13:GetComponent("RectTransform")

				var_289_15.alignment = UnityEngine.TextAnchor.LowerCenter
				var_289_16.offsetMin = Vector2.New(0, 0)
				var_289_16.offsetMax = Vector2.New(0, 0)
			end

			local var_289_17 = 1.3

			if var_289_17 < arg_286_1.time_ and arg_286_1.time_ <= var_289_17 + arg_289_0 then
				arg_286_1.fswbg_:SetActive(true)
				arg_286_1.dialog_:SetActive(false)

				arg_286_1.fswtw_.percent = 0

				local var_289_18 = arg_286_1:GetWordFromCfg(417091068)
				local var_289_19 = arg_286_1:FormatText(var_289_18.content)

				arg_286_1.fswt_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.fswt_)

				arg_286_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_286_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_286_1.fswtw_:SetDirty()

				arg_286_1.typewritterCharCountI18N = 0

				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_20 = 2.3

			if var_289_20 < arg_286_1.time_ and arg_286_1.time_ <= var_289_20 + arg_289_0 then
				arg_286_1.var_.oldValueTypewriter = arg_286_1.fswtw_.percent

				SetActive(arg_286_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_286_1:ShowNextGo(false)
			end

			local var_289_21 = 17
			local var_289_22 = 1.13333333333333
			local var_289_23 = arg_286_1:GetWordFromCfg(417091068)
			local var_289_24 = arg_286_1:FormatText(var_289_23.content)
			local var_289_25, var_289_26 = arg_286_1:GetPercentByPara(var_289_24, 1)

			if var_289_20 < arg_286_1.time_ and arg_286_1.time_ <= var_289_20 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				local var_289_27 = var_289_21 <= 0 and var_289_22 or var_289_22 * ((var_289_26 - arg_286_1.typewritterCharCountI18N) / var_289_21)

				if var_289_27 > 0 and var_289_22 < var_289_27 then
					arg_286_1.talkMaxDuration = var_289_27

					if var_289_27 + var_289_20 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_27 + var_289_20
					end
				end
			end

			local var_289_28 = 1.13333333333333
			local var_289_29 = math.max(var_289_28, arg_286_1.talkMaxDuration)

			if var_289_20 <= arg_286_1.time_ and arg_286_1.time_ < var_289_20 + var_289_29 then
				local var_289_30 = (arg_286_1.time_ - var_289_20) / var_289_29

				arg_286_1.fswtw_.percent = Mathf.Lerp(arg_286_1.var_.oldValueTypewriter, var_289_25, var_289_30)
				arg_286_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_286_1.fswtw_:SetDirty()
			end

			if arg_286_1.time_ >= var_289_20 + var_289_29 and arg_286_1.time_ < var_289_20 + var_289_29 + arg_289_0 then
				arg_286_1.fswtw_.percent = var_289_25

				arg_286_1.fswtw_:SetDirty()
				arg_286_1:ShowNextGo(true)

				arg_286_1.typewritterCharCountI18N = var_289_26
			end

			local var_289_31 = 0

			if var_289_31 < arg_286_1.time_ and arg_286_1.time_ <= var_289_31 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_32 = 1.3

			if var_289_31 <= arg_286_1.time_ and arg_286_1.time_ < var_289_31 + var_289_32 then
				local var_289_33 = (arg_286_1.time_ - var_289_31) / var_289_32
				local var_289_34 = Color.New(0, 0, 0)

				var_289_34.a = Mathf.Lerp(0, 1, var_289_33)
				arg_286_1.mask_.color = var_289_34
			end

			if arg_286_1.time_ >= var_289_31 + var_289_32 and arg_286_1.time_ < var_289_31 + var_289_32 + arg_289_0 then
				local var_289_35 = Color.New(0, 0, 0)

				var_289_35.a = 1
				arg_286_1.mask_.color = var_289_35
			end

			local var_289_36 = 1.3

			if var_289_36 < arg_286_1.time_ and arg_286_1.time_ <= var_289_36 + arg_289_0 then
				arg_286_1.mask_.enabled = true
				arg_286_1.mask_.raycastTarget = true

				arg_286_1:SetGaussion(false)
			end

			local var_289_37 = 2

			if var_289_36 <= arg_286_1.time_ and arg_286_1.time_ < var_289_36 + var_289_37 then
				local var_289_38 = (arg_286_1.time_ - var_289_36) / var_289_37
				local var_289_39 = Color.New(0, 0, 0)

				var_289_39.a = Mathf.Lerp(1, 0, var_289_38)
				arg_286_1.mask_.color = var_289_39
			end

			if arg_286_1.time_ >= var_289_36 + var_289_37 and arg_286_1.time_ < var_289_36 + var_289_37 + arg_289_0 then
				local var_289_40 = Color.New(0, 0, 0)
				local var_289_41 = 0

				arg_286_1.mask_.enabled = false
				var_289_40.a = var_289_41
				arg_286_1.mask_.color = var_289_40
			end

			local var_289_42 = "STblack"

			if arg_286_1.bgs_[var_289_42] == nil then
				local var_289_43 = Object.Instantiate(arg_286_1.paintGo_)

				var_289_43:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_289_42)
				var_289_43.name = var_289_42
				var_289_43.transform.parent = arg_286_1.stage_.transform
				var_289_43.transform.localPosition = Vector3.New(0, 100, 0)
				arg_286_1.bgs_[var_289_42] = var_289_43
			end

			local var_289_44 = 1.3

			if var_289_44 < arg_286_1.time_ and arg_286_1.time_ <= var_289_44 + arg_289_0 then
				local var_289_45 = manager.ui.mainCamera.transform.localPosition
				local var_289_46 = Vector3.New(0, 0, 10) + Vector3.New(var_289_45.x, var_289_45.y, 0)
				local var_289_47 = arg_286_1.bgs_.STblack

				var_289_47.transform.localPosition = var_289_46
				var_289_47.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_289_48 = var_289_47:GetComponent("SpriteRenderer")

				if var_289_48 and var_289_48.sprite then
					local var_289_49 = (var_289_47.transform.localPosition - var_289_45).z
					local var_289_50 = manager.ui.mainCameraCom_
					local var_289_51 = 2 * var_289_49 * Mathf.Tan(var_289_50.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_289_52 = var_289_51 * var_289_50.aspect
					local var_289_53 = var_289_48.sprite.bounds.size.x
					local var_289_54 = var_289_48.sprite.bounds.size.y
					local var_289_55 = var_289_52 / var_289_53
					local var_289_56 = var_289_51 / var_289_54
					local var_289_57 = var_289_56 < var_289_55 and var_289_55 or var_289_56

					var_289_47.transform.localScale = Vector3.New(var_289_57, var_289_57, 0)
				end

				for iter_289_4, iter_289_5 in pairs(arg_286_1.bgs_) do
					if iter_289_4 ~= "STblack" then
						iter_289_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_289_58 = 2.3
			local var_289_59 = 4.666
			local var_289_60 = manager.audio:GetVoiceLength("story_v_out_417091", "417091068", "") / 1000

			if var_289_60 > 0 and var_289_59 < var_289_60 and var_289_60 + var_289_58 > arg_286_1.duration_ then
				local var_289_61 = var_289_60

				arg_286_1.duration_ = var_289_60 + var_289_58
			end

			if var_289_58 < arg_286_1.time_ and arg_286_1.time_ <= var_289_58 + arg_289_0 then
				local var_289_62 = "play"
				local var_289_63 = "voice"

				arg_286_1:AudioAction(var_289_62, var_289_63, "story_v_out_417091", "417091068", "")
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play417091069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 417091069
		arg_290_1.duration_ = 5.07

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play417091070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.fswbg_:SetActive(true)
				arg_290_1.dialog_:SetActive(false)

				arg_290_1.fswtw_.percent = 0

				local var_293_1 = arg_290_1:GetWordFromCfg(417091069)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.fswt_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.fswt_)

				arg_290_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_290_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_290_1.fswtw_:SetDirty()

				arg_290_1.typewritterCharCountI18N = 0

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_3 = 0.733333333333333

			if var_293_3 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.var_.oldValueTypewriter = arg_290_1.fswtw_.percent

				SetActive(arg_290_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_290_1:ShowNextGo(false)
			end

			local var_293_4 = 22
			local var_293_5 = 1.46666666666667
			local var_293_6 = arg_290_1:GetWordFromCfg(417091069)
			local var_293_7 = arg_290_1:FormatText(var_293_6.content)
			local var_293_8, var_293_9 = arg_290_1:GetPercentByPara(var_293_7, 1)

			if var_293_3 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				local var_293_10 = var_293_4 <= 0 and var_293_5 or var_293_5 * ((var_293_9 - arg_290_1.typewritterCharCountI18N) / var_293_4)

				if var_293_10 > 0 and var_293_5 < var_293_10 then
					arg_290_1.talkMaxDuration = var_293_10

					if var_293_10 + var_293_3 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_3
					end
				end
			end

			local var_293_11 = 1.46666666666667
			local var_293_12 = math.max(var_293_11, arg_290_1.talkMaxDuration)

			if var_293_3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_3 + var_293_12 then
				local var_293_13 = (arg_290_1.time_ - var_293_3) / var_293_12

				arg_290_1.fswtw_.percent = Mathf.Lerp(arg_290_1.var_.oldValueTypewriter, var_293_8, var_293_13)
				arg_290_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_290_1.fswtw_:SetDirty()
			end

			if arg_290_1.time_ >= var_293_3 + var_293_12 and arg_290_1.time_ < var_293_3 + var_293_12 + arg_293_0 then
				arg_290_1.fswtw_.percent = var_293_8

				arg_290_1.fswtw_:SetDirty()
				arg_290_1:ShowNextGo(true)

				arg_290_1.typewritterCharCountI18N = var_293_9
			end

			local var_293_14 = 0.733333333333333
			local var_293_15 = 4.333
			local var_293_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091069", "") / 1000

			if var_293_16 > 0 and var_293_15 < var_293_16 and var_293_16 + var_293_14 > arg_290_1.duration_ then
				local var_293_17 = var_293_16

				arg_290_1.duration_ = var_293_16 + var_293_14
			end

			if var_293_14 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				local var_293_18 = "play"
				local var_293_19 = "voice"

				arg_290_1:AudioAction(var_293_18, var_293_19, "story_v_out_417091", "417091069", "")
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play417091070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 417091070
		arg_294_1.duration_ = 8.3

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play417091071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1034"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps1034 == nil then
				arg_294_1.var_.actorSpriteComps1034 = var_297_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_2 = 0.2

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.actorSpriteComps1034 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								local var_297_4 = Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor2.r, var_297_3)
								local var_297_5 = Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor2.g, var_297_3)
								local var_297_6 = Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor2.b, var_297_3)

								iter_297_1.color = Color.New(var_297_4, var_297_5, var_297_6)
							else
								local var_297_7 = Mathf.Lerp(iter_297_1.color.r, 0.5, var_297_3)

								iter_297_1.color = Color.New(var_297_7, var_297_7, var_297_7)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps1034 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_297_3 then
						if arg_294_1.isInRecall_ then
							iter_297_3.color = arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_297_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_294_1.var_.actorSpriteComps1034 = nil
			end

			local var_297_8 = 1.3

			if var_297_8 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.fswbg_:SetActive(false)
				arg_294_1.dialog_:SetActive(false)
				SetActive(arg_294_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_294_1:ShowNextGo(false)
			end

			local var_297_9 = 1.334

			if var_297_9 < arg_294_1.time_ and arg_294_1.time_ <= var_297_9 + arg_297_0 then
				arg_294_1.fswbg_:SetActive(false)
				arg_294_1.dialog_:SetActive(false)
				SetActive(arg_294_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_294_1:ShowNextGo(false)
			end

			local var_297_10 = 0

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_11 = 1.3

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_11 then
				local var_297_12 = (arg_294_1.time_ - var_297_10) / var_297_11
				local var_297_13 = Color.New(0, 0, 0)

				var_297_13.a = Mathf.Lerp(0, 1, var_297_12)
				arg_294_1.mask_.color = var_297_13
			end

			if arg_294_1.time_ >= var_297_10 + var_297_11 and arg_294_1.time_ < var_297_10 + var_297_11 + arg_297_0 then
				local var_297_14 = Color.New(0, 0, 0)

				var_297_14.a = 1
				arg_294_1.mask_.color = var_297_14
			end

			local var_297_15 = 1.3

			if var_297_15 < arg_294_1.time_ and arg_294_1.time_ <= var_297_15 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_16 = 2

			if var_297_15 <= arg_294_1.time_ and arg_294_1.time_ < var_297_15 + var_297_16 then
				local var_297_17 = (arg_294_1.time_ - var_297_15) / var_297_16
				local var_297_18 = Color.New(0, 0, 0)

				var_297_18.a = Mathf.Lerp(1, 0, var_297_17)
				arg_294_1.mask_.color = var_297_18
			end

			if arg_294_1.time_ >= var_297_15 + var_297_16 and arg_294_1.time_ < var_297_15 + var_297_16 + arg_297_0 then
				local var_297_19 = Color.New(0, 0, 0)
				local var_297_20 = 0

				arg_294_1.mask_.enabled = false
				var_297_19.a = var_297_20
				arg_294_1.mask_.color = var_297_19
			end

			local var_297_21 = 1.3

			if var_297_21 < arg_294_1.time_ and arg_294_1.time_ <= var_297_21 + arg_297_0 then
				local var_297_22 = manager.ui.mainCamera.transform.localPosition
				local var_297_23 = Vector3.New(0, 0, 10) + Vector3.New(var_297_22.x, var_297_22.y, 0)
				local var_297_24 = arg_294_1.bgs_.ST69

				var_297_24.transform.localPosition = var_297_23
				var_297_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_25 = var_297_24:GetComponent("SpriteRenderer")

				if var_297_25 and var_297_25.sprite then
					local var_297_26 = (var_297_24.transform.localPosition - var_297_22).z
					local var_297_27 = manager.ui.mainCameraCom_
					local var_297_28 = 2 * var_297_26 * Mathf.Tan(var_297_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_297_29 = var_297_28 * var_297_27.aspect
					local var_297_30 = var_297_25.sprite.bounds.size.x
					local var_297_31 = var_297_25.sprite.bounds.size.y
					local var_297_32 = var_297_29 / var_297_30
					local var_297_33 = var_297_28 / var_297_31
					local var_297_34 = var_297_33 < var_297_32 and var_297_32 or var_297_33

					var_297_24.transform.localScale = Vector3.New(var_297_34, var_297_34, 0)
				end

				for iter_297_4, iter_297_5 in pairs(arg_294_1.bgs_) do
					if iter_297_4 ~= "ST69" then
						iter_297_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_35 = 1.3

			if var_297_35 < arg_294_1.time_ and arg_294_1.time_ <= var_297_35 + arg_297_0 then
				arg_294_1.cswbg_:SetActive(false)
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_36 = 3.3
			local var_297_37 = 1.475

			if var_297_36 < arg_294_1.time_ and arg_294_1.time_ <= var_297_36 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_38 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_38:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_39 = arg_294_1:GetWordFromCfg(417091070)
				local var_297_40 = arg_294_1:FormatText(var_297_39.content)

				arg_294_1.text_.text = var_297_40

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_41 = 59
				local var_297_42 = utf8.len(var_297_40)
				local var_297_43 = var_297_41 <= 0 and var_297_37 or var_297_37 * (var_297_42 / var_297_41)

				if var_297_43 > 0 and var_297_37 < var_297_43 then
					arg_294_1.talkMaxDuration = var_297_43
					var_297_36 = var_297_36 + 0.3

					if var_297_43 + var_297_36 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_43 + var_297_36
					end
				end

				arg_294_1.text_.text = var_297_40
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_44 = var_297_36 + 0.3
			local var_297_45 = math.max(var_297_37, arg_294_1.talkMaxDuration)

			if var_297_44 <= arg_294_1.time_ and arg_294_1.time_ < var_297_44 + var_297_45 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_44) / var_297_45

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_44 + var_297_45 and arg_294_1.time_ < var_297_44 + var_297_45 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play417091071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 417091071
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play417091072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 1.13333333333333
			local var_303_1 = 1

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				local var_303_2 = "play"
				local var_303_3 = "effect"

				arg_300_1:AudioAction(var_303_2, var_303_3, "se_story_129", "se_story_129_alarm", "")
			end

			local var_303_4 = 0
			local var_303_5 = 1.55

			if var_303_4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_6 = arg_300_1:GetWordFromCfg(417091071)
				local var_303_7 = arg_300_1:FormatText(var_303_6.content)

				arg_300_1.text_.text = var_303_7

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_8 = 62
				local var_303_9 = utf8.len(var_303_7)
				local var_303_10 = var_303_8 <= 0 and var_303_5 or var_303_5 * (var_303_9 / var_303_8)

				if var_303_10 > 0 and var_303_5 < var_303_10 then
					arg_300_1.talkMaxDuration = var_303_10

					if var_303_10 + var_303_4 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_4
					end
				end

				arg_300_1.text_.text = var_303_7
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_11 = math.max(var_303_5, arg_300_1.talkMaxDuration)

			if var_303_4 <= arg_300_1.time_ and arg_300_1.time_ < var_303_4 + var_303_11 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_4) / var_303_11

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_4 + var_303_11 and arg_300_1.time_ < var_303_4 + var_303_11 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play417091072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 417091072
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play417091073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.325

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_2 = arg_304_1:GetWordFromCfg(417091072)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 53
				local var_307_5 = utf8.len(var_307_3)
				local var_307_6 = var_307_4 <= 0 and var_307_1 or var_307_1 * (var_307_5 / var_307_4)

				if var_307_6 > 0 and var_307_1 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_7 and arg_304_1.time_ < var_307_0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play417091073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 417091073
		arg_308_1.duration_ = 4.7

		local var_308_0 = {
			zh = 2.566,
			ja = 4.7
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play417091074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1034"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps1034 == nil then
				arg_308_1.var_.actorSpriteComps1034 = var_311_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_2 = 0.2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.actorSpriteComps1034 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								local var_311_4 = Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, var_311_3)
								local var_311_5 = Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, var_311_3)
								local var_311_6 = Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, var_311_3)

								iter_311_1.color = Color.New(var_311_4, var_311_5, var_311_6)
							else
								local var_311_7 = Mathf.Lerp(iter_311_1.color.r, 1, var_311_3)

								iter_311_1.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.actorSpriteComps1034 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_311_3 then
						if arg_308_1.isInRecall_ then
							iter_311_3.color = arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_311_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_308_1.var_.actorSpriteComps1034 = nil
			end

			local var_311_8 = arg_308_1.actors_["1034"].transform
			local var_311_9 = 0

			if var_311_9 < arg_308_1.time_ and arg_308_1.time_ <= var_311_9 + arg_311_0 then
				arg_308_1.var_.moveOldPos1034 = var_311_8.localPosition
				var_311_8.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("1034", 3)

				local var_311_10 = var_311_8.childCount

				for iter_311_4 = 0, var_311_10 - 1 do
					local var_311_11 = var_311_8:GetChild(iter_311_4)

					if var_311_11.name == "split_6" or not string.find(var_311_11.name, "split") then
						var_311_11.gameObject:SetActive(true)
					else
						var_311_11.gameObject:SetActive(false)
					end
				end
			end

			local var_311_12 = 0.001

			if var_311_9 <= arg_308_1.time_ and arg_308_1.time_ < var_311_9 + var_311_12 then
				local var_311_13 = (arg_308_1.time_ - var_311_9) / var_311_12
				local var_311_14 = Vector3.New(0, -331.9, -324)

				var_311_8.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1034, var_311_14, var_311_13)
			end

			if arg_308_1.time_ >= var_311_9 + var_311_12 and arg_308_1.time_ < var_311_9 + var_311_12 + arg_311_0 then
				var_311_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_311_15 = 0
			local var_311_16 = 0.3

			if var_311_15 < arg_308_1.time_ and arg_308_1.time_ <= var_311_15 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_17 = arg_308_1:FormatText(StoryNameCfg[1109].name)

				arg_308_1.leftNameTxt_.text = var_311_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_18 = arg_308_1:GetWordFromCfg(417091073)
				local var_311_19 = arg_308_1:FormatText(var_311_18.content)

				arg_308_1.text_.text = var_311_19

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_20 = 12
				local var_311_21 = utf8.len(var_311_19)
				local var_311_22 = var_311_20 <= 0 and var_311_16 or var_311_16 * (var_311_21 / var_311_20)

				if var_311_22 > 0 and var_311_16 < var_311_22 then
					arg_308_1.talkMaxDuration = var_311_22

					if var_311_22 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_22 + var_311_15
					end
				end

				arg_308_1.text_.text = var_311_19
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091073", "story_v_out_417091.awb") ~= 0 then
					local var_311_23 = manager.audio:GetVoiceLength("story_v_out_417091", "417091073", "story_v_out_417091.awb") / 1000

					if var_311_23 + var_311_15 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_23 + var_311_15
					end

					if var_311_18.prefab_name ~= "" and arg_308_1.actors_[var_311_18.prefab_name] ~= nil then
						local var_311_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_18.prefab_name].transform, "story_v_out_417091", "417091073", "story_v_out_417091.awb")

						arg_308_1:RecordAudio("417091073", var_311_24)
						arg_308_1:RecordAudio("417091073", var_311_24)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_417091", "417091073", "story_v_out_417091.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_417091", "417091073", "story_v_out_417091.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_25 = math.max(var_311_16, arg_308_1.talkMaxDuration)

			if var_311_15 <= arg_308_1.time_ and arg_308_1.time_ < var_311_15 + var_311_25 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_15) / var_311_25

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_15 + var_311_25 and arg_308_1.time_ < var_311_15 + var_311_25 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
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

		arg_308_1:InitPlayNodeList()
	end,
	Play417091074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 417091074
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play417091075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1034"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1034 == nil then
				arg_312_1.var_.actorSpriteComps1034 = var_315_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_2 = 0.2

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.actorSpriteComps1034 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								local var_315_4 = Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor2.r, var_315_3)
								local var_315_5 = Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor2.g, var_315_3)
								local var_315_6 = Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor2.b, var_315_3)

								iter_315_1.color = Color.New(var_315_4, var_315_5, var_315_6)
							else
								local var_315_7 = Mathf.Lerp(iter_315_1.color.r, 0.5, var_315_3)

								iter_315_1.color = Color.New(var_315_7, var_315_7, var_315_7)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.actorSpriteComps1034 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_315_3 then
						if arg_312_1.isInRecall_ then
							iter_315_3.color = arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_315_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_312_1.var_.actorSpriteComps1034 = nil
			end

			local var_315_8 = arg_312_1.actors_["1034"].transform
			local var_315_9 = 0

			if var_315_9 < arg_312_1.time_ and arg_312_1.time_ <= var_315_9 + arg_315_0 then
				arg_312_1.var_.moveOldPos1034 = var_315_8.localPosition
				var_315_8.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1034", 7)

				local var_315_10 = var_315_8.childCount

				for iter_315_4 = 0, var_315_10 - 1 do
					local var_315_11 = var_315_8:GetChild(iter_315_4)

					if var_315_11.name == "" or not string.find(var_315_11.name, "split") then
						var_315_11.gameObject:SetActive(true)
					else
						var_315_11.gameObject:SetActive(false)
					end
				end
			end

			local var_315_12 = 0.001

			if var_315_9 <= arg_312_1.time_ and arg_312_1.time_ < var_315_9 + var_315_12 then
				local var_315_13 = (arg_312_1.time_ - var_315_9) / var_315_12
				local var_315_14 = Vector3.New(0, -2000, 0)

				var_315_8.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1034, var_315_14, var_315_13)
			end

			if arg_312_1.time_ >= var_315_9 + var_315_12 and arg_312_1.time_ < var_315_9 + var_315_12 + arg_315_0 then
				var_315_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_315_15 = 0.05
			local var_315_16 = 1

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				local var_315_17 = "play"
				local var_315_18 = "effect"

				arg_312_1:AudioAction(var_315_17, var_315_18, "se_story_1310", "se_story_1310_keyboard", "")
			end

			local var_315_19 = 0
			local var_315_20 = 0.925

			if var_315_19 < arg_312_1.time_ and arg_312_1.time_ <= var_315_19 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_21 = arg_312_1:GetWordFromCfg(417091074)
				local var_315_22 = arg_312_1:FormatText(var_315_21.content)

				arg_312_1.text_.text = var_315_22

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_23 = 37
				local var_315_24 = utf8.len(var_315_22)
				local var_315_25 = var_315_23 <= 0 and var_315_20 or var_315_20 * (var_315_24 / var_315_23)

				if var_315_25 > 0 and var_315_20 < var_315_25 then
					arg_312_1.talkMaxDuration = var_315_25

					if var_315_25 + var_315_19 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_25 + var_315_19
					end
				end

				arg_312_1.text_.text = var_315_22
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_26 = math.max(var_315_20, arg_312_1.talkMaxDuration)

			if var_315_19 <= arg_312_1.time_ and arg_312_1.time_ < var_315_19 + var_315_26 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_19) / var_315_26

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_19 + var_315_26 and arg_312_1.time_ < var_315_19 + var_315_26 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
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

		arg_312_1:InitPlayNodeList()
	end,
	Play417091075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 417091075
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play417091076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 1.375

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_2 = arg_316_1:GetWordFromCfg(417091075)
				local var_319_3 = arg_316_1:FormatText(var_319_2.content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 55
				local var_319_5 = utf8.len(var_319_3)
				local var_319_6 = var_319_4 <= 0 and var_319_1 or var_319_1 * (var_319_5 / var_319_4)

				if var_319_6 > 0 and var_319_1 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_7 and arg_316_1.time_ < var_319_0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play417091076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 417091076
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play417091077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.324999999999
			local var_323_1 = 1

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				local var_323_2 = "play"
				local var_323_3 = "effect"

				arg_320_1:AudioAction(var_323_2, var_323_3, "se_story_1310", "se_story_1310_logout", "")
			end

			local var_323_4 = 0
			local var_323_5 = 1.325

			if var_323_4 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_6 = arg_320_1:GetWordFromCfg(417091076)
				local var_323_7 = arg_320_1:FormatText(var_323_6.content)

				arg_320_1.text_.text = var_323_7

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_8 = 53
				local var_323_9 = utf8.len(var_323_7)
				local var_323_10 = var_323_8 <= 0 and var_323_5 or var_323_5 * (var_323_9 / var_323_8)

				if var_323_10 > 0 and var_323_5 < var_323_10 then
					arg_320_1.talkMaxDuration = var_323_10

					if var_323_10 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_10 + var_323_4
					end
				end

				arg_320_1.text_.text = var_323_7
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_11 = math.max(var_323_5, arg_320_1.talkMaxDuration)

			if var_323_4 <= arg_320_1.time_ and arg_320_1.time_ < var_323_4 + var_323_11 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_4) / var_323_11

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_4 + var_323_11 and arg_320_1.time_ < var_323_4 + var_323_11 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play417091077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 417091077
		arg_324_1.duration_ = 6.63

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play417091078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 1.3

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.cswbg_:SetActive(true)

				local var_327_1 = arg_324_1.cswt_:GetComponent("RectTransform")

				arg_324_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_327_1.offsetMin = Vector2.New(400, 105)
				var_327_1.offsetMax = Vector2.New(-400, -200)

				local var_327_2 = arg_324_1:GetWordFromCfg(419103)
				local var_327_3 = arg_324_1:FormatText(var_327_2.content)

				arg_324_1.cswt_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.cswt_)

				arg_324_1.cswt_.fontSize = 120
				arg_324_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_324_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_324_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_327_4 = 1.3

			if var_327_4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				local var_327_5 = arg_324_1.fswbg_.transform:Find("textbox/adapt/content") or arg_324_1.fswbg_.transform:Find("textbox/content")
				local var_327_6 = arg_324_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_327_7 = var_327_5:GetComponent("Text")
				local var_327_8 = var_327_5:GetComponent("RectTransform")

				var_327_7.alignment = UnityEngine.TextAnchor.LowerCenter
				var_327_8.offsetMin = Vector2.New(0, 0)
				var_327_8.offsetMax = Vector2.New(0, 0)
			end

			local var_327_9 = 1.3

			if var_327_9 < arg_324_1.time_ and arg_324_1.time_ <= var_327_9 + arg_327_0 then
				arg_324_1.fswbg_:SetActive(true)
				arg_324_1.dialog_:SetActive(false)

				arg_324_1.fswtw_.percent = 0

				local var_327_10 = arg_324_1:GetWordFromCfg(417091077)
				local var_327_11 = arg_324_1:FormatText(var_327_10.content)

				arg_324_1.fswt_.text = var_327_11

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.fswt_)

				arg_324_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_324_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_324_1.fswtw_:SetDirty()

				arg_324_1.typewritterCharCountI18N = 0

				SetActive(arg_324_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_324_1:ShowNextGo(false)
			end

			local var_327_12 = 2.3

			if var_327_12 < arg_324_1.time_ and arg_324_1.time_ <= var_327_12 + arg_327_0 then
				arg_324_1.var_.oldValueTypewriter = arg_324_1.fswtw_.percent

				SetActive(arg_324_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_324_1:ShowNextGo(false)
			end

			local var_327_13 = 30
			local var_327_14 = 2
			local var_327_15 = arg_324_1:GetWordFromCfg(417091077)
			local var_327_16 = arg_324_1:FormatText(var_327_15.content)
			local var_327_17, var_327_18 = arg_324_1:GetPercentByPara(var_327_16, 1)

			if var_327_12 < arg_324_1.time_ and arg_324_1.time_ <= var_327_12 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0

				local var_327_19 = var_327_13 <= 0 and var_327_14 or var_327_14 * ((var_327_18 - arg_324_1.typewritterCharCountI18N) / var_327_13)

				if var_327_19 > 0 and var_327_14 < var_327_19 then
					arg_324_1.talkMaxDuration = var_327_19

					if var_327_19 + var_327_12 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_19 + var_327_12
					end
				end
			end

			local var_327_20 = 2
			local var_327_21 = math.max(var_327_20, arg_324_1.talkMaxDuration)

			if var_327_12 <= arg_324_1.time_ and arg_324_1.time_ < var_327_12 + var_327_21 then
				local var_327_22 = (arg_324_1.time_ - var_327_12) / var_327_21

				arg_324_1.fswtw_.percent = Mathf.Lerp(arg_324_1.var_.oldValueTypewriter, var_327_17, var_327_22)
				arg_324_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_324_1.fswtw_:SetDirty()
			end

			if arg_324_1.time_ >= var_327_12 + var_327_21 and arg_324_1.time_ < var_327_12 + var_327_21 + arg_327_0 then
				arg_324_1.fswtw_.percent = var_327_17

				arg_324_1.fswtw_:SetDirty()
				arg_324_1:ShowNextGo(true)

				arg_324_1.typewritterCharCountI18N = var_327_18
			end

			local var_327_23 = 0

			if var_327_23 < arg_324_1.time_ and arg_324_1.time_ <= var_327_23 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_24 = 1.3

			if var_327_23 <= arg_324_1.time_ and arg_324_1.time_ < var_327_23 + var_327_24 then
				local var_327_25 = (arg_324_1.time_ - var_327_23) / var_327_24
				local var_327_26 = Color.New(0, 0, 0)

				var_327_26.a = Mathf.Lerp(0, 1, var_327_25)
				arg_324_1.mask_.color = var_327_26
			end

			if arg_324_1.time_ >= var_327_23 + var_327_24 and arg_324_1.time_ < var_327_23 + var_327_24 + arg_327_0 then
				local var_327_27 = Color.New(0, 0, 0)

				var_327_27.a = 1
				arg_324_1.mask_.color = var_327_27
			end

			local var_327_28 = 1.3

			if var_327_28 < arg_324_1.time_ and arg_324_1.time_ <= var_327_28 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_29 = 2

			if var_327_28 <= arg_324_1.time_ and arg_324_1.time_ < var_327_28 + var_327_29 then
				local var_327_30 = (arg_324_1.time_ - var_327_28) / var_327_29
				local var_327_31 = Color.New(0, 0, 0)

				var_327_31.a = Mathf.Lerp(1, 0, var_327_30)
				arg_324_1.mask_.color = var_327_31
			end

			if arg_324_1.time_ >= var_327_28 + var_327_29 and arg_324_1.time_ < var_327_28 + var_327_29 + arg_327_0 then
				local var_327_32 = Color.New(0, 0, 0)
				local var_327_33 = 0

				arg_324_1.mask_.enabled = false
				var_327_32.a = var_327_33
				arg_324_1.mask_.color = var_327_32
			end

			local var_327_34 = 1.3

			if var_327_34 < arg_324_1.time_ and arg_324_1.time_ <= var_327_34 + arg_327_0 then
				local var_327_35 = manager.ui.mainCamera.transform.localPosition
				local var_327_36 = Vector3.New(0, 0, 10) + Vector3.New(var_327_35.x, var_327_35.y, 0)
				local var_327_37 = arg_324_1.bgs_.STblack

				var_327_37.transform.localPosition = var_327_36
				var_327_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_327_38 = var_327_37:GetComponent("SpriteRenderer")

				if var_327_38 and var_327_38.sprite then
					local var_327_39 = (var_327_37.transform.localPosition - var_327_35).z
					local var_327_40 = manager.ui.mainCameraCom_
					local var_327_41 = 2 * var_327_39 * Mathf.Tan(var_327_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_327_42 = var_327_41 * var_327_40.aspect
					local var_327_43 = var_327_38.sprite.bounds.size.x
					local var_327_44 = var_327_38.sprite.bounds.size.y
					local var_327_45 = var_327_42 / var_327_43
					local var_327_46 = var_327_41 / var_327_44
					local var_327_47 = var_327_46 < var_327_45 and var_327_45 or var_327_46

					var_327_37.transform.localScale = Vector3.New(var_327_47, var_327_47, 0)
				end

				for iter_327_0, iter_327_1 in pairs(arg_324_1.bgs_) do
					if iter_327_0 ~= "STblack" then
						iter_327_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_327_48 = 2.3
			local var_327_49 = 4.333
			local var_327_50 = manager.audio:GetVoiceLength("story_v_out_417091", "417091077", "") / 1000

			if var_327_50 > 0 and var_327_49 < var_327_50 and var_327_50 + var_327_48 > arg_324_1.duration_ then
				local var_327_51 = var_327_50

				arg_324_1.duration_ = var_327_50 + var_327_48
			end

			if var_327_48 < arg_324_1.time_ and arg_324_1.time_ <= var_327_48 + arg_327_0 then
				local var_327_52 = "play"
				local var_327_53 = "voice"

				arg_324_1:AudioAction(var_327_52, var_327_53, "story_v_out_417091", "417091077", "")
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play417091078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 417091078
		arg_328_1.duration_ = 5.07

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play417091079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.fswbg_:SetActive(true)
				arg_328_1.dialog_:SetActive(false)

				arg_328_1.fswtw_.percent = 0

				local var_331_1 = arg_328_1:GetWordFromCfg(417091078)
				local var_331_2 = arg_328_1:FormatText(var_331_1.content)

				arg_328_1.fswt_.text = var_331_2

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.fswt_)

				arg_328_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_328_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_328_1.fswtw_:SetDirty()

				arg_328_1.typewritterCharCountI18N = 0

				SetActive(arg_328_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_328_1:ShowNextGo(false)
			end

			local var_331_3 = 0.733333333333333

			if var_331_3 < arg_328_1.time_ and arg_328_1.time_ <= var_331_3 + arg_331_0 then
				arg_328_1.var_.oldValueTypewriter = arg_328_1.fswtw_.percent

				SetActive(arg_328_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_328_1:ShowNextGo(false)
			end

			local var_331_4 = 9
			local var_331_5 = 0.6
			local var_331_6 = arg_328_1:GetWordFromCfg(417091078)
			local var_331_7 = arg_328_1:FormatText(var_331_6.content)
			local var_331_8, var_331_9 = arg_328_1:GetPercentByPara(var_331_7, 1)

			if var_331_3 < arg_328_1.time_ and arg_328_1.time_ <= var_331_3 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0

				local var_331_10 = var_331_4 <= 0 and var_331_5 or var_331_5 * ((var_331_9 - arg_328_1.typewritterCharCountI18N) / var_331_4)

				if var_331_10 > 0 and var_331_5 < var_331_10 then
					arg_328_1.talkMaxDuration = var_331_10

					if var_331_10 + var_331_3 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_3
					end
				end
			end

			local var_331_11 = 0.6
			local var_331_12 = math.max(var_331_11, arg_328_1.talkMaxDuration)

			if var_331_3 <= arg_328_1.time_ and arg_328_1.time_ < var_331_3 + var_331_12 then
				local var_331_13 = (arg_328_1.time_ - var_331_3) / var_331_12

				arg_328_1.fswtw_.percent = Mathf.Lerp(arg_328_1.var_.oldValueTypewriter, var_331_8, var_331_13)
				arg_328_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_328_1.fswtw_:SetDirty()
			end

			if arg_328_1.time_ >= var_331_3 + var_331_12 and arg_328_1.time_ < var_331_3 + var_331_12 + arg_331_0 then
				arg_328_1.fswtw_.percent = var_331_8

				arg_328_1.fswtw_:SetDirty()
				arg_328_1:ShowNextGo(true)

				arg_328_1.typewritterCharCountI18N = var_331_9
			end

			local var_331_14 = 0.733333333333333
			local var_331_15 = 4.333
			local var_331_16 = manager.audio:GetVoiceLength("story_v_out_417091", "417091078", "") / 1000

			if var_331_16 > 0 and var_331_15 < var_331_16 and var_331_16 + var_331_14 > arg_328_1.duration_ then
				local var_331_17 = var_331_16

				arg_328_1.duration_ = var_331_16 + var_331_14
			end

			if var_331_14 < arg_328_1.time_ and arg_328_1.time_ <= var_331_14 + arg_331_0 then
				local var_331_18 = "play"
				local var_331_19 = "voice"

				arg_328_1:AudioAction(var_331_18, var_331_19, "story_v_out_417091", "417091078", "")
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play417091079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 417091079
		arg_332_1.duration_ = 12.1

		local var_332_0 = {
			zh = 10.5,
			ja = 12.1
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play417091080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 1.3

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				local var_335_1 = manager.ui.mainCamera.transform.localPosition
				local var_335_2 = Vector3.New(0, 0, 10) + Vector3.New(var_335_1.x, var_335_1.y, 0)
				local var_335_3 = arg_332_1.bgs_.I07a

				var_335_3.transform.localPosition = var_335_2
				var_335_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_335_4 = var_335_3:GetComponent("SpriteRenderer")

				if var_335_4 and var_335_4.sprite then
					local var_335_5 = (var_335_3.transform.localPosition - var_335_1).z
					local var_335_6 = manager.ui.mainCameraCom_
					local var_335_7 = 2 * var_335_5 * Mathf.Tan(var_335_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_335_8 = var_335_7 * var_335_6.aspect
					local var_335_9 = var_335_4.sprite.bounds.size.x
					local var_335_10 = var_335_4.sprite.bounds.size.y
					local var_335_11 = var_335_8 / var_335_9
					local var_335_12 = var_335_7 / var_335_10
					local var_335_13 = var_335_12 < var_335_11 and var_335_11 or var_335_12

					var_335_3.transform.localScale = Vector3.New(var_335_13, var_335_13, 0)
				end

				for iter_335_0, iter_335_1 in pairs(arg_332_1.bgs_) do
					if iter_335_0 ~= "I07a" then
						iter_335_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_335_14 = 1.3

			if var_335_14 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1.fswbg_:SetActive(false)
				arg_332_1.dialog_:SetActive(false)
				SetActive(arg_332_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_332_1:ShowNextGo(false)
			end

			local var_335_15 = 1.334

			if var_335_15 < arg_332_1.time_ and arg_332_1.time_ <= var_335_15 + arg_335_0 then
				arg_332_1.fswbg_:SetActive(false)
				arg_332_1.dialog_:SetActive(false)
				SetActive(arg_332_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_332_1:ShowNextGo(false)
			end

			local var_335_16 = 0

			if var_335_16 < arg_332_1.time_ and arg_332_1.time_ <= var_335_16 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_17 = 1.3

			if var_335_16 <= arg_332_1.time_ and arg_332_1.time_ < var_335_16 + var_335_17 then
				local var_335_18 = (arg_332_1.time_ - var_335_16) / var_335_17
				local var_335_19 = Color.New(0, 0, 0)

				var_335_19.a = Mathf.Lerp(0, 1, var_335_18)
				arg_332_1.mask_.color = var_335_19
			end

			if arg_332_1.time_ >= var_335_16 + var_335_17 and arg_332_1.time_ < var_335_16 + var_335_17 + arg_335_0 then
				local var_335_20 = Color.New(0, 0, 0)

				var_335_20.a = 1
				arg_332_1.mask_.color = var_335_20
			end

			local var_335_21 = 1.3

			if var_335_21 < arg_332_1.time_ and arg_332_1.time_ <= var_335_21 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_22 = 2

			if var_335_21 <= arg_332_1.time_ and arg_332_1.time_ < var_335_21 + var_335_22 then
				local var_335_23 = (arg_332_1.time_ - var_335_21) / var_335_22
				local var_335_24 = Color.New(0, 0, 0)

				var_335_24.a = Mathf.Lerp(1, 0, var_335_23)
				arg_332_1.mask_.color = var_335_24
			end

			if arg_332_1.time_ >= var_335_21 + var_335_22 and arg_332_1.time_ < var_335_21 + var_335_22 + arg_335_0 then
				local var_335_25 = Color.New(0, 0, 0)
				local var_335_26 = 0

				arg_332_1.mask_.enabled = false
				var_335_25.a = var_335_26
				arg_332_1.mask_.color = var_335_25
			end

			local var_335_27 = 1.3

			if var_335_27 < arg_332_1.time_ and arg_332_1.time_ <= var_335_27 + arg_335_0 then
				arg_332_1.cswbg_:SetActive(false)
			end

			local var_335_28 = 0
			local var_335_29 = 0.2

			if var_335_28 < arg_332_1.time_ and arg_332_1.time_ <= var_335_28 + arg_335_0 then
				local var_335_30 = "play"
				local var_335_31 = "music"

				arg_332_1:AudioAction(var_335_30, var_335_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_335_32 = ""
				local var_335_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_335_33 ~= "" then
					if arg_332_1.bgmTxt_.text ~= var_335_33 and arg_332_1.bgmTxt_.text ~= "" then
						if arg_332_1.bgmTxt2_.text ~= "" then
							arg_332_1.bgmTxt_.text = arg_332_1.bgmTxt2_.text
						end

						arg_332_1.bgmTxt2_.text = var_335_33

						arg_332_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_332_1.bgmTxt_.text = var_335_33
						arg_332_1.bgmTxt2_.text = var_335_33
					end

					if arg_332_1.bgmTimer then
						arg_332_1.bgmTimer:Stop()

						arg_332_1.bgmTimer = nil
					end

					if arg_332_1.settingData.show_music_name == 1 then
						arg_332_1.musicController:SetSelectedState("show")
						arg_332_1.musicAnimator_:Play("open", 0, 0)

						if arg_332_1.settingData.music_time ~= 0 then
							arg_332_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_332_1.settingData.music_time), function()
								if arg_332_1 == nil or isNil(arg_332_1.bgmTxt_) then
									return
								end

								arg_332_1.musicController:SetSelectedState("hide")
								arg_332_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_335_34 = 1.1
			local var_335_35 = 1

			if var_335_34 < arg_332_1.time_ and arg_332_1.time_ <= var_335_34 + arg_335_0 then
				local var_335_36 = "play"
				local var_335_37 = "music"

				arg_332_1:AudioAction(var_335_36, var_335_37, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_335_38 = ""
				local var_335_39 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if var_335_39 ~= "" then
					if arg_332_1.bgmTxt_.text ~= var_335_39 and arg_332_1.bgmTxt_.text ~= "" then
						if arg_332_1.bgmTxt2_.text ~= "" then
							arg_332_1.bgmTxt_.text = arg_332_1.bgmTxt2_.text
						end

						arg_332_1.bgmTxt2_.text = var_335_39

						arg_332_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_332_1.bgmTxt_.text = var_335_39
						arg_332_1.bgmTxt2_.text = var_335_39
					end

					if arg_332_1.bgmTimer then
						arg_332_1.bgmTimer:Stop()

						arg_332_1.bgmTimer = nil
					end

					if arg_332_1.settingData.show_music_name == 1 then
						arg_332_1.musicController:SetSelectedState("show")
						arg_332_1.musicAnimator_:Play("open", 0, 0)

						if arg_332_1.settingData.music_time ~= 0 then
							arg_332_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_332_1.settingData.music_time), function()
								if arg_332_1 == nil or isNil(arg_332_1.bgmTxt_) then
									return
								end

								arg_332_1.musicController:SetSelectedState("hide")
								arg_332_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_335_40 = 1.3

			arg_332_1.isInRecall_ = true

			if var_335_40 < arg_332_1.time_ and arg_332_1.time_ <= var_335_40 + arg_335_0 then
				arg_332_1.screenFilterGo_:SetActive(true)

				arg_332_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")
				arg_332_1.hightColor1 = Color.New(0.8980392, 0.8980392, 0.8980392)
				arg_332_1.hightColor2 = Color.New(0.3411765, 0.3411765, 0.3411765)

				for iter_335_2, iter_335_3 in pairs(arg_332_1.actors_) do
					local var_335_41 = iter_335_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_335_4, iter_335_5 in ipairs(var_335_41) do
						if iter_335_5.color.r > 0.51 then
							iter_335_5.color = Color.New(0.8980392, 0.8980392, 0.8980392)
						else
							iter_335_5.color = Color.New(0.3411765, 0.3411765, 0.3411765)
						end
					end
				end
			end

			local var_335_42 = 0.1

			if var_335_40 <= arg_332_1.time_ and arg_332_1.time_ < var_335_40 + var_335_42 then
				local var_335_43 = (arg_332_1.time_ - var_335_40) / var_335_42

				arg_332_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_335_43)
			end

			if arg_332_1.time_ >= var_335_40 + var_335_42 and arg_332_1.time_ < var_335_40 + var_335_42 + arg_335_0 then
				arg_332_1.screenFilterEffect_.weight = 1
			end

			if arg_332_1.frameCnt_ <= 1 then
				arg_332_1.dialog_:SetActive(false)
			end

			local var_335_44 = 3.3
			local var_335_45 = 0.858333333333334

			if var_335_44 < arg_332_1.time_ and arg_332_1.time_ <= var_335_44 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0

				arg_332_1.dialog_:SetActive(true)

				arg_332_1.dialogCg_.alpha = 0

				local var_335_46 = LeanTween.value(arg_332_1.dialog_, 0, 1, 0.3)

				var_335_46:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_332_1.dialogCg_.alpha = arg_338_0
				end))
				var_335_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_332_1.dialog_)
					var_335_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_332_1.duration_ = arg_332_1.duration_ + 0.3

				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_47 = arg_332_1:FormatText(StoryNameCfg[1117].name)

				arg_332_1.leftNameTxt_.text = var_335_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_6")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_48 = arg_332_1:GetWordFromCfg(417091079)
				local var_335_49 = arg_332_1:FormatText(var_335_48.content)

				arg_332_1.text_.text = var_335_49

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_50 = 29
				local var_335_51 = utf8.len(var_335_49)
				local var_335_52 = var_335_50 <= 0 and var_335_45 or var_335_45 * (var_335_51 / var_335_50)

				if var_335_52 > 0 and var_335_45 < var_335_52 then
					arg_332_1.talkMaxDuration = var_335_52
					var_335_44 = var_335_44 + 0.3

					if var_335_52 + var_335_44 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_52 + var_335_44
					end
				end

				arg_332_1.text_.text = var_335_49
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091079", "story_v_out_417091.awb") ~= 0 then
					local var_335_53 = manager.audio:GetVoiceLength("story_v_out_417091", "417091079", "story_v_out_417091.awb") / 1000

					if var_335_53 + var_335_44 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_53 + var_335_44
					end

					if var_335_48.prefab_name ~= "" and arg_332_1.actors_[var_335_48.prefab_name] ~= nil then
						local var_335_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_48.prefab_name].transform, "story_v_out_417091", "417091079", "story_v_out_417091.awb")

						arg_332_1:RecordAudio("417091079", var_335_54)
						arg_332_1:RecordAudio("417091079", var_335_54)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_417091", "417091079", "story_v_out_417091.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_417091", "417091079", "story_v_out_417091.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_55 = var_335_44 + 0.3
			local var_335_56 = math.max(var_335_45, arg_332_1.talkMaxDuration)

			if var_335_55 <= arg_332_1.time_ and arg_332_1.time_ < var_335_55 + var_335_56 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_55) / var_335_56

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_55 + var_335_56 and arg_332_1.time_ < var_335_55 + var_335_56 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play417091080 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 417091080
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play417091081(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["10113"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps10113 == nil then
				arg_340_1.var_.actorSpriteComps10113 = var_343_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_2 = 0.2

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.actorSpriteComps10113 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								local var_343_4 = Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor2.r, var_343_3)
								local var_343_5 = Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor2.g, var_343_3)
								local var_343_6 = Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor2.b, var_343_3)

								iter_343_1.color = Color.New(var_343_4, var_343_5, var_343_6)
							else
								local var_343_7 = Mathf.Lerp(iter_343_1.color.r, 0.5, var_343_3)

								iter_343_1.color = Color.New(var_343_7, var_343_7, var_343_7)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps10113 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_343_3 then
						if arg_340_1.isInRecall_ then
							iter_343_3.color = arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_343_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps10113 = nil
			end

			local var_343_8 = 0.05
			local var_343_9 = 1

			if var_343_8 < arg_340_1.time_ and arg_340_1.time_ <= var_343_8 + arg_343_0 then
				local var_343_10 = "play"
				local var_343_11 = "effect"

				arg_340_1:AudioAction(var_343_10, var_343_11, "se_story_1310", "se_story_1310_coffeecup", "")
			end

			local var_343_12 = 0
			local var_343_13 = 1.175

			if var_343_12 < arg_340_1.time_ and arg_340_1.time_ <= var_343_12 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_14 = arg_340_1:GetWordFromCfg(417091080)
				local var_343_15 = arg_340_1:FormatText(var_343_14.content)

				arg_340_1.text_.text = var_343_15

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_16 = 47
				local var_343_17 = utf8.len(var_343_15)
				local var_343_18 = var_343_16 <= 0 and var_343_13 or var_343_13 * (var_343_17 / var_343_16)

				if var_343_18 > 0 and var_343_13 < var_343_18 then
					arg_340_1.talkMaxDuration = var_343_18

					if var_343_18 + var_343_12 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_18 + var_343_12
					end
				end

				arg_340_1.text_.text = var_343_15
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_19 = math.max(var_343_13, arg_340_1.talkMaxDuration)

			if var_343_12 <= arg_340_1.time_ and arg_340_1.time_ < var_343_12 + var_343_19 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_12) / var_343_19

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_12 + var_343_19 and arg_340_1.time_ < var_343_12 + var_343_19 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play417091081 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 417091081
		arg_344_1.duration_ = 7.77

		local var_344_0 = {
			zh = 6.333,
			ja = 7.766
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play417091082(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1034"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.actorSpriteComps1034 == nil then
				arg_344_1.var_.actorSpriteComps1034 = var_347_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_2 = 0.2

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.actorSpriteComps1034 then
					for iter_347_0, iter_347_1 in pairs(arg_344_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_347_1 then
							if arg_344_1.isInRecall_ then
								local var_347_4 = Mathf.Lerp(iter_347_1.color.r, arg_344_1.hightColor1.r, var_347_3)
								local var_347_5 = Mathf.Lerp(iter_347_1.color.g, arg_344_1.hightColor1.g, var_347_3)
								local var_347_6 = Mathf.Lerp(iter_347_1.color.b, arg_344_1.hightColor1.b, var_347_3)

								iter_347_1.color = Color.New(var_347_4, var_347_5, var_347_6)
							else
								local var_347_7 = Mathf.Lerp(iter_347_1.color.r, 1, var_347_3)

								iter_347_1.color = Color.New(var_347_7, var_347_7, var_347_7)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.actorSpriteComps1034 then
				for iter_347_2, iter_347_3 in pairs(arg_344_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_347_3 then
						if arg_344_1.isInRecall_ then
							iter_347_3.color = arg_344_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_347_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_344_1.var_.actorSpriteComps1034 = nil
			end

			local var_347_8 = arg_344_1.actors_["10113"].transform
			local var_347_9 = 0

			if var_347_9 < arg_344_1.time_ and arg_344_1.time_ <= var_347_9 + arg_347_0 then
				arg_344_1.var_.moveOldPos10113 = var_347_8.localPosition
				var_347_8.localScale = Vector3.New(1, 1, 1)

				arg_344_1:CheckSpriteTmpPos("10113", 7)

				local var_347_10 = var_347_8.childCount

				for iter_347_4 = 0, var_347_10 - 1 do
					local var_347_11 = var_347_8:GetChild(iter_347_4)

					if var_347_11.name == "" or not string.find(var_347_11.name, "split") then
						var_347_11.gameObject:SetActive(true)
					else
						var_347_11.gameObject:SetActive(false)
					end
				end
			end

			local var_347_12 = 0.001

			if var_347_9 <= arg_344_1.time_ and arg_344_1.time_ < var_347_9 + var_347_12 then
				local var_347_13 = (arg_344_1.time_ - var_347_9) / var_347_12
				local var_347_14 = Vector3.New(0, -2000, 0)

				var_347_8.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10113, var_347_14, var_347_13)
			end

			if arg_344_1.time_ >= var_347_9 + var_347_12 and arg_344_1.time_ < var_347_9 + var_347_12 + arg_347_0 then
				var_347_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_347_15 = arg_344_1.actors_["1034"].transform
			local var_347_16 = 0

			if var_347_16 < arg_344_1.time_ and arg_344_1.time_ <= var_347_16 + arg_347_0 then
				arg_344_1.var_.moveOldPos1034 = var_347_15.localPosition
				var_347_15.localScale = Vector3.New(1, 1, 1)

				arg_344_1:CheckSpriteTmpPos("1034", 3)

				local var_347_17 = var_347_15.childCount

				for iter_347_5 = 0, var_347_17 - 1 do
					local var_347_18 = var_347_15:GetChild(iter_347_5)

					if var_347_18.name == "split_6" or not string.find(var_347_18.name, "split") then
						var_347_18.gameObject:SetActive(true)
					else
						var_347_18.gameObject:SetActive(false)
					end
				end
			end

			local var_347_19 = 0.001

			if var_347_16 <= arg_344_1.time_ and arg_344_1.time_ < var_347_16 + var_347_19 then
				local var_347_20 = (arg_344_1.time_ - var_347_16) / var_347_19
				local var_347_21 = Vector3.New(0, -331.9, -324)

				var_347_15.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1034, var_347_21, var_347_20)
			end

			if arg_344_1.time_ >= var_347_16 + var_347_19 and arg_344_1.time_ < var_347_16 + var_347_19 + arg_347_0 then
				var_347_15.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_347_22 = 0
			local var_347_23 = 0.525

			if var_347_22 < arg_344_1.time_ and arg_344_1.time_ <= var_347_22 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_24 = arg_344_1:FormatText(StoryNameCfg[1109].name)

				arg_344_1.leftNameTxt_.text = var_347_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_25 = arg_344_1:GetWordFromCfg(417091081)
				local var_347_26 = arg_344_1:FormatText(var_347_25.content)

				arg_344_1.text_.text = var_347_26

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_27 = 21
				local var_347_28 = utf8.len(var_347_26)
				local var_347_29 = var_347_27 <= 0 and var_347_23 or var_347_23 * (var_347_28 / var_347_27)

				if var_347_29 > 0 and var_347_23 < var_347_29 then
					arg_344_1.talkMaxDuration = var_347_29

					if var_347_29 + var_347_22 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_29 + var_347_22
					end
				end

				arg_344_1.text_.text = var_347_26
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091081", "story_v_out_417091.awb") ~= 0 then
					local var_347_30 = manager.audio:GetVoiceLength("story_v_out_417091", "417091081", "story_v_out_417091.awb") / 1000

					if var_347_30 + var_347_22 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_30 + var_347_22
					end

					if var_347_25.prefab_name ~= "" and arg_344_1.actors_[var_347_25.prefab_name] ~= nil then
						local var_347_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_25.prefab_name].transform, "story_v_out_417091", "417091081", "story_v_out_417091.awb")

						arg_344_1:RecordAudio("417091081", var_347_31)
						arg_344_1:RecordAudio("417091081", var_347_31)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_417091", "417091081", "story_v_out_417091.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_417091", "417091081", "story_v_out_417091.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_32 = math.max(var_347_23, arg_344_1.talkMaxDuration)

			if var_347_22 <= arg_344_1.time_ and arg_344_1.time_ < var_347_22 + var_347_32 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_22) / var_347_32

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_22 + var_347_32 and arg_344_1.time_ < var_347_22 + var_347_32 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
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
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play417091082 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 417091082
		arg_348_1.duration_ = 5.6

		local var_348_0 = {
			zh = 3.866,
			ja = 5.6
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play417091083(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.525

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[1109].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:GetWordFromCfg(417091082)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 21
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091082", "story_v_out_417091.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091082", "story_v_out_417091.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_417091", "417091082", "story_v_out_417091.awb")

						arg_348_1:RecordAudio("417091082", var_351_9)
						arg_348_1:RecordAudio("417091082", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_417091", "417091082", "story_v_out_417091.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_417091", "417091082", "story_v_out_417091.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play417091083 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 417091083
		arg_352_1.duration_ = 6.07

		local var_352_0 = {
			zh = 2.433,
			ja = 6.066
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play417091084(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["10113"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps10113 == nil then
				arg_352_1.var_.actorSpriteComps10113 = var_355_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_2 = 0.2

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.actorSpriteComps10113 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								local var_355_4 = Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, var_355_3)
								local var_355_5 = Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, var_355_3)
								local var_355_6 = Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, var_355_3)

								iter_355_1.color = Color.New(var_355_4, var_355_5, var_355_6)
							else
								local var_355_7 = Mathf.Lerp(iter_355_1.color.r, 1, var_355_3)

								iter_355_1.color = Color.New(var_355_7, var_355_7, var_355_7)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.actorSpriteComps10113 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_355_3 then
						if arg_352_1.isInRecall_ then
							iter_355_3.color = arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_355_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_352_1.var_.actorSpriteComps10113 = nil
			end

			local var_355_8 = arg_352_1.actors_["1034"]
			local var_355_9 = 0

			if var_355_9 < arg_352_1.time_ and arg_352_1.time_ <= var_355_9 + arg_355_0 and not isNil(var_355_8) and arg_352_1.var_.actorSpriteComps1034 == nil then
				arg_352_1.var_.actorSpriteComps1034 = var_355_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_10 = 0.2

			if var_355_9 <= arg_352_1.time_ and arg_352_1.time_ < var_355_9 + var_355_10 and not isNil(var_355_8) then
				local var_355_11 = (arg_352_1.time_ - var_355_9) / var_355_10

				if arg_352_1.var_.actorSpriteComps1034 then
					for iter_355_4, iter_355_5 in pairs(arg_352_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_355_5 then
							if arg_352_1.isInRecall_ then
								local var_355_12 = Mathf.Lerp(iter_355_5.color.r, arg_352_1.hightColor2.r, var_355_11)
								local var_355_13 = Mathf.Lerp(iter_355_5.color.g, arg_352_1.hightColor2.g, var_355_11)
								local var_355_14 = Mathf.Lerp(iter_355_5.color.b, arg_352_1.hightColor2.b, var_355_11)

								iter_355_5.color = Color.New(var_355_12, var_355_13, var_355_14)
							else
								local var_355_15 = Mathf.Lerp(iter_355_5.color.r, 0.5, var_355_11)

								iter_355_5.color = Color.New(var_355_15, var_355_15, var_355_15)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= var_355_9 + var_355_10 and arg_352_1.time_ < var_355_9 + var_355_10 + arg_355_0 and not isNil(var_355_8) and arg_352_1.var_.actorSpriteComps1034 then
				for iter_355_6, iter_355_7 in pairs(arg_352_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_355_7 then
						if arg_352_1.isInRecall_ then
							iter_355_7.color = arg_352_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_355_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_352_1.var_.actorSpriteComps1034 = nil
			end

			local var_355_16 = arg_352_1.actors_["10113"].transform
			local var_355_17 = 0

			if var_355_17 < arg_352_1.time_ and arg_352_1.time_ <= var_355_17 + arg_355_0 then
				arg_352_1.var_.moveOldPos10113 = var_355_16.localPosition
				var_355_16.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("10113", 3)

				local var_355_18 = var_355_16.childCount

				for iter_355_8 = 0, var_355_18 - 1 do
					local var_355_19 = var_355_16:GetChild(iter_355_8)

					if var_355_19.name == "" or not string.find(var_355_19.name, "split") then
						var_355_19.gameObject:SetActive(true)
					else
						var_355_19.gameObject:SetActive(false)
					end
				end
			end

			local var_355_20 = 0.001

			if var_355_17 <= arg_352_1.time_ and arg_352_1.time_ < var_355_17 + var_355_20 then
				local var_355_21 = (arg_352_1.time_ - var_355_17) / var_355_20
				local var_355_22 = Vector3.New(-30.38, -328.4, -517.4)

				var_355_16.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos10113, var_355_22, var_355_21)
			end

			if arg_352_1.time_ >= var_355_17 + var_355_20 and arg_352_1.time_ < var_355_17 + var_355_20 + arg_355_0 then
				var_355_16.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_355_23 = arg_352_1.actors_["1034"].transform
			local var_355_24 = 0

			if var_355_24 < arg_352_1.time_ and arg_352_1.time_ <= var_355_24 + arg_355_0 then
				arg_352_1.var_.moveOldPos1034 = var_355_23.localPosition
				var_355_23.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("1034", 7)

				local var_355_25 = var_355_23.childCount

				for iter_355_9 = 0, var_355_25 - 1 do
					local var_355_26 = var_355_23:GetChild(iter_355_9)

					if var_355_26.name == "" or not string.find(var_355_26.name, "split") then
						var_355_26.gameObject:SetActive(true)
					else
						var_355_26.gameObject:SetActive(false)
					end
				end
			end

			local var_355_27 = 0.001

			if var_355_24 <= arg_352_1.time_ and arg_352_1.time_ < var_355_24 + var_355_27 then
				local var_355_28 = (arg_352_1.time_ - var_355_24) / var_355_27
				local var_355_29 = Vector3.New(0, -2000, 0)

				var_355_23.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1034, var_355_29, var_355_28)
			end

			if arg_352_1.time_ >= var_355_24 + var_355_27 and arg_352_1.time_ < var_355_24 + var_355_27 + arg_355_0 then
				var_355_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_355_30 = 0
			local var_355_31 = 0.3

			if var_355_30 < arg_352_1.time_ and arg_352_1.time_ <= var_355_30 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_32 = arg_352_1:FormatText(StoryNameCfg[1117].name)

				arg_352_1.leftNameTxt_.text = var_355_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_33 = arg_352_1:GetWordFromCfg(417091083)
				local var_355_34 = arg_352_1:FormatText(var_355_33.content)

				arg_352_1.text_.text = var_355_34

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_35 = 12
				local var_355_36 = utf8.len(var_355_34)
				local var_355_37 = var_355_35 <= 0 and var_355_31 or var_355_31 * (var_355_36 / var_355_35)

				if var_355_37 > 0 and var_355_31 < var_355_37 then
					arg_352_1.talkMaxDuration = var_355_37

					if var_355_37 + var_355_30 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_37 + var_355_30
					end
				end

				arg_352_1.text_.text = var_355_34
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091083", "story_v_out_417091.awb") ~= 0 then
					local var_355_38 = manager.audio:GetVoiceLength("story_v_out_417091", "417091083", "story_v_out_417091.awb") / 1000

					if var_355_38 + var_355_30 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_38 + var_355_30
					end

					if var_355_33.prefab_name ~= "" and arg_352_1.actors_[var_355_33.prefab_name] ~= nil then
						local var_355_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_33.prefab_name].transform, "story_v_out_417091", "417091083", "story_v_out_417091.awb")

						arg_352_1:RecordAudio("417091083", var_355_39)
						arg_352_1:RecordAudio("417091083", var_355_39)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_417091", "417091083", "story_v_out_417091.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_417091", "417091083", "story_v_out_417091.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_40 = math.max(var_355_31, arg_352_1.talkMaxDuration)

			if var_355_30 <= arg_352_1.time_ and arg_352_1.time_ < var_355_30 + var_355_40 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_30) / var_355_40

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_30 + var_355_40 and arg_352_1.time_ < var_355_30 + var_355_40 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
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
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play417091084 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 417091084
		arg_356_1.duration_ = 8.03

		local var_356_0 = {
			zh = 6.5,
			ja = 8.033
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play417091085(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.85

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[1117].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:GetWordFromCfg(417091084)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 34
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091084", "story_v_out_417091.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_417091", "417091084", "story_v_out_417091.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_417091", "417091084", "story_v_out_417091.awb")

						arg_356_1:RecordAudio("417091084", var_359_9)
						arg_356_1:RecordAudio("417091084", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_417091", "417091084", "story_v_out_417091.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_417091", "417091084", "story_v_out_417091.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play417091085 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 417091085
		arg_360_1.duration_ = 3.3

		local var_360_0 = {
			zh = 1.333,
			ja = 3.3
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play417091086(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1034"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.actorSpriteComps1034 == nil then
				arg_360_1.var_.actorSpriteComps1034 = var_363_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_2 = 0.2

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.actorSpriteComps1034 then
					for iter_363_0, iter_363_1 in pairs(arg_360_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_363_1 then
							if arg_360_1.isInRecall_ then
								local var_363_4 = Mathf.Lerp(iter_363_1.color.r, arg_360_1.hightColor1.r, var_363_3)
								local var_363_5 = Mathf.Lerp(iter_363_1.color.g, arg_360_1.hightColor1.g, var_363_3)
								local var_363_6 = Mathf.Lerp(iter_363_1.color.b, arg_360_1.hightColor1.b, var_363_3)

								iter_363_1.color = Color.New(var_363_4, var_363_5, var_363_6)
							else
								local var_363_7 = Mathf.Lerp(iter_363_1.color.r, 1, var_363_3)

								iter_363_1.color = Color.New(var_363_7, var_363_7, var_363_7)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.actorSpriteComps1034 then
				for iter_363_2, iter_363_3 in pairs(arg_360_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_363_3 then
						if arg_360_1.isInRecall_ then
							iter_363_3.color = arg_360_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_363_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_360_1.var_.actorSpriteComps1034 = nil
			end

			local var_363_8 = arg_360_1.actors_["10113"]
			local var_363_9 = 0

			if var_363_9 < arg_360_1.time_ and arg_360_1.time_ <= var_363_9 + arg_363_0 and not isNil(var_363_8) and arg_360_1.var_.actorSpriteComps10113 == nil then
				arg_360_1.var_.actorSpriteComps10113 = var_363_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_10 = 0.2

			if var_363_9 <= arg_360_1.time_ and arg_360_1.time_ < var_363_9 + var_363_10 and not isNil(var_363_8) then
				local var_363_11 = (arg_360_1.time_ - var_363_9) / var_363_10

				if arg_360_1.var_.actorSpriteComps10113 then
					for iter_363_4, iter_363_5 in pairs(arg_360_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_363_5 then
							if arg_360_1.isInRecall_ then
								local var_363_12 = Mathf.Lerp(iter_363_5.color.r, arg_360_1.hightColor2.r, var_363_11)
								local var_363_13 = Mathf.Lerp(iter_363_5.color.g, arg_360_1.hightColor2.g, var_363_11)
								local var_363_14 = Mathf.Lerp(iter_363_5.color.b, arg_360_1.hightColor2.b, var_363_11)

								iter_363_5.color = Color.New(var_363_12, var_363_13, var_363_14)
							else
								local var_363_15 = Mathf.Lerp(iter_363_5.color.r, 0.5, var_363_11)

								iter_363_5.color = Color.New(var_363_15, var_363_15, var_363_15)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= var_363_9 + var_363_10 and arg_360_1.time_ < var_363_9 + var_363_10 + arg_363_0 and not isNil(var_363_8) and arg_360_1.var_.actorSpriteComps10113 then
				for iter_363_6, iter_363_7 in pairs(arg_360_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_363_7 then
						if arg_360_1.isInRecall_ then
							iter_363_7.color = arg_360_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_363_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_360_1.var_.actorSpriteComps10113 = nil
			end

			local var_363_16 = arg_360_1.actors_["10113"].transform
			local var_363_17 = 0

			if var_363_17 < arg_360_1.time_ and arg_360_1.time_ <= var_363_17 + arg_363_0 then
				arg_360_1.var_.moveOldPos10113 = var_363_16.localPosition
				var_363_16.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("10113", 7)

				local var_363_18 = var_363_16.childCount

				for iter_363_8 = 0, var_363_18 - 1 do
					local var_363_19 = var_363_16:GetChild(iter_363_8)

					if var_363_19.name == "split_6" or not string.find(var_363_19.name, "split") then
						var_363_19.gameObject:SetActive(true)
					else
						var_363_19.gameObject:SetActive(false)
					end
				end
			end

			local var_363_20 = 0.001

			if var_363_17 <= arg_360_1.time_ and arg_360_1.time_ < var_363_17 + var_363_20 then
				local var_363_21 = (arg_360_1.time_ - var_363_17) / var_363_20
				local var_363_22 = Vector3.New(0, -2000, 0)

				var_363_16.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10113, var_363_22, var_363_21)
			end

			if arg_360_1.time_ >= var_363_17 + var_363_20 and arg_360_1.time_ < var_363_17 + var_363_20 + arg_363_0 then
				var_363_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_363_23 = arg_360_1.actors_["1034"].transform
			local var_363_24 = 0

			if var_363_24 < arg_360_1.time_ and arg_360_1.time_ <= var_363_24 + arg_363_0 then
				arg_360_1.var_.moveOldPos1034 = var_363_23.localPosition
				var_363_23.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("1034", 3)

				local var_363_25 = var_363_23.childCount

				for iter_363_9 = 0, var_363_25 - 1 do
					local var_363_26 = var_363_23:GetChild(iter_363_9)

					if var_363_26.name == "split_6" or not string.find(var_363_26.name, "split") then
						var_363_26.gameObject:SetActive(true)
					else
						var_363_26.gameObject:SetActive(false)
					end
				end
			end

			local var_363_27 = 0.001

			if var_363_24 <= arg_360_1.time_ and arg_360_1.time_ < var_363_24 + var_363_27 then
				local var_363_28 = (arg_360_1.time_ - var_363_24) / var_363_27
				local var_363_29 = Vector3.New(0, -331.9, -324)

				var_363_23.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1034, var_363_29, var_363_28)
			end

			if arg_360_1.time_ >= var_363_24 + var_363_27 and arg_360_1.time_ < var_363_24 + var_363_27 + arg_363_0 then
				var_363_23.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_363_30 = 0
			local var_363_31 = 0.1

			if var_363_30 < arg_360_1.time_ and arg_360_1.time_ <= var_363_30 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_32 = arg_360_1:FormatText(StoryNameCfg[1109].name)

				arg_360_1.leftNameTxt_.text = var_363_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_33 = arg_360_1:GetWordFromCfg(417091085)
				local var_363_34 = arg_360_1:FormatText(var_363_33.content)

				arg_360_1.text_.text = var_363_34

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_35 = 4
				local var_363_36 = utf8.len(var_363_34)
				local var_363_37 = var_363_35 <= 0 and var_363_31 or var_363_31 * (var_363_36 / var_363_35)

				if var_363_37 > 0 and var_363_31 < var_363_37 then
					arg_360_1.talkMaxDuration = var_363_37

					if var_363_37 + var_363_30 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_37 + var_363_30
					end
				end

				arg_360_1.text_.text = var_363_34
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091085", "story_v_out_417091.awb") ~= 0 then
					local var_363_38 = manager.audio:GetVoiceLength("story_v_out_417091", "417091085", "story_v_out_417091.awb") / 1000

					if var_363_38 + var_363_30 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_38 + var_363_30
					end

					if var_363_33.prefab_name ~= "" and arg_360_1.actors_[var_363_33.prefab_name] ~= nil then
						local var_363_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_33.prefab_name].transform, "story_v_out_417091", "417091085", "story_v_out_417091.awb")

						arg_360_1:RecordAudio("417091085", var_363_39)
						arg_360_1:RecordAudio("417091085", var_363_39)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_417091", "417091085", "story_v_out_417091.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_417091", "417091085", "story_v_out_417091.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_40 = math.max(var_363_31, arg_360_1.talkMaxDuration)

			if var_363_30 <= arg_360_1.time_ and arg_360_1.time_ < var_363_30 + var_363_40 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_30) / var_363_40

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_30 + var_363_40 and arg_360_1.time_ < var_363_30 + var_363_40 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
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
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play417091086 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 417091086
		arg_364_1.duration_ = 7.1

		local var_364_0 = {
			zh = 5.333,
			ja = 7.1
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
			arg_364_1.auto_ = false
		end

		function arg_364_1.playNext_(arg_366_0)
			arg_364_1.onStoryFinished_()
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["10113"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.actorSpriteComps10113 == nil then
				arg_364_1.var_.actorSpriteComps10113 = var_367_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_2 = 0.2

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.actorSpriteComps10113 then
					for iter_367_0, iter_367_1 in pairs(arg_364_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_367_1 then
							if arg_364_1.isInRecall_ then
								local var_367_4 = Mathf.Lerp(iter_367_1.color.r, arg_364_1.hightColor1.r, var_367_3)
								local var_367_5 = Mathf.Lerp(iter_367_1.color.g, arg_364_1.hightColor1.g, var_367_3)
								local var_367_6 = Mathf.Lerp(iter_367_1.color.b, arg_364_1.hightColor1.b, var_367_3)

								iter_367_1.color = Color.New(var_367_4, var_367_5, var_367_6)
							else
								local var_367_7 = Mathf.Lerp(iter_367_1.color.r, 1, var_367_3)

								iter_367_1.color = Color.New(var_367_7, var_367_7, var_367_7)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.actorSpriteComps10113 then
				for iter_367_2, iter_367_3 in pairs(arg_364_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_367_3 then
						if arg_364_1.isInRecall_ then
							iter_367_3.color = arg_364_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_367_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_364_1.var_.actorSpriteComps10113 = nil
			end

			local var_367_8 = arg_364_1.actors_["1034"]
			local var_367_9 = 0

			if var_367_9 < arg_364_1.time_ and arg_364_1.time_ <= var_367_9 + arg_367_0 and not isNil(var_367_8) and arg_364_1.var_.actorSpriteComps1034 == nil then
				arg_364_1.var_.actorSpriteComps1034 = var_367_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_10 = 0.2

			if var_367_9 <= arg_364_1.time_ and arg_364_1.time_ < var_367_9 + var_367_10 and not isNil(var_367_8) then
				local var_367_11 = (arg_364_1.time_ - var_367_9) / var_367_10

				if arg_364_1.var_.actorSpriteComps1034 then
					for iter_367_4, iter_367_5 in pairs(arg_364_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_367_5 then
							if arg_364_1.isInRecall_ then
								local var_367_12 = Mathf.Lerp(iter_367_5.color.r, arg_364_1.hightColor2.r, var_367_11)
								local var_367_13 = Mathf.Lerp(iter_367_5.color.g, arg_364_1.hightColor2.g, var_367_11)
								local var_367_14 = Mathf.Lerp(iter_367_5.color.b, arg_364_1.hightColor2.b, var_367_11)

								iter_367_5.color = Color.New(var_367_12, var_367_13, var_367_14)
							else
								local var_367_15 = Mathf.Lerp(iter_367_5.color.r, 0.5, var_367_11)

								iter_367_5.color = Color.New(var_367_15, var_367_15, var_367_15)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= var_367_9 + var_367_10 and arg_364_1.time_ < var_367_9 + var_367_10 + arg_367_0 and not isNil(var_367_8) and arg_364_1.var_.actorSpriteComps1034 then
				for iter_367_6, iter_367_7 in pairs(arg_364_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_367_7 then
						if arg_364_1.isInRecall_ then
							iter_367_7.color = arg_364_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_367_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_364_1.var_.actorSpriteComps1034 = nil
			end

			local var_367_16 = arg_364_1.actors_["10113"].transform
			local var_367_17 = 0

			if var_367_17 < arg_364_1.time_ and arg_364_1.time_ <= var_367_17 + arg_367_0 then
				arg_364_1.var_.moveOldPos10113 = var_367_16.localPosition
				var_367_16.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("10113", 3)

				local var_367_18 = var_367_16.childCount

				for iter_367_8 = 0, var_367_18 - 1 do
					local var_367_19 = var_367_16:GetChild(iter_367_8)

					if var_367_19.name == "" or not string.find(var_367_19.name, "split") then
						var_367_19.gameObject:SetActive(true)
					else
						var_367_19.gameObject:SetActive(false)
					end
				end
			end

			local var_367_20 = 0.001

			if var_367_17 <= arg_364_1.time_ and arg_364_1.time_ < var_367_17 + var_367_20 then
				local var_367_21 = (arg_364_1.time_ - var_367_17) / var_367_20
				local var_367_22 = Vector3.New(-30.38, -328.4, -517.4)

				var_367_16.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos10113, var_367_22, var_367_21)
			end

			if arg_364_1.time_ >= var_367_17 + var_367_20 and arg_364_1.time_ < var_367_17 + var_367_20 + arg_367_0 then
				var_367_16.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_367_23 = arg_364_1.actors_["1034"].transform
			local var_367_24 = 0

			if var_367_24 < arg_364_1.time_ and arg_364_1.time_ <= var_367_24 + arg_367_0 then
				arg_364_1.var_.moveOldPos1034 = var_367_23.localPosition
				var_367_23.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("1034", 7)

				local var_367_25 = var_367_23.childCount

				for iter_367_9 = 0, var_367_25 - 1 do
					local var_367_26 = var_367_23:GetChild(iter_367_9)

					if var_367_26.name == "" or not string.find(var_367_26.name, "split") then
						var_367_26.gameObject:SetActive(true)
					else
						var_367_26.gameObject:SetActive(false)
					end
				end
			end

			local var_367_27 = 0.001

			if var_367_24 <= arg_364_1.time_ and arg_364_1.time_ < var_367_24 + var_367_27 then
				local var_367_28 = (arg_364_1.time_ - var_367_24) / var_367_27
				local var_367_29 = Vector3.New(0, -2000, 0)

				var_367_23.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1034, var_367_29, var_367_28)
			end

			if arg_364_1.time_ >= var_367_24 + var_367_27 and arg_364_1.time_ < var_367_24 + var_367_27 + arg_367_0 then
				var_367_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_367_30 = 0
			local var_367_31 = 0.55

			if var_367_30 < arg_364_1.time_ and arg_364_1.time_ <= var_367_30 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_32 = arg_364_1:FormatText(StoryNameCfg[1117].name)

				arg_364_1.leftNameTxt_.text = var_367_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_33 = arg_364_1:GetWordFromCfg(417091086)
				local var_367_34 = arg_364_1:FormatText(var_367_33.content)

				arg_364_1.text_.text = var_367_34

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_35 = 22
				local var_367_36 = utf8.len(var_367_34)
				local var_367_37 = var_367_35 <= 0 and var_367_31 or var_367_31 * (var_367_36 / var_367_35)

				if var_367_37 > 0 and var_367_31 < var_367_37 then
					arg_364_1.talkMaxDuration = var_367_37

					if var_367_37 + var_367_30 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_37 + var_367_30
					end
				end

				arg_364_1.text_.text = var_367_34
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417091", "417091086", "story_v_out_417091.awb") ~= 0 then
					local var_367_38 = manager.audio:GetVoiceLength("story_v_out_417091", "417091086", "story_v_out_417091.awb") / 1000

					if var_367_38 + var_367_30 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_38 + var_367_30
					end

					if var_367_33.prefab_name ~= "" and arg_364_1.actors_[var_367_33.prefab_name] ~= nil then
						local var_367_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_33.prefab_name].transform, "story_v_out_417091", "417091086", "story_v_out_417091.awb")

						arg_364_1:RecordAudio("417091086", var_367_39)
						arg_364_1:RecordAudio("417091086", var_367_39)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_417091", "417091086", "story_v_out_417091.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_417091", "417091086", "story_v_out_417091.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_40 = math.max(var_367_31, arg_364_1.talkMaxDuration)

			if var_367_30 <= arg_364_1.time_ and arg_364_1.time_ < var_367_30 + var_367_40 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_30) / var_367_40

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_30 + var_367_40 and arg_364_1.time_ < var_367_30 + var_367_40 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
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
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/ST69",
		"TextureConfig/Background/B01",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_417091.awb"
	}
}
