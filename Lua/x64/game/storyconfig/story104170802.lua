return {
	Play417082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417082001
		arg_1_1.duration_ = 7.5

		local var_1_0 = {
			zh = 6.866,
			ja = 7.5
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
				arg_1_0:Play417082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D06a"

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
				local var_4_5 = arg_1_1.bgs_.D06a

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
					if iter_4_0 ~= "D06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 5.600000000001

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = "1034"

			if arg_1_1.actors_[var_4_18] == nil then
				local var_4_19 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

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

			local var_4_22 = arg_1_1.actors_["1034"]
			local var_4_23 = 5.4

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 and not isNil(var_4_22) and arg_1_1.var_.actorSpriteComps1034 == nil then
				arg_1_1.var_.actorSpriteComps1034 = var_4_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_24 = 0.2

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 and not isNil(var_4_22) then
				local var_4_25 = (arg_1_1.time_ - var_4_23) / var_4_24

				if arg_1_1.var_.actorSpriteComps1034 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 and not isNil(var_4_22) and arg_1_1.var_.actorSpriteComps1034 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1034 = nil
			end

			local var_4_30 = arg_1_1.actors_["1034"].transform
			local var_4_31 = 5.4

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034 = var_4_30.localPosition
				var_4_30.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1034", 3)

				local var_4_32 = var_4_30.childCount

				for iter_4_8 = 0, var_4_32 - 1 do
					local var_4_33 = var_4_30:GetChild(iter_4_8)

					if var_4_33.name == "" or not string.find(var_4_33.name, "split") then
						var_4_33.gameObject:SetActive(true)
					else
						var_4_33.gameObject:SetActive(false)
					end
				end
			end

			local var_4_34 = 0.001

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_34 then
				local var_4_35 = (arg_1_1.time_ - var_4_31) / var_4_34
				local var_4_36 = Vector3.New(0, -331.9, -324)

				var_4_30.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034, var_4_36, var_4_35)
			end

			if arg_1_1.time_ >= var_4_31 + var_4_34 and arg_1_1.time_ < var_4_31 + var_4_34 + arg_4_0 then
				var_4_30.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_4_37 = arg_1_1.actors_["1034"]
			local var_4_38 = 5.4

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				local var_4_39 = var_4_37:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_39 then
					arg_1_1.var_.alphaOldValue1034 = var_4_39.alpha
					arg_1_1.var_.characterEffect1034 = var_4_39
				end

				arg_1_1.var_.alphaOldValue1034 = 0
			end

			local var_4_40 = 0.200000000001

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_38) / var_4_40
				local var_4_42 = Mathf.Lerp(arg_1_1.var_.alphaOldValue1034, 1, var_4_41)

				if arg_1_1.var_.characterEffect1034 then
					arg_1_1.var_.characterEffect1034.alpha = var_4_42
				end
			end

			if arg_1_1.time_ >= var_4_38 + var_4_40 and arg_1_1.time_ < var_4_38 + var_4_40 + arg_4_0 and arg_1_1.var_.characterEffect1034 then
				arg_1_1.var_.characterEffect1034.alpha = 1
			end

			local var_4_43 = 0
			local var_4_44 = 0.2

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_48 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_48 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_48

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_48
						arg_1_1.bgmTxt2_.text = var_4_48
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

			local var_4_49 = 0.466666666666667
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

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

			local var_4_55 = 0
			local var_4_56 = 3
			local var_4_57 = "D06a"

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_57)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_58 = arg_1_1:GetWordFromCfg(501031)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_timeText_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_60 = arg_1_1:GetWordFromCfg(501032)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_siteText_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_55 + var_4_56 and arg_1_1.time_ < var_4_55 + var_4_56 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_62 = 3

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_63 = 1.2

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_63 then
				local var_4_64 = (arg_1_1.time_ - var_4_62) / var_4_63
				local var_4_65 = Color.New(0, 0, 0)

				var_4_65.a = Mathf.Lerp(0, 1, var_4_64)
				arg_1_1.mask_.color = var_4_65
			end

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 then
				local var_4_66 = Color.New(0, 0, 0)

				var_4_66.a = 1
				arg_1_1.mask_.color = var_4_66
			end

			local var_4_67 = 4.2

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_68 = 1.2

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				local var_4_69 = (arg_1_1.time_ - var_4_67) / var_4_68
				local var_4_70 = Color.New(0, 0, 0)

				var_4_70.a = Mathf.Lerp(1, 0, var_4_69)
				arg_1_1.mask_.color = var_4_70
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				local var_4_71 = Color.New(0, 0, 0)
				local var_4_72 = 0

				arg_1_1.mask_.enabled = false
				var_4_71.a = var_4_72
				arg_1_1.mask_.color = var_4_71
			end

			local var_4_73 = 0

			if var_4_73 < arg_1_1.time_ and arg_1_1.time_ <= var_4_73 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_74 = 1

			if var_4_73 <= arg_1_1.time_ and arg_1_1.time_ < var_4_73 + var_4_74 then
				local var_4_75 = (arg_1_1.time_ - var_4_73) / var_4_74
				local var_4_76 = Color.New(0, 0, 0)

				var_4_76.a = Mathf.Lerp(1, 0, var_4_75)
				arg_1_1.mask_.color = var_4_76
			end

			if arg_1_1.time_ >= var_4_73 + var_4_74 and arg_1_1.time_ < var_4_73 + var_4_74 + arg_4_0 then
				local var_4_77 = Color.New(0, 0, 0)
				local var_4_78 = 0

				arg_1_1.mask_.enabled = false
				var_4_77.a = var_4_78
				arg_1_1.mask_.color = var_4_77
			end

			local var_4_79 = 0

			if var_4_79 < arg_1_1.time_ and arg_1_1.time_ <= var_4_79 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_80 = 3

			if arg_1_1.time_ >= var_4_79 + var_4_80 and arg_1_1.time_ < var_4_79 + var_4_80 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_81 = 5.4
			local var_4_82 = 0.15

			if var_4_81 < arg_1_1.time_ and arg_1_1.time_ <= var_4_81 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_83 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_83:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_83:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_83:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_84 = arg_1_1:FormatText(StoryNameCfg[1109].name)

				arg_1_1.leftNameTxt_.text = var_4_84

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_85 = arg_1_1:GetWordFromCfg(417082001)
				local var_4_86 = arg_1_1:FormatText(var_4_85.content)

				arg_1_1.text_.text = var_4_86

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_87 = 6
				local var_4_88 = utf8.len(var_4_86)
				local var_4_89 = var_4_87 <= 0 and var_4_82 or var_4_82 * (var_4_88 / var_4_87)

				if var_4_89 > 0 and var_4_82 < var_4_89 then
					arg_1_1.talkMaxDuration = var_4_89
					var_4_81 = var_4_81 + 0.3

					if var_4_89 + var_4_81 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_89 + var_4_81
					end
				end

				arg_1_1.text_.text = var_4_86
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082001", "story_v_out_417082.awb") ~= 0 then
					local var_4_90 = manager.audio:GetVoiceLength("story_v_out_417082", "417082001", "story_v_out_417082.awb") / 1000

					if var_4_90 + var_4_81 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_90 + var_4_81
					end

					if var_4_85.prefab_name ~= "" and arg_1_1.actors_[var_4_85.prefab_name] ~= nil then
						local var_4_91 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_85.prefab_name].transform, "story_v_out_417082", "417082001", "story_v_out_417082.awb")

						arg_1_1:RecordAudio("417082001", var_4_91)
						arg_1_1:RecordAudio("417082001", var_4_91)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417082", "417082001", "story_v_out_417082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417082", "417082001", "story_v_out_417082.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_92 = var_4_81 + 0.3
			local var_4_93 = math.max(var_4_82, arg_1_1.talkMaxDuration)

			if var_4_92 <= arg_1_1.time_ and arg_1_1.time_ < var_4_92 + var_4_93 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_92) / var_4_93

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_92 + var_4_93 and arg_1_1.time_ < var_4_92 + var_4_93 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
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
	Play417082002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417082002
		arg_10_1.duration_ = 2.27

		local var_10_0 = {
			zh = 1.6,
			ja = 2.266
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
				arg_10_0:Play417082003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["1034"]
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 and not isNil(var_13_0) and arg_10_1.var_.actorSpriteComps1034 == nil then
				arg_10_1.var_.actorSpriteComps1034 = var_13_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_2 = 0.2

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 and not isNil(var_13_0) then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2

				if arg_10_1.var_.actorSpriteComps1034 then
					for iter_13_0, iter_13_1 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_13_1 then
							if arg_10_1.isInRecall_ then
								local var_13_4 = Mathf.Lerp(iter_13_1.color.r, arg_10_1.hightColor2.r, var_13_3)
								local var_13_5 = Mathf.Lerp(iter_13_1.color.g, arg_10_1.hightColor2.g, var_13_3)
								local var_13_6 = Mathf.Lerp(iter_13_1.color.b, arg_10_1.hightColor2.b, var_13_3)

								iter_13_1.color = Color.New(var_13_4, var_13_5, var_13_6)
							else
								local var_13_7 = Mathf.Lerp(iter_13_1.color.r, 0.5, var_13_3)

								iter_13_1.color = Color.New(var_13_7, var_13_7, var_13_7)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 and not isNil(var_13_0) and arg_10_1.var_.actorSpriteComps1034 then
				for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_13_3 then
						if arg_10_1.isInRecall_ then
							iter_13_3.color = arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_13_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps1034 = nil
			end

			local var_13_8 = 0
			local var_13_9 = 0.15

			if var_13_8 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_10 = arg_10_1:FormatText(StoryNameCfg[1110].name)

				arg_10_1.leftNameTxt_.text = var_13_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, true)
				arg_10_1.iconController_:SetSelectedState("hero")

				arg_10_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_10_1.callingController_:SetSelectedState("normal")

				arg_10_1.keyicon_.color = Color.New(1, 1, 1)
				arg_10_1.icon_.color = Color.New(1, 1, 1)

				local var_13_11 = arg_10_1:GetWordFromCfg(417082002)
				local var_13_12 = arg_10_1:FormatText(var_13_11.content)

				arg_10_1.text_.text = var_13_12

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 6
				local var_13_14 = utf8.len(var_13_12)
				local var_13_15 = var_13_13 <= 0 and var_13_9 or var_13_9 * (var_13_14 / var_13_13)

				if var_13_15 > 0 and var_13_9 < var_13_15 then
					arg_10_1.talkMaxDuration = var_13_15

					if var_13_15 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_15 + var_13_8
					end
				end

				arg_10_1.text_.text = var_13_12
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082002", "story_v_out_417082.awb") ~= 0 then
					local var_13_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082002", "story_v_out_417082.awb") / 1000

					if var_13_16 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_16 + var_13_8
					end

					if var_13_11.prefab_name ~= "" and arg_10_1.actors_[var_13_11.prefab_name] ~= nil then
						local var_13_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_11.prefab_name].transform, "story_v_out_417082", "417082002", "story_v_out_417082.awb")

						arg_10_1:RecordAudio("417082002", var_13_17)
						arg_10_1:RecordAudio("417082002", var_13_17)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417082", "417082002", "story_v_out_417082.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417082", "417082002", "story_v_out_417082.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_18 = math.max(var_13_9, arg_10_1.talkMaxDuration)

			if var_13_8 <= arg_10_1.time_ and arg_10_1.time_ < var_13_8 + var_13_18 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_8) / var_13_18

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_8 + var_13_18 and arg_10_1.time_ < var_13_8 + var_13_18 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417082003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417082003
		arg_14_1.duration_ = 7.87

		local var_14_0 = {
			zh = 4.5,
			ja = 7.866
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
				arg_14_0:Play417082004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1034"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps1034 == nil then
				arg_14_1.var_.actorSpriteComps1034 = var_17_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_2 = 0.2

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.actorSpriteComps1034 then
					for iter_17_0, iter_17_1 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_17_1 then
							if arg_14_1.isInRecall_ then
								local var_17_4 = Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor1.r, var_17_3)
								local var_17_5 = Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor1.g, var_17_3)
								local var_17_6 = Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor1.b, var_17_3)

								iter_17_1.color = Color.New(var_17_4, var_17_5, var_17_6)
							else
								local var_17_7 = Mathf.Lerp(iter_17_1.color.r, 1, var_17_3)

								iter_17_1.color = Color.New(var_17_7, var_17_7, var_17_7)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_3 then
						if arg_14_1.isInRecall_ then
							iter_17_3.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_17_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_8 = arg_14_1.actors_["1034"].transform
			local var_17_9 = 0

			if var_17_9 < arg_14_1.time_ and arg_14_1.time_ <= var_17_9 + arg_17_0 then
				arg_14_1.var_.moveOldPos1034 = var_17_8.localPosition
				var_17_8.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1034", 3)

				local var_17_10 = var_17_8.childCount

				for iter_17_4 = 0, var_17_10 - 1 do
					local var_17_11 = var_17_8:GetChild(iter_17_4)

					if var_17_11.name == "" or not string.find(var_17_11.name, "split") then
						var_17_11.gameObject:SetActive(true)
					else
						var_17_11.gameObject:SetActive(false)
					end
				end
			end

			local var_17_12 = 0.001

			if var_17_9 <= arg_14_1.time_ and arg_14_1.time_ < var_17_9 + var_17_12 then
				local var_17_13 = (arg_14_1.time_ - var_17_9) / var_17_12
				local var_17_14 = Vector3.New(0, -331.9, -324)

				var_17_8.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1034, var_17_14, var_17_13)
			end

			if arg_14_1.time_ >= var_17_9 + var_17_12 and arg_14_1.time_ < var_17_9 + var_17_12 + arg_17_0 then
				var_17_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_17_15 = 0
			local var_17_16 = 0.575

			if var_17_15 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_17 = arg_14_1:FormatText(StoryNameCfg[1109].name)

				arg_14_1.leftNameTxt_.text = var_17_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_18 = arg_14_1:GetWordFromCfg(417082003)
				local var_17_19 = arg_14_1:FormatText(var_17_18.content)

				arg_14_1.text_.text = var_17_19

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_20 = 23
				local var_17_21 = utf8.len(var_17_19)
				local var_17_22 = var_17_20 <= 0 and var_17_16 or var_17_16 * (var_17_21 / var_17_20)

				if var_17_22 > 0 and var_17_16 < var_17_22 then
					arg_14_1.talkMaxDuration = var_17_22

					if var_17_22 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_22 + var_17_15
					end
				end

				arg_14_1.text_.text = var_17_19
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082003", "story_v_out_417082.awb") ~= 0 then
					local var_17_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082003", "story_v_out_417082.awb") / 1000

					if var_17_23 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_23 + var_17_15
					end

					if var_17_18.prefab_name ~= "" and arg_14_1.actors_[var_17_18.prefab_name] ~= nil then
						local var_17_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_18.prefab_name].transform, "story_v_out_417082", "417082003", "story_v_out_417082.awb")

						arg_14_1:RecordAudio("417082003", var_17_24)
						arg_14_1:RecordAudio("417082003", var_17_24)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417082", "417082003", "story_v_out_417082.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417082", "417082003", "story_v_out_417082.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_25 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_15 <= arg_14_1.time_ and arg_14_1.time_ < var_17_15 + var_17_25 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_15) / var_17_25

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_15 + var_17_25 and arg_14_1.time_ < var_17_15 + var_17_25 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
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

		arg_14_1:InitPlayNodeList()
	end,
	Play417082004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417082004
		arg_18_1.duration_ = 3.9

		local var_18_0 = {
			zh = 1.6,
			ja = 3.9
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
				arg_18_0:Play417082005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.2

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[1109].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:GetWordFromCfg(417082004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082004", "story_v_out_417082.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082004", "story_v_out_417082.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_417082", "417082004", "story_v_out_417082.awb")

						arg_18_1:RecordAudio("417082004", var_21_9)
						arg_18_1:RecordAudio("417082004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417082", "417082004", "story_v_out_417082.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417082", "417082004", "story_v_out_417082.awb")
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
	Play417082005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417082005
		arg_22_1.duration_ = 9.87

		local var_22_0 = {
			zh = 5.766,
			ja = 9.866
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417082006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1034"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1034 == nil then
				arg_22_1.var_.actorSpriteComps1034 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps1034 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1034 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_25_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1034 = nil
			end

			local var_25_8 = 0
			local var_25_9 = 0.75

			if var_25_8 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_10 = arg_22_1:FormatText(StoryNameCfg[1110].name)

				arg_22_1.leftNameTxt_.text = var_25_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_11 = arg_22_1:GetWordFromCfg(417082005)
				local var_25_12 = arg_22_1:FormatText(var_25_11.content)

				arg_22_1.text_.text = var_25_12

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 30
				local var_25_14 = utf8.len(var_25_12)
				local var_25_15 = var_25_13 <= 0 and var_25_9 or var_25_9 * (var_25_14 / var_25_13)

				if var_25_15 > 0 and var_25_9 < var_25_15 then
					arg_22_1.talkMaxDuration = var_25_15

					if var_25_15 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_15 + var_25_8
					end
				end

				arg_22_1.text_.text = var_25_12
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082005", "story_v_out_417082.awb") ~= 0 then
					local var_25_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082005", "story_v_out_417082.awb") / 1000

					if var_25_16 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_16 + var_25_8
					end

					if var_25_11.prefab_name ~= "" and arg_22_1.actors_[var_25_11.prefab_name] ~= nil then
						local var_25_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_11.prefab_name].transform, "story_v_out_417082", "417082005", "story_v_out_417082.awb")

						arg_22_1:RecordAudio("417082005", var_25_17)
						arg_22_1:RecordAudio("417082005", var_25_17)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417082", "417082005", "story_v_out_417082.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417082", "417082005", "story_v_out_417082.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_18 = math.max(var_25_9, arg_22_1.talkMaxDuration)

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_18 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_8) / var_25_18

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_8 + var_25_18 and arg_22_1.time_ < var_25_8 + var_25_18 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417082006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417082006
		arg_26_1.duration_ = 9.8

		local var_26_0 = {
			zh = 5.066,
			ja = 9.8
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417082007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.675

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[1110].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:GetWordFromCfg(417082006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 27
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082006", "story_v_out_417082.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082006", "story_v_out_417082.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_417082", "417082006", "story_v_out_417082.awb")

						arg_26_1:RecordAudio("417082006", var_29_9)
						arg_26_1:RecordAudio("417082006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417082", "417082006", "story_v_out_417082.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417082", "417082006", "story_v_out_417082.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417082007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417082007
		arg_30_1.duration_ = 1.9

		local var_30_0 = {
			zh = 1.9,
			ja = 1.666
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
				arg_30_0:Play417082008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1034"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1034 == nil then
				arg_30_1.var_.actorSpriteComps1034 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps1034 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								local var_33_4 = Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor1.r, var_33_3)
								local var_33_5 = Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor1.g, var_33_3)
								local var_33_6 = Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor1.b, var_33_3)

								iter_33_1.color = Color.New(var_33_4, var_33_5, var_33_6)
							else
								local var_33_7 = Mathf.Lerp(iter_33_1.color.r, 1, var_33_3)

								iter_33_1.color = Color.New(var_33_7, var_33_7, var_33_7)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1034 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_33_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_8 = arg_30_1.actors_["1034"].transform
			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1.var_.moveOldPos1034 = var_33_8.localPosition
				var_33_8.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1034", 3)

				local var_33_10 = var_33_8.childCount

				for iter_33_4 = 0, var_33_10 - 1 do
					local var_33_11 = var_33_8:GetChild(iter_33_4)

					if var_33_11.name == "split_7" or not string.find(var_33_11.name, "split") then
						var_33_11.gameObject:SetActive(true)
					else
						var_33_11.gameObject:SetActive(false)
					end
				end
			end

			local var_33_12 = 0.001

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_12 then
				local var_33_13 = (arg_30_1.time_ - var_33_9) / var_33_12
				local var_33_14 = Vector3.New(0, -331.9, -324)

				var_33_8.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1034, var_33_14, var_33_13)
			end

			if arg_30_1.time_ >= var_33_9 + var_33_12 and arg_30_1.time_ < var_33_9 + var_33_12 + arg_33_0 then
				var_33_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_33_15 = 0
			local var_33_16 = 0.125

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_17 = arg_30_1:FormatText(StoryNameCfg[1109].name)

				arg_30_1.leftNameTxt_.text = var_33_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_18 = arg_30_1:GetWordFromCfg(417082007)
				local var_33_19 = arg_30_1:FormatText(var_33_18.content)

				arg_30_1.text_.text = var_33_19

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_20 = 5
				local var_33_21 = utf8.len(var_33_19)
				local var_33_22 = var_33_20 <= 0 and var_33_16 or var_33_16 * (var_33_21 / var_33_20)

				if var_33_22 > 0 and var_33_16 < var_33_22 then
					arg_30_1.talkMaxDuration = var_33_22

					if var_33_22 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_22 + var_33_15
					end
				end

				arg_30_1.text_.text = var_33_19
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082007", "story_v_out_417082.awb") ~= 0 then
					local var_33_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082007", "story_v_out_417082.awb") / 1000

					if var_33_23 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_15
					end

					if var_33_18.prefab_name ~= "" and arg_30_1.actors_[var_33_18.prefab_name] ~= nil then
						local var_33_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_18.prefab_name].transform, "story_v_out_417082", "417082007", "story_v_out_417082.awb")

						arg_30_1:RecordAudio("417082007", var_33_24)
						arg_30_1:RecordAudio("417082007", var_33_24)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417082", "417082007", "story_v_out_417082.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417082", "417082007", "story_v_out_417082.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_25 = math.max(var_33_16, arg_30_1.talkMaxDuration)

			if var_33_15 <= arg_30_1.time_ and arg_30_1.time_ < var_33_15 + var_33_25 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_15) / var_33_25

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_15 + var_33_25 and arg_30_1.time_ < var_33_15 + var_33_25 + arg_33_0 then
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
	Play417082008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417082008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417082009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1034"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1034 == nil then
				arg_34_1.var_.actorSpriteComps1034 = var_37_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.actorSpriteComps1034 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								local var_37_4 = Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor2.r, var_37_3)
								local var_37_5 = Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor2.g, var_37_3)
								local var_37_6 = Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor2.b, var_37_3)

								iter_37_1.color = Color.New(var_37_4, var_37_5, var_37_6)
							else
								local var_37_7 = Mathf.Lerp(iter_37_1.color.r, 0.5, var_37_3)

								iter_37_1.color = Color.New(var_37_7, var_37_7, var_37_7)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_37_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_8 = arg_34_1.actors_["1034"].transform
			local var_37_9 = 0

			if var_37_9 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 then
				arg_34_1.var_.moveOldPos1034 = var_37_8.localPosition
				var_37_8.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1034", 7)

				local var_37_10 = var_37_8.childCount

				for iter_37_4 = 0, var_37_10 - 1 do
					local var_37_11 = var_37_8:GetChild(iter_37_4)

					if var_37_11.name == "" or not string.find(var_37_11.name, "split") then
						var_37_11.gameObject:SetActive(true)
					else
						var_37_11.gameObject:SetActive(false)
					end
				end
			end

			local var_37_12 = 0.001

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_12 then
				local var_37_13 = (arg_34_1.time_ - var_37_9) / var_37_12
				local var_37_14 = Vector3.New(0, -2000, 0)

				var_37_8.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1034, var_37_14, var_37_13)
			end

			if arg_34_1.time_ >= var_37_9 + var_37_12 and arg_34_1.time_ < var_37_9 + var_37_12 + arg_37_0 then
				var_37_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_37_15 = 0.633333333333333
			local var_37_16 = 1

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				local var_37_17 = "play"
				local var_37_18 = "effect"

				arg_34_1:AudioAction(var_37_17, var_37_18, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_37_19 = 0
			local var_37_20 = 1.15

			if var_37_19 < arg_34_1.time_ and arg_34_1.time_ <= var_37_19 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_21 = arg_34_1:GetWordFromCfg(417082008)
				local var_37_22 = arg_34_1:FormatText(var_37_21.content)

				arg_34_1.text_.text = var_37_22

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_23 = 46
				local var_37_24 = utf8.len(var_37_22)
				local var_37_25 = var_37_23 <= 0 and var_37_20 or var_37_20 * (var_37_24 / var_37_23)

				if var_37_25 > 0 and var_37_20 < var_37_25 then
					arg_34_1.talkMaxDuration = var_37_25

					if var_37_25 + var_37_19 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_25 + var_37_19
					end
				end

				arg_34_1.text_.text = var_37_22
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_26 = math.max(var_37_20, arg_34_1.talkMaxDuration)

			if var_37_19 <= arg_34_1.time_ and arg_34_1.time_ < var_37_19 + var_37_26 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_19) / var_37_26

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_19 + var_37_26 and arg_34_1.time_ < var_37_19 + var_37_26 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play417082009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417082009
		arg_38_1.duration_ = 5.43

		local var_38_0 = {
			zh = 3.666,
			ja = 5.433
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
				arg_38_0:Play417082010(arg_38_1)
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

			local var_41_8 = arg_38_1.actors_["1034"].transform
			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 then
				arg_38_1.var_.moveOldPos1034 = var_41_8.localPosition
				var_41_8.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1034", 3)

				local var_41_10 = var_41_8.childCount

				for iter_41_4 = 0, var_41_10 - 1 do
					local var_41_11 = var_41_8:GetChild(iter_41_4)

					if var_41_11.name == "" or not string.find(var_41_11.name, "split") then
						var_41_11.gameObject:SetActive(true)
					else
						var_41_11.gameObject:SetActive(false)
					end
				end
			end

			local var_41_12 = 0.001

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_12 then
				local var_41_13 = (arg_38_1.time_ - var_41_9) / var_41_12
				local var_41_14 = Vector3.New(0, -331.9, -324)

				var_41_8.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1034, var_41_14, var_41_13)
			end

			if arg_38_1.time_ >= var_41_9 + var_41_12 and arg_38_1.time_ < var_41_9 + var_41_12 + arg_41_0 then
				var_41_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_41_15 = 0
			local var_41_16 = 0.5

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_17 = arg_38_1:FormatText(StoryNameCfg[1109].name)

				arg_38_1.leftNameTxt_.text = var_41_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_18 = arg_38_1:GetWordFromCfg(417082009)
				local var_41_19 = arg_38_1:FormatText(var_41_18.content)

				arg_38_1.text_.text = var_41_19

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_20 = 20
				local var_41_21 = utf8.len(var_41_19)
				local var_41_22 = var_41_20 <= 0 and var_41_16 or var_41_16 * (var_41_21 / var_41_20)

				if var_41_22 > 0 and var_41_16 < var_41_22 then
					arg_38_1.talkMaxDuration = var_41_22

					if var_41_22 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_22 + var_41_15
					end
				end

				arg_38_1.text_.text = var_41_19
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082009", "story_v_out_417082.awb") ~= 0 then
					local var_41_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082009", "story_v_out_417082.awb") / 1000

					if var_41_23 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_23 + var_41_15
					end

					if var_41_18.prefab_name ~= "" and arg_38_1.actors_[var_41_18.prefab_name] ~= nil then
						local var_41_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_18.prefab_name].transform, "story_v_out_417082", "417082009", "story_v_out_417082.awb")

						arg_38_1:RecordAudio("417082009", var_41_24)
						arg_38_1:RecordAudio("417082009", var_41_24)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417082", "417082009", "story_v_out_417082.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417082", "417082009", "story_v_out_417082.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_25 = math.max(var_41_16, arg_38_1.talkMaxDuration)

			if var_41_15 <= arg_38_1.time_ and arg_38_1.time_ < var_41_15 + var_41_25 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_15) / var_41_25

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_15 + var_41_25 and arg_38_1.time_ < var_41_15 + var_41_25 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
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

		arg_38_1:InitPlayNodeList()
	end,
	Play417082010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417082010
		arg_42_1.duration_ = 3.7

		local var_42_0 = {
			zh = 2.466,
			ja = 3.7
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
				arg_42_0:Play417082011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1034"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos1034 = var_45_0.localPosition
				var_45_0.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1034", 3)

				local var_45_2 = var_45_0.childCount

				for iter_45_0 = 0, var_45_2 - 1 do
					local var_45_3 = var_45_0:GetChild(iter_45_0)

					if var_45_3.name == "" or not string.find(var_45_3.name, "split") then
						var_45_3.gameObject:SetActive(true)
					else
						var_45_3.gameObject:SetActive(false)
					end
				end
			end

			local var_45_4 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_4 then
				local var_45_5 = (arg_42_1.time_ - var_45_1) / var_45_4
				local var_45_6 = Vector3.New(0, -331.9, -324)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1034, var_45_6, var_45_5)
			end

			if arg_42_1.time_ >= var_45_1 + var_45_4 and arg_42_1.time_ < var_45_1 + var_45_4 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_45_7 = 0
			local var_45_8 = 0.325

			if var_45_7 < arg_42_1.time_ and arg_42_1.time_ <= var_45_7 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_9 = arg_42_1:FormatText(StoryNameCfg[1109].name)

				arg_42_1.leftNameTxt_.text = var_45_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_10 = arg_42_1:GetWordFromCfg(417082010)
				local var_45_11 = arg_42_1:FormatText(var_45_10.content)

				arg_42_1.text_.text = var_45_11

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_12 = 13
				local var_45_13 = utf8.len(var_45_11)
				local var_45_14 = var_45_12 <= 0 and var_45_8 or var_45_8 * (var_45_13 / var_45_12)

				if var_45_14 > 0 and var_45_8 < var_45_14 then
					arg_42_1.talkMaxDuration = var_45_14

					if var_45_14 + var_45_7 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_7
					end
				end

				arg_42_1.text_.text = var_45_11
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082010", "story_v_out_417082.awb") ~= 0 then
					local var_45_15 = manager.audio:GetVoiceLength("story_v_out_417082", "417082010", "story_v_out_417082.awb") / 1000

					if var_45_15 + var_45_7 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_7
					end

					if var_45_10.prefab_name ~= "" and arg_42_1.actors_[var_45_10.prefab_name] ~= nil then
						local var_45_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_10.prefab_name].transform, "story_v_out_417082", "417082010", "story_v_out_417082.awb")

						arg_42_1:RecordAudio("417082010", var_45_16)
						arg_42_1:RecordAudio("417082010", var_45_16)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417082", "417082010", "story_v_out_417082.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417082", "417082010", "story_v_out_417082.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_17 = math.max(var_45_8, arg_42_1.talkMaxDuration)

			if var_45_7 <= arg_42_1.time_ and arg_42_1.time_ < var_45_7 + var_45_17 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_7) / var_45_17

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_7 + var_45_17 and arg_42_1.time_ < var_45_7 + var_45_17 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play417082011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417082011
		arg_46_1.duration_ = 3.03

		local var_46_0 = {
			zh = 1.633,
			ja = 3.033
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
				arg_46_0:Play417082012(arg_46_1)
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
								local var_49_4 = Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor2.r, var_49_3)
								local var_49_5 = Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor2.g, var_49_3)
								local var_49_6 = Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor2.b, var_49_3)

								iter_49_1.color = Color.New(var_49_4, var_49_5, var_49_6)
							else
								local var_49_7 = Mathf.Lerp(iter_49_1.color.r, 0.5, var_49_3)

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
							iter_49_3.color = arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_49_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_8 = 0
			local var_49_9 = 0.225

			if var_49_8 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_10 = arg_46_1:FormatText(StoryNameCfg[1110].name)

				arg_46_1.leftNameTxt_.text = var_49_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_11 = arg_46_1:GetWordFromCfg(417082011)
				local var_49_12 = arg_46_1:FormatText(var_49_11.content)

				arg_46_1.text_.text = var_49_12

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_13 = 9
				local var_49_14 = utf8.len(var_49_12)
				local var_49_15 = var_49_13 <= 0 and var_49_9 or var_49_9 * (var_49_14 / var_49_13)

				if var_49_15 > 0 and var_49_9 < var_49_15 then
					arg_46_1.talkMaxDuration = var_49_15

					if var_49_15 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_15 + var_49_8
					end
				end

				arg_46_1.text_.text = var_49_12
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082011", "story_v_out_417082.awb") ~= 0 then
					local var_49_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082011", "story_v_out_417082.awb") / 1000

					if var_49_16 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_16 + var_49_8
					end

					if var_49_11.prefab_name ~= "" and arg_46_1.actors_[var_49_11.prefab_name] ~= nil then
						local var_49_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_11.prefab_name].transform, "story_v_out_417082", "417082011", "story_v_out_417082.awb")

						arg_46_1:RecordAudio("417082011", var_49_17)
						arg_46_1:RecordAudio("417082011", var_49_17)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417082", "417082011", "story_v_out_417082.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417082", "417082011", "story_v_out_417082.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_18 = math.max(var_49_9, arg_46_1.talkMaxDuration)

			if var_49_8 <= arg_46_1.time_ and arg_46_1.time_ < var_49_8 + var_49_18 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_8) / var_49_18

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_8 + var_49_18 and arg_46_1.time_ < var_49_8 + var_49_18 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417082012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417082012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417082013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1034"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = var_53_0.localPosition
				var_53_0.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 7)

				local var_53_2 = var_53_0.childCount

				for iter_53_0 = 0, var_53_2 - 1 do
					local var_53_3 = var_53_0:GetChild(iter_53_0)

					if var_53_3.name == "" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_4 then
				local var_53_5 = (arg_50_1.time_ - var_53_1) / var_53_4
				local var_53_6 = Vector3.New(0, -2000, 0)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, var_53_6, var_53_5)
			end

			if arg_50_1.time_ >= var_53_1 + var_53_4 and arg_50_1.time_ < var_53_1 + var_53_4 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_53_7 = 0.266666666666667
			local var_53_8 = 1

			if var_53_7 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				local var_53_9 = "play"
				local var_53_10 = "effect"

				arg_50_1:AudioAction(var_53_9, var_53_10, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_53_11 = 0
			local var_53_12 = 1.1

			if var_53_11 < arg_50_1.time_ and arg_50_1.time_ <= var_53_11 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_13 = arg_50_1:GetWordFromCfg(417082012)
				local var_53_14 = arg_50_1:FormatText(var_53_13.content)

				arg_50_1.text_.text = var_53_14

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_15 = 44
				local var_53_16 = utf8.len(var_53_14)
				local var_53_17 = var_53_15 <= 0 and var_53_12 or var_53_12 * (var_53_16 / var_53_15)

				if var_53_17 > 0 and var_53_12 < var_53_17 then
					arg_50_1.talkMaxDuration = var_53_17

					if var_53_17 + var_53_11 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_17 + var_53_11
					end
				end

				arg_50_1.text_.text = var_53_14
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_18 = math.max(var_53_12, arg_50_1.talkMaxDuration)

			if var_53_11 <= arg_50_1.time_ and arg_50_1.time_ < var_53_11 + var_53_18 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_11) / var_53_18

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_11 + var_53_18 and arg_50_1.time_ < var_53_11 + var_53_18 + arg_53_0 then
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
	Play417082013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417082013
		arg_54_1.duration_ = 5.53

		local var_54_0 = {
			zh = 3.633,
			ja = 5.533
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
				arg_54_0:Play417082014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1034"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1034 == nil then
				arg_54_1.var_.actorSpriteComps1034 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps1034 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1034 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_8 = 0
			local var_57_9 = 0.425

			if var_57_8 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_10 = arg_54_1:FormatText(StoryNameCfg[1109].name)

				arg_54_1.leftNameTxt_.text = var_57_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_11 = arg_54_1:GetWordFromCfg(417082013)
				local var_57_12 = arg_54_1:FormatText(var_57_11.content)

				arg_54_1.text_.text = var_57_12

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_13 = 17
				local var_57_14 = utf8.len(var_57_12)
				local var_57_15 = var_57_13 <= 0 and var_57_9 or var_57_9 * (var_57_14 / var_57_13)

				if var_57_15 > 0 and var_57_9 < var_57_15 then
					arg_54_1.talkMaxDuration = var_57_15

					if var_57_15 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_8
					end
				end

				arg_54_1.text_.text = var_57_12
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082013", "story_v_out_417082.awb") ~= 0 then
					local var_57_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082013", "story_v_out_417082.awb") / 1000

					if var_57_16 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_16 + var_57_8
					end

					if var_57_11.prefab_name ~= "" and arg_54_1.actors_[var_57_11.prefab_name] ~= nil then
						local var_57_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_11.prefab_name].transform, "story_v_out_417082", "417082013", "story_v_out_417082.awb")

						arg_54_1:RecordAudio("417082013", var_57_17)
						arg_54_1:RecordAudio("417082013", var_57_17)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417082", "417082013", "story_v_out_417082.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417082", "417082013", "story_v_out_417082.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_18 = math.max(var_57_9, arg_54_1.talkMaxDuration)

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_18 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_8) / var_57_18

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_8 + var_57_18 and arg_54_1.time_ < var_57_8 + var_57_18 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417082014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417082014
		arg_58_1.duration_ = 4.3

		local var_58_0 = {
			zh = 4.3,
			ja = 4.1
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
				arg_58_0:Play417082015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "STblack"

			if arg_58_1.bgs_[var_61_0] == nil then
				local var_61_1 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_61_0)
				var_61_1.name = var_61_0
				var_61_1.transform.parent = arg_58_1.stage_.transform
				var_61_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_[var_61_0] = var_61_1
			end

			local var_61_2 = 1.16666666666667

			if var_61_2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				local var_61_3 = manager.ui.mainCamera.transform.localPosition
				local var_61_4 = Vector3.New(0, 0, 10) + Vector3.New(var_61_3.x, var_61_3.y, 0)
				local var_61_5 = arg_58_1.bgs_.STblack

				var_61_5.transform.localPosition = var_61_4
				var_61_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_6 = var_61_5:GetComponent("SpriteRenderer")

				if var_61_6 and var_61_6.sprite then
					local var_61_7 = (var_61_5.transform.localPosition - var_61_3).z
					local var_61_8 = manager.ui.mainCameraCom_
					local var_61_9 = 2 * var_61_7 * Mathf.Tan(var_61_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_61_10 = var_61_9 * var_61_8.aspect
					local var_61_11 = var_61_6.sprite.bounds.size.x
					local var_61_12 = var_61_6.sprite.bounds.size.y
					local var_61_13 = var_61_10 / var_61_11
					local var_61_14 = var_61_9 / var_61_12
					local var_61_15 = var_61_14 < var_61_13 and var_61_13 or var_61_14

					var_61_5.transform.localScale = Vector3.New(var_61_15, var_61_15, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "STblack" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_16 = 1.16666666666667

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			local var_61_17 = 0.3

			if arg_58_1.time_ >= var_61_16 + var_61_17 and arg_58_1.time_ < var_61_16 + var_61_17 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			local var_61_18 = 0

			if var_61_18 < arg_58_1.time_ and arg_58_1.time_ <= var_61_18 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_19 = 1.16666666666667

			if var_61_18 <= arg_58_1.time_ and arg_58_1.time_ < var_61_18 + var_61_19 then
				local var_61_20 = (arg_58_1.time_ - var_61_18) / var_61_19
				local var_61_21 = Color.New(0, 0, 0)

				var_61_21.a = Mathf.Lerp(0, 1, var_61_20)
				arg_58_1.mask_.color = var_61_21
			end

			if arg_58_1.time_ >= var_61_18 + var_61_19 and arg_58_1.time_ < var_61_18 + var_61_19 + arg_61_0 then
				local var_61_22 = Color.New(0, 0, 0)

				var_61_22.a = 1
				arg_58_1.mask_.color = var_61_22
			end

			local var_61_23 = 1.16666666666667

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_24 = 1.725

			if var_61_23 <= arg_58_1.time_ and arg_58_1.time_ < var_61_23 + var_61_24 then
				local var_61_25 = (arg_58_1.time_ - var_61_23) / var_61_24
				local var_61_26 = Color.New(0, 0, 0)

				var_61_26.a = Mathf.Lerp(1, 0, var_61_25)
				arg_58_1.mask_.color = var_61_26
			end

			if arg_58_1.time_ >= var_61_23 + var_61_24 and arg_58_1.time_ < var_61_23 + var_61_24 + arg_61_0 then
				local var_61_27 = Color.New(0, 0, 0)
				local var_61_28 = 0

				arg_58_1.mask_.enabled = false
				var_61_27.a = var_61_28
				arg_58_1.mask_.color = var_61_27
			end

			local var_61_29 = arg_58_1.actors_["1034"]
			local var_61_30 = 1.16666666666667

			if var_61_30 < arg_58_1.time_ and arg_58_1.time_ <= var_61_30 + arg_61_0 and not isNil(var_61_29) and arg_58_1.var_.actorSpriteComps1034 == nil then
				arg_58_1.var_.actorSpriteComps1034 = var_61_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_31 = 0.2

			if var_61_30 <= arg_58_1.time_ and arg_58_1.time_ < var_61_30 + var_61_31 and not isNil(var_61_29) then
				local var_61_32 = (arg_58_1.time_ - var_61_30) / var_61_31

				if arg_58_1.var_.actorSpriteComps1034 then
					for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_61_3 then
							if arg_58_1.isInRecall_ then
								local var_61_33 = Mathf.Lerp(iter_61_3.color.r, arg_58_1.hightColor2.r, var_61_32)
								local var_61_34 = Mathf.Lerp(iter_61_3.color.g, arg_58_1.hightColor2.g, var_61_32)
								local var_61_35 = Mathf.Lerp(iter_61_3.color.b, arg_58_1.hightColor2.b, var_61_32)

								iter_61_3.color = Color.New(var_61_33, var_61_34, var_61_35)
							else
								local var_61_36 = Mathf.Lerp(iter_61_3.color.r, 0.5, var_61_32)

								iter_61_3.color = Color.New(var_61_36, var_61_36, var_61_36)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_30 + var_61_31 and arg_58_1.time_ < var_61_30 + var_61_31 + arg_61_0 and not isNil(var_61_29) and arg_58_1.var_.actorSpriteComps1034 then
				for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_61_5 then
						if arg_58_1.isInRecall_ then
							iter_61_5.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1034 = nil
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_37 = 2.4
			local var_61_38 = 0.225

			if var_61_37 < arg_58_1.time_ and arg_58_1.time_ <= var_61_37 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_39 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_39:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_40 = arg_58_1:FormatText(StoryNameCfg[1133].name)

				arg_58_1.leftNameTxt_.text = var_61_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_41 = arg_58_1:GetWordFromCfg(417082014)
				local var_61_42 = arg_58_1:FormatText(var_61_41.content)

				arg_58_1.text_.text = var_61_42

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_43 = 9
				local var_61_44 = utf8.len(var_61_42)
				local var_61_45 = var_61_43 <= 0 and var_61_38 or var_61_38 * (var_61_44 / var_61_43)

				if var_61_45 > 0 and var_61_38 < var_61_45 then
					arg_58_1.talkMaxDuration = var_61_45
					var_61_37 = var_61_37 + 0.3

					if var_61_45 + var_61_37 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_45 + var_61_37
					end
				end

				arg_58_1.text_.text = var_61_42
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082014", "story_v_out_417082.awb") ~= 0 then
					local var_61_46 = manager.audio:GetVoiceLength("story_v_out_417082", "417082014", "story_v_out_417082.awb") / 1000

					if var_61_46 + var_61_37 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_46 + var_61_37
					end

					if var_61_41.prefab_name ~= "" and arg_58_1.actors_[var_61_41.prefab_name] ~= nil then
						local var_61_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_41.prefab_name].transform, "story_v_out_417082", "417082014", "story_v_out_417082.awb")

						arg_58_1:RecordAudio("417082014", var_61_47)
						arg_58_1:RecordAudio("417082014", var_61_47)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417082", "417082014", "story_v_out_417082.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417082", "417082014", "story_v_out_417082.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_48 = var_61_37 + 0.3
			local var_61_49 = math.max(var_61_38, arg_58_1.talkMaxDuration)

			if var_61_48 <= arg_58_1.time_ and arg_58_1.time_ < var_61_48 + var_61_49 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_48) / var_61_49

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_48 + var_61_49 and arg_58_1.time_ < var_61_48 + var_61_49 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417082015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417082015
		arg_64_1.duration_ = 1.01

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play417082016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.01
			local var_67_1 = 1

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				local var_67_2 = "play"
				local var_67_3 = "effect"

				arg_64_1:AudioAction(var_67_2, var_67_3, "se_story_1310", "se_story_1310_gun03", "")
			end

			local var_67_4 = 0
			local var_67_5 = 0.05

			if var_67_4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_6 = arg_64_1:FormatText(StoryNameCfg[1133].name)

				arg_64_1.leftNameTxt_.text = var_67_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_7 = arg_64_1:GetWordFromCfg(417082015)
				local var_67_8 = arg_64_1:FormatText(var_67_7.content)

				arg_64_1.text_.text = var_67_8

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 2
				local var_67_10 = utf8.len(var_67_8)
				local var_67_11 = var_67_9 <= 0 and var_67_5 or var_67_5 * (var_67_10 / var_67_9)

				if var_67_11 > 0 and var_67_5 < var_67_11 then
					arg_64_1.talkMaxDuration = var_67_11

					if var_67_11 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_8
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082015", "story_v_out_417082.awb") ~= 0 then
					local var_67_12 = manager.audio:GetVoiceLength("story_v_out_417082", "417082015", "story_v_out_417082.awb") / 1000

					if var_67_12 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_4
					end

					if var_67_7.prefab_name ~= "" and arg_64_1.actors_[var_67_7.prefab_name] ~= nil then
						local var_67_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_7.prefab_name].transform, "story_v_out_417082", "417082015", "story_v_out_417082.awb")

						arg_64_1:RecordAudio("417082015", var_67_13)
						arg_64_1:RecordAudio("417082015", var_67_13)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_417082", "417082015", "story_v_out_417082.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_417082", "417082015", "story_v_out_417082.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_14 and arg_64_1.time_ < var_67_4 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play417082016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417082016
		arg_68_1.duration_ = 9

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play417082017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.999999999999

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				local var_71_1 = manager.ui.mainCamera.transform.localPosition
				local var_71_2 = Vector3.New(0, 0, 10) + Vector3.New(var_71_1.x, var_71_1.y, 0)
				local var_71_3 = arg_68_1.bgs_.D06a

				var_71_3.transform.localPosition = var_71_2
				var_71_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_71_4 = var_71_3:GetComponent("SpriteRenderer")

				if var_71_4 and var_71_4.sprite then
					local var_71_5 = (var_71_3.transform.localPosition - var_71_1).z
					local var_71_6 = manager.ui.mainCameraCom_
					local var_71_7 = 2 * var_71_5 * Mathf.Tan(var_71_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_71_8 = var_71_7 * var_71_6.aspect
					local var_71_9 = var_71_4.sprite.bounds.size.x
					local var_71_10 = var_71_4.sprite.bounds.size.y
					local var_71_11 = var_71_8 / var_71_9
					local var_71_12 = var_71_7 / var_71_10
					local var_71_13 = var_71_12 < var_71_11 and var_71_11 or var_71_12

					var_71_3.transform.localScale = Vector3.New(var_71_13, var_71_13, 0)
				end

				for iter_71_0, iter_71_1 in pairs(arg_68_1.bgs_) do
					if iter_71_0 ~= "D06a" then
						iter_71_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_71_14 = 1.999999999999

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			local var_71_15 = 0.3

			if arg_68_1.time_ >= var_71_14 + var_71_15 and arg_68_1.time_ < var_71_14 + var_71_15 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_17 = 2

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_17 then
				local var_71_18 = (arg_68_1.time_ - var_71_16) / var_71_17
				local var_71_19 = Color.New(0, 0, 0)

				var_71_19.a = Mathf.Lerp(0, 1, var_71_18)
				arg_68_1.mask_.color = var_71_19
			end

			if arg_68_1.time_ >= var_71_16 + var_71_17 and arg_68_1.time_ < var_71_16 + var_71_17 + arg_71_0 then
				local var_71_20 = Color.New(0, 0, 0)

				var_71_20.a = 1
				arg_68_1.mask_.color = var_71_20
			end

			local var_71_21 = 1.999999999999

			if var_71_21 < arg_68_1.time_ and arg_68_1.time_ <= var_71_21 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_22 = 2.36666666666767

			if var_71_21 <= arg_68_1.time_ and arg_68_1.time_ < var_71_21 + var_71_22 then
				local var_71_23 = (arg_68_1.time_ - var_71_21) / var_71_22
				local var_71_24 = Color.New(0, 0, 0)

				var_71_24.a = Mathf.Lerp(1, 0, var_71_23)
				arg_68_1.mask_.color = var_71_24
			end

			if arg_68_1.time_ >= var_71_21 + var_71_22 and arg_68_1.time_ < var_71_21 + var_71_22 + arg_71_0 then
				local var_71_25 = Color.New(0, 0, 0)
				local var_71_26 = 0

				arg_68_1.mask_.enabled = false
				var_71_25.a = var_71_26
				arg_68_1.mask_.color = var_71_25
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_27 = 3.999999999999
			local var_71_28 = 1.425

			if var_71_27 < arg_68_1.time_ and arg_68_1.time_ <= var_71_27 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_29 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_29:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_30 = arg_68_1:GetWordFromCfg(417082016)
				local var_71_31 = arg_68_1:FormatText(var_71_30.content)

				arg_68_1.text_.text = var_71_31

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_32 = 57
				local var_71_33 = utf8.len(var_71_31)
				local var_71_34 = var_71_32 <= 0 and var_71_28 or var_71_28 * (var_71_33 / var_71_32)

				if var_71_34 > 0 and var_71_28 < var_71_34 then
					arg_68_1.talkMaxDuration = var_71_34
					var_71_27 = var_71_27 + 0.3

					if var_71_34 + var_71_27 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_34 + var_71_27
					end
				end

				arg_68_1.text_.text = var_71_31
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_35 = var_71_27 + 0.3
			local var_71_36 = math.max(var_71_28, arg_68_1.talkMaxDuration)

			if var_71_35 <= arg_68_1.time_ and arg_68_1.time_ < var_71_35 + var_71_36 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_35) / var_71_36

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_35 + var_71_36 and arg_68_1.time_ < var_71_35 + var_71_36 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play417082017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417082017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417082018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.725

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

				local var_77_2 = arg_74_1:GetWordFromCfg(417082017)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 29
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
	Play417082018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417082018
		arg_78_1.duration_ = 3.03

		local var_78_0 = {
			zh = 2.233,
			ja = 3.033
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
				arg_78_0:Play417082019(arg_78_1)
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
			local var_81_16 = 0.275

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

				local var_81_18 = arg_78_1:GetWordFromCfg(417082018)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082018", "story_v_out_417082.awb") ~= 0 then
					local var_81_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082018", "story_v_out_417082.awb") / 1000

					if var_81_23 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_15
					end

					if var_81_18.prefab_name ~= "" and arg_78_1.actors_[var_81_18.prefab_name] ~= nil then
						local var_81_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_18.prefab_name].transform, "story_v_out_417082", "417082018", "story_v_out_417082.awb")

						arg_78_1:RecordAudio("417082018", var_81_24)
						arg_78_1:RecordAudio("417082018", var_81_24)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417082", "417082018", "story_v_out_417082.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417082", "417082018", "story_v_out_417082.awb")
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
	Play417082019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417082019
		arg_82_1.duration_ = 3.23

		local var_82_0 = {
			zh = 2.3,
			ja = 3.233
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
				arg_82_0:Play417082020(arg_82_1)
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

				local var_85_10 = arg_82_1:FormatText(StoryNameCfg[1133].name)

				arg_82_1.leftNameTxt_.text = var_85_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_11 = arg_82_1:GetWordFromCfg(417082019)
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082019", "story_v_out_417082.awb") ~= 0 then
					local var_85_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082019", "story_v_out_417082.awb") / 1000

					if var_85_16 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_16 + var_85_8
					end

					if var_85_11.prefab_name ~= "" and arg_82_1.actors_[var_85_11.prefab_name] ~= nil then
						local var_85_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_11.prefab_name].transform, "story_v_out_417082", "417082019", "story_v_out_417082.awb")

						arg_82_1:RecordAudio("417082019", var_85_17)
						arg_82_1:RecordAudio("417082019", var_85_17)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417082", "417082019", "story_v_out_417082.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417082", "417082019", "story_v_out_417082.awb")
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
	Play417082020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417082020
		arg_86_1.duration_ = 10.57

		local var_86_0 = {
			zh = 9.7,
			ja = 10.566
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
				arg_86_0:Play417082021(arg_86_1)
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
			local var_89_9 = 1.05

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

				local var_89_11 = arg_86_1:GetWordFromCfg(417082020)
				local var_89_12 = arg_86_1:FormatText(var_89_11.content)

				arg_86_1.text_.text = var_89_12

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082020", "story_v_out_417082.awb") ~= 0 then
					local var_89_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082020", "story_v_out_417082.awb") / 1000

					if var_89_16 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_8
					end

					if var_89_11.prefab_name ~= "" and arg_86_1.actors_[var_89_11.prefab_name] ~= nil then
						local var_89_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_11.prefab_name].transform, "story_v_out_417082", "417082020", "story_v_out_417082.awb")

						arg_86_1:RecordAudio("417082020", var_89_17)
						arg_86_1:RecordAudio("417082020", var_89_17)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417082", "417082020", "story_v_out_417082.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417082", "417082020", "story_v_out_417082.awb")
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
	Play417082021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417082021
		arg_90_1.duration_ = 6.67

		local var_90_0 = {
			zh = 3.766,
			ja = 6.666
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
				arg_90_0:Play417082022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1034"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1034 == nil then
				arg_90_1.var_.actorSpriteComps1034 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps1034 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor2.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor2.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor2.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 0.5, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1034 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1034 = nil
			end

			local var_93_8 = 0
			local var_93_9 = 0.475

			if var_93_8 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_10 = arg_90_1:FormatText(StoryNameCfg[1133].name)

				arg_90_1.leftNameTxt_.text = var_93_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_11 = arg_90_1:GetWordFromCfg(417082021)
				local var_93_12 = arg_90_1:FormatText(var_93_11.content)

				arg_90_1.text_.text = var_93_12

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 19
				local var_93_14 = utf8.len(var_93_12)
				local var_93_15 = var_93_13 <= 0 and var_93_9 or var_93_9 * (var_93_14 / var_93_13)

				if var_93_15 > 0 and var_93_9 < var_93_15 then
					arg_90_1.talkMaxDuration = var_93_15

					if var_93_15 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_15 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_12
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082021", "story_v_out_417082.awb") ~= 0 then
					local var_93_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082021", "story_v_out_417082.awb") / 1000

					if var_93_16 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_16 + var_93_8
					end

					if var_93_11.prefab_name ~= "" and arg_90_1.actors_[var_93_11.prefab_name] ~= nil then
						local var_93_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_11.prefab_name].transform, "story_v_out_417082", "417082021", "story_v_out_417082.awb")

						arg_90_1:RecordAudio("417082021", var_93_17)
						arg_90_1:RecordAudio("417082021", var_93_17)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417082", "417082021", "story_v_out_417082.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417082", "417082021", "story_v_out_417082.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_18 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_18 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_18

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_18 and arg_90_1.time_ < var_93_8 + var_93_18 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417082022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417082022
		arg_94_1.duration_ = 4.8

		local var_94_0 = {
			zh = 4.8,
			ja = 2.6
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play417082023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.525

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[1133].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_3 = arg_94_1:GetWordFromCfg(417082022)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 21
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082022", "story_v_out_417082.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082022", "story_v_out_417082.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_417082", "417082022", "story_v_out_417082.awb")

						arg_94_1:RecordAudio("417082022", var_97_9)
						arg_94_1:RecordAudio("417082022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417082", "417082022", "story_v_out_417082.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417082", "417082022", "story_v_out_417082.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417082023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417082023
		arg_98_1.duration_ = 5.5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play417082024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1034"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos1034 = var_101_0.localPosition
				var_101_0.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("1034", 7)

				local var_101_2 = var_101_0.childCount

				for iter_101_0 = 0, var_101_2 - 1 do
					local var_101_3 = var_101_0:GetChild(iter_101_0)

					if var_101_3.name == "" or not string.find(var_101_3.name, "split") then
						var_101_3.gameObject:SetActive(true)
					else
						var_101_3.gameObject:SetActive(false)
					end
				end
			end

			local var_101_4 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_4 then
				local var_101_5 = (arg_98_1.time_ - var_101_1) / var_101_4
				local var_101_6 = Vector3.New(0, -2000, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1034, var_101_6, var_101_5)
			end

			if arg_98_1.time_ >= var_101_1 + var_101_4 and arg_98_1.time_ < var_101_1 + var_101_4 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_101_7 = 1
			local var_101_8 = 1

			if var_101_7 < arg_98_1.time_ and arg_98_1.time_ <= var_101_7 + arg_101_0 then
				local var_101_9 = "play"
				local var_101_10 = "effect"

				arg_98_1:AudioAction(var_101_9, var_101_10, "se_story_1310", "se_story_1310_gun03", "")
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_11 = 0.5
			local var_101_12 = 0.6

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_13 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_13:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_14 = arg_98_1:GetWordFromCfg(417082023)
				local var_101_15 = arg_98_1:FormatText(var_101_14.content)

				arg_98_1.text_.text = var_101_15

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_16 = 24
				local var_101_17 = utf8.len(var_101_15)
				local var_101_18 = var_101_16 <= 0 and var_101_12 or var_101_12 * (var_101_17 / var_101_16)

				if var_101_18 > 0 and var_101_12 < var_101_18 then
					arg_98_1.talkMaxDuration = var_101_18
					var_101_11 = var_101_11 + 0.3

					if var_101_18 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_11
					end
				end

				arg_98_1.text_.text = var_101_15
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_19 = var_101_11 + 0.3
			local var_101_20 = math.max(var_101_12, arg_98_1.talkMaxDuration)

			if var_101_19 <= arg_98_1.time_ and arg_98_1.time_ < var_101_19 + var_101_20 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_19) / var_101_20

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_19 + var_101_20 and arg_98_1.time_ < var_101_19 + var_101_20 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play417082024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417082024
		arg_104_1.duration_ = 1.27

		local var_104_0 = {
			zh = 1.266,
			ja = 1.133
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
				arg_104_0:Play417082025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.1

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[1133].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(417082024)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082024", "story_v_out_417082.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082024", "story_v_out_417082.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_417082", "417082024", "story_v_out_417082.awb")

						arg_104_1:RecordAudio("417082024", var_107_9)
						arg_104_1:RecordAudio("417082024", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417082", "417082024", "story_v_out_417082.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417082", "417082024", "story_v_out_417082.awb")
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
	Play417082025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417082025
		arg_108_1.duration_ = 3.8

		local var_108_0 = {
			zh = 1.866,
			ja = 3.8
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
				arg_108_0:Play417082026(arg_108_1)
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

			local var_111_8 = arg_108_1.actors_["1034"].transform
			local var_111_9 = 0

			if var_111_9 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 then
				arg_108_1.var_.moveOldPos1034 = var_111_8.localPosition
				var_111_8.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1034", 3)

				local var_111_10 = var_111_8.childCount

				for iter_111_4 = 0, var_111_10 - 1 do
					local var_111_11 = var_111_8:GetChild(iter_111_4)

					if var_111_11.name == "split_6" or not string.find(var_111_11.name, "split") then
						var_111_11.gameObject:SetActive(true)
					else
						var_111_11.gameObject:SetActive(false)
					end
				end
			end

			local var_111_12 = 0.001

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_12 then
				local var_111_13 = (arg_108_1.time_ - var_111_9) / var_111_12
				local var_111_14 = Vector3.New(0, -331.9, -324)

				var_111_8.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1034, var_111_14, var_111_13)
			end

			if arg_108_1.time_ >= var_111_9 + var_111_12 and arg_108_1.time_ < var_111_9 + var_111_12 + arg_111_0 then
				var_111_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_111_15 = 0
			local var_111_16 = 0.15

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[1109].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(417082025)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082025", "story_v_out_417082.awb") ~= 0 then
					local var_111_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082025", "story_v_out_417082.awb") / 1000

					if var_111_23 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_15
					end

					if var_111_18.prefab_name ~= "" and arg_108_1.actors_[var_111_18.prefab_name] ~= nil then
						local var_111_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_18.prefab_name].transform, "story_v_out_417082", "417082025", "story_v_out_417082.awb")

						arg_108_1:RecordAudio("417082025", var_111_24)
						arg_108_1:RecordAudio("417082025", var_111_24)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417082", "417082025", "story_v_out_417082.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417082", "417082025", "story_v_out_417082.awb")
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
				actorName = "1034",
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
	Play417082026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417082026
		arg_112_1.duration_ = 2.8

		local var_112_0 = {
			zh = 1.6,
			ja = 2.8
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
				arg_112_0:Play417082027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1034"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1034 == nil then
				arg_112_1.var_.actorSpriteComps1034 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1034 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1034 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1034 = nil
			end

			local var_115_8 = 0
			local var_115_9 = 0.1

			if var_115_8 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_10 = arg_112_1:FormatText(StoryNameCfg[1133].name)

				arg_112_1.leftNameTxt_.text = var_115_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_11 = arg_112_1:GetWordFromCfg(417082026)
				local var_115_12 = arg_112_1:FormatText(var_115_11.content)

				arg_112_1.text_.text = var_115_12

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 4
				local var_115_14 = utf8.len(var_115_12)
				local var_115_15 = var_115_13 <= 0 and var_115_9 or var_115_9 * (var_115_14 / var_115_13)

				if var_115_15 > 0 and var_115_9 < var_115_15 then
					arg_112_1.talkMaxDuration = var_115_15

					if var_115_15 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_15 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_12
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082026", "story_v_out_417082.awb") ~= 0 then
					local var_115_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082026", "story_v_out_417082.awb") / 1000

					if var_115_16 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_16 + var_115_8
					end

					if var_115_11.prefab_name ~= "" and arg_112_1.actors_[var_115_11.prefab_name] ~= nil then
						local var_115_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_11.prefab_name].transform, "story_v_out_417082", "417082026", "story_v_out_417082.awb")

						arg_112_1:RecordAudio("417082026", var_115_17)
						arg_112_1:RecordAudio("417082026", var_115_17)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417082", "417082026", "story_v_out_417082.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417082", "417082026", "story_v_out_417082.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_18 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_18 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_18

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_18 and arg_112_1.time_ < var_115_8 + var_115_18 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play417082027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417082027
		arg_116_1.duration_ = 10.87

		local var_116_0 = {
			zh = 10.2,
			ja = 10.866
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
				arg_116_0:Play417082028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1034"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 1, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_119_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			local var_119_8 = arg_116_1.actors_["1034"].transform
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 then
				arg_116_1.var_.moveOldPos1034 = var_119_8.localPosition
				var_119_8.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1034", 3)

				local var_119_10 = var_119_8.childCount

				for iter_119_4 = 0, var_119_10 - 1 do
					local var_119_11 = var_119_8:GetChild(iter_119_4)

					if var_119_11.name == "" or not string.find(var_119_11.name, "split") then
						var_119_11.gameObject:SetActive(true)
					else
						var_119_11.gameObject:SetActive(false)
					end
				end
			end

			local var_119_12 = 0.001

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_12 then
				local var_119_13 = (arg_116_1.time_ - var_119_9) / var_119_12
				local var_119_14 = Vector3.New(0, -331.9, -324)

				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1034, var_119_14, var_119_13)
			end

			if arg_116_1.time_ >= var_119_9 + var_119_12 and arg_116_1.time_ < var_119_9 + var_119_12 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_119_15 = 0
			local var_119_16 = 1.05

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[1109].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_18 = arg_116_1:GetWordFromCfg(417082027)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 42
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082027", "story_v_out_417082.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082027", "story_v_out_417082.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_out_417082", "417082027", "story_v_out_417082.awb")

						arg_116_1:RecordAudio("417082027", var_119_24)
						arg_116_1:RecordAudio("417082027", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417082", "417082027", "story_v_out_417082.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417082", "417082027", "story_v_out_417082.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play417082028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417082028
		arg_120_1.duration_ = 11.7

		local var_120_0 = {
			zh = 11.7,
			ja = 7.1
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
				arg_120_0:Play417082029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.225

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[1109].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(417082028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082028", "story_v_out_417082.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082028", "story_v_out_417082.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_417082", "417082028", "story_v_out_417082.awb")

						arg_120_1:RecordAudio("417082028", var_123_9)
						arg_120_1:RecordAudio("417082028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417082", "417082028", "story_v_out_417082.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417082", "417082028", "story_v_out_417082.awb")
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
	Play417082029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417082029
		arg_124_1.duration_ = 5.1

		local var_124_0 = {
			zh = 4.9,
			ja = 5.1
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
				arg_124_0:Play417082030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1034"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1034 == nil then
				arg_124_1.var_.actorSpriteComps1034 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps1034 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								local var_127_4 = Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, var_127_3)
								local var_127_5 = Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, var_127_3)
								local var_127_6 = Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, var_127_3)

								iter_127_1.color = Color.New(var_127_4, var_127_5, var_127_6)
							else
								local var_127_7 = Mathf.Lerp(iter_127_1.color.r, 0.5, var_127_3)

								iter_127_1.color = Color.New(var_127_7, var_127_7, var_127_7)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1034 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_127_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1034 = nil
			end

			local var_127_8 = 0
			local var_127_9 = 0.575

			if var_127_8 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_10 = arg_124_1:FormatText(StoryNameCfg[1133].name)

				arg_124_1.leftNameTxt_.text = var_127_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_11 = arg_124_1:GetWordFromCfg(417082029)
				local var_127_12 = arg_124_1:FormatText(var_127_11.content)

				arg_124_1.text_.text = var_127_12

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 23
				local var_127_14 = utf8.len(var_127_12)
				local var_127_15 = var_127_13 <= 0 and var_127_9 or var_127_9 * (var_127_14 / var_127_13)

				if var_127_15 > 0 and var_127_9 < var_127_15 then
					arg_124_1.talkMaxDuration = var_127_15

					if var_127_15 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_15 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_12
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082029", "story_v_out_417082.awb") ~= 0 then
					local var_127_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082029", "story_v_out_417082.awb") / 1000

					if var_127_16 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_16 + var_127_8
					end

					if var_127_11.prefab_name ~= "" and arg_124_1.actors_[var_127_11.prefab_name] ~= nil then
						local var_127_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_11.prefab_name].transform, "story_v_out_417082", "417082029", "story_v_out_417082.awb")

						arg_124_1:RecordAudio("417082029", var_127_17)
						arg_124_1:RecordAudio("417082029", var_127_17)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417082", "417082029", "story_v_out_417082.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417082", "417082029", "story_v_out_417082.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_18 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_18 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_18

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_18 and arg_124_1.time_ < var_127_8 + var_127_18 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play417082030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417082030
		arg_128_1.duration_ = 7.6

		local var_128_0 = {
			zh = 6.533,
			ja = 7.6
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
				arg_128_0:Play417082031(arg_128_1)
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

			local var_131_8 = 0
			local var_131_9 = 0.775

			if var_131_8 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_10 = arg_128_1:FormatText(StoryNameCfg[1109].name)

				arg_128_1.leftNameTxt_.text = var_131_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_11 = arg_128_1:GetWordFromCfg(417082030)
				local var_131_12 = arg_128_1:FormatText(var_131_11.content)

				arg_128_1.text_.text = var_131_12

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_13 = 31
				local var_131_14 = utf8.len(var_131_12)
				local var_131_15 = var_131_13 <= 0 and var_131_9 or var_131_9 * (var_131_14 / var_131_13)

				if var_131_15 > 0 and var_131_9 < var_131_15 then
					arg_128_1.talkMaxDuration = var_131_15

					if var_131_15 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_15 + var_131_8
					end
				end

				arg_128_1.text_.text = var_131_12
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082030", "story_v_out_417082.awb") ~= 0 then
					local var_131_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082030", "story_v_out_417082.awb") / 1000

					if var_131_16 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_16 + var_131_8
					end

					if var_131_11.prefab_name ~= "" and arg_128_1.actors_[var_131_11.prefab_name] ~= nil then
						local var_131_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_11.prefab_name].transform, "story_v_out_417082", "417082030", "story_v_out_417082.awb")

						arg_128_1:RecordAudio("417082030", var_131_17)
						arg_128_1:RecordAudio("417082030", var_131_17)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417082", "417082030", "story_v_out_417082.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417082", "417082030", "story_v_out_417082.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_18 = math.max(var_131_9, arg_128_1.talkMaxDuration)

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_18 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_8) / var_131_18

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_8 + var_131_18 and arg_128_1.time_ < var_131_8 + var_131_18 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417082031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417082031
		arg_132_1.duration_ = 2.23

		local var_132_0 = {
			zh = 0.999999999999,
			ja = 2.233
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
				arg_132_0:Play417082032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1034"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1034 == nil then
				arg_132_1.var_.actorSpriteComps1034 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps1034 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								local var_135_4 = Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, var_135_3)
								local var_135_5 = Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, var_135_3)
								local var_135_6 = Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, var_135_3)

								iter_135_1.color = Color.New(var_135_4, var_135_5, var_135_6)
							else
								local var_135_7 = Mathf.Lerp(iter_135_1.color.r, 0.5, var_135_3)

								iter_135_1.color = Color.New(var_135_7, var_135_7, var_135_7)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1034 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1034 = nil
			end

			local var_135_8 = 0
			local var_135_9 = 0.05

			if var_135_8 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_10 = arg_132_1:FormatText(StoryNameCfg[1133].name)

				arg_132_1.leftNameTxt_.text = var_135_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_11 = arg_132_1:GetWordFromCfg(417082031)
				local var_135_12 = arg_132_1:FormatText(var_135_11.content)

				arg_132_1.text_.text = var_135_12

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 2
				local var_135_14 = utf8.len(var_135_12)
				local var_135_15 = var_135_13 <= 0 and var_135_9 or var_135_9 * (var_135_14 / var_135_13)

				if var_135_15 > 0 and var_135_9 < var_135_15 then
					arg_132_1.talkMaxDuration = var_135_15

					if var_135_15 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_15 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_12
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082031", "story_v_out_417082.awb") ~= 0 then
					local var_135_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082031", "story_v_out_417082.awb") / 1000

					if var_135_16 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_16 + var_135_8
					end

					if var_135_11.prefab_name ~= "" and arg_132_1.actors_[var_135_11.prefab_name] ~= nil then
						local var_135_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_11.prefab_name].transform, "story_v_out_417082", "417082031", "story_v_out_417082.awb")

						arg_132_1:RecordAudio("417082031", var_135_17)
						arg_132_1:RecordAudio("417082031", var_135_17)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417082", "417082031", "story_v_out_417082.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417082", "417082031", "story_v_out_417082.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_18 = math.max(var_135_9, arg_132_1.talkMaxDuration)

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_18 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_8) / var_135_18

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_8 + var_135_18 and arg_132_1.time_ < var_135_8 + var_135_18 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417082032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417082032
		arg_136_1.duration_ = 5.57

		local var_136_0 = {
			zh = 4.266,
			ja = 5.566
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
				arg_136_0:Play417082033(arg_136_1)
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

			local var_139_8 = arg_136_1.actors_["1034"].transform
			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.var_.moveOldPos1034 = var_139_8.localPosition
				var_139_8.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1034", 3)

				local var_139_10 = var_139_8.childCount

				for iter_139_4 = 0, var_139_10 - 1 do
					local var_139_11 = var_139_8:GetChild(iter_139_4)

					if var_139_11.name == "" or not string.find(var_139_11.name, "split") then
						var_139_11.gameObject:SetActive(true)
					else
						var_139_11.gameObject:SetActive(false)
					end
				end
			end

			local var_139_12 = 0.001

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_12 then
				local var_139_13 = (arg_136_1.time_ - var_139_9) / var_139_12
				local var_139_14 = Vector3.New(0, -331.9, -324)

				var_139_8.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1034, var_139_14, var_139_13)
			end

			if arg_136_1.time_ >= var_139_9 + var_139_12 and arg_136_1.time_ < var_139_9 + var_139_12 + arg_139_0 then
				var_139_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_139_15 = 0
			local var_139_16 = 0.45

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_17 = arg_136_1:FormatText(StoryNameCfg[1109].name)

				arg_136_1.leftNameTxt_.text = var_139_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_18 = arg_136_1:GetWordFromCfg(417082032)
				local var_139_19 = arg_136_1:FormatText(var_139_18.content)

				arg_136_1.text_.text = var_139_19

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_20 = 18
				local var_139_21 = utf8.len(var_139_19)
				local var_139_22 = var_139_20 <= 0 and var_139_16 or var_139_16 * (var_139_21 / var_139_20)

				if var_139_22 > 0 and var_139_16 < var_139_22 then
					arg_136_1.talkMaxDuration = var_139_22

					if var_139_22 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_22 + var_139_15
					end
				end

				arg_136_1.text_.text = var_139_19
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082032", "story_v_out_417082.awb") ~= 0 then
					local var_139_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082032", "story_v_out_417082.awb") / 1000

					if var_139_23 + var_139_15 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_15
					end

					if var_139_18.prefab_name ~= "" and arg_136_1.actors_[var_139_18.prefab_name] ~= nil then
						local var_139_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_18.prefab_name].transform, "story_v_out_417082", "417082032", "story_v_out_417082.awb")

						arg_136_1:RecordAudio("417082032", var_139_24)
						arg_136_1:RecordAudio("417082032", var_139_24)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417082", "417082032", "story_v_out_417082.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417082", "417082032", "story_v_out_417082.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_25 = math.max(var_139_16, arg_136_1.talkMaxDuration)

			if var_139_15 <= arg_136_1.time_ and arg_136_1.time_ < var_139_15 + var_139_25 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_15) / var_139_25

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_15 + var_139_25 and arg_136_1.time_ < var_139_15 + var_139_25 + arg_139_0 then
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
	Play417082033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417082033
		arg_140_1.duration_ = 3.17

		local var_140_0 = {
			zh = 2.5,
			ja = 3.166
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
				arg_140_0:Play417082034(arg_140_1)
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

			local var_143_8 = 0
			local var_143_9 = 0.2

			if var_143_8 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_10 = arg_140_1:FormatText(StoryNameCfg[1133].name)

				arg_140_1.leftNameTxt_.text = var_143_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_11 = arg_140_1:GetWordFromCfg(417082033)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 8
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_9 or var_143_9 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_9 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082033", "story_v_out_417082.awb") ~= 0 then
					local var_143_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082033", "story_v_out_417082.awb") / 1000

					if var_143_16 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_16 + var_143_8
					end

					if var_143_11.prefab_name ~= "" and arg_140_1.actors_[var_143_11.prefab_name] ~= nil then
						local var_143_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_11.prefab_name].transform, "story_v_out_417082", "417082033", "story_v_out_417082.awb")

						arg_140_1:RecordAudio("417082033", var_143_17)
						arg_140_1:RecordAudio("417082033", var_143_17)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417082", "417082033", "story_v_out_417082.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417082", "417082033", "story_v_out_417082.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_18 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_18 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_18

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_18 and arg_140_1.time_ < var_143_8 + var_143_18 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play417082034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417082034
		arg_144_1.duration_ = 9.53

		local var_144_0 = {
			zh = 6.366,
			ja = 9.533
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
				arg_144_0:Play417082035(arg_144_1)
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

			local var_147_8 = 0
			local var_147_9 = 0.85

			if var_147_8 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_10 = arg_144_1:FormatText(StoryNameCfg[1109].name)

				arg_144_1.leftNameTxt_.text = var_147_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_11 = arg_144_1:GetWordFromCfg(417082034)
				local var_147_12 = arg_144_1:FormatText(var_147_11.content)

				arg_144_1.text_.text = var_147_12

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082034", "story_v_out_417082.awb") ~= 0 then
					local var_147_16 = manager.audio:GetVoiceLength("story_v_out_417082", "417082034", "story_v_out_417082.awb") / 1000

					if var_147_16 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_8
					end

					if var_147_11.prefab_name ~= "" and arg_144_1.actors_[var_147_11.prefab_name] ~= nil then
						local var_147_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_11.prefab_name].transform, "story_v_out_417082", "417082034", "story_v_out_417082.awb")

						arg_144_1:RecordAudio("417082034", var_147_17)
						arg_144_1:RecordAudio("417082034", var_147_17)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417082", "417082034", "story_v_out_417082.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417082", "417082034", "story_v_out_417082.awb")
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
	Play417082035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417082035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play417082036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1034"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1034 == nil then
				arg_148_1.var_.actorSpriteComps1034 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps1034 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								local var_151_4 = Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor2.r, var_151_3)
								local var_151_5 = Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor2.g, var_151_3)
								local var_151_6 = Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor2.b, var_151_3)

								iter_151_1.color = Color.New(var_151_4, var_151_5, var_151_6)
							else
								local var_151_7 = Mathf.Lerp(iter_151_1.color.r, 0.5, var_151_3)

								iter_151_1.color = Color.New(var_151_7, var_151_7, var_151_7)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1034 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1034 = nil
			end

			local var_151_8 = 0
			local var_151_9 = 1.275

			if var_151_8 < arg_148_1.time_ and arg_148_1.time_ <= var_151_8 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_10 = arg_148_1:GetWordFromCfg(417082035)
				local var_151_11 = arg_148_1:FormatText(var_151_10.content)

				arg_148_1.text_.text = var_151_11

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_12 = 51
				local var_151_13 = utf8.len(var_151_11)
				local var_151_14 = var_151_12 <= 0 and var_151_9 or var_151_9 * (var_151_13 / var_151_12)

				if var_151_14 > 0 and var_151_9 < var_151_14 then
					arg_148_1.talkMaxDuration = var_151_14

					if var_151_14 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_8
					end
				end

				arg_148_1.text_.text = var_151_11
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_15 = math.max(var_151_9, arg_148_1.talkMaxDuration)

			if var_151_8 <= arg_148_1.time_ and arg_148_1.time_ < var_151_8 + var_151_15 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_8) / var_151_15

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_8 + var_151_15 and arg_148_1.time_ < var_151_8 + var_151_15 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play417082036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417082036
		arg_152_1.duration_ = 4.8

		local var_152_0 = {
			zh = 4.266,
			ja = 4.8
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
				arg_152_0:Play417082037(arg_152_1)
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

			local var_155_8 = arg_152_1.actors_["1034"].transform
			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.var_.moveOldPos1034 = var_155_8.localPosition
				var_155_8.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1034", 3)

				local var_155_10 = var_155_8.childCount

				for iter_155_4 = 0, var_155_10 - 1 do
					local var_155_11 = var_155_8:GetChild(iter_155_4)

					if var_155_11.name == "split_6" or not string.find(var_155_11.name, "split") then
						var_155_11.gameObject:SetActive(true)
					else
						var_155_11.gameObject:SetActive(false)
					end
				end
			end

			local var_155_12 = 0.001

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_12 then
				local var_155_13 = (arg_152_1.time_ - var_155_9) / var_155_12
				local var_155_14 = Vector3.New(0, -331.9, -324)

				var_155_8.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1034, var_155_14, var_155_13)
			end

			if arg_152_1.time_ >= var_155_9 + var_155_12 and arg_152_1.time_ < var_155_9 + var_155_12 + arg_155_0 then
				var_155_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_155_15 = 0
			local var_155_16 = 0.475

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[1109].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(417082036)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 19
				local var_155_21 = utf8.len(var_155_19)
				local var_155_22 = var_155_20 <= 0 and var_155_16 or var_155_16 * (var_155_21 / var_155_20)

				if var_155_22 > 0 and var_155_16 < var_155_22 then
					arg_152_1.talkMaxDuration = var_155_22

					if var_155_22 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_22 + var_155_15
					end
				end

				arg_152_1.text_.text = var_155_19
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082036", "story_v_out_417082.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082036", "story_v_out_417082.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_417082", "417082036", "story_v_out_417082.awb")

						arg_152_1:RecordAudio("417082036", var_155_24)
						arg_152_1:RecordAudio("417082036", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_417082", "417082036", "story_v_out_417082.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_417082", "417082036", "story_v_out_417082.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_25 = math.max(var_155_16, arg_152_1.talkMaxDuration)

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_25 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_15) / var_155_25

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_15 + var_155_25 and arg_152_1.time_ < var_155_15 + var_155_25 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play417082037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417082037
		arg_156_1.duration_ = 1.03

		local var_156_0 = {
			zh = 1,
			ja = 1.033
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
				arg_156_0:Play417082038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = "1052"

			if arg_156_1.actors_[var_159_0] == nil then
				local var_159_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1052")

				if not isNil(var_159_1) then
					local var_159_2 = Object.Instantiate(var_159_1, arg_156_1.canvasGo_.transform)

					var_159_2.transform:SetSiblingIndex(1)

					var_159_2.name = var_159_0
					var_159_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_156_1.actors_[var_159_0] = var_159_2

					local var_159_3 = var_159_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_156_1.isInRecall_ then
						for iter_159_0, iter_159_1 in ipairs(var_159_3) do
							iter_159_1.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_159_4 = arg_156_1.actors_["1052"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.actorSpriteComps1052 == nil then
				arg_156_1.var_.actorSpriteComps1052 = var_159_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_6 = 0.2

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.actorSpriteComps1052 then
					for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_159_3 then
							if arg_156_1.isInRecall_ then
								local var_159_8 = Mathf.Lerp(iter_159_3.color.r, arg_156_1.hightColor1.r, var_159_7)
								local var_159_9 = Mathf.Lerp(iter_159_3.color.g, arg_156_1.hightColor1.g, var_159_7)
								local var_159_10 = Mathf.Lerp(iter_159_3.color.b, arg_156_1.hightColor1.b, var_159_7)

								iter_159_3.color = Color.New(var_159_8, var_159_9, var_159_10)
							else
								local var_159_11 = Mathf.Lerp(iter_159_3.color.r, 1, var_159_7)

								iter_159_3.color = Color.New(var_159_11, var_159_11, var_159_11)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.actorSpriteComps1052 then
				for iter_159_4, iter_159_5 in pairs(arg_156_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_159_5 then
						if arg_156_1.isInRecall_ then
							iter_159_5.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_159_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1052 = nil
			end

			local var_159_12 = arg_156_1.actors_["1034"]
			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 and not isNil(var_159_12) and arg_156_1.var_.actorSpriteComps1034 == nil then
				arg_156_1.var_.actorSpriteComps1034 = var_159_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_14 = 0.2

			if var_159_13 <= arg_156_1.time_ and arg_156_1.time_ < var_159_13 + var_159_14 and not isNil(var_159_12) then
				local var_159_15 = (arg_156_1.time_ - var_159_13) / var_159_14

				if arg_156_1.var_.actorSpriteComps1034 then
					for iter_159_6, iter_159_7 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_159_7 then
							if arg_156_1.isInRecall_ then
								local var_159_16 = Mathf.Lerp(iter_159_7.color.r, arg_156_1.hightColor2.r, var_159_15)
								local var_159_17 = Mathf.Lerp(iter_159_7.color.g, arg_156_1.hightColor2.g, var_159_15)
								local var_159_18 = Mathf.Lerp(iter_159_7.color.b, arg_156_1.hightColor2.b, var_159_15)

								iter_159_7.color = Color.New(var_159_16, var_159_17, var_159_18)
							else
								local var_159_19 = Mathf.Lerp(iter_159_7.color.r, 0.5, var_159_15)

								iter_159_7.color = Color.New(var_159_19, var_159_19, var_159_19)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_13 + var_159_14 and arg_156_1.time_ < var_159_13 + var_159_14 + arg_159_0 and not isNil(var_159_12) and arg_156_1.var_.actorSpriteComps1034 then
				for iter_159_8, iter_159_9 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_159_9 then
						if arg_156_1.isInRecall_ then
							iter_159_9.color = arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_159_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1034 = nil
			end

			local var_159_20 = 0
			local var_159_21 = 0.1

			if var_159_20 < arg_156_1.time_ and arg_156_1.time_ <= var_159_20 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_22 = arg_156_1:FormatText(StoryNameCfg[1117].name)

				arg_156_1.leftNameTxt_.text = var_159_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_5")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_23 = arg_156_1:GetWordFromCfg(417082037)
				local var_159_24 = arg_156_1:FormatText(var_159_23.content)

				arg_156_1.text_.text = var_159_24

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_25 = 4
				local var_159_26 = utf8.len(var_159_24)
				local var_159_27 = var_159_25 <= 0 and var_159_21 or var_159_21 * (var_159_26 / var_159_25)

				if var_159_27 > 0 and var_159_21 < var_159_27 then
					arg_156_1.talkMaxDuration = var_159_27

					if var_159_27 + var_159_20 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_27 + var_159_20
					end
				end

				arg_156_1.text_.text = var_159_24
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082037", "story_v_out_417082.awb") ~= 0 then
					local var_159_28 = manager.audio:GetVoiceLength("story_v_out_417082", "417082037", "story_v_out_417082.awb") / 1000

					if var_159_28 + var_159_20 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_28 + var_159_20
					end

					if var_159_23.prefab_name ~= "" and arg_156_1.actors_[var_159_23.prefab_name] ~= nil then
						local var_159_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_23.prefab_name].transform, "story_v_out_417082", "417082037", "story_v_out_417082.awb")

						arg_156_1:RecordAudio("417082037", var_159_29)
						arg_156_1:RecordAudio("417082037", var_159_29)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417082", "417082037", "story_v_out_417082.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417082", "417082037", "story_v_out_417082.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_30 = math.max(var_159_21, arg_156_1.talkMaxDuration)

			if var_159_20 <= arg_156_1.time_ and arg_156_1.time_ < var_159_20 + var_159_30 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_20) / var_159_30

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_20 + var_159_30 and arg_156_1.time_ < var_159_20 + var_159_30 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417082038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417082038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417082039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1052"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1052 == nil then
				arg_160_1.var_.actorSpriteComps1052 = var_163_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.actorSpriteComps1052 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps1052:ToTable()) do
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

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1052 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_163_3 then
						if arg_160_1.isInRecall_ then
							iter_163_3.color = arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_163_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps1052 = nil
			end

			local var_163_8 = arg_160_1.actors_["1034"].transform
			local var_163_9 = 0

			if var_163_9 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.var_.moveOldPos1034 = var_163_8.localPosition
				var_163_8.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("1034", 7)

				local var_163_10 = var_163_8.childCount

				for iter_163_4 = 0, var_163_10 - 1 do
					local var_163_11 = var_163_8:GetChild(iter_163_4)

					if var_163_11.name == "" or not string.find(var_163_11.name, "split") then
						var_163_11.gameObject:SetActive(true)
					else
						var_163_11.gameObject:SetActive(false)
					end
				end
			end

			local var_163_12 = 0.001

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_12 then
				local var_163_13 = (arg_160_1.time_ - var_163_9) / var_163_12
				local var_163_14 = Vector3.New(0, -2000, 0)

				var_163_8.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1034, var_163_14, var_163_13)
			end

			if arg_160_1.time_ >= var_163_9 + var_163_12 and arg_160_1.time_ < var_163_9 + var_163_12 + arg_163_0 then
				var_163_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_163_15 = 0.2
			local var_163_16 = 1

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				local var_163_17 = "play"
				local var_163_18 = "effect"

				arg_160_1:AudioAction(var_163_17, var_163_18, "se_story_1310", "se_story_1310_surround", "")
			end

			local var_163_19 = 0
			local var_163_20 = 1.6

			if var_163_19 < arg_160_1.time_ and arg_160_1.time_ <= var_163_19 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_21 = arg_160_1:GetWordFromCfg(417082038)
				local var_163_22 = arg_160_1:FormatText(var_163_21.content)

				arg_160_1.text_.text = var_163_22

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_23 = 64
				local var_163_24 = utf8.len(var_163_22)
				local var_163_25 = var_163_23 <= 0 and var_163_20 or var_163_20 * (var_163_24 / var_163_23)

				if var_163_25 > 0 and var_163_20 < var_163_25 then
					arg_160_1.talkMaxDuration = var_163_25

					if var_163_25 + var_163_19 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_25 + var_163_19
					end
				end

				arg_160_1.text_.text = var_163_22
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_26 = math.max(var_163_20, arg_160_1.talkMaxDuration)

			if var_163_19 <= arg_160_1.time_ and arg_160_1.time_ < var_163_19 + var_163_26 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_19) / var_163_26

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_19 + var_163_26 and arg_160_1.time_ < var_163_19 + var_163_26 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
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

		arg_160_1:InitPlayNodeList()
	end,
	Play417082039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417082039
		arg_164_1.duration_ = 2.43

		local var_164_0 = {
			zh = 1.3,
			ja = 2.433
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
				arg_164_0:Play417082040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = "10113"

			if arg_164_1.actors_[var_167_0] == nil then
				local var_167_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_167_1) then
					local var_167_2 = Object.Instantiate(var_167_1, arg_164_1.canvasGo_.transform)

					var_167_2.transform:SetSiblingIndex(1)

					var_167_2.name = var_167_0
					var_167_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_164_1.actors_[var_167_0] = var_167_2

					local var_167_3 = var_167_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_164_1.isInRecall_ then
						for iter_167_0, iter_167_1 in ipairs(var_167_3) do
							iter_167_1.color = arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_167_4 = arg_164_1.actors_["10113"]
			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.actorSpriteComps10113 == nil then
				arg_164_1.var_.actorSpriteComps10113 = var_167_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_6 = 0.2

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_6 and not isNil(var_167_4) then
				local var_167_7 = (arg_164_1.time_ - var_167_5) / var_167_6

				if arg_164_1.var_.actorSpriteComps10113 then
					for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_167_3 then
							if arg_164_1.isInRecall_ then
								local var_167_8 = Mathf.Lerp(iter_167_3.color.r, arg_164_1.hightColor1.r, var_167_7)
								local var_167_9 = Mathf.Lerp(iter_167_3.color.g, arg_164_1.hightColor1.g, var_167_7)
								local var_167_10 = Mathf.Lerp(iter_167_3.color.b, arg_164_1.hightColor1.b, var_167_7)

								iter_167_3.color = Color.New(var_167_8, var_167_9, var_167_10)
							else
								local var_167_11 = Mathf.Lerp(iter_167_3.color.r, 1, var_167_7)

								iter_167_3.color = Color.New(var_167_11, var_167_11, var_167_11)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= var_167_5 + var_167_6 and arg_164_1.time_ < var_167_5 + var_167_6 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.actorSpriteComps10113 then
				for iter_167_4, iter_167_5 in pairs(arg_164_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_167_5 then
						if arg_164_1.isInRecall_ then
							iter_167_5.color = arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_167_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_164_1.var_.actorSpriteComps10113 = nil
			end

			local var_167_12 = arg_164_1.actors_["10113"].transform
			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1.var_.moveOldPos10113 = var_167_12.localPosition
				var_167_12.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10113", 3)

				local var_167_14 = var_167_12.childCount

				for iter_167_6 = 0, var_167_14 - 1 do
					local var_167_15 = var_167_12:GetChild(iter_167_6)

					if var_167_15.name == "split_6" or not string.find(var_167_15.name, "split") then
						var_167_15.gameObject:SetActive(true)
					else
						var_167_15.gameObject:SetActive(false)
					end
				end
			end

			local var_167_16 = 0.001

			if var_167_13 <= arg_164_1.time_ and arg_164_1.time_ < var_167_13 + var_167_16 then
				local var_167_17 = (arg_164_1.time_ - var_167_13) / var_167_16
				local var_167_18 = Vector3.New(-30.38, -328.4, -517.4)

				var_167_12.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10113, var_167_18, var_167_17)
			end

			if arg_164_1.time_ >= var_167_13 + var_167_16 and arg_164_1.time_ < var_167_13 + var_167_16 + arg_167_0 then
				var_167_12.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_167_19 = 0
			local var_167_20 = 0.15

			if var_167_19 < arg_164_1.time_ and arg_164_1.time_ <= var_167_19 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_21 = arg_164_1:FormatText(StoryNameCfg[1117].name)

				arg_164_1.leftNameTxt_.text = var_167_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_22 = arg_164_1:GetWordFromCfg(417082039)
				local var_167_23 = arg_164_1:FormatText(var_167_22.content)

				arg_164_1.text_.text = var_167_23

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_24 = 6
				local var_167_25 = utf8.len(var_167_23)
				local var_167_26 = var_167_24 <= 0 and var_167_20 or var_167_20 * (var_167_25 / var_167_24)

				if var_167_26 > 0 and var_167_20 < var_167_26 then
					arg_164_1.talkMaxDuration = var_167_26

					if var_167_26 + var_167_19 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_26 + var_167_19
					end
				end

				arg_164_1.text_.text = var_167_23
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082039", "story_v_out_417082.awb") ~= 0 then
					local var_167_27 = manager.audio:GetVoiceLength("story_v_out_417082", "417082039", "story_v_out_417082.awb") / 1000

					if var_167_27 + var_167_19 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_27 + var_167_19
					end

					if var_167_22.prefab_name ~= "" and arg_164_1.actors_[var_167_22.prefab_name] ~= nil then
						local var_167_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_22.prefab_name].transform, "story_v_out_417082", "417082039", "story_v_out_417082.awb")

						arg_164_1:RecordAudio("417082039", var_167_28)
						arg_164_1:RecordAudio("417082039", var_167_28)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417082", "417082039", "story_v_out_417082.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417082", "417082039", "story_v_out_417082.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_29 = math.max(var_167_20, arg_164_1.talkMaxDuration)

			if var_167_19 <= arg_164_1.time_ and arg_164_1.time_ < var_167_19 + var_167_29 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_19) / var_167_29

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_19 + var_167_29 and arg_164_1.time_ < var_167_19 + var_167_29 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play417082040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417082040
		arg_168_1.duration_ = 4.1

		local var_168_0 = {
			zh = 2.433,
			ja = 4.1
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
				arg_168_0:Play417082041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1034"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1034 == nil then
				arg_168_1.var_.actorSpriteComps1034 = var_171_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.actorSpriteComps1034 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1034 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_171_3 then
						if arg_168_1.isInRecall_ then
							iter_171_3.color = arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_171_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps1034 = nil
			end

			local var_171_8 = arg_168_1.actors_["10113"]
			local var_171_9 = 0

			if var_171_9 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.actorSpriteComps10113 == nil then
				arg_168_1.var_.actorSpriteComps10113 = var_171_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_10 = 0.2

			if var_171_9 <= arg_168_1.time_ and arg_168_1.time_ < var_171_9 + var_171_10 and not isNil(var_171_8) then
				local var_171_11 = (arg_168_1.time_ - var_171_9) / var_171_10

				if arg_168_1.var_.actorSpriteComps10113 then
					for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_168_1.time_ >= var_171_9 + var_171_10 and arg_168_1.time_ < var_171_9 + var_171_10 + arg_171_0 and not isNil(var_171_8) and arg_168_1.var_.actorSpriteComps10113 then
				for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_171_7 then
						if arg_168_1.isInRecall_ then
							iter_171_7.color = arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_171_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps10113 = nil
			end

			local var_171_16 = arg_168_1.actors_["1034"].transform
			local var_171_17 = 0

			if var_171_17 < arg_168_1.time_ and arg_168_1.time_ <= var_171_17 + arg_171_0 then
				arg_168_1.var_.moveOldPos1034 = var_171_16.localPosition
				var_171_16.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1034", 4)

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
				local var_171_22 = Vector3.New(373.7, -331.9, -324)

				var_171_16.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1034, var_171_22, var_171_21)
			end

			if arg_168_1.time_ >= var_171_17 + var_171_20 and arg_168_1.time_ < var_171_17 + var_171_20 + arg_171_0 then
				var_171_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_171_23 = arg_168_1.actors_["10113"].transform
			local var_171_24 = 0

			if var_171_24 < arg_168_1.time_ and arg_168_1.time_ <= var_171_24 + arg_171_0 then
				arg_168_1.var_.moveOldPos10113 = var_171_23.localPosition
				var_171_23.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10113", 2)

				local var_171_25 = var_171_23.childCount

				for iter_171_9 = 0, var_171_25 - 1 do
					local var_171_26 = var_171_23:GetChild(iter_171_9)

					if var_171_26.name == "split_6" or not string.find(var_171_26.name, "split") then
						var_171_26.gameObject:SetActive(true)
					else
						var_171_26.gameObject:SetActive(false)
					end
				end
			end

			local var_171_27 = 0.001

			if var_171_24 <= arg_168_1.time_ and arg_168_1.time_ < var_171_24 + var_171_27 then
				local var_171_28 = (arg_168_1.time_ - var_171_24) / var_171_27
				local var_171_29 = Vector3.New(-403.26, -328.4, -517.4)

				var_171_23.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10113, var_171_29, var_171_28)
			end

			if arg_168_1.time_ >= var_171_24 + var_171_27 and arg_168_1.time_ < var_171_24 + var_171_27 + arg_171_0 then
				var_171_23.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_171_30 = 0
			local var_171_31 = 0.275

			if var_171_30 < arg_168_1.time_ and arg_168_1.time_ <= var_171_30 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_32 = arg_168_1:FormatText(StoryNameCfg[1109].name)

				arg_168_1.leftNameTxt_.text = var_171_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_33 = arg_168_1:GetWordFromCfg(417082040)
				local var_171_34 = arg_168_1:FormatText(var_171_33.content)

				arg_168_1.text_.text = var_171_34

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_35 = 11
				local var_171_36 = utf8.len(var_171_34)
				local var_171_37 = var_171_35 <= 0 and var_171_31 or var_171_31 * (var_171_36 / var_171_35)

				if var_171_37 > 0 and var_171_31 < var_171_37 then
					arg_168_1.talkMaxDuration = var_171_37

					if var_171_37 + var_171_30 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_37 + var_171_30
					end
				end

				arg_168_1.text_.text = var_171_34
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082040", "story_v_out_417082.awb") ~= 0 then
					local var_171_38 = manager.audio:GetVoiceLength("story_v_out_417082", "417082040", "story_v_out_417082.awb") / 1000

					if var_171_38 + var_171_30 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_38 + var_171_30
					end

					if var_171_33.prefab_name ~= "" and arg_168_1.actors_[var_171_33.prefab_name] ~= nil then
						local var_171_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_33.prefab_name].transform, "story_v_out_417082", "417082040", "story_v_out_417082.awb")

						arg_168_1:RecordAudio("417082040", var_171_39)
						arg_168_1:RecordAudio("417082040", var_171_39)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_417082", "417082040", "story_v_out_417082.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_417082", "417082040", "story_v_out_417082.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_40 = math.max(var_171_31, arg_168_1.talkMaxDuration)

			if var_171_30 <= arg_168_1.time_ and arg_168_1.time_ < var_171_30 + var_171_40 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_30) / var_171_40

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_30 + var_171_40 and arg_168_1.time_ < var_171_30 + var_171_40 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
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
				actorName = "10113",
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
	Play417082041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417082041
		arg_172_1.duration_ = 9.6

		local var_172_0 = {
			zh = 3.766,
			ja = 9.6
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
				arg_172_0:Play417082042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10113"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps10113 == nil then
				arg_172_1.var_.actorSpriteComps10113 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps10113 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps10113 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_175_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps10113 = nil
			end

			local var_175_8 = arg_172_1.actors_["1034"]
			local var_175_9 = 0

			if var_175_9 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 and not isNil(var_175_8) and arg_172_1.var_.actorSpriteComps1034 == nil then
				arg_172_1.var_.actorSpriteComps1034 = var_175_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_10 = 0.2

			if var_175_9 <= arg_172_1.time_ and arg_172_1.time_ < var_175_9 + var_175_10 and not isNil(var_175_8) then
				local var_175_11 = (arg_172_1.time_ - var_175_9) / var_175_10

				if arg_172_1.var_.actorSpriteComps1034 then
					for iter_175_4, iter_175_5 in pairs(arg_172_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_172_1.time_ >= var_175_9 + var_175_10 and arg_172_1.time_ < var_175_9 + var_175_10 + arg_175_0 and not isNil(var_175_8) and arg_172_1.var_.actorSpriteComps1034 then
				for iter_175_6, iter_175_7 in pairs(arg_172_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_175_7 then
						if arg_172_1.isInRecall_ then
							iter_175_7.color = arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_175_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps1034 = nil
			end

			local var_175_16 = 0
			local var_175_17 = 0.45

			if var_175_16 < arg_172_1.time_ and arg_172_1.time_ <= var_175_16 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_18 = arg_172_1:FormatText(StoryNameCfg[1117].name)

				arg_172_1.leftNameTxt_.text = var_175_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_19 = arg_172_1:GetWordFromCfg(417082041)
				local var_175_20 = arg_172_1:FormatText(var_175_19.content)

				arg_172_1.text_.text = var_175_20

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_21 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082041", "story_v_out_417082.awb") ~= 0 then
					local var_175_24 = manager.audio:GetVoiceLength("story_v_out_417082", "417082041", "story_v_out_417082.awb") / 1000

					if var_175_24 + var_175_16 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_24 + var_175_16
					end

					if var_175_19.prefab_name ~= "" and arg_172_1.actors_[var_175_19.prefab_name] ~= nil then
						local var_175_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_19.prefab_name].transform, "story_v_out_417082", "417082041", "story_v_out_417082.awb")

						arg_172_1:RecordAudio("417082041", var_175_25)
						arg_172_1:RecordAudio("417082041", var_175_25)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417082", "417082041", "story_v_out_417082.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417082", "417082041", "story_v_out_417082.awb")
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
	Play417082042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417082042
		arg_176_1.duration_ = 7.6

		local var_176_0 = {
			zh = 4.466,
			ja = 7.6
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
				arg_176_0:Play417082043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1034"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1034 == nil then
				arg_176_1.var_.actorSpriteComps1034 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps1034 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_179_1 then
							if arg_176_1.isInRecall_ then
								local var_179_4 = Mathf.Lerp(iter_179_1.color.r, arg_176_1.hightColor1.r, var_179_3)
								local var_179_5 = Mathf.Lerp(iter_179_1.color.g, arg_176_1.hightColor1.g, var_179_3)
								local var_179_6 = Mathf.Lerp(iter_179_1.color.b, arg_176_1.hightColor1.b, var_179_3)

								iter_179_1.color = Color.New(var_179_4, var_179_5, var_179_6)
							else
								local var_179_7 = Mathf.Lerp(iter_179_1.color.r, 1, var_179_3)

								iter_179_1.color = Color.New(var_179_7, var_179_7, var_179_7)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1034 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps1034 = nil
			end

			local var_179_8 = arg_176_1.actors_["10113"]
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10113 == nil then
				arg_176_1.var_.actorSpriteComps10113 = var_179_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_10 = 0.2

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_10 and not isNil(var_179_8) then
				local var_179_11 = (arg_176_1.time_ - var_179_9) / var_179_10

				if arg_176_1.var_.actorSpriteComps10113 then
					for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_179_5 then
							if arg_176_1.isInRecall_ then
								local var_179_12 = Mathf.Lerp(iter_179_5.color.r, arg_176_1.hightColor2.r, var_179_11)
								local var_179_13 = Mathf.Lerp(iter_179_5.color.g, arg_176_1.hightColor2.g, var_179_11)
								local var_179_14 = Mathf.Lerp(iter_179_5.color.b, arg_176_1.hightColor2.b, var_179_11)

								iter_179_5.color = Color.New(var_179_12, var_179_13, var_179_14)
							else
								local var_179_15 = Mathf.Lerp(iter_179_5.color.r, 0.5, var_179_11)

								iter_179_5.color = Color.New(var_179_15, var_179_15, var_179_15)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_9 + var_179_10 and arg_176_1.time_ < var_179_9 + var_179_10 + arg_179_0 and not isNil(var_179_8) and arg_176_1.var_.actorSpriteComps10113 then
				for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_179_7 then
						if arg_176_1.isInRecall_ then
							iter_179_7.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10113 = nil
			end

			local var_179_16 = 0
			local var_179_17 = 0.6

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_18 = arg_176_1:FormatText(StoryNameCfg[1109].name)

				arg_176_1.leftNameTxt_.text = var_179_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_19 = arg_176_1:GetWordFromCfg(417082042)
				local var_179_20 = arg_176_1:FormatText(var_179_19.content)

				arg_176_1.text_.text = var_179_20

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_21 = 24
				local var_179_22 = utf8.len(var_179_20)
				local var_179_23 = var_179_21 <= 0 and var_179_17 or var_179_17 * (var_179_22 / var_179_21)

				if var_179_23 > 0 and var_179_17 < var_179_23 then
					arg_176_1.talkMaxDuration = var_179_23

					if var_179_23 + var_179_16 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_16
					end
				end

				arg_176_1.text_.text = var_179_20
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082042", "story_v_out_417082.awb") ~= 0 then
					local var_179_24 = manager.audio:GetVoiceLength("story_v_out_417082", "417082042", "story_v_out_417082.awb") / 1000

					if var_179_24 + var_179_16 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_24 + var_179_16
					end

					if var_179_19.prefab_name ~= "" and arg_176_1.actors_[var_179_19.prefab_name] ~= nil then
						local var_179_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_19.prefab_name].transform, "story_v_out_417082", "417082042", "story_v_out_417082.awb")

						arg_176_1:RecordAudio("417082042", var_179_25)
						arg_176_1:RecordAudio("417082042", var_179_25)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417082", "417082042", "story_v_out_417082.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417082", "417082042", "story_v_out_417082.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_26 = math.max(var_179_17, arg_176_1.talkMaxDuration)

			if var_179_16 <= arg_176_1.time_ and arg_176_1.time_ < var_179_16 + var_179_26 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_16) / var_179_26

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_16 + var_179_26 and arg_176_1.time_ < var_179_16 + var_179_26 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play417082043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417082043
		arg_180_1.duration_ = 1.43

		local var_180_0 = {
			zh = 0.999999999999,
			ja = 1.433
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
				arg_180_0:Play417082044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = "1028"

			if arg_180_1.actors_[var_183_0] == nil then
				local var_183_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_183_1) then
					local var_183_2 = Object.Instantiate(var_183_1, arg_180_1.canvasGo_.transform)

					var_183_2.transform:SetSiblingIndex(1)

					var_183_2.name = var_183_0
					var_183_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_180_1.actors_[var_183_0] = var_183_2

					local var_183_3 = var_183_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_180_1.isInRecall_ then
						for iter_183_0, iter_183_1 in ipairs(var_183_3) do
							iter_183_1.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_183_4 = arg_180_1.actors_["1028"]
			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.actorSpriteComps1028 == nil then
				arg_180_1.var_.actorSpriteComps1028 = var_183_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_6 = 0.2

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 and not isNil(var_183_4) then
				local var_183_7 = (arg_180_1.time_ - var_183_5) / var_183_6

				if arg_180_1.var_.actorSpriteComps1028 then
					for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_183_3 then
							if arg_180_1.isInRecall_ then
								local var_183_8 = Mathf.Lerp(iter_183_3.color.r, arg_180_1.hightColor1.r, var_183_7)
								local var_183_9 = Mathf.Lerp(iter_183_3.color.g, arg_180_1.hightColor1.g, var_183_7)
								local var_183_10 = Mathf.Lerp(iter_183_3.color.b, arg_180_1.hightColor1.b, var_183_7)

								iter_183_3.color = Color.New(var_183_8, var_183_9, var_183_10)
							else
								local var_183_11 = Mathf.Lerp(iter_183_3.color.r, 1, var_183_7)

								iter_183_3.color = Color.New(var_183_11, var_183_11, var_183_11)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.actorSpriteComps1028 then
				for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_183_5 then
						if arg_180_1.isInRecall_ then
							iter_183_5.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1028 = nil
			end

			local var_183_12 = arg_180_1.actors_["1034"]
			local var_183_13 = 0

			if var_183_13 < arg_180_1.time_ and arg_180_1.time_ <= var_183_13 + arg_183_0 and not isNil(var_183_12) and arg_180_1.var_.actorSpriteComps1034 == nil then
				arg_180_1.var_.actorSpriteComps1034 = var_183_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_14 = 0.2

			if var_183_13 <= arg_180_1.time_ and arg_180_1.time_ < var_183_13 + var_183_14 and not isNil(var_183_12) then
				local var_183_15 = (arg_180_1.time_ - var_183_13) / var_183_14

				if arg_180_1.var_.actorSpriteComps1034 then
					for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_183_7 then
							if arg_180_1.isInRecall_ then
								local var_183_16 = Mathf.Lerp(iter_183_7.color.r, arg_180_1.hightColor2.r, var_183_15)
								local var_183_17 = Mathf.Lerp(iter_183_7.color.g, arg_180_1.hightColor2.g, var_183_15)
								local var_183_18 = Mathf.Lerp(iter_183_7.color.b, arg_180_1.hightColor2.b, var_183_15)

								iter_183_7.color = Color.New(var_183_16, var_183_17, var_183_18)
							else
								local var_183_19 = Mathf.Lerp(iter_183_7.color.r, 0.5, var_183_15)

								iter_183_7.color = Color.New(var_183_19, var_183_19, var_183_19)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_13 + var_183_14 and arg_180_1.time_ < var_183_13 + var_183_14 + arg_183_0 and not isNil(var_183_12) and arg_180_1.var_.actorSpriteComps1034 then
				for iter_183_8, iter_183_9 in pairs(arg_180_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_183_9 then
						if arg_180_1.isInRecall_ then
							iter_183_9.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1034 = nil
			end

			local var_183_20 = 0
			local var_183_21 = 0.075

			if var_183_20 < arg_180_1.time_ and arg_180_1.time_ <= var_183_20 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_22 = arg_180_1:FormatText(StoryNameCfg[595].name)

				arg_180_1.leftNameTxt_.text = var_183_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_23 = arg_180_1:GetWordFromCfg(417082043)
				local var_183_24 = arg_180_1:FormatText(var_183_23.content)

				arg_180_1.text_.text = var_183_24

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_25 = 3
				local var_183_26 = utf8.len(var_183_24)
				local var_183_27 = var_183_25 <= 0 and var_183_21 or var_183_21 * (var_183_26 / var_183_25)

				if var_183_27 > 0 and var_183_21 < var_183_27 then
					arg_180_1.talkMaxDuration = var_183_27

					if var_183_27 + var_183_20 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_27 + var_183_20
					end
				end

				arg_180_1.text_.text = var_183_24
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082043", "story_v_out_417082.awb") ~= 0 then
					local var_183_28 = manager.audio:GetVoiceLength("story_v_out_417082", "417082043", "story_v_out_417082.awb") / 1000

					if var_183_28 + var_183_20 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_28 + var_183_20
					end

					if var_183_23.prefab_name ~= "" and arg_180_1.actors_[var_183_23.prefab_name] ~= nil then
						local var_183_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_23.prefab_name].transform, "story_v_out_417082", "417082043", "story_v_out_417082.awb")

						arg_180_1:RecordAudio("417082043", var_183_29)
						arg_180_1:RecordAudio("417082043", var_183_29)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417082", "417082043", "story_v_out_417082.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417082", "417082043", "story_v_out_417082.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_30 = math.max(var_183_21, arg_180_1.talkMaxDuration)

			if var_183_20 <= arg_180_1.time_ and arg_180_1.time_ < var_183_20 + var_183_30 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_20) / var_183_30

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_20 + var_183_30 and arg_180_1.time_ < var_183_20 + var_183_30 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417082044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417082044
		arg_184_1.duration_ = 5.43

		local var_184_0 = {
			zh = 3.6,
			ja = 5.433
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
				arg_184_0:Play417082045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10113"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10113 == nil then
				arg_184_1.var_.actorSpriteComps10113 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps10113 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps10113 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10113 = nil
			end

			local var_187_8 = arg_184_1.actors_["1028"]
			local var_187_9 = 0

			if var_187_9 < arg_184_1.time_ and arg_184_1.time_ <= var_187_9 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps1028 == nil then
				arg_184_1.var_.actorSpriteComps1028 = var_187_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_10 = 0.2

			if var_187_9 <= arg_184_1.time_ and arg_184_1.time_ < var_187_9 + var_187_10 and not isNil(var_187_8) then
				local var_187_11 = (arg_184_1.time_ - var_187_9) / var_187_10

				if arg_184_1.var_.actorSpriteComps1028 then
					for iter_187_4, iter_187_5 in pairs(arg_184_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_184_1.time_ >= var_187_9 + var_187_10 and arg_184_1.time_ < var_187_9 + var_187_10 + arg_187_0 and not isNil(var_187_8) and arg_184_1.var_.actorSpriteComps1028 then
				for iter_187_6, iter_187_7 in pairs(arg_184_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_187_7 then
						if arg_184_1.isInRecall_ then
							iter_187_7.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps1028 = nil
			end

			local var_187_16 = arg_184_1.actors_["10113"].transform
			local var_187_17 = 0

			if var_187_17 < arg_184_1.time_ and arg_184_1.time_ <= var_187_17 + arg_187_0 then
				arg_184_1.var_.moveOldPos10113 = var_187_16.localPosition
				var_187_16.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10113", 2)

				local var_187_18 = var_187_16.childCount

				for iter_187_8 = 0, var_187_18 - 1 do
					local var_187_19 = var_187_16:GetChild(iter_187_8)

					if var_187_19.name == "split_4" or not string.find(var_187_19.name, "split") then
						var_187_19.gameObject:SetActive(true)
					else
						var_187_19.gameObject:SetActive(false)
					end
				end
			end

			local var_187_20 = 0.001

			if var_187_17 <= arg_184_1.time_ and arg_184_1.time_ < var_187_17 + var_187_20 then
				local var_187_21 = (arg_184_1.time_ - var_187_17) / var_187_20
				local var_187_22 = Vector3.New(-403.26, -328.4, -517.4)

				var_187_16.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10113, var_187_22, var_187_21)
			end

			if arg_184_1.time_ >= var_187_17 + var_187_20 and arg_184_1.time_ < var_187_17 + var_187_20 + arg_187_0 then
				var_187_16.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_187_23 = 0
			local var_187_24 = 0.425

			if var_187_23 < arg_184_1.time_ and arg_184_1.time_ <= var_187_23 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_25 = arg_184_1:FormatText(StoryNameCfg[1117].name)

				arg_184_1.leftNameTxt_.text = var_187_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_26 = arg_184_1:GetWordFromCfg(417082044)
				local var_187_27 = arg_184_1:FormatText(var_187_26.content)

				arg_184_1.text_.text = var_187_27

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_28 = 17
				local var_187_29 = utf8.len(var_187_27)
				local var_187_30 = var_187_28 <= 0 and var_187_24 or var_187_24 * (var_187_29 / var_187_28)

				if var_187_30 > 0 and var_187_24 < var_187_30 then
					arg_184_1.talkMaxDuration = var_187_30

					if var_187_30 + var_187_23 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_30 + var_187_23
					end
				end

				arg_184_1.text_.text = var_187_27
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082044", "story_v_out_417082.awb") ~= 0 then
					local var_187_31 = manager.audio:GetVoiceLength("story_v_out_417082", "417082044", "story_v_out_417082.awb") / 1000

					if var_187_31 + var_187_23 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_31 + var_187_23
					end

					if var_187_26.prefab_name ~= "" and arg_184_1.actors_[var_187_26.prefab_name] ~= nil then
						local var_187_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_26.prefab_name].transform, "story_v_out_417082", "417082044", "story_v_out_417082.awb")

						arg_184_1:RecordAudio("417082044", var_187_32)
						arg_184_1:RecordAudio("417082044", var_187_32)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417082", "417082044", "story_v_out_417082.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417082", "417082044", "story_v_out_417082.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_33 = math.max(var_187_24, arg_184_1.talkMaxDuration)

			if var_187_23 <= arg_184_1.time_ and arg_184_1.time_ < var_187_23 + var_187_33 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_23) / var_187_33

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_23 + var_187_33 and arg_184_1.time_ < var_187_23 + var_187_33 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
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

		arg_184_1:InitPlayNodeList()
	end,
	Play417082045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417082045
		arg_188_1.duration_ = 5.5

		local var_188_0 = {
			zh = 3.233,
			ja = 5.5
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
				arg_188_0:Play417082046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1034"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps1034 == nil then
				arg_188_1.var_.actorSpriteComps1034 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps1034 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps1034 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1034 = nil
			end

			local var_191_8 = arg_188_1.actors_["10113"]
			local var_191_9 = 0

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps10113 == nil then
				arg_188_1.var_.actorSpriteComps10113 = var_191_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_10 = 0.2

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_10 and not isNil(var_191_8) then
				local var_191_11 = (arg_188_1.time_ - var_191_9) / var_191_10

				if arg_188_1.var_.actorSpriteComps10113 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_188_1.time_ >= var_191_9 + var_191_10 and arg_188_1.time_ < var_191_9 + var_191_10 + arg_191_0 and not isNil(var_191_8) and arg_188_1.var_.actorSpriteComps10113 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_191_7 then
						if arg_188_1.isInRecall_ then
							iter_191_7.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10113 = nil
			end

			local var_191_16 = arg_188_1.actors_["1034"].transform
			local var_191_17 = 0

			if var_191_17 < arg_188_1.time_ and arg_188_1.time_ <= var_191_17 + arg_191_0 then
				arg_188_1.var_.moveOldPos1034 = var_191_16.localPosition
				var_191_16.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1034", 4)

				local var_191_18 = var_191_16.childCount

				for iter_191_8 = 0, var_191_18 - 1 do
					local var_191_19 = var_191_16:GetChild(iter_191_8)

					if var_191_19.name == "split_6" or not string.find(var_191_19.name, "split") then
						var_191_19.gameObject:SetActive(true)
					else
						var_191_19.gameObject:SetActive(false)
					end
				end
			end

			local var_191_20 = 0.001

			if var_191_17 <= arg_188_1.time_ and arg_188_1.time_ < var_191_17 + var_191_20 then
				local var_191_21 = (arg_188_1.time_ - var_191_17) / var_191_20
				local var_191_22 = Vector3.New(373.7, -331.9, -324)

				var_191_16.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1034, var_191_22, var_191_21)
			end

			if arg_188_1.time_ >= var_191_17 + var_191_20 and arg_188_1.time_ < var_191_17 + var_191_20 + arg_191_0 then
				var_191_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_191_23 = arg_188_1.actors_["10113"].transform
			local var_191_24 = 0

			if var_191_24 < arg_188_1.time_ and arg_188_1.time_ <= var_191_24 + arg_191_0 then
				arg_188_1.var_.moveOldPos10113 = var_191_23.localPosition
				var_191_23.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10113", 2)

				local var_191_25 = var_191_23.childCount

				for iter_191_9 = 0, var_191_25 - 1 do
					local var_191_26 = var_191_23:GetChild(iter_191_9)

					if var_191_26.name == "split_6" or not string.find(var_191_26.name, "split") then
						var_191_26.gameObject:SetActive(true)
					else
						var_191_26.gameObject:SetActive(false)
					end
				end
			end

			local var_191_27 = 0.001

			if var_191_24 <= arg_188_1.time_ and arg_188_1.time_ < var_191_24 + var_191_27 then
				local var_191_28 = (arg_188_1.time_ - var_191_24) / var_191_27
				local var_191_29 = Vector3.New(-403.26, -328.4, -517.4)

				var_191_23.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10113, var_191_29, var_191_28)
			end

			if arg_188_1.time_ >= var_191_24 + var_191_27 and arg_188_1.time_ < var_191_24 + var_191_27 + arg_191_0 then
				var_191_23.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_191_30 = 0
			local var_191_31 = 0.375

			if var_191_30 < arg_188_1.time_ and arg_188_1.time_ <= var_191_30 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_32 = arg_188_1:FormatText(StoryNameCfg[1109].name)

				arg_188_1.leftNameTxt_.text = var_191_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_33 = arg_188_1:GetWordFromCfg(417082045)
				local var_191_34 = arg_188_1:FormatText(var_191_33.content)

				arg_188_1.text_.text = var_191_34

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_35 = 15
				local var_191_36 = utf8.len(var_191_34)
				local var_191_37 = var_191_35 <= 0 and var_191_31 or var_191_31 * (var_191_36 / var_191_35)

				if var_191_37 > 0 and var_191_31 < var_191_37 then
					arg_188_1.talkMaxDuration = var_191_37

					if var_191_37 + var_191_30 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_37 + var_191_30
					end
				end

				arg_188_1.text_.text = var_191_34
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082045", "story_v_out_417082.awb") ~= 0 then
					local var_191_38 = manager.audio:GetVoiceLength("story_v_out_417082", "417082045", "story_v_out_417082.awb") / 1000

					if var_191_38 + var_191_30 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_38 + var_191_30
					end

					if var_191_33.prefab_name ~= "" and arg_188_1.actors_[var_191_33.prefab_name] ~= nil then
						local var_191_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_33.prefab_name].transform, "story_v_out_417082", "417082045", "story_v_out_417082.awb")

						arg_188_1:RecordAudio("417082045", var_191_39)
						arg_188_1:RecordAudio("417082045", var_191_39)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417082", "417082045", "story_v_out_417082.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417082", "417082045", "story_v_out_417082.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_40 = math.max(var_191_31, arg_188_1.talkMaxDuration)

			if var_191_30 <= arg_188_1.time_ and arg_188_1.time_ < var_191_30 + var_191_40 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_30) / var_191_40

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_30 + var_191_40 and arg_188_1.time_ < var_191_30 + var_191_40 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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
				actorName = "10113",
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
	Play417082046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417082046
		arg_192_1.duration_ = 8.07

		local var_192_0 = {
			zh = 8.066,
			ja = 7.233
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
				arg_192_0:Play417082047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[1109].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(417082046)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 40
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082046", "story_v_out_417082.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082046", "story_v_out_417082.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_417082", "417082046", "story_v_out_417082.awb")

						arg_192_1:RecordAudio("417082046", var_195_9)
						arg_192_1:RecordAudio("417082046", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417082", "417082046", "story_v_out_417082.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417082", "417082046", "story_v_out_417082.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play417082047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417082047
		arg_196_1.duration_ = 7.6

		local var_196_0 = {
			zh = 4.733,
			ja = 7.6
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
				arg_196_0:Play417082048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1034"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1034 = var_199_0.localPosition
				var_199_0.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1034", 4)

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
				local var_199_6 = Vector3.New(373.7, -331.9, -324)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1034, var_199_6, var_199_5)
			end

			if arg_196_1.time_ >= var_199_1 + var_199_4 and arg_196_1.time_ < var_199_1 + var_199_4 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_199_7 = 0
			local var_199_8 = 0.625

			if var_199_7 < arg_196_1.time_ and arg_196_1.time_ <= var_199_7 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_9 = arg_196_1:FormatText(StoryNameCfg[1109].name)

				arg_196_1.leftNameTxt_.text = var_199_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_10 = arg_196_1:GetWordFromCfg(417082047)
				local var_199_11 = arg_196_1:FormatText(var_199_10.content)

				arg_196_1.text_.text = var_199_11

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_12 = 25
				local var_199_13 = utf8.len(var_199_11)
				local var_199_14 = var_199_12 <= 0 and var_199_8 or var_199_8 * (var_199_13 / var_199_12)

				if var_199_14 > 0 and var_199_8 < var_199_14 then
					arg_196_1.talkMaxDuration = var_199_14

					if var_199_14 + var_199_7 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_14 + var_199_7
					end
				end

				arg_196_1.text_.text = var_199_11
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082047", "story_v_out_417082.awb") ~= 0 then
					local var_199_15 = manager.audio:GetVoiceLength("story_v_out_417082", "417082047", "story_v_out_417082.awb") / 1000

					if var_199_15 + var_199_7 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_15 + var_199_7
					end

					if var_199_10.prefab_name ~= "" and arg_196_1.actors_[var_199_10.prefab_name] ~= nil then
						local var_199_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_10.prefab_name].transform, "story_v_out_417082", "417082047", "story_v_out_417082.awb")

						arg_196_1:RecordAudio("417082047", var_199_16)
						arg_196_1:RecordAudio("417082047", var_199_16)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417082", "417082047", "story_v_out_417082.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417082", "417082047", "story_v_out_417082.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_17 = math.max(var_199_8, arg_196_1.talkMaxDuration)

			if var_199_7 <= arg_196_1.time_ and arg_196_1.time_ < var_199_7 + var_199_17 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_7) / var_199_17

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_7 + var_199_17 and arg_196_1.time_ < var_199_7 + var_199_17 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
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

		arg_196_1:InitPlayNodeList()
	end,
	Play417082048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417082048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417082049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1034"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps1034 == nil then
				arg_200_1.var_.actorSpriteComps1034 = var_203_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_2 = 0.2

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.actorSpriteComps1034 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								local var_203_4 = Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor2.r, var_203_3)
								local var_203_5 = Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor2.g, var_203_3)
								local var_203_6 = Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor2.b, var_203_3)

								iter_203_1.color = Color.New(var_203_4, var_203_5, var_203_6)
							else
								local var_203_7 = Mathf.Lerp(iter_203_1.color.r, 0.5, var_203_3)

								iter_203_1.color = Color.New(var_203_7, var_203_7, var_203_7)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.actorSpriteComps1034 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_203_3 then
						if arg_200_1.isInRecall_ then
							iter_203_3.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps1034 = nil
			end

			local var_203_8 = arg_200_1.actors_["10113"].transform
			local var_203_9 = 0

			if var_203_9 < arg_200_1.time_ and arg_200_1.time_ <= var_203_9 + arg_203_0 then
				arg_200_1.var_.moveOldPos10113 = var_203_8.localPosition
				var_203_8.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10113", 7)

				local var_203_10 = var_203_8.childCount

				for iter_203_4 = 0, var_203_10 - 1 do
					local var_203_11 = var_203_8:GetChild(iter_203_4)

					if var_203_11.name == "split_4" or not string.find(var_203_11.name, "split") then
						var_203_11.gameObject:SetActive(true)
					else
						var_203_11.gameObject:SetActive(false)
					end
				end
			end

			local var_203_12 = 0.001

			if var_203_9 <= arg_200_1.time_ and arg_200_1.time_ < var_203_9 + var_203_12 then
				local var_203_13 = (arg_200_1.time_ - var_203_9) / var_203_12
				local var_203_14 = Vector3.New(0, -2000, 0)

				var_203_8.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10113, var_203_14, var_203_13)
			end

			if arg_200_1.time_ >= var_203_9 + var_203_12 and arg_200_1.time_ < var_203_9 + var_203_12 + arg_203_0 then
				var_203_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_15 = arg_200_1.actors_["1034"].transform
			local var_203_16 = 0

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 then
				arg_200_1.var_.moveOldPos1034 = var_203_15.localPosition
				var_203_15.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1034", 7)

				local var_203_17 = var_203_15.childCount

				for iter_203_5 = 0, var_203_17 - 1 do
					local var_203_18 = var_203_15:GetChild(iter_203_5)

					if var_203_18.name == "" or not string.find(var_203_18.name, "split") then
						var_203_18.gameObject:SetActive(true)
					else
						var_203_18.gameObject:SetActive(false)
					end
				end
			end

			local var_203_19 = 0.001

			if var_203_16 <= arg_200_1.time_ and arg_200_1.time_ < var_203_16 + var_203_19 then
				local var_203_20 = (arg_200_1.time_ - var_203_16) / var_203_19
				local var_203_21 = Vector3.New(0, -2000, 0)

				var_203_15.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1034, var_203_21, var_203_20)
			end

			if arg_200_1.time_ >= var_203_16 + var_203_19 and arg_200_1.time_ < var_203_16 + var_203_19 + arg_203_0 then
				var_203_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_203_22 = 0
			local var_203_23 = 1.275

			if var_203_22 < arg_200_1.time_ and arg_200_1.time_ <= var_203_22 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_24 = arg_200_1:GetWordFromCfg(417082048)
				local var_203_25 = arg_200_1:FormatText(var_203_24.content)

				arg_200_1.text_.text = var_203_25

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_26 = 51
				local var_203_27 = utf8.len(var_203_25)
				local var_203_28 = var_203_26 <= 0 and var_203_23 or var_203_23 * (var_203_27 / var_203_26)

				if var_203_28 > 0 and var_203_23 < var_203_28 then
					arg_200_1.talkMaxDuration = var_203_28

					if var_203_28 + var_203_22 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_28 + var_203_22
					end
				end

				arg_200_1.text_.text = var_203_25
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_29 = math.max(var_203_23, arg_200_1.talkMaxDuration)

			if var_203_22 <= arg_200_1.time_ and arg_200_1.time_ < var_203_22 + var_203_29 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_22) / var_203_29

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_22 + var_203_29 and arg_200_1.time_ < var_203_22 + var_203_29 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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

		arg_200_1:InitPlayNodeList()
	end,
	Play417082049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417082049
		arg_204_1.duration_ = 10.13

		local var_204_0 = {
			zh = 9,
			ja = 10.133
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
				arg_204_0:Play417082050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10113"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps10113 == nil then
				arg_204_1.var_.actorSpriteComps10113 = var_207_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_2 = 0.2

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.actorSpriteComps10113 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.actorSpriteComps10113 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_207_3 then
						if arg_204_1.isInRecall_ then
							iter_207_3.color = arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_207_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps10113 = nil
			end

			local var_207_8 = arg_204_1.actors_["10113"].transform
			local var_207_9 = 0

			if var_207_9 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 then
				arg_204_1.var_.moveOldPos10113 = var_207_8.localPosition
				var_207_8.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10113", 2)

				local var_207_10 = var_207_8.childCount

				for iter_207_4 = 0, var_207_10 - 1 do
					local var_207_11 = var_207_8:GetChild(iter_207_4)

					if var_207_11.name == "split_6" or not string.find(var_207_11.name, "split") then
						var_207_11.gameObject:SetActive(true)
					else
						var_207_11.gameObject:SetActive(false)
					end
				end
			end

			local var_207_12 = 0.001

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_12 then
				local var_207_13 = (arg_204_1.time_ - var_207_9) / var_207_12
				local var_207_14 = Vector3.New(-403.26, -328.4, -517.4)

				var_207_8.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10113, var_207_14, var_207_13)
			end

			if arg_204_1.time_ >= var_207_9 + var_207_12 and arg_204_1.time_ < var_207_9 + var_207_12 + arg_207_0 then
				var_207_8.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_207_15 = 0
			local var_207_16 = 1

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_17 = arg_204_1:FormatText(StoryNameCfg[1117].name)

				arg_204_1.leftNameTxt_.text = var_207_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_18 = arg_204_1:GetWordFromCfg(417082049)
				local var_207_19 = arg_204_1:FormatText(var_207_18.content)

				arg_204_1.text_.text = var_207_19

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_20 = 40
				local var_207_21 = utf8.len(var_207_19)
				local var_207_22 = var_207_20 <= 0 and var_207_16 or var_207_16 * (var_207_21 / var_207_20)

				if var_207_22 > 0 and var_207_16 < var_207_22 then
					arg_204_1.talkMaxDuration = var_207_22

					if var_207_22 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_22 + var_207_15
					end
				end

				arg_204_1.text_.text = var_207_19
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082049", "story_v_out_417082.awb") ~= 0 then
					local var_207_23 = manager.audio:GetVoiceLength("story_v_out_417082", "417082049", "story_v_out_417082.awb") / 1000

					if var_207_23 + var_207_15 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_23 + var_207_15
					end

					if var_207_18.prefab_name ~= "" and arg_204_1.actors_[var_207_18.prefab_name] ~= nil then
						local var_207_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_18.prefab_name].transform, "story_v_out_417082", "417082049", "story_v_out_417082.awb")

						arg_204_1:RecordAudio("417082049", var_207_24)
						arg_204_1:RecordAudio("417082049", var_207_24)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_417082", "417082049", "story_v_out_417082.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_417082", "417082049", "story_v_out_417082.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_25 = math.max(var_207_16, arg_204_1.talkMaxDuration)

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_25 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_15) / var_207_25

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_15 + var_207_25 and arg_204_1.time_ < var_207_15 + var_207_25 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play417082050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417082050
		arg_208_1.duration_ = 3.27

		local var_208_0 = {
			zh = 1.666,
			ja = 3.266
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
				arg_208_0:Play417082051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10113"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos10113 = var_211_0.localPosition
				var_211_0.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10113", 2)

				local var_211_2 = var_211_0.childCount

				for iter_211_0 = 0, var_211_2 - 1 do
					local var_211_3 = var_211_0:GetChild(iter_211_0)

					if var_211_3.name == "split_6" or not string.find(var_211_3.name, "split") then
						var_211_3.gameObject:SetActive(true)
					else
						var_211_3.gameObject:SetActive(false)
					end
				end
			end

			local var_211_4 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_4 then
				local var_211_5 = (arg_208_1.time_ - var_211_1) / var_211_4
				local var_211_6 = Vector3.New(-403.26, -328.4, -517.4)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10113, var_211_6, var_211_5)
			end

			if arg_208_1.time_ >= var_211_1 + var_211_4 and arg_208_1.time_ < var_211_1 + var_211_4 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(-403.26, -328.4, -517.4)
			end

			local var_211_7 = 0
			local var_211_8 = 0.25

			if var_211_7 < arg_208_1.time_ and arg_208_1.time_ <= var_211_7 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_9 = arg_208_1:FormatText(StoryNameCfg[1117].name)

				arg_208_1.leftNameTxt_.text = var_211_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_10 = arg_208_1:GetWordFromCfg(417082050)
				local var_211_11 = arg_208_1:FormatText(var_211_10.content)

				arg_208_1.text_.text = var_211_11

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_12 = 10
				local var_211_13 = utf8.len(var_211_11)
				local var_211_14 = var_211_12 <= 0 and var_211_8 or var_211_8 * (var_211_13 / var_211_12)

				if var_211_14 > 0 and var_211_8 < var_211_14 then
					arg_208_1.talkMaxDuration = var_211_14

					if var_211_14 + var_211_7 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_14 + var_211_7
					end
				end

				arg_208_1.text_.text = var_211_11
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082050", "story_v_out_417082.awb") ~= 0 then
					local var_211_15 = manager.audio:GetVoiceLength("story_v_out_417082", "417082050", "story_v_out_417082.awb") / 1000

					if var_211_15 + var_211_7 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_15 + var_211_7
					end

					if var_211_10.prefab_name ~= "" and arg_208_1.actors_[var_211_10.prefab_name] ~= nil then
						local var_211_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_10.prefab_name].transform, "story_v_out_417082", "417082050", "story_v_out_417082.awb")

						arg_208_1:RecordAudio("417082050", var_211_16)
						arg_208_1:RecordAudio("417082050", var_211_16)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_417082", "417082050", "story_v_out_417082.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_417082", "417082050", "story_v_out_417082.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_17 = math.max(var_211_8, arg_208_1.talkMaxDuration)

			if var_211_7 <= arg_208_1.time_ and arg_208_1.time_ < var_211_7 + var_211_17 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_7) / var_211_17

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_7 + var_211_17 and arg_208_1.time_ < var_211_7 + var_211_17 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
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

		arg_208_1:InitPlayNodeList()
	end,
	Play417082051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 417082051
		arg_212_1.duration_ = 6.13

		local var_212_0 = {
			zh = 3.1,
			ja = 6.133
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
				arg_212_0:Play417082052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1034"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps1034 == nil then
				arg_212_1.var_.actorSpriteComps1034 = var_215_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.actorSpriteComps1034 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								local var_215_4 = Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, var_215_3)
								local var_215_5 = Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, var_215_3)
								local var_215_6 = Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, var_215_3)

								iter_215_1.color = Color.New(var_215_4, var_215_5, var_215_6)
							else
								local var_215_7 = Mathf.Lerp(iter_215_1.color.r, 1, var_215_3)

								iter_215_1.color = Color.New(var_215_7, var_215_7, var_215_7)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps1034 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_215_3 then
						if arg_212_1.isInRecall_ then
							iter_215_3.color = arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_215_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps1034 = nil
			end

			local var_215_8 = arg_212_1.actors_["10113"]
			local var_215_9 = 0

			if var_215_9 < arg_212_1.time_ and arg_212_1.time_ <= var_215_9 + arg_215_0 and not isNil(var_215_8) and arg_212_1.var_.actorSpriteComps10113 == nil then
				arg_212_1.var_.actorSpriteComps10113 = var_215_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_10 = 0.2

			if var_215_9 <= arg_212_1.time_ and arg_212_1.time_ < var_215_9 + var_215_10 and not isNil(var_215_8) then
				local var_215_11 = (arg_212_1.time_ - var_215_9) / var_215_10

				if arg_212_1.var_.actorSpriteComps10113 then
					for iter_215_4, iter_215_5 in pairs(arg_212_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_215_5 then
							if arg_212_1.isInRecall_ then
								local var_215_12 = Mathf.Lerp(iter_215_5.color.r, arg_212_1.hightColor2.r, var_215_11)
								local var_215_13 = Mathf.Lerp(iter_215_5.color.g, arg_212_1.hightColor2.g, var_215_11)
								local var_215_14 = Mathf.Lerp(iter_215_5.color.b, arg_212_1.hightColor2.b, var_215_11)

								iter_215_5.color = Color.New(var_215_12, var_215_13, var_215_14)
							else
								local var_215_15 = Mathf.Lerp(iter_215_5.color.r, 0.5, var_215_11)

								iter_215_5.color = Color.New(var_215_15, var_215_15, var_215_15)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= var_215_9 + var_215_10 and arg_212_1.time_ < var_215_9 + var_215_10 + arg_215_0 and not isNil(var_215_8) and arg_212_1.var_.actorSpriteComps10113 then
				for iter_215_6, iter_215_7 in pairs(arg_212_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_215_7 then
						if arg_212_1.isInRecall_ then
							iter_215_7.color = arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_215_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps10113 = nil
			end

			local var_215_16 = arg_212_1.actors_["1034"].transform
			local var_215_17 = 0

			if var_215_17 < arg_212_1.time_ and arg_212_1.time_ <= var_215_17 + arg_215_0 then
				arg_212_1.var_.moveOldPos1034 = var_215_16.localPosition
				var_215_16.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("1034", 4)

				local var_215_18 = var_215_16.childCount

				for iter_215_8 = 0, var_215_18 - 1 do
					local var_215_19 = var_215_16:GetChild(iter_215_8)

					if var_215_19.name == "split_7" or not string.find(var_215_19.name, "split") then
						var_215_19.gameObject:SetActive(true)
					else
						var_215_19.gameObject:SetActive(false)
					end
				end
			end

			local var_215_20 = 0.001

			if var_215_17 <= arg_212_1.time_ and arg_212_1.time_ < var_215_17 + var_215_20 then
				local var_215_21 = (arg_212_1.time_ - var_215_17) / var_215_20
				local var_215_22 = Vector3.New(373.7, -331.9, -324)

				var_215_16.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1034, var_215_22, var_215_21)
			end

			if arg_212_1.time_ >= var_215_17 + var_215_20 and arg_212_1.time_ < var_215_17 + var_215_20 + arg_215_0 then
				var_215_16.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_215_23 = 0
			local var_215_24 = 0.375

			if var_215_23 < arg_212_1.time_ and arg_212_1.time_ <= var_215_23 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_25 = arg_212_1:FormatText(StoryNameCfg[1109].name)

				arg_212_1.leftNameTxt_.text = var_215_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_26 = arg_212_1:GetWordFromCfg(417082051)
				local var_215_27 = arg_212_1:FormatText(var_215_26.content)

				arg_212_1.text_.text = var_215_27

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_28 = 15
				local var_215_29 = utf8.len(var_215_27)
				local var_215_30 = var_215_28 <= 0 and var_215_24 or var_215_24 * (var_215_29 / var_215_28)

				if var_215_30 > 0 and var_215_24 < var_215_30 then
					arg_212_1.talkMaxDuration = var_215_30

					if var_215_30 + var_215_23 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_30 + var_215_23
					end
				end

				arg_212_1.text_.text = var_215_27
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082051", "story_v_out_417082.awb") ~= 0 then
					local var_215_31 = manager.audio:GetVoiceLength("story_v_out_417082", "417082051", "story_v_out_417082.awb") / 1000

					if var_215_31 + var_215_23 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_31 + var_215_23
					end

					if var_215_26.prefab_name ~= "" and arg_212_1.actors_[var_215_26.prefab_name] ~= nil then
						local var_215_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_26.prefab_name].transform, "story_v_out_417082", "417082051", "story_v_out_417082.awb")

						arg_212_1:RecordAudio("417082051", var_215_32)
						arg_212_1:RecordAudio("417082051", var_215_32)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_417082", "417082051", "story_v_out_417082.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_417082", "417082051", "story_v_out_417082.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_33 = math.max(var_215_24, arg_212_1.talkMaxDuration)

			if var_215_23 <= arg_212_1.time_ and arg_212_1.time_ < var_215_23 + var_215_33 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_23) / var_215_33

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_23 + var_215_33 and arg_212_1.time_ < var_215_23 + var_215_33 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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

		arg_212_1:InitPlayNodeList()
	end,
	Play417082052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 417082052
		arg_216_1.duration_ = 6.9

		local var_216_0 = {
			zh = 3.366,
			ja = 6.9
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
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play417082053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1034"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1034 = var_219_0.localPosition
				var_219_0.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1034", 4)

				local var_219_2 = var_219_0.childCount

				for iter_219_0 = 0, var_219_2 - 1 do
					local var_219_3 = var_219_0:GetChild(iter_219_0)

					if var_219_3.name == "" or not string.find(var_219_3.name, "split") then
						var_219_3.gameObject:SetActive(true)
					else
						var_219_3.gameObject:SetActive(false)
					end
				end
			end

			local var_219_4 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_4 then
				local var_219_5 = (arg_216_1.time_ - var_219_1) / var_219_4
				local var_219_6 = Vector3.New(373.7, -331.9, -324)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1034, var_219_6, var_219_5)
			end

			if arg_216_1.time_ >= var_219_1 + var_219_4 and arg_216_1.time_ < var_219_1 + var_219_4 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_219_7 = 0
			local var_219_8 = 0.4

			if var_219_7 < arg_216_1.time_ and arg_216_1.time_ <= var_219_7 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_9 = arg_216_1:FormatText(StoryNameCfg[1109].name)

				arg_216_1.leftNameTxt_.text = var_219_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_10 = arg_216_1:GetWordFromCfg(417082052)
				local var_219_11 = arg_216_1:FormatText(var_219_10.content)

				arg_216_1.text_.text = var_219_11

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_12 = 16
				local var_219_13 = utf8.len(var_219_11)
				local var_219_14 = var_219_12 <= 0 and var_219_8 or var_219_8 * (var_219_13 / var_219_12)

				if var_219_14 > 0 and var_219_8 < var_219_14 then
					arg_216_1.talkMaxDuration = var_219_14

					if var_219_14 + var_219_7 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_7
					end
				end

				arg_216_1.text_.text = var_219_11
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082052", "story_v_out_417082.awb") ~= 0 then
					local var_219_15 = manager.audio:GetVoiceLength("story_v_out_417082", "417082052", "story_v_out_417082.awb") / 1000

					if var_219_15 + var_219_7 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_7
					end

					if var_219_10.prefab_name ~= "" and arg_216_1.actors_[var_219_10.prefab_name] ~= nil then
						local var_219_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_10.prefab_name].transform, "story_v_out_417082", "417082052", "story_v_out_417082.awb")

						arg_216_1:RecordAudio("417082052", var_219_16)
						arg_216_1:RecordAudio("417082052", var_219_16)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_417082", "417082052", "story_v_out_417082.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_417082", "417082052", "story_v_out_417082.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_17 = math.max(var_219_8, arg_216_1.talkMaxDuration)

			if var_219_7 <= arg_216_1.time_ and arg_216_1.time_ < var_219_7 + var_219_17 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_7) / var_219_17

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_7 + var_219_17 and arg_216_1.time_ < var_219_7 + var_219_17 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	Play417082053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 417082053
		arg_220_1.duration_ = 7.43

		local var_220_0 = {
			zh = 6.833,
			ja = 7.433
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play417082054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1028"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps1028 == nil then
				arg_220_1.var_.actorSpriteComps1028 = var_223_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_2 = 0.2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.actorSpriteComps1028 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								local var_223_4 = Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor1.r, var_223_3)
								local var_223_5 = Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor1.g, var_223_3)
								local var_223_6 = Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor1.b, var_223_3)

								iter_223_1.color = Color.New(var_223_4, var_223_5, var_223_6)
							else
								local var_223_7 = Mathf.Lerp(iter_223_1.color.r, 1, var_223_3)

								iter_223_1.color = Color.New(var_223_7, var_223_7, var_223_7)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps1028 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_223_3 then
						if arg_220_1.isInRecall_ then
							iter_223_3.color = arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_223_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps1028 = nil
			end

			local var_223_8 = arg_220_1.actors_["1034"]
			local var_223_9 = 0

			if var_223_9 < arg_220_1.time_ and arg_220_1.time_ <= var_223_9 + arg_223_0 and not isNil(var_223_8) and arg_220_1.var_.actorSpriteComps1034 == nil then
				arg_220_1.var_.actorSpriteComps1034 = var_223_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_10 = 0.2

			if var_223_9 <= arg_220_1.time_ and arg_220_1.time_ < var_223_9 + var_223_10 and not isNil(var_223_8) then
				local var_223_11 = (arg_220_1.time_ - var_223_9) / var_223_10

				if arg_220_1.var_.actorSpriteComps1034 then
					for iter_223_4, iter_223_5 in pairs(arg_220_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_223_5 then
							if arg_220_1.isInRecall_ then
								local var_223_12 = Mathf.Lerp(iter_223_5.color.r, arg_220_1.hightColor2.r, var_223_11)
								local var_223_13 = Mathf.Lerp(iter_223_5.color.g, arg_220_1.hightColor2.g, var_223_11)
								local var_223_14 = Mathf.Lerp(iter_223_5.color.b, arg_220_1.hightColor2.b, var_223_11)

								iter_223_5.color = Color.New(var_223_12, var_223_13, var_223_14)
							else
								local var_223_15 = Mathf.Lerp(iter_223_5.color.r, 0.5, var_223_11)

								iter_223_5.color = Color.New(var_223_15, var_223_15, var_223_15)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_9 + var_223_10 and arg_220_1.time_ < var_223_9 + var_223_10 + arg_223_0 and not isNil(var_223_8) and arg_220_1.var_.actorSpriteComps1034 then
				for iter_223_6, iter_223_7 in pairs(arg_220_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_223_7 then
						if arg_220_1.isInRecall_ then
							iter_223_7.color = arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_223_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps1034 = nil
			end

			local var_223_16 = 0
			local var_223_17 = 0.875

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_18 = arg_220_1:FormatText(StoryNameCfg[595].name)

				arg_220_1.leftNameTxt_.text = var_223_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_19 = arg_220_1:GetWordFromCfg(417082053)
				local var_223_20 = arg_220_1:FormatText(var_223_19.content)

				arg_220_1.text_.text = var_223_20

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_21 = 35
				local var_223_22 = utf8.len(var_223_20)
				local var_223_23 = var_223_21 <= 0 and var_223_17 or var_223_17 * (var_223_22 / var_223_21)

				if var_223_23 > 0 and var_223_17 < var_223_23 then
					arg_220_1.talkMaxDuration = var_223_23

					if var_223_23 + var_223_16 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_23 + var_223_16
					end
				end

				arg_220_1.text_.text = var_223_20
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082053", "story_v_out_417082.awb") ~= 0 then
					local var_223_24 = manager.audio:GetVoiceLength("story_v_out_417082", "417082053", "story_v_out_417082.awb") / 1000

					if var_223_24 + var_223_16 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_24 + var_223_16
					end

					if var_223_19.prefab_name ~= "" and arg_220_1.actors_[var_223_19.prefab_name] ~= nil then
						local var_223_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_19.prefab_name].transform, "story_v_out_417082", "417082053", "story_v_out_417082.awb")

						arg_220_1:RecordAudio("417082053", var_223_25)
						arg_220_1:RecordAudio("417082053", var_223_25)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_417082", "417082053", "story_v_out_417082.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_417082", "417082053", "story_v_out_417082.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_26 = math.max(var_223_17, arg_220_1.talkMaxDuration)

			if var_223_16 <= arg_220_1.time_ and arg_220_1.time_ < var_223_16 + var_223_26 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_16) / var_223_26

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_16 + var_223_26 and arg_220_1.time_ < var_223_16 + var_223_26 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play417082054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 417082054
		arg_224_1.duration_ = 9.13

		local var_224_0 = {
			zh = 6.1,
			ja = 9.133
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play417082055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10113"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps10113 == nil then
				arg_224_1.var_.actorSpriteComps10113 = var_227_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.actorSpriteComps10113 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								local var_227_4 = Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, var_227_3)
								local var_227_5 = Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, var_227_3)
								local var_227_6 = Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, var_227_3)

								iter_227_1.color = Color.New(var_227_4, var_227_5, var_227_6)
							else
								local var_227_7 = Mathf.Lerp(iter_227_1.color.r, 1, var_227_3)

								iter_227_1.color = Color.New(var_227_7, var_227_7, var_227_7)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps10113 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_227_3 then
						if arg_224_1.isInRecall_ then
							iter_227_3.color = arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_227_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps10113 = nil
			end

			local var_227_8 = arg_224_1.actors_["1028"]
			local var_227_9 = 0

			if var_227_9 < arg_224_1.time_ and arg_224_1.time_ <= var_227_9 + arg_227_0 and not isNil(var_227_8) and arg_224_1.var_.actorSpriteComps1028 == nil then
				arg_224_1.var_.actorSpriteComps1028 = var_227_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_10 = 0.2

			if var_227_9 <= arg_224_1.time_ and arg_224_1.time_ < var_227_9 + var_227_10 and not isNil(var_227_8) then
				local var_227_11 = (arg_224_1.time_ - var_227_9) / var_227_10

				if arg_224_1.var_.actorSpriteComps1028 then
					for iter_227_4, iter_227_5 in pairs(arg_224_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_227_5 then
							if arg_224_1.isInRecall_ then
								local var_227_12 = Mathf.Lerp(iter_227_5.color.r, arg_224_1.hightColor2.r, var_227_11)
								local var_227_13 = Mathf.Lerp(iter_227_5.color.g, arg_224_1.hightColor2.g, var_227_11)
								local var_227_14 = Mathf.Lerp(iter_227_5.color.b, arg_224_1.hightColor2.b, var_227_11)

								iter_227_5.color = Color.New(var_227_12, var_227_13, var_227_14)
							else
								local var_227_15 = Mathf.Lerp(iter_227_5.color.r, 0.5, var_227_11)

								iter_227_5.color = Color.New(var_227_15, var_227_15, var_227_15)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_9 + var_227_10 and arg_224_1.time_ < var_227_9 + var_227_10 + arg_227_0 and not isNil(var_227_8) and arg_224_1.var_.actorSpriteComps1028 then
				for iter_227_6, iter_227_7 in pairs(arg_224_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_227_7 then
						if arg_224_1.isInRecall_ then
							iter_227_7.color = arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_227_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps1028 = nil
			end

			local var_227_16 = 0
			local var_227_17 = 0.8

			if var_227_16 < arg_224_1.time_ and arg_224_1.time_ <= var_227_16 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_18 = arg_224_1:FormatText(StoryNameCfg[1117].name)

				arg_224_1.leftNameTxt_.text = var_227_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_19 = arg_224_1:GetWordFromCfg(417082054)
				local var_227_20 = arg_224_1:FormatText(var_227_19.content)

				arg_224_1.text_.text = var_227_20

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_21 = 32
				local var_227_22 = utf8.len(var_227_20)
				local var_227_23 = var_227_21 <= 0 and var_227_17 or var_227_17 * (var_227_22 / var_227_21)

				if var_227_23 > 0 and var_227_17 < var_227_23 then
					arg_224_1.talkMaxDuration = var_227_23

					if var_227_23 + var_227_16 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_23 + var_227_16
					end
				end

				arg_224_1.text_.text = var_227_20
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082054", "story_v_out_417082.awb") ~= 0 then
					local var_227_24 = manager.audio:GetVoiceLength("story_v_out_417082", "417082054", "story_v_out_417082.awb") / 1000

					if var_227_24 + var_227_16 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_24 + var_227_16
					end

					if var_227_19.prefab_name ~= "" and arg_224_1.actors_[var_227_19.prefab_name] ~= nil then
						local var_227_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_19.prefab_name].transform, "story_v_out_417082", "417082054", "story_v_out_417082.awb")

						arg_224_1:RecordAudio("417082054", var_227_25)
						arg_224_1:RecordAudio("417082054", var_227_25)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_417082", "417082054", "story_v_out_417082.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_417082", "417082054", "story_v_out_417082.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_26 = math.max(var_227_17, arg_224_1.talkMaxDuration)

			if var_227_16 <= arg_224_1.time_ and arg_224_1.time_ < var_227_16 + var_227_26 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_16) / var_227_26

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_16 + var_227_26 and arg_224_1.time_ < var_227_16 + var_227_26 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play417082055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 417082055
		arg_228_1.duration_ = 9.67

		local var_228_0 = {
			zh = 5.6,
			ja = 9.666
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
			arg_228_1.auto_ = false
		end

		function arg_228_1.playNext_(arg_230_0)
			arg_228_1.onStoryFinished_()
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0
			local var_231_1 = 0.725

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[1117].name)

				arg_228_1.leftNameTxt_.text = var_231_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_3 = arg_228_1:GetWordFromCfg(417082055)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 29
				local var_231_6 = utf8.len(var_231_4)
				local var_231_7 = var_231_5 <= 0 and var_231_1 or var_231_1 * (var_231_6 / var_231_5)

				if var_231_7 > 0 and var_231_1 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417082", "417082055", "story_v_out_417082.awb") ~= 0 then
					local var_231_8 = manager.audio:GetVoiceLength("story_v_out_417082", "417082055", "story_v_out_417082.awb") / 1000

					if var_231_8 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_8 + var_231_0
					end

					if var_231_3.prefab_name ~= "" and arg_228_1.actors_[var_231_3.prefab_name] ~= nil then
						local var_231_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_3.prefab_name].transform, "story_v_out_417082", "417082055", "story_v_out_417082.awb")

						arg_228_1:RecordAudio("417082055", var_231_9)
						arg_228_1:RecordAudio("417082055", var_231_9)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_417082", "417082055", "story_v_out_417082.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_417082", "417082055", "story_v_out_417082.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_10 and arg_228_1.time_ < var_231_0 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D06a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_417082.awb"
	}
}
