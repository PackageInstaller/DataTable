return {
	Play417171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417171001
		arg_1_1.duration_ = 9.83

		local var_1_0 = {
			zh = 9.166,
			ja = 9.833
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
				arg_1_0:Play417171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 7.4

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.0666666666666667

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = 0
			local var_4_3 = 5
			local var_4_4 = "I16h"

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_4)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_5 = arg_1_1:GetWordFromCfg(501053)
				local var_4_6 = arg_1_1:FormatText(var_4_5.content)

				arg_1_1.text_timeText_.text = var_4_6

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_7 = arg_1_1:GetWordFromCfg(501054)
				local var_4_8 = arg_1_1:FormatText(var_4_7.content)

				arg_1_1.text_siteText_.text = var_4_8

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_2 + var_4_3 and arg_1_1.time_ < var_4_2 + var_4_3 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_9 = 5

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_10 = 1.2

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				local var_4_11 = (arg_1_1.time_ - var_4_9) / var_4_10
				local var_4_12 = Color.New(0, 0, 0)

				var_4_12.a = Mathf.Lerp(0, 1, var_4_11)
				arg_1_1.mask_.color = var_4_12
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = 1
				arg_1_1.mask_.color = var_4_13
			end

			local var_4_14 = 6.2

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 1.2

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_14) / var_4_15
				local var_4_17 = Color.New(0, 0, 0)

				var_4_17.a = Mathf.Lerp(1, 0, var_4_16)
				arg_1_1.mask_.color = var_4_17
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_18 = Color.New(0, 0, 0)
				local var_4_19 = 0

				arg_1_1.mask_.enabled = false
				var_4_18.a = var_4_19
				arg_1_1.mask_.color = var_4_18
			end

			local var_4_20 = "I16h"

			if arg_1_1.bgs_[var_4_20] == nil then
				local var_4_21 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_20)
				var_4_21.name = var_4_20
				var_4_21.transform.parent = arg_1_1.stage_.transform
				var_4_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_20] = var_4_21
			end

			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = manager.ui.mainCamera.transform.localPosition
				local var_4_24 = Vector3.New(0, 0, 10) + Vector3.New(var_4_23.x, var_4_23.y, 0)
				local var_4_25 = arg_1_1.bgs_.I16h

				var_4_25.transform.localPosition = var_4_24
				var_4_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_26 = var_4_25:GetComponent("SpriteRenderer")

				if var_4_26 and var_4_26.sprite then
					local var_4_27 = (var_4_25.transform.localPosition - var_4_23).z
					local var_4_28 = manager.ui.mainCameraCom_
					local var_4_29 = 2 * var_4_27 * Mathf.Tan(var_4_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_30 = var_4_29 * var_4_28.aspect
					local var_4_31 = var_4_26.sprite.bounds.size.x
					local var_4_32 = var_4_26.sprite.bounds.size.y
					local var_4_33 = var_4_30 / var_4_31
					local var_4_34 = var_4_29 / var_4_32
					local var_4_35 = var_4_34 < var_4_33 and var_4_33 or var_4_34

					var_4_25.transform.localScale = Vector3.New(var_4_35, var_4_35, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I16h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_36 = "10128"

			if arg_1_1.actors_[var_4_36] == nil then
				local var_4_37 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_4_37) then
					local var_4_38 = Object.Instantiate(var_4_37, arg_1_1.canvasGo_.transform)

					var_4_38.transform:SetSiblingIndex(1)

					var_4_38.name = var_4_36
					var_4_38.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_36] = var_4_38

					local var_4_39 = var_4_38:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_39) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_40 = arg_1_1.actors_["10128"]
			local var_4_41 = 7.06666666666667

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_42 = var_4_40:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_42 then
					arg_1_1.var_.alphaOldValue10128 = var_4_42.alpha
					arg_1_1.var_.characterEffect10128 = var_4_42
				end

				arg_1_1.var_.alphaOldValue10128 = 0
			end

			local var_4_43 = 0.333333333333333

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_43 then
				local var_4_44 = (arg_1_1.time_ - var_4_41) / var_4_43
				local var_4_45 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10128, 1, var_4_44)

				if arg_1_1.var_.characterEffect10128 then
					arg_1_1.var_.characterEffect10128.alpha = var_4_45
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_43 and arg_1_1.time_ < var_4_41 + var_4_43 + arg_4_0 and arg_1_1.var_.characterEffect10128 then
				arg_1_1.var_.characterEffect10128.alpha = 1
			end

			local var_4_46 = arg_1_1.actors_["10128"]
			local var_4_47 = 7.06666666666667

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 and not isNil(var_4_46) and arg_1_1.var_.actorSpriteComps10128 == nil then
				arg_1_1.var_.actorSpriteComps10128 = var_4_46:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_48 = 0.2

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 and not isNil(var_4_46) then
				local var_4_49 = (arg_1_1.time_ - var_4_47) / var_4_48

				if arg_1_1.var_.actorSpriteComps10128 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_50 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_49)
								local var_4_51 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_49)
								local var_4_52 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_49)

								iter_4_5.color = Color.New(var_4_50, var_4_51, var_4_52)
							else
								local var_4_53 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_49)

								iter_4_5.color = Color.New(var_4_53, var_4_53, var_4_53)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 and not isNil(var_4_46) and arg_1_1.var_.actorSpriteComps10128 then
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

			local var_4_54 = arg_1_1.actors_["10128"].transform
			local var_4_55 = 7.06666666666667

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				arg_1_1.var_.moveOldPos10128 = var_4_54.localPosition
				var_4_54.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10128", 3)

				local var_4_56 = var_4_54.childCount

				for iter_4_8 = 0, var_4_56 - 1 do
					local var_4_57 = var_4_54:GetChild(iter_4_8)

					if var_4_57.name == "" or not string.find(var_4_57.name, "split") then
						var_4_57.gameObject:SetActive(true)
					else
						var_4_57.gameObject:SetActive(false)
					end
				end
			end

			local var_4_58 = 0.001

			if var_4_55 <= arg_1_1.time_ and arg_1_1.time_ < var_4_55 + var_4_58 then
				local var_4_59 = (arg_1_1.time_ - var_4_55) / var_4_58
				local var_4_60 = Vector3.New(0, -347, -300)

				var_4_54.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10128, var_4_60, var_4_59)
			end

			if arg_1_1.time_ >= var_4_55 + var_4_58 and arg_1_1.time_ < var_4_55 + var_4_58 + arg_4_0 then
				var_4_54.localPosition = Vector3.New(0, -347, -300)
			end

			local var_4_61 = 0

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_62 = 1

			if var_4_61 <= arg_1_1.time_ and arg_1_1.time_ < var_4_61 + var_4_62 then
				local var_4_63 = (arg_1_1.time_ - var_4_61) / var_4_62
				local var_4_64 = Color.New(0, 0, 0)

				var_4_64.a = Mathf.Lerp(1, 0, var_4_63)
				arg_1_1.mask_.color = var_4_64
			end

			if arg_1_1.time_ >= var_4_61 + var_4_62 and arg_1_1.time_ < var_4_61 + var_4_62 + arg_4_0 then
				local var_4_65 = Color.New(0, 0, 0)
				local var_4_66 = 0

				arg_1_1.mask_.enabled = false
				var_4_65.a = var_4_66
				arg_1_1.mask_.color = var_4_65
			end

			local var_4_67 = 0
			local var_4_68 = 0.2

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				local var_4_69 = "play"
				local var_4_70 = "music"

				arg_1_1:AudioAction(var_4_69, var_4_70, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_71 = ""
				local var_4_72 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_72 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_72 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_72

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_72
						arg_1_1.bgmTxt2_.text = var_4_72
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

			local var_4_73 = 5.4
			local var_4_74 = 1

			if var_4_73 < arg_1_1.time_ and arg_1_1.time_ <= var_4_73 + arg_4_0 then
				local var_4_75 = "play"
				local var_4_76 = "music"

				arg_1_1:AudioAction(var_4_75, var_4_76, "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_77 = ""
				local var_4_78 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if var_4_78 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_78 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_78

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_78
						arg_1_1.bgmTxt2_.text = var_4_78
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

			local var_4_79 = 7.4
			local var_4_80 = 0.15

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

				local var_4_83 = arg_1_1:GetWordFromCfg(417171001)
				local var_4_84 = arg_1_1:FormatText(var_4_83.content)

				arg_1_1.text_.text = var_4_84

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_85 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171001", "story_v_out_417171.awb") ~= 0 then
					local var_4_88 = manager.audio:GetVoiceLength("story_v_out_417171", "417171001", "story_v_out_417171.awb") / 1000

					if var_4_88 + var_4_79 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_88 + var_4_79
					end

					if var_4_83.prefab_name ~= "" and arg_1_1.actors_[var_4_83.prefab_name] ~= nil then
						local var_4_89 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_83.prefab_name].transform, "story_v_out_417171", "417171001", "story_v_out_417171.awb")

						arg_1_1:RecordAudio("417171001", var_4_89)
						arg_1_1:RecordAudio("417171001", var_4_89)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417171", "417171001", "story_v_out_417171.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417171", "417171001", "story_v_out_417171.awb")
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
				startTime = 7.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play417171002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417171002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417171003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["10128"].transform
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.moveOldPos10128 = var_13_0.localPosition
				var_13_0.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("10128", 7)

				local var_13_2 = var_13_0.childCount

				for iter_13_0 = 0, var_13_2 - 1 do
					local var_13_3 = var_13_0:GetChild(iter_13_0)

					if var_13_3.name == "" or not string.find(var_13_3.name, "split") then
						var_13_3.gameObject:SetActive(true)
					else
						var_13_3.gameObject:SetActive(false)
					end
				end
			end

			local var_13_4 = 0.001

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_4 then
				local var_13_5 = (arg_10_1.time_ - var_13_1) / var_13_4
				local var_13_6 = Vector3.New(0, -2000, -300)

				var_13_0.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10128, var_13_6, var_13_5)
			end

			if arg_10_1.time_ >= var_13_1 + var_13_4 and arg_10_1.time_ < var_13_1 + var_13_4 + arg_13_0 then
				var_13_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_13_7 = 0
			local var_13_8 = 1.325

			if var_13_7 < arg_10_1.time_ and arg_10_1.time_ <= var_13_7 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_9 = arg_10_1:GetWordFromCfg(417171002)
				local var_13_10 = arg_10_1:FormatText(var_13_9.content)

				arg_10_1.text_.text = var_13_10

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_11 = 53
				local var_13_12 = utf8.len(var_13_10)
				local var_13_13 = var_13_11 <= 0 and var_13_8 or var_13_8 * (var_13_12 / var_13_11)

				if var_13_13 > 0 and var_13_8 < var_13_13 then
					arg_10_1.talkMaxDuration = var_13_13

					if var_13_13 + var_13_7 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_13 + var_13_7
					end
				end

				arg_10_1.text_.text = var_13_10
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_14 = math.max(var_13_8, arg_10_1.talkMaxDuration)

			if var_13_7 <= arg_10_1.time_ and arg_10_1.time_ < var_13_7 + var_13_14 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_7) / var_13_14

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_7 + var_13_14 and arg_10_1.time_ < var_13_7 + var_13_14 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
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

		arg_10_1:InitPlayNodeList()
	end,
	Play417171003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417171003
		arg_14_1.duration_ = 5.05

		local var_14_0 = {
			zh = 5.05,
			ja = 4.15
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
				arg_14_0:Play417171004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_1 = 0.5

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_1 then
				local var_17_2 = (arg_14_1.time_ - var_17_0) / var_17_1
				local var_17_3 = Color.New(0, 0, 0)

				var_17_3.a = Mathf.Lerp(0, 1, var_17_2)
				arg_14_1.mask_.color = var_17_3
			end

			if arg_14_1.time_ >= var_17_0 + var_17_1 and arg_14_1.time_ < var_17_0 + var_17_1 + arg_17_0 then
				local var_17_4 = Color.New(0, 0, 0)

				var_17_4.a = 1
				arg_14_1.mask_.color = var_17_4
			end

			local var_17_5 = 0.5

			if var_17_5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_6 = 0.849999999999

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_6 then
				local var_17_7 = (arg_14_1.time_ - var_17_5) / var_17_6
				local var_17_8 = Color.New(0, 0, 0)

				var_17_8.a = Mathf.Lerp(1, 0, var_17_7)
				arg_14_1.mask_.color = var_17_8
			end

			if arg_14_1.time_ >= var_17_5 + var_17_6 and arg_14_1.time_ < var_17_5 + var_17_6 + arg_17_0 then
				local var_17_9 = Color.New(0, 0, 0)
				local var_17_10 = 0

				arg_14_1.mask_.enabled = false
				var_17_9.a = var_17_10
				arg_14_1.mask_.color = var_17_9
			end

			local var_17_11 = 0.5

			if var_17_11 < arg_14_1.time_ and arg_14_1.time_ <= var_17_11 + arg_17_0 then
				local var_17_12 = manager.ui.mainCamera.transform.localPosition
				local var_17_13 = Vector3.New(0, 0, 10) + Vector3.New(var_17_12.x, var_17_12.y, 0)
				local var_17_14 = arg_14_1.bgs_.I16h

				var_17_14.transform.localPosition = var_17_13
				var_17_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_15 = var_17_14:GetComponent("SpriteRenderer")

				if var_17_15 and var_17_15.sprite then
					local var_17_16 = (var_17_14.transform.localPosition - var_17_12).z
					local var_17_17 = manager.ui.mainCameraCom_
					local var_17_18 = 2 * var_17_16 * Mathf.Tan(var_17_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_17_19 = var_17_18 * var_17_17.aspect
					local var_17_20 = var_17_15.sprite.bounds.size.x
					local var_17_21 = var_17_15.sprite.bounds.size.y
					local var_17_22 = var_17_19 / var_17_20
					local var_17_23 = var_17_18 / var_17_21
					local var_17_24 = var_17_23 < var_17_22 and var_17_22 or var_17_23

					var_17_14.transform.localScale = Vector3.New(var_17_24, var_17_24, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "I16h" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_25 = 0.5

			arg_14_1.isInRecall_ = true

			if var_17_25 < arg_14_1.time_ and arg_14_1.time_ <= var_17_25 + arg_17_0 then
				arg_14_1.screenFilterGo_:SetActive(true)

				arg_14_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_14_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_14_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_17_2, iter_17_3 in pairs(arg_14_1.actors_) do
					local var_17_26 = iter_17_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_17_4, iter_17_5 in ipairs(var_17_26) do
						if iter_17_5.color.r > 0.51 then
							iter_17_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_17_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_17_27 = 0.0333333333333333

			if var_17_25 <= arg_14_1.time_ and arg_14_1.time_ < var_17_25 + var_17_27 then
				local var_17_28 = (arg_14_1.time_ - var_17_25) / var_17_27

				arg_14_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_17_28)
			end

			if arg_14_1.time_ >= var_17_25 + var_17_27 and arg_14_1.time_ < var_17_25 + var_17_27 + arg_17_0 then
				arg_14_1.screenFilterEffect_.weight = 1
			end

			local var_17_29 = 1.35

			if var_17_29 < arg_14_1.time_ and arg_14_1.time_ <= var_17_29 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			local var_17_30 = 0.216666666666666

			if arg_14_1.time_ >= var_17_29 + var_17_30 and arg_14_1.time_ < var_17_29 + var_17_30 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			if arg_14_1.frameCnt_ <= 1 then
				arg_14_1.dialog_:SetActive(false)
			end

			local var_17_31 = 1.35
			local var_17_32 = 0.35

			if var_17_31 < arg_14_1.time_ and arg_14_1.time_ <= var_17_31 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_33 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_33:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_14_1.dialogCg_.alpha = arg_18_0
				end))
				var_17_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_34 = arg_14_1:FormatText(StoryNameCfg[468].name)

				arg_14_1.leftNameTxt_.text = var_17_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_14_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_17_35 = arg_14_1:GetWordFromCfg(417171003)
				local var_17_36 = arg_14_1:FormatText(var_17_35.content)

				arg_14_1.text_.text = var_17_36

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_37 = 14
				local var_17_38 = utf8.len(var_17_36)
				local var_17_39 = var_17_37 <= 0 and var_17_32 or var_17_32 * (var_17_38 / var_17_37)

				if var_17_39 > 0 and var_17_32 < var_17_39 then
					arg_14_1.talkMaxDuration = var_17_39
					var_17_31 = var_17_31 + 0.3

					if var_17_39 + var_17_31 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_39 + var_17_31
					end
				end

				arg_14_1.text_.text = var_17_36
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171003", "story_v_out_417171.awb") ~= 0 then
					local var_17_40 = manager.audio:GetVoiceLength("story_v_out_417171", "417171003", "story_v_out_417171.awb") / 1000

					if var_17_40 + var_17_31 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_40 + var_17_31
					end

					if var_17_35.prefab_name ~= "" and arg_14_1.actors_[var_17_35.prefab_name] ~= nil then
						local var_17_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_35.prefab_name].transform, "story_v_out_417171", "417171003", "story_v_out_417171.awb")

						arg_14_1:RecordAudio("417171003", var_17_41)
						arg_14_1:RecordAudio("417171003", var_17_41)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417171", "417171003", "story_v_out_417171.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417171", "417171003", "story_v_out_417171.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_42 = var_17_31 + 0.3
			local var_17_43 = math.max(var_17_32, arg_14_1.talkMaxDuration)

			if var_17_42 <= arg_14_1.time_ and arg_14_1.time_ < var_17_42 + var_17_43 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_42) / var_17_43

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_42 + var_17_43 and arg_14_1.time_ < var_17_42 + var_17_43 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417171004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 417171004
		arg_20_1.duration_ = 10.1

		local var_20_0 = {
			zh = 8.433,
			ja = 10.1
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play417171005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.775

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[468].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_20_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_23_3 = arg_20_1:GetWordFromCfg(417171004)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 31
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171004", "story_v_out_417171.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171004", "story_v_out_417171.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_417171", "417171004", "story_v_out_417171.awb")

						arg_20_1:RecordAudio("417171004", var_23_9)
						arg_20_1:RecordAudio("417171004", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_417171", "417171004", "story_v_out_417171.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_417171", "417171004", "story_v_out_417171.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play417171005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 417171005
		arg_24_1.duration_ = 5.5

		local var_24_0 = {
			zh = 4.766,
			ja = 5.5
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play417171006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_1 = 0.5

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_1 then
				local var_27_2 = (arg_24_1.time_ - var_27_0) / var_27_1
				local var_27_3 = Color.New(0, 0, 0)

				var_27_3.a = Mathf.Lerp(0, 1, var_27_2)
				arg_24_1.mask_.color = var_27_3
			end

			if arg_24_1.time_ >= var_27_0 + var_27_1 and arg_24_1.time_ < var_27_0 + var_27_1 + arg_27_0 then
				local var_27_4 = Color.New(0, 0, 0)

				var_27_4.a = 1
				arg_24_1.mask_.color = var_27_4
			end

			local var_27_5 = 0.5

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_6 = 0.9

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6
				local var_27_8 = Color.New(0, 0, 0)

				var_27_8.a = Mathf.Lerp(1, 0, var_27_7)
				arg_24_1.mask_.color = var_27_8
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 then
				local var_27_9 = Color.New(0, 0, 0)
				local var_27_10 = 0

				arg_24_1.mask_.enabled = false
				var_27_9.a = var_27_10
				arg_24_1.mask_.color = var_27_9
			end

			local var_27_11 = 0.5

			if var_27_11 < arg_24_1.time_ and arg_24_1.time_ <= var_27_11 + arg_27_0 then
				local var_27_12 = manager.ui.mainCamera.transform.localPosition
				local var_27_13 = Vector3.New(0, 0, 10) + Vector3.New(var_27_12.x, var_27_12.y, 0)
				local var_27_14 = arg_24_1.bgs_.I16h

				var_27_14.transform.localPosition = var_27_13
				var_27_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_15 = var_27_14:GetComponent("SpriteRenderer")

				if var_27_15 and var_27_15.sprite then
					local var_27_16 = (var_27_14.transform.localPosition - var_27_12).z
					local var_27_17 = manager.ui.mainCameraCom_
					local var_27_18 = 2 * var_27_16 * Mathf.Tan(var_27_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_27_19 = var_27_18 * var_27_17.aspect
					local var_27_20 = var_27_15.sprite.bounds.size.x
					local var_27_21 = var_27_15.sprite.bounds.size.y
					local var_27_22 = var_27_19 / var_27_20
					local var_27_23 = var_27_18 / var_27_21
					local var_27_24 = var_27_23 < var_27_22 and var_27_22 or var_27_23

					var_27_14.transform.localScale = Vector3.New(var_27_24, var_27_24, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "I16h" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_25 = 0.483333333333333

			arg_24_1.isInRecall_ = false

			if var_27_25 < arg_24_1.time_ and arg_24_1.time_ <= var_27_25 + arg_27_0 then
				arg_24_1.screenFilterGo_:SetActive(false)

				for iter_27_2, iter_27_3 in pairs(arg_24_1.actors_) do
					local var_27_26 = iter_27_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_27_4, iter_27_5 in ipairs(var_27_26) do
						if iter_27_5.color.r > 0.51 then
							iter_27_5.color = Color.New(1, 1, 1)
						else
							iter_27_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_27_27 = 0.0166666666666667

			if var_27_25 <= arg_24_1.time_ and arg_24_1.time_ < var_27_25 + var_27_27 then
				local var_27_28 = (arg_24_1.time_ - var_27_25) / var_27_27

				arg_24_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_27_28)
			end

			if arg_24_1.time_ >= var_27_25 + var_27_27 and arg_24_1.time_ < var_27_25 + var_27_27 + arg_27_0 then
				arg_24_1.screenFilterEffect_.weight = 0
			end

			local var_27_29 = arg_24_1.actors_["10128"]
			local var_27_30 = 1.2

			if var_27_30 < arg_24_1.time_ and arg_24_1.time_ <= var_27_30 + arg_27_0 and not isNil(var_27_29) and arg_24_1.var_.actorSpriteComps10128 == nil then
				arg_24_1.var_.actorSpriteComps10128 = var_27_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_31 = 0.2

			if var_27_30 <= arg_24_1.time_ and arg_24_1.time_ < var_27_30 + var_27_31 and not isNil(var_27_29) then
				local var_27_32 = (arg_24_1.time_ - var_27_30) / var_27_31

				if arg_24_1.var_.actorSpriteComps10128 then
					for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_27_7 then
							if arg_24_1.isInRecall_ then
								local var_27_33 = Mathf.Lerp(iter_27_7.color.r, arg_24_1.hightColor1.r, var_27_32)
								local var_27_34 = Mathf.Lerp(iter_27_7.color.g, arg_24_1.hightColor1.g, var_27_32)
								local var_27_35 = Mathf.Lerp(iter_27_7.color.b, arg_24_1.hightColor1.b, var_27_32)

								iter_27_7.color = Color.New(var_27_33, var_27_34, var_27_35)
							else
								local var_27_36 = Mathf.Lerp(iter_27_7.color.r, 1, var_27_32)

								iter_27_7.color = Color.New(var_27_36, var_27_36, var_27_36)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= var_27_30 + var_27_31 and arg_24_1.time_ < var_27_30 + var_27_31 + arg_27_0 and not isNil(var_27_29) and arg_24_1.var_.actorSpriteComps10128 then
				for iter_27_8, iter_27_9 in pairs(arg_24_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_27_9 then
						if arg_24_1.isInRecall_ then
							iter_27_9.color = arg_24_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_27_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_24_1.var_.actorSpriteComps10128 = nil
			end

			local var_27_37 = arg_24_1.actors_["10128"].transform
			local var_27_38 = 1.2

			if var_27_38 < arg_24_1.time_ and arg_24_1.time_ <= var_27_38 + arg_27_0 then
				arg_24_1.var_.moveOldPos10128 = var_27_37.localPosition
				var_27_37.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10128", 3)

				local var_27_39 = var_27_37.childCount

				for iter_27_10 = 0, var_27_39 - 1 do
					local var_27_40 = var_27_37:GetChild(iter_27_10)

					if var_27_40.name == "" or not string.find(var_27_40.name, "split") then
						var_27_40.gameObject:SetActive(true)
					else
						var_27_40.gameObject:SetActive(false)
					end
				end
			end

			local var_27_41 = 0.001

			if var_27_38 <= arg_24_1.time_ and arg_24_1.time_ < var_27_38 + var_27_41 then
				local var_27_42 = (arg_24_1.time_ - var_27_38) / var_27_41
				local var_27_43 = Vector3.New(0, -347, -300)

				var_27_37.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10128, var_27_43, var_27_42)
			end

			if arg_24_1.time_ >= var_27_38 + var_27_41 and arg_24_1.time_ < var_27_38 + var_27_41 + arg_27_0 then
				var_27_37.localPosition = Vector3.New(0, -347, -300)
			end

			local var_27_44 = arg_24_1.actors_["10128"]
			local var_27_45 = 1.2

			if var_27_45 < arg_24_1.time_ and arg_24_1.time_ <= var_27_45 + arg_27_0 then
				local var_27_46 = var_27_44:GetComponentInChildren(typeof(CanvasGroup))

				if var_27_46 then
					arg_24_1.var_.alphaOldValue10128 = var_27_46.alpha
					arg_24_1.var_.characterEffect10128 = var_27_46
				end

				arg_24_1.var_.alphaOldValue10128 = 0
			end

			local var_27_47 = 0.2

			if var_27_45 <= arg_24_1.time_ and arg_24_1.time_ < var_27_45 + var_27_47 then
				local var_27_48 = (arg_24_1.time_ - var_27_45) / var_27_47
				local var_27_49 = Mathf.Lerp(arg_24_1.var_.alphaOldValue10128, 1, var_27_48)

				if arg_24_1.var_.characterEffect10128 then
					arg_24_1.var_.characterEffect10128.alpha = var_27_49
				end
			end

			if arg_24_1.time_ >= var_27_45 + var_27_47 and arg_24_1.time_ < var_27_45 + var_27_47 + arg_27_0 and arg_24_1.var_.characterEffect10128 then
				arg_24_1.var_.characterEffect10128.alpha = 1
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_50 = 1.4
			local var_27_51 = 0.4

			if var_27_50 < arg_24_1.time_ and arg_24_1.time_ <= var_27_50 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_52 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_52:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_53 = arg_24_1:FormatText(StoryNameCfg[595].name)

				arg_24_1.leftNameTxt_.text = var_27_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_54 = arg_24_1:GetWordFromCfg(417171005)
				local var_27_55 = arg_24_1:FormatText(var_27_54.content)

				arg_24_1.text_.text = var_27_55

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_56 = 16
				local var_27_57 = utf8.len(var_27_55)
				local var_27_58 = var_27_56 <= 0 and var_27_51 or var_27_51 * (var_27_57 / var_27_56)

				if var_27_58 > 0 and var_27_51 < var_27_58 then
					arg_24_1.talkMaxDuration = var_27_58
					var_27_50 = var_27_50 + 0.3

					if var_27_58 + var_27_50 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_58 + var_27_50
					end
				end

				arg_24_1.text_.text = var_27_55
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171005", "story_v_out_417171.awb") ~= 0 then
					local var_27_59 = manager.audio:GetVoiceLength("story_v_out_417171", "417171005", "story_v_out_417171.awb") / 1000

					if var_27_59 + var_27_50 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_59 + var_27_50
					end

					if var_27_54.prefab_name ~= "" and arg_24_1.actors_[var_27_54.prefab_name] ~= nil then
						local var_27_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_54.prefab_name].transform, "story_v_out_417171", "417171005", "story_v_out_417171.awb")

						arg_24_1:RecordAudio("417171005", var_27_60)
						arg_24_1:RecordAudio("417171005", var_27_60)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_417171", "417171005", "story_v_out_417171.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_417171", "417171005", "story_v_out_417171.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_61 = var_27_50 + 0.3
			local var_27_62 = math.max(var_27_51, arg_24_1.talkMaxDuration)

			if var_27_61 <= arg_24_1.time_ and arg_24_1.time_ < var_27_61 + var_27_62 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_61) / var_27_62

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_61 + var_27_62 and arg_24_1.time_ < var_27_61 + var_27_62 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play417171006 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417171006
		arg_30_1.duration_ = 1.53

		local var_30_0 = {
			zh = 1.366,
			ja = 1.533
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
				arg_30_0:Play417171007(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10128"].transform
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.var_.moveOldPos10128 = var_33_0.localPosition
				var_33_0.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10128", 7)

				local var_33_2 = var_33_0.childCount

				for iter_33_0 = 0, var_33_2 - 1 do
					local var_33_3 = var_33_0:GetChild(iter_33_0)

					if var_33_3.name == "" or not string.find(var_33_3.name, "split") then
						var_33_3.gameObject:SetActive(true)
					else
						var_33_3.gameObject:SetActive(false)
					end
				end
			end

			local var_33_4 = 0.001

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_4 then
				local var_33_5 = (arg_30_1.time_ - var_33_1) / var_33_4
				local var_33_6 = Vector3.New(0, -2000, -300)

				var_33_0.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10128, var_33_6, var_33_5)
			end

			if arg_30_1.time_ >= var_33_1 + var_33_4 and arg_30_1.time_ < var_33_1 + var_33_4 + arg_33_0 then
				var_33_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_33_7 = 0
			local var_33_8 = 0.2

			if var_33_7 < arg_30_1.time_ and arg_30_1.time_ <= var_33_7 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_9 = arg_30_1:FormatText(StoryNameCfg[1117].name)

				arg_30_1.leftNameTxt_.text = var_33_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_1")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_10 = arg_30_1:GetWordFromCfg(417171006)
				local var_33_11 = arg_30_1:FormatText(var_33_10.content)

				arg_30_1.text_.text = var_33_11

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_12 = 5
				local var_33_13 = utf8.len(var_33_11)
				local var_33_14 = var_33_12 <= 0 and var_33_8 or var_33_8 * (var_33_13 / var_33_12)

				if var_33_14 > 0 and var_33_8 < var_33_14 then
					arg_30_1.talkMaxDuration = var_33_14

					if var_33_14 + var_33_7 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_14 + var_33_7
					end
				end

				arg_30_1.text_.text = var_33_11
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171006", "story_v_out_417171.awb") ~= 0 then
					local var_33_15 = manager.audio:GetVoiceLength("story_v_out_417171", "417171006", "story_v_out_417171.awb") / 1000

					if var_33_15 + var_33_7 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_15 + var_33_7
					end

					if var_33_10.prefab_name ~= "" and arg_30_1.actors_[var_33_10.prefab_name] ~= nil then
						local var_33_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_10.prefab_name].transform, "story_v_out_417171", "417171006", "story_v_out_417171.awb")

						arg_30_1:RecordAudio("417171006", var_33_16)
						arg_30_1:RecordAudio("417171006", var_33_16)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417171", "417171006", "story_v_out_417171.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417171", "417171006", "story_v_out_417171.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_17 = math.max(var_33_8, arg_30_1.talkMaxDuration)

			if var_33_7 <= arg_30_1.time_ and arg_30_1.time_ < var_33_7 + var_33_17 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_7) / var_33_17

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_7 + var_33_17 and arg_30_1.time_ < var_33_7 + var_33_17 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play417171007 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417171007
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417171008(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.3
			local var_37_1 = 1

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				local var_37_2 = "play"
				local var_37_3 = "effect"

				arg_34_1:AudioAction(var_37_2, var_37_3, "se_story_1311", "se_story_1311_footsteps", "")
			end

			local var_37_4 = 0
			local var_37_5 = 1.175

			if var_37_4 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_6 = arg_34_1:GetWordFromCfg(417171007)
				local var_37_7 = arg_34_1:FormatText(var_37_6.content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_8 = 47
				local var_37_9 = utf8.len(var_37_7)
				local var_37_10 = var_37_8 <= 0 and var_37_5 or var_37_5 * (var_37_9 / var_37_8)

				if var_37_10 > 0 and var_37_5 < var_37_10 then
					arg_34_1.talkMaxDuration = var_37_10

					if var_37_10 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_11 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_11 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_11

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_11 and arg_34_1.time_ < var_37_4 + var_37_11 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417171008 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417171008
		arg_38_1.duration_ = 5.2

		local var_38_0 = {
			zh = 3.4,
			ja = 5.2
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
				arg_38_0:Play417171009(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10128"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps10128 == nil then
				arg_38_1.var_.actorSpriteComps10128 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps10128 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps10128 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_41_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps10128 = nil
			end

			local var_41_8 = arg_38_1.actors_["10128"].transform
			local var_41_9 = 0

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 then
				arg_38_1.var_.moveOldPos10128 = var_41_8.localPosition
				var_41_8.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10128", 3)

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
				local var_41_14 = Vector3.New(0, -347, -300)

				var_41_8.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10128, var_41_14, var_41_13)
			end

			if arg_38_1.time_ >= var_41_9 + var_41_12 and arg_38_1.time_ < var_41_9 + var_41_12 + arg_41_0 then
				var_41_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_41_15 = 0
			local var_41_16 = 0.35

			if var_41_15 < arg_38_1.time_ and arg_38_1.time_ <= var_41_15 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_17 = arg_38_1:FormatText(StoryNameCfg[595].name)

				arg_38_1.leftNameTxt_.text = var_41_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_18 = arg_38_1:GetWordFromCfg(417171008)
				local var_41_19 = arg_38_1:FormatText(var_41_18.content)

				arg_38_1.text_.text = var_41_19

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171008", "story_v_out_417171.awb") ~= 0 then
					local var_41_23 = manager.audio:GetVoiceLength("story_v_out_417171", "417171008", "story_v_out_417171.awb") / 1000

					if var_41_23 + var_41_15 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_23 + var_41_15
					end

					if var_41_18.prefab_name ~= "" and arg_38_1.actors_[var_41_18.prefab_name] ~= nil then
						local var_41_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_18.prefab_name].transform, "story_v_out_417171", "417171008", "story_v_out_417171.awb")

						arg_38_1:RecordAudio("417171008", var_41_24)
						arg_38_1:RecordAudio("417171008", var_41_24)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417171", "417171008", "story_v_out_417171.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417171", "417171008", "story_v_out_417171.awb")
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
				actorName = "10128",
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
	Play417171009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417171009
		arg_42_1.duration_ = 7.6

		local var_42_0 = {
			zh = 6.2,
			ja = 7.6
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
				arg_42_0:Play417171010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "10113"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(var_45_1, arg_42_1.canvasGo_.transform)

					var_45_2.transform:SetSiblingIndex(1)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_42_1.isInRecall_ then
						for iter_45_0, iter_45_1 in ipairs(var_45_3) do
							iter_45_1.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_45_4 = arg_42_1.actors_["10113"]
			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.actorSpriteComps10113 == nil then
				arg_42_1.var_.actorSpriteComps10113 = var_45_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_6 = 0.2

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_6 and not isNil(var_45_4) then
				local var_45_7 = (arg_42_1.time_ - var_45_5) / var_45_6

				if arg_42_1.var_.actorSpriteComps10113 then
					for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_45_3 then
							if arg_42_1.isInRecall_ then
								local var_45_8 = Mathf.Lerp(iter_45_3.color.r, arg_42_1.hightColor1.r, var_45_7)
								local var_45_9 = Mathf.Lerp(iter_45_3.color.g, arg_42_1.hightColor1.g, var_45_7)
								local var_45_10 = Mathf.Lerp(iter_45_3.color.b, arg_42_1.hightColor1.b, var_45_7)

								iter_45_3.color = Color.New(var_45_8, var_45_9, var_45_10)
							else
								local var_45_11 = Mathf.Lerp(iter_45_3.color.r, 1, var_45_7)

								iter_45_3.color = Color.New(var_45_11, var_45_11, var_45_11)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_5 + var_45_6 and arg_42_1.time_ < var_45_5 + var_45_6 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.actorSpriteComps10113 then
				for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_45_5 then
						if arg_42_1.isInRecall_ then
							iter_45_5.color = arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_45_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10113 = nil
			end

			local var_45_12 = arg_42_1.actors_["10128"]
			local var_45_13 = 0

			if var_45_13 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 and not isNil(var_45_12) and arg_42_1.var_.actorSpriteComps10128 == nil then
				arg_42_1.var_.actorSpriteComps10128 = var_45_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_14 = 0.2

			if var_45_13 <= arg_42_1.time_ and arg_42_1.time_ < var_45_13 + var_45_14 and not isNil(var_45_12) then
				local var_45_15 = (arg_42_1.time_ - var_45_13) / var_45_14

				if arg_42_1.var_.actorSpriteComps10128 then
					for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_45_7 then
							if arg_42_1.isInRecall_ then
								local var_45_16 = Mathf.Lerp(iter_45_7.color.r, arg_42_1.hightColor2.r, var_45_15)
								local var_45_17 = Mathf.Lerp(iter_45_7.color.g, arg_42_1.hightColor2.g, var_45_15)
								local var_45_18 = Mathf.Lerp(iter_45_7.color.b, arg_42_1.hightColor2.b, var_45_15)

								iter_45_7.color = Color.New(var_45_16, var_45_17, var_45_18)
							else
								local var_45_19 = Mathf.Lerp(iter_45_7.color.r, 0.5, var_45_15)

								iter_45_7.color = Color.New(var_45_19, var_45_19, var_45_19)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_13 + var_45_14 and arg_42_1.time_ < var_45_13 + var_45_14 + arg_45_0 and not isNil(var_45_12) and arg_42_1.var_.actorSpriteComps10128 then
				for iter_45_8, iter_45_9 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_45_9 then
						if arg_42_1.isInRecall_ then
							iter_45_9.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps10128 = nil
			end

			local var_45_20 = arg_42_1.actors_["10128"].transform
			local var_45_21 = 0

			if var_45_21 < arg_42_1.time_ and arg_42_1.time_ <= var_45_21 + arg_45_0 then
				arg_42_1.var_.moveOldPos10128 = var_45_20.localPosition
				var_45_20.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10128", 2)

				local var_45_22 = var_45_20.childCount

				for iter_45_10 = 0, var_45_22 - 1 do
					local var_45_23 = var_45_20:GetChild(iter_45_10)

					if var_45_23.name == "" or not string.find(var_45_23.name, "split") then
						var_45_23.gameObject:SetActive(true)
					else
						var_45_23.gameObject:SetActive(false)
					end
				end
			end

			local var_45_24 = 0.001

			if var_45_21 <= arg_42_1.time_ and arg_42_1.time_ < var_45_21 + var_45_24 then
				local var_45_25 = (arg_42_1.time_ - var_45_21) / var_45_24
				local var_45_26 = Vector3.New(-390, -347, -300)

				var_45_20.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10128, var_45_26, var_45_25)
			end

			if arg_42_1.time_ >= var_45_21 + var_45_24 and arg_42_1.time_ < var_45_21 + var_45_24 + arg_45_0 then
				var_45_20.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_45_27 = arg_42_1.actors_["10113"].transform
			local var_45_28 = 0

			if var_45_28 < arg_42_1.time_ and arg_42_1.time_ <= var_45_28 + arg_45_0 then
				arg_42_1.var_.moveOldPos10113 = var_45_27.localPosition
				var_45_27.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10113", 4)

				local var_45_29 = var_45_27.childCount

				for iter_45_11 = 0, var_45_29 - 1 do
					local var_45_30 = var_45_27:GetChild(iter_45_11)

					if var_45_30.name == "" or not string.find(var_45_30.name, "split") then
						var_45_30.gameObject:SetActive(true)
					else
						var_45_30.gameObject:SetActive(false)
					end
				end
			end

			local var_45_31 = 0.001

			if var_45_28 <= arg_42_1.time_ and arg_42_1.time_ < var_45_28 + var_45_31 then
				local var_45_32 = (arg_42_1.time_ - var_45_28) / var_45_31
				local var_45_33 = Vector3.New(377.3, -328.4, -517.4)

				var_45_27.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10113, var_45_33, var_45_32)
			end

			if arg_42_1.time_ >= var_45_28 + var_45_31 and arg_42_1.time_ < var_45_28 + var_45_31 + arg_45_0 then
				var_45_27.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_45_34 = 0
			local var_45_35 = 0.925

			if var_45_34 < arg_42_1.time_ and arg_42_1.time_ <= var_45_34 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_36 = arg_42_1:FormatText(StoryNameCfg[1117].name)

				arg_42_1.leftNameTxt_.text = var_45_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_37 = arg_42_1:GetWordFromCfg(417171009)
				local var_45_38 = arg_42_1:FormatText(var_45_37.content)

				arg_42_1.text_.text = var_45_38

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_39 = 37
				local var_45_40 = utf8.len(var_45_38)
				local var_45_41 = var_45_39 <= 0 and var_45_35 or var_45_35 * (var_45_40 / var_45_39)

				if var_45_41 > 0 and var_45_35 < var_45_41 then
					arg_42_1.talkMaxDuration = var_45_41

					if var_45_41 + var_45_34 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_41 + var_45_34
					end
				end

				arg_42_1.text_.text = var_45_38
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171009", "story_v_out_417171.awb") ~= 0 then
					local var_45_42 = manager.audio:GetVoiceLength("story_v_out_417171", "417171009", "story_v_out_417171.awb") / 1000

					if var_45_42 + var_45_34 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_42 + var_45_34
					end

					if var_45_37.prefab_name ~= "" and arg_42_1.actors_[var_45_37.prefab_name] ~= nil then
						local var_45_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_37.prefab_name].transform, "story_v_out_417171", "417171009", "story_v_out_417171.awb")

						arg_42_1:RecordAudio("417171009", var_45_43)
						arg_42_1:RecordAudio("417171009", var_45_43)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417171", "417171009", "story_v_out_417171.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417171", "417171009", "story_v_out_417171.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_44 = math.max(var_45_35, arg_42_1.talkMaxDuration)

			if var_45_34 <= arg_42_1.time_ and arg_42_1.time_ < var_45_34 + var_45_44 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_34) / var_45_44

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_34 + var_45_44 and arg_42_1.time_ < var_45_34 + var_45_44 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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
				actorName = "10113",
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
	Play417171010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417171010
		arg_46_1.duration_ = 9.97

		local var_46_0 = {
			zh = 5.933,
			ja = 9.966
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
				arg_46_0:Play417171011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.85

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[1117].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:GetWordFromCfg(417171010)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 34
				local var_49_6 = utf8.len(var_49_4)
				local var_49_7 = var_49_5 <= 0 and var_49_1 or var_49_1 * (var_49_6 / var_49_5)

				if var_49_7 > 0 and var_49_1 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171010", "story_v_out_417171.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171010", "story_v_out_417171.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_417171", "417171010", "story_v_out_417171.awb")

						arg_46_1:RecordAudio("417171010", var_49_9)
						arg_46_1:RecordAudio("417171010", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417171", "417171010", "story_v_out_417171.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417171", "417171010", "story_v_out_417171.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_10 and arg_46_1.time_ < var_49_0 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417171011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417171011
		arg_50_1.duration_ = 3.9

		local var_50_0 = {
			zh = 3.766,
			ja = 3.9
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
				arg_50_0:Play417171012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10128"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps10128 == nil then
				arg_50_1.var_.actorSpriteComps10128 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps10128 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								local var_53_4 = Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor1.r, var_53_3)
								local var_53_5 = Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor1.g, var_53_3)
								local var_53_6 = Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor1.b, var_53_3)

								iter_53_1.color = Color.New(var_53_4, var_53_5, var_53_6)
							else
								local var_53_7 = Mathf.Lerp(iter_53_1.color.r, 1, var_53_3)

								iter_53_1.color = Color.New(var_53_7, var_53_7, var_53_7)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps10128 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps10128 = nil
			end

			local var_53_8 = arg_50_1.actors_["10113"]
			local var_53_9 = 0

			if var_53_9 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 and not isNil(var_53_8) and arg_50_1.var_.actorSpriteComps10113 == nil then
				arg_50_1.var_.actorSpriteComps10113 = var_53_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_10 = 0.2

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_10 and not isNil(var_53_8) then
				local var_53_11 = (arg_50_1.time_ - var_53_9) / var_53_10

				if arg_50_1.var_.actorSpriteComps10113 then
					for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_53_5 then
							if arg_50_1.isInRecall_ then
								local var_53_12 = Mathf.Lerp(iter_53_5.color.r, arg_50_1.hightColor2.r, var_53_11)
								local var_53_13 = Mathf.Lerp(iter_53_5.color.g, arg_50_1.hightColor2.g, var_53_11)
								local var_53_14 = Mathf.Lerp(iter_53_5.color.b, arg_50_1.hightColor2.b, var_53_11)

								iter_53_5.color = Color.New(var_53_12, var_53_13, var_53_14)
							else
								local var_53_15 = Mathf.Lerp(iter_53_5.color.r, 0.5, var_53_11)

								iter_53_5.color = Color.New(var_53_15, var_53_15, var_53_15)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_9 + var_53_10 and arg_50_1.time_ < var_53_9 + var_53_10 + arg_53_0 and not isNil(var_53_8) and arg_50_1.var_.actorSpriteComps10113 then
				for iter_53_6, iter_53_7 in pairs(arg_50_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_53_7 then
						if arg_50_1.isInRecall_ then
							iter_53_7.color = arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_53_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps10113 = nil
			end

			local var_53_16 = 0
			local var_53_17 = 0.425

			if var_53_16 < arg_50_1.time_ and arg_50_1.time_ <= var_53_16 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_18 = arg_50_1:FormatText(StoryNameCfg[595].name)

				arg_50_1.leftNameTxt_.text = var_53_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_19 = arg_50_1:GetWordFromCfg(417171011)
				local var_53_20 = arg_50_1:FormatText(var_53_19.content)

				arg_50_1.text_.text = var_53_20

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_21 = 17
				local var_53_22 = utf8.len(var_53_20)
				local var_53_23 = var_53_21 <= 0 and var_53_17 or var_53_17 * (var_53_22 / var_53_21)

				if var_53_23 > 0 and var_53_17 < var_53_23 then
					arg_50_1.talkMaxDuration = var_53_23

					if var_53_23 + var_53_16 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_16
					end
				end

				arg_50_1.text_.text = var_53_20
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171011", "story_v_out_417171.awb") ~= 0 then
					local var_53_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171011", "story_v_out_417171.awb") / 1000

					if var_53_24 + var_53_16 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_24 + var_53_16
					end

					if var_53_19.prefab_name ~= "" and arg_50_1.actors_[var_53_19.prefab_name] ~= nil then
						local var_53_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_19.prefab_name].transform, "story_v_out_417171", "417171011", "story_v_out_417171.awb")

						arg_50_1:RecordAudio("417171011", var_53_25)
						arg_50_1:RecordAudio("417171011", var_53_25)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417171", "417171011", "story_v_out_417171.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417171", "417171011", "story_v_out_417171.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_26 = math.max(var_53_17, arg_50_1.talkMaxDuration)

			if var_53_16 <= arg_50_1.time_ and arg_50_1.time_ < var_53_16 + var_53_26 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_16) / var_53_26

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_16 + var_53_26 and arg_50_1.time_ < var_53_16 + var_53_26 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417171012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417171012
		arg_54_1.duration_ = 5.77

		local var_54_0 = {
			zh = 3.3,
			ja = 5.766
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
				arg_54_0:Play417171013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["10113"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps10113 == nil then
				arg_54_1.var_.actorSpriteComps10113 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps10113 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps10113 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps10113 = nil
			end

			local var_57_8 = arg_54_1.actors_["10128"]
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps10128 == nil then
				arg_54_1.var_.actorSpriteComps10128 = var_57_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_10 = 0.2

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_10 and not isNil(var_57_8) then
				local var_57_11 = (arg_54_1.time_ - var_57_9) / var_57_10

				if arg_54_1.var_.actorSpriteComps10128 then
					for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_54_1.time_ >= var_57_9 + var_57_10 and arg_54_1.time_ < var_57_9 + var_57_10 + arg_57_0 and not isNil(var_57_8) and arg_54_1.var_.actorSpriteComps10128 then
				for iter_57_6, iter_57_7 in pairs(arg_54_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_57_7 then
						if arg_54_1.isInRecall_ then
							iter_57_7.color = arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_57_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps10128 = nil
			end

			local var_57_16 = 0
			local var_57_17 = 0.4

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_18 = arg_54_1:FormatText(StoryNameCfg[1117].name)

				arg_54_1.leftNameTxt_.text = var_57_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_19 = arg_54_1:GetWordFromCfg(417171012)
				local var_57_20 = arg_54_1:FormatText(var_57_19.content)

				arg_54_1.text_.text = var_57_20

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_21 = 16
				local var_57_22 = utf8.len(var_57_20)
				local var_57_23 = var_57_21 <= 0 and var_57_17 or var_57_17 * (var_57_22 / var_57_21)

				if var_57_23 > 0 and var_57_17 < var_57_23 then
					arg_54_1.talkMaxDuration = var_57_23

					if var_57_23 + var_57_16 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_16
					end
				end

				arg_54_1.text_.text = var_57_20
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171012", "story_v_out_417171.awb") ~= 0 then
					local var_57_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171012", "story_v_out_417171.awb") / 1000

					if var_57_24 + var_57_16 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_24 + var_57_16
					end

					if var_57_19.prefab_name ~= "" and arg_54_1.actors_[var_57_19.prefab_name] ~= nil then
						local var_57_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_19.prefab_name].transform, "story_v_out_417171", "417171012", "story_v_out_417171.awb")

						arg_54_1:RecordAudio("417171012", var_57_25)
						arg_54_1:RecordAudio("417171012", var_57_25)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417171", "417171012", "story_v_out_417171.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417171", "417171012", "story_v_out_417171.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_26 = math.max(var_57_17, arg_54_1.talkMaxDuration)

			if var_57_16 <= arg_54_1.time_ and arg_54_1.time_ < var_57_16 + var_57_26 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_16) / var_57_26

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_16 + var_57_26 and arg_54_1.time_ < var_57_16 + var_57_26 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417171013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417171013
		arg_58_1.duration_ = 7.63

		local var_58_0 = {
			zh = 7.033,
			ja = 7.633
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
				arg_58_0:Play417171014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10128"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_8 = arg_58_1.actors_["10113"]
			local var_61_9 = 0

			if var_61_9 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps10113 == nil then
				arg_58_1.var_.actorSpriteComps10113 = var_61_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_10 = 0.2

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_10 and not isNil(var_61_8) then
				local var_61_11 = (arg_58_1.time_ - var_61_9) / var_61_10

				if arg_58_1.var_.actorSpriteComps10113 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								local var_61_12 = Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, var_61_11)
								local var_61_13 = Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, var_61_11)
								local var_61_14 = Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, var_61_11)

								iter_61_5.color = Color.New(var_61_12, var_61_13, var_61_14)
							else
								local var_61_15 = Mathf.Lerp(iter_61_5.color.r, 0.5, var_61_11)

								iter_61_5.color = Color.New(var_61_15, var_61_15, var_61_15)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_9 + var_61_10 and arg_58_1.time_ < var_61_9 + var_61_10 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.actorSpriteComps10113 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_61_7 then
						if arg_58_1.isInRecall_ then
							iter_61_7.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps10113 = nil
			end

			local var_61_16 = 0
			local var_61_17 = 0.8

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_18 = arg_58_1:FormatText(StoryNameCfg[595].name)

				arg_58_1.leftNameTxt_.text = var_61_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_19 = arg_58_1:GetWordFromCfg(417171013)
				local var_61_20 = arg_58_1:FormatText(var_61_19.content)

				arg_58_1.text_.text = var_61_20

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_21 = 32
				local var_61_22 = utf8.len(var_61_20)
				local var_61_23 = var_61_21 <= 0 and var_61_17 or var_61_17 * (var_61_22 / var_61_21)

				if var_61_23 > 0 and var_61_17 < var_61_23 then
					arg_58_1.talkMaxDuration = var_61_23

					if var_61_23 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_23 + var_61_16
					end
				end

				arg_58_1.text_.text = var_61_20
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171013", "story_v_out_417171.awb") ~= 0 then
					local var_61_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171013", "story_v_out_417171.awb") / 1000

					if var_61_24 + var_61_16 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_24 + var_61_16
					end

					if var_61_19.prefab_name ~= "" and arg_58_1.actors_[var_61_19.prefab_name] ~= nil then
						local var_61_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_19.prefab_name].transform, "story_v_out_417171", "417171013", "story_v_out_417171.awb")

						arg_58_1:RecordAudio("417171013", var_61_25)
						arg_58_1:RecordAudio("417171013", var_61_25)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417171", "417171013", "story_v_out_417171.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417171", "417171013", "story_v_out_417171.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_26 = math.max(var_61_17, arg_58_1.talkMaxDuration)

			if var_61_16 <= arg_58_1.time_ and arg_58_1.time_ < var_61_16 + var_61_26 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_16) / var_61_26

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_16 + var_61_26 and arg_58_1.time_ < var_61_16 + var_61_26 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417171014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417171014
		arg_62_1.duration_ = 6.77

		local var_62_0 = {
			zh = 3.933,
			ja = 6.766
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
				arg_62_0:Play417171015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["10113"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps10113 == nil then
				arg_62_1.var_.actorSpriteComps10113 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps10113 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps10113 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps10113 = nil
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

			local var_65_16 = 0
			local var_65_17 = 0.475

			if var_65_16 < arg_62_1.time_ and arg_62_1.time_ <= var_65_16 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_18 = arg_62_1:FormatText(StoryNameCfg[1117].name)

				arg_62_1.leftNameTxt_.text = var_65_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_19 = arg_62_1:GetWordFromCfg(417171014)
				local var_65_20 = arg_62_1:FormatText(var_65_19.content)

				arg_62_1.text_.text = var_65_20

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_21 = 19
				local var_65_22 = utf8.len(var_65_20)
				local var_65_23 = var_65_21 <= 0 and var_65_17 or var_65_17 * (var_65_22 / var_65_21)

				if var_65_23 > 0 and var_65_17 < var_65_23 then
					arg_62_1.talkMaxDuration = var_65_23

					if var_65_23 + var_65_16 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_23 + var_65_16
					end
				end

				arg_62_1.text_.text = var_65_20
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171014", "story_v_out_417171.awb") ~= 0 then
					local var_65_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171014", "story_v_out_417171.awb") / 1000

					if var_65_24 + var_65_16 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_24 + var_65_16
					end

					if var_65_19.prefab_name ~= "" and arg_62_1.actors_[var_65_19.prefab_name] ~= nil then
						local var_65_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_19.prefab_name].transform, "story_v_out_417171", "417171014", "story_v_out_417171.awb")

						arg_62_1:RecordAudio("417171014", var_65_25)
						arg_62_1:RecordAudio("417171014", var_65_25)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417171", "417171014", "story_v_out_417171.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417171", "417171014", "story_v_out_417171.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_26 = math.max(var_65_17, arg_62_1.talkMaxDuration)

			if var_65_16 <= arg_62_1.time_ and arg_62_1.time_ < var_65_16 + var_65_26 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_16) / var_65_26

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_16 + var_65_26 and arg_62_1.time_ < var_65_16 + var_65_26 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417171015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417171015
		arg_66_1.duration_ = 1.5

		local var_66_0 = {
			zh = 1.233,
			ja = 1.5
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
				arg_66_0:Play417171016(arg_66_1)
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

			local var_69_8 = arg_66_1.actors_["10113"]
			local var_69_9 = 0

			if var_69_9 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps10113 == nil then
				arg_66_1.var_.actorSpriteComps10113 = var_69_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_10 = 0.2

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_10 and not isNil(var_69_8) then
				local var_69_11 = (arg_66_1.time_ - var_69_9) / var_69_10

				if arg_66_1.var_.actorSpriteComps10113 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_66_1.time_ >= var_69_9 + var_69_10 and arg_66_1.time_ < var_69_9 + var_69_10 + arg_69_0 and not isNil(var_69_8) and arg_66_1.var_.actorSpriteComps10113 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_69_7 then
						if arg_66_1.isInRecall_ then
							iter_69_7.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps10113 = nil
			end

			local var_69_16 = 0
			local var_69_17 = 0.125

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_18 = arg_66_1:FormatText(StoryNameCfg[595].name)

				arg_66_1.leftNameTxt_.text = var_69_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_19 = arg_66_1:GetWordFromCfg(417171015)
				local var_69_20 = arg_66_1:FormatText(var_69_19.content)

				arg_66_1.text_.text = var_69_20

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_21 = 5
				local var_69_22 = utf8.len(var_69_20)
				local var_69_23 = var_69_21 <= 0 and var_69_17 or var_69_17 * (var_69_22 / var_69_21)

				if var_69_23 > 0 and var_69_17 < var_69_23 then
					arg_66_1.talkMaxDuration = var_69_23

					if var_69_23 + var_69_16 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_16
					end
				end

				arg_66_1.text_.text = var_69_20
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171015", "story_v_out_417171.awb") ~= 0 then
					local var_69_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171015", "story_v_out_417171.awb") / 1000

					if var_69_24 + var_69_16 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_16
					end

					if var_69_19.prefab_name ~= "" and arg_66_1.actors_[var_69_19.prefab_name] ~= nil then
						local var_69_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_19.prefab_name].transform, "story_v_out_417171", "417171015", "story_v_out_417171.awb")

						arg_66_1:RecordAudio("417171015", var_69_25)
						arg_66_1:RecordAudio("417171015", var_69_25)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417171", "417171015", "story_v_out_417171.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417171", "417171015", "story_v_out_417171.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_26 = math.max(var_69_17, arg_66_1.talkMaxDuration)

			if var_69_16 <= arg_66_1.time_ and arg_66_1.time_ < var_69_16 + var_69_26 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_16) / var_69_26

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_16 + var_69_26 and arg_66_1.time_ < var_69_16 + var_69_26 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417171016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417171016
		arg_70_1.duration_ = 9.2

		local var_70_0 = {
			zh = 6.933,
			ja = 9.2
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
				arg_70_0:Play417171017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10113"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps10113 == nil then
				arg_70_1.var_.actorSpriteComps10113 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps10113 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 1, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps10113 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_73_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps10113 = nil
			end

			local var_73_8 = arg_70_1.actors_["10128"]
			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps10128 == nil then
				arg_70_1.var_.actorSpriteComps10128 = var_73_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_10 = 0.2

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_10 and not isNil(var_73_8) then
				local var_73_11 = (arg_70_1.time_ - var_73_9) / var_73_10

				if arg_70_1.var_.actorSpriteComps10128 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								local var_73_12 = Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, var_73_11)
								local var_73_13 = Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, var_73_11)
								local var_73_14 = Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, var_73_11)

								iter_73_5.color = Color.New(var_73_12, var_73_13, var_73_14)
							else
								local var_73_15 = Mathf.Lerp(iter_73_5.color.r, 0.5, var_73_11)

								iter_73_5.color = Color.New(var_73_15, var_73_15, var_73_15)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_9 + var_73_10 and arg_70_1.time_ < var_73_9 + var_73_10 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.actorSpriteComps10128 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_73_7 then
						if arg_70_1.isInRecall_ then
							iter_73_7.color = arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_73_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps10128 = nil
			end

			local var_73_16 = 0
			local var_73_17 = 0.9

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_18 = arg_70_1:FormatText(StoryNameCfg[1117].name)

				arg_70_1.leftNameTxt_.text = var_73_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_19 = arg_70_1:GetWordFromCfg(417171016)
				local var_73_20 = arg_70_1:FormatText(var_73_19.content)

				arg_70_1.text_.text = var_73_20

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_21 = 36
				local var_73_22 = utf8.len(var_73_20)
				local var_73_23 = var_73_21 <= 0 and var_73_17 or var_73_17 * (var_73_22 / var_73_21)

				if var_73_23 > 0 and var_73_17 < var_73_23 then
					arg_70_1.talkMaxDuration = var_73_23

					if var_73_23 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_16
					end
				end

				arg_70_1.text_.text = var_73_20
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171016", "story_v_out_417171.awb") ~= 0 then
					local var_73_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171016", "story_v_out_417171.awb") / 1000

					if var_73_24 + var_73_16 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_24 + var_73_16
					end

					if var_73_19.prefab_name ~= "" and arg_70_1.actors_[var_73_19.prefab_name] ~= nil then
						local var_73_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_19.prefab_name].transform, "story_v_out_417171", "417171016", "story_v_out_417171.awb")

						arg_70_1:RecordAudio("417171016", var_73_25)
						arg_70_1:RecordAudio("417171016", var_73_25)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417171", "417171016", "story_v_out_417171.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417171", "417171016", "story_v_out_417171.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_26 = math.max(var_73_17, arg_70_1.talkMaxDuration)

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_26 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_16) / var_73_26

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_16 + var_73_26 and arg_70_1.time_ < var_73_16 + var_73_26 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417171017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417171017
		arg_74_1.duration_ = 3.7

		local var_74_0 = {
			zh = 2.2,
			ja = 3.7
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
				arg_74_0:Play417171018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10128"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps10128 == nil then
				arg_74_1.var_.actorSpriteComps10128 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps10128 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps10128 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_77_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps10128 = nil
			end

			local var_77_8 = arg_74_1.actors_["10113"]
			local var_77_9 = 0

			if var_77_9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 and not isNil(var_77_8) and arg_74_1.var_.actorSpriteComps10113 == nil then
				arg_74_1.var_.actorSpriteComps10113 = var_77_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_10 = 0.2

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_10 and not isNil(var_77_8) then
				local var_77_11 = (arg_74_1.time_ - var_77_9) / var_77_10

				if arg_74_1.var_.actorSpriteComps10113 then
					for iter_77_4, iter_77_5 in pairs(arg_74_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_77_5 then
							if arg_74_1.isInRecall_ then
								local var_77_12 = Mathf.Lerp(iter_77_5.color.r, arg_74_1.hightColor2.r, var_77_11)
								local var_77_13 = Mathf.Lerp(iter_77_5.color.g, arg_74_1.hightColor2.g, var_77_11)
								local var_77_14 = Mathf.Lerp(iter_77_5.color.b, arg_74_1.hightColor2.b, var_77_11)

								iter_77_5.color = Color.New(var_77_12, var_77_13, var_77_14)
							else
								local var_77_15 = Mathf.Lerp(iter_77_5.color.r, 0.5, var_77_11)

								iter_77_5.color = Color.New(var_77_15, var_77_15, var_77_15)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_9 + var_77_10 and arg_74_1.time_ < var_77_9 + var_77_10 + arg_77_0 and not isNil(var_77_8) and arg_74_1.var_.actorSpriteComps10113 then
				for iter_77_6, iter_77_7 in pairs(arg_74_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_77_7 then
						if arg_74_1.isInRecall_ then
							iter_77_7.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps10113 = nil
			end

			local var_77_16 = 0
			local var_77_17 = 0.3

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_18 = arg_74_1:FormatText(StoryNameCfg[595].name)

				arg_74_1.leftNameTxt_.text = var_77_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_19 = arg_74_1:GetWordFromCfg(417171017)
				local var_77_20 = arg_74_1:FormatText(var_77_19.content)

				arg_74_1.text_.text = var_77_20

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_21 = 12
				local var_77_22 = utf8.len(var_77_20)
				local var_77_23 = var_77_21 <= 0 and var_77_17 or var_77_17 * (var_77_22 / var_77_21)

				if var_77_23 > 0 and var_77_17 < var_77_23 then
					arg_74_1.talkMaxDuration = var_77_23

					if var_77_23 + var_77_16 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_16
					end
				end

				arg_74_1.text_.text = var_77_20
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171017", "story_v_out_417171.awb") ~= 0 then
					local var_77_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171017", "story_v_out_417171.awb") / 1000

					if var_77_24 + var_77_16 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_24 + var_77_16
					end

					if var_77_19.prefab_name ~= "" and arg_74_1.actors_[var_77_19.prefab_name] ~= nil then
						local var_77_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_19.prefab_name].transform, "story_v_out_417171", "417171017", "story_v_out_417171.awb")

						arg_74_1:RecordAudio("417171017", var_77_25)
						arg_74_1:RecordAudio("417171017", var_77_25)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417171", "417171017", "story_v_out_417171.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417171", "417171017", "story_v_out_417171.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_26 = math.max(var_77_17, arg_74_1.talkMaxDuration)

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_26 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_16) / var_77_26

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_16 + var_77_26 and arg_74_1.time_ < var_77_16 + var_77_26 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play417171018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417171018
		arg_78_1.duration_ = 9.17

		local var_78_0 = {
			zh = 9.166,
			ja = 8.033
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
				arg_78_0:Play417171019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10113"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10113 == nil then
				arg_78_1.var_.actorSpriteComps10113 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps10113 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps10113 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10113 = nil
			end

			local var_81_8 = arg_78_1.actors_["10128"]
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.actorSpriteComps10128 == nil then
				arg_78_1.var_.actorSpriteComps10128 = var_81_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_10 = 0.2

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_10 and not isNil(var_81_8) then
				local var_81_11 = (arg_78_1.time_ - var_81_9) / var_81_10

				if arg_78_1.var_.actorSpriteComps10128 then
					for iter_81_4, iter_81_5 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_78_1.time_ >= var_81_9 + var_81_10 and arg_78_1.time_ < var_81_9 + var_81_10 + arg_81_0 and not isNil(var_81_8) and arg_78_1.var_.actorSpriteComps10128 then
				for iter_81_6, iter_81_7 in pairs(arg_78_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_81_7 then
						if arg_78_1.isInRecall_ then
							iter_81_7.color = arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_81_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps10128 = nil
			end

			local var_81_16 = 0
			local var_81_17 = 1.15

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_18 = arg_78_1:FormatText(StoryNameCfg[1117].name)

				arg_78_1.leftNameTxt_.text = var_81_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_19 = arg_78_1:GetWordFromCfg(417171018)
				local var_81_20 = arg_78_1:FormatText(var_81_19.content)

				arg_78_1.text_.text = var_81_20

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_21 = 46
				local var_81_22 = utf8.len(var_81_20)
				local var_81_23 = var_81_21 <= 0 and var_81_17 or var_81_17 * (var_81_22 / var_81_21)

				if var_81_23 > 0 and var_81_17 < var_81_23 then
					arg_78_1.talkMaxDuration = var_81_23

					if var_81_23 + var_81_16 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_16
					end
				end

				arg_78_1.text_.text = var_81_20
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171018", "story_v_out_417171.awb") ~= 0 then
					local var_81_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171018", "story_v_out_417171.awb") / 1000

					if var_81_24 + var_81_16 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_24 + var_81_16
					end

					if var_81_19.prefab_name ~= "" and arg_78_1.actors_[var_81_19.prefab_name] ~= nil then
						local var_81_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_19.prefab_name].transform, "story_v_out_417171", "417171018", "story_v_out_417171.awb")

						arg_78_1:RecordAudio("417171018", var_81_25)
						arg_78_1:RecordAudio("417171018", var_81_25)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417171", "417171018", "story_v_out_417171.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417171", "417171018", "story_v_out_417171.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_26 = math.max(var_81_17, arg_78_1.talkMaxDuration)

			if var_81_16 <= arg_78_1.time_ and arg_78_1.time_ < var_81_16 + var_81_26 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_16) / var_81_26

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_16 + var_81_26 and arg_78_1.time_ < var_81_16 + var_81_26 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417171019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417171019
		arg_82_1.duration_ = 5.03

		local var_82_0 = {
			zh = 3.166,
			ja = 5.033
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
				arg_82_0:Play417171020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10128"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps10128 == nil then
				arg_82_1.var_.actorSpriteComps10128 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps10128 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								local var_85_4 = Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor1.r, var_85_3)
								local var_85_5 = Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor1.g, var_85_3)
								local var_85_6 = Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor1.b, var_85_3)

								iter_85_1.color = Color.New(var_85_4, var_85_5, var_85_6)
							else
								local var_85_7 = Mathf.Lerp(iter_85_1.color.r, 1, var_85_3)

								iter_85_1.color = Color.New(var_85_7, var_85_7, var_85_7)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps10128 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_85_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps10128 = nil
			end

			local var_85_8 = arg_82_1.actors_["10113"]
			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps10113 == nil then
				arg_82_1.var_.actorSpriteComps10113 = var_85_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_10 = 0.2

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_10 and not isNil(var_85_8) then
				local var_85_11 = (arg_82_1.time_ - var_85_9) / var_85_10

				if arg_82_1.var_.actorSpriteComps10113 then
					for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_85_5 then
							if arg_82_1.isInRecall_ then
								local var_85_12 = Mathf.Lerp(iter_85_5.color.r, arg_82_1.hightColor2.r, var_85_11)
								local var_85_13 = Mathf.Lerp(iter_85_5.color.g, arg_82_1.hightColor2.g, var_85_11)
								local var_85_14 = Mathf.Lerp(iter_85_5.color.b, arg_82_1.hightColor2.b, var_85_11)

								iter_85_5.color = Color.New(var_85_12, var_85_13, var_85_14)
							else
								local var_85_15 = Mathf.Lerp(iter_85_5.color.r, 0.5, var_85_11)

								iter_85_5.color = Color.New(var_85_15, var_85_15, var_85_15)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_9 + var_85_10 and arg_82_1.time_ < var_85_9 + var_85_10 + arg_85_0 and not isNil(var_85_8) and arg_82_1.var_.actorSpriteComps10113 then
				for iter_85_6, iter_85_7 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_85_7 then
						if arg_82_1.isInRecall_ then
							iter_85_7.color = arg_82_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_85_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps10113 = nil
			end

			local var_85_16 = 0
			local var_85_17 = 0.35

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_18 = arg_82_1:FormatText(StoryNameCfg[595].name)

				arg_82_1.leftNameTxt_.text = var_85_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_19 = arg_82_1:GetWordFromCfg(417171019)
				local var_85_20 = arg_82_1:FormatText(var_85_19.content)

				arg_82_1.text_.text = var_85_20

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_21 = 14
				local var_85_22 = utf8.len(var_85_20)
				local var_85_23 = var_85_21 <= 0 and var_85_17 or var_85_17 * (var_85_22 / var_85_21)

				if var_85_23 > 0 and var_85_17 < var_85_23 then
					arg_82_1.talkMaxDuration = var_85_23

					if var_85_23 + var_85_16 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_16
					end
				end

				arg_82_1.text_.text = var_85_20
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171019", "story_v_out_417171.awb") ~= 0 then
					local var_85_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171019", "story_v_out_417171.awb") / 1000

					if var_85_24 + var_85_16 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_24 + var_85_16
					end

					if var_85_19.prefab_name ~= "" and arg_82_1.actors_[var_85_19.prefab_name] ~= nil then
						local var_85_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_19.prefab_name].transform, "story_v_out_417171", "417171019", "story_v_out_417171.awb")

						arg_82_1:RecordAudio("417171019", var_85_25)
						arg_82_1:RecordAudio("417171019", var_85_25)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417171", "417171019", "story_v_out_417171.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417171", "417171019", "story_v_out_417171.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_26 = math.max(var_85_17, arg_82_1.talkMaxDuration)

			if var_85_16 <= arg_82_1.time_ and arg_82_1.time_ < var_85_16 + var_85_26 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_16) / var_85_26

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_16 + var_85_26 and arg_82_1.time_ < var_85_16 + var_85_26 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417171020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417171020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play417171021(arg_86_1)
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

			local var_89_8 = 0.05
			local var_89_9 = 1

			if var_89_8 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				local var_89_10 = "play"
				local var_89_11 = "effect"

				arg_86_1:AudioAction(var_89_10, var_89_11, "se_story_1311", "se_story_1311_car01", "")
			end

			local var_89_12 = 0
			local var_89_13 = 0.775

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_14 = arg_86_1:GetWordFromCfg(417171020)
				local var_89_15 = arg_86_1:FormatText(var_89_14.content)

				arg_86_1.text_.text = var_89_15

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_16 = 31
				local var_89_17 = utf8.len(var_89_15)
				local var_89_18 = var_89_16 <= 0 and var_89_13 or var_89_13 * (var_89_17 / var_89_16)

				if var_89_18 > 0 and var_89_13 < var_89_18 then
					arg_86_1.talkMaxDuration = var_89_18

					if var_89_18 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_12
					end
				end

				arg_86_1.text_.text = var_89_15
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_19 = math.max(var_89_13, arg_86_1.talkMaxDuration)

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_19 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_12) / var_89_19

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_12 + var_89_19 and arg_86_1.time_ < var_89_12 + var_89_19 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417171021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417171021
		arg_90_1.duration_ = 2.63

		local var_90_0 = {
			zh = 1.9,
			ja = 2.633
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
				arg_90_0:Play417171022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10113"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10113 == nil then
				arg_90_1.var_.actorSpriteComps10113 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps10113 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 1, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps10113 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps10113 = nil
			end

			local var_93_8 = 0
			local var_93_9 = 0.25

			if var_93_8 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_10 = arg_90_1:FormatText(StoryNameCfg[1117].name)

				arg_90_1.leftNameTxt_.text = var_93_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_11 = arg_90_1:GetWordFromCfg(417171021)
				local var_93_12 = arg_90_1:FormatText(var_93_11.content)

				arg_90_1.text_.text = var_93_12

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171021", "story_v_out_417171.awb") ~= 0 then
					local var_93_16 = manager.audio:GetVoiceLength("story_v_out_417171", "417171021", "story_v_out_417171.awb") / 1000

					if var_93_16 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_16 + var_93_8
					end

					if var_93_11.prefab_name ~= "" and arg_90_1.actors_[var_93_11.prefab_name] ~= nil then
						local var_93_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_11.prefab_name].transform, "story_v_out_417171", "417171021", "story_v_out_417171.awb")

						arg_90_1:RecordAudio("417171021", var_93_17)
						arg_90_1:RecordAudio("417171021", var_93_17)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417171", "417171021", "story_v_out_417171.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417171", "417171021", "story_v_out_417171.awb")
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
	Play417171022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417171022
		arg_94_1.duration_ = 8.6

		local var_94_0 = {
			zh = 7.833,
			ja = 8.6
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
				arg_94_0:Play417171023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10128"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps10128 == nil then
				arg_94_1.var_.actorSpriteComps10128 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps10128 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								local var_97_4 = Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor1.r, var_97_3)
								local var_97_5 = Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor1.g, var_97_3)
								local var_97_6 = Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor1.b, var_97_3)

								iter_97_1.color = Color.New(var_97_4, var_97_5, var_97_6)
							else
								local var_97_7 = Mathf.Lerp(iter_97_1.color.r, 1, var_97_3)

								iter_97_1.color = Color.New(var_97_7, var_97_7, var_97_7)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps10128 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_97_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps10128 = nil
			end

			local var_97_8 = arg_94_1.actors_["10113"]
			local var_97_9 = 0

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 and not isNil(var_97_8) and arg_94_1.var_.actorSpriteComps10113 == nil then
				arg_94_1.var_.actorSpriteComps10113 = var_97_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_10 = 0.2

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_10 and not isNil(var_97_8) then
				local var_97_11 = (arg_94_1.time_ - var_97_9) / var_97_10

				if arg_94_1.var_.actorSpriteComps10113 then
					for iter_97_4, iter_97_5 in pairs(arg_94_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_97_5 then
							if arg_94_1.isInRecall_ then
								local var_97_12 = Mathf.Lerp(iter_97_5.color.r, arg_94_1.hightColor2.r, var_97_11)
								local var_97_13 = Mathf.Lerp(iter_97_5.color.g, arg_94_1.hightColor2.g, var_97_11)
								local var_97_14 = Mathf.Lerp(iter_97_5.color.b, arg_94_1.hightColor2.b, var_97_11)

								iter_97_5.color = Color.New(var_97_12, var_97_13, var_97_14)
							else
								local var_97_15 = Mathf.Lerp(iter_97_5.color.r, 0.5, var_97_11)

								iter_97_5.color = Color.New(var_97_15, var_97_15, var_97_15)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_9 + var_97_10 and arg_94_1.time_ < var_97_9 + var_97_10 + arg_97_0 and not isNil(var_97_8) and arg_94_1.var_.actorSpriteComps10113 then
				for iter_97_6, iter_97_7 in pairs(arg_94_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_97_7 then
						if arg_94_1.isInRecall_ then
							iter_97_7.color = arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_97_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps10113 = nil
			end

			local var_97_16 = 0
			local var_97_17 = 0.775

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_18 = arg_94_1:FormatText(StoryNameCfg[595].name)

				arg_94_1.leftNameTxt_.text = var_97_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_19 = arg_94_1:GetWordFromCfg(417171022)
				local var_97_20 = arg_94_1:FormatText(var_97_19.content)

				arg_94_1.text_.text = var_97_20

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_21 = 31
				local var_97_22 = utf8.len(var_97_20)
				local var_97_23 = var_97_21 <= 0 and var_97_17 or var_97_17 * (var_97_22 / var_97_21)

				if var_97_23 > 0 and var_97_17 < var_97_23 then
					arg_94_1.talkMaxDuration = var_97_23

					if var_97_23 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_23 + var_97_16
					end
				end

				arg_94_1.text_.text = var_97_20
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171022", "story_v_out_417171.awb") ~= 0 then
					local var_97_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171022", "story_v_out_417171.awb") / 1000

					if var_97_24 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_24 + var_97_16
					end

					if var_97_19.prefab_name ~= "" and arg_94_1.actors_[var_97_19.prefab_name] ~= nil then
						local var_97_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_19.prefab_name].transform, "story_v_out_417171", "417171022", "story_v_out_417171.awb")

						arg_94_1:RecordAudio("417171022", var_97_25)
						arg_94_1:RecordAudio("417171022", var_97_25)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417171", "417171022", "story_v_out_417171.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417171", "417171022", "story_v_out_417171.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_26 = math.max(var_97_17, arg_94_1.talkMaxDuration)

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_26 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_16) / var_97_26

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_16 + var_97_26 and arg_94_1.time_ < var_97_16 + var_97_26 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play417171023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417171023
		arg_98_1.duration_ = 12.1

		local var_98_0 = {
			zh = 10.033,
			ja = 12.1
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
				arg_98_0:Play417171024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10113"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps10113 == nil then
				arg_98_1.var_.actorSpriteComps10113 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps10113 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps10113 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_101_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps10113 = nil
			end

			local var_101_8 = arg_98_1.actors_["10128"]
			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.actorSpriteComps10128 == nil then
				arg_98_1.var_.actorSpriteComps10128 = var_101_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_10 = 0.2

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_10 and not isNil(var_101_8) then
				local var_101_11 = (arg_98_1.time_ - var_101_9) / var_101_10

				if arg_98_1.var_.actorSpriteComps10128 then
					for iter_101_4, iter_101_5 in pairs(arg_98_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_101_5 then
							if arg_98_1.isInRecall_ then
								local var_101_12 = Mathf.Lerp(iter_101_5.color.r, arg_98_1.hightColor2.r, var_101_11)
								local var_101_13 = Mathf.Lerp(iter_101_5.color.g, arg_98_1.hightColor2.g, var_101_11)
								local var_101_14 = Mathf.Lerp(iter_101_5.color.b, arg_98_1.hightColor2.b, var_101_11)

								iter_101_5.color = Color.New(var_101_12, var_101_13, var_101_14)
							else
								local var_101_15 = Mathf.Lerp(iter_101_5.color.r, 0.5, var_101_11)

								iter_101_5.color = Color.New(var_101_15, var_101_15, var_101_15)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_9 + var_101_10 and arg_98_1.time_ < var_101_9 + var_101_10 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.actorSpriteComps10128 then
				for iter_101_6, iter_101_7 in pairs(arg_98_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_101_7 then
						if arg_98_1.isInRecall_ then
							iter_101_7.color = arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_101_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps10128 = nil
			end

			local var_101_16 = 0
			local var_101_17 = 1.275

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_18 = arg_98_1:FormatText(StoryNameCfg[1117].name)

				arg_98_1.leftNameTxt_.text = var_101_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_19 = arg_98_1:GetWordFromCfg(417171023)
				local var_101_20 = arg_98_1:FormatText(var_101_19.content)

				arg_98_1.text_.text = var_101_20

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_21 = 51
				local var_101_22 = utf8.len(var_101_20)
				local var_101_23 = var_101_21 <= 0 and var_101_17 or var_101_17 * (var_101_22 / var_101_21)

				if var_101_23 > 0 and var_101_17 < var_101_23 then
					arg_98_1.talkMaxDuration = var_101_23

					if var_101_23 + var_101_16 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_23 + var_101_16
					end
				end

				arg_98_1.text_.text = var_101_20
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171023", "story_v_out_417171.awb") ~= 0 then
					local var_101_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171023", "story_v_out_417171.awb") / 1000

					if var_101_24 + var_101_16 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_16
					end

					if var_101_19.prefab_name ~= "" and arg_98_1.actors_[var_101_19.prefab_name] ~= nil then
						local var_101_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_19.prefab_name].transform, "story_v_out_417171", "417171023", "story_v_out_417171.awb")

						arg_98_1:RecordAudio("417171023", var_101_25)
						arg_98_1:RecordAudio("417171023", var_101_25)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417171", "417171023", "story_v_out_417171.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417171", "417171023", "story_v_out_417171.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_26 = math.max(var_101_17, arg_98_1.talkMaxDuration)

			if var_101_16 <= arg_98_1.time_ and arg_98_1.time_ < var_101_16 + var_101_26 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_16) / var_101_26

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_16 + var_101_26 and arg_98_1.time_ < var_101_16 + var_101_26 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417171024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417171024
		arg_102_1.duration_ = 7.93

		local var_102_0 = {
			zh = 6.466,
			ja = 7.933
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
				arg_102_0:Play417171025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["10128"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps10128 == nil then
				arg_102_1.var_.actorSpriteComps10128 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps10128 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 1, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps10128 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps10128 = nil
			end

			local var_105_8 = arg_102_1.actors_["10113"]
			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps10113 == nil then
				arg_102_1.var_.actorSpriteComps10113 = var_105_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_10 = 0.2

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_10 and not isNil(var_105_8) then
				local var_105_11 = (arg_102_1.time_ - var_105_9) / var_105_10

				if arg_102_1.var_.actorSpriteComps10113 then
					for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_105_5 then
							if arg_102_1.isInRecall_ then
								local var_105_12 = Mathf.Lerp(iter_105_5.color.r, arg_102_1.hightColor2.r, var_105_11)
								local var_105_13 = Mathf.Lerp(iter_105_5.color.g, arg_102_1.hightColor2.g, var_105_11)
								local var_105_14 = Mathf.Lerp(iter_105_5.color.b, arg_102_1.hightColor2.b, var_105_11)

								iter_105_5.color = Color.New(var_105_12, var_105_13, var_105_14)
							else
								local var_105_15 = Mathf.Lerp(iter_105_5.color.r, 0.5, var_105_11)

								iter_105_5.color = Color.New(var_105_15, var_105_15, var_105_15)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_9 + var_105_10 and arg_102_1.time_ < var_105_9 + var_105_10 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps10113 then
				for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_105_7 then
						if arg_102_1.isInRecall_ then
							iter_105_7.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps10113 = nil
			end

			local var_105_16 = 0
			local var_105_17 = 0.7

			if var_105_16 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_18 = arg_102_1:FormatText(StoryNameCfg[595].name)

				arg_102_1.leftNameTxt_.text = var_105_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_19 = arg_102_1:GetWordFromCfg(417171024)
				local var_105_20 = arg_102_1:FormatText(var_105_19.content)

				arg_102_1.text_.text = var_105_20

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_21 = 28
				local var_105_22 = utf8.len(var_105_20)
				local var_105_23 = var_105_21 <= 0 and var_105_17 or var_105_17 * (var_105_22 / var_105_21)

				if var_105_23 > 0 and var_105_17 < var_105_23 then
					arg_102_1.talkMaxDuration = var_105_23

					if var_105_23 + var_105_16 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_16
					end
				end

				arg_102_1.text_.text = var_105_20
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171024", "story_v_out_417171.awb") ~= 0 then
					local var_105_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171024", "story_v_out_417171.awb") / 1000

					if var_105_24 + var_105_16 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_24 + var_105_16
					end

					if var_105_19.prefab_name ~= "" and arg_102_1.actors_[var_105_19.prefab_name] ~= nil then
						local var_105_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_19.prefab_name].transform, "story_v_out_417171", "417171024", "story_v_out_417171.awb")

						arg_102_1:RecordAudio("417171024", var_105_25)
						arg_102_1:RecordAudio("417171024", var_105_25)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417171", "417171024", "story_v_out_417171.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417171", "417171024", "story_v_out_417171.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_26 = math.max(var_105_17, arg_102_1.talkMaxDuration)

			if var_105_16 <= arg_102_1.time_ and arg_102_1.time_ < var_105_16 + var_105_26 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_16) / var_105_26

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_16 + var_105_26 and arg_102_1.time_ < var_105_16 + var_105_26 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play417171025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417171025
		arg_106_1.duration_ = 6.33

		local var_106_0 = {
			zh = 4.033,
			ja = 6.333
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
				arg_106_0:Play417171026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10113"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps10113 == nil then
				arg_106_1.var_.actorSpriteComps10113 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps10113 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps10113 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps10113 = nil
			end

			local var_109_8 = arg_106_1.actors_["10128"]
			local var_109_9 = 0

			if var_109_9 < arg_106_1.time_ and arg_106_1.time_ <= var_109_9 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps10128 == nil then
				arg_106_1.var_.actorSpriteComps10128 = var_109_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_10 = 0.2

			if var_109_9 <= arg_106_1.time_ and arg_106_1.time_ < var_109_9 + var_109_10 and not isNil(var_109_8) then
				local var_109_11 = (arg_106_1.time_ - var_109_9) / var_109_10

				if arg_106_1.var_.actorSpriteComps10128 then
					for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_109_5 then
							if arg_106_1.isInRecall_ then
								local var_109_12 = Mathf.Lerp(iter_109_5.color.r, arg_106_1.hightColor2.r, var_109_11)
								local var_109_13 = Mathf.Lerp(iter_109_5.color.g, arg_106_1.hightColor2.g, var_109_11)
								local var_109_14 = Mathf.Lerp(iter_109_5.color.b, arg_106_1.hightColor2.b, var_109_11)

								iter_109_5.color = Color.New(var_109_12, var_109_13, var_109_14)
							else
								local var_109_15 = Mathf.Lerp(iter_109_5.color.r, 0.5, var_109_11)

								iter_109_5.color = Color.New(var_109_15, var_109_15, var_109_15)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_9 + var_109_10 and arg_106_1.time_ < var_109_9 + var_109_10 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps10128 then
				for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_109_7 then
						if arg_106_1.isInRecall_ then
							iter_109_7.color = arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_109_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps10128 = nil
			end

			local var_109_16 = arg_106_1.actors_["10113"].transform
			local var_109_17 = 0

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.var_.moveOldPos10113 = var_109_16.localPosition
				var_109_16.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("10113", 4)

				local var_109_18 = var_109_16.childCount

				for iter_109_8 = 0, var_109_18 - 1 do
					local var_109_19 = var_109_16:GetChild(iter_109_8)

					if var_109_19.name == "split_6" or not string.find(var_109_19.name, "split") then
						var_109_19.gameObject:SetActive(true)
					else
						var_109_19.gameObject:SetActive(false)
					end
				end
			end

			local var_109_20 = 0.001

			if var_109_17 <= arg_106_1.time_ and arg_106_1.time_ < var_109_17 + var_109_20 then
				local var_109_21 = (arg_106_1.time_ - var_109_17) / var_109_20
				local var_109_22 = Vector3.New(377.3, -328.4, -517.4)

				var_109_16.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10113, var_109_22, var_109_21)
			end

			if arg_106_1.time_ >= var_109_17 + var_109_20 and arg_106_1.time_ < var_109_17 + var_109_20 + arg_109_0 then
				var_109_16.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_109_23 = 0
			local var_109_24 = 0.5

			if var_109_23 < arg_106_1.time_ and arg_106_1.time_ <= var_109_23 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_25 = arg_106_1:FormatText(StoryNameCfg[1117].name)

				arg_106_1.leftNameTxt_.text = var_109_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_26 = arg_106_1:GetWordFromCfg(417171025)
				local var_109_27 = arg_106_1:FormatText(var_109_26.content)

				arg_106_1.text_.text = var_109_27

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_28 = 20
				local var_109_29 = utf8.len(var_109_27)
				local var_109_30 = var_109_28 <= 0 and var_109_24 or var_109_24 * (var_109_29 / var_109_28)

				if var_109_30 > 0 and var_109_24 < var_109_30 then
					arg_106_1.talkMaxDuration = var_109_30

					if var_109_30 + var_109_23 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_30 + var_109_23
					end
				end

				arg_106_1.text_.text = var_109_27
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171025", "story_v_out_417171.awb") ~= 0 then
					local var_109_31 = manager.audio:GetVoiceLength("story_v_out_417171", "417171025", "story_v_out_417171.awb") / 1000

					if var_109_31 + var_109_23 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_31 + var_109_23
					end

					if var_109_26.prefab_name ~= "" and arg_106_1.actors_[var_109_26.prefab_name] ~= nil then
						local var_109_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_26.prefab_name].transform, "story_v_out_417171", "417171025", "story_v_out_417171.awb")

						arg_106_1:RecordAudio("417171025", var_109_32)
						arg_106_1:RecordAudio("417171025", var_109_32)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417171", "417171025", "story_v_out_417171.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417171", "417171025", "story_v_out_417171.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_33 = math.max(var_109_24, arg_106_1.talkMaxDuration)

			if var_109_23 <= arg_106_1.time_ and arg_106_1.time_ < var_109_23 + var_109_33 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_23) / var_109_33

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_23 + var_109_33 and arg_106_1.time_ < var_109_23 + var_109_33 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
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

		arg_106_1:InitPlayNodeList()
	end,
	Play417171026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417171026
		arg_110_1.duration_ = 5.5

		local var_110_0 = {
			zh = 3.933,
			ja = 5.5
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
				arg_110_0:Play417171027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10128"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps10128 == nil then
				arg_110_1.var_.actorSpriteComps10128 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps10128 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								local var_113_4 = Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor1.r, var_113_3)
								local var_113_5 = Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor1.g, var_113_3)
								local var_113_6 = Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor1.b, var_113_3)

								iter_113_1.color = Color.New(var_113_4, var_113_5, var_113_6)
							else
								local var_113_7 = Mathf.Lerp(iter_113_1.color.r, 1, var_113_3)

								iter_113_1.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps10128 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_113_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps10128 = nil
			end

			local var_113_8 = arg_110_1.actors_["10113"]
			local var_113_9 = 0

			if var_113_9 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.actorSpriteComps10113 == nil then
				arg_110_1.var_.actorSpriteComps10113 = var_113_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_10 = 0.2

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 and not isNil(var_113_8) then
				local var_113_11 = (arg_110_1.time_ - var_113_9) / var_113_10

				if arg_110_1.var_.actorSpriteComps10113 then
					for iter_113_4, iter_113_5 in pairs(arg_110_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_113_5 then
							if arg_110_1.isInRecall_ then
								local var_113_12 = Mathf.Lerp(iter_113_5.color.r, arg_110_1.hightColor2.r, var_113_11)
								local var_113_13 = Mathf.Lerp(iter_113_5.color.g, arg_110_1.hightColor2.g, var_113_11)
								local var_113_14 = Mathf.Lerp(iter_113_5.color.b, arg_110_1.hightColor2.b, var_113_11)

								iter_113_5.color = Color.New(var_113_12, var_113_13, var_113_14)
							else
								local var_113_15 = Mathf.Lerp(iter_113_5.color.r, 0.5, var_113_11)

								iter_113_5.color = Color.New(var_113_15, var_113_15, var_113_15)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.actorSpriteComps10113 then
				for iter_113_6, iter_113_7 in pairs(arg_110_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_113_7 then
						if arg_110_1.isInRecall_ then
							iter_113_7.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps10113 = nil
			end

			local var_113_16 = 0
			local var_113_17 = 0.45

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_18 = arg_110_1:FormatText(StoryNameCfg[595].name)

				arg_110_1.leftNameTxt_.text = var_113_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_19 = arg_110_1:GetWordFromCfg(417171026)
				local var_113_20 = arg_110_1:FormatText(var_113_19.content)

				arg_110_1.text_.text = var_113_20

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_21 = 18
				local var_113_22 = utf8.len(var_113_20)
				local var_113_23 = var_113_21 <= 0 and var_113_17 or var_113_17 * (var_113_22 / var_113_21)

				if var_113_23 > 0 and var_113_17 < var_113_23 then
					arg_110_1.talkMaxDuration = var_113_23

					if var_113_23 + var_113_16 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_23 + var_113_16
					end
				end

				arg_110_1.text_.text = var_113_20
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171026", "story_v_out_417171.awb") ~= 0 then
					local var_113_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171026", "story_v_out_417171.awb") / 1000

					if var_113_24 + var_113_16 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_24 + var_113_16
					end

					if var_113_19.prefab_name ~= "" and arg_110_1.actors_[var_113_19.prefab_name] ~= nil then
						local var_113_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_19.prefab_name].transform, "story_v_out_417171", "417171026", "story_v_out_417171.awb")

						arg_110_1:RecordAudio("417171026", var_113_25)
						arg_110_1:RecordAudio("417171026", var_113_25)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417171", "417171026", "story_v_out_417171.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417171", "417171026", "story_v_out_417171.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_26 = math.max(var_113_17, arg_110_1.talkMaxDuration)

			if var_113_16 <= arg_110_1.time_ and arg_110_1.time_ < var_113_16 + var_113_26 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_16) / var_113_26

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_16 + var_113_26 and arg_110_1.time_ < var_113_16 + var_113_26 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play417171027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417171027
		arg_114_1.duration_ = 9

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play417171028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 4

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			local var_117_1 = 0.666666666666667

			if arg_114_1.time_ >= var_117_0 + var_117_1 and arg_114_1.time_ < var_117_0 + var_117_1 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_2 = "I17f"

			if arg_114_1.bgs_[var_117_2] == nil then
				local var_117_3 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_117_2)
				var_117_3.name = var_117_2
				var_117_3.transform.parent = arg_114_1.stage_.transform
				var_117_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_[var_117_2] = var_117_3
			end

			local var_117_4 = 2

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				local var_117_5 = manager.ui.mainCamera.transform.localPosition
				local var_117_6 = Vector3.New(0, 0, 10) + Vector3.New(var_117_5.x, var_117_5.y, 0)
				local var_117_7 = arg_114_1.bgs_.I17f

				var_117_7.transform.localPosition = var_117_6
				var_117_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_8 = var_117_7:GetComponent("SpriteRenderer")

				if var_117_8 and var_117_8.sprite then
					local var_117_9 = (var_117_7.transform.localPosition - var_117_5).z
					local var_117_10 = manager.ui.mainCameraCom_
					local var_117_11 = 2 * var_117_9 * Mathf.Tan(var_117_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_117_12 = var_117_11 * var_117_10.aspect
					local var_117_13 = var_117_8.sprite.bounds.size.x
					local var_117_14 = var_117_8.sprite.bounds.size.y
					local var_117_15 = var_117_12 / var_117_13
					local var_117_16 = var_117_11 / var_117_14
					local var_117_17 = var_117_16 < var_117_15 and var_117_15 or var_117_16

					var_117_7.transform.localScale = Vector3.New(var_117_17, var_117_17, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "I17f" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_18 = 0

			if var_117_18 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_19 = 2

			if var_117_18 <= arg_114_1.time_ and arg_114_1.time_ < var_117_18 + var_117_19 then
				local var_117_20 = (arg_114_1.time_ - var_117_18) / var_117_19
				local var_117_21 = Color.New(0, 0, 0)

				var_117_21.a = Mathf.Lerp(0, 1, var_117_20)
				arg_114_1.mask_.color = var_117_21
			end

			if arg_114_1.time_ >= var_117_18 + var_117_19 and arg_114_1.time_ < var_117_18 + var_117_19 + arg_117_0 then
				local var_117_22 = Color.New(0, 0, 0)

				var_117_22.a = 1
				arg_114_1.mask_.color = var_117_22
			end

			local var_117_23 = 2

			if var_117_23 < arg_114_1.time_ and arg_114_1.time_ <= var_117_23 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_24 = 2

			if var_117_23 <= arg_114_1.time_ and arg_114_1.time_ < var_117_23 + var_117_24 then
				local var_117_25 = (arg_114_1.time_ - var_117_23) / var_117_24
				local var_117_26 = Color.New(0, 0, 0)

				var_117_26.a = Mathf.Lerp(1, 0, var_117_25)
				arg_114_1.mask_.color = var_117_26
			end

			if arg_114_1.time_ >= var_117_23 + var_117_24 and arg_114_1.time_ < var_117_23 + var_117_24 + arg_117_0 then
				local var_117_27 = Color.New(0, 0, 0)
				local var_117_28 = 0

				arg_114_1.mask_.enabled = false
				var_117_27.a = var_117_28
				arg_114_1.mask_.color = var_117_27
			end

			local var_117_29 = arg_114_1.actors_["10128"].transform
			local var_117_30 = 1.966

			if var_117_30 < arg_114_1.time_ and arg_114_1.time_ <= var_117_30 + arg_117_0 then
				arg_114_1.var_.moveOldPos10128 = var_117_29.localPosition
				var_117_29.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("10128", 7)

				local var_117_31 = var_117_29.childCount

				for iter_117_2 = 0, var_117_31 - 1 do
					local var_117_32 = var_117_29:GetChild(iter_117_2)

					if var_117_32.name == "" or not string.find(var_117_32.name, "split") then
						var_117_32.gameObject:SetActive(true)
					else
						var_117_32.gameObject:SetActive(false)
					end
				end
			end

			local var_117_33 = 0.001

			if var_117_30 <= arg_114_1.time_ and arg_114_1.time_ < var_117_30 + var_117_33 then
				local var_117_34 = (arg_114_1.time_ - var_117_30) / var_117_33
				local var_117_35 = Vector3.New(0, -2000, -300)

				var_117_29.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10128, var_117_35, var_117_34)
			end

			if arg_114_1.time_ >= var_117_30 + var_117_33 and arg_114_1.time_ < var_117_30 + var_117_33 + arg_117_0 then
				var_117_29.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_117_36 = arg_114_1.actors_["10113"].transform
			local var_117_37 = 1.966

			if var_117_37 < arg_114_1.time_ and arg_114_1.time_ <= var_117_37 + arg_117_0 then
				arg_114_1.var_.moveOldPos10113 = var_117_36.localPosition
				var_117_36.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("10113", 7)

				local var_117_38 = var_117_36.childCount

				for iter_117_3 = 0, var_117_38 - 1 do
					local var_117_39 = var_117_36:GetChild(iter_117_3)

					if var_117_39.name == "" or not string.find(var_117_39.name, "split") then
						var_117_39.gameObject:SetActive(true)
					else
						var_117_39.gameObject:SetActive(false)
					end
				end
			end

			local var_117_40 = 0.001

			if var_117_37 <= arg_114_1.time_ and arg_114_1.time_ < var_117_37 + var_117_40 then
				local var_117_41 = (arg_114_1.time_ - var_117_37) / var_117_40
				local var_117_42 = Vector3.New(0, -2000, 0)

				var_117_36.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10113, var_117_42, var_117_41)
			end

			if arg_114_1.time_ >= var_117_37 + var_117_40 and arg_114_1.time_ < var_117_37 + var_117_40 + arg_117_0 then
				var_117_36.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_43 = 4
			local var_117_44 = 1

			if var_117_43 < arg_114_1.time_ and arg_114_1.time_ <= var_117_43 + arg_117_0 then
				local var_117_45 = "play"
				local var_117_46 = "effect"

				arg_114_1:AudioAction(var_117_45, var_117_46, "se_story_1310", "se_story_1310_car02", "")
			end

			local var_117_47 = 1.7
			local var_117_48 = 1

			if var_117_47 < arg_114_1.time_ and arg_114_1.time_ <= var_117_47 + arg_117_0 then
				local var_117_49 = "play"
				local var_117_50 = "effect"

				arg_114_1:AudioAction(var_117_49, var_117_50, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_117_51 = 0
			local var_117_52 = 0.2

			if var_117_51 < arg_114_1.time_ and arg_114_1.time_ <= var_117_51 + arg_117_0 then
				local var_117_53 = "play"
				local var_117_54 = "music"

				arg_114_1:AudioAction(var_117_53, var_117_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_117_55 = ""
				local var_117_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_117_56 ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_56 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_56

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_56
						arg_114_1.bgmTxt2_.text = var_117_56
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_117_57 = 1.7
			local var_117_58 = 1

			if var_117_57 < arg_114_1.time_ and arg_114_1.time_ <= var_117_57 + arg_117_0 then
				local var_117_59 = "play"
				local var_117_60 = "music"

				arg_114_1:AudioAction(var_117_59, var_117_60, "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain.awb")

				local var_117_61 = ""
				local var_117_62 = manager.audio:GetAudioName("bgm_activity_3_10_story_mountain", "bgm_activity_3_10_story_mountain")

				if var_117_62 ~= "" then
					if arg_114_1.bgmTxt_.text ~= var_117_62 and arg_114_1.bgmTxt_.text ~= "" then
						if arg_114_1.bgmTxt2_.text ~= "" then
							arg_114_1.bgmTxt_.text = arg_114_1.bgmTxt2_.text
						end

						arg_114_1.bgmTxt2_.text = var_117_62

						arg_114_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_114_1.bgmTxt_.text = var_117_62
						arg_114_1.bgmTxt2_.text = var_117_62
					end

					if arg_114_1.bgmTimer then
						arg_114_1.bgmTimer:Stop()

						arg_114_1.bgmTimer = nil
					end

					if arg_114_1.settingData.show_music_name == 1 then
						arg_114_1.musicController:SetSelectedState("show")
						arg_114_1.musicAnimator_:Play("open", 0, 0)

						if arg_114_1.settingData.music_time ~= 0 then
							arg_114_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_114_1.settingData.music_time), function()
								if arg_114_1 == nil or isNil(arg_114_1.bgmTxt_) then
									return
								end

								arg_114_1.musicController:SetSelectedState("hide")
								arg_114_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_63 = 3.999999999999
			local var_117_64 = 1.225

			if var_117_63 < arg_114_1.time_ and arg_114_1.time_ <= var_117_63 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_65 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_65:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_114_1.dialogCg_.alpha = arg_120_0
				end))
				var_117_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_66 = arg_114_1:GetWordFromCfg(417171027)
				local var_117_67 = arg_114_1:FormatText(var_117_66.content)

				arg_114_1.text_.text = var_117_67

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_68 = 49
				local var_117_69 = utf8.len(var_117_67)
				local var_117_70 = var_117_68 <= 0 and var_117_64 or var_117_64 * (var_117_69 / var_117_68)

				if var_117_70 > 0 and var_117_64 < var_117_70 then
					arg_114_1.talkMaxDuration = var_117_70
					var_117_63 = var_117_63 + 0.3

					if var_117_70 + var_117_63 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_70 + var_117_63
					end
				end

				arg_114_1.text_.text = var_117_67
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_71 = var_117_63 + 0.3
			local var_117_72 = math.max(var_117_64, arg_114_1.talkMaxDuration)

			if var_117_71 <= arg_114_1.time_ and arg_114_1.time_ < var_117_71 + var_117_72 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_71) / var_117_72

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_71 + var_117_72 and arg_114_1.time_ < var_117_71 + var_117_72 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play417171028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417171028
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play417171029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 1.4

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(417171028)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 56
				local var_125_5 = utf8.len(var_125_3)
				local var_125_6 = var_125_4 <= 0 and var_125_1 or var_125_1 * (var_125_5 / var_125_4)

				if var_125_6 > 0 and var_125_1 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_7 and arg_122_1.time_ < var_125_0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play417171029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417171029
		arg_126_1.duration_ = 5.83

		local var_126_0 = {
			zh = 2.733,
			ja = 5.833
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
				arg_126_0:Play417171030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "10120"

			if arg_126_1.actors_[var_129_0] == nil then
				local var_129_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10120")

				if not isNil(var_129_1) then
					local var_129_2 = Object.Instantiate(var_129_1, arg_126_1.canvasGo_.transform)

					var_129_2.transform:SetSiblingIndex(1)

					var_129_2.name = var_129_0
					var_129_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_126_1.actors_[var_129_0] = var_129_2

					local var_129_3 = var_129_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_126_1.isInRecall_ then
						for iter_129_0, iter_129_1 in ipairs(var_129_3) do
							iter_129_1.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_129_4 = arg_126_1.actors_["10120"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.actorSpriteComps10120 == nil then
				arg_126_1.var_.actorSpriteComps10120 = var_129_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_6 = 0.2

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.actorSpriteComps10120 then
					for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_129_3 then
							if arg_126_1.isInRecall_ then
								local var_129_8 = Mathf.Lerp(iter_129_3.color.r, arg_126_1.hightColor1.r, var_129_7)
								local var_129_9 = Mathf.Lerp(iter_129_3.color.g, arg_126_1.hightColor1.g, var_129_7)
								local var_129_10 = Mathf.Lerp(iter_129_3.color.b, arg_126_1.hightColor1.b, var_129_7)

								iter_129_3.color = Color.New(var_129_8, var_129_9, var_129_10)
							else
								local var_129_11 = Mathf.Lerp(iter_129_3.color.r, 1, var_129_7)

								iter_129_3.color = Color.New(var_129_11, var_129_11, var_129_11)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.actorSpriteComps10120 then
				for iter_129_4, iter_129_5 in pairs(arg_126_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_129_5 then
						if arg_126_1.isInRecall_ then
							iter_129_5.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps10120 = nil
			end

			local var_129_12 = arg_126_1.actors_["10120"].transform
			local var_129_13 = 0

			if var_129_13 < arg_126_1.time_ and arg_126_1.time_ <= var_129_13 + arg_129_0 then
				arg_126_1.var_.moveOldPos10120 = var_129_12.localPosition
				var_129_12.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("10120", 3)

				local var_129_14 = var_129_12.childCount

				for iter_129_6 = 0, var_129_14 - 1 do
					local var_129_15 = var_129_12:GetChild(iter_129_6)

					if var_129_15.name == "" or not string.find(var_129_15.name, "split") then
						var_129_15.gameObject:SetActive(true)
					else
						var_129_15.gameObject:SetActive(false)
					end
				end
			end

			local var_129_16 = 0.001

			if var_129_13 <= arg_126_1.time_ and arg_126_1.time_ < var_129_13 + var_129_16 then
				local var_129_17 = (arg_126_1.time_ - var_129_13) / var_129_16
				local var_129_18 = Vector3.New(0, -260.5, -275)

				var_129_12.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10120, var_129_18, var_129_17)
			end

			if arg_126_1.time_ >= var_129_13 + var_129_16 and arg_126_1.time_ < var_129_13 + var_129_16 + arg_129_0 then
				var_129_12.localPosition = Vector3.New(0, -260.5, -275)
			end

			local var_129_19 = 0
			local var_129_20 = 0.3

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_21 = arg_126_1:FormatText(StoryNameCfg[1141].name)

				arg_126_1.leftNameTxt_.text = var_129_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_22 = arg_126_1:GetWordFromCfg(417171029)
				local var_129_23 = arg_126_1:FormatText(var_129_22.content)

				arg_126_1.text_.text = var_129_23

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_24 = 12
				local var_129_25 = utf8.len(var_129_23)
				local var_129_26 = var_129_24 <= 0 and var_129_20 or var_129_20 * (var_129_25 / var_129_24)

				if var_129_26 > 0 and var_129_20 < var_129_26 then
					arg_126_1.talkMaxDuration = var_129_26

					if var_129_26 + var_129_19 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_26 + var_129_19
					end
				end

				arg_126_1.text_.text = var_129_23
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171029", "story_v_out_417171.awb") ~= 0 then
					local var_129_27 = manager.audio:GetVoiceLength("story_v_out_417171", "417171029", "story_v_out_417171.awb") / 1000

					if var_129_27 + var_129_19 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_27 + var_129_19
					end

					if var_129_22.prefab_name ~= "" and arg_126_1.actors_[var_129_22.prefab_name] ~= nil then
						local var_129_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_22.prefab_name].transform, "story_v_out_417171", "417171029", "story_v_out_417171.awb")

						arg_126_1:RecordAudio("417171029", var_129_28)
						arg_126_1:RecordAudio("417171029", var_129_28)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_417171", "417171029", "story_v_out_417171.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_417171", "417171029", "story_v_out_417171.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_29 = math.max(var_129_20, arg_126_1.talkMaxDuration)

			if var_129_19 <= arg_126_1.time_ and arg_126_1.time_ < var_129_19 + var_129_29 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_19) / var_129_29

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_19 + var_129_29 and arg_126_1.time_ < var_129_19 + var_129_29 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play417171030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417171030
		arg_130_1.duration_ = 2.23

		local var_130_0 = {
			zh = 1.766,
			ja = 2.233
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play417171031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["10128"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps10128 == nil then
				arg_130_1.var_.actorSpriteComps10128 = var_133_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.actorSpriteComps10128 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								local var_133_4 = Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor1.r, var_133_3)
								local var_133_5 = Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor1.g, var_133_3)
								local var_133_6 = Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor1.b, var_133_3)

								iter_133_1.color = Color.New(var_133_4, var_133_5, var_133_6)
							else
								local var_133_7 = Mathf.Lerp(iter_133_1.color.r, 1, var_133_3)

								iter_133_1.color = Color.New(var_133_7, var_133_7, var_133_7)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps10128 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_133_3 then
						if arg_130_1.isInRecall_ then
							iter_133_3.color = arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_133_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps10128 = nil
			end

			local var_133_8 = arg_130_1.actors_["10128"].transform
			local var_133_9 = 0

			if var_133_9 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				arg_130_1.var_.moveOldPos10128 = var_133_8.localPosition
				var_133_8.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("10128", 3)

				local var_133_10 = var_133_8.childCount

				for iter_133_4 = 0, var_133_10 - 1 do
					local var_133_11 = var_133_8:GetChild(iter_133_4)

					if var_133_11.name == "" or not string.find(var_133_11.name, "split") then
						var_133_11.gameObject:SetActive(true)
					else
						var_133_11.gameObject:SetActive(false)
					end
				end
			end

			local var_133_12 = 0.001

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_12 then
				local var_133_13 = (arg_130_1.time_ - var_133_9) / var_133_12
				local var_133_14 = Vector3.New(0, -347, -300)

				var_133_8.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10128, var_133_14, var_133_13)
			end

			if arg_130_1.time_ >= var_133_9 + var_133_12 and arg_130_1.time_ < var_133_9 + var_133_12 + arg_133_0 then
				var_133_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_133_15 = 0
			local var_133_16 = 0.225

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_17 = arg_130_1:FormatText(StoryNameCfg[595].name)

				arg_130_1.leftNameTxt_.text = var_133_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_18 = arg_130_1:GetWordFromCfg(417171030)
				local var_133_19 = arg_130_1:FormatText(var_133_18.content)

				arg_130_1.text_.text = var_133_19

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_20 = 9
				local var_133_21 = utf8.len(var_133_19)
				local var_133_22 = var_133_20 <= 0 and var_133_16 or var_133_16 * (var_133_21 / var_133_20)

				if var_133_22 > 0 and var_133_16 < var_133_22 then
					arg_130_1.talkMaxDuration = var_133_22

					if var_133_22 + var_133_15 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_22 + var_133_15
					end
				end

				arg_130_1.text_.text = var_133_19
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171030", "story_v_out_417171.awb") ~= 0 then
					local var_133_23 = manager.audio:GetVoiceLength("story_v_out_417171", "417171030", "story_v_out_417171.awb") / 1000

					if var_133_23 + var_133_15 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_23 + var_133_15
					end

					if var_133_18.prefab_name ~= "" and arg_130_1.actors_[var_133_18.prefab_name] ~= nil then
						local var_133_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_18.prefab_name].transform, "story_v_out_417171", "417171030", "story_v_out_417171.awb")

						arg_130_1:RecordAudio("417171030", var_133_24)
						arg_130_1:RecordAudio("417171030", var_133_24)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417171", "417171030", "story_v_out_417171.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417171", "417171030", "story_v_out_417171.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_25 = math.max(var_133_16, arg_130_1.talkMaxDuration)

			if var_133_15 <= arg_130_1.time_ and arg_130_1.time_ < var_133_15 + var_133_25 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_15) / var_133_25

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_15 + var_133_25 and arg_130_1.time_ < var_133_15 + var_133_25 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play417171031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417171031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play417171032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["10128"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps10128 == nil then
				arg_134_1.var_.actorSpriteComps10128 = var_137_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.actorSpriteComps10128 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								local var_137_4 = Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor2.r, var_137_3)
								local var_137_5 = Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor2.g, var_137_3)
								local var_137_6 = Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor2.b, var_137_3)

								iter_137_1.color = Color.New(var_137_4, var_137_5, var_137_6)
							else
								local var_137_7 = Mathf.Lerp(iter_137_1.color.r, 0.5, var_137_3)

								iter_137_1.color = Color.New(var_137_7, var_137_7, var_137_7)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.actorSpriteComps10128 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_137_3 then
						if arg_134_1.isInRecall_ then
							iter_137_3.color = arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_137_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_134_1.var_.actorSpriteComps10128 = nil
			end

			local var_137_8 = 1.63333333333333
			local var_137_9 = 1

			if var_137_8 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 then
				local var_137_10 = "play"
				local var_137_11 = "effect"

				arg_134_1:AudioAction(var_137_10, var_137_11, "se_story_1311", "se_story_1311_knockcar", "")
			end

			local var_137_12 = 0
			local var_137_13 = 1

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				local var_137_14 = "play"
				local var_137_15 = "effect"

				arg_134_1:AudioAction(var_137_14, var_137_15, "se_story_1310", "se_story_1310_cardoor03", "")
			end

			local var_137_16 = 0
			local var_137_17 = 0.9

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_18 = arg_134_1:GetWordFromCfg(417171031)
				local var_137_19 = arg_134_1:FormatText(var_137_18.content)

				arg_134_1.text_.text = var_137_19

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_20 = 36
				local var_137_21 = utf8.len(var_137_19)
				local var_137_22 = var_137_20 <= 0 and var_137_17 or var_137_17 * (var_137_21 / var_137_20)

				if var_137_22 > 0 and var_137_17 < var_137_22 then
					arg_134_1.talkMaxDuration = var_137_22

					if var_137_22 + var_137_16 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_22 + var_137_16
					end
				end

				arg_134_1.text_.text = var_137_19
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_23 = math.max(var_137_17, arg_134_1.talkMaxDuration)

			if var_137_16 <= arg_134_1.time_ and arg_134_1.time_ < var_137_16 + var_137_23 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_16) / var_137_23

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_16 + var_137_23 and arg_134_1.time_ < var_137_16 + var_137_23 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417171032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417171032
		arg_138_1.duration_ = 4.9

		local var_138_0 = {
			zh = 1.866,
			ja = 4.9
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
				arg_138_0:Play417171033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10120"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10120 == nil then
				arg_138_1.var_.actorSpriteComps10120 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps10120 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								local var_141_4 = Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, var_141_3)
								local var_141_5 = Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, var_141_3)
								local var_141_6 = Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, var_141_3)

								iter_141_1.color = Color.New(var_141_4, var_141_5, var_141_6)
							else
								local var_141_7 = Mathf.Lerp(iter_141_1.color.r, 1, var_141_3)

								iter_141_1.color = Color.New(var_141_7, var_141_7, var_141_7)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10120 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_141_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10120 = nil
			end

			local var_141_8 = arg_138_1.actors_["10120"].transform
			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1.var_.moveOldPos10120 = var_141_8.localPosition
				var_141_8.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10120", 4)

				local var_141_10 = var_141_8.childCount

				for iter_141_4 = 0, var_141_10 - 1 do
					local var_141_11 = var_141_8:GetChild(iter_141_4)

					if var_141_11.name == "" or not string.find(var_141_11.name, "split") then
						var_141_11.gameObject:SetActive(true)
					else
						var_141_11.gameObject:SetActive(false)
					end
				end
			end

			local var_141_12 = 0.001

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_12 then
				local var_141_13 = (arg_138_1.time_ - var_141_9) / var_141_12
				local var_141_14 = Vector3.New(390, -260.5, -275)

				var_141_8.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10120, var_141_14, var_141_13)
			end

			if arg_138_1.time_ >= var_141_9 + var_141_12 and arg_138_1.time_ < var_141_9 + var_141_12 + arg_141_0 then
				var_141_8.localPosition = Vector3.New(390, -260.5, -275)
			end

			local var_141_15 = arg_138_1.actors_["10128"].transform
			local var_141_16 = 0

			if var_141_16 < arg_138_1.time_ and arg_138_1.time_ <= var_141_16 + arg_141_0 then
				arg_138_1.var_.moveOldPos10128 = var_141_15.localPosition
				var_141_15.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10128", 2)

				local var_141_17 = var_141_15.childCount

				for iter_141_5 = 0, var_141_17 - 1 do
					local var_141_18 = var_141_15:GetChild(iter_141_5)

					if var_141_18.name == "" or not string.find(var_141_18.name, "split") then
						var_141_18.gameObject:SetActive(true)
					else
						var_141_18.gameObject:SetActive(false)
					end
				end
			end

			local var_141_19 = 0.001

			if var_141_16 <= arg_138_1.time_ and arg_138_1.time_ < var_141_16 + var_141_19 then
				local var_141_20 = (arg_138_1.time_ - var_141_16) / var_141_19
				local var_141_21 = Vector3.New(-390, -347, -300)

				var_141_15.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10128, var_141_21, var_141_20)
			end

			if arg_138_1.time_ >= var_141_16 + var_141_19 and arg_138_1.time_ < var_141_16 + var_141_19 + arg_141_0 then
				var_141_15.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_141_22 = arg_138_1.actors_["10128"]
			local var_141_23 = 0

			if var_141_23 < arg_138_1.time_ and arg_138_1.time_ <= var_141_23 + arg_141_0 and not isNil(var_141_22) and arg_138_1.var_.actorSpriteComps10128 == nil then
				arg_138_1.var_.actorSpriteComps10128 = var_141_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_24 = 0.2

			if var_141_23 <= arg_138_1.time_ and arg_138_1.time_ < var_141_23 + var_141_24 and not isNil(var_141_22) then
				local var_141_25 = (arg_138_1.time_ - var_141_23) / var_141_24

				if arg_138_1.var_.actorSpriteComps10128 then
					for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_141_7 then
							if arg_138_1.isInRecall_ then
								local var_141_26 = Mathf.Lerp(iter_141_7.color.r, arg_138_1.hightColor2.r, var_141_25)
								local var_141_27 = Mathf.Lerp(iter_141_7.color.g, arg_138_1.hightColor2.g, var_141_25)
								local var_141_28 = Mathf.Lerp(iter_141_7.color.b, arg_138_1.hightColor2.b, var_141_25)

								iter_141_7.color = Color.New(var_141_26, var_141_27, var_141_28)
							else
								local var_141_29 = Mathf.Lerp(iter_141_7.color.r, 0.5, var_141_25)

								iter_141_7.color = Color.New(var_141_29, var_141_29, var_141_29)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_23 + var_141_24 and arg_138_1.time_ < var_141_23 + var_141_24 + arg_141_0 and not isNil(var_141_22) and arg_138_1.var_.actorSpriteComps10128 then
				for iter_141_8, iter_141_9 in pairs(arg_138_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_141_9 then
						if arg_138_1.isInRecall_ then
							iter_141_9.color = arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_141_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10128 = nil
			end

			local var_141_30 = 0
			local var_141_31 = 0.225

			if var_141_30 < arg_138_1.time_ and arg_138_1.time_ <= var_141_30 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_32 = arg_138_1:FormatText(StoryNameCfg[1141].name)

				arg_138_1.leftNameTxt_.text = var_141_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_33 = arg_138_1:GetWordFromCfg(417171032)
				local var_141_34 = arg_138_1:FormatText(var_141_33.content)

				arg_138_1.text_.text = var_141_34

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_35 = 9
				local var_141_36 = utf8.len(var_141_34)
				local var_141_37 = var_141_35 <= 0 and var_141_31 or var_141_31 * (var_141_36 / var_141_35)

				if var_141_37 > 0 and var_141_31 < var_141_37 then
					arg_138_1.talkMaxDuration = var_141_37

					if var_141_37 + var_141_30 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_37 + var_141_30
					end
				end

				arg_138_1.text_.text = var_141_34
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171032", "story_v_out_417171.awb") ~= 0 then
					local var_141_38 = manager.audio:GetVoiceLength("story_v_out_417171", "417171032", "story_v_out_417171.awb") / 1000

					if var_141_38 + var_141_30 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_38 + var_141_30
					end

					if var_141_33.prefab_name ~= "" and arg_138_1.actors_[var_141_33.prefab_name] ~= nil then
						local var_141_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_33.prefab_name].transform, "story_v_out_417171", "417171032", "story_v_out_417171.awb")

						arg_138_1:RecordAudio("417171032", var_141_39)
						arg_138_1:RecordAudio("417171032", var_141_39)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417171", "417171032", "story_v_out_417171.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417171", "417171032", "story_v_out_417171.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_40 = math.max(var_141_31, arg_138_1.talkMaxDuration)

			if var_141_30 <= arg_138_1.time_ and arg_138_1.time_ < var_141_30 + var_141_40 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_30) / var_141_40

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_30 + var_141_40 and arg_138_1.time_ < var_141_30 + var_141_40 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10120",
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

		arg_138_1:InitPlayNodeList()
	end,
	Play417171033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417171033
		arg_142_1.duration_ = 8.47

		local var_142_0 = {
			zh = 6.766,
			ja = 8.466
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
				arg_142_0:Play417171034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10128"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10128 == nil then
				arg_142_1.var_.actorSpriteComps10128 = var_145_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.actorSpriteComps10128 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10128 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_145_3 then
						if arg_142_1.isInRecall_ then
							iter_145_3.color = arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_145_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps10128 = nil
			end

			local var_145_8 = arg_142_1.actors_["10120"]
			local var_145_9 = 0

			if var_145_9 < arg_142_1.time_ and arg_142_1.time_ <= var_145_9 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.actorSpriteComps10120 == nil then
				arg_142_1.var_.actorSpriteComps10120 = var_145_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_10 = 0.2

			if var_145_9 <= arg_142_1.time_ and arg_142_1.time_ < var_145_9 + var_145_10 and not isNil(var_145_8) then
				local var_145_11 = (arg_142_1.time_ - var_145_9) / var_145_10

				if arg_142_1.var_.actorSpriteComps10120 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								local var_145_12 = Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, var_145_11)
								local var_145_13 = Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, var_145_11)
								local var_145_14 = Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, var_145_11)

								iter_145_5.color = Color.New(var_145_12, var_145_13, var_145_14)
							else
								local var_145_15 = Mathf.Lerp(iter_145_5.color.r, 0.5, var_145_11)

								iter_145_5.color = Color.New(var_145_15, var_145_15, var_145_15)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_9 + var_145_10 and arg_142_1.time_ < var_145_9 + var_145_10 + arg_145_0 and not isNil(var_145_8) and arg_142_1.var_.actorSpriteComps10120 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_145_7 then
						if arg_142_1.isInRecall_ then
							iter_145_7.color = arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_145_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps10120 = nil
			end

			local var_145_16 = 0
			local var_145_17 = 0.95

			if var_145_16 < arg_142_1.time_ and arg_142_1.time_ <= var_145_16 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_18 = arg_142_1:FormatText(StoryNameCfg[595].name)

				arg_142_1.leftNameTxt_.text = var_145_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_19 = arg_142_1:GetWordFromCfg(417171033)
				local var_145_20 = arg_142_1:FormatText(var_145_19.content)

				arg_142_1.text_.text = var_145_20

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_21 = 38
				local var_145_22 = utf8.len(var_145_20)
				local var_145_23 = var_145_21 <= 0 and var_145_17 or var_145_17 * (var_145_22 / var_145_21)

				if var_145_23 > 0 and var_145_17 < var_145_23 then
					arg_142_1.talkMaxDuration = var_145_23

					if var_145_23 + var_145_16 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_23 + var_145_16
					end
				end

				arg_142_1.text_.text = var_145_20
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171033", "story_v_out_417171.awb") ~= 0 then
					local var_145_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171033", "story_v_out_417171.awb") / 1000

					if var_145_24 + var_145_16 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_24 + var_145_16
					end

					if var_145_19.prefab_name ~= "" and arg_142_1.actors_[var_145_19.prefab_name] ~= nil then
						local var_145_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_19.prefab_name].transform, "story_v_out_417171", "417171033", "story_v_out_417171.awb")

						arg_142_1:RecordAudio("417171033", var_145_25)
						arg_142_1:RecordAudio("417171033", var_145_25)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417171", "417171033", "story_v_out_417171.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417171", "417171033", "story_v_out_417171.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_26 = math.max(var_145_17, arg_142_1.talkMaxDuration)

			if var_145_16 <= arg_142_1.time_ and arg_142_1.time_ < var_145_16 + var_145_26 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_16) / var_145_26

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_16 + var_145_26 and arg_142_1.time_ < var_145_16 + var_145_26 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play417171034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417171034
		arg_146_1.duration_ = 3.73

		local var_146_0 = {
			zh = 2.133,
			ja = 3.733
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
				arg_146_0:Play417171035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10128"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10128 == nil then
				arg_146_1.var_.actorSpriteComps10128 = var_149_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.actorSpriteComps10128 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10128 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_149_3 then
						if arg_146_1.isInRecall_ then
							iter_149_3.color = arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_149_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps10128 = nil
			end

			local var_149_8 = arg_146_1.actors_["10120"]
			local var_149_9 = 0

			if var_149_9 < arg_146_1.time_ and arg_146_1.time_ <= var_149_9 + arg_149_0 and not isNil(var_149_8) and arg_146_1.var_.actorSpriteComps10120 == nil then
				arg_146_1.var_.actorSpriteComps10120 = var_149_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_10 = 0.2

			if var_149_9 <= arg_146_1.time_ and arg_146_1.time_ < var_149_9 + var_149_10 and not isNil(var_149_8) then
				local var_149_11 = (arg_146_1.time_ - var_149_9) / var_149_10

				if arg_146_1.var_.actorSpriteComps10120 then
					for iter_149_4, iter_149_5 in pairs(arg_146_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_149_5 then
							if arg_146_1.isInRecall_ then
								local var_149_12 = Mathf.Lerp(iter_149_5.color.r, arg_146_1.hightColor1.r, var_149_11)
								local var_149_13 = Mathf.Lerp(iter_149_5.color.g, arg_146_1.hightColor1.g, var_149_11)
								local var_149_14 = Mathf.Lerp(iter_149_5.color.b, arg_146_1.hightColor1.b, var_149_11)

								iter_149_5.color = Color.New(var_149_12, var_149_13, var_149_14)
							else
								local var_149_15 = Mathf.Lerp(iter_149_5.color.r, 1, var_149_11)

								iter_149_5.color = Color.New(var_149_15, var_149_15, var_149_15)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_9 + var_149_10 and arg_146_1.time_ < var_149_9 + var_149_10 + arg_149_0 and not isNil(var_149_8) and arg_146_1.var_.actorSpriteComps10120 then
				for iter_149_6, iter_149_7 in pairs(arg_146_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_149_7 then
						if arg_146_1.isInRecall_ then
							iter_149_7.color = arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_149_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps10120 = nil
			end

			local var_149_16 = 0
			local var_149_17 = 0.25

			if var_149_16 < arg_146_1.time_ and arg_146_1.time_ <= var_149_16 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_18 = arg_146_1:FormatText(StoryNameCfg[1141].name)

				arg_146_1.leftNameTxt_.text = var_149_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_19 = arg_146_1:GetWordFromCfg(417171034)
				local var_149_20 = arg_146_1:FormatText(var_149_19.content)

				arg_146_1.text_.text = var_149_20

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_21 = 10
				local var_149_22 = utf8.len(var_149_20)
				local var_149_23 = var_149_21 <= 0 and var_149_17 or var_149_17 * (var_149_22 / var_149_21)

				if var_149_23 > 0 and var_149_17 < var_149_23 then
					arg_146_1.talkMaxDuration = var_149_23

					if var_149_23 + var_149_16 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_23 + var_149_16
					end
				end

				arg_146_1.text_.text = var_149_20
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171034", "story_v_out_417171.awb") ~= 0 then
					local var_149_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171034", "story_v_out_417171.awb") / 1000

					if var_149_24 + var_149_16 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_24 + var_149_16
					end

					if var_149_19.prefab_name ~= "" and arg_146_1.actors_[var_149_19.prefab_name] ~= nil then
						local var_149_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_19.prefab_name].transform, "story_v_out_417171", "417171034", "story_v_out_417171.awb")

						arg_146_1:RecordAudio("417171034", var_149_25)
						arg_146_1:RecordAudio("417171034", var_149_25)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417171", "417171034", "story_v_out_417171.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417171", "417171034", "story_v_out_417171.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_26 = math.max(var_149_17, arg_146_1.talkMaxDuration)

			if var_149_16 <= arg_146_1.time_ and arg_146_1.time_ < var_149_16 + var_149_26 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_16) / var_149_26

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_16 + var_149_26 and arg_146_1.time_ < var_149_16 + var_149_26 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play417171035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417171035
		arg_150_1.duration_ = 7

		local var_150_0 = {
			zh = 5.1,
			ja = 7
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
				arg_150_0:Play417171036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10128"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10128 == nil then
				arg_150_1.var_.actorSpriteComps10128 = var_153_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.actorSpriteComps10128 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								local var_153_4 = Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, var_153_3)
								local var_153_5 = Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, var_153_3)
								local var_153_6 = Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, var_153_3)

								iter_153_1.color = Color.New(var_153_4, var_153_5, var_153_6)
							else
								local var_153_7 = Mathf.Lerp(iter_153_1.color.r, 1, var_153_3)

								iter_153_1.color = Color.New(var_153_7, var_153_7, var_153_7)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10128 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_153_3 then
						if arg_150_1.isInRecall_ then
							iter_153_3.color = arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_153_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps10128 = nil
			end

			local var_153_8 = arg_150_1.actors_["10120"]
			local var_153_9 = 0

			if var_153_9 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 and not isNil(var_153_8) and arg_150_1.var_.actorSpriteComps10120 == nil then
				arg_150_1.var_.actorSpriteComps10120 = var_153_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_10 = 0.2

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_10 and not isNil(var_153_8) then
				local var_153_11 = (arg_150_1.time_ - var_153_9) / var_153_10

				if arg_150_1.var_.actorSpriteComps10120 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								local var_153_12 = Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, var_153_11)
								local var_153_13 = Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, var_153_11)
								local var_153_14 = Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, var_153_11)

								iter_153_5.color = Color.New(var_153_12, var_153_13, var_153_14)
							else
								local var_153_15 = Mathf.Lerp(iter_153_5.color.r, 0.5, var_153_11)

								iter_153_5.color = Color.New(var_153_15, var_153_15, var_153_15)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_9 + var_153_10 and arg_150_1.time_ < var_153_9 + var_153_10 + arg_153_0 and not isNil(var_153_8) and arg_150_1.var_.actorSpriteComps10120 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_153_7 then
						if arg_150_1.isInRecall_ then
							iter_153_7.color = arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_153_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps10120 = nil
			end

			local var_153_16 = arg_150_1.actors_["10128"].transform
			local var_153_17 = 0

			if var_153_17 < arg_150_1.time_ and arg_150_1.time_ <= var_153_17 + arg_153_0 then
				arg_150_1.var_.moveOldPos10128 = var_153_16.localPosition
				var_153_16.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("10128", 2)

				local var_153_18 = var_153_16.childCount

				for iter_153_8 = 0, var_153_18 - 1 do
					local var_153_19 = var_153_16:GetChild(iter_153_8)

					if var_153_19.name == "split_6" or not string.find(var_153_19.name, "split") then
						var_153_19.gameObject:SetActive(true)
					else
						var_153_19.gameObject:SetActive(false)
					end
				end
			end

			local var_153_20 = 0.001

			if var_153_17 <= arg_150_1.time_ and arg_150_1.time_ < var_153_17 + var_153_20 then
				local var_153_21 = (arg_150_1.time_ - var_153_17) / var_153_20
				local var_153_22 = Vector3.New(-390, -347, -300)

				var_153_16.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10128, var_153_22, var_153_21)
			end

			if arg_150_1.time_ >= var_153_17 + var_153_20 and arg_150_1.time_ < var_153_17 + var_153_20 + arg_153_0 then
				var_153_16.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_153_23 = 0
			local var_153_24 = 0.7

			if var_153_23 < arg_150_1.time_ and arg_150_1.time_ <= var_153_23 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_25 = arg_150_1:FormatText(StoryNameCfg[595].name)

				arg_150_1.leftNameTxt_.text = var_153_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_26 = arg_150_1:GetWordFromCfg(417171035)
				local var_153_27 = arg_150_1:FormatText(var_153_26.content)

				arg_150_1.text_.text = var_153_27

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_28 = 28
				local var_153_29 = utf8.len(var_153_27)
				local var_153_30 = var_153_28 <= 0 and var_153_24 or var_153_24 * (var_153_29 / var_153_28)

				if var_153_30 > 0 and var_153_24 < var_153_30 then
					arg_150_1.talkMaxDuration = var_153_30

					if var_153_30 + var_153_23 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_30 + var_153_23
					end
				end

				arg_150_1.text_.text = var_153_27
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171035", "story_v_out_417171.awb") ~= 0 then
					local var_153_31 = manager.audio:GetVoiceLength("story_v_out_417171", "417171035", "story_v_out_417171.awb") / 1000

					if var_153_31 + var_153_23 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_31 + var_153_23
					end

					if var_153_26.prefab_name ~= "" and arg_150_1.actors_[var_153_26.prefab_name] ~= nil then
						local var_153_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_26.prefab_name].transform, "story_v_out_417171", "417171035", "story_v_out_417171.awb")

						arg_150_1:RecordAudio("417171035", var_153_32)
						arg_150_1:RecordAudio("417171035", var_153_32)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417171", "417171035", "story_v_out_417171.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417171", "417171035", "story_v_out_417171.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_33 = math.max(var_153_24, arg_150_1.talkMaxDuration)

			if var_153_23 <= arg_150_1.time_ and arg_150_1.time_ < var_153_23 + var_153_33 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_23) / var_153_33

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_23 + var_153_33 and arg_150_1.time_ < var_153_23 + var_153_33 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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

		arg_150_1:InitPlayNodeList()
	end,
	Play417171036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417171036
		arg_154_1.duration_ = 5.1

		local var_154_0 = {
			zh = 3.366,
			ja = 5.1
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
				arg_154_0:Play417171037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10128"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10128 == nil then
				arg_154_1.var_.actorSpriteComps10128 = var_157_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.actorSpriteComps10128 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								local var_157_4 = Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, var_157_3)
								local var_157_5 = Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, var_157_3)
								local var_157_6 = Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, var_157_3)

								iter_157_1.color = Color.New(var_157_4, var_157_5, var_157_6)
							else
								local var_157_7 = Mathf.Lerp(iter_157_1.color.r, 0.5, var_157_3)

								iter_157_1.color = Color.New(var_157_7, var_157_7, var_157_7)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10128 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_157_3 then
						if arg_154_1.isInRecall_ then
							iter_157_3.color = arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_157_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps10128 = nil
			end

			local var_157_8 = arg_154_1.actors_["10120"]
			local var_157_9 = 0

			if var_157_9 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.actorSpriteComps10120 == nil then
				arg_154_1.var_.actorSpriteComps10120 = var_157_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_10 = 0.2

			if var_157_9 <= arg_154_1.time_ and arg_154_1.time_ < var_157_9 + var_157_10 and not isNil(var_157_8) then
				local var_157_11 = (arg_154_1.time_ - var_157_9) / var_157_10

				if arg_154_1.var_.actorSpriteComps10120 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								local var_157_12 = Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor1.r, var_157_11)
								local var_157_13 = Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor1.g, var_157_11)
								local var_157_14 = Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor1.b, var_157_11)

								iter_157_5.color = Color.New(var_157_12, var_157_13, var_157_14)
							else
								local var_157_15 = Mathf.Lerp(iter_157_5.color.r, 1, var_157_11)

								iter_157_5.color = Color.New(var_157_15, var_157_15, var_157_15)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_9 + var_157_10 and arg_154_1.time_ < var_157_9 + var_157_10 + arg_157_0 and not isNil(var_157_8) and arg_154_1.var_.actorSpriteComps10120 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_157_7 then
						if arg_154_1.isInRecall_ then
							iter_157_7.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_157_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps10120 = nil
			end

			local var_157_16 = 0
			local var_157_17 = 0.425

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_18 = arg_154_1:FormatText(StoryNameCfg[1141].name)

				arg_154_1.leftNameTxt_.text = var_157_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_19 = arg_154_1:GetWordFromCfg(417171036)
				local var_157_20 = arg_154_1:FormatText(var_157_19.content)

				arg_154_1.text_.text = var_157_20

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_21 = 17
				local var_157_22 = utf8.len(var_157_20)
				local var_157_23 = var_157_21 <= 0 and var_157_17 or var_157_17 * (var_157_22 / var_157_21)

				if var_157_23 > 0 and var_157_17 < var_157_23 then
					arg_154_1.talkMaxDuration = var_157_23

					if var_157_23 + var_157_16 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_23 + var_157_16
					end
				end

				arg_154_1.text_.text = var_157_20
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171036", "story_v_out_417171.awb") ~= 0 then
					local var_157_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171036", "story_v_out_417171.awb") / 1000

					if var_157_24 + var_157_16 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_24 + var_157_16
					end

					if var_157_19.prefab_name ~= "" and arg_154_1.actors_[var_157_19.prefab_name] ~= nil then
						local var_157_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_19.prefab_name].transform, "story_v_out_417171", "417171036", "story_v_out_417171.awb")

						arg_154_1:RecordAudio("417171036", var_157_25)
						arg_154_1:RecordAudio("417171036", var_157_25)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417171", "417171036", "story_v_out_417171.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417171", "417171036", "story_v_out_417171.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_26 = math.max(var_157_17, arg_154_1.talkMaxDuration)

			if var_157_16 <= arg_154_1.time_ and arg_154_1.time_ < var_157_16 + var_157_26 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_16) / var_157_26

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_16 + var_157_26 and arg_154_1.time_ < var_157_16 + var_157_26 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play417171037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417171037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417171038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10120"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps10120 == nil then
				arg_158_1.var_.actorSpriteComps10120 = var_161_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_2 = 0.2

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.actorSpriteComps10120 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps10120:ToTable()) do
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

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps10120 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_161_3 then
						if arg_158_1.isInRecall_ then
							iter_161_3.color = arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_161_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_158_1.var_.actorSpriteComps10120 = nil
			end

			local var_161_8 = 0
			local var_161_9 = 0.775

			if var_161_8 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_10 = arg_158_1:GetWordFromCfg(417171037)
				local var_161_11 = arg_158_1:FormatText(var_161_10.content)

				arg_158_1.text_.text = var_161_11

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_12 = 31
				local var_161_13 = utf8.len(var_161_11)
				local var_161_14 = var_161_12 <= 0 and var_161_9 or var_161_9 * (var_161_13 / var_161_12)

				if var_161_14 > 0 and var_161_9 < var_161_14 then
					arg_158_1.talkMaxDuration = var_161_14

					if var_161_14 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_11
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_15 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_15 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_15

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_15 and arg_158_1.time_ < var_161_8 + var_161_15 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417171038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417171038
		arg_162_1.duration_ = 5.13

		local var_162_0 = {
			zh = 2.266,
			ja = 5.133
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
				arg_162_0:Play417171039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10128"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps10128 == nil then
				arg_162_1.var_.actorSpriteComps10128 = var_165_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.actorSpriteComps10128 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								local var_165_4 = Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, var_165_3)
								local var_165_5 = Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, var_165_3)
								local var_165_6 = Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, var_165_3)

								iter_165_1.color = Color.New(var_165_4, var_165_5, var_165_6)
							else
								local var_165_7 = Mathf.Lerp(iter_165_1.color.r, 1, var_165_3)

								iter_165_1.color = Color.New(var_165_7, var_165_7, var_165_7)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps10128 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_165_3 then
						if arg_162_1.isInRecall_ then
							iter_165_3.color = arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_165_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps10128 = nil
			end

			local var_165_8 = 0
			local var_165_9 = 0.225

			if var_165_8 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_10 = arg_162_1:FormatText(StoryNameCfg[595].name)

				arg_162_1.leftNameTxt_.text = var_165_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_11 = arg_162_1:GetWordFromCfg(417171038)
				local var_165_12 = arg_162_1:FormatText(var_165_11.content)

				arg_162_1.text_.text = var_165_12

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_13 = 9
				local var_165_14 = utf8.len(var_165_12)
				local var_165_15 = var_165_13 <= 0 and var_165_9 or var_165_9 * (var_165_14 / var_165_13)

				if var_165_15 > 0 and var_165_9 < var_165_15 then
					arg_162_1.talkMaxDuration = var_165_15

					if var_165_15 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_15 + var_165_8
					end
				end

				arg_162_1.text_.text = var_165_12
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171038", "story_v_out_417171.awb") ~= 0 then
					local var_165_16 = manager.audio:GetVoiceLength("story_v_out_417171", "417171038", "story_v_out_417171.awb") / 1000

					if var_165_16 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_16 + var_165_8
					end

					if var_165_11.prefab_name ~= "" and arg_162_1.actors_[var_165_11.prefab_name] ~= nil then
						local var_165_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_11.prefab_name].transform, "story_v_out_417171", "417171038", "story_v_out_417171.awb")

						arg_162_1:RecordAudio("417171038", var_165_17)
						arg_162_1:RecordAudio("417171038", var_165_17)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417171", "417171038", "story_v_out_417171.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417171", "417171038", "story_v_out_417171.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_18 = math.max(var_165_9, arg_162_1.talkMaxDuration)

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_18 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_8) / var_165_18

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_8 + var_165_18 and arg_162_1.time_ < var_165_8 + var_165_18 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play417171039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417171039
		arg_166_1.duration_ = 3.1

		local var_166_0 = {
			zh = 3.1,
			ja = 3.033
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
				arg_166_0:Play417171040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10128"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10128 == nil then
				arg_166_1.var_.actorSpriteComps10128 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps10128 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 0.5, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10128 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_169_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10128 = nil
			end

			local var_169_8 = arg_166_1.actors_["10120"]
			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 and not isNil(var_169_8) and arg_166_1.var_.actorSpriteComps10120 == nil then
				arg_166_1.var_.actorSpriteComps10120 = var_169_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_10 = 0.2

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_10 and not isNil(var_169_8) then
				local var_169_11 = (arg_166_1.time_ - var_169_9) / var_169_10

				if arg_166_1.var_.actorSpriteComps10120 then
					for iter_169_4, iter_169_5 in pairs(arg_166_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_169_5 then
							if arg_166_1.isInRecall_ then
								local var_169_12 = Mathf.Lerp(iter_169_5.color.r, arg_166_1.hightColor1.r, var_169_11)
								local var_169_13 = Mathf.Lerp(iter_169_5.color.g, arg_166_1.hightColor1.g, var_169_11)
								local var_169_14 = Mathf.Lerp(iter_169_5.color.b, arg_166_1.hightColor1.b, var_169_11)

								iter_169_5.color = Color.New(var_169_12, var_169_13, var_169_14)
							else
								local var_169_15 = Mathf.Lerp(iter_169_5.color.r, 1, var_169_11)

								iter_169_5.color = Color.New(var_169_15, var_169_15, var_169_15)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_9 + var_169_10 and arg_166_1.time_ < var_169_9 + var_169_10 + arg_169_0 and not isNil(var_169_8) and arg_166_1.var_.actorSpriteComps10120 then
				for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_169_7 then
						if arg_166_1.isInRecall_ then
							iter_169_7.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10120 = nil
			end

			local var_169_16 = 0
			local var_169_17 = 0.35

			if var_169_16 < arg_166_1.time_ and arg_166_1.time_ <= var_169_16 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_18 = arg_166_1:FormatText(StoryNameCfg[1141].name)

				arg_166_1.leftNameTxt_.text = var_169_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_19 = arg_166_1:GetWordFromCfg(417171039)
				local var_169_20 = arg_166_1:FormatText(var_169_19.content)

				arg_166_1.text_.text = var_169_20

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_21 = 14
				local var_169_22 = utf8.len(var_169_20)
				local var_169_23 = var_169_21 <= 0 and var_169_17 or var_169_17 * (var_169_22 / var_169_21)

				if var_169_23 > 0 and var_169_17 < var_169_23 then
					arg_166_1.talkMaxDuration = var_169_23

					if var_169_23 + var_169_16 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_16
					end
				end

				arg_166_1.text_.text = var_169_20
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171039", "story_v_out_417171.awb") ~= 0 then
					local var_169_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171039", "story_v_out_417171.awb") / 1000

					if var_169_24 + var_169_16 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_24 + var_169_16
					end

					if var_169_19.prefab_name ~= "" and arg_166_1.actors_[var_169_19.prefab_name] ~= nil then
						local var_169_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_19.prefab_name].transform, "story_v_out_417171", "417171039", "story_v_out_417171.awb")

						arg_166_1:RecordAudio("417171039", var_169_25)
						arg_166_1:RecordAudio("417171039", var_169_25)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_417171", "417171039", "story_v_out_417171.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_417171", "417171039", "story_v_out_417171.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_26 = math.max(var_169_17, arg_166_1.talkMaxDuration)

			if var_169_16 <= arg_166_1.time_ and arg_166_1.time_ < var_169_16 + var_169_26 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_16) / var_169_26

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_16 + var_169_26 and arg_166_1.time_ < var_169_16 + var_169_26 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play417171040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417171040
		arg_170_1.duration_ = 1.83

		local var_170_0 = {
			zh = 1,
			ja = 1.833
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
				arg_170_0:Play417171041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10128"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10128 == nil then
				arg_170_1.var_.actorSpriteComps10128 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps10128 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10128 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10128 = nil
			end

			local var_173_8 = arg_170_1.actors_["10120"]
			local var_173_9 = 0

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 and not isNil(var_173_8) and arg_170_1.var_.actorSpriteComps10120 == nil then
				arg_170_1.var_.actorSpriteComps10120 = var_173_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_10 = 0.2

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_10 and not isNil(var_173_8) then
				local var_173_11 = (arg_170_1.time_ - var_173_9) / var_173_10

				if arg_170_1.var_.actorSpriteComps10120 then
					for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_173_5 then
							if arg_170_1.isInRecall_ then
								local var_173_12 = Mathf.Lerp(iter_173_5.color.r, arg_170_1.hightColor2.r, var_173_11)
								local var_173_13 = Mathf.Lerp(iter_173_5.color.g, arg_170_1.hightColor2.g, var_173_11)
								local var_173_14 = Mathf.Lerp(iter_173_5.color.b, arg_170_1.hightColor2.b, var_173_11)

								iter_173_5.color = Color.New(var_173_12, var_173_13, var_173_14)
							else
								local var_173_15 = Mathf.Lerp(iter_173_5.color.r, 0.5, var_173_11)

								iter_173_5.color = Color.New(var_173_15, var_173_15, var_173_15)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_9 + var_173_10 and arg_170_1.time_ < var_173_9 + var_173_10 + arg_173_0 and not isNil(var_173_8) and arg_170_1.var_.actorSpriteComps10120 then
				for iter_173_6, iter_173_7 in pairs(arg_170_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_173_7 then
						if arg_170_1.isInRecall_ then
							iter_173_7.color = arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_173_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10120 = nil
			end

			local var_173_16 = 0
			local var_173_17 = 0.05

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_18 = arg_170_1:FormatText(StoryNameCfg[595].name)

				arg_170_1.leftNameTxt_.text = var_173_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_19 = arg_170_1:GetWordFromCfg(417171040)
				local var_173_20 = arg_170_1:FormatText(var_173_19.content)

				arg_170_1.text_.text = var_173_20

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_21 = 2
				local var_173_22 = utf8.len(var_173_20)
				local var_173_23 = var_173_21 <= 0 and var_173_17 or var_173_17 * (var_173_22 / var_173_21)

				if var_173_23 > 0 and var_173_17 < var_173_23 then
					arg_170_1.talkMaxDuration = var_173_23

					if var_173_23 + var_173_16 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_23 + var_173_16
					end
				end

				arg_170_1.text_.text = var_173_20
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171040", "story_v_out_417171.awb") ~= 0 then
					local var_173_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171040", "story_v_out_417171.awb") / 1000

					if var_173_24 + var_173_16 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_24 + var_173_16
					end

					if var_173_19.prefab_name ~= "" and arg_170_1.actors_[var_173_19.prefab_name] ~= nil then
						local var_173_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_19.prefab_name].transform, "story_v_out_417171", "417171040", "story_v_out_417171.awb")

						arg_170_1:RecordAudio("417171040", var_173_25)
						arg_170_1:RecordAudio("417171040", var_173_25)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417171", "417171040", "story_v_out_417171.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417171", "417171040", "story_v_out_417171.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_26 = math.max(var_173_17, arg_170_1.talkMaxDuration)

			if var_173_16 <= arg_170_1.time_ and arg_170_1.time_ < var_173_16 + var_173_26 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_16) / var_173_26

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_16 + var_173_26 and arg_170_1.time_ < var_173_16 + var_173_26 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417171041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417171041
		arg_174_1.duration_ = 1.3

		local var_174_0 = {
			zh = 1.3,
			ja = 1.066
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
				arg_174_0:Play417171042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10128"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10128 == nil then
				arg_174_1.var_.actorSpriteComps10128 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps10128 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10128 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10128 = nil
			end

			local var_177_8 = arg_174_1.actors_["10120"]
			local var_177_9 = 0

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.actorSpriteComps10120 == nil then
				arg_174_1.var_.actorSpriteComps10120 = var_177_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_10 = 0.2

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_10 and not isNil(var_177_8) then
				local var_177_11 = (arg_174_1.time_ - var_177_9) / var_177_10

				if arg_174_1.var_.actorSpriteComps10120 then
					for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps10120:ToTable()) do
						if iter_177_5 then
							if arg_174_1.isInRecall_ then
								local var_177_12 = Mathf.Lerp(iter_177_5.color.r, arg_174_1.hightColor1.r, var_177_11)
								local var_177_13 = Mathf.Lerp(iter_177_5.color.g, arg_174_1.hightColor1.g, var_177_11)
								local var_177_14 = Mathf.Lerp(iter_177_5.color.b, arg_174_1.hightColor1.b, var_177_11)

								iter_177_5.color = Color.New(var_177_12, var_177_13, var_177_14)
							else
								local var_177_15 = Mathf.Lerp(iter_177_5.color.r, 1, var_177_11)

								iter_177_5.color = Color.New(var_177_15, var_177_15, var_177_15)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_9 + var_177_10 and arg_174_1.time_ < var_177_9 + var_177_10 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.actorSpriteComps10120 then
				for iter_177_6, iter_177_7 in pairs(arg_174_1.var_.actorSpriteComps10120:ToTable()) do
					if iter_177_7 then
						if arg_174_1.isInRecall_ then
							iter_177_7.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_177_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10120 = nil
			end

			local var_177_16 = 0
			local var_177_17 = 0.1

			if var_177_16 < arg_174_1.time_ and arg_174_1.time_ <= var_177_16 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_18 = arg_174_1:FormatText(StoryNameCfg[1141].name)

				arg_174_1.leftNameTxt_.text = var_177_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_19 = arg_174_1:GetWordFromCfg(417171041)
				local var_177_20 = arg_174_1:FormatText(var_177_19.content)

				arg_174_1.text_.text = var_177_20

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_21 = 4
				local var_177_22 = utf8.len(var_177_20)
				local var_177_23 = var_177_21 <= 0 and var_177_17 or var_177_17 * (var_177_22 / var_177_21)

				if var_177_23 > 0 and var_177_17 < var_177_23 then
					arg_174_1.talkMaxDuration = var_177_23

					if var_177_23 + var_177_16 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_23 + var_177_16
					end
				end

				arg_174_1.text_.text = var_177_20
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171041", "story_v_out_417171.awb") ~= 0 then
					local var_177_24 = manager.audio:GetVoiceLength("story_v_out_417171", "417171041", "story_v_out_417171.awb") / 1000

					if var_177_24 + var_177_16 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_24 + var_177_16
					end

					if var_177_19.prefab_name ~= "" and arg_174_1.actors_[var_177_19.prefab_name] ~= nil then
						local var_177_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_19.prefab_name].transform, "story_v_out_417171", "417171041", "story_v_out_417171.awb")

						arg_174_1:RecordAudio("417171041", var_177_25)
						arg_174_1:RecordAudio("417171041", var_177_25)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417171", "417171041", "story_v_out_417171.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417171", "417171041", "story_v_out_417171.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_26 = math.max(var_177_17, arg_174_1.talkMaxDuration)

			if var_177_16 <= arg_174_1.time_ and arg_174_1.time_ < var_177_16 + var_177_26 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_16) / var_177_26

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_16 + var_177_26 and arg_174_1.time_ < var_177_16 + var_177_26 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play417171042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417171042
		arg_178_1.duration_ = 9

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play417171043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 4

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.allBtn_.enabled = false
			end

			local var_181_1 = 0.3

			if arg_178_1.time_ >= var_181_0 + var_181_1 and arg_178_1.time_ < var_181_0 + var_181_1 + arg_181_0 then
				arg_178_1.allBtn_.enabled = true
			end

			local var_181_2 = 2

			if var_181_2 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				local var_181_3 = manager.ui.mainCamera.transform.localPosition
				local var_181_4 = Vector3.New(0, 0, 10) + Vector3.New(var_181_3.x, var_181_3.y, 0)
				local var_181_5 = arg_178_1.bgs_.I17f

				var_181_5.transform.localPosition = var_181_4
				var_181_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_6 = var_181_5:GetComponent("SpriteRenderer")

				if var_181_6 and var_181_6.sprite then
					local var_181_7 = (var_181_5.transform.localPosition - var_181_3).z
					local var_181_8 = manager.ui.mainCameraCom_
					local var_181_9 = 2 * var_181_7 * Mathf.Tan(var_181_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_181_10 = var_181_9 * var_181_8.aspect
					local var_181_11 = var_181_6.sprite.bounds.size.x
					local var_181_12 = var_181_6.sprite.bounds.size.y
					local var_181_13 = var_181_10 / var_181_11
					local var_181_14 = var_181_9 / var_181_12
					local var_181_15 = var_181_14 < var_181_13 and var_181_13 or var_181_14

					var_181_5.transform.localScale = Vector3.New(var_181_15, var_181_15, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "I17f" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_181_16 = 0

			if var_181_16 < arg_178_1.time_ and arg_178_1.time_ <= var_181_16 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_17 = 2

			if var_181_16 <= arg_178_1.time_ and arg_178_1.time_ < var_181_16 + var_181_17 then
				local var_181_18 = (arg_178_1.time_ - var_181_16) / var_181_17
				local var_181_19 = Color.New(0, 0, 0)

				var_181_19.a = Mathf.Lerp(0, 1, var_181_18)
				arg_178_1.mask_.color = var_181_19
			end

			if arg_178_1.time_ >= var_181_16 + var_181_17 and arg_178_1.time_ < var_181_16 + var_181_17 + arg_181_0 then
				local var_181_20 = Color.New(0, 0, 0)

				var_181_20.a = 1
				arg_178_1.mask_.color = var_181_20
			end

			local var_181_21 = 2

			if var_181_21 < arg_178_1.time_ and arg_178_1.time_ <= var_181_21 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = true

				arg_178_1:SetGaussion(false)
			end

			local var_181_22 = 2

			if var_181_21 <= arg_178_1.time_ and arg_178_1.time_ < var_181_21 + var_181_22 then
				local var_181_23 = (arg_178_1.time_ - var_181_21) / var_181_22
				local var_181_24 = Color.New(0, 0, 0)

				var_181_24.a = Mathf.Lerp(1, 0, var_181_23)
				arg_178_1.mask_.color = var_181_24
			end

			if arg_178_1.time_ >= var_181_21 + var_181_22 and arg_178_1.time_ < var_181_21 + var_181_22 + arg_181_0 then
				local var_181_25 = Color.New(0, 0, 0)
				local var_181_26 = 0

				arg_178_1.mask_.enabled = false
				var_181_25.a = var_181_26
				arg_178_1.mask_.color = var_181_25
			end

			local var_181_27 = arg_178_1.actors_["10128"].transform
			local var_181_28 = 1.966

			if var_181_28 < arg_178_1.time_ and arg_178_1.time_ <= var_181_28 + arg_181_0 then
				arg_178_1.var_.moveOldPos10128 = var_181_27.localPosition
				var_181_27.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10128", 7)

				local var_181_29 = var_181_27.childCount

				for iter_181_2 = 0, var_181_29 - 1 do
					local var_181_30 = var_181_27:GetChild(iter_181_2)

					if var_181_30.name == "" or not string.find(var_181_30.name, "split") then
						var_181_30.gameObject:SetActive(true)
					else
						var_181_30.gameObject:SetActive(false)
					end
				end
			end

			local var_181_31 = 0.001

			if var_181_28 <= arg_178_1.time_ and arg_178_1.time_ < var_181_28 + var_181_31 then
				local var_181_32 = (arg_178_1.time_ - var_181_28) / var_181_31
				local var_181_33 = Vector3.New(0, -2000, -300)

				var_181_27.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10128, var_181_33, var_181_32)
			end

			if arg_178_1.time_ >= var_181_28 + var_181_31 and arg_178_1.time_ < var_181_28 + var_181_31 + arg_181_0 then
				var_181_27.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_181_34 = arg_178_1.actors_["10120"].transform
			local var_181_35 = 1.966

			if var_181_35 < arg_178_1.time_ and arg_178_1.time_ <= var_181_35 + arg_181_0 then
				arg_178_1.var_.moveOldPos10120 = var_181_34.localPosition
				var_181_34.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("10120", 7)

				local var_181_36 = var_181_34.childCount

				for iter_181_3 = 0, var_181_36 - 1 do
					local var_181_37 = var_181_34:GetChild(iter_181_3)

					if var_181_37.name == "" or not string.find(var_181_37.name, "split") then
						var_181_37.gameObject:SetActive(true)
					else
						var_181_37.gameObject:SetActive(false)
					end
				end
			end

			local var_181_38 = 0.001

			if var_181_35 <= arg_178_1.time_ and arg_178_1.time_ < var_181_35 + var_181_38 then
				local var_181_39 = (arg_178_1.time_ - var_181_35) / var_181_38
				local var_181_40 = Vector3.New(0, -2000, 0)

				var_181_34.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos10120, var_181_40, var_181_39)
			end

			if arg_178_1.time_ >= var_181_35 + var_181_38 and arg_178_1.time_ < var_181_35 + var_181_38 + arg_181_0 then
				var_181_34.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_181_41 = 4
			local var_181_42 = 1

			if var_181_41 < arg_178_1.time_ and arg_178_1.time_ <= var_181_41 + arg_181_0 then
				local var_181_43 = "play"
				local var_181_44 = "effect"

				arg_178_1:AudioAction(var_181_43, var_181_44, "se_story_1311", "se_story_1311_machine01", "")
			end

			if arg_178_1.frameCnt_ <= 1 then
				arg_178_1.dialog_:SetActive(false)
			end

			local var_181_45 = 4
			local var_181_46 = 0.925

			if var_181_45 < arg_178_1.time_ and arg_178_1.time_ <= var_181_45 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				arg_178_1.dialog_:SetActive(true)

				arg_178_1.dialogCg_.alpha = 0

				local var_181_47 = LeanTween.value(arg_178_1.dialog_, 0, 1, 0.3)

				var_181_47:setOnUpdate(LuaHelper.FloatAction(function(arg_182_0)
					arg_178_1.dialogCg_.alpha = arg_182_0
				end))
				var_181_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_178_1.dialog_)
					var_181_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_178_1.duration_ = arg_178_1.duration_ + 0.3

				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_48 = arg_178_1:GetWordFromCfg(417171042)
				local var_181_49 = arg_178_1:FormatText(var_181_48.content)

				arg_178_1.text_.text = var_181_49

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_50 = 37
				local var_181_51 = utf8.len(var_181_49)
				local var_181_52 = var_181_50 <= 0 and var_181_46 or var_181_46 * (var_181_51 / var_181_50)

				if var_181_52 > 0 and var_181_46 < var_181_52 then
					arg_178_1.talkMaxDuration = var_181_52
					var_181_45 = var_181_45 + 0.3

					if var_181_52 + var_181_45 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_52 + var_181_45
					end
				end

				arg_178_1.text_.text = var_181_49
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_53 = var_181_45 + 0.3
			local var_181_54 = math.max(var_181_46, arg_178_1.talkMaxDuration)

			if var_181_53 <= arg_178_1.time_ and arg_178_1.time_ < var_181_53 + var_181_54 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_53) / var_181_54

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_53 + var_181_54 and arg_178_1.time_ < var_181_53 + var_181_54 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10120",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play417171043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417171043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417171044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0.1
			local var_187_1 = 1

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				local var_187_2 = "play"
				local var_187_3 = "effect"

				arg_184_1:AudioAction(var_187_2, var_187_3, "se_story_1311", "se_story_1311_truck01", "")
			end

			local var_187_4 = 0
			local var_187_5 = 1.35

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_6 = arg_184_1:GetWordFromCfg(417171043)
				local var_187_7 = arg_184_1:FormatText(var_187_6.content)

				arg_184_1.text_.text = var_187_7

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_8 = 54
				local var_187_9 = utf8.len(var_187_7)
				local var_187_10 = var_187_8 <= 0 and var_187_5 or var_187_5 * (var_187_9 / var_187_8)

				if var_187_10 > 0 and var_187_5 < var_187_10 then
					arg_184_1.talkMaxDuration = var_187_10

					if var_187_10 + var_187_4 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_4
					end
				end

				arg_184_1.text_.text = var_187_7
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_11 = math.max(var_187_5, arg_184_1.talkMaxDuration)

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_11 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_4) / var_187_11

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_4 + var_187_11 and arg_184_1.time_ < var_187_4 + var_187_11 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417171044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417171044
		arg_188_1.duration_ = 7.37

		local var_188_0 = {
			zh = 5.8,
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
				arg_188_0:Play417171045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 4

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			local var_191_1 = 0.1

			if arg_188_1.time_ >= var_191_0 + var_191_1 and arg_188_1.time_ < var_191_0 + var_191_1 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end

			local var_191_2 = "ST75"

			if arg_188_1.bgs_[var_191_2] == nil then
				local var_191_3 = Object.Instantiate(arg_188_1.paintGo_)

				var_191_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_191_2)
				var_191_3.name = var_191_2
				var_191_3.transform.parent = arg_188_1.stage_.transform
				var_191_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.bgs_[var_191_2] = var_191_3
			end

			local var_191_4 = 2

			if var_191_4 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				local var_191_5 = manager.ui.mainCamera.transform.localPosition
				local var_191_6 = Vector3.New(0, 0, 10) + Vector3.New(var_191_5.x, var_191_5.y, 0)
				local var_191_7 = arg_188_1.bgs_.ST75

				var_191_7.transform.localPosition = var_191_6
				var_191_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_191_8 = var_191_7:GetComponent("SpriteRenderer")

				if var_191_8 and var_191_8.sprite then
					local var_191_9 = (var_191_7.transform.localPosition - var_191_5).z
					local var_191_10 = manager.ui.mainCameraCom_
					local var_191_11 = 2 * var_191_9 * Mathf.Tan(var_191_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_191_12 = var_191_11 * var_191_10.aspect
					local var_191_13 = var_191_8.sprite.bounds.size.x
					local var_191_14 = var_191_8.sprite.bounds.size.y
					local var_191_15 = var_191_12 / var_191_13
					local var_191_16 = var_191_11 / var_191_14
					local var_191_17 = var_191_16 < var_191_15 and var_191_15 or var_191_16

					var_191_7.transform.localScale = Vector3.New(var_191_17, var_191_17, 0)
				end

				for iter_191_0, iter_191_1 in pairs(arg_188_1.bgs_) do
					if iter_191_0 ~= "ST75" then
						iter_191_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_191_18 = 0

			if var_191_18 < arg_188_1.time_ and arg_188_1.time_ <= var_191_18 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_19 = 2

			if var_191_18 <= arg_188_1.time_ and arg_188_1.time_ < var_191_18 + var_191_19 then
				local var_191_20 = (arg_188_1.time_ - var_191_18) / var_191_19
				local var_191_21 = Color.New(0, 0, 0)

				var_191_21.a = Mathf.Lerp(0, 1, var_191_20)
				arg_188_1.mask_.color = var_191_21
			end

			if arg_188_1.time_ >= var_191_18 + var_191_19 and arg_188_1.time_ < var_191_18 + var_191_19 + arg_191_0 then
				local var_191_22 = Color.New(0, 0, 0)

				var_191_22.a = 1
				arg_188_1.mask_.color = var_191_22
			end

			local var_191_23 = 2

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 then
				arg_188_1.mask_.enabled = true
				arg_188_1.mask_.raycastTarget = true

				arg_188_1:SetGaussion(false)
			end

			local var_191_24 = 2

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_24 then
				local var_191_25 = (arg_188_1.time_ - var_191_23) / var_191_24
				local var_191_26 = Color.New(0, 0, 0)

				var_191_26.a = Mathf.Lerp(1, 0, var_191_25)
				arg_188_1.mask_.color = var_191_26
			end

			if arg_188_1.time_ >= var_191_23 + var_191_24 and arg_188_1.time_ < var_191_23 + var_191_24 + arg_191_0 then
				local var_191_27 = Color.New(0, 0, 0)
				local var_191_28 = 0

				arg_188_1.mask_.enabled = false
				var_191_27.a = var_191_28
				arg_188_1.mask_.color = var_191_27
			end

			local var_191_29 = 1.46666666666667
			local var_191_30 = 1

			if var_191_29 < arg_188_1.time_ and arg_188_1.time_ <= var_191_29 + arg_191_0 then
				local var_191_31 = "stop"
				local var_191_32 = "effect"

				arg_188_1:AudioAction(var_191_31, var_191_32, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_191_33 = 1.46666666666667
			local var_191_34 = 1

			if var_191_33 < arg_188_1.time_ and arg_188_1.time_ <= var_191_33 + arg_191_0 then
				local var_191_35 = "play"
				local var_191_36 = "effect"

				arg_188_1:AudioAction(var_191_35, var_191_36, "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if arg_188_1.frameCnt_ <= 1 then
				arg_188_1.dialog_:SetActive(false)
			end

			local var_191_37 = 4
			local var_191_38 = 0.225

			if var_191_37 < arg_188_1.time_ and arg_188_1.time_ <= var_191_37 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				arg_188_1.dialog_:SetActive(true)

				arg_188_1.dialogCg_.alpha = 0

				local var_191_39 = LeanTween.value(arg_188_1.dialog_, 0, 1, 0.3)

				var_191_39:setOnUpdate(LuaHelper.FloatAction(function(arg_192_0)
					arg_188_1.dialogCg_.alpha = arg_192_0
				end))
				var_191_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_188_1.dialog_)
					var_191_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_188_1.duration_ = arg_188_1.duration_ + 0.3

				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_40 = arg_188_1:FormatText(StoryNameCfg[1142].name)

				arg_188_1.leftNameTxt_.text = var_191_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_41 = arg_188_1:GetWordFromCfg(417171044)
				local var_191_42 = arg_188_1:FormatText(var_191_41.content)

				arg_188_1.text_.text = var_191_42

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_43 = 9
				local var_191_44 = utf8.len(var_191_42)
				local var_191_45 = var_191_43 <= 0 and var_191_38 or var_191_38 * (var_191_44 / var_191_43)

				if var_191_45 > 0 and var_191_38 < var_191_45 then
					arg_188_1.talkMaxDuration = var_191_45
					var_191_37 = var_191_37 + 0.3

					if var_191_45 + var_191_37 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_45 + var_191_37
					end
				end

				arg_188_1.text_.text = var_191_42
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171044", "story_v_out_417171.awb") ~= 0 then
					local var_191_46 = manager.audio:GetVoiceLength("story_v_out_417171", "417171044", "story_v_out_417171.awb") / 1000

					if var_191_46 + var_191_37 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_46 + var_191_37
					end

					if var_191_41.prefab_name ~= "" and arg_188_1.actors_[var_191_41.prefab_name] ~= nil then
						local var_191_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_41.prefab_name].transform, "story_v_out_417171", "417171044", "story_v_out_417171.awb")

						arg_188_1:RecordAudio("417171044", var_191_47)
						arg_188_1:RecordAudio("417171044", var_191_47)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417171", "417171044", "story_v_out_417171.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417171", "417171044", "story_v_out_417171.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_48 = var_191_37 + 0.3
			local var_191_49 = math.max(var_191_38, arg_188_1.talkMaxDuration)

			if var_191_48 <= arg_188_1.time_ and arg_188_1.time_ < var_191_48 + var_191_49 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_48) / var_191_49

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_48 + var_191_49 and arg_188_1.time_ < var_191_48 + var_191_49 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play417171045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417171045
		arg_194_1.duration_ = 7.37

		local var_194_0 = {
			zh = 5.6,
			ja = 7.366
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
				arg_194_0:Play417171046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.825

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[1142].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(417171045)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 33
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171045", "story_v_out_417171.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171045", "story_v_out_417171.awb") / 1000

					if var_197_8 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_0
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_417171", "417171045", "story_v_out_417171.awb")

						arg_194_1:RecordAudio("417171045", var_197_9)
						arg_194_1:RecordAudio("417171045", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417171", "417171045", "story_v_out_417171.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417171", "417171045", "story_v_out_417171.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_10 and arg_194_1.time_ < var_197_0 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play417171046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417171046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417171047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 0.85

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_2 = arg_198_1:GetWordFromCfg(417171046)
				local var_201_3 = arg_198_1:FormatText(var_201_2.content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 34
				local var_201_5 = utf8.len(var_201_3)
				local var_201_6 = var_201_4 <= 0 and var_201_1 or var_201_1 * (var_201_5 / var_201_4)

				if var_201_6 > 0 and var_201_1 < var_201_6 then
					arg_198_1.talkMaxDuration = var_201_6

					if var_201_6 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_7 and arg_198_1.time_ < var_201_0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417171047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417171047
		arg_202_1.duration_ = 3.8

		local var_202_0 = {
			zh = 3.166,
			ja = 3.8
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
				arg_202_0:Play417171048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.4

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[1142].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:GetWordFromCfg(417171047)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 16
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171047", "story_v_out_417171.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171047", "story_v_out_417171.awb") / 1000

					if var_205_8 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_0
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_417171", "417171047", "story_v_out_417171.awb")

						arg_202_1:RecordAudio("417171047", var_205_9)
						arg_202_1:RecordAudio("417171047", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417171", "417171047", "story_v_out_417171.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417171", "417171047", "story_v_out_417171.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_10 and arg_202_1.time_ < var_205_0 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417171048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417171048
		arg_206_1.duration_ = 2.5

		local var_206_0 = {
			zh = 1.266,
			ja = 2.5
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
				arg_206_0:Play417171049(arg_206_1)
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

			local var_209_8 = arg_206_1.actors_["10128"].transform
			local var_209_9 = 0

			if var_209_9 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1.var_.moveOldPos10128 = var_209_8.localPosition
				var_209_8.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("10128", 3)

				local var_209_10 = var_209_8.childCount

				for iter_209_4 = 0, var_209_10 - 1 do
					local var_209_11 = var_209_8:GetChild(iter_209_4)

					if var_209_11.name == "" or not string.find(var_209_11.name, "split") then
						var_209_11.gameObject:SetActive(true)
					else
						var_209_11.gameObject:SetActive(false)
					end
				end
			end

			local var_209_12 = 0.001

			if var_209_9 <= arg_206_1.time_ and arg_206_1.time_ < var_209_9 + var_209_12 then
				local var_209_13 = (arg_206_1.time_ - var_209_9) / var_209_12
				local var_209_14 = Vector3.New(0, -347, -300)

				var_209_8.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10128, var_209_14, var_209_13)
			end

			if arg_206_1.time_ >= var_209_9 + var_209_12 and arg_206_1.time_ < var_209_9 + var_209_12 + arg_209_0 then
				var_209_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_209_15 = 0
			local var_209_16 = 0.125

			if var_209_15 < arg_206_1.time_ and arg_206_1.time_ <= var_209_15 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_17 = arg_206_1:FormatText(StoryNameCfg[595].name)

				arg_206_1.leftNameTxt_.text = var_209_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_18 = arg_206_1:GetWordFromCfg(417171048)
				local var_209_19 = arg_206_1:FormatText(var_209_18.content)

				arg_206_1.text_.text = var_209_19

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_20 = 5
				local var_209_21 = utf8.len(var_209_19)
				local var_209_22 = var_209_20 <= 0 and var_209_16 or var_209_16 * (var_209_21 / var_209_20)

				if var_209_22 > 0 and var_209_16 < var_209_22 then
					arg_206_1.talkMaxDuration = var_209_22

					if var_209_22 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_22 + var_209_15
					end
				end

				arg_206_1.text_.text = var_209_19
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171048", "story_v_out_417171.awb") ~= 0 then
					local var_209_23 = manager.audio:GetVoiceLength("story_v_out_417171", "417171048", "story_v_out_417171.awb") / 1000

					if var_209_23 + var_209_15 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_23 + var_209_15
					end

					if var_209_18.prefab_name ~= "" and arg_206_1.actors_[var_209_18.prefab_name] ~= nil then
						local var_209_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_18.prefab_name].transform, "story_v_out_417171", "417171048", "story_v_out_417171.awb")

						arg_206_1:RecordAudio("417171048", var_209_24)
						arg_206_1:RecordAudio("417171048", var_209_24)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417171", "417171048", "story_v_out_417171.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417171", "417171048", "story_v_out_417171.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_25 = math.max(var_209_16, arg_206_1.talkMaxDuration)

			if var_209_15 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_25 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_25

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_25 and arg_206_1.time_ < var_209_15 + var_209_25 + arg_209_0 then
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
	Play417171049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417171049
		arg_210_1.duration_ = 11.73

		local var_210_0 = {
			zh = 9.5,
			ja = 11.733
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417171050(arg_210_1)
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
			local var_213_9 = 1.05

			if var_213_8 < arg_210_1.time_ and arg_210_1.time_ <= var_213_8 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_10 = arg_210_1:FormatText(StoryNameCfg[1142].name)

				arg_210_1.leftNameTxt_.text = var_213_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_11 = arg_210_1:GetWordFromCfg(417171049)
				local var_213_12 = arg_210_1:FormatText(var_213_11.content)

				arg_210_1.text_.text = var_213_12

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_13 = 42
				local var_213_14 = utf8.len(var_213_12)
				local var_213_15 = var_213_13 <= 0 and var_213_9 or var_213_9 * (var_213_14 / var_213_13)

				if var_213_15 > 0 and var_213_9 < var_213_15 then
					arg_210_1.talkMaxDuration = var_213_15

					if var_213_15 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_15 + var_213_8
					end
				end

				arg_210_1.text_.text = var_213_12
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171049", "story_v_out_417171.awb") ~= 0 then
					local var_213_16 = manager.audio:GetVoiceLength("story_v_out_417171", "417171049", "story_v_out_417171.awb") / 1000

					if var_213_16 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_16 + var_213_8
					end

					if var_213_11.prefab_name ~= "" and arg_210_1.actors_[var_213_11.prefab_name] ~= nil then
						local var_213_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_11.prefab_name].transform, "story_v_out_417171", "417171049", "story_v_out_417171.awb")

						arg_210_1:RecordAudio("417171049", var_213_17)
						arg_210_1:RecordAudio("417171049", var_213_17)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417171", "417171049", "story_v_out_417171.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417171", "417171049", "story_v_out_417171.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_18 = math.max(var_213_9, arg_210_1.talkMaxDuration)

			if var_213_8 <= arg_210_1.time_ and arg_210_1.time_ < var_213_8 + var_213_18 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_8) / var_213_18

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_8 + var_213_18 and arg_210_1.time_ < var_213_8 + var_213_18 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play417171050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417171050
		arg_214_1.duration_ = 8.03

		local var_214_0 = {
			zh = 7.6,
			ja = 8.033
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
				arg_214_0:Play417171051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.975

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[1142].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(417171050)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171050", "story_v_out_417171.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171050", "story_v_out_417171.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_417171", "417171050", "story_v_out_417171.awb")

						arg_214_1:RecordAudio("417171050", var_217_9)
						arg_214_1:RecordAudio("417171050", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417171", "417171050", "story_v_out_417171.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417171", "417171050", "story_v_out_417171.awb")
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
	Play417171051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417171051
		arg_218_1.duration_ = 4.3

		local var_218_0 = {
			zh = 3.733,
			ja = 4.3
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
				arg_218_0:Play417171052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10128"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps10128 == nil then
				arg_218_1.var_.actorSpriteComps10128 = var_221_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_2 = 0.2

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.actorSpriteComps10128 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								local var_221_4 = Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, var_221_3)
								local var_221_5 = Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, var_221_3)
								local var_221_6 = Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, var_221_3)

								iter_221_1.color = Color.New(var_221_4, var_221_5, var_221_6)
							else
								local var_221_7 = Mathf.Lerp(iter_221_1.color.r, 1, var_221_3)

								iter_221_1.color = Color.New(var_221_7, var_221_7, var_221_7)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.actorSpriteComps10128 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_221_3 then
						if arg_218_1.isInRecall_ then
							iter_221_3.color = arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_221_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_218_1.var_.actorSpriteComps10128 = nil
			end

			local var_221_8 = 0
			local var_221_9 = 0.3

			if var_221_8 < arg_218_1.time_ and arg_218_1.time_ <= var_221_8 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_10 = arg_218_1:FormatText(StoryNameCfg[595].name)

				arg_218_1.leftNameTxt_.text = var_221_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_11 = arg_218_1:GetWordFromCfg(417171051)
				local var_221_12 = arg_218_1:FormatText(var_221_11.content)

				arg_218_1.text_.text = var_221_12

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_13 = 12
				local var_221_14 = utf8.len(var_221_12)
				local var_221_15 = var_221_13 <= 0 and var_221_9 or var_221_9 * (var_221_14 / var_221_13)

				if var_221_15 > 0 and var_221_9 < var_221_15 then
					arg_218_1.talkMaxDuration = var_221_15

					if var_221_15 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_15 + var_221_8
					end
				end

				arg_218_1.text_.text = var_221_12
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171051", "story_v_out_417171.awb") ~= 0 then
					local var_221_16 = manager.audio:GetVoiceLength("story_v_out_417171", "417171051", "story_v_out_417171.awb") / 1000

					if var_221_16 + var_221_8 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_16 + var_221_8
					end

					if var_221_11.prefab_name ~= "" and arg_218_1.actors_[var_221_11.prefab_name] ~= nil then
						local var_221_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_11.prefab_name].transform, "story_v_out_417171", "417171051", "story_v_out_417171.awb")

						arg_218_1:RecordAudio("417171051", var_221_17)
						arg_218_1:RecordAudio("417171051", var_221_17)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417171", "417171051", "story_v_out_417171.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417171", "417171051", "story_v_out_417171.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_18 = math.max(var_221_9, arg_218_1.talkMaxDuration)

			if var_221_8 <= arg_218_1.time_ and arg_218_1.time_ < var_221_8 + var_221_18 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_8) / var_221_18

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_8 + var_221_18 and arg_218_1.time_ < var_221_8 + var_221_18 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play417171052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417171052
		arg_222_1.duration_ = 5.17

		local var_222_0 = {
			zh = 3.466,
			ja = 5.166
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
				arg_222_0:Play417171053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.375

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[595].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_3 = arg_222_1:GetWordFromCfg(417171052)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171052", "story_v_out_417171.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171052", "story_v_out_417171.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_417171", "417171052", "story_v_out_417171.awb")

						arg_222_1:RecordAudio("417171052", var_225_9)
						arg_222_1:RecordAudio("417171052", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417171", "417171052", "story_v_out_417171.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417171", "417171052", "story_v_out_417171.awb")
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
	Play417171053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417171053
		arg_226_1.duration_ = 4.7

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417171054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10128"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps10128 == nil then
				arg_226_1.var_.actorSpriteComps10128 = var_229_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.actorSpriteComps10128 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								local var_229_4 = Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor2.r, var_229_3)
								local var_229_5 = Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor2.g, var_229_3)
								local var_229_6 = Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor2.b, var_229_3)

								iter_229_1.color = Color.New(var_229_4, var_229_5, var_229_6)
							else
								local var_229_7 = Mathf.Lerp(iter_229_1.color.r, 0.5, var_229_3)

								iter_229_1.color = Color.New(var_229_7, var_229_7, var_229_7)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.actorSpriteComps10128 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_229_3 then
						if arg_226_1.isInRecall_ then
							iter_229_3.color = arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_229_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps10128 = nil
			end

			local var_229_8 = 0
			local var_229_9 = 0.6

			if var_229_8 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_10 = arg_226_1:FormatText(StoryNameCfg[1142].name)

				arg_226_1.leftNameTxt_.text = var_229_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerka")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_11 = arg_226_1:GetWordFromCfg(417171053)
				local var_229_12 = arg_226_1:FormatText(var_229_11.content)

				arg_226_1.text_.text = var_229_12

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_13 = 24
				local var_229_14 = utf8.len(var_229_12)
				local var_229_15 = var_229_13 <= 0 and var_229_9 or var_229_9 * (var_229_14 / var_229_13)

				if var_229_15 > 0 and var_229_9 < var_229_15 then
					arg_226_1.talkMaxDuration = var_229_15

					if var_229_15 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_15 + var_229_8
					end
				end

				arg_226_1.text_.text = var_229_12
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171053", "story_v_out_417171.awb") ~= 0 then
					local var_229_16 = manager.audio:GetVoiceLength("story_v_out_417171", "417171053", "story_v_out_417171.awb") / 1000

					if var_229_16 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_16 + var_229_8
					end

					if var_229_11.prefab_name ~= "" and arg_226_1.actors_[var_229_11.prefab_name] ~= nil then
						local var_229_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_11.prefab_name].transform, "story_v_out_417171", "417171053", "story_v_out_417171.awb")

						arg_226_1:RecordAudio("417171053", var_229_17)
						arg_226_1:RecordAudio("417171053", var_229_17)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417171", "417171053", "story_v_out_417171.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417171", "417171053", "story_v_out_417171.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_18 = math.max(var_229_9, arg_226_1.talkMaxDuration)

			if var_229_8 <= arg_226_1.time_ and arg_226_1.time_ < var_229_8 + var_229_18 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_8) / var_229_18

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_8 + var_229_18 and arg_226_1.time_ < var_229_8 + var_229_18 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417171054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417171054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417171055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10128"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos10128 = var_233_0.localPosition
				var_233_0.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10128", 7)

				local var_233_2 = var_233_0.childCount

				for iter_233_0 = 0, var_233_2 - 1 do
					local var_233_3 = var_233_0:GetChild(iter_233_0)

					if var_233_3.name == "" or not string.find(var_233_3.name, "split") then
						var_233_3.gameObject:SetActive(true)
					else
						var_233_3.gameObject:SetActive(false)
					end
				end
			end

			local var_233_4 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_4 then
				local var_233_5 = (arg_230_1.time_ - var_233_1) / var_233_4
				local var_233_6 = Vector3.New(0, -2000, -300)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10128, var_233_6, var_233_5)
			end

			if arg_230_1.time_ >= var_233_1 + var_233_4 and arg_230_1.time_ < var_233_1 + var_233_4 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_233_7 = 0
			local var_233_8 = 0.775

			if var_233_7 < arg_230_1.time_ and arg_230_1.time_ <= var_233_7 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_9 = arg_230_1:GetWordFromCfg(417171054)
				local var_233_10 = arg_230_1:FormatText(var_233_9.content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 31
				local var_233_12 = utf8.len(var_233_10)
				local var_233_13 = var_233_11 <= 0 and var_233_8 or var_233_8 * (var_233_12 / var_233_11)

				if var_233_13 > 0 and var_233_8 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_7 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_7
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_14 = math.max(var_233_8, arg_230_1.talkMaxDuration)

			if var_233_7 <= arg_230_1.time_ and arg_230_1.time_ < var_233_7 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_7) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_7 + var_233_14 and arg_230_1.time_ < var_233_7 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play417171055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417171055
		arg_234_1.duration_ = 6.9

		local var_234_0 = {
			zh = 5.3,
			ja = 6.9
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417171056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 4

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			local var_237_1 = 0.0666666666666664

			if arg_234_1.time_ >= var_237_0 + var_237_1 and arg_234_1.time_ < var_237_0 + var_237_1 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			local var_237_2 = "SS1706"

			if arg_234_1.bgs_[var_237_2] == nil then
				local var_237_3 = Object.Instantiate(arg_234_1.paintGo_)

				var_237_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_2)
				var_237_3.name = var_237_2
				var_237_3.transform.parent = arg_234_1.stage_.transform
				var_237_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.bgs_[var_237_2] = var_237_3
			end

			local var_237_4 = 2

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				local var_237_5 = manager.ui.mainCamera.transform.localPosition
				local var_237_6 = Vector3.New(0, 0, 10) + Vector3.New(var_237_5.x, var_237_5.y, 0)
				local var_237_7 = arg_234_1.bgs_.SS1706

				var_237_7.transform.localPosition = var_237_6
				var_237_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_8 = var_237_7:GetComponent("SpriteRenderer")

				if var_237_8 and var_237_8.sprite then
					local var_237_9 = (var_237_7.transform.localPosition - var_237_5).z
					local var_237_10 = manager.ui.mainCameraCom_
					local var_237_11 = 2 * var_237_9 * Mathf.Tan(var_237_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_237_12 = var_237_11 * var_237_10.aspect
					local var_237_13 = var_237_8.sprite.bounds.size.x
					local var_237_14 = var_237_8.sprite.bounds.size.y
					local var_237_15 = var_237_12 / var_237_13
					local var_237_16 = var_237_11 / var_237_14
					local var_237_17 = var_237_16 < var_237_15 and var_237_15 or var_237_16

					var_237_7.transform.localScale = Vector3.New(var_237_17, var_237_17, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "SS1706" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_18 = 0

			if var_237_18 < arg_234_1.time_ and arg_234_1.time_ <= var_237_18 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_19 = 2

			if var_237_18 <= arg_234_1.time_ and arg_234_1.time_ < var_237_18 + var_237_19 then
				local var_237_20 = (arg_234_1.time_ - var_237_18) / var_237_19
				local var_237_21 = Color.New(0, 0, 0)

				var_237_21.a = Mathf.Lerp(0, 1, var_237_20)
				arg_234_1.mask_.color = var_237_21
			end

			if arg_234_1.time_ >= var_237_18 + var_237_19 and arg_234_1.time_ < var_237_18 + var_237_19 + arg_237_0 then
				local var_237_22 = Color.New(0, 0, 0)

				var_237_22.a = 1
				arg_234_1.mask_.color = var_237_22
			end

			local var_237_23 = 2

			if var_237_23 < arg_234_1.time_ and arg_234_1.time_ <= var_237_23 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_24 = 2

			if var_237_23 <= arg_234_1.time_ and arg_234_1.time_ < var_237_23 + var_237_24 then
				local var_237_25 = (arg_234_1.time_ - var_237_23) / var_237_24
				local var_237_26 = Color.New(0, 0, 0)

				var_237_26.a = Mathf.Lerp(1, 0, var_237_25)
				arg_234_1.mask_.color = var_237_26
			end

			if arg_234_1.time_ >= var_237_23 + var_237_24 and arg_234_1.time_ < var_237_23 + var_237_24 + arg_237_0 then
				local var_237_27 = Color.New(0, 0, 0)
				local var_237_28 = 0

				arg_234_1.mask_.enabled = false
				var_237_27.a = var_237_28
				arg_234_1.mask_.color = var_237_27
			end

			local var_237_29 = 2

			arg_234_1.isInRecall_ = true

			if var_237_29 < arg_234_1.time_ and arg_234_1.time_ <= var_237_29 + arg_237_0 then
				arg_234_1.screenFilterGo_:SetActive(true)

				arg_234_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_234_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_234_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_237_2, iter_237_3 in pairs(arg_234_1.actors_) do
					local var_237_30 = iter_237_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_237_4, iter_237_5 in ipairs(var_237_30) do
						if iter_237_5.color.r > 0.51 then
							iter_237_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_237_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_237_31 = 0.0666666666666667

			if var_237_29 <= arg_234_1.time_ and arg_234_1.time_ < var_237_29 + var_237_31 then
				local var_237_32 = (arg_234_1.time_ - var_237_29) / var_237_31

				arg_234_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_237_32)
			end

			if arg_234_1.time_ >= var_237_29 + var_237_31 and arg_234_1.time_ < var_237_29 + var_237_31 + arg_237_0 then
				arg_234_1.screenFilterEffect_.weight = 1
			end

			local var_237_33 = 0.5
			local var_237_34 = 1

			if var_237_33 < arg_234_1.time_ and arg_234_1.time_ <= var_237_33 + arg_237_0 then
				local var_237_35 = "stop"
				local var_237_36 = "effect"

				arg_234_1:AudioAction(var_237_35, var_237_36, "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_37 = 4
			local var_237_38 = 0.125

			if var_237_37 < arg_234_1.time_ and arg_234_1.time_ <= var_237_37 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_39 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_39:setOnUpdate(LuaHelper.FloatAction(function(arg_238_0)
					arg_234_1.dialogCg_.alpha = arg_238_0
				end))
				var_237_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_40 = arg_234_1:FormatText(StoryNameCfg[1125].name)

				arg_234_1.leftNameTxt_.text = var_237_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_41 = arg_234_1:GetWordFromCfg(417171055)
				local var_237_42 = arg_234_1:FormatText(var_237_41.content)

				arg_234_1.text_.text = var_237_42

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_43 = 5
				local var_237_44 = utf8.len(var_237_42)
				local var_237_45 = var_237_43 <= 0 and var_237_38 or var_237_38 * (var_237_44 / var_237_43)

				if var_237_45 > 0 and var_237_38 < var_237_45 then
					arg_234_1.talkMaxDuration = var_237_45
					var_237_37 = var_237_37 + 0.3

					if var_237_45 + var_237_37 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_45 + var_237_37
					end
				end

				arg_234_1.text_.text = var_237_42
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171055", "story_v_out_417171.awb") ~= 0 then
					local var_237_46 = manager.audio:GetVoiceLength("story_v_out_417171", "417171055", "story_v_out_417171.awb") / 1000

					if var_237_46 + var_237_37 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_46 + var_237_37
					end

					if var_237_41.prefab_name ~= "" and arg_234_1.actors_[var_237_41.prefab_name] ~= nil then
						local var_237_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_41.prefab_name].transform, "story_v_out_417171", "417171055", "story_v_out_417171.awb")

						arg_234_1:RecordAudio("417171055", var_237_47)
						arg_234_1:RecordAudio("417171055", var_237_47)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_417171", "417171055", "story_v_out_417171.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_417171", "417171055", "story_v_out_417171.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_48 = var_237_37 + 0.3
			local var_237_49 = math.max(var_237_38, arg_234_1.talkMaxDuration)

			if var_237_48 <= arg_234_1.time_ and arg_234_1.time_ < var_237_48 + var_237_49 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_48) / var_237_49

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_48 + var_237_49 and arg_234_1.time_ < var_237_48 + var_237_49 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play417171056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 417171056
		arg_240_1.duration_ = 7.93

		local var_240_0 = {
			zh = 3.933,
			ja = 7.933
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play417171057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0
			local var_243_1 = 0.425

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_2 = arg_240_1:FormatText(StoryNameCfg[595].name)

				arg_240_1.leftNameTxt_.text = var_243_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_3 = arg_240_1:GetWordFromCfg(417171056)
				local var_243_4 = arg_240_1:FormatText(var_243_3.content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 17
				local var_243_6 = utf8.len(var_243_4)
				local var_243_7 = var_243_5 <= 0 and var_243_1 or var_243_1 * (var_243_6 / var_243_5)

				if var_243_7 > 0 and var_243_1 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171056", "story_v_out_417171.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_417171", "417171056", "story_v_out_417171.awb") / 1000

					if var_243_8 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_0
					end

					if var_243_3.prefab_name ~= "" and arg_240_1.actors_[var_243_3.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_3.prefab_name].transform, "story_v_out_417171", "417171056", "story_v_out_417171.awb")

						arg_240_1:RecordAudio("417171056", var_243_9)
						arg_240_1:RecordAudio("417171056", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_417171", "417171056", "story_v_out_417171.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_417171", "417171056", "story_v_out_417171.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_10 and arg_240_1.time_ < var_243_0 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play417171057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417171057
		arg_244_1.duration_ = 4.07

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play417171058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 1.96666666666667

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.allBtn_.enabled = false
			end

			local var_247_1 = 0.0166666666666667

			if arg_244_1.time_ >= var_247_0 + var_247_1 and arg_244_1.time_ < var_247_0 + var_247_1 + arg_247_0 then
				arg_244_1.allBtn_.enabled = true
			end

			local var_247_2 = 1

			if var_247_2 < arg_244_1.time_ and arg_244_1.time_ <= var_247_2 + arg_247_0 then
				local var_247_3 = manager.ui.mainCamera.transform.localPosition
				local var_247_4 = Vector3.New(0, 0, 10) + Vector3.New(var_247_3.x, var_247_3.y, 0)
				local var_247_5 = arg_244_1.bgs_.I16h

				var_247_5.transform.localPosition = var_247_4
				var_247_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_247_6 = var_247_5:GetComponent("SpriteRenderer")

				if var_247_6 and var_247_6.sprite then
					local var_247_7 = (var_247_5.transform.localPosition - var_247_3).z
					local var_247_8 = manager.ui.mainCameraCom_
					local var_247_9 = 2 * var_247_7 * Mathf.Tan(var_247_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_247_10 = var_247_9 * var_247_8.aspect
					local var_247_11 = var_247_6.sprite.bounds.size.x
					local var_247_12 = var_247_6.sprite.bounds.size.y
					local var_247_13 = var_247_10 / var_247_11
					local var_247_14 = var_247_9 / var_247_12
					local var_247_15 = var_247_14 < var_247_13 and var_247_13 or var_247_14

					var_247_5.transform.localScale = Vector3.New(var_247_15, var_247_15, 0)
				end

				for iter_247_0, iter_247_1 in pairs(arg_244_1.bgs_) do
					if iter_247_0 ~= "I16h" then
						iter_247_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_247_16 = 0

			if var_247_16 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_17 = 1

			if var_247_16 <= arg_244_1.time_ and arg_244_1.time_ < var_247_16 + var_247_17 then
				local var_247_18 = (arg_244_1.time_ - var_247_16) / var_247_17
				local var_247_19 = Color.New(0, 0, 0)

				var_247_19.a = Mathf.Lerp(0, 1, var_247_18)
				arg_244_1.mask_.color = var_247_19
			end

			if arg_244_1.time_ >= var_247_16 + var_247_17 and arg_244_1.time_ < var_247_16 + var_247_17 + arg_247_0 then
				local var_247_20 = Color.New(0, 0, 0)

				var_247_20.a = 1
				arg_244_1.mask_.color = var_247_20
			end

			local var_247_21 = 1

			if var_247_21 < arg_244_1.time_ and arg_244_1.time_ <= var_247_21 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_22 = 0.966666666666667

			if var_247_21 <= arg_244_1.time_ and arg_244_1.time_ < var_247_21 + var_247_22 then
				local var_247_23 = (arg_244_1.time_ - var_247_21) / var_247_22
				local var_247_24 = Color.New(0, 0, 0)

				var_247_24.a = Mathf.Lerp(1, 0, var_247_23)
				arg_244_1.mask_.color = var_247_24
			end

			if arg_244_1.time_ >= var_247_21 + var_247_22 and arg_244_1.time_ < var_247_21 + var_247_22 + arg_247_0 then
				local var_247_25 = Color.New(0, 0, 0)
				local var_247_26 = 0

				arg_244_1.mask_.enabled = false
				var_247_25.a = var_247_26
				arg_244_1.mask_.color = var_247_25
			end

			local var_247_27 = arg_244_1.actors_["10128"].transform
			local var_247_28 = 1.76666666666667

			if var_247_28 < arg_244_1.time_ and arg_244_1.time_ <= var_247_28 + arg_247_0 then
				arg_244_1.var_.moveOldPos10128 = var_247_27.localPosition
				var_247_27.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10128", 3)

				local var_247_29 = var_247_27.childCount

				for iter_247_2 = 0, var_247_29 - 1 do
					local var_247_30 = var_247_27:GetChild(iter_247_2)

					if var_247_30.name == "split_6" or not string.find(var_247_30.name, "split") then
						var_247_30.gameObject:SetActive(true)
					else
						var_247_30.gameObject:SetActive(false)
					end
				end
			end

			local var_247_31 = 0.001

			if var_247_28 <= arg_244_1.time_ and arg_244_1.time_ < var_247_28 + var_247_31 then
				local var_247_32 = (arg_244_1.time_ - var_247_28) / var_247_31
				local var_247_33 = Vector3.New(0, -347, -300)

				var_247_27.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10128, var_247_33, var_247_32)
			end

			if arg_244_1.time_ >= var_247_28 + var_247_31 and arg_244_1.time_ < var_247_28 + var_247_31 + arg_247_0 then
				var_247_27.localPosition = Vector3.New(0, -347, -300)
			end

			local var_247_34 = arg_244_1.actors_["10128"]
			local var_247_35 = 1.76733333333333

			if var_247_35 < arg_244_1.time_ and arg_244_1.time_ <= var_247_35 + arg_247_0 and not isNil(var_247_34) and arg_244_1.var_.actorSpriteComps10128 == nil then
				arg_244_1.var_.actorSpriteComps10128 = var_247_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_36 = 0.0999999999999999

			if var_247_35 <= arg_244_1.time_ and arg_244_1.time_ < var_247_35 + var_247_36 and not isNil(var_247_34) then
				local var_247_37 = (arg_244_1.time_ - var_247_35) / var_247_36

				if arg_244_1.var_.actorSpriteComps10128 then
					for iter_247_3, iter_247_4 in pairs(arg_244_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_247_4 then
							if arg_244_1.isInRecall_ then
								local var_247_38 = Mathf.Lerp(iter_247_4.color.r, arg_244_1.hightColor1.r, var_247_37)
								local var_247_39 = Mathf.Lerp(iter_247_4.color.g, arg_244_1.hightColor1.g, var_247_37)
								local var_247_40 = Mathf.Lerp(iter_247_4.color.b, arg_244_1.hightColor1.b, var_247_37)

								iter_247_4.color = Color.New(var_247_38, var_247_39, var_247_40)
							else
								local var_247_41 = Mathf.Lerp(iter_247_4.color.r, 1, var_247_37)

								iter_247_4.color = Color.New(var_247_41, var_247_41, var_247_41)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_35 + var_247_36 and arg_244_1.time_ < var_247_35 + var_247_36 + arg_247_0 and not isNil(var_247_34) and arg_244_1.var_.actorSpriteComps10128 then
				for iter_247_5, iter_247_6 in pairs(arg_244_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_247_6 then
						if arg_244_1.isInRecall_ then
							iter_247_6.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps10128 = nil
			end

			local var_247_42 = arg_244_1.actors_["10128"]
			local var_247_43 = 1.76666666666667

			if var_247_43 < arg_244_1.time_ and arg_244_1.time_ <= var_247_43 + arg_247_0 then
				local var_247_44 = var_247_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_247_44 then
					arg_244_1.var_.alphaOldValue10128 = var_247_44.alpha
					arg_244_1.var_.characterEffect10128 = var_247_44
				end

				arg_244_1.var_.alphaOldValue10128 = 0
			end

			local var_247_45 = 0.2

			if var_247_43 <= arg_244_1.time_ and arg_244_1.time_ < var_247_43 + var_247_45 then
				local var_247_46 = (arg_244_1.time_ - var_247_43) / var_247_45
				local var_247_47 = Mathf.Lerp(arg_244_1.var_.alphaOldValue10128, 1, var_247_46)

				if arg_244_1.var_.characterEffect10128 then
					arg_244_1.var_.characterEffect10128.alpha = var_247_47
				end
			end

			if arg_244_1.time_ >= var_247_43 + var_247_45 and arg_244_1.time_ < var_247_43 + var_247_45 + arg_247_0 and arg_244_1.var_.characterEffect10128 then
				arg_244_1.var_.characterEffect10128.alpha = 1
			end

			if arg_244_1.frameCnt_ <= 1 then
				arg_244_1.dialog_:SetActive(false)
			end

			local var_247_48 = 1.96666666666667
			local var_247_49 = 0.075

			if var_247_48 < arg_244_1.time_ and arg_244_1.time_ <= var_247_48 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0

				arg_244_1.dialog_:SetActive(true)

				arg_244_1.dialogCg_.alpha = 0

				local var_247_50 = LeanTween.value(arg_244_1.dialog_, 0, 1, 0.3)

				var_247_50:setOnUpdate(LuaHelper.FloatAction(function(arg_248_0)
					arg_244_1.dialogCg_.alpha = arg_248_0
				end))
				var_247_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_244_1.dialog_)
					var_247_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_244_1.duration_ = arg_244_1.duration_ + 0.3

				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_51 = arg_244_1:FormatText(StoryNameCfg[595].name)

				arg_244_1.leftNameTxt_.text = var_247_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_52 = arg_244_1:GetWordFromCfg(417171057)
				local var_247_53 = arg_244_1:FormatText(var_247_52.content)

				arg_244_1.text_.text = var_247_53

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_54 = 3
				local var_247_55 = utf8.len(var_247_53)
				local var_247_56 = var_247_54 <= 0 and var_247_49 or var_247_49 * (var_247_55 / var_247_54)

				if var_247_56 > 0 and var_247_49 < var_247_56 then
					arg_244_1.talkMaxDuration = var_247_56
					var_247_48 = var_247_48 + 0.3

					if var_247_56 + var_247_48 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_56 + var_247_48
					end
				end

				arg_244_1.text_.text = var_247_53
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171057", "story_v_out_417171.awb") ~= 0 then
					local var_247_57 = manager.audio:GetVoiceLength("story_v_out_417171", "417171057", "story_v_out_417171.awb") / 1000

					if var_247_57 + var_247_48 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_57 + var_247_48
					end

					if var_247_52.prefab_name ~= "" and arg_244_1.actors_[var_247_52.prefab_name] ~= nil then
						local var_247_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_52.prefab_name].transform, "story_v_out_417171", "417171057", "story_v_out_417171.awb")

						arg_244_1:RecordAudio("417171057", var_247_58)
						arg_244_1:RecordAudio("417171057", var_247_58)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_417171", "417171057", "story_v_out_417171.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_417171", "417171057", "story_v_out_417171.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_59 = var_247_48 + 0.3
			local var_247_60 = math.max(var_247_49, arg_244_1.talkMaxDuration)

			if var_247_59 <= arg_244_1.time_ and arg_244_1.time_ < var_247_59 + var_247_60 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_59) / var_247_60

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_59 + var_247_60 and arg_244_1.time_ < var_247_59 + var_247_60 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play417171058 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 417171058
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play417171059(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10128"].transform
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.var_.moveOldPos10128 = var_253_0.localPosition
				var_253_0.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10128", 7)

				local var_253_2 = var_253_0.childCount

				for iter_253_0 = 0, var_253_2 - 1 do
					local var_253_3 = var_253_0:GetChild(iter_253_0)

					if var_253_3.name == "" or not string.find(var_253_3.name, "split") then
						var_253_3.gameObject:SetActive(true)
					else
						var_253_3.gameObject:SetActive(false)
					end
				end
			end

			local var_253_4 = 0.001

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_4 then
				local var_253_5 = (arg_250_1.time_ - var_253_1) / var_253_4
				local var_253_6 = Vector3.New(0, -2000, -300)

				var_253_0.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10128, var_253_6, var_253_5)
			end

			if arg_250_1.time_ >= var_253_1 + var_253_4 and arg_250_1.time_ < var_253_1 + var_253_4 + arg_253_0 then
				var_253_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_253_7 = 0
			local var_253_8 = 0.65

			if var_253_7 < arg_250_1.time_ and arg_250_1.time_ <= var_253_7 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_9 = arg_250_1:GetWordFromCfg(417171058)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 26
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_8 or var_253_8 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_8 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_7 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_7
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_14 = math.max(var_253_8, arg_250_1.talkMaxDuration)

			if var_253_7 <= arg_250_1.time_ and arg_250_1.time_ < var_253_7 + var_253_14 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_7) / var_253_14

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_7 + var_253_14 and arg_250_1.time_ < var_253_7 + var_253_14 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play417171059 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 417171059
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play417171060(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0
			local var_257_1 = 0.825

			if var_257_0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_2 = arg_254_1:GetWordFromCfg(417171059)
				local var_257_3 = arg_254_1:FormatText(var_257_2.content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 33
				local var_257_5 = utf8.len(var_257_3)
				local var_257_6 = var_257_4 <= 0 and var_257_1 or var_257_1 * (var_257_5 / var_257_4)

				if var_257_6 > 0 and var_257_1 < var_257_6 then
					arg_254_1.talkMaxDuration = var_257_6

					if var_257_6 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_6 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_7 and arg_254_1.time_ < var_257_0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play417171060 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 417171060
		arg_258_1.duration_ = 9

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play417171061(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 4

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.allBtn_.enabled = false
			end

			local var_261_1 = 0.3

			if arg_258_1.time_ >= var_261_0 + var_261_1 and arg_258_1.time_ < var_261_0 + var_261_1 + arg_261_0 then
				arg_258_1.allBtn_.enabled = true
			end

			local var_261_2 = 2

			if var_261_2 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				local var_261_3 = manager.ui.mainCamera.transform.localPosition
				local var_261_4 = Vector3.New(0, 0, 10) + Vector3.New(var_261_3.x, var_261_3.y, 0)
				local var_261_5 = arg_258_1.bgs_.SS1706

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
					if iter_261_0 ~= "SS1706" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_16 = 0

			if var_261_16 < arg_258_1.time_ and arg_258_1.time_ <= var_261_16 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_17 = 2

			if var_261_16 <= arg_258_1.time_ and arg_258_1.time_ < var_261_16 + var_261_17 then
				local var_261_18 = (arg_258_1.time_ - var_261_16) / var_261_17
				local var_261_19 = Color.New(0, 0, 0)

				var_261_19.a = Mathf.Lerp(0, 1, var_261_18)
				arg_258_1.mask_.color = var_261_19
			end

			if arg_258_1.time_ >= var_261_16 + var_261_17 and arg_258_1.time_ < var_261_16 + var_261_17 + arg_261_0 then
				local var_261_20 = Color.New(0, 0, 0)

				var_261_20.a = 1
				arg_258_1.mask_.color = var_261_20
			end

			local var_261_21 = 2

			if var_261_21 < arg_258_1.time_ and arg_258_1.time_ <= var_261_21 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_22 = 2

			if var_261_21 <= arg_258_1.time_ and arg_258_1.time_ < var_261_21 + var_261_22 then
				local var_261_23 = (arg_258_1.time_ - var_261_21) / var_261_22
				local var_261_24 = Color.New(0, 0, 0)

				var_261_24.a = Mathf.Lerp(1, 0, var_261_23)
				arg_258_1.mask_.color = var_261_24
			end

			if arg_258_1.time_ >= var_261_21 + var_261_22 and arg_258_1.time_ < var_261_21 + var_261_22 + arg_261_0 then
				local var_261_25 = Color.New(0, 0, 0)
				local var_261_26 = 0

				arg_258_1.mask_.enabled = false
				var_261_25.a = var_261_26
				arg_258_1.mask_.color = var_261_25
			end

			local var_261_27 = 4.13333333333333
			local var_261_28 = 1

			if var_261_27 < arg_258_1.time_ and arg_258_1.time_ <= var_261_27 + arg_261_0 then
				local var_261_29 = "play"
				local var_261_30 = "effect"

				arg_258_1:AudioAction(var_261_29, var_261_30, "se_story_1311", "se_story_1311_pictures", "")
			end

			if arg_258_1.frameCnt_ <= 1 then
				arg_258_1.dialog_:SetActive(false)
			end

			local var_261_31 = 4
			local var_261_32 = 0.9

			if var_261_31 < arg_258_1.time_ and arg_258_1.time_ <= var_261_31 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				arg_258_1.dialog_:SetActive(true)

				arg_258_1.dialogCg_.alpha = 0

				local var_261_33 = LeanTween.value(arg_258_1.dialog_, 0, 1, 0.3)

				var_261_33:setOnUpdate(LuaHelper.FloatAction(function(arg_262_0)
					arg_258_1.dialogCg_.alpha = arg_262_0
				end))
				var_261_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_258_1.dialog_)
					var_261_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_258_1.duration_ = arg_258_1.duration_ + 0.3

				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_34 = arg_258_1:GetWordFromCfg(417171060)
				local var_261_35 = arg_258_1:FormatText(var_261_34.content)

				arg_258_1.text_.text = var_261_35

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_36 = 36
				local var_261_37 = utf8.len(var_261_35)
				local var_261_38 = var_261_36 <= 0 and var_261_32 or var_261_32 * (var_261_37 / var_261_36)

				if var_261_38 > 0 and var_261_32 < var_261_38 then
					arg_258_1.talkMaxDuration = var_261_38
					var_261_31 = var_261_31 + 0.3

					if var_261_38 + var_261_31 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_38 + var_261_31
					end
				end

				arg_258_1.text_.text = var_261_35
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_39 = var_261_31 + 0.3
			local var_261_40 = math.max(var_261_32, arg_258_1.talkMaxDuration)

			if var_261_39 <= arg_258_1.time_ and arg_258_1.time_ < var_261_39 + var_261_40 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_39) / var_261_40

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_39 + var_261_40 and arg_258_1.time_ < var_261_39 + var_261_40 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play417171061 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 417171061
		arg_264_1.duration_ = 9

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play417171062(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 4

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			local var_267_1 = 0.766666666666667

			if arg_264_1.time_ >= var_267_0 + var_267_1 and arg_264_1.time_ < var_267_0 + var_267_1 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			local var_267_2 = 2

			if var_267_2 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				local var_267_3 = manager.ui.mainCamera.transform.localPosition
				local var_267_4 = Vector3.New(0, 0, 10) + Vector3.New(var_267_3.x, var_267_3.y, 0)
				local var_267_5 = arg_264_1.bgs_.I16h

				var_267_5.transform.localPosition = var_267_4
				var_267_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_6 = var_267_5:GetComponent("SpriteRenderer")

				if var_267_6 and var_267_6.sprite then
					local var_267_7 = (var_267_5.transform.localPosition - var_267_3).z
					local var_267_8 = manager.ui.mainCameraCom_
					local var_267_9 = 2 * var_267_7 * Mathf.Tan(var_267_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_267_10 = var_267_9 * var_267_8.aspect
					local var_267_11 = var_267_6.sprite.bounds.size.x
					local var_267_12 = var_267_6.sprite.bounds.size.y
					local var_267_13 = var_267_10 / var_267_11
					local var_267_14 = var_267_9 / var_267_12
					local var_267_15 = var_267_14 < var_267_13 and var_267_13 or var_267_14

					var_267_5.transform.localScale = Vector3.New(var_267_15, var_267_15, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "I16h" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_16 = 0

			if var_267_16 < arg_264_1.time_ and arg_264_1.time_ <= var_267_16 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_17 = 2

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

			local var_267_21 = 2

			if var_267_21 < arg_264_1.time_ and arg_264_1.time_ <= var_267_21 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_22 = 2

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

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_27 = 4
			local var_267_28 = 1.3

			if var_267_27 < arg_264_1.time_ and arg_264_1.time_ <= var_267_27 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_29 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_29:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_30 = arg_264_1:GetWordFromCfg(417171061)
				local var_267_31 = arg_264_1:FormatText(var_267_30.content)

				arg_264_1.text_.text = var_267_31

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_32 = 52
				local var_267_33 = utf8.len(var_267_31)
				local var_267_34 = var_267_32 <= 0 and var_267_28 or var_267_28 * (var_267_33 / var_267_32)

				if var_267_34 > 0 and var_267_28 < var_267_34 then
					arg_264_1.talkMaxDuration = var_267_34
					var_267_27 = var_267_27 + 0.3

					if var_267_34 + var_267_27 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_34 + var_267_27
					end
				end

				arg_264_1.text_.text = var_267_31
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_35 = var_267_27 + 0.3
			local var_267_36 = math.max(var_267_28, arg_264_1.talkMaxDuration)

			if var_267_35 <= arg_264_1.time_ and arg_264_1.time_ < var_267_35 + var_267_36 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_35) / var_267_36

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_35 + var_267_36 and arg_264_1.time_ < var_267_35 + var_267_36 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play417171062 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417171062
		arg_270_1.duration_ = 5.2

		local var_270_0 = {
			zh = 4.966,
			ja = 5.2
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
				arg_270_0:Play417171063(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 4

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			local var_273_1 = 0.0166666666666667

			if arg_270_1.time_ >= var_273_0 + var_273_1 and arg_270_1.time_ < var_273_0 + var_273_1 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			local var_273_2 = 2

			if var_273_2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_2 + arg_273_0 then
				local var_273_3 = manager.ui.mainCamera.transform.localPosition
				local var_273_4 = Vector3.New(0, 0, 10) + Vector3.New(var_273_3.x, var_273_3.y, 0)
				local var_273_5 = arg_270_1.bgs_.ST75

				var_273_5.transform.localPosition = var_273_4
				var_273_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_6 = var_273_5:GetComponent("SpriteRenderer")

				if var_273_6 and var_273_6.sprite then
					local var_273_7 = (var_273_5.transform.localPosition - var_273_3).z
					local var_273_8 = manager.ui.mainCameraCom_
					local var_273_9 = 2 * var_273_7 * Mathf.Tan(var_273_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_273_10 = var_273_9 * var_273_8.aspect
					local var_273_11 = var_273_6.sprite.bounds.size.x
					local var_273_12 = var_273_6.sprite.bounds.size.y
					local var_273_13 = var_273_10 / var_273_11
					local var_273_14 = var_273_9 / var_273_12
					local var_273_15 = var_273_14 < var_273_13 and var_273_13 or var_273_14

					var_273_5.transform.localScale = Vector3.New(var_273_15, var_273_15, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "ST75" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_16 = 0

			if var_273_16 < arg_270_1.time_ and arg_270_1.time_ <= var_273_16 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_17 = 2

			if var_273_16 <= arg_270_1.time_ and arg_270_1.time_ < var_273_16 + var_273_17 then
				local var_273_18 = (arg_270_1.time_ - var_273_16) / var_273_17
				local var_273_19 = Color.New(0, 0, 0)

				var_273_19.a = Mathf.Lerp(0, 1, var_273_18)
				arg_270_1.mask_.color = var_273_19
			end

			if arg_270_1.time_ >= var_273_16 + var_273_17 and arg_270_1.time_ < var_273_16 + var_273_17 + arg_273_0 then
				local var_273_20 = Color.New(0, 0, 0)

				var_273_20.a = 1
				arg_270_1.mask_.color = var_273_20
			end

			local var_273_21 = 2

			if var_273_21 < arg_270_1.time_ and arg_270_1.time_ <= var_273_21 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_22 = 2

			if var_273_21 <= arg_270_1.time_ and arg_270_1.time_ < var_273_21 + var_273_22 then
				local var_273_23 = (arg_270_1.time_ - var_273_21) / var_273_22
				local var_273_24 = Color.New(0, 0, 0)

				var_273_24.a = Mathf.Lerp(1, 0, var_273_23)
				arg_270_1.mask_.color = var_273_24
			end

			if arg_270_1.time_ >= var_273_21 + var_273_22 and arg_270_1.time_ < var_273_21 + var_273_22 + arg_273_0 then
				local var_273_25 = Color.New(0, 0, 0)
				local var_273_26 = 0

				arg_270_1.mask_.enabled = false
				var_273_25.a = var_273_26
				arg_270_1.mask_.color = var_273_25
			end

			local var_273_27 = arg_270_1.actors_["10128"]
			local var_273_28 = 3.8

			if var_273_28 < arg_270_1.time_ and arg_270_1.time_ <= var_273_28 + arg_273_0 and not isNil(var_273_27) and arg_270_1.var_.actorSpriteComps10128 == nil then
				arg_270_1.var_.actorSpriteComps10128 = var_273_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_29 = 0.2

			if var_273_28 <= arg_270_1.time_ and arg_270_1.time_ < var_273_28 + var_273_29 and not isNil(var_273_27) then
				local var_273_30 = (arg_270_1.time_ - var_273_28) / var_273_29

				if arg_270_1.var_.actorSpriteComps10128 then
					for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_273_3 then
							if arg_270_1.isInRecall_ then
								local var_273_31 = Mathf.Lerp(iter_273_3.color.r, arg_270_1.hightColor1.r, var_273_30)
								local var_273_32 = Mathf.Lerp(iter_273_3.color.g, arg_270_1.hightColor1.g, var_273_30)
								local var_273_33 = Mathf.Lerp(iter_273_3.color.b, arg_270_1.hightColor1.b, var_273_30)

								iter_273_3.color = Color.New(var_273_31, var_273_32, var_273_33)
							else
								local var_273_34 = Mathf.Lerp(iter_273_3.color.r, 1, var_273_30)

								iter_273_3.color = Color.New(var_273_34, var_273_34, var_273_34)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= var_273_28 + var_273_29 and arg_270_1.time_ < var_273_28 + var_273_29 + arg_273_0 and not isNil(var_273_27) and arg_270_1.var_.actorSpriteComps10128 then
				for iter_273_4, iter_273_5 in pairs(arg_270_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_273_5 then
						if arg_270_1.isInRecall_ then
							iter_273_5.color = arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_273_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_270_1.var_.actorSpriteComps10128 = nil
			end

			local var_273_35 = arg_270_1.actors_["10128"].transform
			local var_273_36 = 3.8

			if var_273_36 < arg_270_1.time_ and arg_270_1.time_ <= var_273_36 + arg_273_0 then
				arg_270_1.var_.moveOldPos10128 = var_273_35.localPosition
				var_273_35.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10128", 3)

				local var_273_37 = var_273_35.childCount

				for iter_273_6 = 0, var_273_37 - 1 do
					local var_273_38 = var_273_35:GetChild(iter_273_6)

					if var_273_38.name == "" or not string.find(var_273_38.name, "split") then
						var_273_38.gameObject:SetActive(true)
					else
						var_273_38.gameObject:SetActive(false)
					end
				end
			end

			local var_273_39 = 0.001

			if var_273_36 <= arg_270_1.time_ and arg_270_1.time_ < var_273_36 + var_273_39 then
				local var_273_40 = (arg_270_1.time_ - var_273_36) / var_273_39
				local var_273_41 = Vector3.New(0, -347, -300)

				var_273_35.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10128, var_273_41, var_273_40)
			end

			if arg_270_1.time_ >= var_273_36 + var_273_39 and arg_270_1.time_ < var_273_36 + var_273_39 + arg_273_0 then
				var_273_35.localPosition = Vector3.New(0, -347, -300)
			end

			local var_273_42 = arg_270_1.actors_["10128"]
			local var_273_43 = 3.8

			if var_273_43 < arg_270_1.time_ and arg_270_1.time_ <= var_273_43 + arg_273_0 then
				local var_273_44 = var_273_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_273_44 then
					arg_270_1.var_.alphaOldValue10128 = var_273_44.alpha
					arg_270_1.var_.characterEffect10128 = var_273_44
				end

				arg_270_1.var_.alphaOldValue10128 = 0
			end

			local var_273_45 = 0.2

			if var_273_43 <= arg_270_1.time_ and arg_270_1.time_ < var_273_43 + var_273_45 then
				local var_273_46 = (arg_270_1.time_ - var_273_43) / var_273_45
				local var_273_47 = Mathf.Lerp(arg_270_1.var_.alphaOldValue10128, 1, var_273_46)

				if arg_270_1.var_.characterEffect10128 then
					arg_270_1.var_.characterEffect10128.alpha = var_273_47
				end
			end

			if arg_270_1.time_ >= var_273_43 + var_273_45 and arg_270_1.time_ < var_273_43 + var_273_45 + arg_273_0 and arg_270_1.var_.characterEffect10128 then
				arg_270_1.var_.characterEffect10128.alpha = 1
			end

			local var_273_48 = 1.93333333333333

			arg_270_1.isInRecall_ = false

			if var_273_48 < arg_270_1.time_ and arg_270_1.time_ <= var_273_48 + arg_273_0 then
				arg_270_1.screenFilterGo_:SetActive(false)

				for iter_273_7, iter_273_8 in pairs(arg_270_1.actors_) do
					local var_273_49 = iter_273_8:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_273_9, iter_273_10 in ipairs(var_273_49) do
						if iter_273_10.color.r > 0.51 then
							iter_273_10.color = Color.New(1, 1, 1)
						else
							iter_273_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_273_50 = 0.0666666666666667

			if var_273_48 <= arg_270_1.time_ and arg_270_1.time_ < var_273_48 + var_273_50 then
				local var_273_51 = (arg_270_1.time_ - var_273_48) / var_273_50

				arg_270_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_273_51)
			end

			if arg_270_1.time_ >= var_273_48 + var_273_50 and arg_270_1.time_ < var_273_48 + var_273_50 + arg_273_0 then
				arg_270_1.screenFilterEffect_.weight = 0
			end

			local var_273_52 = 1.66666666666667
			local var_273_53 = 1

			if var_273_52 < arg_270_1.time_ and arg_270_1.time_ <= var_273_52 + arg_273_0 then
				local var_273_54 = "play"
				local var_273_55 = "effect"

				arg_270_1:AudioAction(var_273_54, var_273_55, "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_56 = 4
			local var_273_57 = 0.05

			if var_273_56 < arg_270_1.time_ and arg_270_1.time_ <= var_273_56 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_58 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_58:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_59 = arg_270_1:FormatText(StoryNameCfg[595].name)

				arg_270_1.leftNameTxt_.text = var_273_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_60 = arg_270_1:GetWordFromCfg(417171062)
				local var_273_61 = arg_270_1:FormatText(var_273_60.content)

				arg_270_1.text_.text = var_273_61

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_62 = 2
				local var_273_63 = utf8.len(var_273_61)
				local var_273_64 = var_273_62 <= 0 and var_273_57 or var_273_57 * (var_273_63 / var_273_62)

				if var_273_64 > 0 and var_273_57 < var_273_64 then
					arg_270_1.talkMaxDuration = var_273_64
					var_273_56 = var_273_56 + 0.3

					if var_273_64 + var_273_56 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_64 + var_273_56
					end
				end

				arg_270_1.text_.text = var_273_61
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417171", "417171062", "story_v_out_417171.awb") ~= 0 then
					local var_273_65 = manager.audio:GetVoiceLength("story_v_out_417171", "417171062", "story_v_out_417171.awb") / 1000

					if var_273_65 + var_273_56 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_65 + var_273_56
					end

					if var_273_60.prefab_name ~= "" and arg_270_1.actors_[var_273_60.prefab_name] ~= nil then
						local var_273_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_60.prefab_name].transform, "story_v_out_417171", "417171062", "story_v_out_417171.awb")

						arg_270_1:RecordAudio("417171062", var_273_66)
						arg_270_1:RecordAudio("417171062", var_273_66)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417171", "417171062", "story_v_out_417171.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417171", "417171062", "story_v_out_417171.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_67 = var_273_56 + 0.3
			local var_273_68 = math.max(var_273_57, arg_270_1.talkMaxDuration)

			if var_273_67 <= arg_270_1.time_ and arg_270_1.time_ < var_273_67 + var_273_68 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_67) / var_273_68

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_67 + var_273_68 and arg_270_1.time_ < var_273_67 + var_273_68 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play417171063 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 417171063
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play417171064(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10128"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos10128 = var_279_0.localPosition
				var_279_0.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10128", 7)

				local var_279_2 = var_279_0.childCount

				for iter_279_0 = 0, var_279_2 - 1 do
					local var_279_3 = var_279_0:GetChild(iter_279_0)

					if var_279_3.name == "" or not string.find(var_279_3.name, "split") then
						var_279_3.gameObject:SetActive(true)
					else
						var_279_3.gameObject:SetActive(false)
					end
				end
			end

			local var_279_4 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_4 then
				local var_279_5 = (arg_276_1.time_ - var_279_1) / var_279_4
				local var_279_6 = Vector3.New(0, -2000, -300)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10128, var_279_6, var_279_5)
			end

			if arg_276_1.time_ >= var_279_1 + var_279_4 and arg_276_1.time_ < var_279_1 + var_279_4 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_279_7 = 0
			local var_279_8 = 1

			if var_279_7 < arg_276_1.time_ and arg_276_1.time_ <= var_279_7 + arg_279_0 then
				local var_279_9 = "play"
				local var_279_10 = "effect"

				arg_276_1:AudioAction(var_279_9, var_279_10, "se_story_138", "se_story_138_carloop_stop", "")
			end

			local var_279_11 = 0
			local var_279_12 = 1

			if var_279_11 < arg_276_1.time_ and arg_276_1.time_ <= var_279_11 + arg_279_0 then
				local var_279_13 = "stop"
				local var_279_14 = "effect"

				arg_276_1:AudioAction(var_279_13, var_279_14, "se_story_1311_truck_loop", "se_story_1311_truck_loop", "")
			end

			local var_279_15 = 0
			local var_279_16 = 1.75

			if var_279_15 < arg_276_1.time_ and arg_276_1.time_ <= var_279_15 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_17 = arg_276_1:GetWordFromCfg(417171063)
				local var_279_18 = arg_276_1:FormatText(var_279_17.content)

				arg_276_1.text_.text = var_279_18

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_19 = 70
				local var_279_20 = utf8.len(var_279_18)
				local var_279_21 = var_279_19 <= 0 and var_279_16 or var_279_16 * (var_279_20 / var_279_19)

				if var_279_21 > 0 and var_279_16 < var_279_21 then
					arg_276_1.talkMaxDuration = var_279_21

					if var_279_21 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_21 + var_279_15
					end
				end

				arg_276_1.text_.text = var_279_18
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_22 = math.max(var_279_16, arg_276_1.talkMaxDuration)

			if var_279_15 <= arg_276_1.time_ and arg_276_1.time_ < var_279_15 + var_279_22 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_15) / var_279_22

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_15 + var_279_22 and arg_276_1.time_ < var_279_15 + var_279_22 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
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

		arg_276_1:InitPlayNodeList()
	end,
	Play417171064 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 417171064
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play417171065(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.05
			local var_283_1 = 1

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				local var_283_2 = "play"
				local var_283_3 = "effect"

				arg_280_1:AudioAction(var_283_2, var_283_3, "se_story_1311", "se_story_1311_cardoor", "")
			end

			local var_283_4 = 0
			local var_283_5 = 0.725

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_6 = arg_280_1:GetWordFromCfg(417171064)
				local var_283_7 = arg_280_1:FormatText(var_283_6.content)

				arg_280_1.text_.text = var_283_7

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_8 = 29
				local var_283_9 = utf8.len(var_283_7)
				local var_283_10 = var_283_8 <= 0 and var_283_5 or var_283_5 * (var_283_9 / var_283_8)

				if var_283_10 > 0 and var_283_5 < var_283_10 then
					arg_280_1.talkMaxDuration = var_283_10

					if var_283_10 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_10 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_7
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_11 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_11 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_11

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_11 and arg_280_1.time_ < var_283_4 + var_283_11 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play417171065 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 417171065
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
			arg_284_1.auto_ = false
		end

		function arg_284_1.playNext_(arg_286_0)
			arg_284_1.onStoryFinished_()
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.875

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_2 = arg_284_1:GetWordFromCfg(417171065)
				local var_287_3 = arg_284_1:FormatText(var_287_2.content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 35
				local var_287_5 = utf8.len(var_287_3)
				local var_287_6 = var_287_4 <= 0 and var_287_1 or var_287_1 * (var_287_5 / var_287_4)

				if var_287_6 > 0 and var_287_1 < var_287_6 then
					arg_284_1.talkMaxDuration = var_287_6

					if var_287_6 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_7 and arg_284_1.time_ < var_287_0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I16h",
		"TextureConfig/Background/I17f",
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/SS1706"
	},
	voices = {
		"story_v_out_417171.awb"
	}
}
