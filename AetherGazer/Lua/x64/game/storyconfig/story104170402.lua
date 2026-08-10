return {
	Play417042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417042001
		arg_1_1.duration_ = 18.5

		local var_1_0 = {
			zh = 12.766,
			ja = 18.5
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
				arg_1_0:Play417042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I16f"

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
				local var_4_5 = arg_1_1.bgs_.I16f

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
					if iter_4_0 ~= "I16f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 5.4

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = "10128"

			if arg_1_1.actors_[var_4_18] == nil then
				local var_4_19 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_4_19) then
					local var_4_20 = Object.Instantiate(var_4_19, arg_1_1.canvasGo_.transform)

					var_4_20.transform:SetSiblingIndex(1)

					var_4_20.name = var_4_18
					var_4_20.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_18] = var_4_20

					local var_4_21 = var_4_20:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_21) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_22 = arg_1_1.actors_["10128"]
			local var_4_23 = 5.4

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 and not isNil(var_4_22) and arg_1_1.var_.actorSpriteComps10128 == nil then
				arg_1_1.var_.actorSpriteComps10128 = var_4_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_24 = 0.2

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 and not isNil(var_4_22) then
				local var_4_25 = (arg_1_1.time_ - var_4_23) / var_4_24

				if arg_1_1.var_.actorSpriteComps10128 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_26 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_25)
								local var_4_27 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_25)
								local var_4_28 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_25)

								iter_4_5.color = Color.New(var_4_26, var_4_27, var_4_28)
							else
								local var_4_29 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_25)

								iter_4_5.color = Color.New(var_4_29, var_4_29, var_4_29)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 and not isNil(var_4_22) and arg_1_1.var_.actorSpriteComps10128 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10128 = nil
			end

			local var_4_30 = 0
			local var_4_31 = 0.2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 0.466666666666667
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "music"

				arg_1_1:AudioAction(var_4_38, var_4_39, "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_40 = ""
				local var_4_41 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if var_4_41 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_41 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_41

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_41
						arg_1_1.bgmTxt2_.text = var_4_41
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

			local var_4_42 = arg_1_1.actors_["10128"].transform
			local var_4_43 = 5.4

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.var_.moveOldPos10128 = var_4_42.localPosition
				var_4_42.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10128", 3)

				local var_4_44 = var_4_42.childCount

				for iter_4_8 = 0, var_4_44 - 1 do
					local var_4_45 = var_4_42:GetChild(iter_4_8)

					if var_4_45.name == "" or not string.find(var_4_45.name, "split") then
						var_4_45.gameObject:SetActive(true)
					else
						var_4_45.gameObject:SetActive(false)
					end
				end
			end

			local var_4_46 = 0.001

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_43) / var_4_46
				local var_4_48 = Vector3.New(0, -347, -300)

				var_4_42.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10128, var_4_48, var_4_47)
			end

			if arg_1_1.time_ >= var_4_43 + var_4_46 and arg_1_1.time_ < var_4_43 + var_4_46 + arg_4_0 then
				var_4_42.localPosition = Vector3.New(0, -347, -300)
			end

			local var_4_49 = 0

			arg_1_1.isInRecall_ = false

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(false)

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					local var_4_50 = iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_11, iter_4_12 in ipairs(var_4_50) do
						if iter_4_12.color.r > 0.51 then
							iter_4_12.color = Color.New(1, 1, 1)
						else
							iter_4_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_4_51 = 0.1

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_51 then
				local var_4_52 = (arg_1_1.time_ - var_4_49) / var_4_51

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_4_52)
			end

			if arg_1_1.time_ >= var_4_49 + var_4_51 and arg_1_1.time_ < var_4_49 + var_4_51 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 0
			end

			local var_4_53 = 0
			local var_4_54 = 3
			local var_4_55 = "I16f"

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_55)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_56 = arg_1_1:GetWordFromCfg(501015)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_timeText_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_58 = arg_1_1:GetWordFromCfg(501016)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_siteText_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_60 = 3

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_61 = 1.2

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				local var_4_62 = (arg_1_1.time_ - var_4_60) / var_4_61
				local var_4_63 = Color.New(0, 0, 0)

				var_4_63.a = Mathf.Lerp(0, 1, var_4_62)
				arg_1_1.mask_.color = var_4_63
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				local var_4_64 = Color.New(0, 0, 0)

				var_4_64.a = 1
				arg_1_1.mask_.color = var_4_64
			end

			local var_4_65 = 4.2

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_66 = 1.2

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				local var_4_67 = (arg_1_1.time_ - var_4_65) / var_4_66
				local var_4_68 = Color.New(0, 0, 0)

				var_4_68.a = Mathf.Lerp(1, 0, var_4_67)
				arg_1_1.mask_.color = var_4_68
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				local var_4_69 = Color.New(0, 0, 0)
				local var_4_70 = 0

				arg_1_1.mask_.enabled = false
				var_4_69.a = var_4_70
				arg_1_1.mask_.color = var_4_69
			end

			local var_4_71 = 0

			if var_4_71 < arg_1_1.time_ and arg_1_1.time_ <= var_4_71 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_72 = 1

			if var_4_71 <= arg_1_1.time_ and arg_1_1.time_ < var_4_71 + var_4_72 then
				local var_4_73 = (arg_1_1.time_ - var_4_71) / var_4_72
				local var_4_74 = Color.New(0, 0, 0)

				var_4_74.a = Mathf.Lerp(1, 0, var_4_73)
				arg_1_1.mask_.color = var_4_74
			end

			if arg_1_1.time_ >= var_4_71 + var_4_72 and arg_1_1.time_ < var_4_71 + var_4_72 + arg_4_0 then
				local var_4_75 = Color.New(0, 0, 0)
				local var_4_76 = 0

				arg_1_1.mask_.enabled = false
				var_4_75.a = var_4_76
				arg_1_1.mask_.color = var_4_75
			end

			local var_4_77 = 0

			if var_4_77 < arg_1_1.time_ and arg_1_1.time_ <= var_4_77 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_78 = 3

			if arg_1_1.time_ >= var_4_77 + var_4_78 and arg_1_1.time_ < var_4_77 + var_4_78 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_79 = 5.6
			local var_4_80 = 0.925

			if var_4_79 < arg_1_1.time_ and arg_1_1.time_ <= var_4_79 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_81 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_81:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_81:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_81:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_82 = arg_1_1:FormatText(StoryNameCfg[595].name)

				arg_1_1.leftNameTxt_.text = var_4_82

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_83 = arg_1_1:GetWordFromCfg(417042001)
				local var_4_84 = arg_1_1:FormatText(var_4_83.content)

				arg_1_1.text_.text = var_4_84

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_85 = 37
				local var_4_86 = utf8.len(var_4_84)
				local var_4_87 = var_4_85 <= 0 and var_4_80 or var_4_80 * (var_4_86 / var_4_85)

				if var_4_87 > 0 and var_4_80 < var_4_87 then
					arg_1_1.talkMaxDuration = var_4_87
					var_4_79 = var_4_79 + 0.3

					if var_4_87 + var_4_79 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_87 + var_4_79
					end
				end

				arg_1_1.text_.text = var_4_84
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042001", "story_v_out_417042.awb") ~= 0 then
					local var_4_88 = manager.audio:GetVoiceLength("story_v_out_417042", "417042001", "story_v_out_417042.awb") / 1000

					if var_4_88 + var_4_79 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_88 + var_4_79
					end

					if var_4_83.prefab_name ~= "" and arg_1_1.actors_[var_4_83.prefab_name] ~= nil then
						local var_4_89 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_83.prefab_name].transform, "story_v_out_417042", "417042001", "story_v_out_417042.awb")

						arg_1_1:RecordAudio("417042001", var_4_89)
						arg_1_1:RecordAudio("417042001", var_4_89)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417042", "417042001", "story_v_out_417042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417042", "417042001", "story_v_out_417042.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_90 = var_4_79 + 0.3
			local var_4_91 = math.max(var_4_80, arg_1_1.talkMaxDuration)

			if var_4_90 <= arg_1_1.time_ and arg_1_1.time_ < var_4_90 + var_4_91 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_90) / var_4_91

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_90 + var_4_91 and arg_1_1.time_ < var_4_90 + var_4_91 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play417042002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417042002
		arg_10_1.duration_ = 13.83

		local var_10_0 = {
			zh = 10.333,
			ja = 13.833
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417042003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0
			local var_13_1 = 1.225

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_2 = arg_10_1:FormatText(StoryNameCfg[595].name)

				arg_10_1.leftNameTxt_.text = var_13_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_3 = arg_10_1:GetWordFromCfg(417042002)
				local var_13_4 = arg_10_1:FormatText(var_13_3.content)

				arg_10_1.text_.text = var_13_4

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_5 = 49
				local var_13_6 = utf8.len(var_13_4)
				local var_13_7 = var_13_5 <= 0 and var_13_1 or var_13_1 * (var_13_6 / var_13_5)

				if var_13_7 > 0 and var_13_1 < var_13_7 then
					arg_10_1.talkMaxDuration = var_13_7

					if var_13_7 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_7 + var_13_0
					end
				end

				arg_10_1.text_.text = var_13_4
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042002", "story_v_out_417042.awb") ~= 0 then
					local var_13_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042002", "story_v_out_417042.awb") / 1000

					if var_13_8 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_8 + var_13_0
					end

					if var_13_3.prefab_name ~= "" and arg_10_1.actors_[var_13_3.prefab_name] ~= nil then
						local var_13_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_3.prefab_name].transform, "story_v_out_417042", "417042002", "story_v_out_417042.awb")

						arg_10_1:RecordAudio("417042002", var_13_9)
						arg_10_1:RecordAudio("417042002", var_13_9)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417042", "417042002", "story_v_out_417042.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417042", "417042002", "story_v_out_417042.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_10 = math.max(var_13_1, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_10 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_0) / var_13_10

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_10 and arg_10_1.time_ < var_13_0 + var_13_10 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417042003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417042003
		arg_14_1.duration_ = 7.47

		local var_14_0 = {
			zh = 5.566,
			ja = 7.466
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417042004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 0.675

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_2 = arg_14_1:FormatText(StoryNameCfg[595].name)

				arg_14_1.leftNameTxt_.text = var_17_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_3 = arg_14_1:GetWordFromCfg(417042003)
				local var_17_4 = arg_14_1:FormatText(var_17_3.content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 27
				local var_17_6 = utf8.len(var_17_4)
				local var_17_7 = var_17_5 <= 0 and var_17_1 or var_17_1 * (var_17_6 / var_17_5)

				if var_17_7 > 0 and var_17_1 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_4
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042003", "story_v_out_417042.awb") ~= 0 then
					local var_17_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042003", "story_v_out_417042.awb") / 1000

					if var_17_8 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_8 + var_17_0
					end

					if var_17_3.prefab_name ~= "" and arg_14_1.actors_[var_17_3.prefab_name] ~= nil then
						local var_17_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_3.prefab_name].transform, "story_v_out_417042", "417042003", "story_v_out_417042.awb")

						arg_14_1:RecordAudio("417042003", var_17_9)
						arg_14_1:RecordAudio("417042003", var_17_9)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417042", "417042003", "story_v_out_417042.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417042", "417042003", "story_v_out_417042.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_10 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_10 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_10

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_10 and arg_14_1.time_ < var_17_0 + var_17_10 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417042004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417042004
		arg_18_1.duration_ = 1

		local var_18_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417042005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.075

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[595].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:GetWordFromCfg(417042004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 3
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042004", "story_v_out_417042.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042004", "story_v_out_417042.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_417042", "417042004", "story_v_out_417042.awb")

						arg_18_1:RecordAudio("417042004", var_21_9)
						arg_18_1:RecordAudio("417042004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417042", "417042004", "story_v_out_417042.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417042", "417042004", "story_v_out_417042.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417042005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417042005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417042006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["10128"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps10128 == nil then
				arg_22_1.var_.actorSpriteComps10128 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps10128 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								local var_25_4 = Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor2.r, var_25_3)
								local var_25_5 = Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor2.g, var_25_3)
								local var_25_6 = Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor2.b, var_25_3)

								iter_25_1.color = Color.New(var_25_4, var_25_5, var_25_6)
							else
								local var_25_7 = Mathf.Lerp(iter_25_1.color.r, 0.5, var_25_3)

								iter_25_1.color = Color.New(var_25_7, var_25_7, var_25_7)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps10128 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_25_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps10128 = nil
			end

			local var_25_8 = arg_22_1.actors_["10128"].transform
			local var_25_9 = 0

			if var_25_9 < arg_22_1.time_ and arg_22_1.time_ <= var_25_9 + arg_25_0 then
				arg_22_1.var_.moveOldPos10128 = var_25_8.localPosition
				var_25_8.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10128", 7)

				local var_25_10 = var_25_8.childCount

				for iter_25_4 = 0, var_25_10 - 1 do
					local var_25_11 = var_25_8:GetChild(iter_25_4)

					if var_25_11.name == "" or not string.find(var_25_11.name, "split") then
						var_25_11.gameObject:SetActive(true)
					else
						var_25_11.gameObject:SetActive(false)
					end
				end
			end

			local var_25_12 = 0.001

			if var_25_9 <= arg_22_1.time_ and arg_22_1.time_ < var_25_9 + var_25_12 then
				local var_25_13 = (arg_22_1.time_ - var_25_9) / var_25_12
				local var_25_14 = Vector3.New(0, -2000, -300)

				var_25_8.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10128, var_25_14, var_25_13)
			end

			if arg_22_1.time_ >= var_25_9 + var_25_12 and arg_22_1.time_ < var_25_9 + var_25_12 + arg_25_0 then
				var_25_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_25_15 = 0
			local var_25_16 = 1.175

			if var_25_15 < arg_22_1.time_ and arg_22_1.time_ <= var_25_15 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_17 = arg_22_1:GetWordFromCfg(417042005)
				local var_25_18 = arg_22_1:FormatText(var_25_17.content)

				arg_22_1.text_.text = var_25_18

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_19 = 47
				local var_25_20 = utf8.len(var_25_18)
				local var_25_21 = var_25_19 <= 0 and var_25_16 or var_25_16 * (var_25_20 / var_25_19)

				if var_25_21 > 0 and var_25_16 < var_25_21 then
					arg_22_1.talkMaxDuration = var_25_21

					if var_25_21 + var_25_15 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_21 + var_25_15
					end
				end

				arg_22_1.text_.text = var_25_18
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_22 = math.max(var_25_16, arg_22_1.talkMaxDuration)

			if var_25_15 <= arg_22_1.time_ and arg_22_1.time_ < var_25_15 + var_25_22 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_15) / var_25_22

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_15 + var_25_22 and arg_22_1.time_ < var_25_15 + var_25_22 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
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

		arg_22_1:InitPlayNodeList()
	end,
	Play417042006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417042006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417042007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.5
			local var_29_1 = 1

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				local var_29_2 = "play"
				local var_29_3 = "effect"

				arg_26_1:AudioAction(var_29_2, var_29_3, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_29_4 = 0
			local var_29_5 = 1.5

			if var_29_4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_6 = arg_26_1:GetWordFromCfg(417042006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_8 = 60
				local var_29_9 = utf8.len(var_29_7)
				local var_29_10 = var_29_8 <= 0 and var_29_5 or var_29_5 * (var_29_9 / var_29_8)

				if var_29_10 > 0 and var_29_5 < var_29_10 then
					arg_26_1.talkMaxDuration = var_29_10

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_11 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_11 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_11

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_11 and arg_26_1.time_ < var_29_4 + var_29_11 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417042007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417042007
		arg_30_1.duration_ = 8

		local var_30_0 = {
			zh = 2.033,
			ja = 8
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417042008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = "1034"

			if arg_30_1.actors_[var_33_0] == nil then
				local var_33_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_33_1) then
					local var_33_2 = Object.Instantiate(var_33_1, arg_30_1.canvasGo_.transform)

					var_33_2.transform:SetSiblingIndex(1)

					var_33_2.name = var_33_0
					var_33_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_30_1.actors_[var_33_0] = var_33_2

					local var_33_3 = var_33_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_30_1.isInRecall_ then
						for iter_33_0, iter_33_1 in ipairs(var_33_3) do
							iter_33_1.color = arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_33_4 = arg_30_1.actors_["1034"]
			local var_33_5 = 0

			if var_33_5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 and not isNil(var_33_4) and arg_30_1.var_.actorSpriteComps1034 == nil then
				arg_30_1.var_.actorSpriteComps1034 = var_33_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_6 = 0.2

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_6 and not isNil(var_33_4) then
				local var_33_7 = (arg_30_1.time_ - var_33_5) / var_33_6

				if arg_30_1.var_.actorSpriteComps1034 then
					for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_33_3 then
							if arg_30_1.isInRecall_ then
								local var_33_8 = Mathf.Lerp(iter_33_3.color.r, arg_30_1.hightColor1.r, var_33_7)
								local var_33_9 = Mathf.Lerp(iter_33_3.color.g, arg_30_1.hightColor1.g, var_33_7)
								local var_33_10 = Mathf.Lerp(iter_33_3.color.b, arg_30_1.hightColor1.b, var_33_7)

								iter_33_3.color = Color.New(var_33_8, var_33_9, var_33_10)
							else
								local var_33_11 = Mathf.Lerp(iter_33_3.color.r, 1, var_33_7)

								iter_33_3.color = Color.New(var_33_11, var_33_11, var_33_11)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_5 + var_33_6 and arg_30_1.time_ < var_33_5 + var_33_6 + arg_33_0 and not isNil(var_33_4) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_4, iter_33_5 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_5 then
						if arg_30_1.isInRecall_ then
							iter_33_5.color = arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_33_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_12 = arg_30_1.actors_["1034"].transform
			local var_33_13 = 0

			if var_33_13 < arg_30_1.time_ and arg_30_1.time_ <= var_33_13 + arg_33_0 then
				arg_30_1.var_.moveOldPos1034 = var_33_12.localPosition
				var_33_12.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1034", 2)

				local var_33_14 = var_33_12.childCount

				for iter_33_6 = 0, var_33_14 - 1 do
					local var_33_15 = var_33_12:GetChild(iter_33_6)

					if var_33_15.name == "" or not string.find(var_33_15.name, "split") then
						var_33_15.gameObject:SetActive(true)
					else
						var_33_15.gameObject:SetActive(false)
					end
				end
			end

			local var_33_16 = 0.001

			if var_33_13 <= arg_30_1.time_ and arg_30_1.time_ < var_33_13 + var_33_16 then
				local var_33_17 = (arg_30_1.time_ - var_33_13) / var_33_16
				local var_33_18 = Vector3.New(-390, -331.9, -324)

				var_33_12.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1034, var_33_18, var_33_17)
			end

			if arg_30_1.time_ >= var_33_13 + var_33_16 and arg_30_1.time_ < var_33_13 + var_33_16 + arg_33_0 then
				var_33_12.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_33_19 = 0
			local var_33_20 = 0.225

			if var_33_19 < arg_30_1.time_ and arg_30_1.time_ <= var_33_19 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_21 = arg_30_1:FormatText(StoryNameCfg[1109].name)

				arg_30_1.leftNameTxt_.text = var_33_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_22 = arg_30_1:GetWordFromCfg(417042007)
				local var_33_23 = arg_30_1:FormatText(var_33_22.content)

				arg_30_1.text_.text = var_33_23

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_24 = 9
				local var_33_25 = utf8.len(var_33_23)
				local var_33_26 = var_33_24 <= 0 and var_33_20 or var_33_20 * (var_33_25 / var_33_24)

				if var_33_26 > 0 and var_33_20 < var_33_26 then
					arg_30_1.talkMaxDuration = var_33_26

					if var_33_26 + var_33_19 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_26 + var_33_19
					end
				end

				arg_30_1.text_.text = var_33_23
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042007", "story_v_out_417042.awb") ~= 0 then
					local var_33_27 = manager.audio:GetVoiceLength("story_v_out_417042", "417042007", "story_v_out_417042.awb") / 1000

					if var_33_27 + var_33_19 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_27 + var_33_19
					end

					if var_33_22.prefab_name ~= "" and arg_30_1.actors_[var_33_22.prefab_name] ~= nil then
						local var_33_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_22.prefab_name].transform, "story_v_out_417042", "417042007", "story_v_out_417042.awb")

						arg_30_1:RecordAudio("417042007", var_33_28)
						arg_30_1:RecordAudio("417042007", var_33_28)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417042", "417042007", "story_v_out_417042.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417042", "417042007", "story_v_out_417042.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_29 = math.max(var_33_20, arg_30_1.talkMaxDuration)

			if var_33_19 <= arg_30_1.time_ and arg_30_1.time_ < var_33_19 + var_33_29 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_19) / var_33_29

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_19 + var_33_29 and arg_30_1.time_ < var_33_19 + var_33_29 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play417042008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417042008
		arg_34_1.duration_ = 13.63

		local var_34_0 = {
			zh = 9.033,
			ja = 13.633
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417042009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10128"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps10128 == nil then
				arg_34_1.var_.actorSpriteComps10128 = var_37_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.actorSpriteComps10128 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								local var_37_4 = Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor1.r, var_37_3)
								local var_37_5 = Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor1.g, var_37_3)
								local var_37_6 = Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor1.b, var_37_3)

								iter_37_1.color = Color.New(var_37_4, var_37_5, var_37_6)
							else
								local var_37_7 = Mathf.Lerp(iter_37_1.color.r, 1, var_37_3)

								iter_37_1.color = Color.New(var_37_7, var_37_7, var_37_7)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps10128 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_37_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps10128 = nil
			end

			local var_37_8 = arg_34_1.actors_["1034"]
			local var_37_9 = 0

			if var_37_9 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 and not isNil(var_37_8) and arg_34_1.var_.actorSpriteComps1034 == nil then
				arg_34_1.var_.actorSpriteComps1034 = var_37_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_10 = 0.2

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_10 and not isNil(var_37_8) then
				local var_37_11 = (arg_34_1.time_ - var_37_9) / var_37_10

				if arg_34_1.var_.actorSpriteComps1034 then
					for iter_37_4, iter_37_5 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_37_5 then
							if arg_34_1.isInRecall_ then
								local var_37_12 = Mathf.Lerp(iter_37_5.color.r, arg_34_1.hightColor2.r, var_37_11)
								local var_37_13 = Mathf.Lerp(iter_37_5.color.g, arg_34_1.hightColor2.g, var_37_11)
								local var_37_14 = Mathf.Lerp(iter_37_5.color.b, arg_34_1.hightColor2.b, var_37_11)

								iter_37_5.color = Color.New(var_37_12, var_37_13, var_37_14)
							else
								local var_37_15 = Mathf.Lerp(iter_37_5.color.r, 0.5, var_37_11)

								iter_37_5.color = Color.New(var_37_15, var_37_15, var_37_15)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_9 + var_37_10 and arg_34_1.time_ < var_37_9 + var_37_10 + arg_37_0 and not isNil(var_37_8) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_6, iter_37_7 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_7 then
						if arg_34_1.isInRecall_ then
							iter_37_7.color = arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_37_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_16 = arg_34_1.actors_["10128"].transform
			local var_37_17 = 0

			if var_37_17 < arg_34_1.time_ and arg_34_1.time_ <= var_37_17 + arg_37_0 then
				arg_34_1.var_.moveOldPos10128 = var_37_16.localPosition
				var_37_16.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10128", 4)

				local var_37_18 = var_37_16.childCount

				for iter_37_8 = 0, var_37_18 - 1 do
					local var_37_19 = var_37_16:GetChild(iter_37_8)

					if var_37_19.name == "" or not string.find(var_37_19.name, "split") then
						var_37_19.gameObject:SetActive(true)
					else
						var_37_19.gameObject:SetActive(false)
					end
				end
			end

			local var_37_20 = 0.001

			if var_37_17 <= arg_34_1.time_ and arg_34_1.time_ < var_37_17 + var_37_20 then
				local var_37_21 = (arg_34_1.time_ - var_37_17) / var_37_20
				local var_37_22 = Vector3.New(390, -347, -300)

				var_37_16.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10128, var_37_22, var_37_21)
			end

			if arg_34_1.time_ >= var_37_17 + var_37_20 and arg_34_1.time_ < var_37_17 + var_37_20 + arg_37_0 then
				var_37_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_37_23 = 0
			local var_37_24 = 1.125

			if var_37_23 < arg_34_1.time_ and arg_34_1.time_ <= var_37_23 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_25 = arg_34_1:FormatText(StoryNameCfg[595].name)

				arg_34_1.leftNameTxt_.text = var_37_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_26 = arg_34_1:GetWordFromCfg(417042008)
				local var_37_27 = arg_34_1:FormatText(var_37_26.content)

				arg_34_1.text_.text = var_37_27

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_28 = 45
				local var_37_29 = utf8.len(var_37_27)
				local var_37_30 = var_37_28 <= 0 and var_37_24 or var_37_24 * (var_37_29 / var_37_28)

				if var_37_30 > 0 and var_37_24 < var_37_30 then
					arg_34_1.talkMaxDuration = var_37_30

					if var_37_30 + var_37_23 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_30 + var_37_23
					end
				end

				arg_34_1.text_.text = var_37_27
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042008", "story_v_out_417042.awb") ~= 0 then
					local var_37_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042008", "story_v_out_417042.awb") / 1000

					if var_37_31 + var_37_23 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_31 + var_37_23
					end

					if var_37_26.prefab_name ~= "" and arg_34_1.actors_[var_37_26.prefab_name] ~= nil then
						local var_37_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_26.prefab_name].transform, "story_v_out_417042", "417042008", "story_v_out_417042.awb")

						arg_34_1:RecordAudio("417042008", var_37_32)
						arg_34_1:RecordAudio("417042008", var_37_32)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417042", "417042008", "story_v_out_417042.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417042", "417042008", "story_v_out_417042.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_33 = math.max(var_37_24, arg_34_1.talkMaxDuration)

			if var_37_23 <= arg_34_1.time_ and arg_34_1.time_ < var_37_23 + var_37_33 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_23) / var_37_33

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_23 + var_37_33 and arg_34_1.time_ < var_37_23 + var_37_33 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play417042009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417042009
		arg_38_1.duration_ = 9.23

		local var_38_0 = {
			zh = 6.2,
			ja = 9.233
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417042010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1034"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1034 == nil then
				arg_38_1.var_.actorSpriteComps1034 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps1034 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								local var_41_4 = Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, var_41_3)
								local var_41_5 = Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, var_41_3)
								local var_41_6 = Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, var_41_3)

								iter_41_1.color = Color.New(var_41_4, var_41_5, var_41_6)
							else
								local var_41_7 = Mathf.Lerp(iter_41_1.color.r, 1, var_41_3)

								iter_41_1.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1034 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1034 = nil
			end

			local var_41_8 = arg_38_1.actors_["10128"]
			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps10128 == nil then
				arg_38_1.var_.actorSpriteComps10128 = var_41_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_10 = 0.2

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_10 and not isNil(var_41_8) then
				local var_41_11 = (arg_38_1.time_ - var_41_9) / var_41_10

				if arg_38_1.var_.actorSpriteComps10128 then
					for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_41_5 then
							if arg_38_1.isInRecall_ then
								local var_41_12 = Mathf.Lerp(iter_41_5.color.r, arg_38_1.hightColor2.r, var_41_11)
								local var_41_13 = Mathf.Lerp(iter_41_5.color.g, arg_38_1.hightColor2.g, var_41_11)
								local var_41_14 = Mathf.Lerp(iter_41_5.color.b, arg_38_1.hightColor2.b, var_41_11)

								iter_41_5.color = Color.New(var_41_12, var_41_13, var_41_14)
							else
								local var_41_15 = Mathf.Lerp(iter_41_5.color.r, 0.5, var_41_11)

								iter_41_5.color = Color.New(var_41_15, var_41_15, var_41_15)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_9 + var_41_10 and arg_38_1.time_ < var_41_9 + var_41_10 + arg_41_0 and not isNil(var_41_8) and arg_38_1.var_.actorSpriteComps10128 then
				for iter_41_6, iter_41_7 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_41_7 then
						if arg_38_1.isInRecall_ then
							iter_41_7.color = arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_41_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps10128 = nil
			end

			local var_41_16 = 0
			local var_41_17 = 0.825

			if var_41_16 < arg_38_1.time_ and arg_38_1.time_ <= var_41_16 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_18 = arg_38_1:FormatText(StoryNameCfg[1109].name)

				arg_38_1.leftNameTxt_.text = var_41_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_19 = arg_38_1:GetWordFromCfg(417042009)
				local var_41_20 = arg_38_1:FormatText(var_41_19.content)

				arg_38_1.text_.text = var_41_20

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_21 = 33
				local var_41_22 = utf8.len(var_41_20)
				local var_41_23 = var_41_21 <= 0 and var_41_17 or var_41_17 * (var_41_22 / var_41_21)

				if var_41_23 > 0 and var_41_17 < var_41_23 then
					arg_38_1.talkMaxDuration = var_41_23

					if var_41_23 + var_41_16 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_23 + var_41_16
					end
				end

				arg_38_1.text_.text = var_41_20
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042009", "story_v_out_417042.awb") ~= 0 then
					local var_41_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042009", "story_v_out_417042.awb") / 1000

					if var_41_24 + var_41_16 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_24 + var_41_16
					end

					if var_41_19.prefab_name ~= "" and arg_38_1.actors_[var_41_19.prefab_name] ~= nil then
						local var_41_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_19.prefab_name].transform, "story_v_out_417042", "417042009", "story_v_out_417042.awb")

						arg_38_1:RecordAudio("417042009", var_41_25)
						arg_38_1:RecordAudio("417042009", var_41_25)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417042", "417042009", "story_v_out_417042.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417042", "417042009", "story_v_out_417042.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_26 = math.max(var_41_17, arg_38_1.talkMaxDuration)

			if var_41_16 <= arg_38_1.time_ and arg_38_1.time_ < var_41_16 + var_41_26 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_16) / var_41_26

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_16 + var_41_26 and arg_38_1.time_ < var_41_16 + var_41_26 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417042010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417042010
		arg_42_1.duration_ = 7.67

		local var_42_0 = {
			zh = 1.8,
			ja = 7.666
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417042011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10128"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps10128 == nil then
				arg_42_1.var_.actorSpriteComps10128 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps10128 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								local var_45_4 = Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, var_45_3)
								local var_45_5 = Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, var_45_3)
								local var_45_6 = Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, var_45_3)

								iter_45_1.color = Color.New(var_45_4, var_45_5, var_45_6)
							else
								local var_45_7 = Mathf.Lerp(iter_45_1.color.r, 1, var_45_3)

								iter_45_1.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps10128 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10128 = nil
			end

			local var_45_8 = arg_42_1.actors_["1034"]
			local var_45_9 = 0

			if var_45_9 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = var_45_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_10 = 0.2

			if var_45_9 <= arg_42_1.time_ and arg_42_1.time_ < var_45_9 + var_45_10 and not isNil(var_45_8) then
				local var_45_11 = (arg_42_1.time_ - var_45_9) / var_45_10

				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_45_5 then
							if arg_42_1.isInRecall_ then
								local var_45_12 = Mathf.Lerp(iter_45_5.color.r, arg_42_1.hightColor2.r, var_45_11)
								local var_45_13 = Mathf.Lerp(iter_45_5.color.g, arg_42_1.hightColor2.g, var_45_11)
								local var_45_14 = Mathf.Lerp(iter_45_5.color.b, arg_42_1.hightColor2.b, var_45_11)

								iter_45_5.color = Color.New(var_45_12, var_45_13, var_45_14)
							else
								local var_45_15 = Mathf.Lerp(iter_45_5.color.r, 0.5, var_45_11)

								iter_45_5.color = Color.New(var_45_15, var_45_15, var_45_15)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_9 + var_45_10 and arg_42_1.time_ < var_45_9 + var_45_10 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_7 then
						if arg_42_1.isInRecall_ then
							iter_45_7.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_16 = 0
			local var_45_17 = 0.25

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_18 = arg_42_1:FormatText(StoryNameCfg[595].name)

				arg_42_1.leftNameTxt_.text = var_45_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_19 = arg_42_1:GetWordFromCfg(417042010)
				local var_45_20 = arg_42_1:FormatText(var_45_19.content)

				arg_42_1.text_.text = var_45_20

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_21 = 10
				local var_45_22 = utf8.len(var_45_20)
				local var_45_23 = var_45_21 <= 0 and var_45_17 or var_45_17 * (var_45_22 / var_45_21)

				if var_45_23 > 0 and var_45_17 < var_45_23 then
					arg_42_1.talkMaxDuration = var_45_23

					if var_45_23 + var_45_16 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_23 + var_45_16
					end
				end

				arg_42_1.text_.text = var_45_20
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042010", "story_v_out_417042.awb") ~= 0 then
					local var_45_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042010", "story_v_out_417042.awb") / 1000

					if var_45_24 + var_45_16 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_24 + var_45_16
					end

					if var_45_19.prefab_name ~= "" and arg_42_1.actors_[var_45_19.prefab_name] ~= nil then
						local var_45_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_19.prefab_name].transform, "story_v_out_417042", "417042010", "story_v_out_417042.awb")

						arg_42_1:RecordAudio("417042010", var_45_25)
						arg_42_1:RecordAudio("417042010", var_45_25)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417042", "417042010", "story_v_out_417042.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417042", "417042010", "story_v_out_417042.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_26 = math.max(var_45_17, arg_42_1.talkMaxDuration)

			if var_45_16 <= arg_42_1.time_ and arg_42_1.time_ < var_45_16 + var_45_26 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_16) / var_45_26

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_16 + var_45_26 and arg_42_1.time_ < var_45_16 + var_45_26 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417042011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417042011
		arg_46_1.duration_ = 13.93

		local var_46_0 = {
			zh = 10.1,
			ja = 13.933
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417042012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1034"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1034 == nil then
				arg_46_1.var_.actorSpriteComps1034 = var_49_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.actorSpriteComps1034 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								local var_49_4 = Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor1.r, var_49_3)
								local var_49_5 = Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor1.g, var_49_3)
								local var_49_6 = Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor1.b, var_49_3)

								iter_49_1.color = Color.New(var_49_4, var_49_5, var_49_6)
							else
								local var_49_7 = Mathf.Lerp(iter_49_1.color.r, 1, var_49_3)

								iter_49_1.color = Color.New(var_49_7, var_49_7, var_49_7)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1034 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_49_3 then
						if arg_46_1.isInRecall_ then
							iter_49_3.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_49_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_8 = arg_46_1.actors_["10128"]
			local var_49_9 = 0

			if var_49_9 < arg_46_1.time_ and arg_46_1.time_ <= var_49_9 + arg_49_0 and not isNil(var_49_8) and arg_46_1.var_.actorSpriteComps10128 == nil then
				arg_46_1.var_.actorSpriteComps10128 = var_49_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_10 = 0.2

			if var_49_9 <= arg_46_1.time_ and arg_46_1.time_ < var_49_9 + var_49_10 and not isNil(var_49_8) then
				local var_49_11 = (arg_46_1.time_ - var_49_9) / var_49_10

				if arg_46_1.var_.actorSpriteComps10128 then
					for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_49_5 then
							if arg_46_1.isInRecall_ then
								local var_49_12 = Mathf.Lerp(iter_49_5.color.r, arg_46_1.hightColor2.r, var_49_11)
								local var_49_13 = Mathf.Lerp(iter_49_5.color.g, arg_46_1.hightColor2.g, var_49_11)
								local var_49_14 = Mathf.Lerp(iter_49_5.color.b, arg_46_1.hightColor2.b, var_49_11)

								iter_49_5.color = Color.New(var_49_12, var_49_13, var_49_14)
							else
								local var_49_15 = Mathf.Lerp(iter_49_5.color.r, 0.5, var_49_11)

								iter_49_5.color = Color.New(var_49_15, var_49_15, var_49_15)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_9 + var_49_10 and arg_46_1.time_ < var_49_9 + var_49_10 + arg_49_0 and not isNil(var_49_8) and arg_46_1.var_.actorSpriteComps10128 then
				for iter_49_6, iter_49_7 in pairs(arg_46_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_49_7 then
						if arg_46_1.isInRecall_ then
							iter_49_7.color = arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_49_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps10128 = nil
			end

			local var_49_16 = 0
			local var_49_17 = 1.275

			if var_49_16 < arg_46_1.time_ and arg_46_1.time_ <= var_49_16 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_18 = arg_46_1:FormatText(StoryNameCfg[1109].name)

				arg_46_1.leftNameTxt_.text = var_49_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_19 = arg_46_1:GetWordFromCfg(417042011)
				local var_49_20 = arg_46_1:FormatText(var_49_19.content)

				arg_46_1.text_.text = var_49_20

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_21 = 51
				local var_49_22 = utf8.len(var_49_20)
				local var_49_23 = var_49_21 <= 0 and var_49_17 or var_49_17 * (var_49_22 / var_49_21)

				if var_49_23 > 0 and var_49_17 < var_49_23 then
					arg_46_1.talkMaxDuration = var_49_23

					if var_49_23 + var_49_16 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_16
					end
				end

				arg_46_1.text_.text = var_49_20
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042011", "story_v_out_417042.awb") ~= 0 then
					local var_49_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042011", "story_v_out_417042.awb") / 1000

					if var_49_24 + var_49_16 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_24 + var_49_16
					end

					if var_49_19.prefab_name ~= "" and arg_46_1.actors_[var_49_19.prefab_name] ~= nil then
						local var_49_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_19.prefab_name].transform, "story_v_out_417042", "417042011", "story_v_out_417042.awb")

						arg_46_1:RecordAudio("417042011", var_49_25)
						arg_46_1:RecordAudio("417042011", var_49_25)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417042", "417042011", "story_v_out_417042.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417042", "417042011", "story_v_out_417042.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_26 = math.max(var_49_17, arg_46_1.talkMaxDuration)

			if var_49_16 <= arg_46_1.time_ and arg_46_1.time_ < var_49_16 + var_49_26 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_16) / var_49_26

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_16 + var_49_26 and arg_46_1.time_ < var_49_16 + var_49_26 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417042012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417042012
		arg_50_1.duration_ = 14.47

		local var_50_0 = {
			zh = 8.3,
			ja = 14.466
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417042013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1034"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = var_53_0.localPosition
				var_53_0.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 2)

				local var_53_2 = var_53_0.childCount

				for iter_53_0 = 0, var_53_2 - 1 do
					local var_53_3 = var_53_0:GetChild(iter_53_0)

					if var_53_3.name == "split_1" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_4 then
				local var_53_5 = (arg_50_1.time_ - var_53_1) / var_53_4
				local var_53_6 = Vector3.New(-390, -331.9, -324)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, var_53_6, var_53_5)
			end

			if arg_50_1.time_ >= var_53_1 + var_53_4 and arg_50_1.time_ < var_53_1 + var_53_4 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_53_7 = 0
			local var_53_8 = 1.05

			if var_53_7 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_9 = arg_50_1:FormatText(StoryNameCfg[1109].name)

				arg_50_1.leftNameTxt_.text = var_53_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_10 = arg_50_1:GetWordFromCfg(417042012)
				local var_53_11 = arg_50_1:FormatText(var_53_10.content)

				arg_50_1.text_.text = var_53_11

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_12 = 42
				local var_53_13 = utf8.len(var_53_11)
				local var_53_14 = var_53_12 <= 0 and var_53_8 or var_53_8 * (var_53_13 / var_53_12)

				if var_53_14 > 0 and var_53_8 < var_53_14 then
					arg_50_1.talkMaxDuration = var_53_14

					if var_53_14 + var_53_7 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_7
					end
				end

				arg_50_1.text_.text = var_53_11
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042012", "story_v_out_417042.awb") ~= 0 then
					local var_53_15 = manager.audio:GetVoiceLength("story_v_out_417042", "417042012", "story_v_out_417042.awb") / 1000

					if var_53_15 + var_53_7 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_15 + var_53_7
					end

					if var_53_10.prefab_name ~= "" and arg_50_1.actors_[var_53_10.prefab_name] ~= nil then
						local var_53_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_10.prefab_name].transform, "story_v_out_417042", "417042012", "story_v_out_417042.awb")

						arg_50_1:RecordAudio("417042012", var_53_16)
						arg_50_1:RecordAudio("417042012", var_53_16)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417042", "417042012", "story_v_out_417042.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417042", "417042012", "story_v_out_417042.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_17 = math.max(var_53_8, arg_50_1.talkMaxDuration)

			if var_53_7 <= arg_50_1.time_ and arg_50_1.time_ < var_53_7 + var_53_17 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_7) / var_53_17

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_7 + var_53_17 and arg_50_1.time_ < var_53_7 + var_53_17 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play417042013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417042013
		arg_54_1.duration_ = 16.3

		local var_54_0 = {
			zh = 12.666,
			ja = 16.3
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play417042014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["10128"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps10128 == nil then
				arg_54_1.var_.actorSpriteComps10128 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps10128 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								local var_57_4 = Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor1.r, var_57_3)
								local var_57_5 = Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor1.g, var_57_3)
								local var_57_6 = Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor1.b, var_57_3)

								iter_57_1.color = Color.New(var_57_4, var_57_5, var_57_6)
							else
								local var_57_7 = Mathf.Lerp(iter_57_1.color.r, 1, var_57_3)

								iter_57_1.color = Color.New(var_57_7, var_57_7, var_57_7)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps10128 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps10128 = nil
			end

			local var_57_8 = arg_54_1.actors_["1034"]
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps1034 == nil then
				arg_54_1.var_.actorSpriteComps1034 = var_57_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_10 = 0.2

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_10 and not isNil(var_57_8) then
				local var_57_11 = (arg_54_1.time_ - var_57_9) / var_57_10

				if arg_54_1.var_.actorSpriteComps1034 then
					for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_57_5 then
							if arg_54_1.isInRecall_ then
								local var_57_12 = Mathf.Lerp(iter_57_5.color.r, arg_54_1.hightColor2.r, var_57_11)
								local var_57_13 = Mathf.Lerp(iter_57_5.color.g, arg_54_1.hightColor2.g, var_57_11)
								local var_57_14 = Mathf.Lerp(iter_57_5.color.b, arg_54_1.hightColor2.b, var_57_11)

								iter_57_5.color = Color.New(var_57_12, var_57_13, var_57_14)
							else
								local var_57_15 = Mathf.Lerp(iter_57_5.color.r, 0.5, var_57_11)

								iter_57_5.color = Color.New(var_57_15, var_57_15, var_57_15)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_9 + var_57_10 and arg_54_1.time_ < var_57_9 + var_57_10 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_6, iter_57_7 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_7 then
						if arg_54_1.isInRecall_ then
							iter_57_7.color = arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_57_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_16 = arg_54_1.actors_["10128"].transform
			local var_57_17 = 0

			if var_57_17 < arg_54_1.time_ and arg_54_1.time_ <= var_57_17 + arg_57_0 then
				arg_54_1.var_.moveOldPos10128 = var_57_16.localPosition
				var_57_16.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("10128", 4)

				local var_57_18 = var_57_16.childCount

				for iter_57_8 = 0, var_57_18 - 1 do
					local var_57_19 = var_57_16:GetChild(iter_57_8)

					if var_57_19.name == "split_2" or not string.find(var_57_19.name, "split") then
						var_57_19.gameObject:SetActive(true)
					else
						var_57_19.gameObject:SetActive(false)
					end
				end
			end

			local var_57_20 = 0.001

			if var_57_17 <= arg_54_1.time_ and arg_54_1.time_ < var_57_17 + var_57_20 then
				local var_57_21 = (arg_54_1.time_ - var_57_17) / var_57_20
				local var_57_22 = Vector3.New(390, -347, -330)

				var_57_16.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos10128, var_57_22, var_57_21)
			end

			if arg_54_1.time_ >= var_57_17 + var_57_20 and arg_54_1.time_ < var_57_17 + var_57_20 + arg_57_0 then
				var_57_16.localPosition = Vector3.New(390, -347, -330)
			end

			local var_57_23 = 0
			local var_57_24 = 1.6

			if var_57_23 < arg_54_1.time_ and arg_54_1.time_ <= var_57_23 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_25 = arg_54_1:FormatText(StoryNameCfg[595].name)

				arg_54_1.leftNameTxt_.text = var_57_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_26 = arg_54_1:GetWordFromCfg(417042013)
				local var_57_27 = arg_54_1:FormatText(var_57_26.content)

				arg_54_1.text_.text = var_57_27

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_28 = 64
				local var_57_29 = utf8.len(var_57_27)
				local var_57_30 = var_57_28 <= 0 and var_57_24 or var_57_24 * (var_57_29 / var_57_28)

				if var_57_30 > 0 and var_57_24 < var_57_30 then
					arg_54_1.talkMaxDuration = var_57_30

					if var_57_30 + var_57_23 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_30 + var_57_23
					end
				end

				arg_54_1.text_.text = var_57_27
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042013", "story_v_out_417042.awb") ~= 0 then
					local var_57_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042013", "story_v_out_417042.awb") / 1000

					if var_57_31 + var_57_23 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_31 + var_57_23
					end

					if var_57_26.prefab_name ~= "" and arg_54_1.actors_[var_57_26.prefab_name] ~= nil then
						local var_57_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_26.prefab_name].transform, "story_v_out_417042", "417042013", "story_v_out_417042.awb")

						arg_54_1:RecordAudio("417042013", var_57_32)
						arg_54_1:RecordAudio("417042013", var_57_32)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417042", "417042013", "story_v_out_417042.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417042", "417042013", "story_v_out_417042.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_33 = math.max(var_57_24, arg_54_1.talkMaxDuration)

			if var_57_23 <= arg_54_1.time_ and arg_54_1.time_ < var_57_23 + var_57_33 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_23) / var_57_33

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_23 + var_57_33 and arg_54_1.time_ < var_57_23 + var_57_33 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play417042014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417042014
		arg_58_1.duration_ = 8.43

		local var_58_0 = {
			zh = 7.4,
			ja = 8.433
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
				arg_58_0:Play417042015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1.1

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[595].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(417042014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 44
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042014", "story_v_out_417042.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042014", "story_v_out_417042.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_417042", "417042014", "story_v_out_417042.awb")

						arg_58_1:RecordAudio("417042014", var_61_9)
						arg_58_1:RecordAudio("417042014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417042", "417042014", "story_v_out_417042.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417042", "417042014", "story_v_out_417042.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417042015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417042015
		arg_62_1.duration_ = 3.03

		local var_62_0 = {
			zh = 1.3,
			ja = 3.033
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
				arg_62_0:Play417042016(arg_62_1)
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

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1034 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps1034 = nil
			end

			local var_65_8 = arg_62_1.actors_["10128"]
			local var_65_9 = 0

			if var_65_9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 and not isNil(var_65_8) and arg_62_1.var_.actorSpriteComps10128 == nil then
				arg_62_1.var_.actorSpriteComps10128 = var_65_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_10 = 0.2

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_10 and not isNil(var_65_8) then
				local var_65_11 = (arg_62_1.time_ - var_65_9) / var_65_10

				if arg_62_1.var_.actorSpriteComps10128 then
					for iter_65_4, iter_65_5 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_65_5 then
							if arg_62_1.isInRecall_ then
								local var_65_12 = Mathf.Lerp(iter_65_5.color.r, arg_62_1.hightColor2.r, var_65_11)
								local var_65_13 = Mathf.Lerp(iter_65_5.color.g, arg_62_1.hightColor2.g, var_65_11)
								local var_65_14 = Mathf.Lerp(iter_65_5.color.b, arg_62_1.hightColor2.b, var_65_11)

								iter_65_5.color = Color.New(var_65_12, var_65_13, var_65_14)
							else
								local var_65_15 = Mathf.Lerp(iter_65_5.color.r, 0.5, var_65_11)

								iter_65_5.color = Color.New(var_65_15, var_65_15, var_65_15)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= var_65_9 + var_65_10 and arg_62_1.time_ < var_65_9 + var_65_10 + arg_65_0 and not isNil(var_65_8) and arg_62_1.var_.actorSpriteComps10128 then
				for iter_65_6, iter_65_7 in pairs(arg_62_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_65_7 then
						if arg_62_1.isInRecall_ then
							iter_65_7.color = arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_65_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps10128 = nil
			end

			local var_65_16 = arg_62_1.actors_["1034"].transform
			local var_65_17 = 0

			if var_65_17 < arg_62_1.time_ and arg_62_1.time_ <= var_65_17 + arg_65_0 then
				arg_62_1.var_.moveOldPos1034 = var_65_16.localPosition
				var_65_16.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1034", 2)

				local var_65_18 = var_65_16.childCount

				for iter_65_8 = 0, var_65_18 - 1 do
					local var_65_19 = var_65_16:GetChild(iter_65_8)

					if var_65_19.name == "split_4" or not string.find(var_65_19.name, "split") then
						var_65_19.gameObject:SetActive(true)
					else
						var_65_19.gameObject:SetActive(false)
					end
				end
			end

			local var_65_20 = 0.001

			if var_65_17 <= arg_62_1.time_ and arg_62_1.time_ < var_65_17 + var_65_20 then
				local var_65_21 = (arg_62_1.time_ - var_65_17) / var_65_20
				local var_65_22 = Vector3.New(-390, -331.9, -324)

				var_65_16.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1034, var_65_22, var_65_21)
			end

			if arg_62_1.time_ >= var_65_17 + var_65_20 and arg_62_1.time_ < var_65_17 + var_65_20 + arg_65_0 then
				var_65_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_65_23 = 0
			local var_65_24 = 0.1

			if var_65_23 < arg_62_1.time_ and arg_62_1.time_ <= var_65_23 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_25 = arg_62_1:FormatText(StoryNameCfg[1109].name)

				arg_62_1.leftNameTxt_.text = var_65_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_26 = arg_62_1:GetWordFromCfg(417042015)
				local var_65_27 = arg_62_1:FormatText(var_65_26.content)

				arg_62_1.text_.text = var_65_27

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_28 = 4
				local var_65_29 = utf8.len(var_65_27)
				local var_65_30 = var_65_28 <= 0 and var_65_24 or var_65_24 * (var_65_29 / var_65_28)

				if var_65_30 > 0 and var_65_24 < var_65_30 then
					arg_62_1.talkMaxDuration = var_65_30

					if var_65_30 + var_65_23 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_30 + var_65_23
					end
				end

				arg_62_1.text_.text = var_65_27
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042015", "story_v_out_417042.awb") ~= 0 then
					local var_65_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042015", "story_v_out_417042.awb") / 1000

					if var_65_31 + var_65_23 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_31 + var_65_23
					end

					if var_65_26.prefab_name ~= "" and arg_62_1.actors_[var_65_26.prefab_name] ~= nil then
						local var_65_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_26.prefab_name].transform, "story_v_out_417042", "417042015", "story_v_out_417042.awb")

						arg_62_1:RecordAudio("417042015", var_65_32)
						arg_62_1:RecordAudio("417042015", var_65_32)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417042", "417042015", "story_v_out_417042.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417042", "417042015", "story_v_out_417042.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_33 = math.max(var_65_24, arg_62_1.talkMaxDuration)

			if var_65_23 <= arg_62_1.time_ and arg_62_1.time_ < var_65_23 + var_65_33 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_23) / var_65_33

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_23 + var_65_33 and arg_62_1.time_ < var_65_23 + var_65_33 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play417042016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417042016
		arg_66_1.duration_ = 3.33

		local var_66_0 = {
			zh = 2.633,
			ja = 3.333
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
				arg_66_0:Play417042017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10128"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps10128 == nil then
				arg_66_1.var_.actorSpriteComps10128 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps10128 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps10128 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_69_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps10128 = nil
			end

			local var_69_8 = arg_66_1.actors_["1034"]
			local var_69_9 = 0

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps1034 == nil then
				arg_66_1.var_.actorSpriteComps1034 = var_69_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_10 = 0.2

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_10 and not isNil(var_69_8) then
				local var_69_11 = (arg_66_1.time_ - var_69_9) / var_69_10

				if arg_66_1.var_.actorSpriteComps1034 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								local var_69_12 = Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor2.r, var_69_11)
								local var_69_13 = Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor2.g, var_69_11)
								local var_69_14 = Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor2.b, var_69_11)

								iter_69_5.color = Color.New(var_69_12, var_69_13, var_69_14)
							else
								local var_69_15 = Mathf.Lerp(iter_69_5.color.r, 0.5, var_69_11)

								iter_69_5.color = Color.New(var_69_15, var_69_15, var_69_15)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_9 + var_69_10 and arg_66_1.time_ < var_69_9 + var_69_10 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps1034 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_69_7 then
						if arg_66_1.isInRecall_ then
							iter_69_7.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1034 = nil
			end

			local var_69_16 = arg_66_1.actors_["10128"].transform
			local var_69_17 = 0

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.var_.moveOldPos10128 = var_69_16.localPosition
				var_69_16.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("10128", 4)

				local var_69_18 = var_69_16.childCount

				for iter_69_8 = 0, var_69_18 - 1 do
					local var_69_19 = var_69_16:GetChild(iter_69_8)

					if var_69_19.name == "" or not string.find(var_69_19.name, "split") then
						var_69_19.gameObject:SetActive(true)
					else
						var_69_19.gameObject:SetActive(false)
					end
				end
			end

			local var_69_20 = 0.001

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_20 then
				local var_69_21 = (arg_66_1.time_ - var_69_17) / var_69_20
				local var_69_22 = Vector3.New(390, -347, -300)

				var_69_16.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10128, var_69_22, var_69_21)
			end

			if arg_66_1.time_ >= var_69_17 + var_69_20 and arg_66_1.time_ < var_69_17 + var_69_20 + arg_69_0 then
				var_69_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_69_23 = 0
			local var_69_24 = 0.325

			if var_69_23 < arg_66_1.time_ and arg_66_1.time_ <= var_69_23 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_25 = arg_66_1:FormatText(StoryNameCfg[595].name)

				arg_66_1.leftNameTxt_.text = var_69_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_26 = arg_66_1:GetWordFromCfg(417042016)
				local var_69_27 = arg_66_1:FormatText(var_69_26.content)

				arg_66_1.text_.text = var_69_27

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_28 = 13
				local var_69_29 = utf8.len(var_69_27)
				local var_69_30 = var_69_28 <= 0 and var_69_24 or var_69_24 * (var_69_29 / var_69_28)

				if var_69_30 > 0 and var_69_24 < var_69_30 then
					arg_66_1.talkMaxDuration = var_69_30

					if var_69_30 + var_69_23 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_30 + var_69_23
					end
				end

				arg_66_1.text_.text = var_69_27
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042016", "story_v_out_417042.awb") ~= 0 then
					local var_69_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042016", "story_v_out_417042.awb") / 1000

					if var_69_31 + var_69_23 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_31 + var_69_23
					end

					if var_69_26.prefab_name ~= "" and arg_66_1.actors_[var_69_26.prefab_name] ~= nil then
						local var_69_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_26.prefab_name].transform, "story_v_out_417042", "417042016", "story_v_out_417042.awb")

						arg_66_1:RecordAudio("417042016", var_69_32)
						arg_66_1:RecordAudio("417042016", var_69_32)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417042", "417042016", "story_v_out_417042.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417042", "417042016", "story_v_out_417042.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_33 = math.max(var_69_24, arg_66_1.talkMaxDuration)

			if var_69_23 <= arg_66_1.time_ and arg_66_1.time_ < var_69_23 + var_69_33 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_23) / var_69_33

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_23 + var_69_33 and arg_66_1.time_ < var_69_23 + var_69_33 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play417042017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417042017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play417042018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10128"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps10128 == nil then
				arg_70_1.var_.actorSpriteComps10128 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps10128 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps10128 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps10128 = nil
			end

			local var_73_8 = 0
			local var_73_9 = 0.9

			if var_73_8 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_10 = arg_70_1:GetWordFromCfg(417042017)
				local var_73_11 = arg_70_1:FormatText(var_73_10.content)

				arg_70_1.text_.text = var_73_11

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_12 = 36
				local var_73_13 = utf8.len(var_73_11)
				local var_73_14 = var_73_12 <= 0 and var_73_9 or var_73_9 * (var_73_13 / var_73_12)

				if var_73_14 > 0 and var_73_9 < var_73_14 then
					arg_70_1.talkMaxDuration = var_73_14

					if var_73_14 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_8
					end
				end

				arg_70_1.text_.text = var_73_11
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_15 = math.max(var_73_9, arg_70_1.talkMaxDuration)

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_15 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_8) / var_73_15

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_8 + var_73_15 and arg_70_1.time_ < var_73_8 + var_73_15 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417042018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417042018
		arg_74_1.duration_ = 7.27

		local var_74_0 = {
			zh = 4.566,
			ja = 7.266
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417042019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1034"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1034 == nil then
				arg_74_1.var_.actorSpriteComps1034 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps1034 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor1.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor1.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor1.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 1, var_77_3)

								iter_77_1.color = Color.New(var_77_7, var_77_7, var_77_7)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1034 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_77_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1034 = nil
			end

			local var_77_8 = arg_74_1.actors_["1034"].transform
			local var_77_9 = 0

			if var_77_9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.var_.moveOldPos1034 = var_77_8.localPosition
				var_77_8.localScale = Vector3.New(1, 1, 1)

				arg_74_1:CheckSpriteTmpPos("1034", 2)

				local var_77_10 = var_77_8.childCount

				for iter_77_4 = 0, var_77_10 - 1 do
					local var_77_11 = var_77_8:GetChild(iter_77_4)

					if var_77_11.name == "" or not string.find(var_77_11.name, "split") then
						var_77_11.gameObject:SetActive(true)
					else
						var_77_11.gameObject:SetActive(false)
					end
				end
			end

			local var_77_12 = 0.001

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_12 then
				local var_77_13 = (arg_74_1.time_ - var_77_9) / var_77_12
				local var_77_14 = Vector3.New(-390, -331.9, -324)

				var_77_8.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1034, var_77_14, var_77_13)
			end

			if arg_74_1.time_ >= var_77_9 + var_77_12 and arg_74_1.time_ < var_77_9 + var_77_12 + arg_77_0 then
				var_77_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_77_15 = 0
			local var_77_16 = 0.4

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_17 = arg_74_1:FormatText(StoryNameCfg[1109].name)

				arg_74_1.leftNameTxt_.text = var_77_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_18 = arg_74_1:GetWordFromCfg(417042018)
				local var_77_19 = arg_74_1:FormatText(var_77_18.content)

				arg_74_1.text_.text = var_77_19

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_20 = 16
				local var_77_21 = utf8.len(var_77_19)
				local var_77_22 = var_77_20 <= 0 and var_77_16 or var_77_16 * (var_77_21 / var_77_20)

				if var_77_22 > 0 and var_77_16 < var_77_22 then
					arg_74_1.talkMaxDuration = var_77_22

					if var_77_22 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_22 + var_77_15
					end
				end

				arg_74_1.text_.text = var_77_19
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042018", "story_v_out_417042.awb") ~= 0 then
					local var_77_23 = manager.audio:GetVoiceLength("story_v_out_417042", "417042018", "story_v_out_417042.awb") / 1000

					if var_77_23 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_15
					end

					if var_77_18.prefab_name ~= "" and arg_74_1.actors_[var_77_18.prefab_name] ~= nil then
						local var_77_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_18.prefab_name].transform, "story_v_out_417042", "417042018", "story_v_out_417042.awb")

						arg_74_1:RecordAudio("417042018", var_77_24)
						arg_74_1:RecordAudio("417042018", var_77_24)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417042", "417042018", "story_v_out_417042.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417042", "417042018", "story_v_out_417042.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_25 = math.max(var_77_16, arg_74_1.talkMaxDuration)

			if var_77_15 <= arg_74_1.time_ and arg_74_1.time_ < var_77_15 + var_77_25 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_15) / var_77_25

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_15 + var_77_25 and arg_74_1.time_ < var_77_15 + var_77_25 + arg_77_0 then
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
	Play417042019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417042019
		arg_78_1.duration_ = 11.37

		local var_78_0 = {
			zh = 10.266,
			ja = 11.366
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
				arg_78_0:Play417042020(arg_78_1)
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

			local var_81_8 = arg_78_1.actors_["1034"]
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.actorSpriteComps1034 == nil then
				arg_78_1.var_.actorSpriteComps1034 = var_81_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_10 = 0.2

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_10 and not isNil(var_81_8) then
				local var_81_11 = (arg_78_1.time_ - var_81_9) / var_81_10

				if arg_78_1.var_.actorSpriteComps1034 then
					for iter_81_4, iter_81_5 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_81_5 then
							if arg_78_1.isInRecall_ then
								local var_81_12 = Mathf.Lerp(iter_81_5.color.r, arg_78_1.hightColor2.r, var_81_11)
								local var_81_13 = Mathf.Lerp(iter_81_5.color.g, arg_78_1.hightColor2.g, var_81_11)
								local var_81_14 = Mathf.Lerp(iter_81_5.color.b, arg_78_1.hightColor2.b, var_81_11)

								iter_81_5.color = Color.New(var_81_12, var_81_13, var_81_14)
							else
								local var_81_15 = Mathf.Lerp(iter_81_5.color.r, 0.5, var_81_11)

								iter_81_5.color = Color.New(var_81_15, var_81_15, var_81_15)
							end
						end
					end
				end
			end

			if arg_78_1.time_ >= var_81_9 + var_81_10 and arg_78_1.time_ < var_81_9 + var_81_10 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.actorSpriteComps1034 then
				for iter_81_6, iter_81_7 in pairs(arg_78_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_81_7 then
						if arg_78_1.isInRecall_ then
							iter_81_7.color = arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_81_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps1034 = nil
			end

			local var_81_16 = arg_78_1.actors_["10128"].transform
			local var_81_17 = 0

			if var_81_17 < arg_78_1.time_ and arg_78_1.time_ <= var_81_17 + arg_81_0 then
				arg_78_1.var_.moveOldPos10128 = var_81_16.localPosition
				var_81_16.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("10128", 4)

				local var_81_18 = var_81_16.childCount

				for iter_81_8 = 0, var_81_18 - 1 do
					local var_81_19 = var_81_16:GetChild(iter_81_8)

					if var_81_19.name == "" or not string.find(var_81_19.name, "split") then
						var_81_19.gameObject:SetActive(true)
					else
						var_81_19.gameObject:SetActive(false)
					end
				end
			end

			local var_81_20 = 0.001

			if var_81_17 <= arg_78_1.time_ and arg_78_1.time_ < var_81_17 + var_81_20 then
				local var_81_21 = (arg_78_1.time_ - var_81_17) / var_81_20
				local var_81_22 = Vector3.New(390, -347, -300)

				var_81_16.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10128, var_81_22, var_81_21)
			end

			if arg_78_1.time_ >= var_81_17 + var_81_20 and arg_78_1.time_ < var_81_17 + var_81_20 + arg_81_0 then
				var_81_16.localPosition = Vector3.New(390, -347, -300)
			end

			local var_81_23 = 0
			local var_81_24 = 1.3

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_25 = arg_78_1:FormatText(StoryNameCfg[595].name)

				arg_78_1.leftNameTxt_.text = var_81_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_26 = arg_78_1:GetWordFromCfg(417042019)
				local var_81_27 = arg_78_1:FormatText(var_81_26.content)

				arg_78_1.text_.text = var_81_27

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_28 = 52
				local var_81_29 = utf8.len(var_81_27)
				local var_81_30 = var_81_28 <= 0 and var_81_24 or var_81_24 * (var_81_29 / var_81_28)

				if var_81_30 > 0 and var_81_24 < var_81_30 then
					arg_78_1.talkMaxDuration = var_81_30

					if var_81_30 + var_81_23 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_30 + var_81_23
					end
				end

				arg_78_1.text_.text = var_81_27
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042019", "story_v_out_417042.awb") ~= 0 then
					local var_81_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042019", "story_v_out_417042.awb") / 1000

					if var_81_31 + var_81_23 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_31 + var_81_23
					end

					if var_81_26.prefab_name ~= "" and arg_78_1.actors_[var_81_26.prefab_name] ~= nil then
						local var_81_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_26.prefab_name].transform, "story_v_out_417042", "417042019", "story_v_out_417042.awb")

						arg_78_1:RecordAudio("417042019", var_81_32)
						arg_78_1:RecordAudio("417042019", var_81_32)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417042", "417042019", "story_v_out_417042.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417042", "417042019", "story_v_out_417042.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_33 = math.max(var_81_24, arg_78_1.talkMaxDuration)

			if var_81_23 <= arg_78_1.time_ and arg_78_1.time_ < var_81_23 + var_81_33 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_23) / var_81_33

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_23 + var_81_33 and arg_78_1.time_ < var_81_23 + var_81_33 + arg_81_0 then
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
	Play417042020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417042020
		arg_82_1.duration_ = 5.87

		local var_82_0 = {
			zh = 5.366,
			ja = 5.866
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
				arg_82_0:Play417042021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.675

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

				local var_85_3 = arg_82_1:GetWordFromCfg(417042020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042020", "story_v_out_417042.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042020", "story_v_out_417042.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_417042", "417042020", "story_v_out_417042.awb")

						arg_82_1:RecordAudio("417042020", var_85_9)
						arg_82_1:RecordAudio("417042020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417042", "417042020", "story_v_out_417042.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417042", "417042020", "story_v_out_417042.awb")
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
	Play417042021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417042021
		arg_86_1.duration_ = 8.47

		local var_86_0 = {
			zh = 7.06666666666667,
			ja = 8.46666666666667
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
				arg_86_0:Play417042022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = "ST73"

			if arg_86_1.bgs_[var_89_0] == nil then
				local var_89_1 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_89_0)
				var_89_1.name = var_89_0
				var_89_1.transform.parent = arg_86_1.stage_.transform
				var_89_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_[var_89_0] = var_89_1
			end

			local var_89_2 = 1.76666666666667

			if var_89_2 < arg_86_1.time_ and arg_86_1.time_ <= var_89_2 + arg_89_0 then
				local var_89_3 = manager.ui.mainCamera.transform.localPosition
				local var_89_4 = Vector3.New(0, 0, 10) + Vector3.New(var_89_3.x, var_89_3.y, 0)
				local var_89_5 = arg_86_1.bgs_.ST73

				var_89_5.transform.localPosition = var_89_4
				var_89_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_6 = var_89_5:GetComponent("SpriteRenderer")

				if var_89_6 and var_89_6.sprite then
					local var_89_7 = (var_89_5.transform.localPosition - var_89_3).z
					local var_89_8 = manager.ui.mainCameraCom_
					local var_89_9 = 2 * var_89_7 * Mathf.Tan(var_89_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_89_10 = var_89_9 * var_89_8.aspect
					local var_89_11 = var_89_6.sprite.bounds.size.x
					local var_89_12 = var_89_6.sprite.bounds.size.y
					local var_89_13 = var_89_10 / var_89_11
					local var_89_14 = var_89_9 / var_89_12
					local var_89_15 = var_89_14 < var_89_13 and var_89_13 or var_89_14

					var_89_5.transform.localScale = Vector3.New(var_89_15, var_89_15, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "ST73" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_89_16 = 0

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1.allBtn_.enabled = false
			end

			local var_89_17 = 0.3

			if arg_86_1.time_ >= var_89_16 + var_89_17 and arg_86_1.time_ < var_89_16 + var_89_17 + arg_89_0 then
				arg_86_1.allBtn_.enabled = true
			end

			local var_89_18 = 0

			if var_89_18 < arg_86_1.time_ and arg_86_1.time_ <= var_89_18 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_19 = 1.76666666666667

			if var_89_18 <= arg_86_1.time_ and arg_86_1.time_ < var_89_18 + var_89_19 then
				local var_89_20 = (arg_86_1.time_ - var_89_18) / var_89_19
				local var_89_21 = Color.New(0, 0, 0)

				var_89_21.a = Mathf.Lerp(0, 1, var_89_20)
				arg_86_1.mask_.color = var_89_21
			end

			if arg_86_1.time_ >= var_89_18 + var_89_19 and arg_86_1.time_ < var_89_18 + var_89_19 + arg_89_0 then
				local var_89_22 = Color.New(0, 0, 0)

				var_89_22.a = 1
				arg_86_1.mask_.color = var_89_22
			end

			local var_89_23 = 1.76666666666667

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 then
				arg_86_1.mask_.enabled = true
				arg_86_1.mask_.raycastTarget = true

				arg_86_1:SetGaussion(false)
			end

			local var_89_24 = 2.17499999999933

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_24 then
				local var_89_25 = (arg_86_1.time_ - var_89_23) / var_89_24
				local var_89_26 = Color.New(0, 0, 0)

				var_89_26.a = Mathf.Lerp(1, 0, var_89_25)
				arg_86_1.mask_.color = var_89_26
			end

			if arg_86_1.time_ >= var_89_23 + var_89_24 and arg_86_1.time_ < var_89_23 + var_89_24 + arg_89_0 then
				local var_89_27 = Color.New(0, 0, 0)
				local var_89_28 = 0

				arg_86_1.mask_.enabled = false
				var_89_27.a = var_89_28
				arg_86_1.mask_.color = var_89_27
			end

			local var_89_29 = arg_86_1.actors_["10128"].transform
			local var_89_30 = 1.73333333333333

			if var_89_30 < arg_86_1.time_ and arg_86_1.time_ <= var_89_30 + arg_89_0 then
				arg_86_1.var_.moveOldPos10128 = var_89_29.localPosition
				var_89_29.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10128", 7)

				local var_89_31 = var_89_29.childCount

				for iter_89_2 = 0, var_89_31 - 1 do
					local var_89_32 = var_89_29:GetChild(iter_89_2)

					if var_89_32.name == "" or not string.find(var_89_32.name, "split") then
						var_89_32.gameObject:SetActive(true)
					else
						var_89_32.gameObject:SetActive(false)
					end
				end
			end

			local var_89_33 = 0.001

			if var_89_30 <= arg_86_1.time_ and arg_86_1.time_ < var_89_30 + var_89_33 then
				local var_89_34 = (arg_86_1.time_ - var_89_30) / var_89_33
				local var_89_35 = Vector3.New(0, -2000, -300)

				var_89_29.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10128, var_89_35, var_89_34)
			end

			if arg_86_1.time_ >= var_89_30 + var_89_33 and arg_86_1.time_ < var_89_30 + var_89_33 + arg_89_0 then
				var_89_29.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_89_36 = arg_86_1.actors_["1034"].transform
			local var_89_37 = 1.73333333333333

			if var_89_37 < arg_86_1.time_ and arg_86_1.time_ <= var_89_37 + arg_89_0 then
				arg_86_1.var_.moveOldPos1034 = var_89_36.localPosition
				var_89_36.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("1034", 7)

				local var_89_38 = var_89_36.childCount

				for iter_89_3 = 0, var_89_38 - 1 do
					local var_89_39 = var_89_36:GetChild(iter_89_3)

					if var_89_39.name == "" or not string.find(var_89_39.name, "split") then
						var_89_39.gameObject:SetActive(true)
					else
						var_89_39.gameObject:SetActive(false)
					end
				end
			end

			local var_89_40 = 0.001

			if var_89_37 <= arg_86_1.time_ and arg_86_1.time_ < var_89_37 + var_89_40 then
				local var_89_41 = (arg_86_1.time_ - var_89_37) / var_89_40
				local var_89_42 = Vector3.New(0, -2000, 0)

				var_89_36.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1034, var_89_42, var_89_41)
			end

			if arg_86_1.time_ >= var_89_37 + var_89_40 and arg_86_1.time_ < var_89_37 + var_89_40 + arg_89_0 then
				var_89_36.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_43 = 3.76666666666667
			local var_89_44 = 0.375

			if var_89_43 < arg_86_1.time_ and arg_86_1.time_ <= var_89_43 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_45 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_45:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_86_1.dialogCg_.alpha = arg_90_0
				end))
				var_89_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_46 = arg_86_1:FormatText(StoryNameCfg[1113].name)

				arg_86_1.leftNameTxt_.text = var_89_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10115_split_4")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_47 = arg_86_1:GetWordFromCfg(417042021)
				local var_89_48 = arg_86_1:FormatText(var_89_47.content)

				arg_86_1.text_.text = var_89_48

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_49 = 15
				local var_89_50 = utf8.len(var_89_48)
				local var_89_51 = var_89_49 <= 0 and var_89_44 or var_89_44 * (var_89_50 / var_89_49)

				if var_89_51 > 0 and var_89_44 < var_89_51 then
					arg_86_1.talkMaxDuration = var_89_51
					var_89_43 = var_89_43 + 0.3

					if var_89_51 + var_89_43 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_51 + var_89_43
					end
				end

				arg_86_1.text_.text = var_89_48
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042021", "story_v_out_417042.awb") ~= 0 then
					local var_89_52 = manager.audio:GetVoiceLength("story_v_out_417042", "417042021", "story_v_out_417042.awb") / 1000

					if var_89_52 + var_89_43 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_52 + var_89_43
					end

					if var_89_47.prefab_name ~= "" and arg_86_1.actors_[var_89_47.prefab_name] ~= nil then
						local var_89_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_47.prefab_name].transform, "story_v_out_417042", "417042021", "story_v_out_417042.awb")

						arg_86_1:RecordAudio("417042021", var_89_53)
						arg_86_1:RecordAudio("417042021", var_89_53)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417042", "417042021", "story_v_out_417042.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417042", "417042021", "story_v_out_417042.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_54 = var_89_43 + 0.3
			local var_89_55 = math.max(var_89_44, arg_86_1.talkMaxDuration)

			if var_89_54 <= arg_86_1.time_ and arg_86_1.time_ < var_89_54 + var_89_55 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_54) / var_89_55

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_54 + var_89_55 and arg_86_1.time_ < var_89_54 + var_89_55 + arg_89_0 then
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
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play417042022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417042022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play417042023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = "10115"

			if arg_92_1.actors_[var_95_0] == nil then
				local var_95_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_95_1) then
					local var_95_2 = Object.Instantiate(var_95_1, arg_92_1.canvasGo_.transform)

					var_95_2.transform:SetSiblingIndex(1)

					var_95_2.name = var_95_0
					var_95_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_92_1.actors_[var_95_0] = var_95_2

					local var_95_3 = var_95_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_92_1.isInRecall_ then
						for iter_95_0, iter_95_1 in ipairs(var_95_3) do
							iter_95_1.color = arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_95_4 = arg_92_1.actors_["10115"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.actorSpriteComps10115 == nil then
				arg_92_1.var_.actorSpriteComps10115 = var_95_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_6 = 0.2

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.actorSpriteComps10115 then
					for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_95_3 then
							if arg_92_1.isInRecall_ then
								local var_95_8 = Mathf.Lerp(iter_95_3.color.r, arg_92_1.hightColor2.r, var_95_7)
								local var_95_9 = Mathf.Lerp(iter_95_3.color.g, arg_92_1.hightColor2.g, var_95_7)
								local var_95_10 = Mathf.Lerp(iter_95_3.color.b, arg_92_1.hightColor2.b, var_95_7)

								iter_95_3.color = Color.New(var_95_8, var_95_9, var_95_10)
							else
								local var_95_11 = Mathf.Lerp(iter_95_3.color.r, 0.5, var_95_7)

								iter_95_3.color = Color.New(var_95_11, var_95_11, var_95_11)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.actorSpriteComps10115 then
				for iter_95_4, iter_95_5 in pairs(arg_92_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_95_5 then
						if arg_92_1.isInRecall_ then
							iter_95_5.color = arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_95_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_92_1.var_.actorSpriteComps10115 = nil
			end

			local var_95_12 = 0
			local var_95_13 = 0.75

			if var_95_12 < arg_92_1.time_ and arg_92_1.time_ <= var_95_12 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_14 = arg_92_1:GetWordFromCfg(417042022)
				local var_95_15 = arg_92_1:FormatText(var_95_14.content)

				arg_92_1.text_.text = var_95_15

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_16 = 30
				local var_95_17 = utf8.len(var_95_15)
				local var_95_18 = var_95_16 <= 0 and var_95_13 or var_95_13 * (var_95_17 / var_95_16)

				if var_95_18 > 0 and var_95_13 < var_95_18 then
					arg_92_1.talkMaxDuration = var_95_18

					if var_95_18 + var_95_12 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_12
					end
				end

				arg_92_1.text_.text = var_95_15
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_19 = math.max(var_95_13, arg_92_1.talkMaxDuration)

			if var_95_12 <= arg_92_1.time_ and arg_92_1.time_ < var_95_12 + var_95_19 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_12) / var_95_19

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_12 + var_95_19 and arg_92_1.time_ < var_95_12 + var_95_19 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play417042023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417042023
		arg_96_1.duration_ = 1.97

		local var_96_0 = {
			zh = 1.8,
			ja = 1.966
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play417042024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10115"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10115 == nil then
				arg_96_1.var_.actorSpriteComps10115 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps10115 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								local var_99_4 = Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, var_99_3)
								local var_99_5 = Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, var_99_3)
								local var_99_6 = Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, var_99_3)

								iter_99_1.color = Color.New(var_99_4, var_99_5, var_99_6)
							else
								local var_99_7 = Mathf.Lerp(iter_99_1.color.r, 1, var_99_3)

								iter_99_1.color = Color.New(var_99_7, var_99_7, var_99_7)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps10115 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_99_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps10115 = nil
			end

			local var_99_8 = arg_96_1.actors_["10115"].transform
			local var_99_9 = 0

			if var_99_9 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 then
				arg_96_1.var_.moveOldPos10115 = var_99_8.localPosition
				var_99_8.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("10115", 3)

				local var_99_10 = var_99_8.childCount

				for iter_99_4 = 0, var_99_10 - 1 do
					local var_99_11 = var_99_8:GetChild(iter_99_4)

					if var_99_11.name == "" or not string.find(var_99_11.name, "split") then
						var_99_11.gameObject:SetActive(true)
					else
						var_99_11.gameObject:SetActive(false)
					end
				end
			end

			local var_99_12 = 0.001

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_12 then
				local var_99_13 = (arg_96_1.time_ - var_99_9) / var_99_12
				local var_99_14 = Vector3.New(0, -387.3, -246.2)

				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10115, var_99_14, var_99_13)
			end

			if arg_96_1.time_ >= var_99_9 + var_99_12 and arg_96_1.time_ < var_99_9 + var_99_12 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_99_15 = 0
			local var_99_16 = 0.2

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[1113].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(417042023)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 8
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042023", "story_v_out_417042.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_out_417042", "417042023", "story_v_out_417042.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_out_417042", "417042023", "story_v_out_417042.awb")

						arg_96_1:RecordAudio("417042023", var_99_24)
						arg_96_1:RecordAudio("417042023", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417042", "417042023", "story_v_out_417042.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417042", "417042023", "story_v_out_417042.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play417042024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417042024
		arg_100_1.duration_ = 4.2

		local var_100_0 = {
			zh = 1.5,
			ja = 4.2
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play417042025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1034"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1034 == nil then
				arg_100_1.var_.actorSpriteComps1034 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps1034 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 1, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1034 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_103_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps1034 = nil
			end

			local var_103_8 = arg_100_1.actors_["10115"]
			local var_103_9 = 0

			if var_103_9 < arg_100_1.time_ and arg_100_1.time_ <= var_103_9 + arg_103_0 and not isNil(var_103_8) and arg_100_1.var_.actorSpriteComps10115 == nil then
				arg_100_1.var_.actorSpriteComps10115 = var_103_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_10 = 0.2

			if var_103_9 <= arg_100_1.time_ and arg_100_1.time_ < var_103_9 + var_103_10 and not isNil(var_103_8) then
				local var_103_11 = (arg_100_1.time_ - var_103_9) / var_103_10

				if arg_100_1.var_.actorSpriteComps10115 then
					for iter_103_4, iter_103_5 in pairs(arg_100_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_103_5 then
							if arg_100_1.isInRecall_ then
								local var_103_12 = Mathf.Lerp(iter_103_5.color.r, arg_100_1.hightColor2.r, var_103_11)
								local var_103_13 = Mathf.Lerp(iter_103_5.color.g, arg_100_1.hightColor2.g, var_103_11)
								local var_103_14 = Mathf.Lerp(iter_103_5.color.b, arg_100_1.hightColor2.b, var_103_11)

								iter_103_5.color = Color.New(var_103_12, var_103_13, var_103_14)
							else
								local var_103_15 = Mathf.Lerp(iter_103_5.color.r, 0.5, var_103_11)

								iter_103_5.color = Color.New(var_103_15, var_103_15, var_103_15)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_9 + var_103_10 and arg_100_1.time_ < var_103_9 + var_103_10 + arg_103_0 and not isNil(var_103_8) and arg_100_1.var_.actorSpriteComps10115 then
				for iter_103_6, iter_103_7 in pairs(arg_100_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_103_7 then
						if arg_100_1.isInRecall_ then
							iter_103_7.color = arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_103_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps10115 = nil
			end

			local var_103_16 = arg_100_1.actors_["10115"].transform
			local var_103_17 = 0

			if var_103_17 < arg_100_1.time_ and arg_100_1.time_ <= var_103_17 + arg_103_0 then
				arg_100_1.var_.moveOldPos10115 = var_103_16.localPosition
				var_103_16.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10115", 7)

				local var_103_18 = var_103_16.childCount

				for iter_103_8 = 0, var_103_18 - 1 do
					local var_103_19 = var_103_16:GetChild(iter_103_8)

					if var_103_19.name == "" or not string.find(var_103_19.name, "split") then
						var_103_19.gameObject:SetActive(true)
					else
						var_103_19.gameObject:SetActive(false)
					end
				end
			end

			local var_103_20 = 0.001

			if var_103_17 <= arg_100_1.time_ and arg_100_1.time_ < var_103_17 + var_103_20 then
				local var_103_21 = (arg_100_1.time_ - var_103_17) / var_103_20
				local var_103_22 = Vector3.New(0, -2000, 0)

				var_103_16.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10115, var_103_22, var_103_21)
			end

			if arg_100_1.time_ >= var_103_17 + var_103_20 and arg_100_1.time_ < var_103_17 + var_103_20 + arg_103_0 then
				var_103_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_103_23 = arg_100_1.actors_["1034"].transform
			local var_103_24 = 0

			if var_103_24 < arg_100_1.time_ and arg_100_1.time_ <= var_103_24 + arg_103_0 then
				arg_100_1.var_.moveOldPos1034 = var_103_23.localPosition
				var_103_23.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("1034", 3)

				local var_103_25 = var_103_23.childCount

				for iter_103_9 = 0, var_103_25 - 1 do
					local var_103_26 = var_103_23:GetChild(iter_103_9)

					if var_103_26.name == "split_6" or not string.find(var_103_26.name, "split") then
						var_103_26.gameObject:SetActive(true)
					else
						var_103_26.gameObject:SetActive(false)
					end
				end
			end

			local var_103_27 = 0.001

			if var_103_24 <= arg_100_1.time_ and arg_100_1.time_ < var_103_24 + var_103_27 then
				local var_103_28 = (arg_100_1.time_ - var_103_24) / var_103_27
				local var_103_29 = Vector3.New(0, -331.9, -324)

				var_103_23.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1034, var_103_29, var_103_28)
			end

			if arg_100_1.time_ >= var_103_24 + var_103_27 and arg_100_1.time_ < var_103_24 + var_103_27 + arg_103_0 then
				var_103_23.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_103_30 = 0
			local var_103_31 = 0.2

			if var_103_30 < arg_100_1.time_ and arg_100_1.time_ <= var_103_30 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_32 = arg_100_1:FormatText(StoryNameCfg[1109].name)

				arg_100_1.leftNameTxt_.text = var_103_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_33 = arg_100_1:GetWordFromCfg(417042024)
				local var_103_34 = arg_100_1:FormatText(var_103_33.content)

				arg_100_1.text_.text = var_103_34

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_35 = 8
				local var_103_36 = utf8.len(var_103_34)
				local var_103_37 = var_103_35 <= 0 and var_103_31 or var_103_31 * (var_103_36 / var_103_35)

				if var_103_37 > 0 and var_103_31 < var_103_37 then
					arg_100_1.talkMaxDuration = var_103_37

					if var_103_37 + var_103_30 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_37 + var_103_30
					end
				end

				arg_100_1.text_.text = var_103_34
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042024", "story_v_out_417042.awb") ~= 0 then
					local var_103_38 = manager.audio:GetVoiceLength("story_v_out_417042", "417042024", "story_v_out_417042.awb") / 1000

					if var_103_38 + var_103_30 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_38 + var_103_30
					end

					if var_103_33.prefab_name ~= "" and arg_100_1.actors_[var_103_33.prefab_name] ~= nil then
						local var_103_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_33.prefab_name].transform, "story_v_out_417042", "417042024", "story_v_out_417042.awb")

						arg_100_1:RecordAudio("417042024", var_103_39)
						arg_100_1:RecordAudio("417042024", var_103_39)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417042", "417042024", "story_v_out_417042.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417042", "417042024", "story_v_out_417042.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_40 = math.max(var_103_31, arg_100_1.talkMaxDuration)

			if var_103_30 <= arg_100_1.time_ and arg_100_1.time_ < var_103_30 + var_103_40 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_30) / var_103_40

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_30 + var_103_40 and arg_100_1.time_ < var_103_30 + var_103_40 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
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

		arg_100_1:InitPlayNodeList()
	end,
	Play417042025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417042025
		arg_104_1.duration_ = 3.47

		local var_104_0 = {
			zh = 1.2,
			ja = 3.466
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
				arg_104_0:Play417042026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10115"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10115 == nil then
				arg_104_1.var_.actorSpriteComps10115 = var_107_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.actorSpriteComps10115 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								local var_107_4 = Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor1.r, var_107_3)
								local var_107_5 = Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor1.g, var_107_3)
								local var_107_6 = Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor1.b, var_107_3)

								iter_107_1.color = Color.New(var_107_4, var_107_5, var_107_6)
							else
								local var_107_7 = Mathf.Lerp(iter_107_1.color.r, 1, var_107_3)

								iter_107_1.color = Color.New(var_107_7, var_107_7, var_107_7)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.actorSpriteComps10115 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_107_3 then
						if arg_104_1.isInRecall_ then
							iter_107_3.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_107_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps10115 = nil
			end

			local var_107_8 = arg_104_1.actors_["1034"]
			local var_107_9 = 0

			if var_107_9 < arg_104_1.time_ and arg_104_1.time_ <= var_107_9 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps1034 == nil then
				arg_104_1.var_.actorSpriteComps1034 = var_107_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_10 = 0.2

			if var_107_9 <= arg_104_1.time_ and arg_104_1.time_ < var_107_9 + var_107_10 and not isNil(var_107_8) then
				local var_107_11 = (arg_104_1.time_ - var_107_9) / var_107_10

				if arg_104_1.var_.actorSpriteComps1034 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								local var_107_12 = Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor2.r, var_107_11)
								local var_107_13 = Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor2.g, var_107_11)
								local var_107_14 = Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor2.b, var_107_11)

								iter_107_5.color = Color.New(var_107_12, var_107_13, var_107_14)
							else
								local var_107_15 = Mathf.Lerp(iter_107_5.color.r, 0.5, var_107_11)

								iter_107_5.color = Color.New(var_107_15, var_107_15, var_107_15)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= var_107_9 + var_107_10 and arg_104_1.time_ < var_107_9 + var_107_10 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps1034 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_107_7 then
						if arg_104_1.isInRecall_ then
							iter_107_7.color = arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_107_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_104_1.var_.actorSpriteComps1034 = nil
			end

			local var_107_16 = arg_104_1.actors_["1034"].transform
			local var_107_17 = 0

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.var_.moveOldPos1034 = var_107_16.localPosition
				var_107_16.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1034", 4)

				local var_107_18 = var_107_16.childCount

				for iter_107_8 = 0, var_107_18 - 1 do
					local var_107_19 = var_107_16:GetChild(iter_107_8)

					if var_107_19.name == "split_6" or not string.find(var_107_19.name, "split") then
						var_107_19.gameObject:SetActive(true)
					else
						var_107_19.gameObject:SetActive(false)
					end
				end
			end

			local var_107_20 = 0.001

			if var_107_17 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_20 then
				local var_107_21 = (arg_104_1.time_ - var_107_17) / var_107_20
				local var_107_22 = Vector3.New(373.7, -331.9, -324)

				var_107_16.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1034, var_107_22, var_107_21)
			end

			if arg_104_1.time_ >= var_107_17 + var_107_20 and arg_104_1.time_ < var_107_17 + var_107_20 + arg_107_0 then
				var_107_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_107_23 = arg_104_1.actors_["10115"].transform
			local var_107_24 = 0

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 then
				arg_104_1.var_.moveOldPos10115 = var_107_23.localPosition
				var_107_23.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10115", 2)

				local var_107_25 = var_107_23.childCount

				for iter_107_9 = 0, var_107_25 - 1 do
					local var_107_26 = var_107_23:GetChild(iter_107_9)

					if var_107_26.name == "split_6" or not string.find(var_107_26.name, "split") then
						var_107_26.gameObject:SetActive(true)
					else
						var_107_26.gameObject:SetActive(false)
					end
				end
			end

			local var_107_27 = 0.001

			if var_107_24 <= arg_104_1.time_ and arg_104_1.time_ < var_107_24 + var_107_27 then
				local var_107_28 = (arg_104_1.time_ - var_107_24) / var_107_27
				local var_107_29 = Vector3.New(-390, -387.3, -246.2)

				var_107_23.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10115, var_107_29, var_107_28)
			end

			if arg_104_1.time_ >= var_107_24 + var_107_27 and arg_104_1.time_ < var_107_24 + var_107_27 + arg_107_0 then
				var_107_23.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_107_30 = 0
			local var_107_31 = 0.125

			if var_107_30 < arg_104_1.time_ and arg_104_1.time_ <= var_107_30 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_32 = arg_104_1:FormatText(StoryNameCfg[1113].name)

				arg_104_1.leftNameTxt_.text = var_107_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_33 = arg_104_1:GetWordFromCfg(417042025)
				local var_107_34 = arg_104_1:FormatText(var_107_33.content)

				arg_104_1.text_.text = var_107_34

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_35 = 5
				local var_107_36 = utf8.len(var_107_34)
				local var_107_37 = var_107_35 <= 0 and var_107_31 or var_107_31 * (var_107_36 / var_107_35)

				if var_107_37 > 0 and var_107_31 < var_107_37 then
					arg_104_1.talkMaxDuration = var_107_37

					if var_107_37 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_37 + var_107_30
					end
				end

				arg_104_1.text_.text = var_107_34
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042025", "story_v_out_417042.awb") ~= 0 then
					local var_107_38 = manager.audio:GetVoiceLength("story_v_out_417042", "417042025", "story_v_out_417042.awb") / 1000

					if var_107_38 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_38 + var_107_30
					end

					if var_107_33.prefab_name ~= "" and arg_104_1.actors_[var_107_33.prefab_name] ~= nil then
						local var_107_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_33.prefab_name].transform, "story_v_out_417042", "417042025", "story_v_out_417042.awb")

						arg_104_1:RecordAudio("417042025", var_107_39)
						arg_104_1:RecordAudio("417042025", var_107_39)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417042", "417042025", "story_v_out_417042.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417042", "417042025", "story_v_out_417042.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_40 = math.max(var_107_31, arg_104_1.talkMaxDuration)

			if var_107_30 <= arg_104_1.time_ and arg_104_1.time_ < var_107_30 + var_107_40 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_30) / var_107_40

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_30 + var_107_40 and arg_104_1.time_ < var_107_30 + var_107_40 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play417042026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417042026
		arg_108_1.duration_ = 1.47

		local var_108_0 = {
			zh = 0.999999999999,
			ja = 1.466
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
				arg_108_0:Play417042027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1034"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1034 == nil then
				arg_108_1.var_.actorSpriteComps1034 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps1034 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1034 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1034 = nil
			end

			local var_111_8 = arg_108_1.actors_["10115"]
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10115 == nil then
				arg_108_1.var_.actorSpriteComps10115 = var_111_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_10 = 0.2

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 and not isNil(var_111_8) then
				local var_111_11 = (arg_108_1.time_ - var_111_9) / var_111_10

				if arg_108_1.var_.actorSpriteComps10115 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								local var_111_12 = Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor2.r, var_111_11)
								local var_111_13 = Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor2.g, var_111_11)
								local var_111_14 = Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor2.b, var_111_11)

								iter_111_5.color = Color.New(var_111_12, var_111_13, var_111_14)
							else
								local var_111_15 = Mathf.Lerp(iter_111_5.color.r, 0.5, var_111_11)

								iter_111_5.color = Color.New(var_111_15, var_111_15, var_111_15)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 and not isNil(var_111_8) and arg_108_1.var_.actorSpriteComps10115 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_111_7 then
						if arg_108_1.isInRecall_ then
							iter_111_7.color = arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_111_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps10115 = nil
			end

			local var_111_16 = 0
			local var_111_17 = 0.075

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_18 = arg_108_1:FormatText(StoryNameCfg[1109].name)

				arg_108_1.leftNameTxt_.text = var_111_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_19 = arg_108_1:GetWordFromCfg(417042026)
				local var_111_20 = arg_108_1:FormatText(var_111_19.content)

				arg_108_1.text_.text = var_111_20

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_21 = 3
				local var_111_22 = utf8.len(var_111_20)
				local var_111_23 = var_111_21 <= 0 and var_111_17 or var_111_17 * (var_111_22 / var_111_21)

				if var_111_23 > 0 and var_111_17 < var_111_23 then
					arg_108_1.talkMaxDuration = var_111_23

					if var_111_23 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_16
					end
				end

				arg_108_1.text_.text = var_111_20
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042026", "story_v_out_417042.awb") ~= 0 then
					local var_111_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042026", "story_v_out_417042.awb") / 1000

					if var_111_24 + var_111_16 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_24 + var_111_16
					end

					if var_111_19.prefab_name ~= "" and arg_108_1.actors_[var_111_19.prefab_name] ~= nil then
						local var_111_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_19.prefab_name].transform, "story_v_out_417042", "417042026", "story_v_out_417042.awb")

						arg_108_1:RecordAudio("417042026", var_111_25)
						arg_108_1:RecordAudio("417042026", var_111_25)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417042", "417042026", "story_v_out_417042.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417042", "417042026", "story_v_out_417042.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_26 = math.max(var_111_17, arg_108_1.talkMaxDuration)

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_26 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_16) / var_111_26

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_16 + var_111_26 and arg_108_1.time_ < var_111_16 + var_111_26 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play417042027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417042027
		arg_112_1.duration_ = 7.13

		local var_112_0 = {
			zh = 7.133,
			ja = 6.233
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417042028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10115"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10115 == nil then
				arg_112_1.var_.actorSpriteComps10115 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps10115 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								local var_115_4 = Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, var_115_3)
								local var_115_5 = Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, var_115_3)
								local var_115_6 = Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, var_115_3)

								iter_115_1.color = Color.New(var_115_4, var_115_5, var_115_6)
							else
								local var_115_7 = Mathf.Lerp(iter_115_1.color.r, 1, var_115_3)

								iter_115_1.color = Color.New(var_115_7, var_115_7, var_115_7)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps10115 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_115_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps10115 = nil
			end

			local var_115_8 = arg_112_1.actors_["1034"]
			local var_115_9 = 0

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps1034 == nil then
				arg_112_1.var_.actorSpriteComps1034 = var_115_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_10 = 0.2

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_10 and not isNil(var_115_8) then
				local var_115_11 = (arg_112_1.time_ - var_115_9) / var_115_10

				if arg_112_1.var_.actorSpriteComps1034 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_115_5 then
							if arg_112_1.isInRecall_ then
								local var_115_12 = Mathf.Lerp(iter_115_5.color.r, arg_112_1.hightColor2.r, var_115_11)
								local var_115_13 = Mathf.Lerp(iter_115_5.color.g, arg_112_1.hightColor2.g, var_115_11)
								local var_115_14 = Mathf.Lerp(iter_115_5.color.b, arg_112_1.hightColor2.b, var_115_11)

								iter_115_5.color = Color.New(var_115_12, var_115_13, var_115_14)
							else
								local var_115_15 = Mathf.Lerp(iter_115_5.color.r, 0.5, var_115_11)

								iter_115_5.color = Color.New(var_115_15, var_115_15, var_115_15)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= var_115_9 + var_115_10 and arg_112_1.time_ < var_115_9 + var_115_10 + arg_115_0 and not isNil(var_115_8) and arg_112_1.var_.actorSpriteComps1034 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_115_7 then
						if arg_112_1.isInRecall_ then
							iter_115_7.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1034 = nil
			end

			local var_115_16 = arg_112_1.actors_["10115"].transform
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 then
				arg_112_1.var_.moveOldPos10115 = var_115_16.localPosition
				var_115_16.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("10115", 2)

				local var_115_18 = var_115_16.childCount

				for iter_115_8 = 0, var_115_18 - 1 do
					local var_115_19 = var_115_16:GetChild(iter_115_8)

					if var_115_19.name == "split_4" or not string.find(var_115_19.name, "split") then
						var_115_19.gameObject:SetActive(true)
					else
						var_115_19.gameObject:SetActive(false)
					end
				end
			end

			local var_115_20 = 0.001

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_20 then
				local var_115_21 = (arg_112_1.time_ - var_115_17) / var_115_20
				local var_115_22 = Vector3.New(-390, -387.3, -246.2)

				var_115_16.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10115, var_115_22, var_115_21)
			end

			if arg_112_1.time_ >= var_115_17 + var_115_20 and arg_112_1.time_ < var_115_17 + var_115_20 + arg_115_0 then
				var_115_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_115_23 = 0
			local var_115_24 = 0.975

			if var_115_23 < arg_112_1.time_ and arg_112_1.time_ <= var_115_23 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_25 = arg_112_1:FormatText(StoryNameCfg[1113].name)

				arg_112_1.leftNameTxt_.text = var_115_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_26 = arg_112_1:GetWordFromCfg(417042027)
				local var_115_27 = arg_112_1:FormatText(var_115_26.content)

				arg_112_1.text_.text = var_115_27

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_28 = 39
				local var_115_29 = utf8.len(var_115_27)
				local var_115_30 = var_115_28 <= 0 and var_115_24 or var_115_24 * (var_115_29 / var_115_28)

				if var_115_30 > 0 and var_115_24 < var_115_30 then
					arg_112_1.talkMaxDuration = var_115_30

					if var_115_30 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_23
					end
				end

				arg_112_1.text_.text = var_115_27
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042027", "story_v_out_417042.awb") ~= 0 then
					local var_115_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042027", "story_v_out_417042.awb") / 1000

					if var_115_31 + var_115_23 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_31 + var_115_23
					end

					if var_115_26.prefab_name ~= "" and arg_112_1.actors_[var_115_26.prefab_name] ~= nil then
						local var_115_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_26.prefab_name].transform, "story_v_out_417042", "417042027", "story_v_out_417042.awb")

						arg_112_1:RecordAudio("417042027", var_115_32)
						arg_112_1:RecordAudio("417042027", var_115_32)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417042", "417042027", "story_v_out_417042.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417042", "417042027", "story_v_out_417042.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_33 = math.max(var_115_24, arg_112_1.talkMaxDuration)

			if var_115_23 <= arg_112_1.time_ and arg_112_1.time_ < var_115_23 + var_115_33 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_23) / var_115_33

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_23 + var_115_33 and arg_112_1.time_ < var_115_23 + var_115_33 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play417042028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417042028
		arg_116_1.duration_ = 9.57

		local var_116_0 = {
			zh = 5,
			ja = 9.566
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play417042029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10115"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos10115 = var_119_0.localPosition
				var_119_0.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("10115", 2)

				local var_119_2 = var_119_0.childCount

				for iter_119_0 = 0, var_119_2 - 1 do
					local var_119_3 = var_119_0:GetChild(iter_119_0)

					if var_119_3.name == "" or not string.find(var_119_3.name, "split") then
						var_119_3.gameObject:SetActive(true)
					else
						var_119_3.gameObject:SetActive(false)
					end
				end
			end

			local var_119_4 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_4 then
				local var_119_5 = (arg_116_1.time_ - var_119_1) / var_119_4
				local var_119_6 = Vector3.New(-390, -387.3, -246.2)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10115, var_119_6, var_119_5)
			end

			if arg_116_1.time_ >= var_119_1 + var_119_4 and arg_116_1.time_ < var_119_1 + var_119_4 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_119_7 = 0
			local var_119_8 = 0.7

			if var_119_7 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_9 = arg_116_1:FormatText(StoryNameCfg[1113].name)

				arg_116_1.leftNameTxt_.text = var_119_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_10 = arg_116_1:GetWordFromCfg(417042028)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_12 = 28
				local var_119_13 = utf8.len(var_119_11)
				local var_119_14 = var_119_12 <= 0 and var_119_8 or var_119_8 * (var_119_13 / var_119_12)

				if var_119_14 > 0 and var_119_8 < var_119_14 then
					arg_116_1.talkMaxDuration = var_119_14

					if var_119_14 + var_119_7 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_7
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042028", "story_v_out_417042.awb") ~= 0 then
					local var_119_15 = manager.audio:GetVoiceLength("story_v_out_417042", "417042028", "story_v_out_417042.awb") / 1000

					if var_119_15 + var_119_7 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_7
					end

					if var_119_10.prefab_name ~= "" and arg_116_1.actors_[var_119_10.prefab_name] ~= nil then
						local var_119_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_10.prefab_name].transform, "story_v_out_417042", "417042028", "story_v_out_417042.awb")

						arg_116_1:RecordAudio("417042028", var_119_16)
						arg_116_1:RecordAudio("417042028", var_119_16)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417042", "417042028", "story_v_out_417042.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417042", "417042028", "story_v_out_417042.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_17 = math.max(var_119_8, arg_116_1.talkMaxDuration)

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_17 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_7) / var_119_17

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_7 + var_119_17 and arg_116_1.time_ < var_119_7 + var_119_17 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play417042029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417042029
		arg_120_1.duration_ = 5.8

		local var_120_0 = {
			zh = 3.666,
			ja = 5.8
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
				arg_120_0:Play417042030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1034"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1034 == nil then
				arg_120_1.var_.actorSpriteComps1034 = var_123_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_2 = 0.2

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.actorSpriteComps1034 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								local var_123_4 = Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, var_123_3)
								local var_123_5 = Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, var_123_3)
								local var_123_6 = Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, var_123_3)

								iter_123_1.color = Color.New(var_123_4, var_123_5, var_123_6)
							else
								local var_123_7 = Mathf.Lerp(iter_123_1.color.r, 1, var_123_3)

								iter_123_1.color = Color.New(var_123_7, var_123_7, var_123_7)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.actorSpriteComps1034 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_123_3 then
						if arg_120_1.isInRecall_ then
							iter_123_3.color = arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_123_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps1034 = nil
			end

			local var_123_8 = arg_120_1.actors_["10115"]
			local var_123_9 = 0

			if var_123_9 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps10115 == nil then
				arg_120_1.var_.actorSpriteComps10115 = var_123_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_10 = 0.2

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 and not isNil(var_123_8) then
				local var_123_11 = (arg_120_1.time_ - var_123_9) / var_123_10

				if arg_120_1.var_.actorSpriteComps10115 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								local var_123_12 = Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, var_123_11)
								local var_123_13 = Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, var_123_11)
								local var_123_14 = Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, var_123_11)

								iter_123_5.color = Color.New(var_123_12, var_123_13, var_123_14)
							else
								local var_123_15 = Mathf.Lerp(iter_123_5.color.r, 0.5, var_123_11)

								iter_123_5.color = Color.New(var_123_15, var_123_15, var_123_15)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 and not isNil(var_123_8) and arg_120_1.var_.actorSpriteComps10115 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_123_7 then
						if arg_120_1.isInRecall_ then
							iter_123_7.color = arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_123_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_120_1.var_.actorSpriteComps10115 = nil
			end

			local var_123_16 = arg_120_1.actors_["1034"].transform
			local var_123_17 = 0

			if var_123_17 < arg_120_1.time_ and arg_120_1.time_ <= var_123_17 + arg_123_0 then
				arg_120_1.var_.moveOldPos1034 = var_123_16.localPosition
				var_123_16.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("1034", 4)

				local var_123_18 = var_123_16.childCount

				for iter_123_8 = 0, var_123_18 - 1 do
					local var_123_19 = var_123_16:GetChild(iter_123_8)

					if var_123_19.name == "split_3" or not string.find(var_123_19.name, "split") then
						var_123_19.gameObject:SetActive(true)
					else
						var_123_19.gameObject:SetActive(false)
					end
				end
			end

			local var_123_20 = 0.001

			if var_123_17 <= arg_120_1.time_ and arg_120_1.time_ < var_123_17 + var_123_20 then
				local var_123_21 = (arg_120_1.time_ - var_123_17) / var_123_20
				local var_123_22 = Vector3.New(373.7, -331.9, -324)

				var_123_16.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1034, var_123_22, var_123_21)
			end

			if arg_120_1.time_ >= var_123_17 + var_123_20 and arg_120_1.time_ < var_123_17 + var_123_20 + arg_123_0 then
				var_123_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_123_23 = 0
			local var_123_24 = 0.425

			if var_123_23 < arg_120_1.time_ and arg_120_1.time_ <= var_123_23 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_25 = arg_120_1:FormatText(StoryNameCfg[1109].name)

				arg_120_1.leftNameTxt_.text = var_123_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_26 = arg_120_1:GetWordFromCfg(417042029)
				local var_123_27 = arg_120_1:FormatText(var_123_26.content)

				arg_120_1.text_.text = var_123_27

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_28 = 17
				local var_123_29 = utf8.len(var_123_27)
				local var_123_30 = var_123_28 <= 0 and var_123_24 or var_123_24 * (var_123_29 / var_123_28)

				if var_123_30 > 0 and var_123_24 < var_123_30 then
					arg_120_1.talkMaxDuration = var_123_30

					if var_123_30 + var_123_23 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_30 + var_123_23
					end
				end

				arg_120_1.text_.text = var_123_27
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042029", "story_v_out_417042.awb") ~= 0 then
					local var_123_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042029", "story_v_out_417042.awb") / 1000

					if var_123_31 + var_123_23 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_31 + var_123_23
					end

					if var_123_26.prefab_name ~= "" and arg_120_1.actors_[var_123_26.prefab_name] ~= nil then
						local var_123_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_26.prefab_name].transform, "story_v_out_417042", "417042029", "story_v_out_417042.awb")

						arg_120_1:RecordAudio("417042029", var_123_32)
						arg_120_1:RecordAudio("417042029", var_123_32)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417042", "417042029", "story_v_out_417042.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417042", "417042029", "story_v_out_417042.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_33 = math.max(var_123_24, arg_120_1.talkMaxDuration)

			if var_123_23 <= arg_120_1.time_ and arg_120_1.time_ < var_123_23 + var_123_33 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_23) / var_123_33

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_23 + var_123_33 and arg_120_1.time_ < var_123_23 + var_123_33 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play417042030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417042030
		arg_124_1.duration_ = 8.9

		local var_124_0 = {
			zh = 6.966,
			ja = 8.9
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
				arg_124_0:Play417042031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10115"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10115 == nil then
				arg_124_1.var_.actorSpriteComps10115 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps10115 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps10115 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps10115 = nil
			end

			local var_127_8 = arg_124_1.actors_["1034"]
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = var_127_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_10 = 0.2

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_10 and not isNil(var_127_8) then
				local var_127_11 = (arg_124_1.time_ - var_127_9) / var_127_10

				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								local var_127_12 = Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor2.r, var_127_11)
								local var_127_13 = Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor2.g, var_127_11)
								local var_127_14 = Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor2.b, var_127_11)

								iter_127_5.color = Color.New(var_127_12, var_127_13, var_127_14)
							else
								local var_127_15 = Mathf.Lerp(iter_127_5.color.r, 0.5, var_127_11)

								iter_127_5.color = Color.New(var_127_15, var_127_15, var_127_15)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_9 + var_127_10 and arg_124_1.time_ < var_127_9 + var_127_10 + arg_127_0 and not isNil(var_127_8) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_7 then
						if arg_124_1.isInRecall_ then
							iter_127_7.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_16 = arg_124_1.actors_["10115"].transform
			local var_127_17 = 0

			if var_127_17 < arg_124_1.time_ and arg_124_1.time_ <= var_127_17 + arg_127_0 then
				arg_124_1.var_.moveOldPos10115 = var_127_16.localPosition
				var_127_16.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("10115", 2)

				local var_127_18 = var_127_16.childCount

				for iter_127_8 = 0, var_127_18 - 1 do
					local var_127_19 = var_127_16:GetChild(iter_127_8)

					if var_127_19.name == "split_1" or not string.find(var_127_19.name, "split") then
						var_127_19.gameObject:SetActive(true)
					else
						var_127_19.gameObject:SetActive(false)
					end
				end
			end

			local var_127_20 = 0.001

			if var_127_17 <= arg_124_1.time_ and arg_124_1.time_ < var_127_17 + var_127_20 then
				local var_127_21 = (arg_124_1.time_ - var_127_17) / var_127_20
				local var_127_22 = Vector3.New(-390, -387.3, -246.2)

				var_127_16.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10115, var_127_22, var_127_21)
			end

			if arg_124_1.time_ >= var_127_17 + var_127_20 and arg_124_1.time_ < var_127_17 + var_127_20 + arg_127_0 then
				var_127_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_127_23 = 0
			local var_127_24 = 0.775

			if var_127_23 < arg_124_1.time_ and arg_124_1.time_ <= var_127_23 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_25 = arg_124_1:FormatText(StoryNameCfg[1113].name)

				arg_124_1.leftNameTxt_.text = var_127_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_26 = arg_124_1:GetWordFromCfg(417042030)
				local var_127_27 = arg_124_1:FormatText(var_127_26.content)

				arg_124_1.text_.text = var_127_27

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_28 = 31
				local var_127_29 = utf8.len(var_127_27)
				local var_127_30 = var_127_28 <= 0 and var_127_24 or var_127_24 * (var_127_29 / var_127_28)

				if var_127_30 > 0 and var_127_24 < var_127_30 then
					arg_124_1.talkMaxDuration = var_127_30

					if var_127_30 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_30 + var_127_23
					end
				end

				arg_124_1.text_.text = var_127_27
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042030", "story_v_out_417042.awb") ~= 0 then
					local var_127_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042030", "story_v_out_417042.awb") / 1000

					if var_127_31 + var_127_23 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_31 + var_127_23
					end

					if var_127_26.prefab_name ~= "" and arg_124_1.actors_[var_127_26.prefab_name] ~= nil then
						local var_127_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_26.prefab_name].transform, "story_v_out_417042", "417042030", "story_v_out_417042.awb")

						arg_124_1:RecordAudio("417042030", var_127_32)
						arg_124_1:RecordAudio("417042030", var_127_32)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417042", "417042030", "story_v_out_417042.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417042", "417042030", "story_v_out_417042.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_33 = math.max(var_127_24, arg_124_1.talkMaxDuration)

			if var_127_23 <= arg_124_1.time_ and arg_124_1.time_ < var_127_23 + var_127_33 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_23) / var_127_33

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_23 + var_127_33 and arg_124_1.time_ < var_127_23 + var_127_33 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play417042031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417042031
		arg_128_1.duration_ = 6.37

		local var_128_0 = {
			zh = 1.4,
			ja = 6.366
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
				arg_128_0:Play417042032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1034"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1034 == nil then
				arg_128_1.var_.actorSpriteComps1034 = var_131_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_2 = 0.2

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.actorSpriteComps1034 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								local var_131_4 = Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, var_131_3)
								local var_131_5 = Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, var_131_3)
								local var_131_6 = Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, var_131_3)

								iter_131_1.color = Color.New(var_131_4, var_131_5, var_131_6)
							else
								local var_131_7 = Mathf.Lerp(iter_131_1.color.r, 1, var_131_3)

								iter_131_1.color = Color.New(var_131_7, var_131_7, var_131_7)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.actorSpriteComps1034 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_131_3 then
						if arg_128_1.isInRecall_ then
							iter_131_3.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1034 = nil
			end

			local var_131_8 = arg_128_1.actors_["10115"]
			local var_131_9 = 0

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps10115 == nil then
				arg_128_1.var_.actorSpriteComps10115 = var_131_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_10 = 0.2

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_10 and not isNil(var_131_8) then
				local var_131_11 = (arg_128_1.time_ - var_131_9) / var_131_10

				if arg_128_1.var_.actorSpriteComps10115 then
					for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_131_5 then
							if arg_128_1.isInRecall_ then
								local var_131_12 = Mathf.Lerp(iter_131_5.color.r, arg_128_1.hightColor2.r, var_131_11)
								local var_131_13 = Mathf.Lerp(iter_131_5.color.g, arg_128_1.hightColor2.g, var_131_11)
								local var_131_14 = Mathf.Lerp(iter_131_5.color.b, arg_128_1.hightColor2.b, var_131_11)

								iter_131_5.color = Color.New(var_131_12, var_131_13, var_131_14)
							else
								local var_131_15 = Mathf.Lerp(iter_131_5.color.r, 0.5, var_131_11)

								iter_131_5.color = Color.New(var_131_15, var_131_15, var_131_15)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_9 + var_131_10 and arg_128_1.time_ < var_131_9 + var_131_10 + arg_131_0 and not isNil(var_131_8) and arg_128_1.var_.actorSpriteComps10115 then
				for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_131_7 then
						if arg_128_1.isInRecall_ then
							iter_131_7.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps10115 = nil
			end

			local var_131_16 = arg_128_1.actors_["1034"].transform
			local var_131_17 = 0

			if var_131_17 < arg_128_1.time_ and arg_128_1.time_ <= var_131_17 + arg_131_0 then
				arg_128_1.var_.moveOldPos1034 = var_131_16.localPosition
				var_131_16.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1034", 4)

				local var_131_18 = var_131_16.childCount

				for iter_131_8 = 0, var_131_18 - 1 do
					local var_131_19 = var_131_16:GetChild(iter_131_8)

					if var_131_19.name == "split_6" or not string.find(var_131_19.name, "split") then
						var_131_19.gameObject:SetActive(true)
					else
						var_131_19.gameObject:SetActive(false)
					end
				end
			end

			local var_131_20 = 0.001

			if var_131_17 <= arg_128_1.time_ and arg_128_1.time_ < var_131_17 + var_131_20 then
				local var_131_21 = (arg_128_1.time_ - var_131_17) / var_131_20
				local var_131_22 = Vector3.New(373.7, -331.9, -324)

				var_131_16.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1034, var_131_22, var_131_21)
			end

			if arg_128_1.time_ >= var_131_17 + var_131_20 and arg_128_1.time_ < var_131_17 + var_131_20 + arg_131_0 then
				var_131_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_131_23 = 0
			local var_131_24 = 0.175

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_25 = arg_128_1:FormatText(StoryNameCfg[1109].name)

				arg_128_1.leftNameTxt_.text = var_131_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_26 = arg_128_1:GetWordFromCfg(417042031)
				local var_131_27 = arg_128_1:FormatText(var_131_26.content)

				arg_128_1.text_.text = var_131_27

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_28 = 7
				local var_131_29 = utf8.len(var_131_27)
				local var_131_30 = var_131_28 <= 0 and var_131_24 or var_131_24 * (var_131_29 / var_131_28)

				if var_131_30 > 0 and var_131_24 < var_131_30 then
					arg_128_1.talkMaxDuration = var_131_30

					if var_131_30 + var_131_23 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_30 + var_131_23
					end
				end

				arg_128_1.text_.text = var_131_27
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042031", "story_v_out_417042.awb") ~= 0 then
					local var_131_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042031", "story_v_out_417042.awb") / 1000

					if var_131_31 + var_131_23 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_31 + var_131_23
					end

					if var_131_26.prefab_name ~= "" and arg_128_1.actors_[var_131_26.prefab_name] ~= nil then
						local var_131_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_26.prefab_name].transform, "story_v_out_417042", "417042031", "story_v_out_417042.awb")

						arg_128_1:RecordAudio("417042031", var_131_32)
						arg_128_1:RecordAudio("417042031", var_131_32)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417042", "417042031", "story_v_out_417042.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417042", "417042031", "story_v_out_417042.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_33 = math.max(var_131_24, arg_128_1.talkMaxDuration)

			if var_131_23 <= arg_128_1.time_ and arg_128_1.time_ < var_131_23 + var_131_33 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_23) / var_131_33

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_23 + var_131_33 and arg_128_1.time_ < var_131_23 + var_131_33 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play417042032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417042032
		arg_132_1.duration_ = 7.27

		local var_132_0 = {
			zh = 5.866,
			ja = 7.266
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play417042033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10115"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10115 == nil then
				arg_132_1.var_.actorSpriteComps10115 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps10115 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 1, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps10115 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps10115 = nil
			end

			local var_135_8 = arg_132_1.actors_["1034"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1034 == nil then
				arg_132_1.var_.actorSpriteComps1034 = var_135_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_10 = 0.2

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.actorSpriteComps1034 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_135_5 then
							if arg_132_1.isInRecall_ then
								local var_135_12 = Mathf.Lerp(iter_135_5.color.r, arg_132_1.hightColor2.r, var_135_11)
								local var_135_13 = Mathf.Lerp(iter_135_5.color.g, arg_132_1.hightColor2.g, var_135_11)
								local var_135_14 = Mathf.Lerp(iter_135_5.color.b, arg_132_1.hightColor2.b, var_135_11)

								iter_135_5.color = Color.New(var_135_12, var_135_13, var_135_14)
							else
								local var_135_15 = Mathf.Lerp(iter_135_5.color.r, 0.5, var_135_11)

								iter_135_5.color = Color.New(var_135_15, var_135_15, var_135_15)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1034 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_135_7 then
						if arg_132_1.isInRecall_ then
							iter_135_7.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1034 = nil
			end

			local var_135_16 = arg_132_1.actors_["10115"].transform
			local var_135_17 = 0

			if var_135_17 < arg_132_1.time_ and arg_132_1.time_ <= var_135_17 + arg_135_0 then
				arg_132_1.var_.moveOldPos10115 = var_135_16.localPosition
				var_135_16.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("10115", 2)

				local var_135_18 = var_135_16.childCount

				for iter_135_8 = 0, var_135_18 - 1 do
					local var_135_19 = var_135_16:GetChild(iter_135_8)

					if var_135_19.name == "" or not string.find(var_135_19.name, "split") then
						var_135_19.gameObject:SetActive(true)
					else
						var_135_19.gameObject:SetActive(false)
					end
				end
			end

			local var_135_20 = 0.001

			if var_135_17 <= arg_132_1.time_ and arg_132_1.time_ < var_135_17 + var_135_20 then
				local var_135_21 = (arg_132_1.time_ - var_135_17) / var_135_20
				local var_135_22 = Vector3.New(-390, -387.3, -246.2)

				var_135_16.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10115, var_135_22, var_135_21)
			end

			if arg_132_1.time_ >= var_135_17 + var_135_20 and arg_132_1.time_ < var_135_17 + var_135_20 + arg_135_0 then
				var_135_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_135_23 = 0
			local var_135_24 = 0.725

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_25 = arg_132_1:FormatText(StoryNameCfg[1113].name)

				arg_132_1.leftNameTxt_.text = var_135_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_26 = arg_132_1:GetWordFromCfg(417042032)
				local var_135_27 = arg_132_1:FormatText(var_135_26.content)

				arg_132_1.text_.text = var_135_27

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_28 = 29
				local var_135_29 = utf8.len(var_135_27)
				local var_135_30 = var_135_28 <= 0 and var_135_24 or var_135_24 * (var_135_29 / var_135_28)

				if var_135_30 > 0 and var_135_24 < var_135_30 then
					arg_132_1.talkMaxDuration = var_135_30

					if var_135_30 + var_135_23 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_30 + var_135_23
					end
				end

				arg_132_1.text_.text = var_135_27
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042032", "story_v_out_417042.awb") ~= 0 then
					local var_135_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042032", "story_v_out_417042.awb") / 1000

					if var_135_31 + var_135_23 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_31 + var_135_23
					end

					if var_135_26.prefab_name ~= "" and arg_132_1.actors_[var_135_26.prefab_name] ~= nil then
						local var_135_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_26.prefab_name].transform, "story_v_out_417042", "417042032", "story_v_out_417042.awb")

						arg_132_1:RecordAudio("417042032", var_135_32)
						arg_132_1:RecordAudio("417042032", var_135_32)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417042", "417042032", "story_v_out_417042.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417042", "417042032", "story_v_out_417042.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_33 = math.max(var_135_24, arg_132_1.talkMaxDuration)

			if var_135_23 <= arg_132_1.time_ and arg_132_1.time_ < var_135_23 + var_135_33 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_23) / var_135_33

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_23 + var_135_33 and arg_132_1.time_ < var_135_23 + var_135_33 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play417042033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417042033
		arg_136_1.duration_ = 4.8

		local var_136_0 = {
			zh = 3.133,
			ja = 4.8
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417042034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1034"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1034 == nil then
				arg_136_1.var_.actorSpriteComps1034 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps1034 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								local var_139_4 = Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, var_139_3)
								local var_139_5 = Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, var_139_3)
								local var_139_6 = Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, var_139_3)

								iter_139_1.color = Color.New(var_139_4, var_139_5, var_139_6)
							else
								local var_139_7 = Mathf.Lerp(iter_139_1.color.r, 1, var_139_3)

								iter_139_1.color = Color.New(var_139_7, var_139_7, var_139_7)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1034 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_139_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps1034 = nil
			end

			local var_139_8 = arg_136_1.actors_["10115"]
			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps10115 == nil then
				arg_136_1.var_.actorSpriteComps10115 = var_139_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_10 = 0.2

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 and not isNil(var_139_8) then
				local var_139_11 = (arg_136_1.time_ - var_139_9) / var_139_10

				if arg_136_1.var_.actorSpriteComps10115 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_139_5 then
							if arg_136_1.isInRecall_ then
								local var_139_12 = Mathf.Lerp(iter_139_5.color.r, arg_136_1.hightColor2.r, var_139_11)
								local var_139_13 = Mathf.Lerp(iter_139_5.color.g, arg_136_1.hightColor2.g, var_139_11)
								local var_139_14 = Mathf.Lerp(iter_139_5.color.b, arg_136_1.hightColor2.b, var_139_11)

								iter_139_5.color = Color.New(var_139_12, var_139_13, var_139_14)
							else
								local var_139_15 = Mathf.Lerp(iter_139_5.color.r, 0.5, var_139_11)

								iter_139_5.color = Color.New(var_139_15, var_139_15, var_139_15)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps10115 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_139_7 then
						if arg_136_1.isInRecall_ then
							iter_139_7.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps10115 = nil
			end

			local var_139_16 = arg_136_1.actors_["1034"].transform
			local var_139_17 = 0

			if var_139_17 < arg_136_1.time_ and arg_136_1.time_ <= var_139_17 + arg_139_0 then
				arg_136_1.var_.moveOldPos1034 = var_139_16.localPosition
				var_139_16.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1034", 4)

				local var_139_18 = var_139_16.childCount

				for iter_139_8 = 0, var_139_18 - 1 do
					local var_139_19 = var_139_16:GetChild(iter_139_8)

					if var_139_19.name == "" or not string.find(var_139_19.name, "split") then
						var_139_19.gameObject:SetActive(true)
					else
						var_139_19.gameObject:SetActive(false)
					end
				end
			end

			local var_139_20 = 0.001

			if var_139_17 <= arg_136_1.time_ and arg_136_1.time_ < var_139_17 + var_139_20 then
				local var_139_21 = (arg_136_1.time_ - var_139_17) / var_139_20
				local var_139_22 = Vector3.New(373.7, -331.9, -324)

				var_139_16.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1034, var_139_22, var_139_21)
			end

			if arg_136_1.time_ >= var_139_17 + var_139_20 and arg_136_1.time_ < var_139_17 + var_139_20 + arg_139_0 then
				var_139_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_139_23 = 0
			local var_139_24 = 0.4

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_25 = arg_136_1:FormatText(StoryNameCfg[1109].name)

				arg_136_1.leftNameTxt_.text = var_139_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_26 = arg_136_1:GetWordFromCfg(417042033)
				local var_139_27 = arg_136_1:FormatText(var_139_26.content)

				arg_136_1.text_.text = var_139_27

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_28 = 16
				local var_139_29 = utf8.len(var_139_27)
				local var_139_30 = var_139_28 <= 0 and var_139_24 or var_139_24 * (var_139_29 / var_139_28)

				if var_139_30 > 0 and var_139_24 < var_139_30 then
					arg_136_1.talkMaxDuration = var_139_30

					if var_139_30 + var_139_23 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_30 + var_139_23
					end
				end

				arg_136_1.text_.text = var_139_27
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042033", "story_v_out_417042.awb") ~= 0 then
					local var_139_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042033", "story_v_out_417042.awb") / 1000

					if var_139_31 + var_139_23 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_31 + var_139_23
					end

					if var_139_26.prefab_name ~= "" and arg_136_1.actors_[var_139_26.prefab_name] ~= nil then
						local var_139_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_26.prefab_name].transform, "story_v_out_417042", "417042033", "story_v_out_417042.awb")

						arg_136_1:RecordAudio("417042033", var_139_32)
						arg_136_1:RecordAudio("417042033", var_139_32)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417042", "417042033", "story_v_out_417042.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417042", "417042033", "story_v_out_417042.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_33 = math.max(var_139_24, arg_136_1.talkMaxDuration)

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_33 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_23) / var_139_33

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_23 + var_139_33 and arg_136_1.time_ < var_139_23 + var_139_33 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play417042034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417042034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play417042035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1034"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1034 == nil then
				arg_140_1.var_.actorSpriteComps1034 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1034 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								local var_143_4 = Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor2.r, var_143_3)
								local var_143_5 = Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor2.g, var_143_3)
								local var_143_6 = Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor2.b, var_143_3)

								iter_143_1.color = Color.New(var_143_4, var_143_5, var_143_6)
							else
								local var_143_7 = Mathf.Lerp(iter_143_1.color.r, 0.5, var_143_3)

								iter_143_1.color = Color.New(var_143_7, var_143_7, var_143_7)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1034 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_143_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1034 = nil
			end

			local var_143_8 = arg_140_1.actors_["1034"].transform
			local var_143_9 = 0

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.var_.moveOldPos1034 = var_143_8.localPosition
				var_143_8.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1034", 7)

				local var_143_10 = var_143_8.childCount

				for iter_143_4 = 0, var_143_10 - 1 do
					local var_143_11 = var_143_8:GetChild(iter_143_4)

					if var_143_11.name == "" or not string.find(var_143_11.name, "split") then
						var_143_11.gameObject:SetActive(true)
					else
						var_143_11.gameObject:SetActive(false)
					end
				end
			end

			local var_143_12 = 0.001

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_12 then
				local var_143_13 = (arg_140_1.time_ - var_143_9) / var_143_12
				local var_143_14 = Vector3.New(0, -2000, 0)

				var_143_8.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1034, var_143_14, var_143_13)
			end

			if arg_140_1.time_ >= var_143_9 + var_143_12 and arg_140_1.time_ < var_143_9 + var_143_12 + arg_143_0 then
				var_143_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_15 = arg_140_1.actors_["10115"].transform
			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.var_.moveOldPos10115 = var_143_15.localPosition
				var_143_15.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("10115", 7)

				local var_143_17 = var_143_15.childCount

				for iter_143_5 = 0, var_143_17 - 1 do
					local var_143_18 = var_143_15:GetChild(iter_143_5)

					if var_143_18.name == "" or not string.find(var_143_18.name, "split") then
						var_143_18.gameObject:SetActive(true)
					else
						var_143_18.gameObject:SetActive(false)
					end
				end
			end

			local var_143_19 = 0.001

			if var_143_16 <= arg_140_1.time_ and arg_140_1.time_ < var_143_16 + var_143_19 then
				local var_143_20 = (arg_140_1.time_ - var_143_16) / var_143_19
				local var_143_21 = Vector3.New(0, -2000, 0)

				var_143_15.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos10115, var_143_21, var_143_20)
			end

			if arg_140_1.time_ >= var_143_16 + var_143_19 and arg_140_1.time_ < var_143_16 + var_143_19 + arg_143_0 then
				var_143_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_22 = 0.05
			local var_143_23 = 1

			if var_143_22 < arg_140_1.time_ and arg_140_1.time_ <= var_143_22 + arg_143_0 then
				local var_143_24 = "play"
				local var_143_25 = "effect"

				arg_140_1:AudioAction(var_143_24, var_143_25, "se_story_1310", "se_story_1310_sofa", "")
			end

			local var_143_26 = 0
			local var_143_27 = 0.875

			if var_143_26 < arg_140_1.time_ and arg_140_1.time_ <= var_143_26 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_28 = arg_140_1:GetWordFromCfg(417042034)
				local var_143_29 = arg_140_1:FormatText(var_143_28.content)

				arg_140_1.text_.text = var_143_29

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_30 = 35
				local var_143_31 = utf8.len(var_143_29)
				local var_143_32 = var_143_30 <= 0 and var_143_27 or var_143_27 * (var_143_31 / var_143_30)

				if var_143_32 > 0 and var_143_27 < var_143_32 then
					arg_140_1.talkMaxDuration = var_143_32

					if var_143_32 + var_143_26 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_32 + var_143_26
					end
				end

				arg_140_1.text_.text = var_143_29
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_33 = math.max(var_143_27, arg_140_1.talkMaxDuration)

			if var_143_26 <= arg_140_1.time_ and arg_140_1.time_ < var_143_26 + var_143_33 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_26) / var_143_33

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_26 + var_143_33 and arg_140_1.time_ < var_143_26 + var_143_33 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play417042035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417042035
		arg_144_1.duration_ = 6.17

		local var_144_0 = {
			zh = 4.433,
			ja = 6.166
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
				arg_144_0:Play417042036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1034"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1034 == nil then
				arg_144_1.var_.actorSpriteComps1034 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps1034 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								local var_147_4 = Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor1.r, var_147_3)
								local var_147_5 = Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor1.g, var_147_3)
								local var_147_6 = Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor1.b, var_147_3)

								iter_147_1.color = Color.New(var_147_4, var_147_5, var_147_6)
							else
								local var_147_7 = Mathf.Lerp(iter_147_1.color.r, 1, var_147_3)

								iter_147_1.color = Color.New(var_147_7, var_147_7, var_147_7)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1034 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps1034 = nil
			end

			local var_147_8 = arg_144_1.actors_["1034"].transform
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.var_.moveOldPos1034 = var_147_8.localPosition
				var_147_8.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1034", 4)

				local var_147_10 = var_147_8.childCount

				for iter_147_4 = 0, var_147_10 - 1 do
					local var_147_11 = var_147_8:GetChild(iter_147_4)

					if var_147_11.name == "split_6" or not string.find(var_147_11.name, "split") then
						var_147_11.gameObject:SetActive(true)
					else
						var_147_11.gameObject:SetActive(false)
					end
				end
			end

			local var_147_12 = 0.001

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_9) / var_147_12
				local var_147_14 = Vector3.New(373.7, -331.9, -324)

				var_147_8.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1034, var_147_14, var_147_13)
			end

			if arg_144_1.time_ >= var_147_9 + var_147_12 and arg_144_1.time_ < var_147_9 + var_147_12 + arg_147_0 then
				var_147_8.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_147_15 = 0
			local var_147_16 = 0.6

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_17 = arg_144_1:FormatText(StoryNameCfg[1109].name)

				arg_144_1.leftNameTxt_.text = var_147_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_18 = arg_144_1:GetWordFromCfg(417042035)
				local var_147_19 = arg_144_1:FormatText(var_147_18.content)

				arg_144_1.text_.text = var_147_19

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_20 = 24
				local var_147_21 = utf8.len(var_147_19)
				local var_147_22 = var_147_20 <= 0 and var_147_16 or var_147_16 * (var_147_21 / var_147_20)

				if var_147_22 > 0 and var_147_16 < var_147_22 then
					arg_144_1.talkMaxDuration = var_147_22

					if var_147_22 + var_147_15 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_22 + var_147_15
					end
				end

				arg_144_1.text_.text = var_147_19
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042035", "story_v_out_417042.awb") ~= 0 then
					local var_147_23 = manager.audio:GetVoiceLength("story_v_out_417042", "417042035", "story_v_out_417042.awb") / 1000

					if var_147_23 + var_147_15 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_23 + var_147_15
					end

					if var_147_18.prefab_name ~= "" and arg_144_1.actors_[var_147_18.prefab_name] ~= nil then
						local var_147_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_18.prefab_name].transform, "story_v_out_417042", "417042035", "story_v_out_417042.awb")

						arg_144_1:RecordAudio("417042035", var_147_24)
						arg_144_1:RecordAudio("417042035", var_147_24)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417042", "417042035", "story_v_out_417042.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417042", "417042035", "story_v_out_417042.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_25 = math.max(var_147_16, arg_144_1.talkMaxDuration)

			if var_147_15 <= arg_144_1.time_ and arg_144_1.time_ < var_147_15 + var_147_25 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_15) / var_147_25

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_15 + var_147_25 and arg_144_1.time_ < var_147_15 + var_147_25 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play417042036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417042036
		arg_148_1.duration_ = 6.33

		local var_148_0 = {
			zh = 4.2,
			ja = 6.333
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
				arg_148_0:Play417042037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["10115"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10115 == nil then
				arg_148_1.var_.actorSpriteComps10115 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps10115 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps10115 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_151_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps10115 = nil
			end

			local var_151_8 = arg_148_1.actors_["1034"]
			local var_151_9 = 0

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps1034 == nil then
				arg_148_1.var_.actorSpriteComps1034 = var_151_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_10 = 0.2

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_10 and not isNil(var_151_8) then
				local var_151_11 = (arg_148_1.time_ - var_151_9) / var_151_10

				if arg_148_1.var_.actorSpriteComps1034 then
					for iter_151_4, iter_151_5 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_151_5 then
							if arg_148_1.isInRecall_ then
								local var_151_12 = Mathf.Lerp(iter_151_5.color.r, arg_148_1.hightColor2.r, var_151_11)
								local var_151_13 = Mathf.Lerp(iter_151_5.color.g, arg_148_1.hightColor2.g, var_151_11)
								local var_151_14 = Mathf.Lerp(iter_151_5.color.b, arg_148_1.hightColor2.b, var_151_11)

								iter_151_5.color = Color.New(var_151_12, var_151_13, var_151_14)
							else
								local var_151_15 = Mathf.Lerp(iter_151_5.color.r, 0.5, var_151_11)

								iter_151_5.color = Color.New(var_151_15, var_151_15, var_151_15)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_9 + var_151_10 and arg_148_1.time_ < var_151_9 + var_151_10 + arg_151_0 and not isNil(var_151_8) and arg_148_1.var_.actorSpriteComps1034 then
				for iter_151_6, iter_151_7 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_151_7 then
						if arg_148_1.isInRecall_ then
							iter_151_7.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1034 = nil
			end

			local var_151_16 = arg_148_1.actors_["1034"].transform
			local var_151_17 = 0

			if var_151_17 < arg_148_1.time_ and arg_148_1.time_ <= var_151_17 + arg_151_0 then
				arg_148_1.var_.moveOldPos1034 = var_151_16.localPosition
				var_151_16.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1034", 4)

				local var_151_18 = var_151_16.childCount

				for iter_151_8 = 0, var_151_18 - 1 do
					local var_151_19 = var_151_16:GetChild(iter_151_8)

					if var_151_19.name == "split_6" or not string.find(var_151_19.name, "split") then
						var_151_19.gameObject:SetActive(true)
					else
						var_151_19.gameObject:SetActive(false)
					end
				end
			end

			local var_151_20 = 0.001

			if var_151_17 <= arg_148_1.time_ and arg_148_1.time_ < var_151_17 + var_151_20 then
				local var_151_21 = (arg_148_1.time_ - var_151_17) / var_151_20
				local var_151_22 = Vector3.New(373.7, -331.9, -324)

				var_151_16.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1034, var_151_22, var_151_21)
			end

			if arg_148_1.time_ >= var_151_17 + var_151_20 and arg_148_1.time_ < var_151_17 + var_151_20 + arg_151_0 then
				var_151_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_151_23 = arg_148_1.actors_["10115"].transform
			local var_151_24 = 0

			if var_151_24 < arg_148_1.time_ and arg_148_1.time_ <= var_151_24 + arg_151_0 then
				arg_148_1.var_.moveOldPos10115 = var_151_23.localPosition
				var_151_23.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10115", 2)

				local var_151_25 = var_151_23.childCount

				for iter_151_9 = 0, var_151_25 - 1 do
					local var_151_26 = var_151_23:GetChild(iter_151_9)

					if var_151_26.name == "" or not string.find(var_151_26.name, "split") then
						var_151_26.gameObject:SetActive(true)
					else
						var_151_26.gameObject:SetActive(false)
					end
				end
			end

			local var_151_27 = 0.001

			if var_151_24 <= arg_148_1.time_ and arg_148_1.time_ < var_151_24 + var_151_27 then
				local var_151_28 = (arg_148_1.time_ - var_151_24) / var_151_27
				local var_151_29 = Vector3.New(-390, -387.3, -246.2)

				var_151_23.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10115, var_151_29, var_151_28)
			end

			if arg_148_1.time_ >= var_151_24 + var_151_27 and arg_148_1.time_ < var_151_24 + var_151_27 + arg_151_0 then
				var_151_23.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_151_30 = 0
			local var_151_31 = 0.525

			if var_151_30 < arg_148_1.time_ and arg_148_1.time_ <= var_151_30 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_32 = arg_148_1:FormatText(StoryNameCfg[1113].name)

				arg_148_1.leftNameTxt_.text = var_151_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_33 = arg_148_1:GetWordFromCfg(417042036)
				local var_151_34 = arg_148_1:FormatText(var_151_33.content)

				arg_148_1.text_.text = var_151_34

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_35 = 21
				local var_151_36 = utf8.len(var_151_34)
				local var_151_37 = var_151_35 <= 0 and var_151_31 or var_151_31 * (var_151_36 / var_151_35)

				if var_151_37 > 0 and var_151_31 < var_151_37 then
					arg_148_1.talkMaxDuration = var_151_37

					if var_151_37 + var_151_30 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_37 + var_151_30
					end
				end

				arg_148_1.text_.text = var_151_34
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042036", "story_v_out_417042.awb") ~= 0 then
					local var_151_38 = manager.audio:GetVoiceLength("story_v_out_417042", "417042036", "story_v_out_417042.awb") / 1000

					if var_151_38 + var_151_30 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_38 + var_151_30
					end

					if var_151_33.prefab_name ~= "" and arg_148_1.actors_[var_151_33.prefab_name] ~= nil then
						local var_151_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_33.prefab_name].transform, "story_v_out_417042", "417042036", "story_v_out_417042.awb")

						arg_148_1:RecordAudio("417042036", var_151_39)
						arg_148_1:RecordAudio("417042036", var_151_39)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417042", "417042036", "story_v_out_417042.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417042", "417042036", "story_v_out_417042.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_40 = math.max(var_151_31, arg_148_1.talkMaxDuration)

			if var_151_30 <= arg_148_1.time_ and arg_148_1.time_ < var_151_30 + var_151_40 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_30) / var_151_40

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_30 + var_151_40 and arg_148_1.time_ < var_151_30 + var_151_40 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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
				actorName = "10115",
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
	Play417042037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417042037
		arg_152_1.duration_ = 3.67

		local var_152_0 = {
			zh = 3.1,
			ja = 3.666
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
				arg_152_0:Play417042038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1034"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1034 == nil then
				arg_152_1.var_.actorSpriteComps1034 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps1034 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								local var_155_4 = Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, var_155_3)
								local var_155_5 = Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, var_155_3)
								local var_155_6 = Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, var_155_3)

								iter_155_1.color = Color.New(var_155_4, var_155_5, var_155_6)
							else
								local var_155_7 = Mathf.Lerp(iter_155_1.color.r, 1, var_155_3)

								iter_155_1.color = Color.New(var_155_7, var_155_7, var_155_7)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1034 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_155_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps1034 = nil
			end

			local var_155_8 = arg_152_1.actors_["10115"]
			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 and not isNil(var_155_8) and arg_152_1.var_.actorSpriteComps10115 == nil then
				arg_152_1.var_.actorSpriteComps10115 = var_155_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_10 = 0.2

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_10 and not isNil(var_155_8) then
				local var_155_11 = (arg_152_1.time_ - var_155_9) / var_155_10

				if arg_152_1.var_.actorSpriteComps10115 then
					for iter_155_4, iter_155_5 in pairs(arg_152_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_155_5 then
							if arg_152_1.isInRecall_ then
								local var_155_12 = Mathf.Lerp(iter_155_5.color.r, arg_152_1.hightColor2.r, var_155_11)
								local var_155_13 = Mathf.Lerp(iter_155_5.color.g, arg_152_1.hightColor2.g, var_155_11)
								local var_155_14 = Mathf.Lerp(iter_155_5.color.b, arg_152_1.hightColor2.b, var_155_11)

								iter_155_5.color = Color.New(var_155_12, var_155_13, var_155_14)
							else
								local var_155_15 = Mathf.Lerp(iter_155_5.color.r, 0.5, var_155_11)

								iter_155_5.color = Color.New(var_155_15, var_155_15, var_155_15)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= var_155_9 + var_155_10 and arg_152_1.time_ < var_155_9 + var_155_10 + arg_155_0 and not isNil(var_155_8) and arg_152_1.var_.actorSpriteComps10115 then
				for iter_155_6, iter_155_7 in pairs(arg_152_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_155_7 then
						if arg_152_1.isInRecall_ then
							iter_155_7.color = arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_155_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps10115 = nil
			end

			local var_155_16 = 0
			local var_155_17 = 0.3

			if var_155_16 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_18 = arg_152_1:FormatText(StoryNameCfg[1109].name)

				arg_152_1.leftNameTxt_.text = var_155_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_19 = arg_152_1:GetWordFromCfg(417042037)
				local var_155_20 = arg_152_1:FormatText(var_155_19.content)

				arg_152_1.text_.text = var_155_20

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_21 = 12
				local var_155_22 = utf8.len(var_155_20)
				local var_155_23 = var_155_21 <= 0 and var_155_17 or var_155_17 * (var_155_22 / var_155_21)

				if var_155_23 > 0 and var_155_17 < var_155_23 then
					arg_152_1.talkMaxDuration = var_155_23

					if var_155_23 + var_155_16 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_16
					end
				end

				arg_152_1.text_.text = var_155_20
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042037", "story_v_out_417042.awb") ~= 0 then
					local var_155_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042037", "story_v_out_417042.awb") / 1000

					if var_155_24 + var_155_16 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_24 + var_155_16
					end

					if var_155_19.prefab_name ~= "" and arg_152_1.actors_[var_155_19.prefab_name] ~= nil then
						local var_155_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_19.prefab_name].transform, "story_v_out_417042", "417042037", "story_v_out_417042.awb")

						arg_152_1:RecordAudio("417042037", var_155_25)
						arg_152_1:RecordAudio("417042037", var_155_25)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417042", "417042037", "story_v_out_417042.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417042", "417042037", "story_v_out_417042.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_26 = math.max(var_155_17, arg_152_1.talkMaxDuration)

			if var_155_16 <= arg_152_1.time_ and arg_152_1.time_ < var_155_16 + var_155_26 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_16) / var_155_26

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_16 + var_155_26 and arg_152_1.time_ < var_155_16 + var_155_26 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play417042038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417042038
		arg_156_1.duration_ = 11.67

		local var_156_0 = {
			zh = 7.5,
			ja = 11.666
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
				arg_156_0:Play417042039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10115"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps10115 == nil then
				arg_156_1.var_.actorSpriteComps10115 = var_159_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.actorSpriteComps10115 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps10115 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_159_3 then
						if arg_156_1.isInRecall_ then
							iter_159_3.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_159_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps10115 = nil
			end

			local var_159_8 = arg_156_1.actors_["1034"]
			local var_159_9 = 0

			if var_159_9 < arg_156_1.time_ and arg_156_1.time_ <= var_159_9 + arg_159_0 and not isNil(var_159_8) and arg_156_1.var_.actorSpriteComps1034 == nil then
				arg_156_1.var_.actorSpriteComps1034 = var_159_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_10 = 0.2

			if var_159_9 <= arg_156_1.time_ and arg_156_1.time_ < var_159_9 + var_159_10 and not isNil(var_159_8) then
				local var_159_11 = (arg_156_1.time_ - var_159_9) / var_159_10

				if arg_156_1.var_.actorSpriteComps1034 then
					for iter_159_4, iter_159_5 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_159_5 then
							if arg_156_1.isInRecall_ then
								local var_159_12 = Mathf.Lerp(iter_159_5.color.r, arg_156_1.hightColor2.r, var_159_11)
								local var_159_13 = Mathf.Lerp(iter_159_5.color.g, arg_156_1.hightColor2.g, var_159_11)
								local var_159_14 = Mathf.Lerp(iter_159_5.color.b, arg_156_1.hightColor2.b, var_159_11)

								iter_159_5.color = Color.New(var_159_12, var_159_13, var_159_14)
							else
								local var_159_15 = Mathf.Lerp(iter_159_5.color.r, 0.5, var_159_11)

								iter_159_5.color = Color.New(var_159_15, var_159_15, var_159_15)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_9 + var_159_10 and arg_156_1.time_ < var_159_9 + var_159_10 + arg_159_0 and not isNil(var_159_8) and arg_156_1.var_.actorSpriteComps1034 then
				for iter_159_6, iter_159_7 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_159_7 then
						if arg_156_1.isInRecall_ then
							iter_159_7.color = arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_159_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1034 = nil
			end

			local var_159_16 = 0
			local var_159_17 = 0.925

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_18 = arg_156_1:FormatText(StoryNameCfg[1113].name)

				arg_156_1.leftNameTxt_.text = var_159_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_19 = arg_156_1:GetWordFromCfg(417042038)
				local var_159_20 = arg_156_1:FormatText(var_159_19.content)

				arg_156_1.text_.text = var_159_20

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_21 = 37
				local var_159_22 = utf8.len(var_159_20)
				local var_159_23 = var_159_21 <= 0 and var_159_17 or var_159_17 * (var_159_22 / var_159_21)

				if var_159_23 > 0 and var_159_17 < var_159_23 then
					arg_156_1.talkMaxDuration = var_159_23

					if var_159_23 + var_159_16 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_16
					end
				end

				arg_156_1.text_.text = var_159_20
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042038", "story_v_out_417042.awb") ~= 0 then
					local var_159_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042038", "story_v_out_417042.awb") / 1000

					if var_159_24 + var_159_16 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_24 + var_159_16
					end

					if var_159_19.prefab_name ~= "" and arg_156_1.actors_[var_159_19.prefab_name] ~= nil then
						local var_159_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_19.prefab_name].transform, "story_v_out_417042", "417042038", "story_v_out_417042.awb")

						arg_156_1:RecordAudio("417042038", var_159_25)
						arg_156_1:RecordAudio("417042038", var_159_25)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417042", "417042038", "story_v_out_417042.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417042", "417042038", "story_v_out_417042.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_26 = math.max(var_159_17, arg_156_1.talkMaxDuration)

			if var_159_16 <= arg_156_1.time_ and arg_156_1.time_ < var_159_16 + var_159_26 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_16) / var_159_26

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_16 + var_159_26 and arg_156_1.time_ < var_159_16 + var_159_26 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417042039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417042039
		arg_160_1.duration_ = 9.53

		local var_160_0 = {
			zh = 5.9,
			ja = 9.533
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
				arg_160_0:Play417042040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1034"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1034 == nil then
				arg_160_1.var_.actorSpriteComps1034 = var_163_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.actorSpriteComps1034 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								local var_163_4 = Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor1.r, var_163_3)
								local var_163_5 = Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor1.g, var_163_3)
								local var_163_6 = Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor1.b, var_163_3)

								iter_163_1.color = Color.New(var_163_4, var_163_5, var_163_6)
							else
								local var_163_7 = Mathf.Lerp(iter_163_1.color.r, 1, var_163_3)

								iter_163_1.color = Color.New(var_163_7, var_163_7, var_163_7)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1034 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_163_3 then
						if arg_160_1.isInRecall_ then
							iter_163_3.color = arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_163_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps1034 = nil
			end

			local var_163_8 = arg_160_1.actors_["10115"]
			local var_163_9 = 0

			if var_163_9 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 and not isNil(var_163_8) and arg_160_1.var_.actorSpriteComps10115 == nil then
				arg_160_1.var_.actorSpriteComps10115 = var_163_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_10 = 0.2

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_10 and not isNil(var_163_8) then
				local var_163_11 = (arg_160_1.time_ - var_163_9) / var_163_10

				if arg_160_1.var_.actorSpriteComps10115 then
					for iter_163_4, iter_163_5 in pairs(arg_160_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_163_5 then
							if arg_160_1.isInRecall_ then
								local var_163_12 = Mathf.Lerp(iter_163_5.color.r, arg_160_1.hightColor2.r, var_163_11)
								local var_163_13 = Mathf.Lerp(iter_163_5.color.g, arg_160_1.hightColor2.g, var_163_11)
								local var_163_14 = Mathf.Lerp(iter_163_5.color.b, arg_160_1.hightColor2.b, var_163_11)

								iter_163_5.color = Color.New(var_163_12, var_163_13, var_163_14)
							else
								local var_163_15 = Mathf.Lerp(iter_163_5.color.r, 0.5, var_163_11)

								iter_163_5.color = Color.New(var_163_15, var_163_15, var_163_15)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= var_163_9 + var_163_10 and arg_160_1.time_ < var_163_9 + var_163_10 + arg_163_0 and not isNil(var_163_8) and arg_160_1.var_.actorSpriteComps10115 then
				for iter_163_6, iter_163_7 in pairs(arg_160_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_163_7 then
						if arg_160_1.isInRecall_ then
							iter_163_7.color = arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_163_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps10115 = nil
			end

			local var_163_16 = 0
			local var_163_17 = 0.675

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_18 = arg_160_1:FormatText(StoryNameCfg[1109].name)

				arg_160_1.leftNameTxt_.text = var_163_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_19 = arg_160_1:GetWordFromCfg(417042039)
				local var_163_20 = arg_160_1:FormatText(var_163_19.content)

				arg_160_1.text_.text = var_163_20

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_21 = 27
				local var_163_22 = utf8.len(var_163_20)
				local var_163_23 = var_163_21 <= 0 and var_163_17 or var_163_17 * (var_163_22 / var_163_21)

				if var_163_23 > 0 and var_163_17 < var_163_23 then
					arg_160_1.talkMaxDuration = var_163_23

					if var_163_23 + var_163_16 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_23 + var_163_16
					end
				end

				arg_160_1.text_.text = var_163_20
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042039", "story_v_out_417042.awb") ~= 0 then
					local var_163_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042039", "story_v_out_417042.awb") / 1000

					if var_163_24 + var_163_16 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_24 + var_163_16
					end

					if var_163_19.prefab_name ~= "" and arg_160_1.actors_[var_163_19.prefab_name] ~= nil then
						local var_163_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_19.prefab_name].transform, "story_v_out_417042", "417042039", "story_v_out_417042.awb")

						arg_160_1:RecordAudio("417042039", var_163_25)
						arg_160_1:RecordAudio("417042039", var_163_25)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_417042", "417042039", "story_v_out_417042.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_417042", "417042039", "story_v_out_417042.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_26 = math.max(var_163_17, arg_160_1.talkMaxDuration)

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_26 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_16) / var_163_26

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_16 + var_163_26 and arg_160_1.time_ < var_163_16 + var_163_26 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417042040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417042040
		arg_164_1.duration_ = 10.4

		local var_164_0 = {
			zh = 8,
			ja = 10.4
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play417042041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.925

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[1109].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:GetWordFromCfg(417042040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 37
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042040", "story_v_out_417042.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042040", "story_v_out_417042.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_417042", "417042040", "story_v_out_417042.awb")

						arg_164_1:RecordAudio("417042040", var_167_9)
						arg_164_1:RecordAudio("417042040", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417042", "417042040", "story_v_out_417042.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417042", "417042040", "story_v_out_417042.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play417042041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417042041
		arg_168_1.duration_ = 2.37

		local var_168_0 = {
			zh = 2.366,
			ja = 2.166
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play417042042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10115"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps10115 == nil then
				arg_168_1.var_.actorSpriteComps10115 = var_171_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.actorSpriteComps10115 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								local var_171_4 = Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor1.r, var_171_3)
								local var_171_5 = Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor1.g, var_171_3)
								local var_171_6 = Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor1.b, var_171_3)

								iter_171_1.color = Color.New(var_171_4, var_171_5, var_171_6)
							else
								local var_171_7 = Mathf.Lerp(iter_171_1.color.r, 1, var_171_3)

								iter_171_1.color = Color.New(var_171_7, var_171_7, var_171_7)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps10115 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_171_3 then
						if arg_168_1.isInRecall_ then
							iter_171_3.color = arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_171_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps10115 = nil
			end

			local var_171_8 = arg_168_1.actors_["1034"]
			local var_171_9 = 0

			if var_171_9 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.actorSpriteComps1034 == nil then
				arg_168_1.var_.actorSpriteComps1034 = var_171_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_10 = 0.2

			if var_171_9 <= arg_168_1.time_ and arg_168_1.time_ < var_171_9 + var_171_10 and not isNil(var_171_8) then
				local var_171_11 = (arg_168_1.time_ - var_171_9) / var_171_10

				if arg_168_1.var_.actorSpriteComps1034 then
					for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_171_5 then
							if arg_168_1.isInRecall_ then
								local var_171_12 = Mathf.Lerp(iter_171_5.color.r, arg_168_1.hightColor2.r, var_171_11)
								local var_171_13 = Mathf.Lerp(iter_171_5.color.g, arg_168_1.hightColor2.g, var_171_11)
								local var_171_14 = Mathf.Lerp(iter_171_5.color.b, arg_168_1.hightColor2.b, var_171_11)

								iter_171_5.color = Color.New(var_171_12, var_171_13, var_171_14)
							else
								local var_171_15 = Mathf.Lerp(iter_171_5.color.r, 0.5, var_171_11)

								iter_171_5.color = Color.New(var_171_15, var_171_15, var_171_15)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_9 + var_171_10 and arg_168_1.time_ < var_171_9 + var_171_10 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.actorSpriteComps1034 then
				for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_171_7 then
						if arg_168_1.isInRecall_ then
							iter_171_7.color = arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_171_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps1034 = nil
			end

			local var_171_16 = arg_168_1.actors_["10115"].transform
			local var_171_17 = 0

			if var_171_17 < arg_168_1.time_ and arg_168_1.time_ <= var_171_17 + arg_171_0 then
				arg_168_1.var_.moveOldPos10115 = var_171_16.localPosition
				var_171_16.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10115", 2)

				local var_171_18 = var_171_16.childCount

				for iter_171_8 = 0, var_171_18 - 1 do
					local var_171_19 = var_171_16:GetChild(iter_171_8)

					if var_171_19.name == "" or not string.find(var_171_19.name, "split") then
						var_171_19.gameObject:SetActive(true)
					else
						var_171_19.gameObject:SetActive(false)
					end
				end
			end

			local var_171_20 = 0.001

			if var_171_17 <= arg_168_1.time_ and arg_168_1.time_ < var_171_17 + var_171_20 then
				local var_171_21 = (arg_168_1.time_ - var_171_17) / var_171_20
				local var_171_22 = Vector3.New(-390, -387.3, -246.2)

				var_171_16.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10115, var_171_22, var_171_21)
			end

			if arg_168_1.time_ >= var_171_17 + var_171_20 and arg_168_1.time_ < var_171_17 + var_171_20 + arg_171_0 then
				var_171_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_171_23 = 0
			local var_171_24 = 0.15

			if var_171_23 < arg_168_1.time_ and arg_168_1.time_ <= var_171_23 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_25 = arg_168_1:FormatText(StoryNameCfg[1113].name)

				arg_168_1.leftNameTxt_.text = var_171_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_26 = arg_168_1:GetWordFromCfg(417042041)
				local var_171_27 = arg_168_1:FormatText(var_171_26.content)

				arg_168_1.text_.text = var_171_27

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_28 = 6
				local var_171_29 = utf8.len(var_171_27)
				local var_171_30 = var_171_28 <= 0 and var_171_24 or var_171_24 * (var_171_29 / var_171_28)

				if var_171_30 > 0 and var_171_24 < var_171_30 then
					arg_168_1.talkMaxDuration = var_171_30

					if var_171_30 + var_171_23 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_30 + var_171_23
					end
				end

				arg_168_1.text_.text = var_171_27
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042041", "story_v_out_417042.awb") ~= 0 then
					local var_171_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042041", "story_v_out_417042.awb") / 1000

					if var_171_31 + var_171_23 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_31 + var_171_23
					end

					if var_171_26.prefab_name ~= "" and arg_168_1.actors_[var_171_26.prefab_name] ~= nil then
						local var_171_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_26.prefab_name].transform, "story_v_out_417042", "417042041", "story_v_out_417042.awb")

						arg_168_1:RecordAudio("417042041", var_171_32)
						arg_168_1:RecordAudio("417042041", var_171_32)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_417042", "417042041", "story_v_out_417042.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_417042", "417042041", "story_v_out_417042.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_33 = math.max(var_171_24, arg_168_1.talkMaxDuration)

			if var_171_23 <= arg_168_1.time_ and arg_168_1.time_ < var_171_23 + var_171_33 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_23) / var_171_33

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_23 + var_171_33 and arg_168_1.time_ < var_171_23 + var_171_33 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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

		arg_168_1:InitPlayNodeList()
	end,
	Play417042042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417042042
		arg_172_1.duration_ = 5.9

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play417042043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1034"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1034 == nil then
				arg_172_1.var_.actorSpriteComps1034 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps1034 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1034 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_175_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps1034 = nil
			end

			local var_175_8 = arg_172_1.actors_["10115"]
			local var_175_9 = 0

			if var_175_9 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 and not isNil(var_175_8) and arg_172_1.var_.actorSpriteComps10115 == nil then
				arg_172_1.var_.actorSpriteComps10115 = var_175_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_10 = 0.2

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_10 and not isNil(var_175_8) then
				local var_175_11 = (arg_172_1.time_ - var_175_9) / var_175_10

				if arg_172_1.var_.actorSpriteComps10115 then
					for iter_175_4, iter_175_5 in pairs(arg_172_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_175_5 then
							if arg_172_1.isInRecall_ then
								local var_175_12 = Mathf.Lerp(iter_175_5.color.r, arg_172_1.hightColor2.r, var_175_11)
								local var_175_13 = Mathf.Lerp(iter_175_5.color.g, arg_172_1.hightColor2.g, var_175_11)
								local var_175_14 = Mathf.Lerp(iter_175_5.color.b, arg_172_1.hightColor2.b, var_175_11)

								iter_175_5.color = Color.New(var_175_12, var_175_13, var_175_14)
							else
								local var_175_15 = Mathf.Lerp(iter_175_5.color.r, 0.5, var_175_11)

								iter_175_5.color = Color.New(var_175_15, var_175_15, var_175_15)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= var_175_9 + var_175_10 and arg_172_1.time_ < var_175_9 + var_175_10 + arg_175_0 and not isNil(var_175_8) and arg_172_1.var_.actorSpriteComps10115 then
				for iter_175_6, iter_175_7 in pairs(arg_172_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_175_7 then
						if arg_172_1.isInRecall_ then
							iter_175_7.color = arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_175_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps10115 = nil
			end

			local var_175_16 = 0
			local var_175_17 = 0.75

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_18 = arg_172_1:FormatText(StoryNameCfg[1109].name)

				arg_172_1.leftNameTxt_.text = var_175_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_19 = arg_172_1:GetWordFromCfg(417042042)
				local var_175_20 = arg_172_1:FormatText(var_175_19.content)

				arg_172_1.text_.text = var_175_20

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_21 = 30
				local var_175_22 = utf8.len(var_175_20)
				local var_175_23 = var_175_21 <= 0 and var_175_17 or var_175_17 * (var_175_22 / var_175_21)

				if var_175_23 > 0 and var_175_17 < var_175_23 then
					arg_172_1.talkMaxDuration = var_175_23

					if var_175_23 + var_175_16 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_16
					end
				end

				arg_172_1.text_.text = var_175_20
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042042", "story_v_out_417042.awb") ~= 0 then
					local var_175_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042042", "story_v_out_417042.awb") / 1000

					if var_175_24 + var_175_16 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_24 + var_175_16
					end

					if var_175_19.prefab_name ~= "" and arg_172_1.actors_[var_175_19.prefab_name] ~= nil then
						local var_175_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_19.prefab_name].transform, "story_v_out_417042", "417042042", "story_v_out_417042.awb")

						arg_172_1:RecordAudio("417042042", var_175_25)
						arg_172_1:RecordAudio("417042042", var_175_25)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417042", "417042042", "story_v_out_417042.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417042", "417042042", "story_v_out_417042.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_26 = math.max(var_175_17, arg_172_1.talkMaxDuration)

			if var_175_16 <= arg_172_1.time_ and arg_172_1.time_ < var_175_16 + var_175_26 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_16) / var_175_26

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_16 + var_175_26 and arg_172_1.time_ < var_175_16 + var_175_26 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play417042043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417042043
		arg_176_1.duration_ = 12.9

		local var_176_0 = {
			zh = 8.166,
			ja = 12.9
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
				arg_176_0:Play417042044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.975

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[1109].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_3 = arg_176_1:GetWordFromCfg(417042043)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 39
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042043", "story_v_out_417042.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042043", "story_v_out_417042.awb") / 1000

					if var_179_8 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_0
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_417042", "417042043", "story_v_out_417042.awb")

						arg_176_1:RecordAudio("417042043", var_179_9)
						arg_176_1:RecordAudio("417042043", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417042", "417042043", "story_v_out_417042.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417042", "417042043", "story_v_out_417042.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_10 and arg_176_1.time_ < var_179_0 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play417042044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417042044
		arg_180_1.duration_ = 3

		local var_180_0 = {
			zh = 2,
			ja = 3
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
				arg_180_0:Play417042045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10115"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10115 == nil then
				arg_180_1.var_.actorSpriteComps10115 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps10115 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps10115 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10115 = nil
			end

			local var_183_8 = arg_180_1.actors_["1034"]
			local var_183_9 = 0

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps1034 == nil then
				arg_180_1.var_.actorSpriteComps1034 = var_183_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_10 = 0.2

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_10 and not isNil(var_183_8) then
				local var_183_11 = (arg_180_1.time_ - var_183_9) / var_183_10

				if arg_180_1.var_.actorSpriteComps1034 then
					for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_183_5 then
							if arg_180_1.isInRecall_ then
								local var_183_12 = Mathf.Lerp(iter_183_5.color.r, arg_180_1.hightColor2.r, var_183_11)
								local var_183_13 = Mathf.Lerp(iter_183_5.color.g, arg_180_1.hightColor2.g, var_183_11)
								local var_183_14 = Mathf.Lerp(iter_183_5.color.b, arg_180_1.hightColor2.b, var_183_11)

								iter_183_5.color = Color.New(var_183_12, var_183_13, var_183_14)
							else
								local var_183_15 = Mathf.Lerp(iter_183_5.color.r, 0.5, var_183_11)

								iter_183_5.color = Color.New(var_183_15, var_183_15, var_183_15)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_9 + var_183_10 and arg_180_1.time_ < var_183_9 + var_183_10 + arg_183_0 and not isNil(var_183_8) and arg_180_1.var_.actorSpriteComps1034 then
				for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_183_7 then
						if arg_180_1.isInRecall_ then
							iter_183_7.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1034 = nil
			end

			local var_183_16 = arg_180_1.actors_["1034"].transform
			local var_183_17 = 0

			if var_183_17 < arg_180_1.time_ and arg_180_1.time_ <= var_183_17 + arg_183_0 then
				arg_180_1.var_.moveOldPos1034 = var_183_16.localPosition
				var_183_16.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1034", 4)

				local var_183_18 = var_183_16.childCount

				for iter_183_8 = 0, var_183_18 - 1 do
					local var_183_19 = var_183_16:GetChild(iter_183_8)

					if var_183_19.name == "" or not string.find(var_183_19.name, "split") then
						var_183_19.gameObject:SetActive(true)
					else
						var_183_19.gameObject:SetActive(false)
					end
				end
			end

			local var_183_20 = 0.001

			if var_183_17 <= arg_180_1.time_ and arg_180_1.time_ < var_183_17 + var_183_20 then
				local var_183_21 = (arg_180_1.time_ - var_183_17) / var_183_20
				local var_183_22 = Vector3.New(373.7, -331.9, -324)

				var_183_16.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1034, var_183_22, var_183_21)
			end

			if arg_180_1.time_ >= var_183_17 + var_183_20 and arg_180_1.time_ < var_183_17 + var_183_20 + arg_183_0 then
				var_183_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_183_23 = 0
			local var_183_24 = 0.225

			if var_183_23 < arg_180_1.time_ and arg_180_1.time_ <= var_183_23 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_25 = arg_180_1:FormatText(StoryNameCfg[1113].name)

				arg_180_1.leftNameTxt_.text = var_183_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_26 = arg_180_1:GetWordFromCfg(417042044)
				local var_183_27 = arg_180_1:FormatText(var_183_26.content)

				arg_180_1.text_.text = var_183_27

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_28 = 9
				local var_183_29 = utf8.len(var_183_27)
				local var_183_30 = var_183_28 <= 0 and var_183_24 or var_183_24 * (var_183_29 / var_183_28)

				if var_183_30 > 0 and var_183_24 < var_183_30 then
					arg_180_1.talkMaxDuration = var_183_30

					if var_183_30 + var_183_23 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_30 + var_183_23
					end
				end

				arg_180_1.text_.text = var_183_27
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042044", "story_v_out_417042.awb") ~= 0 then
					local var_183_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042044", "story_v_out_417042.awb") / 1000

					if var_183_31 + var_183_23 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_31 + var_183_23
					end

					if var_183_26.prefab_name ~= "" and arg_180_1.actors_[var_183_26.prefab_name] ~= nil then
						local var_183_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_26.prefab_name].transform, "story_v_out_417042", "417042044", "story_v_out_417042.awb")

						arg_180_1:RecordAudio("417042044", var_183_32)
						arg_180_1:RecordAudio("417042044", var_183_32)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417042", "417042044", "story_v_out_417042.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417042", "417042044", "story_v_out_417042.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_33 = math.max(var_183_24, arg_180_1.talkMaxDuration)

			if var_183_23 <= arg_180_1.time_ and arg_180_1.time_ < var_183_23 + var_183_33 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_23) / var_183_33

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_23 + var_183_33 and arg_180_1.time_ < var_183_23 + var_183_33 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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

		arg_180_1:InitPlayNodeList()
	end,
	Play417042045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417042045
		arg_184_1.duration_ = 5.93

		local var_184_0 = {
			zh = 3.466,
			ja = 5.933
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
				arg_184_0:Play417042046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1034"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1034 == nil then
				arg_184_1.var_.actorSpriteComps1034 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps1034 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								local var_187_4 = Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor1.r, var_187_3)
								local var_187_5 = Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor1.g, var_187_3)
								local var_187_6 = Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor1.b, var_187_3)

								iter_187_1.color = Color.New(var_187_4, var_187_5, var_187_6)
							else
								local var_187_7 = Mathf.Lerp(iter_187_1.color.r, 1, var_187_3)

								iter_187_1.color = Color.New(var_187_7, var_187_7, var_187_7)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1034 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps1034 = nil
			end

			local var_187_8 = arg_184_1.actors_["10115"]
			local var_187_9 = 0

			if var_187_9 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps10115 == nil then
				arg_184_1.var_.actorSpriteComps10115 = var_187_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_10 = 0.2

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_10 and not isNil(var_187_8) then
				local var_187_11 = (arg_184_1.time_ - var_187_9) / var_187_10

				if arg_184_1.var_.actorSpriteComps10115 then
					for iter_187_4, iter_187_5 in pairs(arg_184_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_187_5 then
							if arg_184_1.isInRecall_ then
								local var_187_12 = Mathf.Lerp(iter_187_5.color.r, arg_184_1.hightColor2.r, var_187_11)
								local var_187_13 = Mathf.Lerp(iter_187_5.color.g, arg_184_1.hightColor2.g, var_187_11)
								local var_187_14 = Mathf.Lerp(iter_187_5.color.b, arg_184_1.hightColor2.b, var_187_11)

								iter_187_5.color = Color.New(var_187_12, var_187_13, var_187_14)
							else
								local var_187_15 = Mathf.Lerp(iter_187_5.color.r, 0.5, var_187_11)

								iter_187_5.color = Color.New(var_187_15, var_187_15, var_187_15)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_9 + var_187_10 and arg_184_1.time_ < var_187_9 + var_187_10 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps10115 then
				for iter_187_6, iter_187_7 in pairs(arg_184_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_187_7 then
						if arg_184_1.isInRecall_ then
							iter_187_7.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10115 = nil
			end

			local var_187_16 = 0
			local var_187_17 = 0.35

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_18 = arg_184_1:FormatText(StoryNameCfg[1109].name)

				arg_184_1.leftNameTxt_.text = var_187_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_19 = arg_184_1:GetWordFromCfg(417042045)
				local var_187_20 = arg_184_1:FormatText(var_187_19.content)

				arg_184_1.text_.text = var_187_20

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_21 = 14
				local var_187_22 = utf8.len(var_187_20)
				local var_187_23 = var_187_21 <= 0 and var_187_17 or var_187_17 * (var_187_22 / var_187_21)

				if var_187_23 > 0 and var_187_17 < var_187_23 then
					arg_184_1.talkMaxDuration = var_187_23

					if var_187_23 + var_187_16 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_23 + var_187_16
					end
				end

				arg_184_1.text_.text = var_187_20
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042045", "story_v_out_417042.awb") ~= 0 then
					local var_187_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042045", "story_v_out_417042.awb") / 1000

					if var_187_24 + var_187_16 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_24 + var_187_16
					end

					if var_187_19.prefab_name ~= "" and arg_184_1.actors_[var_187_19.prefab_name] ~= nil then
						local var_187_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_19.prefab_name].transform, "story_v_out_417042", "417042045", "story_v_out_417042.awb")

						arg_184_1:RecordAudio("417042045", var_187_25)
						arg_184_1:RecordAudio("417042045", var_187_25)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417042", "417042045", "story_v_out_417042.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417042", "417042045", "story_v_out_417042.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_26 = math.max(var_187_17, arg_184_1.talkMaxDuration)

			if var_187_16 <= arg_184_1.time_ and arg_184_1.time_ < var_187_16 + var_187_26 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_16) / var_187_26

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_16 + var_187_26 and arg_184_1.time_ < var_187_16 + var_187_26 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417042046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417042046
		arg_188_1.duration_ = 7.7

		local var_188_0 = {
			zh = 7.7,
			ja = 7.366
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
				arg_188_0:Play417042047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10115"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10115 == nil then
				arg_188_1.var_.actorSpriteComps10115 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps10115 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								local var_191_4 = Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, var_191_3)
								local var_191_5 = Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, var_191_3)
								local var_191_6 = Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, var_191_3)

								iter_191_1.color = Color.New(var_191_4, var_191_5, var_191_6)
							else
								local var_191_7 = Mathf.Lerp(iter_191_1.color.r, 1, var_191_3)

								iter_191_1.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps10115 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10115 = nil
			end

			local var_191_8 = arg_188_1.actors_["1034"]
			local var_191_9 = 0

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps1034 == nil then
				arg_188_1.var_.actorSpriteComps1034 = var_191_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_10 = 0.2

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_10 and not isNil(var_191_8) then
				local var_191_11 = (arg_188_1.time_ - var_191_9) / var_191_10

				if arg_188_1.var_.actorSpriteComps1034 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								local var_191_12 = Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, var_191_11)
								local var_191_13 = Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, var_191_11)
								local var_191_14 = Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, var_191_11)

								iter_191_5.color = Color.New(var_191_12, var_191_13, var_191_14)
							else
								local var_191_15 = Mathf.Lerp(iter_191_5.color.r, 0.5, var_191_11)

								iter_191_5.color = Color.New(var_191_15, var_191_15, var_191_15)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_9 + var_191_10 and arg_188_1.time_ < var_191_9 + var_191_10 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps1034 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_191_7 then
						if arg_188_1.isInRecall_ then
							iter_191_7.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1034 = nil
			end

			local var_191_16 = arg_188_1.actors_["10115"].transform
			local var_191_17 = 0

			if var_191_17 < arg_188_1.time_ and arg_188_1.time_ <= var_191_17 + arg_191_0 then
				arg_188_1.var_.moveOldPos10115 = var_191_16.localPosition
				var_191_16.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10115", 2)

				local var_191_18 = var_191_16.childCount

				for iter_191_8 = 0, var_191_18 - 1 do
					local var_191_19 = var_191_16:GetChild(iter_191_8)

					if var_191_19.name == "split_4" or not string.find(var_191_19.name, "split") then
						var_191_19.gameObject:SetActive(true)
					else
						var_191_19.gameObject:SetActive(false)
					end
				end
			end

			local var_191_20 = 0.001

			if var_191_17 <= arg_188_1.time_ and arg_188_1.time_ < var_191_17 + var_191_20 then
				local var_191_21 = (arg_188_1.time_ - var_191_17) / var_191_20
				local var_191_22 = Vector3.New(-390, -387.3, -246.2)

				var_191_16.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10115, var_191_22, var_191_21)
			end

			if arg_188_1.time_ >= var_191_17 + var_191_20 and arg_188_1.time_ < var_191_17 + var_191_20 + arg_191_0 then
				var_191_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_191_23 = 0
			local var_191_24 = 1

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_25 = arg_188_1:FormatText(StoryNameCfg[1113].name)

				arg_188_1.leftNameTxt_.text = var_191_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_26 = arg_188_1:GetWordFromCfg(417042046)
				local var_191_27 = arg_188_1:FormatText(var_191_26.content)

				arg_188_1.text_.text = var_191_27

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_28 = 40
				local var_191_29 = utf8.len(var_191_27)
				local var_191_30 = var_191_28 <= 0 and var_191_24 or var_191_24 * (var_191_29 / var_191_28)

				if var_191_30 > 0 and var_191_24 < var_191_30 then
					arg_188_1.talkMaxDuration = var_191_30

					if var_191_30 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_30 + var_191_23
					end
				end

				arg_188_1.text_.text = var_191_27
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042046", "story_v_out_417042.awb") ~= 0 then
					local var_191_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042046", "story_v_out_417042.awb") / 1000

					if var_191_31 + var_191_23 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_31 + var_191_23
					end

					if var_191_26.prefab_name ~= "" and arg_188_1.actors_[var_191_26.prefab_name] ~= nil then
						local var_191_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_26.prefab_name].transform, "story_v_out_417042", "417042046", "story_v_out_417042.awb")

						arg_188_1:RecordAudio("417042046", var_191_32)
						arg_188_1:RecordAudio("417042046", var_191_32)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417042", "417042046", "story_v_out_417042.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417042", "417042046", "story_v_out_417042.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_33 = math.max(var_191_24, arg_188_1.talkMaxDuration)

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_33 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_23) / var_191_33

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_23 + var_191_33 and arg_188_1.time_ < var_191_23 + var_191_33 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play417042047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417042047
		arg_192_1.duration_ = 7.27

		local var_192_0 = {
			zh = 3.733,
			ja = 7.266
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
				arg_192_0:Play417042048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1034"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1034 == nil then
				arg_192_1.var_.actorSpriteComps1034 = var_195_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_2 = 0.2

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.actorSpriteComps1034 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.actorSpriteComps1034 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_195_3 then
						if arg_192_1.isInRecall_ then
							iter_195_3.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps1034 = nil
			end

			local var_195_8 = arg_192_1.actors_["10115"]
			local var_195_9 = 0

			if var_195_9 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10115 == nil then
				arg_192_1.var_.actorSpriteComps10115 = var_195_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_10 = 0.2

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_10 and not isNil(var_195_8) then
				local var_195_11 = (arg_192_1.time_ - var_195_9) / var_195_10

				if arg_192_1.var_.actorSpriteComps10115 then
					for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_195_5 then
							if arg_192_1.isInRecall_ then
								local var_195_12 = Mathf.Lerp(iter_195_5.color.r, arg_192_1.hightColor2.r, var_195_11)
								local var_195_13 = Mathf.Lerp(iter_195_5.color.g, arg_192_1.hightColor2.g, var_195_11)
								local var_195_14 = Mathf.Lerp(iter_195_5.color.b, arg_192_1.hightColor2.b, var_195_11)

								iter_195_5.color = Color.New(var_195_12, var_195_13, var_195_14)
							else
								local var_195_15 = Mathf.Lerp(iter_195_5.color.r, 0.5, var_195_11)

								iter_195_5.color = Color.New(var_195_15, var_195_15, var_195_15)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_9 + var_195_10 and arg_192_1.time_ < var_195_9 + var_195_10 + arg_195_0 and not isNil(var_195_8) and arg_192_1.var_.actorSpriteComps10115 then
				for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_195_7 then
						if arg_192_1.isInRecall_ then
							iter_195_7.color = arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_195_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10115 = nil
			end

			local var_195_16 = 0
			local var_195_17 = 0.5

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_18 = arg_192_1:FormatText(StoryNameCfg[1109].name)

				arg_192_1.leftNameTxt_.text = var_195_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_19 = arg_192_1:GetWordFromCfg(417042047)
				local var_195_20 = arg_192_1:FormatText(var_195_19.content)

				arg_192_1.text_.text = var_195_20

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_21 = 20
				local var_195_22 = utf8.len(var_195_20)
				local var_195_23 = var_195_21 <= 0 and var_195_17 or var_195_17 * (var_195_22 / var_195_21)

				if var_195_23 > 0 and var_195_17 < var_195_23 then
					arg_192_1.talkMaxDuration = var_195_23

					if var_195_23 + var_195_16 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_23 + var_195_16
					end
				end

				arg_192_1.text_.text = var_195_20
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042047", "story_v_out_417042.awb") ~= 0 then
					local var_195_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042047", "story_v_out_417042.awb") / 1000

					if var_195_24 + var_195_16 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_24 + var_195_16
					end

					if var_195_19.prefab_name ~= "" and arg_192_1.actors_[var_195_19.prefab_name] ~= nil then
						local var_195_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_19.prefab_name].transform, "story_v_out_417042", "417042047", "story_v_out_417042.awb")

						arg_192_1:RecordAudio("417042047", var_195_25)
						arg_192_1:RecordAudio("417042047", var_195_25)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417042", "417042047", "story_v_out_417042.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417042", "417042047", "story_v_out_417042.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_26 = math.max(var_195_17, arg_192_1.talkMaxDuration)

			if var_195_16 <= arg_192_1.time_ and arg_192_1.time_ < var_195_16 + var_195_26 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_16) / var_195_26

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_16 + var_195_26 and arg_192_1.time_ < var_195_16 + var_195_26 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play417042048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417042048
		arg_196_1.duration_ = 10.07

		local var_196_0 = {
			zh = 10.066,
			ja = 8.666
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play417042049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 1.275

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[1109].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_3 = arg_196_1:GetWordFromCfg(417042048)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 51
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042048", "story_v_out_417042.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042048", "story_v_out_417042.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_417042", "417042048", "story_v_out_417042.awb")

						arg_196_1:RecordAudio("417042048", var_199_9)
						arg_196_1:RecordAudio("417042048", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417042", "417042048", "story_v_out_417042.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417042", "417042048", "story_v_out_417042.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play417042049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417042049
		arg_200_1.duration_ = 9.8

		local var_200_0 = {
			zh = 6.866,
			ja = 9.8
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417042050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10115"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10115 == nil then
				arg_200_1.var_.actorSpriteComps10115 = var_203_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.actorSpriteComps10115 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								local var_203_4 = Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, var_203_3)
								local var_203_5 = Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, var_203_3)
								local var_203_6 = Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, var_203_3)

								iter_203_1.color = Color.New(var_203_4, var_203_5, var_203_6)
							else
								local var_203_7 = Mathf.Lerp(iter_203_1.color.r, 1, var_203_3)

								iter_203_1.color = Color.New(var_203_7, var_203_7, var_203_7)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps10115 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_203_3 then
						if arg_200_1.isInRecall_ then
							iter_203_3.color = arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_203_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10115 = nil
			end

			local var_203_8 = arg_200_1.actors_["1034"]
			local var_203_9 = 0

			if var_203_9 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps1034 == nil then
				arg_200_1.var_.actorSpriteComps1034 = var_203_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_10 = 0.2

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_10 and not isNil(var_203_8) then
				local var_203_11 = (arg_200_1.time_ - var_203_9) / var_203_10

				if arg_200_1.var_.actorSpriteComps1034 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								local var_203_12 = Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, var_203_11)
								local var_203_13 = Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, var_203_11)
								local var_203_14 = Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, var_203_11)

								iter_203_5.color = Color.New(var_203_12, var_203_13, var_203_14)
							else
								local var_203_15 = Mathf.Lerp(iter_203_5.color.r, 0.5, var_203_11)

								iter_203_5.color = Color.New(var_203_15, var_203_15, var_203_15)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_9 + var_203_10 and arg_200_1.time_ < var_203_9 + var_203_10 + arg_203_0 and not isNil(var_203_8) and arg_200_1.var_.actorSpriteComps1034 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_203_7 then
						if arg_200_1.isInRecall_ then
							iter_203_7.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps1034 = nil
			end

			local var_203_16 = arg_200_1.actors_["10115"].transform
			local var_203_17 = 0

			if var_203_17 < arg_200_1.time_ and arg_200_1.time_ <= var_203_17 + arg_203_0 then
				arg_200_1.var_.moveOldPos10115 = var_203_16.localPosition
				var_203_16.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10115", 2)

				local var_203_18 = var_203_16.childCount

				for iter_203_8 = 0, var_203_18 - 1 do
					local var_203_19 = var_203_16:GetChild(iter_203_8)

					if var_203_19.name == "" or not string.find(var_203_19.name, "split") then
						var_203_19.gameObject:SetActive(true)
					else
						var_203_19.gameObject:SetActive(false)
					end
				end
			end

			local var_203_20 = 0.001

			if var_203_17 <= arg_200_1.time_ and arg_200_1.time_ < var_203_17 + var_203_20 then
				local var_203_21 = (arg_200_1.time_ - var_203_17) / var_203_20
				local var_203_22 = Vector3.New(-390, -387.3, -246.2)

				var_203_16.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10115, var_203_22, var_203_21)
			end

			if arg_200_1.time_ >= var_203_17 + var_203_20 and arg_200_1.time_ < var_203_17 + var_203_20 + arg_203_0 then
				var_203_16.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_203_23 = 0
			local var_203_24 = 0.8

			if var_203_23 < arg_200_1.time_ and arg_200_1.time_ <= var_203_23 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_25 = arg_200_1:FormatText(StoryNameCfg[1113].name)

				arg_200_1.leftNameTxt_.text = var_203_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_26 = arg_200_1:GetWordFromCfg(417042049)
				local var_203_27 = arg_200_1:FormatText(var_203_26.content)

				arg_200_1.text_.text = var_203_27

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_28 = 32
				local var_203_29 = utf8.len(var_203_27)
				local var_203_30 = var_203_28 <= 0 and var_203_24 or var_203_24 * (var_203_29 / var_203_28)

				if var_203_30 > 0 and var_203_24 < var_203_30 then
					arg_200_1.talkMaxDuration = var_203_30

					if var_203_30 + var_203_23 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_30 + var_203_23
					end
				end

				arg_200_1.text_.text = var_203_27
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042049", "story_v_out_417042.awb") ~= 0 then
					local var_203_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042049", "story_v_out_417042.awb") / 1000

					if var_203_31 + var_203_23 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_31 + var_203_23
					end

					if var_203_26.prefab_name ~= "" and arg_200_1.actors_[var_203_26.prefab_name] ~= nil then
						local var_203_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_26.prefab_name].transform, "story_v_out_417042", "417042049", "story_v_out_417042.awb")

						arg_200_1:RecordAudio("417042049", var_203_32)
						arg_200_1:RecordAudio("417042049", var_203_32)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_417042", "417042049", "story_v_out_417042.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_417042", "417042049", "story_v_out_417042.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_33 = math.max(var_203_24, arg_200_1.talkMaxDuration)

			if var_203_23 <= arg_200_1.time_ and arg_200_1.time_ < var_203_23 + var_203_33 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_23) / var_203_33

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_23 + var_203_33 and arg_200_1.time_ < var_203_23 + var_203_33 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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

		arg_200_1:InitPlayNodeList()
	end,
	Play417042050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417042050
		arg_204_1.duration_ = 4.87

		local var_204_0 = {
			zh = 3.3,
			ja = 4.866
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play417042051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1034"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps1034 == nil then
				arg_204_1.var_.actorSpriteComps1034 = var_207_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.actorSpriteComps1034 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								local var_207_4 = Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor1.r, var_207_3)
								local var_207_5 = Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor1.g, var_207_3)
								local var_207_6 = Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor1.b, var_207_3)

								iter_207_1.color = Color.New(var_207_4, var_207_5, var_207_6)
							else
								local var_207_7 = Mathf.Lerp(iter_207_1.color.r, 1, var_207_3)

								iter_207_1.color = Color.New(var_207_7, var_207_7, var_207_7)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps1034 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_207_3 then
						if arg_204_1.isInRecall_ then
							iter_207_3.color = arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_207_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps1034 = nil
			end

			local var_207_8 = arg_204_1.actors_["10115"]
			local var_207_9 = 0

			if var_207_9 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.actorSpriteComps10115 == nil then
				arg_204_1.var_.actorSpriteComps10115 = var_207_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_10 = 0.2

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_10 and not isNil(var_207_8) then
				local var_207_11 = (arg_204_1.time_ - var_207_9) / var_207_10

				if arg_204_1.var_.actorSpriteComps10115 then
					for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_207_5 then
							if arg_204_1.isInRecall_ then
								local var_207_12 = Mathf.Lerp(iter_207_5.color.r, arg_204_1.hightColor2.r, var_207_11)
								local var_207_13 = Mathf.Lerp(iter_207_5.color.g, arg_204_1.hightColor2.g, var_207_11)
								local var_207_14 = Mathf.Lerp(iter_207_5.color.b, arg_204_1.hightColor2.b, var_207_11)

								iter_207_5.color = Color.New(var_207_12, var_207_13, var_207_14)
							else
								local var_207_15 = Mathf.Lerp(iter_207_5.color.r, 0.5, var_207_11)

								iter_207_5.color = Color.New(var_207_15, var_207_15, var_207_15)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_9 + var_207_10 and arg_204_1.time_ < var_207_9 + var_207_10 + arg_207_0 and not isNil(var_207_8) and arg_204_1.var_.actorSpriteComps10115 then
				for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_207_7 then
						if arg_204_1.isInRecall_ then
							iter_207_7.color = arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_207_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps10115 = nil
			end

			local var_207_16 = arg_204_1.actors_["1034"].transform
			local var_207_17 = 0

			if var_207_17 < arg_204_1.time_ and arg_204_1.time_ <= var_207_17 + arg_207_0 then
				arg_204_1.var_.moveOldPos1034 = var_207_16.localPosition
				var_207_16.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("1034", 4)

				local var_207_18 = var_207_16.childCount

				for iter_207_8 = 0, var_207_18 - 1 do
					local var_207_19 = var_207_16:GetChild(iter_207_8)

					if var_207_19.name == "" or not string.find(var_207_19.name, "split") then
						var_207_19.gameObject:SetActive(true)
					else
						var_207_19.gameObject:SetActive(false)
					end
				end
			end

			local var_207_20 = 0.001

			if var_207_17 <= arg_204_1.time_ and arg_204_1.time_ < var_207_17 + var_207_20 then
				local var_207_21 = (arg_204_1.time_ - var_207_17) / var_207_20
				local var_207_22 = Vector3.New(373.7, -331.9, -324)

				var_207_16.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1034, var_207_22, var_207_21)
			end

			if arg_204_1.time_ >= var_207_17 + var_207_20 and arg_204_1.time_ < var_207_17 + var_207_20 + arg_207_0 then
				var_207_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_207_23 = 0
			local var_207_24 = 0.425

			if var_207_23 < arg_204_1.time_ and arg_204_1.time_ <= var_207_23 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_25 = arg_204_1:FormatText(StoryNameCfg[1109].name)

				arg_204_1.leftNameTxt_.text = var_207_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_26 = arg_204_1:GetWordFromCfg(417042050)
				local var_207_27 = arg_204_1:FormatText(var_207_26.content)

				arg_204_1.text_.text = var_207_27

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_28 = 17
				local var_207_29 = utf8.len(var_207_27)
				local var_207_30 = var_207_28 <= 0 and var_207_24 or var_207_24 * (var_207_29 / var_207_28)

				if var_207_30 > 0 and var_207_24 < var_207_30 then
					arg_204_1.talkMaxDuration = var_207_30

					if var_207_30 + var_207_23 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_30 + var_207_23
					end
				end

				arg_204_1.text_.text = var_207_27
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042050", "story_v_out_417042.awb") ~= 0 then
					local var_207_31 = manager.audio:GetVoiceLength("story_v_out_417042", "417042050", "story_v_out_417042.awb") / 1000

					if var_207_31 + var_207_23 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_31 + var_207_23
					end

					if var_207_26.prefab_name ~= "" and arg_204_1.actors_[var_207_26.prefab_name] ~= nil then
						local var_207_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_26.prefab_name].transform, "story_v_out_417042", "417042050", "story_v_out_417042.awb")

						arg_204_1:RecordAudio("417042050", var_207_32)
						arg_204_1:RecordAudio("417042050", var_207_32)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_417042", "417042050", "story_v_out_417042.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_417042", "417042050", "story_v_out_417042.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_33 = math.max(var_207_24, arg_204_1.talkMaxDuration)

			if var_207_23 <= arg_204_1.time_ and arg_204_1.time_ < var_207_23 + var_207_33 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_23) / var_207_33

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_23 + var_207_33 and arg_204_1.time_ < var_207_23 + var_207_33 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play417042051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417042051
		arg_208_1.duration_ = 2.97

		local var_208_0 = {
			zh = 1.366,
			ja = 2.966
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play417042052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10115"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.actorSpriteComps10115 == nil then
				arg_208_1.var_.actorSpriteComps10115 = var_211_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_2 = 0.2

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.actorSpriteComps10115 then
					for iter_211_0, iter_211_1 in pairs(arg_208_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_211_1 then
							if arg_208_1.isInRecall_ then
								local var_211_4 = Mathf.Lerp(iter_211_1.color.r, arg_208_1.hightColor1.r, var_211_3)
								local var_211_5 = Mathf.Lerp(iter_211_1.color.g, arg_208_1.hightColor1.g, var_211_3)
								local var_211_6 = Mathf.Lerp(iter_211_1.color.b, arg_208_1.hightColor1.b, var_211_3)

								iter_211_1.color = Color.New(var_211_4, var_211_5, var_211_6)
							else
								local var_211_7 = Mathf.Lerp(iter_211_1.color.r, 1, var_211_3)

								iter_211_1.color = Color.New(var_211_7, var_211_7, var_211_7)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.actorSpriteComps10115 then
				for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_211_3 then
						if arg_208_1.isInRecall_ then
							iter_211_3.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_211_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps10115 = nil
			end

			local var_211_8 = arg_208_1.actors_["1034"]
			local var_211_9 = 0

			if var_211_9 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 and not isNil(var_211_8) and arg_208_1.var_.actorSpriteComps1034 == nil then
				arg_208_1.var_.actorSpriteComps1034 = var_211_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_10 = 0.2

			if var_211_9 <= arg_208_1.time_ and arg_208_1.time_ < var_211_9 + var_211_10 and not isNil(var_211_8) then
				local var_211_11 = (arg_208_1.time_ - var_211_9) / var_211_10

				if arg_208_1.var_.actorSpriteComps1034 then
					for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_211_5 then
							if arg_208_1.isInRecall_ then
								local var_211_12 = Mathf.Lerp(iter_211_5.color.r, arg_208_1.hightColor2.r, var_211_11)
								local var_211_13 = Mathf.Lerp(iter_211_5.color.g, arg_208_1.hightColor2.g, var_211_11)
								local var_211_14 = Mathf.Lerp(iter_211_5.color.b, arg_208_1.hightColor2.b, var_211_11)

								iter_211_5.color = Color.New(var_211_12, var_211_13, var_211_14)
							else
								local var_211_15 = Mathf.Lerp(iter_211_5.color.r, 0.5, var_211_11)

								iter_211_5.color = Color.New(var_211_15, var_211_15, var_211_15)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_9 + var_211_10 and arg_208_1.time_ < var_211_9 + var_211_10 + arg_211_0 and not isNil(var_211_8) and arg_208_1.var_.actorSpriteComps1034 then
				for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_211_7 then
						if arg_208_1.isInRecall_ then
							iter_211_7.color = arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_211_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps1034 = nil
			end

			local var_211_16 = 0
			local var_211_17 = 0.125

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_18 = arg_208_1:FormatText(StoryNameCfg[1113].name)

				arg_208_1.leftNameTxt_.text = var_211_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_19 = arg_208_1:GetWordFromCfg(417042051)
				local var_211_20 = arg_208_1:FormatText(var_211_19.content)

				arg_208_1.text_.text = var_211_20

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_21 = 5
				local var_211_22 = utf8.len(var_211_20)
				local var_211_23 = var_211_21 <= 0 and var_211_17 or var_211_17 * (var_211_22 / var_211_21)

				if var_211_23 > 0 and var_211_17 < var_211_23 then
					arg_208_1.talkMaxDuration = var_211_23

					if var_211_23 + var_211_16 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_23 + var_211_16
					end
				end

				arg_208_1.text_.text = var_211_20
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042051", "story_v_out_417042.awb") ~= 0 then
					local var_211_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042051", "story_v_out_417042.awb") / 1000

					if var_211_24 + var_211_16 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_24 + var_211_16
					end

					if var_211_19.prefab_name ~= "" and arg_208_1.actors_[var_211_19.prefab_name] ~= nil then
						local var_211_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_19.prefab_name].transform, "story_v_out_417042", "417042051", "story_v_out_417042.awb")

						arg_208_1:RecordAudio("417042051", var_211_25)
						arg_208_1:RecordAudio("417042051", var_211_25)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_417042", "417042051", "story_v_out_417042.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_417042", "417042051", "story_v_out_417042.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_26 = math.max(var_211_17, arg_208_1.talkMaxDuration)

			if var_211_16 <= arg_208_1.time_ and arg_208_1.time_ < var_211_16 + var_211_26 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_16) / var_211_26

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_16 + var_211_26 and arg_208_1.time_ < var_211_16 + var_211_26 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play417042052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 417042052
		arg_212_1.duration_ = 7.9

		local var_212_0 = {
			zh = 6.066,
			ja = 7.9
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play417042053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.775

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[1113].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:GetWordFromCfg(417042052)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 31
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042052", "story_v_out_417042.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_417042", "417042052", "story_v_out_417042.awb") / 1000

					if var_215_8 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_0
					end

					if var_215_3.prefab_name ~= "" and arg_212_1.actors_[var_215_3.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_3.prefab_name].transform, "story_v_out_417042", "417042052", "story_v_out_417042.awb")

						arg_212_1:RecordAudio("417042052", var_215_9)
						arg_212_1:RecordAudio("417042052", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_417042", "417042052", "story_v_out_417042.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_417042", "417042052", "story_v_out_417042.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_10 and arg_212_1.time_ < var_215_0 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play417042053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 417042053
		arg_216_1.duration_ = 2.83

		local var_216_0 = {
			zh = 1.366,
			ja = 2.833
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
			arg_216_1.auto_ = false
		end

		function arg_216_1.playNext_(arg_218_0)
			arg_216_1.onStoryFinished_()
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1034"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1034 == nil then
				arg_216_1.var_.actorSpriteComps1034 = var_219_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_2 = 0.2

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.actorSpriteComps1034 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								local var_219_4 = Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor1.r, var_219_3)
								local var_219_5 = Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor1.g, var_219_3)
								local var_219_6 = Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor1.b, var_219_3)

								iter_219_1.color = Color.New(var_219_4, var_219_5, var_219_6)
							else
								local var_219_7 = Mathf.Lerp(iter_219_1.color.r, 1, var_219_3)

								iter_219_1.color = Color.New(var_219_7, var_219_7, var_219_7)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1034 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_219_3 then
						if arg_216_1.isInRecall_ then
							iter_219_3.color = arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_219_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps1034 = nil
			end

			local var_219_8 = arg_216_1.actors_["10115"]
			local var_219_9 = 0

			if var_219_9 < arg_216_1.time_ and arg_216_1.time_ <= var_219_9 + arg_219_0 and not isNil(var_219_8) and arg_216_1.var_.actorSpriteComps10115 == nil then
				arg_216_1.var_.actorSpriteComps10115 = var_219_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_10 = 0.2

			if var_219_9 <= arg_216_1.time_ and arg_216_1.time_ < var_219_9 + var_219_10 and not isNil(var_219_8) then
				local var_219_11 = (arg_216_1.time_ - var_219_9) / var_219_10

				if arg_216_1.var_.actorSpriteComps10115 then
					for iter_219_4, iter_219_5 in pairs(arg_216_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_219_5 then
							if arg_216_1.isInRecall_ then
								local var_219_12 = Mathf.Lerp(iter_219_5.color.r, arg_216_1.hightColor2.r, var_219_11)
								local var_219_13 = Mathf.Lerp(iter_219_5.color.g, arg_216_1.hightColor2.g, var_219_11)
								local var_219_14 = Mathf.Lerp(iter_219_5.color.b, arg_216_1.hightColor2.b, var_219_11)

								iter_219_5.color = Color.New(var_219_12, var_219_13, var_219_14)
							else
								local var_219_15 = Mathf.Lerp(iter_219_5.color.r, 0.5, var_219_11)

								iter_219_5.color = Color.New(var_219_15, var_219_15, var_219_15)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= var_219_9 + var_219_10 and arg_216_1.time_ < var_219_9 + var_219_10 + arg_219_0 and not isNil(var_219_8) and arg_216_1.var_.actorSpriteComps10115 then
				for iter_219_6, iter_219_7 in pairs(arg_216_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_219_7 then
						if arg_216_1.isInRecall_ then
							iter_219_7.color = arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_219_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps10115 = nil
			end

			local var_219_16 = 0
			local var_219_17 = 0.15

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_18 = arg_216_1:FormatText(StoryNameCfg[1109].name)

				arg_216_1.leftNameTxt_.text = var_219_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_19 = arg_216_1:GetWordFromCfg(417042053)
				local var_219_20 = arg_216_1:FormatText(var_219_19.content)

				arg_216_1.text_.text = var_219_20

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_21 = 6
				local var_219_22 = utf8.len(var_219_20)
				local var_219_23 = var_219_21 <= 0 and var_219_17 or var_219_17 * (var_219_22 / var_219_21)

				if var_219_23 > 0 and var_219_17 < var_219_23 then
					arg_216_1.talkMaxDuration = var_219_23

					if var_219_23 + var_219_16 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_23 + var_219_16
					end
				end

				arg_216_1.text_.text = var_219_20
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417042", "417042053", "story_v_out_417042.awb") ~= 0 then
					local var_219_24 = manager.audio:GetVoiceLength("story_v_out_417042", "417042053", "story_v_out_417042.awb") / 1000

					if var_219_24 + var_219_16 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_24 + var_219_16
					end

					if var_219_19.prefab_name ~= "" and arg_216_1.actors_[var_219_19.prefab_name] ~= nil then
						local var_219_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_19.prefab_name].transform, "story_v_out_417042", "417042053", "story_v_out_417042.awb")

						arg_216_1:RecordAudio("417042053", var_219_25)
						arg_216_1:RecordAudio("417042053", var_219_25)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_417042", "417042053", "story_v_out_417042.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_417042", "417042053", "story_v_out_417042.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_26 = math.max(var_219_17, arg_216_1.talkMaxDuration)

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_26 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_16) / var_219_26

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_16 + var_219_26 and arg_216_1.time_ < var_219_16 + var_219_26 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I16f",
		"TextureConfig/Background/ST73"
	},
	voices = {
		"story_v_out_417042.awb"
	}
}
