return {
	Play417111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417111001
		arg_1_1.duration_ = 9.52

		local var_1_0 = {
			zh = 7.51666666666667,
			ja = 9.51666666666667
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
				arg_1_0:Play417111002(arg_1_1)
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

			local var_4_16 = 5.56666666666667

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = "10072"

			if arg_1_1.actors_[var_4_18] == nil then
				local var_4_19 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10072")

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

			local var_4_22 = arg_1_1.actors_["10072"]
			local var_4_23 = 0

			if var_4_23 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 and not isNil(var_4_22) and arg_1_1.var_.actorSpriteComps10072 == nil then
				arg_1_1.var_.actorSpriteComps10072 = var_4_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_24 = 0.2

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 and not isNil(var_4_22) then
				local var_4_25 = (arg_1_1.time_ - var_4_23) / var_4_24

				if arg_1_1.var_.actorSpriteComps10072 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10072:ToTable()) do
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

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 and not isNil(var_4_22) and arg_1_1.var_.actorSpriteComps10072 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10072:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10072 = nil
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

				arg_1_1:AudioAction(var_4_38, var_4_39, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_4_40 = ""
				local var_4_41 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

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

			local var_4_42 = 0
			local var_4_43 = 3
			local var_4_44 = "I07a"

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_44)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_45 = arg_1_1:GetWordFromCfg(501039)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.text_timeText_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_47 = arg_1_1:GetWordFromCfg(501040)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_siteText_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_49 = 3

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_50 = 1.2

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_50 then
				local var_4_51 = (arg_1_1.time_ - var_4_49) / var_4_50
				local var_4_52 = Color.New(0, 0, 0)

				var_4_52.a = Mathf.Lerp(0, 1, var_4_51)
				arg_1_1.mask_.color = var_4_52
			end

			if arg_1_1.time_ >= var_4_49 + var_4_50 and arg_1_1.time_ < var_4_49 + var_4_50 + arg_4_0 then
				local var_4_53 = Color.New(0, 0, 0)

				var_4_53.a = 1
				arg_1_1.mask_.color = var_4_53
			end

			local var_4_54 = 4.2

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_55 = 1.2

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_55 then
				local var_4_56 = (arg_1_1.time_ - var_4_54) / var_4_55
				local var_4_57 = Color.New(0, 0, 0)

				var_4_57.a = Mathf.Lerp(1, 0, var_4_56)
				arg_1_1.mask_.color = var_4_57
			end

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				local var_4_58 = Color.New(0, 0, 0)
				local var_4_59 = 0

				arg_1_1.mask_.enabled = false
				var_4_58.a = var_4_59
				arg_1_1.mask_.color = var_4_58
			end

			local var_4_60 = 0

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_61 = 1

			if var_4_60 <= arg_1_1.time_ and arg_1_1.time_ < var_4_60 + var_4_61 then
				local var_4_62 = (arg_1_1.time_ - var_4_60) / var_4_61
				local var_4_63 = Color.New(0, 0, 0)

				var_4_63.a = Mathf.Lerp(1, 0, var_4_62)
				arg_1_1.mask_.color = var_4_63
			end

			if arg_1_1.time_ >= var_4_60 + var_4_61 and arg_1_1.time_ < var_4_60 + var_4_61 + arg_4_0 then
				local var_4_64 = Color.New(0, 0, 0)
				local var_4_65 = 0

				arg_1_1.mask_.enabled = false
				var_4_64.a = var_4_65
				arg_1_1.mask_.color = var_4_64
			end

			local var_4_66 = 0

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_67 = 3

			if arg_1_1.time_ >= var_4_66 + var_4_67 and arg_1_1.time_ < var_4_66 + var_4_67 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_68 = 5.61666666666667
			local var_4_69 = 0.25

			if var_4_68 < arg_1_1.time_ and arg_1_1.time_ <= var_4_68 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_70 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_70:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_71 = arg_1_1:FormatText(StoryNameCfg[1136].name)

				arg_1_1.leftNameTxt_.text = var_4_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_72 = arg_1_1:GetWordFromCfg(417111001)
				local var_4_73 = arg_1_1:FormatText(var_4_72.content)

				arg_1_1.text_.text = var_4_73

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_74 = 10
				local var_4_75 = utf8.len(var_4_73)
				local var_4_76 = var_4_74 <= 0 and var_4_69 or var_4_69 * (var_4_75 / var_4_74)

				if var_4_76 > 0 and var_4_69 < var_4_76 then
					arg_1_1.talkMaxDuration = var_4_76
					var_4_68 = var_4_68 + 0.3

					if var_4_76 + var_4_68 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_76 + var_4_68
					end
				end

				arg_1_1.text_.text = var_4_73
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111001", "story_v_out_417111.awb") ~= 0 then
					local var_4_77 = manager.audio:GetVoiceLength("story_v_out_417111", "417111001", "story_v_out_417111.awb") / 1000

					if var_4_77 + var_4_68 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_77 + var_4_68
					end

					if var_4_72.prefab_name ~= "" and arg_1_1.actors_[var_4_72.prefab_name] ~= nil then
						local var_4_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_72.prefab_name].transform, "story_v_out_417111", "417111001", "story_v_out_417111.awb")

						arg_1_1:RecordAudio("417111001", var_4_78)
						arg_1_1:RecordAudio("417111001", var_4_78)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417111", "417111001", "story_v_out_417111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417111", "417111001", "story_v_out_417111.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_79 = var_4_68 + 0.3
			local var_4_80 = math.max(var_4_69, arg_1_1.talkMaxDuration)

			if var_4_79 <= arg_1_1.time_ and arg_1_1.time_ < var_4_79 + var_4_80 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_79) / var_4_80

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_79 + var_4_80 and arg_1_1.time_ < var_4_79 + var_4_80 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417111002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417111002
		arg_10_1.duration_ = 4

		local var_10_0 = {
			zh = 4,
			ja = 3.766
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
				arg_10_0:Play417111003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "1034"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_13_1) then
					local var_13_2 = Object.Instantiate(var_13_1, arg_10_1.canvasGo_.transform)

					var_13_2.transform:SetSiblingIndex(1)

					var_13_2.name = var_13_0
					var_13_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_10_1.actors_[var_13_0] = var_13_2

					local var_13_3 = var_13_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_10_1.isInRecall_ then
						for iter_13_0, iter_13_1 in ipairs(var_13_3) do
							iter_13_1.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_13_4 = arg_10_1.actors_["1034"]
			local var_13_5 = 0

			if var_13_5 < arg_10_1.time_ and arg_10_1.time_ <= var_13_5 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1034 == nil then
				arg_10_1.var_.actorSpriteComps1034 = var_13_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_6 = 0.2

			if var_13_5 <= arg_10_1.time_ and arg_10_1.time_ < var_13_5 + var_13_6 and not isNil(var_13_4) then
				local var_13_7 = (arg_10_1.time_ - var_13_5) / var_13_6

				if arg_10_1.var_.actorSpriteComps1034 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_13_3 then
							if arg_10_1.isInRecall_ then
								local var_13_8 = Mathf.Lerp(iter_13_3.color.r, arg_10_1.hightColor1.r, var_13_7)
								local var_13_9 = Mathf.Lerp(iter_13_3.color.g, arg_10_1.hightColor1.g, var_13_7)
								local var_13_10 = Mathf.Lerp(iter_13_3.color.b, arg_10_1.hightColor1.b, var_13_7)

								iter_13_3.color = Color.New(var_13_8, var_13_9, var_13_10)
							else
								local var_13_11 = Mathf.Lerp(iter_13_3.color.r, 1, var_13_7)

								iter_13_3.color = Color.New(var_13_11, var_13_11, var_13_11)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= var_13_5 + var_13_6 and arg_10_1.time_ < var_13_5 + var_13_6 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1034 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_13_5 then
						if arg_10_1.isInRecall_ then
							iter_13_5.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_13_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps1034 = nil
			end

			local var_13_12 = arg_10_1.actors_["10072"]
			local var_13_13 = 0

			if var_13_13 < arg_10_1.time_ and arg_10_1.time_ <= var_13_13 + arg_13_0 and not isNil(var_13_12) and arg_10_1.var_.actorSpriteComps10072 == nil then
				arg_10_1.var_.actorSpriteComps10072 = var_13_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_14 = 0.2

			if var_13_13 <= arg_10_1.time_ and arg_10_1.time_ < var_13_13 + var_13_14 and not isNil(var_13_12) then
				local var_13_15 = (arg_10_1.time_ - var_13_13) / var_13_14

				if arg_10_1.var_.actorSpriteComps10072 then
					for iter_13_6, iter_13_7 in pairs(arg_10_1.var_.actorSpriteComps10072:ToTable()) do
						if iter_13_7 then
							if arg_10_1.isInRecall_ then
								local var_13_16 = Mathf.Lerp(iter_13_7.color.r, arg_10_1.hightColor2.r, var_13_15)
								local var_13_17 = Mathf.Lerp(iter_13_7.color.g, arg_10_1.hightColor2.g, var_13_15)
								local var_13_18 = Mathf.Lerp(iter_13_7.color.b, arg_10_1.hightColor2.b, var_13_15)

								iter_13_7.color = Color.New(var_13_16, var_13_17, var_13_18)
							else
								local var_13_19 = Mathf.Lerp(iter_13_7.color.r, 0.5, var_13_15)

								iter_13_7.color = Color.New(var_13_19, var_13_19, var_13_19)
							end
						end
					end
				end
			end

			if arg_10_1.time_ >= var_13_13 + var_13_14 and arg_10_1.time_ < var_13_13 + var_13_14 + arg_13_0 and not isNil(var_13_12) and arg_10_1.var_.actorSpriteComps10072 then
				for iter_13_8, iter_13_9 in pairs(arg_10_1.var_.actorSpriteComps10072:ToTable()) do
					if iter_13_9 then
						if arg_10_1.isInRecall_ then
							iter_13_9.color = arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_13_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps10072 = nil
			end

			local var_13_20 = arg_10_1.actors_["1034"].transform
			local var_13_21 = 0

			if var_13_21 < arg_10_1.time_ and arg_10_1.time_ <= var_13_21 + arg_13_0 then
				arg_10_1.var_.moveOldPos1034 = var_13_20.localPosition
				var_13_20.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1034", 3)

				local var_13_22 = var_13_20.childCount

				for iter_13_10 = 0, var_13_22 - 1 do
					local var_13_23 = var_13_20:GetChild(iter_13_10)

					if var_13_23.name == "" or not string.find(var_13_23.name, "split") then
						var_13_23.gameObject:SetActive(true)
					else
						var_13_23.gameObject:SetActive(false)
					end
				end
			end

			local var_13_24 = 0.001

			if var_13_21 <= arg_10_1.time_ and arg_10_1.time_ < var_13_21 + var_13_24 then
				local var_13_25 = (arg_10_1.time_ - var_13_21) / var_13_24
				local var_13_26 = Vector3.New(0, -331.9, -324)

				var_13_20.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1034, var_13_26, var_13_25)
			end

			if arg_10_1.time_ >= var_13_21 + var_13_24 and arg_10_1.time_ < var_13_21 + var_13_24 + arg_13_0 then
				var_13_20.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_13_27 = 0
			local var_13_28 = 0.475

			if var_13_27 < arg_10_1.time_ and arg_10_1.time_ <= var_13_27 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_29 = arg_10_1:FormatText(StoryNameCfg[1109].name)

				arg_10_1.leftNameTxt_.text = var_13_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_30 = arg_10_1:GetWordFromCfg(417111002)
				local var_13_31 = arg_10_1:FormatText(var_13_30.content)

				arg_10_1.text_.text = var_13_31

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_32 = 19
				local var_13_33 = utf8.len(var_13_31)
				local var_13_34 = var_13_32 <= 0 and var_13_28 or var_13_28 * (var_13_33 / var_13_32)

				if var_13_34 > 0 and var_13_28 < var_13_34 then
					arg_10_1.talkMaxDuration = var_13_34

					if var_13_34 + var_13_27 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_34 + var_13_27
					end
				end

				arg_10_1.text_.text = var_13_31
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111002", "story_v_out_417111.awb") ~= 0 then
					local var_13_35 = manager.audio:GetVoiceLength("story_v_out_417111", "417111002", "story_v_out_417111.awb") / 1000

					if var_13_35 + var_13_27 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_35 + var_13_27
					end

					if var_13_30.prefab_name ~= "" and arg_10_1.actors_[var_13_30.prefab_name] ~= nil then
						local var_13_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_30.prefab_name].transform, "story_v_out_417111", "417111002", "story_v_out_417111.awb")

						arg_10_1:RecordAudio("417111002", var_13_36)
						arg_10_1:RecordAudio("417111002", var_13_36)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_417111", "417111002", "story_v_out_417111.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_417111", "417111002", "story_v_out_417111.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_37 = math.max(var_13_28, arg_10_1.talkMaxDuration)

			if var_13_27 <= arg_10_1.time_ and arg_10_1.time_ < var_13_27 + var_13_37 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_27) / var_13_37

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_27 + var_13_37 and arg_10_1.time_ < var_13_27 + var_13_37 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
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

		arg_10_1:InitPlayNodeList()
	end,
	Play417111003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417111003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417111004(arg_14_1)
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
								local var_17_4 = Mathf.Lerp(iter_17_1.color.r, arg_14_1.hightColor2.r, var_17_3)
								local var_17_5 = Mathf.Lerp(iter_17_1.color.g, arg_14_1.hightColor2.g, var_17_3)
								local var_17_6 = Mathf.Lerp(iter_17_1.color.b, arg_14_1.hightColor2.b, var_17_3)

								iter_17_1.color = Color.New(var_17_4, var_17_5, var_17_6)
							else
								local var_17_7 = Mathf.Lerp(iter_17_1.color.r, 0.5, var_17_3)

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
							iter_17_3.color = arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_17_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_8 = 0
			local var_17_9 = 1.35

			if var_17_8 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_10 = arg_14_1:GetWordFromCfg(417111003)
				local var_17_11 = arg_14_1:FormatText(var_17_10.content)

				arg_14_1.text_.text = var_17_11

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_12 = 54
				local var_17_13 = utf8.len(var_17_11)
				local var_17_14 = var_17_12 <= 0 and var_17_9 or var_17_9 * (var_17_13 / var_17_12)

				if var_17_14 > 0 and var_17_9 < var_17_14 then
					arg_14_1.talkMaxDuration = var_17_14

					if var_17_14 + var_17_8 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_14 + var_17_8
					end
				end

				arg_14_1.text_.text = var_17_11
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_15 = math.max(var_17_9, arg_14_1.talkMaxDuration)

			if var_17_8 <= arg_14_1.time_ and arg_14_1.time_ < var_17_8 + var_17_15 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_8) / var_17_15

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_8 + var_17_15 and arg_14_1.time_ < var_17_8 + var_17_15 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417111004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417111004
		arg_18_1.duration_ = 6.4

		local var_18_0 = {
			zh = 5.633,
			ja = 6.4
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
				arg_18_0:Play417111005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1034"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1034 == nil then
				arg_18_1.var_.actorSpriteComps1034 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps1034 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								local var_21_4 = Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor1.r, var_21_3)
								local var_21_5 = Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor1.g, var_21_3)
								local var_21_6 = Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor1.b, var_21_3)

								iter_21_1.color = Color.New(var_21_4, var_21_5, var_21_6)
							else
								local var_21_7 = Mathf.Lerp(iter_21_1.color.r, 1, var_21_3)

								iter_21_1.color = Color.New(var_21_7, var_21_7, var_21_7)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1034 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_21_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps1034 = nil
			end

			local var_21_8 = 0
			local var_21_9 = 0.7

			if var_21_8 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_10 = arg_18_1:FormatText(StoryNameCfg[1109].name)

				arg_18_1.leftNameTxt_.text = var_21_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_11 = arg_18_1:GetWordFromCfg(417111004)
				local var_21_12 = arg_18_1:FormatText(var_21_11.content)

				arg_18_1.text_.text = var_21_12

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_13 = 28
				local var_21_14 = utf8.len(var_21_12)
				local var_21_15 = var_21_13 <= 0 and var_21_9 or var_21_9 * (var_21_14 / var_21_13)

				if var_21_15 > 0 and var_21_9 < var_21_15 then
					arg_18_1.talkMaxDuration = var_21_15

					if var_21_15 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_15 + var_21_8
					end
				end

				arg_18_1.text_.text = var_21_12
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111004", "story_v_out_417111.awb") ~= 0 then
					local var_21_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111004", "story_v_out_417111.awb") / 1000

					if var_21_16 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_16 + var_21_8
					end

					if var_21_11.prefab_name ~= "" and arg_18_1.actors_[var_21_11.prefab_name] ~= nil then
						local var_21_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_11.prefab_name].transform, "story_v_out_417111", "417111004", "story_v_out_417111.awb")

						arg_18_1:RecordAudio("417111004", var_21_17)
						arg_18_1:RecordAudio("417111004", var_21_17)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417111", "417111004", "story_v_out_417111.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417111", "417111004", "story_v_out_417111.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_18 = math.max(var_21_9, arg_18_1.talkMaxDuration)

			if var_21_8 <= arg_18_1.time_ and arg_18_1.time_ < var_21_8 + var_21_18 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_8) / var_21_18

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_8 + var_21_18 and arg_18_1.time_ < var_21_8 + var_21_18 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417111005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417111005
		arg_22_1.duration_ = 2.2

		local var_22_0 = {
			zh = 2.2,
			ja = 1.733
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
				arg_22_0:Play417111006(arg_22_1)
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
			local var_25_9 = 0.2

			if var_25_8 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_10 = arg_22_1:FormatText(StoryNameCfg[1137].name)

				arg_22_1.leftNameTxt_.text = var_25_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_11 = arg_22_1:GetWordFromCfg(417111005)
				local var_25_12 = arg_22_1:FormatText(var_25_11.content)

				arg_22_1.text_.text = var_25_12

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111005", "story_v_out_417111.awb") ~= 0 then
					local var_25_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111005", "story_v_out_417111.awb") / 1000

					if var_25_16 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_16 + var_25_8
					end

					if var_25_11.prefab_name ~= "" and arg_22_1.actors_[var_25_11.prefab_name] ~= nil then
						local var_25_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_11.prefab_name].transform, "story_v_out_417111", "417111005", "story_v_out_417111.awb")

						arg_22_1:RecordAudio("417111005", var_25_17)
						arg_22_1:RecordAudio("417111005", var_25_17)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417111", "417111005", "story_v_out_417111.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417111", "417111005", "story_v_out_417111.awb")
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
	Play417111006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417111006
		arg_26_1.duration_ = 6.83

		local var_26_0 = {
			zh = 5.666,
			ja = 6.833
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
				arg_26_0:Play417111007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1034"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1034 == nil then
				arg_26_1.var_.actorSpriteComps1034 = var_29_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.actorSpriteComps1034 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_29_1 then
							if arg_26_1.isInRecall_ then
								local var_29_4 = Mathf.Lerp(iter_29_1.color.r, arg_26_1.hightColor1.r, var_29_3)
								local var_29_5 = Mathf.Lerp(iter_29_1.color.g, arg_26_1.hightColor1.g, var_29_3)
								local var_29_6 = Mathf.Lerp(iter_29_1.color.b, arg_26_1.hightColor1.b, var_29_3)

								iter_29_1.color = Color.New(var_29_4, var_29_5, var_29_6)
							else
								local var_29_7 = Mathf.Lerp(iter_29_1.color.r, 1, var_29_3)

								iter_29_1.color = Color.New(var_29_7, var_29_7, var_29_7)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1034 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_29_3 then
						if arg_26_1.isInRecall_ then
							iter_29_3.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1034 = nil
			end

			local var_29_8 = arg_26_1.actors_["1034"].transform
			local var_29_9 = 0

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 then
				arg_26_1.var_.moveOldPos1034 = var_29_8.localPosition
				var_29_8.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1034", 3)

				local var_29_10 = var_29_8.childCount

				for iter_29_4 = 0, var_29_10 - 1 do
					local var_29_11 = var_29_8:GetChild(iter_29_4)

					if var_29_11.name == "" or not string.find(var_29_11.name, "split") then
						var_29_11.gameObject:SetActive(true)
					else
						var_29_11.gameObject:SetActive(false)
					end
				end
			end

			local var_29_12 = 0.001

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_12 then
				local var_29_13 = (arg_26_1.time_ - var_29_9) / var_29_12
				local var_29_14 = Vector3.New(0, -331.9, -324)

				var_29_8.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1034, var_29_14, var_29_13)
			end

			if arg_26_1.time_ >= var_29_9 + var_29_12 and arg_26_1.time_ < var_29_9 + var_29_12 + arg_29_0 then
				var_29_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_29_15 = 0
			local var_29_16 = 0.7

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_17 = arg_26_1:FormatText(StoryNameCfg[1109].name)

				arg_26_1.leftNameTxt_.text = var_29_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_18 = arg_26_1:GetWordFromCfg(417111006)
				local var_29_19 = arg_26_1:FormatText(var_29_18.content)

				arg_26_1.text_.text = var_29_19

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_20 = 28
				local var_29_21 = utf8.len(var_29_19)
				local var_29_22 = var_29_20 <= 0 and var_29_16 or var_29_16 * (var_29_21 / var_29_20)

				if var_29_22 > 0 and var_29_16 < var_29_22 then
					arg_26_1.talkMaxDuration = var_29_22

					if var_29_22 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_22 + var_29_15
					end
				end

				arg_26_1.text_.text = var_29_19
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111006", "story_v_out_417111.awb") ~= 0 then
					local var_29_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111006", "story_v_out_417111.awb") / 1000

					if var_29_23 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_15
					end

					if var_29_18.prefab_name ~= "" and arg_26_1.actors_[var_29_18.prefab_name] ~= nil then
						local var_29_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_18.prefab_name].transform, "story_v_out_417111", "417111006", "story_v_out_417111.awb")

						arg_26_1:RecordAudio("417111006", var_29_24)
						arg_26_1:RecordAudio("417111006", var_29_24)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417111", "417111006", "story_v_out_417111.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417111", "417111006", "story_v_out_417111.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_25 = math.max(var_29_16, arg_26_1.talkMaxDuration)

			if var_29_15 <= arg_26_1.time_ and arg_26_1.time_ < var_29_15 + var_29_25 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_15) / var_29_25

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_15 + var_29_25 and arg_26_1.time_ < var_29_15 + var_29_25 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
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

		arg_26_1:InitPlayNodeList()
	end,
	Play417111007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417111007
		arg_30_1.duration_ = 4.67

		local var_30_0 = {
			zh = 2,
			ja = 4.666
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
				arg_30_0:Play417111008(arg_30_1)
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
								local var_33_4 = Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor2.r, var_33_3)
								local var_33_5 = Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor2.g, var_33_3)
								local var_33_6 = Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor2.b, var_33_3)

								iter_33_1.color = Color.New(var_33_4, var_33_5, var_33_6)
							else
								local var_33_7 = Mathf.Lerp(iter_33_1.color.r, 0.5, var_33_3)

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
							iter_33_3.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1034 = nil
			end

			local var_33_8 = 0
			local var_33_9 = 0.3

			if var_33_8 < arg_30_1.time_ and arg_30_1.time_ <= var_33_8 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_10 = arg_30_1:FormatText(StoryNameCfg[1137].name)

				arg_30_1.leftNameTxt_.text = var_33_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_11 = arg_30_1:GetWordFromCfg(417111007)
				local var_33_12 = arg_30_1:FormatText(var_33_11.content)

				arg_30_1.text_.text = var_33_12

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_13 = 12
				local var_33_14 = utf8.len(var_33_12)
				local var_33_15 = var_33_13 <= 0 and var_33_9 or var_33_9 * (var_33_14 / var_33_13)

				if var_33_15 > 0 and var_33_9 < var_33_15 then
					arg_30_1.talkMaxDuration = var_33_15

					if var_33_15 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_15 + var_33_8
					end
				end

				arg_30_1.text_.text = var_33_12
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111007", "story_v_out_417111.awb") ~= 0 then
					local var_33_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111007", "story_v_out_417111.awb") / 1000

					if var_33_16 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_16 + var_33_8
					end

					if var_33_11.prefab_name ~= "" and arg_30_1.actors_[var_33_11.prefab_name] ~= nil then
						local var_33_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_11.prefab_name].transform, "story_v_out_417111", "417111007", "story_v_out_417111.awb")

						arg_30_1:RecordAudio("417111007", var_33_17)
						arg_30_1:RecordAudio("417111007", var_33_17)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417111", "417111007", "story_v_out_417111.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417111", "417111007", "story_v_out_417111.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_18 = math.max(var_33_9, arg_30_1.talkMaxDuration)

			if var_33_8 <= arg_30_1.time_ and arg_30_1.time_ < var_33_8 + var_33_18 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_8) / var_33_18

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_8 + var_33_18 and arg_30_1.time_ < var_33_8 + var_33_18 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417111008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417111008
		arg_34_1.duration_ = 8.5

		local var_34_0 = {
			zh = 7,
			ja = 8.5
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
				arg_34_0:Play417111009(arg_34_1)
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

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_37_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_8 = 0
			local var_37_9 = 0.825

			if var_37_8 < arg_34_1.time_ and arg_34_1.time_ <= var_37_8 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_10 = arg_34_1:FormatText(StoryNameCfg[1109].name)

				arg_34_1.leftNameTxt_.text = var_37_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_11 = arg_34_1:GetWordFromCfg(417111008)
				local var_37_12 = arg_34_1:FormatText(var_37_11.content)

				arg_34_1.text_.text = var_37_12

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_13 = 33
				local var_37_14 = utf8.len(var_37_12)
				local var_37_15 = var_37_13 <= 0 and var_37_9 or var_37_9 * (var_37_14 / var_37_13)

				if var_37_15 > 0 and var_37_9 < var_37_15 then
					arg_34_1.talkMaxDuration = var_37_15

					if var_37_15 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_15 + var_37_8
					end
				end

				arg_34_1.text_.text = var_37_12
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111008", "story_v_out_417111.awb") ~= 0 then
					local var_37_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111008", "story_v_out_417111.awb") / 1000

					if var_37_16 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_16 + var_37_8
					end

					if var_37_11.prefab_name ~= "" and arg_34_1.actors_[var_37_11.prefab_name] ~= nil then
						local var_37_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_11.prefab_name].transform, "story_v_out_417111", "417111008", "story_v_out_417111.awb")

						arg_34_1:RecordAudio("417111008", var_37_17)
						arg_34_1:RecordAudio("417111008", var_37_17)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417111", "417111008", "story_v_out_417111.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417111", "417111008", "story_v_out_417111.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_18 = math.max(var_37_9, arg_34_1.talkMaxDuration)

			if var_37_8 <= arg_34_1.time_ and arg_34_1.time_ < var_37_8 + var_37_18 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_8) / var_37_18

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_8 + var_37_18 and arg_34_1.time_ < var_37_8 + var_37_18 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417111009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417111009
		arg_38_1.duration_ = 9.63

		local var_38_0 = {
			zh = 9.633,
			ja = 8.4
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
				arg_38_0:Play417111010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1034"].transform
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.var_.moveOldPos1034 = var_41_0.localPosition
				var_41_0.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1034", 3)

				local var_41_2 = var_41_0.childCount

				for iter_41_0 = 0, var_41_2 - 1 do
					local var_41_3 = var_41_0:GetChild(iter_41_0)

					if var_41_3.name == "split_6" or not string.find(var_41_3.name, "split") then
						var_41_3.gameObject:SetActive(true)
					else
						var_41_3.gameObject:SetActive(false)
					end
				end
			end

			local var_41_4 = 0.001

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_4 then
				local var_41_5 = (arg_38_1.time_ - var_41_1) / var_41_4
				local var_41_6 = Vector3.New(0, -331.9, -324)

				var_41_0.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1034, var_41_6, var_41_5)
			end

			if arg_38_1.time_ >= var_41_1 + var_41_4 and arg_38_1.time_ < var_41_1 + var_41_4 + arg_41_0 then
				var_41_0.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_41_7 = 0
			local var_41_8 = 1.175

			if var_41_7 < arg_38_1.time_ and arg_38_1.time_ <= var_41_7 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_9 = arg_38_1:FormatText(StoryNameCfg[1109].name)

				arg_38_1.leftNameTxt_.text = var_41_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_10 = arg_38_1:GetWordFromCfg(417111009)
				local var_41_11 = arg_38_1:FormatText(var_41_10.content)

				arg_38_1.text_.text = var_41_11

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_12 = 47
				local var_41_13 = utf8.len(var_41_11)
				local var_41_14 = var_41_12 <= 0 and var_41_8 or var_41_8 * (var_41_13 / var_41_12)

				if var_41_14 > 0 and var_41_8 < var_41_14 then
					arg_38_1.talkMaxDuration = var_41_14

					if var_41_14 + var_41_7 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_14 + var_41_7
					end
				end

				arg_38_1.text_.text = var_41_11
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111009", "story_v_out_417111.awb") ~= 0 then
					local var_41_15 = manager.audio:GetVoiceLength("story_v_out_417111", "417111009", "story_v_out_417111.awb") / 1000

					if var_41_15 + var_41_7 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_7
					end

					if var_41_10.prefab_name ~= "" and arg_38_1.actors_[var_41_10.prefab_name] ~= nil then
						local var_41_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_10.prefab_name].transform, "story_v_out_417111", "417111009", "story_v_out_417111.awb")

						arg_38_1:RecordAudio("417111009", var_41_16)
						arg_38_1:RecordAudio("417111009", var_41_16)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417111", "417111009", "story_v_out_417111.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417111", "417111009", "story_v_out_417111.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_17 = math.max(var_41_8, arg_38_1.talkMaxDuration)

			if var_41_7 <= arg_38_1.time_ and arg_38_1.time_ < var_41_7 + var_41_17 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_7) / var_41_17

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_7 + var_41_17 and arg_38_1.time_ < var_41_7 + var_41_17 + arg_41_0 then
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
	Play417111010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417111010
		arg_42_1.duration_ = 5.3

		local var_42_0 = {
			zh = 5.3,
			ja = 3.566
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
				arg_42_0:Play417111011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1034"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								local var_45_4 = Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor2.r, var_45_3)
								local var_45_5 = Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor2.g, var_45_3)
								local var_45_6 = Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor2.b, var_45_3)

								iter_45_1.color = Color.New(var_45_4, var_45_5, var_45_6)
							else
								local var_45_7 = Mathf.Lerp(iter_45_1.color.r, 0.5, var_45_3)

								iter_45_1.color = Color.New(var_45_7, var_45_7, var_45_7)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_8 = 0
			local var_45_9 = 0.775

			if var_45_8 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_10 = arg_42_1:FormatText(StoryNameCfg[1137].name)

				arg_42_1.leftNameTxt_.text = var_45_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_11 = arg_42_1:GetWordFromCfg(417111010)
				local var_45_12 = arg_42_1:FormatText(var_45_11.content)

				arg_42_1.text_.text = var_45_12

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 31
				local var_45_14 = utf8.len(var_45_12)
				local var_45_15 = var_45_13 <= 0 and var_45_9 or var_45_9 * (var_45_14 / var_45_13)

				if var_45_15 > 0 and var_45_9 < var_45_15 then
					arg_42_1.talkMaxDuration = var_45_15

					if var_45_15 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_8
					end
				end

				arg_42_1.text_.text = var_45_12
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111010", "story_v_out_417111.awb") ~= 0 then
					local var_45_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111010", "story_v_out_417111.awb") / 1000

					if var_45_16 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_16 + var_45_8
					end

					if var_45_11.prefab_name ~= "" and arg_42_1.actors_[var_45_11.prefab_name] ~= nil then
						local var_45_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_11.prefab_name].transform, "story_v_out_417111", "417111010", "story_v_out_417111.awb")

						arg_42_1:RecordAudio("417111010", var_45_17)
						arg_42_1:RecordAudio("417111010", var_45_17)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417111", "417111010", "story_v_out_417111.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417111", "417111010", "story_v_out_417111.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_18 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_18 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_8) / var_45_18

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_8 + var_45_18 and arg_42_1.time_ < var_45_8 + var_45_18 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417111011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417111011
		arg_46_1.duration_ = 6.3

		local var_46_0 = {
			zh = 5.166,
			ja = 6.3
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
				arg_46_0:Play417111012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.675

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[1137].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_3 = arg_46_1:GetWordFromCfg(417111011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111011", "story_v_out_417111.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111011", "story_v_out_417111.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_417111", "417111011", "story_v_out_417111.awb")

						arg_46_1:RecordAudio("417111011", var_49_9)
						arg_46_1:RecordAudio("417111011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417111", "417111011", "story_v_out_417111.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417111", "417111011", "story_v_out_417111.awb")
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
	Play417111012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417111012
		arg_50_1.duration_ = 4.03

		local var_50_0 = {
			zh = 3.466,
			ja = 4.033
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
				arg_50_0:Play417111013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1034"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps1034 == nil then
				arg_50_1.var_.actorSpriteComps1034 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps1034 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps1034 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_53_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps1034 = nil
			end

			local var_53_8 = arg_50_1.actors_["1034"].transform
			local var_53_9 = 0

			if var_53_9 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 then
				arg_50_1.var_.moveOldPos1034 = var_53_8.localPosition
				var_53_8.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1034", 3)

				local var_53_10 = var_53_8.childCount

				for iter_53_4 = 0, var_53_10 - 1 do
					local var_53_11 = var_53_8:GetChild(iter_53_4)

					if var_53_11.name == "" or not string.find(var_53_11.name, "split") then
						var_53_11.gameObject:SetActive(true)
					else
						var_53_11.gameObject:SetActive(false)
					end
				end
			end

			local var_53_12 = 0.001

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_12 then
				local var_53_13 = (arg_50_1.time_ - var_53_9) / var_53_12
				local var_53_14 = Vector3.New(0, -331.9, -324)

				var_53_8.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1034, var_53_14, var_53_13)
			end

			if arg_50_1.time_ >= var_53_9 + var_53_12 and arg_50_1.time_ < var_53_9 + var_53_12 + arg_53_0 then
				var_53_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_53_15 = 0
			local var_53_16 = 0.275

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_17 = arg_50_1:FormatText(StoryNameCfg[1109].name)

				arg_50_1.leftNameTxt_.text = var_53_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_18 = arg_50_1:GetWordFromCfg(417111012)
				local var_53_19 = arg_50_1:FormatText(var_53_18.content)

				arg_50_1.text_.text = var_53_19

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_20 = 11
				local var_53_21 = utf8.len(var_53_19)
				local var_53_22 = var_53_20 <= 0 and var_53_16 or var_53_16 * (var_53_21 / var_53_20)

				if var_53_22 > 0 and var_53_16 < var_53_22 then
					arg_50_1.talkMaxDuration = var_53_22

					if var_53_22 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_22 + var_53_15
					end
				end

				arg_50_1.text_.text = var_53_19
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111012", "story_v_out_417111.awb") ~= 0 then
					local var_53_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111012", "story_v_out_417111.awb") / 1000

					if var_53_23 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_15
					end

					if var_53_18.prefab_name ~= "" and arg_50_1.actors_[var_53_18.prefab_name] ~= nil then
						local var_53_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_18.prefab_name].transform, "story_v_out_417111", "417111012", "story_v_out_417111.awb")

						arg_50_1:RecordAudio("417111012", var_53_24)
						arg_50_1:RecordAudio("417111012", var_53_24)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417111", "417111012", "story_v_out_417111.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417111", "417111012", "story_v_out_417111.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_25 = math.max(var_53_16, arg_50_1.talkMaxDuration)

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_25 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_15) / var_53_25

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_15 + var_53_25 and arg_50_1.time_ < var_53_15 + var_53_25 + arg_53_0 then
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
	Play417111013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417111013
		arg_54_1.duration_ = 2.57

		local var_54_0 = {
			zh = 2.566,
			ja = 1.633
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
				arg_54_0:Play417111014(arg_54_1)
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
								local var_57_4 = Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor2.r, var_57_3)
								local var_57_5 = Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor2.g, var_57_3)
								local var_57_6 = Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor2.b, var_57_3)

								iter_57_1.color = Color.New(var_57_4, var_57_5, var_57_6)
							else
								local var_57_7 = Mathf.Lerp(iter_57_1.color.r, 0.5, var_57_3)

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
							iter_57_3.color = arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_57_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1034 = nil
			end

			local var_57_8 = 0
			local var_57_9 = 0.225

			if var_57_8 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_10 = arg_54_1:FormatText(StoryNameCfg[1137].name)

				arg_54_1.leftNameTxt_.text = var_57_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_11 = arg_54_1:GetWordFromCfg(417111013)
				local var_57_12 = arg_54_1:FormatText(var_57_11.content)

				arg_54_1.text_.text = var_57_12

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_13 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111013", "story_v_out_417111.awb") ~= 0 then
					local var_57_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111013", "story_v_out_417111.awb") / 1000

					if var_57_16 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_16 + var_57_8
					end

					if var_57_11.prefab_name ~= "" and arg_54_1.actors_[var_57_11.prefab_name] ~= nil then
						local var_57_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_11.prefab_name].transform, "story_v_out_417111", "417111013", "story_v_out_417111.awb")

						arg_54_1:RecordAudio("417111013", var_57_17)
						arg_54_1:RecordAudio("417111013", var_57_17)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417111", "417111013", "story_v_out_417111.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417111", "417111013", "story_v_out_417111.awb")
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
	Play417111014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417111014
		arg_58_1.duration_ = 13.67

		local var_58_0 = {
			zh = 7.666,
			ja = 13.666
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
				arg_58_0:Play417111015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[1137].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:GetWordFromCfg(417111014)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111014", "story_v_out_417111.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111014", "story_v_out_417111.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_417111", "417111014", "story_v_out_417111.awb")

						arg_58_1:RecordAudio("417111014", var_61_9)
						arg_58_1:RecordAudio("417111014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417111", "417111014", "story_v_out_417111.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417111", "417111014", "story_v_out_417111.awb")
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
	Play417111015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417111015
		arg_62_1.duration_ = 2.6

		local var_62_0 = {
			zh = 1.366,
			ja = 2.6
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
				arg_62_0:Play417111016(arg_62_1)
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

			local var_65_8 = arg_62_1.actors_["1034"].transform
			local var_65_9 = 0

			if var_65_9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 then
				arg_62_1.var_.moveOldPos1034 = var_65_8.localPosition
				var_65_8.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1034", 3)

				local var_65_10 = var_65_8.childCount

				for iter_65_4 = 0, var_65_10 - 1 do
					local var_65_11 = var_65_8:GetChild(iter_65_4)

					if var_65_11.name == "split_5" or not string.find(var_65_11.name, "split") then
						var_65_11.gameObject:SetActive(true)
					else
						var_65_11.gameObject:SetActive(false)
					end
				end
			end

			local var_65_12 = 0.001

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_12 then
				local var_65_13 = (arg_62_1.time_ - var_65_9) / var_65_12
				local var_65_14 = Vector3.New(0, -331.9, -324)

				var_65_8.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1034, var_65_14, var_65_13)
			end

			if arg_62_1.time_ >= var_65_9 + var_65_12 and arg_62_1.time_ < var_65_9 + var_65_12 + arg_65_0 then
				var_65_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_65_15 = 0
			local var_65_16 = 0.1

			if var_65_15 < arg_62_1.time_ and arg_62_1.time_ <= var_65_15 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_17 = arg_62_1:FormatText(StoryNameCfg[1109].name)

				arg_62_1.leftNameTxt_.text = var_65_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_18 = arg_62_1:GetWordFromCfg(417111015)
				local var_65_19 = arg_62_1:FormatText(var_65_18.content)

				arg_62_1.text_.text = var_65_19

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_20 = 4
				local var_65_21 = utf8.len(var_65_19)
				local var_65_22 = var_65_20 <= 0 and var_65_16 or var_65_16 * (var_65_21 / var_65_20)

				if var_65_22 > 0 and var_65_16 < var_65_22 then
					arg_62_1.talkMaxDuration = var_65_22

					if var_65_22 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_22 + var_65_15
					end
				end

				arg_62_1.text_.text = var_65_19
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111015", "story_v_out_417111.awb") ~= 0 then
					local var_65_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111015", "story_v_out_417111.awb") / 1000

					if var_65_23 + var_65_15 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_23 + var_65_15
					end

					if var_65_18.prefab_name ~= "" and arg_62_1.actors_[var_65_18.prefab_name] ~= nil then
						local var_65_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_18.prefab_name].transform, "story_v_out_417111", "417111015", "story_v_out_417111.awb")

						arg_62_1:RecordAudio("417111015", var_65_24)
						arg_62_1:RecordAudio("417111015", var_65_24)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_417111", "417111015", "story_v_out_417111.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_417111", "417111015", "story_v_out_417111.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_25 = math.max(var_65_16, arg_62_1.talkMaxDuration)

			if var_65_15 <= arg_62_1.time_ and arg_62_1.time_ < var_65_15 + var_65_25 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_15) / var_65_25

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_15 + var_65_25 and arg_62_1.time_ < var_65_15 + var_65_25 + arg_65_0 then
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
	Play417111016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417111016
		arg_66_1.duration_ = 12.9

		local var_66_0 = {
			zh = 8.9,
			ja = 12.9
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
				arg_66_0:Play417111017(arg_66_1)
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

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1034 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1034 = nil
			end

			local var_69_8 = 0
			local var_69_9 = 1.225

			if var_69_8 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_10 = arg_66_1:FormatText(StoryNameCfg[1137].name)

				arg_66_1.leftNameTxt_.text = var_69_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_11 = arg_66_1:GetWordFromCfg(417111016)
				local var_69_12 = arg_66_1:FormatText(var_69_11.content)

				arg_66_1.text_.text = var_69_12

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_13 = 49
				local var_69_14 = utf8.len(var_69_12)
				local var_69_15 = var_69_13 <= 0 and var_69_9 or var_69_9 * (var_69_14 / var_69_13)

				if var_69_15 > 0 and var_69_9 < var_69_15 then
					arg_66_1.talkMaxDuration = var_69_15

					if var_69_15 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_15 + var_69_8
					end
				end

				arg_66_1.text_.text = var_69_12
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111016", "story_v_out_417111.awb") ~= 0 then
					local var_69_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111016", "story_v_out_417111.awb") / 1000

					if var_69_16 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_8
					end

					if var_69_11.prefab_name ~= "" and arg_66_1.actors_[var_69_11.prefab_name] ~= nil then
						local var_69_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_11.prefab_name].transform, "story_v_out_417111", "417111016", "story_v_out_417111.awb")

						arg_66_1:RecordAudio("417111016", var_69_17)
						arg_66_1:RecordAudio("417111016", var_69_17)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417111", "417111016", "story_v_out_417111.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417111", "417111016", "story_v_out_417111.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_18 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_18 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_18

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_18 and arg_66_1.time_ < var_69_8 + var_69_18 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417111017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417111017
		arg_70_1.duration_ = 9.33

		local var_70_0 = {
			zh = 9.333,
			ja = 8.233
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
				arg_70_0:Play417111018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1.275

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[1137].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:GetWordFromCfg(417111017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 51
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111017", "story_v_out_417111.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111017", "story_v_out_417111.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_417111", "417111017", "story_v_out_417111.awb")

						arg_70_1:RecordAudio("417111017", var_73_9)
						arg_70_1:RecordAudio("417111017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417111", "417111017", "story_v_out_417111.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417111", "417111017", "story_v_out_417111.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417111018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417111018
		arg_74_1.duration_ = 4.67

		local var_74_0 = {
			zh = 1.733,
			ja = 4.666
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
				arg_74_0:Play417111019(arg_74_1)
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

				arg_74_1:CheckSpriteTmpPos("1034", 3)

				local var_77_10 = var_77_8.childCount

				for iter_77_4 = 0, var_77_10 - 1 do
					local var_77_11 = var_77_8:GetChild(iter_77_4)

					if var_77_11.name == "split_6" or not string.find(var_77_11.name, "split") then
						var_77_11.gameObject:SetActive(true)
					else
						var_77_11.gameObject:SetActive(false)
					end
				end
			end

			local var_77_12 = 0.001

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_12 then
				local var_77_13 = (arg_74_1.time_ - var_77_9) / var_77_12
				local var_77_14 = Vector3.New(0, -331.9, -324)

				var_77_8.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1034, var_77_14, var_77_13)
			end

			if arg_74_1.time_ >= var_77_9 + var_77_12 and arg_74_1.time_ < var_77_9 + var_77_12 + arg_77_0 then
				var_77_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_77_15 = 0
			local var_77_16 = 0.225

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

				local var_77_18 = arg_74_1:GetWordFromCfg(417111018)
				local var_77_19 = arg_74_1:FormatText(var_77_18.content)

				arg_74_1.text_.text = var_77_19

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_20 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111018", "story_v_out_417111.awb") ~= 0 then
					local var_77_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111018", "story_v_out_417111.awb") / 1000

					if var_77_23 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_15
					end

					if var_77_18.prefab_name ~= "" and arg_74_1.actors_[var_77_18.prefab_name] ~= nil then
						local var_77_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_18.prefab_name].transform, "story_v_out_417111", "417111018", "story_v_out_417111.awb")

						arg_74_1:RecordAudio("417111018", var_77_24)
						arg_74_1:RecordAudio("417111018", var_77_24)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_417111", "417111018", "story_v_out_417111.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_417111", "417111018", "story_v_out_417111.awb")
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
	Play417111019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417111019
		arg_78_1.duration_ = 1.3

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417111020(arg_78_1)
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
								local var_81_4 = Mathf.Lerp(iter_81_1.color.r, arg_78_1.hightColor2.r, var_81_3)
								local var_81_5 = Mathf.Lerp(iter_81_1.color.g, arg_78_1.hightColor2.g, var_81_3)
								local var_81_6 = Mathf.Lerp(iter_81_1.color.b, arg_78_1.hightColor2.b, var_81_3)

								iter_81_1.color = Color.New(var_81_4, var_81_5, var_81_6)
							else
								local var_81_7 = Mathf.Lerp(iter_81_1.color.r, 0.5, var_81_3)

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
							iter_81_3.color = arg_78_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_81_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps1034 = nil
			end

			local var_81_8 = 0
			local var_81_9 = 0.125

			if var_81_8 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_10 = arg_78_1:FormatText(StoryNameCfg[1137].name)

				arg_78_1.leftNameTxt_.text = var_81_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_11 = arg_78_1:GetWordFromCfg(417111019)
				local var_81_12 = arg_78_1:FormatText(var_81_11.content)

				arg_78_1.text_.text = var_81_12

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 5
				local var_81_14 = utf8.len(var_81_12)
				local var_81_15 = var_81_13 <= 0 and var_81_9 or var_81_9 * (var_81_14 / var_81_13)

				if var_81_15 > 0 and var_81_9 < var_81_15 then
					arg_78_1.talkMaxDuration = var_81_15

					if var_81_15 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_15 + var_81_8
					end
				end

				arg_78_1.text_.text = var_81_12
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111019", "story_v_out_417111.awb") ~= 0 then
					local var_81_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111019", "story_v_out_417111.awb") / 1000

					if var_81_16 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_16 + var_81_8
					end

					if var_81_11.prefab_name ~= "" and arg_78_1.actors_[var_81_11.prefab_name] ~= nil then
						local var_81_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_11.prefab_name].transform, "story_v_out_417111", "417111019", "story_v_out_417111.awb")

						arg_78_1:RecordAudio("417111019", var_81_17)
						arg_78_1:RecordAudio("417111019", var_81_17)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_417111", "417111019", "story_v_out_417111.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_417111", "417111019", "story_v_out_417111.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_18 = math.max(var_81_9, arg_78_1.talkMaxDuration)

			if var_81_8 <= arg_78_1.time_ and arg_78_1.time_ < var_81_8 + var_81_18 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_8) / var_81_18

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_8 + var_81_18 and arg_78_1.time_ < var_81_8 + var_81_18 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417111020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417111020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play417111021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 1.15

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(417111020)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 46
				local var_85_5 = utf8.len(var_85_3)
				local var_85_6 = var_85_4 <= 0 and var_85_1 or var_85_1 * (var_85_5 / var_85_4)

				if var_85_6 > 0 and var_85_1 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_7 and arg_82_1.time_ < var_85_0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play417111021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417111021
		arg_86_1.duration_ = 4.63

		local var_86_0 = {
			zh = 4.633,
			ja = 3
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
				arg_86_0:Play417111022(arg_86_1)
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
			local var_89_9 = 0.375

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

				local var_89_11 = arg_86_1:GetWordFromCfg(417111021)
				local var_89_12 = arg_86_1:FormatText(var_89_11.content)

				arg_86_1.text_.text = var_89_12

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111021", "story_v_out_417111.awb") ~= 0 then
					local var_89_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111021", "story_v_out_417111.awb") / 1000

					if var_89_16 + var_89_8 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_8
					end

					if var_89_11.prefab_name ~= "" and arg_86_1.actors_[var_89_11.prefab_name] ~= nil then
						local var_89_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_11.prefab_name].transform, "story_v_out_417111", "417111021", "story_v_out_417111.awb")

						arg_86_1:RecordAudio("417111021", var_89_17)
						arg_86_1:RecordAudio("417111021", var_89_17)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417111", "417111021", "story_v_out_417111.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417111", "417111021", "story_v_out_417111.awb")
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
	Play417111022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417111022
		arg_90_1.duration_ = 1.37

		local var_90_0 = {
			zh = 1.366,
			ja = 1.3
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
				arg_90_0:Play417111023(arg_90_1)
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
			local var_93_9 = 0.175

			if var_93_8 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_10 = arg_90_1:FormatText(StoryNameCfg[1137].name)

				arg_90_1.leftNameTxt_.text = var_93_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_11 = arg_90_1:GetWordFromCfg(417111022)
				local var_93_12 = arg_90_1:FormatText(var_93_11.content)

				arg_90_1.text_.text = var_93_12

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111022", "story_v_out_417111.awb") ~= 0 then
					local var_93_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111022", "story_v_out_417111.awb") / 1000

					if var_93_16 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_16 + var_93_8
					end

					if var_93_11.prefab_name ~= "" and arg_90_1.actors_[var_93_11.prefab_name] ~= nil then
						local var_93_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_11.prefab_name].transform, "story_v_out_417111", "417111022", "story_v_out_417111.awb")

						arg_90_1:RecordAudio("417111022", var_93_17)
						arg_90_1:RecordAudio("417111022", var_93_17)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417111", "417111022", "story_v_out_417111.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417111", "417111022", "story_v_out_417111.awb")
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
	Play417111023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417111023
		arg_94_1.duration_ = 11.87

		local var_94_0 = {
			zh = 9.9,
			ja = 11.866
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
				arg_94_0:Play417111024(arg_94_1)
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

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps1034 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_97_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps1034 = nil
			end

			local var_97_8 = arg_94_1.actors_["1034"].transform
			local var_97_9 = 0

			if var_97_9 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.var_.moveOldPos1034 = var_97_8.localPosition
				var_97_8.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("1034", 3)

				local var_97_10 = var_97_8.childCount

				for iter_97_4 = 0, var_97_10 - 1 do
					local var_97_11 = var_97_8:GetChild(iter_97_4)

					if var_97_11.name == "split_6" or not string.find(var_97_11.name, "split") then
						var_97_11.gameObject:SetActive(true)
					else
						var_97_11.gameObject:SetActive(false)
					end
				end
			end

			local var_97_12 = 0.001

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_12 then
				local var_97_13 = (arg_94_1.time_ - var_97_9) / var_97_12
				local var_97_14 = Vector3.New(0, -331.9, -324)

				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1034, var_97_14, var_97_13)
			end

			if arg_94_1.time_ >= var_97_9 + var_97_12 and arg_94_1.time_ < var_97_9 + var_97_12 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_97_15 = 0
			local var_97_16 = 1.075

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_17 = arg_94_1:FormatText(StoryNameCfg[1109].name)

				arg_94_1.leftNameTxt_.text = var_97_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_18 = arg_94_1:GetWordFromCfg(417111023)
				local var_97_19 = arg_94_1:FormatText(var_97_18.content)

				arg_94_1.text_.text = var_97_19

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_20 = 43
				local var_97_21 = utf8.len(var_97_19)
				local var_97_22 = var_97_20 <= 0 and var_97_16 or var_97_16 * (var_97_21 / var_97_20)

				if var_97_22 > 0 and var_97_16 < var_97_22 then
					arg_94_1.talkMaxDuration = var_97_22

					if var_97_22 + var_97_15 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_22 + var_97_15
					end
				end

				arg_94_1.text_.text = var_97_19
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111023", "story_v_out_417111.awb") ~= 0 then
					local var_97_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111023", "story_v_out_417111.awb") / 1000

					if var_97_23 + var_97_15 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_23 + var_97_15
					end

					if var_97_18.prefab_name ~= "" and arg_94_1.actors_[var_97_18.prefab_name] ~= nil then
						local var_97_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_18.prefab_name].transform, "story_v_out_417111", "417111023", "story_v_out_417111.awb")

						arg_94_1:RecordAudio("417111023", var_97_24)
						arg_94_1:RecordAudio("417111023", var_97_24)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417111", "417111023", "story_v_out_417111.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417111", "417111023", "story_v_out_417111.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_25 = math.max(var_97_16, arg_94_1.talkMaxDuration)

			if var_97_15 <= arg_94_1.time_ and arg_94_1.time_ < var_97_15 + var_97_25 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_15) / var_97_25

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_15 + var_97_25 and arg_94_1.time_ < var_97_15 + var_97_25 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play417111024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 417111024
		arg_98_1.duration_ = 5.33

		local var_98_0 = {
			zh = 3.833,
			ja = 5.333
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
				arg_98_0:Play417111025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0
			local var_101_1 = 0.4

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_2 = arg_98_1:FormatText(StoryNameCfg[1109].name)

				arg_98_1.leftNameTxt_.text = var_101_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(417111024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 16
				local var_101_6 = utf8.len(var_101_4)
				local var_101_7 = var_101_5 <= 0 and var_101_1 or var_101_1 * (var_101_6 / var_101_5)

				if var_101_7 > 0 and var_101_1 < var_101_7 then
					arg_98_1.talkMaxDuration = var_101_7

					if var_101_7 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111024", "story_v_out_417111.awb") ~= 0 then
					local var_101_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111024", "story_v_out_417111.awb") / 1000

					if var_101_8 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_0
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_417111", "417111024", "story_v_out_417111.awb")

						arg_98_1:RecordAudio("417111024", var_101_9)
						arg_98_1:RecordAudio("417111024", var_101_9)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_417111", "417111024", "story_v_out_417111.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_417111", "417111024", "story_v_out_417111.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_10 and arg_98_1.time_ < var_101_0 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play417111025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 417111025
		arg_102_1.duration_ = 5

		local var_102_0 = {
			zh = 3.833,
			ja = 5
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
				arg_102_0:Play417111026(arg_102_1)
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
			local var_105_9 = 0.5

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_10 = arg_102_1:FormatText(StoryNameCfg[1137].name)

				arg_102_1.leftNameTxt_.text = var_105_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_11 = arg_102_1:GetWordFromCfg(417111025)
				local var_105_12 = arg_102_1:FormatText(var_105_11.content)

				arg_102_1.text_.text = var_105_12

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111025", "story_v_out_417111.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111025", "story_v_out_417111.awb") / 1000

					if var_105_16 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_8
					end

					if var_105_11.prefab_name ~= "" and arg_102_1.actors_[var_105_11.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_11.prefab_name].transform, "story_v_out_417111", "417111025", "story_v_out_417111.awb")

						arg_102_1:RecordAudio("417111025", var_105_17)
						arg_102_1:RecordAudio("417111025", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_417111", "417111025", "story_v_out_417111.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_417111", "417111025", "story_v_out_417111.awb")
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
	Play417111026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 417111026
		arg_106_1.duration_ = 6.87

		local var_106_0 = {
			zh = 2,
			ja = 6.866
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
				arg_106_0:Play417111027(arg_106_1)
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

			local var_109_8 = 0
			local var_109_9 = 0.25

			if var_109_8 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_10 = arg_106_1:FormatText(StoryNameCfg[1109].name)

				arg_106_1.leftNameTxt_.text = var_109_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_11 = arg_106_1:GetWordFromCfg(417111026)
				local var_109_12 = arg_106_1:FormatText(var_109_11.content)

				arg_106_1.text_.text = var_109_12

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 10
				local var_109_14 = utf8.len(var_109_12)
				local var_109_15 = var_109_13 <= 0 and var_109_9 or var_109_9 * (var_109_14 / var_109_13)

				if var_109_15 > 0 and var_109_9 < var_109_15 then
					arg_106_1.talkMaxDuration = var_109_15

					if var_109_15 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_15 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_12
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111026", "story_v_out_417111.awb") ~= 0 then
					local var_109_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111026", "story_v_out_417111.awb") / 1000

					if var_109_16 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_16 + var_109_8
					end

					if var_109_11.prefab_name ~= "" and arg_106_1.actors_[var_109_11.prefab_name] ~= nil then
						local var_109_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_11.prefab_name].transform, "story_v_out_417111", "417111026", "story_v_out_417111.awb")

						arg_106_1:RecordAudio("417111026", var_109_17)
						arg_106_1:RecordAudio("417111026", var_109_17)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_417111", "417111026", "story_v_out_417111.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_417111", "417111026", "story_v_out_417111.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_18 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_18 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_18

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_18 and arg_106_1.time_ < var_109_8 + var_109_18 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play417111027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 417111027
		arg_110_1.duration_ = 12.57

		local var_110_0 = {
			zh = 11.433,
			ja = 12.566
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
				arg_110_0:Play417111028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0
			local var_113_1 = 1.55

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_2 = arg_110_1:FormatText(StoryNameCfg[1109].name)

				arg_110_1.leftNameTxt_.text = var_113_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(417111027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 62
				local var_113_6 = utf8.len(var_113_4)
				local var_113_7 = var_113_5 <= 0 and var_113_1 or var_113_1 * (var_113_6 / var_113_5)

				if var_113_7 > 0 and var_113_1 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111027", "story_v_out_417111.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111027", "story_v_out_417111.awb") / 1000

					if var_113_8 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_0
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_417111", "417111027", "story_v_out_417111.awb")

						arg_110_1:RecordAudio("417111027", var_113_9)
						arg_110_1:RecordAudio("417111027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_417111", "417111027", "story_v_out_417111.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_417111", "417111027", "story_v_out_417111.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_10 and arg_110_1.time_ < var_113_0 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play417111028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 417111028
		arg_114_1.duration_ = 12.17

		local var_114_0 = {
			zh = 10.1,
			ja = 12.166
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
				arg_114_0:Play417111029(arg_114_1)
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

				local var_117_2 = arg_114_1:FormatText(StoryNameCfg[1109].name)

				arg_114_1.leftNameTxt_.text = var_117_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_3 = arg_114_1:GetWordFromCfg(417111028)
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111028", "story_v_out_417111.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111028", "story_v_out_417111.awb") / 1000

					if var_117_8 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_0
					end

					if var_117_3.prefab_name ~= "" and arg_114_1.actors_[var_117_3.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_3.prefab_name].transform, "story_v_out_417111", "417111028", "story_v_out_417111.awb")

						arg_114_1:RecordAudio("417111028", var_117_9)
						arg_114_1:RecordAudio("417111028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_417111", "417111028", "story_v_out_417111.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_417111", "417111028", "story_v_out_417111.awb")
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
	Play417111029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 417111029
		arg_118_1.duration_ = 3.7

		local var_118_0 = {
			zh = 3.166,
			ja = 3.7
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
				arg_118_0:Play417111030(arg_118_1)
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
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor2.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor2.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor2.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 0.5, var_121_3)

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
							iter_121_3.color = arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_121_3.color = Color.New(0.5, 0.5, 0.5)
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

				local var_121_10 = arg_118_1:FormatText(StoryNameCfg[1137].name)

				arg_118_1.leftNameTxt_.text = var_121_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_11 = arg_118_1:GetWordFromCfg(417111029)
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111029", "story_v_out_417111.awb") ~= 0 then
					local var_121_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111029", "story_v_out_417111.awb") / 1000

					if var_121_16 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_16 + var_121_8
					end

					if var_121_11.prefab_name ~= "" and arg_118_1.actors_[var_121_11.prefab_name] ~= nil then
						local var_121_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_11.prefab_name].transform, "story_v_out_417111", "417111029", "story_v_out_417111.awb")

						arg_118_1:RecordAudio("417111029", var_121_17)
						arg_118_1:RecordAudio("417111029", var_121_17)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_417111", "417111029", "story_v_out_417111.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_417111", "417111029", "story_v_out_417111.awb")
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
	Play417111030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417111030
		arg_122_1.duration_ = 13.37

		local var_122_0 = {
			zh = 13.366,
			ja = 11.7
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
				arg_122_0:Play417111031(arg_122_1)
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
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor1.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor1.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor1.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 1, var_125_3)

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
							iter_125_3.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_125_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps1034 = nil
			end

			local var_125_8 = 0
			local var_125_9 = 1.625

			if var_125_8 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_10 = arg_122_1:FormatText(StoryNameCfg[1109].name)

				arg_122_1.leftNameTxt_.text = var_125_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_11 = arg_122_1:GetWordFromCfg(417111030)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 65
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111030", "story_v_out_417111.awb") ~= 0 then
					local var_125_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111030", "story_v_out_417111.awb") / 1000

					if var_125_16 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_16 + var_125_8
					end

					if var_125_11.prefab_name ~= "" and arg_122_1.actors_[var_125_11.prefab_name] ~= nil then
						local var_125_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_11.prefab_name].transform, "story_v_out_417111", "417111030", "story_v_out_417111.awb")

						arg_122_1:RecordAudio("417111030", var_125_17)
						arg_122_1:RecordAudio("417111030", var_125_17)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_417111", "417111030", "story_v_out_417111.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_417111", "417111030", "story_v_out_417111.awb")
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
	Play417111031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417111031
		arg_126_1.duration_ = 15.7

		local var_126_0 = {
			zh = 11.3,
			ja = 15.7
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
				arg_126_0:Play417111032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 1.325

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[1109].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:GetWordFromCfg(417111031)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 53
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111031", "story_v_out_417111.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111031", "story_v_out_417111.awb") / 1000

					if var_129_8 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_0
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_417111", "417111031", "story_v_out_417111.awb")

						arg_126_1:RecordAudio("417111031", var_129_9)
						arg_126_1:RecordAudio("417111031", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_417111", "417111031", "story_v_out_417111.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_417111", "417111031", "story_v_out_417111.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_10 and arg_126_1.time_ < var_129_0 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play417111032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417111032
		arg_130_1.duration_ = 9.57

		local var_130_0 = {
			zh = 7.066,
			ja = 9.566
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
				arg_130_0:Play417111033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0
			local var_133_1 = 0.825

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_2 = arg_130_1:FormatText(StoryNameCfg[1109].name)

				arg_130_1.leftNameTxt_.text = var_133_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_3 = arg_130_1:GetWordFromCfg(417111032)
				local var_133_4 = arg_130_1:FormatText(var_133_3.content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 33
				local var_133_6 = utf8.len(var_133_4)
				local var_133_7 = var_133_5 <= 0 and var_133_1 or var_133_1 * (var_133_6 / var_133_5)

				if var_133_7 > 0 and var_133_1 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_0
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111032", "story_v_out_417111.awb") ~= 0 then
					local var_133_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111032", "story_v_out_417111.awb") / 1000

					if var_133_8 + var_133_0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_0
					end

					if var_133_3.prefab_name ~= "" and arg_130_1.actors_[var_133_3.prefab_name] ~= nil then
						local var_133_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_3.prefab_name].transform, "story_v_out_417111", "417111032", "story_v_out_417111.awb")

						arg_130_1:RecordAudio("417111032", var_133_9)
						arg_130_1:RecordAudio("417111032", var_133_9)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417111", "417111032", "story_v_out_417111.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417111", "417111032", "story_v_out_417111.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_1, arg_130_1.talkMaxDuration)

			if var_133_0 <= arg_130_1.time_ and arg_130_1.time_ < var_133_0 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_0) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_0 + var_133_10 and arg_130_1.time_ < var_133_0 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play417111033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417111033
		arg_134_1.duration_ = 7

		local var_134_0 = {
			zh = 3.566,
			ja = 7
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
				arg_134_0:Play417111034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.425

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[1109].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_3 = arg_134_1:GetWordFromCfg(417111033)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 17
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111033", "story_v_out_417111.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111033", "story_v_out_417111.awb") / 1000

					if var_137_8 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_0
					end

					if var_137_3.prefab_name ~= "" and arg_134_1.actors_[var_137_3.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_3.prefab_name].transform, "story_v_out_417111", "417111033", "story_v_out_417111.awb")

						arg_134_1:RecordAudio("417111033", var_137_9)
						arg_134_1:RecordAudio("417111033", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_417111", "417111033", "story_v_out_417111.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_417111", "417111033", "story_v_out_417111.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_10 and arg_134_1.time_ < var_137_0 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417111034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417111034
		arg_138_1.duration_ = 1.27

		local var_138_0 = {
			zh = 1.1,
			ja = 1.266
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
				arg_138_0:Play417111035(arg_138_1)
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
			local var_141_9 = 0.1

			if var_141_8 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_10 = arg_138_1:FormatText(StoryNameCfg[1137].name)

				arg_138_1.leftNameTxt_.text = var_141_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_11 = arg_138_1:GetWordFromCfg(417111034)
				local var_141_12 = arg_138_1:FormatText(var_141_11.content)

				arg_138_1.text_.text = var_141_12

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_13 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111034", "story_v_out_417111.awb") ~= 0 then
					local var_141_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111034", "story_v_out_417111.awb") / 1000

					if var_141_16 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_16 + var_141_8
					end

					if var_141_11.prefab_name ~= "" and arg_138_1.actors_[var_141_11.prefab_name] ~= nil then
						local var_141_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_11.prefab_name].transform, "story_v_out_417111", "417111034", "story_v_out_417111.awb")

						arg_138_1:RecordAudio("417111034", var_141_17)
						arg_138_1:RecordAudio("417111034", var_141_17)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417111", "417111034", "story_v_out_417111.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417111", "417111034", "story_v_out_417111.awb")
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
	Play417111035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417111035
		arg_142_1.duration_ = 7.77

		local var_142_0 = {
			zh = 3.833,
			ja = 7.766
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
				arg_142_0:Play417111036(arg_142_1)
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

			local var_145_8 = 0
			local var_145_9 = 0.475

			if var_145_8 < arg_142_1.time_ and arg_142_1.time_ <= var_145_8 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_10 = arg_142_1:FormatText(StoryNameCfg[1109].name)

				arg_142_1.leftNameTxt_.text = var_145_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_11 = arg_142_1:GetWordFromCfg(417111035)
				local var_145_12 = arg_142_1:FormatText(var_145_11.content)

				arg_142_1.text_.text = var_145_12

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_13 = 19
				local var_145_14 = utf8.len(var_145_12)
				local var_145_15 = var_145_13 <= 0 and var_145_9 or var_145_9 * (var_145_14 / var_145_13)

				if var_145_15 > 0 and var_145_9 < var_145_15 then
					arg_142_1.talkMaxDuration = var_145_15

					if var_145_15 + var_145_8 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_15 + var_145_8
					end
				end

				arg_142_1.text_.text = var_145_12
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111035", "story_v_out_417111.awb") ~= 0 then
					local var_145_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111035", "story_v_out_417111.awb") / 1000

					if var_145_16 + var_145_8 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_16 + var_145_8
					end

					if var_145_11.prefab_name ~= "" and arg_142_1.actors_[var_145_11.prefab_name] ~= nil then
						local var_145_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_11.prefab_name].transform, "story_v_out_417111", "417111035", "story_v_out_417111.awb")

						arg_142_1:RecordAudio("417111035", var_145_17)
						arg_142_1:RecordAudio("417111035", var_145_17)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417111", "417111035", "story_v_out_417111.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417111", "417111035", "story_v_out_417111.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_18 = math.max(var_145_9, arg_142_1.talkMaxDuration)

			if var_145_8 <= arg_142_1.time_ and arg_142_1.time_ < var_145_8 + var_145_18 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_8) / var_145_18

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_8 + var_145_18 and arg_142_1.time_ < var_145_8 + var_145_18 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play417111036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417111036
		arg_146_1.duration_ = 9.1

		local var_146_0 = {
			zh = 9.1,
			ja = 7.933
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
				arg_146_0:Play417111037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1034"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1034 = var_149_0.localPosition
				var_149_0.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("1034", 3)

				local var_149_2 = var_149_0.childCount

				for iter_149_0 = 0, var_149_2 - 1 do
					local var_149_3 = var_149_0:GetChild(iter_149_0)

					if var_149_3.name == "split_3" or not string.find(var_149_3.name, "split") then
						var_149_3.gameObject:SetActive(true)
					else
						var_149_3.gameObject:SetActive(false)
					end
				end
			end

			local var_149_4 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_4 then
				local var_149_5 = (arg_146_1.time_ - var_149_1) / var_149_4
				local var_149_6 = Vector3.New(0, -331.9, -324)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1034, var_149_6, var_149_5)
			end

			if arg_146_1.time_ >= var_149_1 + var_149_4 and arg_146_1.time_ < var_149_1 + var_149_4 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_149_7 = 0
			local var_149_8 = 0.925

			if var_149_7 < arg_146_1.time_ and arg_146_1.time_ <= var_149_7 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_9 = arg_146_1:FormatText(StoryNameCfg[1109].name)

				arg_146_1.leftNameTxt_.text = var_149_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_10 = arg_146_1:GetWordFromCfg(417111036)
				local var_149_11 = arg_146_1:FormatText(var_149_10.content)

				arg_146_1.text_.text = var_149_11

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_12 = 37
				local var_149_13 = utf8.len(var_149_11)
				local var_149_14 = var_149_12 <= 0 and var_149_8 or var_149_8 * (var_149_13 / var_149_12)

				if var_149_14 > 0 and var_149_8 < var_149_14 then
					arg_146_1.talkMaxDuration = var_149_14

					if var_149_14 + var_149_7 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_14 + var_149_7
					end
				end

				arg_146_1.text_.text = var_149_11
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111036", "story_v_out_417111.awb") ~= 0 then
					local var_149_15 = manager.audio:GetVoiceLength("story_v_out_417111", "417111036", "story_v_out_417111.awb") / 1000

					if var_149_15 + var_149_7 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_15 + var_149_7
					end

					if var_149_10.prefab_name ~= "" and arg_146_1.actors_[var_149_10.prefab_name] ~= nil then
						local var_149_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_10.prefab_name].transform, "story_v_out_417111", "417111036", "story_v_out_417111.awb")

						arg_146_1:RecordAudio("417111036", var_149_16)
						arg_146_1:RecordAudio("417111036", var_149_16)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417111", "417111036", "story_v_out_417111.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417111", "417111036", "story_v_out_417111.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_17 = math.max(var_149_8, arg_146_1.talkMaxDuration)

			if var_149_7 <= arg_146_1.time_ and arg_146_1.time_ < var_149_7 + var_149_17 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_7) / var_149_17

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_7 + var_149_17 and arg_146_1.time_ < var_149_7 + var_149_17 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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

		arg_146_1:InitPlayNodeList()
	end,
	Play417111037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417111037
		arg_150_1.duration_ = 6.6

		local var_150_0 = {
			zh = 6.6,
			ja = 4.466
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
				arg_150_0:Play417111038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.65

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[1109].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:GetWordFromCfg(417111037)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111037", "story_v_out_417111.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111037", "story_v_out_417111.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_417111", "417111037", "story_v_out_417111.awb")

						arg_150_1:RecordAudio("417111037", var_153_9)
						arg_150_1:RecordAudio("417111037", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417111", "417111037", "story_v_out_417111.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417111", "417111037", "story_v_out_417111.awb")
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
	Play417111038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417111038
		arg_154_1.duration_ = 10.57

		local var_154_0 = {
			zh = 8.1,
			ja = 10.566
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
				arg_154_0:Play417111039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = "ST73"

			if arg_154_1.bgs_[var_157_0] == nil then
				local var_157_1 = Object.Instantiate(arg_154_1.paintGo_)

				var_157_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_157_0)
				var_157_1.name = var_157_0
				var_157_1.transform.parent = arg_154_1.stage_.transform
				var_157_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.bgs_[var_157_0] = var_157_1
			end

			local var_157_2 = 2.00066666666667

			if var_157_2 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				local var_157_3 = manager.ui.mainCamera.transform.localPosition
				local var_157_4 = Vector3.New(0, 0, 10) + Vector3.New(var_157_3.x, var_157_3.y, 0)
				local var_157_5 = arg_154_1.bgs_.ST73

				var_157_5.transform.localPosition = var_157_4
				var_157_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_6 = var_157_5:GetComponent("SpriteRenderer")

				if var_157_6 and var_157_6.sprite then
					local var_157_7 = (var_157_5.transform.localPosition - var_157_3).z
					local var_157_8 = manager.ui.mainCameraCom_
					local var_157_9 = 2 * var_157_7 * Mathf.Tan(var_157_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_157_10 = var_157_9 * var_157_8.aspect
					local var_157_11 = var_157_6.sprite.bounds.size.x
					local var_157_12 = var_157_6.sprite.bounds.size.y
					local var_157_13 = var_157_10 / var_157_11
					local var_157_14 = var_157_9 / var_157_12
					local var_157_15 = var_157_14 < var_157_13 and var_157_13 or var_157_14

					var_157_5.transform.localScale = Vector3.New(var_157_15, var_157_15, 0)
				end

				for iter_157_0, iter_157_1 in pairs(arg_154_1.bgs_) do
					if iter_157_0 ~= "ST73" then
						iter_157_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_16 = 0

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			local var_157_17 = 0.3

			if arg_154_1.time_ >= var_157_16 + var_157_17 and arg_154_1.time_ < var_157_16 + var_157_17 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			local var_157_18 = 0

			if var_157_18 < arg_154_1.time_ and arg_154_1.time_ <= var_157_18 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_19 = 2

			if var_157_18 <= arg_154_1.time_ and arg_154_1.time_ < var_157_18 + var_157_19 then
				local var_157_20 = (arg_154_1.time_ - var_157_18) / var_157_19
				local var_157_21 = Color.New(0, 0, 0)

				var_157_21.a = Mathf.Lerp(0, 1, var_157_20)
				arg_154_1.mask_.color = var_157_21
			end

			if arg_154_1.time_ >= var_157_18 + var_157_19 and arg_154_1.time_ < var_157_18 + var_157_19 + arg_157_0 then
				local var_157_22 = Color.New(0, 0, 0)

				var_157_22.a = 1
				arg_154_1.mask_.color = var_157_22
			end

			local var_157_23 = 2

			if var_157_23 < arg_154_1.time_ and arg_154_1.time_ <= var_157_23 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_24 = 2

			if var_157_23 <= arg_154_1.time_ and arg_154_1.time_ < var_157_23 + var_157_24 then
				local var_157_25 = (arg_154_1.time_ - var_157_23) / var_157_24
				local var_157_26 = Color.New(0, 0, 0)

				var_157_26.a = Mathf.Lerp(1, 0, var_157_25)
				arg_154_1.mask_.color = var_157_26
			end

			if arg_154_1.time_ >= var_157_23 + var_157_24 and arg_154_1.time_ < var_157_23 + var_157_24 + arg_157_0 then
				local var_157_27 = Color.New(0, 0, 0)
				local var_157_28 = 0

				arg_154_1.mask_.enabled = false
				var_157_27.a = var_157_28
				arg_154_1.mask_.color = var_157_27
			end

			local var_157_29 = "10128"

			if arg_154_1.actors_[var_157_29] == nil then
				local var_157_30 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_157_30) then
					local var_157_31 = Object.Instantiate(var_157_30, arg_154_1.canvasGo_.transform)

					var_157_31.transform:SetSiblingIndex(1)

					var_157_31.name = var_157_29
					var_157_31.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_154_1.actors_[var_157_29] = var_157_31

					local var_157_32 = var_157_31:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_154_1.isInRecall_ then
						for iter_157_2, iter_157_3 in ipairs(var_157_32) do
							iter_157_3.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_157_33 = arg_154_1.actors_["10128"]
			local var_157_34 = 1.96666666666667

			if var_157_34 < arg_154_1.time_ and arg_154_1.time_ <= var_157_34 + arg_157_0 and not isNil(var_157_33) and arg_154_1.var_.actorSpriteComps10128 == nil then
				arg_154_1.var_.actorSpriteComps10128 = var_157_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_35 = 0.2

			if var_157_34 <= arg_154_1.time_ and arg_154_1.time_ < var_157_34 + var_157_35 and not isNil(var_157_33) then
				local var_157_36 = (arg_154_1.time_ - var_157_34) / var_157_35

				if arg_154_1.var_.actorSpriteComps10128 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								local var_157_37 = Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor1.r, var_157_36)
								local var_157_38 = Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor1.g, var_157_36)
								local var_157_39 = Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor1.b, var_157_36)

								iter_157_5.color = Color.New(var_157_37, var_157_38, var_157_39)
							else
								local var_157_40 = Mathf.Lerp(iter_157_5.color.r, 1, var_157_36)

								iter_157_5.color = Color.New(var_157_40, var_157_40, var_157_40)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_34 + var_157_35 and arg_154_1.time_ < var_157_34 + var_157_35 + arg_157_0 and not isNil(var_157_33) and arg_154_1.var_.actorSpriteComps10128 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_157_7 then
						if arg_154_1.isInRecall_ then
							iter_157_7.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_157_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps10128 = nil
			end

			local var_157_41 = arg_154_1.actors_["1034"]
			local var_157_42 = 1.96666666666667

			if var_157_42 < arg_154_1.time_ and arg_154_1.time_ <= var_157_42 + arg_157_0 and not isNil(var_157_41) and arg_154_1.var_.actorSpriteComps1034 == nil then
				arg_154_1.var_.actorSpriteComps1034 = var_157_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_43 = 0.2

			if var_157_42 <= arg_154_1.time_ and arg_154_1.time_ < var_157_42 + var_157_43 and not isNil(var_157_41) then
				local var_157_44 = (arg_154_1.time_ - var_157_42) / var_157_43

				if arg_154_1.var_.actorSpriteComps1034 then
					for iter_157_8, iter_157_9 in pairs(arg_154_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_157_9 then
							if arg_154_1.isInRecall_ then
								local var_157_45 = Mathf.Lerp(iter_157_9.color.r, arg_154_1.hightColor2.r, var_157_44)
								local var_157_46 = Mathf.Lerp(iter_157_9.color.g, arg_154_1.hightColor2.g, var_157_44)
								local var_157_47 = Mathf.Lerp(iter_157_9.color.b, arg_154_1.hightColor2.b, var_157_44)

								iter_157_9.color = Color.New(var_157_45, var_157_46, var_157_47)
							else
								local var_157_48 = Mathf.Lerp(iter_157_9.color.r, 0.5, var_157_44)

								iter_157_9.color = Color.New(var_157_48, var_157_48, var_157_48)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_42 + var_157_43 and arg_154_1.time_ < var_157_42 + var_157_43 + arg_157_0 and not isNil(var_157_41) and arg_154_1.var_.actorSpriteComps1034 then
				for iter_157_10, iter_157_11 in pairs(arg_154_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_157_11 then
						if arg_154_1.isInRecall_ then
							iter_157_11.color = arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_157_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps1034 = nil
			end

			local var_157_49 = arg_154_1.actors_["1034"].transform
			local var_157_50 = 1.98333333333333

			if var_157_50 < arg_154_1.time_ and arg_154_1.time_ <= var_157_50 + arg_157_0 then
				arg_154_1.var_.moveOldPos1034 = var_157_49.localPosition
				var_157_49.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1034", 7)

				local var_157_51 = var_157_49.childCount

				for iter_157_12 = 0, var_157_51 - 1 do
					local var_157_52 = var_157_49:GetChild(iter_157_12)

					if var_157_52.name == "" or not string.find(var_157_52.name, "split") then
						var_157_52.gameObject:SetActive(true)
					else
						var_157_52.gameObject:SetActive(false)
					end
				end
			end

			local var_157_53 = 0.001

			if var_157_50 <= arg_154_1.time_ and arg_154_1.time_ < var_157_50 + var_157_53 then
				local var_157_54 = (arg_154_1.time_ - var_157_50) / var_157_53
				local var_157_55 = Vector3.New(0, -2000, 0)

				var_157_49.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1034, var_157_55, var_157_54)
			end

			if arg_154_1.time_ >= var_157_50 + var_157_53 and arg_154_1.time_ < var_157_50 + var_157_53 + arg_157_0 then
				var_157_49.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_157_56 = 0
			local var_157_57 = 0.2

			if var_157_56 < arg_154_1.time_ and arg_154_1.time_ <= var_157_56 + arg_157_0 then
				local var_157_58 = "play"
				local var_157_59 = "music"

				arg_154_1:AudioAction(var_157_58, var_157_59, "ui_battle", "ui_battle_stopbgm", "")

				local var_157_60 = ""
				local var_157_61 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_157_61 ~= "" then
					if arg_154_1.bgmTxt_.text ~= var_157_61 and arg_154_1.bgmTxt_.text ~= "" then
						if arg_154_1.bgmTxt2_.text ~= "" then
							arg_154_1.bgmTxt_.text = arg_154_1.bgmTxt2_.text
						end

						arg_154_1.bgmTxt2_.text = var_157_61

						arg_154_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_154_1.bgmTxt_.text = var_157_61
						arg_154_1.bgmTxt2_.text = var_157_61
					end

					if arg_154_1.bgmTimer then
						arg_154_1.bgmTimer:Stop()

						arg_154_1.bgmTimer = nil
					end

					if arg_154_1.settingData.show_music_name == 1 then
						arg_154_1.musicController:SetSelectedState("show")
						arg_154_1.musicAnimator_:Play("open", 0, 0)

						if arg_154_1.settingData.music_time ~= 0 then
							arg_154_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_154_1.settingData.music_time), function()
								if arg_154_1 == nil or isNil(arg_154_1.bgmTxt_) then
									return
								end

								arg_154_1.musicController:SetSelectedState("hide")
								arg_154_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_157_62 = 1.66666666666667
			local var_157_63 = 1

			if var_157_62 < arg_154_1.time_ and arg_154_1.time_ <= var_157_62 + arg_157_0 then
				local var_157_64 = "play"
				local var_157_65 = "music"

				arg_154_1:AudioAction(var_157_64, var_157_65, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_157_66 = ""
				local var_157_67 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_157_67 ~= "" then
					if arg_154_1.bgmTxt_.text ~= var_157_67 and arg_154_1.bgmTxt_.text ~= "" then
						if arg_154_1.bgmTxt2_.text ~= "" then
							arg_154_1.bgmTxt_.text = arg_154_1.bgmTxt2_.text
						end

						arg_154_1.bgmTxt2_.text = var_157_67

						arg_154_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_154_1.bgmTxt_.text = var_157_67
						arg_154_1.bgmTxt2_.text = var_157_67
					end

					if arg_154_1.bgmTimer then
						arg_154_1.bgmTimer:Stop()

						arg_154_1.bgmTimer = nil
					end

					if arg_154_1.settingData.show_music_name == 1 then
						arg_154_1.musicController:SetSelectedState("show")
						arg_154_1.musicAnimator_:Play("open", 0, 0)

						if arg_154_1.settingData.music_time ~= 0 then
							arg_154_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_154_1.settingData.music_time), function()
								if arg_154_1 == nil or isNil(arg_154_1.bgmTxt_) then
									return
								end

								arg_154_1.musicController:SetSelectedState("hide")
								arg_154_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_68 = 3.7
			local var_157_69 = 0.55

			if var_157_68 < arg_154_1.time_ and arg_154_1.time_ <= var_157_68 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_70 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_70:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_154_1.dialogCg_.alpha = arg_160_0
				end))
				var_157_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_71 = arg_154_1:FormatText(StoryNameCfg[595].name)

				arg_154_1.leftNameTxt_.text = var_157_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_72 = arg_154_1:GetWordFromCfg(417111038)
				local var_157_73 = arg_154_1:FormatText(var_157_72.content)

				arg_154_1.text_.text = var_157_73

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_74 = 22
				local var_157_75 = utf8.len(var_157_73)
				local var_157_76 = var_157_74 <= 0 and var_157_69 or var_157_69 * (var_157_75 / var_157_74)

				if var_157_76 > 0 and var_157_69 < var_157_76 then
					arg_154_1.talkMaxDuration = var_157_76
					var_157_68 = var_157_68 + 0.3

					if var_157_76 + var_157_68 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_76 + var_157_68
					end
				end

				arg_154_1.text_.text = var_157_73
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111038", "story_v_out_417111.awb") ~= 0 then
					local var_157_77 = manager.audio:GetVoiceLength("story_v_out_417111", "417111038", "story_v_out_417111.awb") / 1000

					if var_157_77 + var_157_68 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_77 + var_157_68
					end

					if var_157_72.prefab_name ~= "" and arg_154_1.actors_[var_157_72.prefab_name] ~= nil then
						local var_157_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_72.prefab_name].transform, "story_v_out_417111", "417111038", "story_v_out_417111.awb")

						arg_154_1:RecordAudio("417111038", var_157_78)
						arg_154_1:RecordAudio("417111038", var_157_78)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417111", "417111038", "story_v_out_417111.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417111", "417111038", "story_v_out_417111.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_79 = var_157_68 + 0.3
			local var_157_80 = math.max(var_157_69, arg_154_1.talkMaxDuration)

			if var_157_79 <= arg_154_1.time_ and arg_154_1.time_ < var_157_79 + var_157_80 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_79) / var_157_80

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_79 + var_157_80 and arg_154_1.time_ < var_157_79 + var_157_80 + arg_157_0 then
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
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play417111039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417111039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417111040(arg_162_1)
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
								local var_165_4 = Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor2.r, var_165_3)
								local var_165_5 = Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor2.g, var_165_3)
								local var_165_6 = Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor2.b, var_165_3)

								iter_165_1.color = Color.New(var_165_4, var_165_5, var_165_6)
							else
								local var_165_7 = Mathf.Lerp(iter_165_1.color.r, 0.5, var_165_3)

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
							iter_165_3.color = arg_162_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_165_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps10128 = nil
			end

			local var_165_8 = 0
			local var_165_9 = 1.225

			if var_165_8 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_10 = arg_162_1:GetWordFromCfg(417111039)
				local var_165_11 = arg_162_1:FormatText(var_165_10.content)

				arg_162_1.text_.text = var_165_11

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_12 = 49
				local var_165_13 = utf8.len(var_165_11)
				local var_165_14 = var_165_12 <= 0 and var_165_9 or var_165_9 * (var_165_13 / var_165_12)

				if var_165_14 > 0 and var_165_9 < var_165_14 then
					arg_162_1.talkMaxDuration = var_165_14

					if var_165_14 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_8
					end
				end

				arg_162_1.text_.text = var_165_11
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_15 = math.max(var_165_9, arg_162_1.talkMaxDuration)

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_15 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_8) / var_165_15

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_8 + var_165_15 and arg_162_1.time_ < var_165_8 + var_165_15 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play417111040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417111040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play417111041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.8
			local var_169_1 = 1

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				local var_169_2 = "play"
				local var_169_3 = "effect"

				arg_166_1:AudioAction(var_169_2, var_169_3, "se_story_1310", "se_story_1310_teacup02", "")
			end

			local var_169_4 = 0
			local var_169_5 = 1.7

			if var_169_4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(417111040)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_8 = 68
				local var_169_9 = utf8.len(var_169_7)
				local var_169_10 = var_169_8 <= 0 and var_169_5 or var_169_5 * (var_169_9 / var_169_8)

				if var_169_10 > 0 and var_169_5 < var_169_10 then
					arg_166_1.talkMaxDuration = var_169_10

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_11 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_11 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_11

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_11 and arg_166_1.time_ < var_169_4 + var_169_11 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play417111041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417111041
		arg_170_1.duration_ = 4.1

		local var_170_0 = {
			zh = 1.366,
			ja = 4.1
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
				arg_170_0:Play417111042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.125

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[1138].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:GetWordFromCfg(417111041)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 5
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111041", "story_v_out_417111.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111041", "story_v_out_417111.awb") / 1000

					if var_173_8 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_0
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_417111", "417111041", "story_v_out_417111.awb")

						arg_170_1:RecordAudio("417111041", var_173_9)
						arg_170_1:RecordAudio("417111041", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417111", "417111041", "story_v_out_417111.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417111", "417111041", "story_v_out_417111.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_10 and arg_170_1.time_ < var_173_0 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play417111042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417111042
		arg_174_1.duration_ = 4.4

		local var_174_0 = {
			zh = 3.1,
			ja = 4.4
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
				arg_174_0:Play417111043(arg_174_1)
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
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 1, var_177_3)

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
							iter_177_3.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_177_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10128 = nil
			end

			local var_177_8 = arg_174_1.actors_["10128"].transform
			local var_177_9 = 0

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 then
				arg_174_1.var_.moveOldPos10128 = var_177_8.localPosition
				var_177_8.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10128", 3)

				local var_177_10 = var_177_8.childCount

				for iter_177_4 = 0, var_177_10 - 1 do
					local var_177_11 = var_177_8:GetChild(iter_177_4)

					if var_177_11.name == "" or not string.find(var_177_11.name, "split") then
						var_177_11.gameObject:SetActive(true)
					else
						var_177_11.gameObject:SetActive(false)
					end
				end
			end

			local var_177_12 = 0.001

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_12 then
				local var_177_13 = (arg_174_1.time_ - var_177_9) / var_177_12
				local var_177_14 = Vector3.New(0, -347, -300)

				var_177_8.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10128, var_177_14, var_177_13)
			end

			if arg_174_1.time_ >= var_177_9 + var_177_12 and arg_174_1.time_ < var_177_9 + var_177_12 + arg_177_0 then
				var_177_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_177_15 = 0
			local var_177_16 = 0.4

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_17 = arg_174_1:FormatText(StoryNameCfg[595].name)

				arg_174_1.leftNameTxt_.text = var_177_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_18 = arg_174_1:GetWordFromCfg(417111042)
				local var_177_19 = arg_174_1:FormatText(var_177_18.content)

				arg_174_1.text_.text = var_177_19

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_20 = 16
				local var_177_21 = utf8.len(var_177_19)
				local var_177_22 = var_177_20 <= 0 and var_177_16 or var_177_16 * (var_177_21 / var_177_20)

				if var_177_22 > 0 and var_177_16 < var_177_22 then
					arg_174_1.talkMaxDuration = var_177_22

					if var_177_22 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_22 + var_177_15
					end
				end

				arg_174_1.text_.text = var_177_19
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111042", "story_v_out_417111.awb") ~= 0 then
					local var_177_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111042", "story_v_out_417111.awb") / 1000

					if var_177_23 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_23 + var_177_15
					end

					if var_177_18.prefab_name ~= "" and arg_174_1.actors_[var_177_18.prefab_name] ~= nil then
						local var_177_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_18.prefab_name].transform, "story_v_out_417111", "417111042", "story_v_out_417111.awb")

						arg_174_1:RecordAudio("417111042", var_177_24)
						arg_174_1:RecordAudio("417111042", var_177_24)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417111", "417111042", "story_v_out_417111.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417111", "417111042", "story_v_out_417111.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_25 = math.max(var_177_16, arg_174_1.talkMaxDuration)

			if var_177_15 <= arg_174_1.time_ and arg_174_1.time_ < var_177_15 + var_177_25 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_15) / var_177_25

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_15 + var_177_25 and arg_174_1.time_ < var_177_15 + var_177_25 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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

		arg_174_1:InitPlayNodeList()
	end,
	Play417111043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417111043
		arg_178_1.duration_ = 10.7

		local var_178_0 = {
			zh = 8.233,
			ja = 10.7
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play417111044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 1.05

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[595].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:GetWordFromCfg(417111043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 42
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111043", "story_v_out_417111.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111043", "story_v_out_417111.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_417111", "417111043", "story_v_out_417111.awb")

						arg_178_1:RecordAudio("417111043", var_181_9)
						arg_178_1:RecordAudio("417111043", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_417111", "417111043", "story_v_out_417111.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_417111", "417111043", "story_v_out_417111.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play417111044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417111044
		arg_182_1.duration_ = 10.63

		local var_182_0 = {
			zh = 6.766,
			ja = 10.633
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
				arg_182_0:Play417111045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10128"].transform
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.var_.moveOldPos10128 = var_185_0.localPosition
				var_185_0.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10128", 3)

				local var_185_2 = var_185_0.childCount

				for iter_185_0 = 0, var_185_2 - 1 do
					local var_185_3 = var_185_0:GetChild(iter_185_0)

					if var_185_3.name == "split_6" or not string.find(var_185_3.name, "split") then
						var_185_3.gameObject:SetActive(true)
					else
						var_185_3.gameObject:SetActive(false)
					end
				end
			end

			local var_185_4 = 0.001

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_4 then
				local var_185_5 = (arg_182_1.time_ - var_185_1) / var_185_4
				local var_185_6 = Vector3.New(0, -347, -300)

				var_185_0.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10128, var_185_6, var_185_5)
			end

			if arg_182_1.time_ >= var_185_1 + var_185_4 and arg_182_1.time_ < var_185_1 + var_185_4 + arg_185_0 then
				var_185_0.localPosition = Vector3.New(0, -347, -300)
			end

			local var_185_7 = 0
			local var_185_8 = 0.725

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_9 = arg_182_1:FormatText(StoryNameCfg[595].name)

				arg_182_1.leftNameTxt_.text = var_185_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_10 = arg_182_1:GetWordFromCfg(417111044)
				local var_185_11 = arg_182_1:FormatText(var_185_10.content)

				arg_182_1.text_.text = var_185_11

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_12 = 29
				local var_185_13 = utf8.len(var_185_11)
				local var_185_14 = var_185_12 <= 0 and var_185_8 or var_185_8 * (var_185_13 / var_185_12)

				if var_185_14 > 0 and var_185_8 < var_185_14 then
					arg_182_1.talkMaxDuration = var_185_14

					if var_185_14 + var_185_7 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_7
					end
				end

				arg_182_1.text_.text = var_185_11
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111044", "story_v_out_417111.awb") ~= 0 then
					local var_185_15 = manager.audio:GetVoiceLength("story_v_out_417111", "417111044", "story_v_out_417111.awb") / 1000

					if var_185_15 + var_185_7 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_15 + var_185_7
					end

					if var_185_10.prefab_name ~= "" and arg_182_1.actors_[var_185_10.prefab_name] ~= nil then
						local var_185_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_10.prefab_name].transform, "story_v_out_417111", "417111044", "story_v_out_417111.awb")

						arg_182_1:RecordAudio("417111044", var_185_16)
						arg_182_1:RecordAudio("417111044", var_185_16)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417111", "417111044", "story_v_out_417111.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417111", "417111044", "story_v_out_417111.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_17 = math.max(var_185_8, arg_182_1.talkMaxDuration)

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_17 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_7) / var_185_17

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_7 + var_185_17 and arg_182_1.time_ < var_185_7 + var_185_17 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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

		arg_182_1:InitPlayNodeList()
	end,
	Play417111045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417111045
		arg_186_1.duration_ = 5.27

		local var_186_0 = {
			zh = 3.2,
			ja = 5.266
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
				arg_186_0:Play417111046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10128"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10128 == nil then
				arg_186_1.var_.actorSpriteComps10128 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps10128 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 0.5, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10128 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10128 = nil
			end

			local var_189_8 = 0
			local var_189_9 = 0.325

			if var_189_8 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_10 = arg_186_1:FormatText(StoryNameCfg[1138].name)

				arg_186_1.leftNameTxt_.text = var_189_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_11 = arg_186_1:GetWordFromCfg(417111045)
				local var_189_12 = arg_186_1:FormatText(var_189_11.content)

				arg_186_1.text_.text = var_189_12

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 13
				local var_189_14 = utf8.len(var_189_12)
				local var_189_15 = var_189_13 <= 0 and var_189_9 or var_189_9 * (var_189_14 / var_189_13)

				if var_189_15 > 0 and var_189_9 < var_189_15 then
					arg_186_1.talkMaxDuration = var_189_15

					if var_189_15 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_15 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_12
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111045", "story_v_out_417111.awb") ~= 0 then
					local var_189_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111045", "story_v_out_417111.awb") / 1000

					if var_189_16 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_16 + var_189_8
					end

					if var_189_11.prefab_name ~= "" and arg_186_1.actors_[var_189_11.prefab_name] ~= nil then
						local var_189_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_11.prefab_name].transform, "story_v_out_417111", "417111045", "story_v_out_417111.awb")

						arg_186_1:RecordAudio("417111045", var_189_17)
						arg_186_1:RecordAudio("417111045", var_189_17)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417111", "417111045", "story_v_out_417111.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417111", "417111045", "story_v_out_417111.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_18 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_18 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_18

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_18 and arg_186_1.time_ < var_189_8 + var_189_18 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play417111046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417111046
		arg_190_1.duration_ = 5.47

		local var_190_0 = {
			zh = 1.3,
			ja = 5.466
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play417111047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10128"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps10128 == nil then
				arg_190_1.var_.actorSpriteComps10128 = var_193_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.actorSpriteComps10128 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								local var_193_4 = Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor1.r, var_193_3)
								local var_193_5 = Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor1.g, var_193_3)
								local var_193_6 = Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor1.b, var_193_3)

								iter_193_1.color = Color.New(var_193_4, var_193_5, var_193_6)
							else
								local var_193_7 = Mathf.Lerp(iter_193_1.color.r, 1, var_193_3)

								iter_193_1.color = Color.New(var_193_7, var_193_7, var_193_7)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps10128 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_193_3 then
						if arg_190_1.isInRecall_ then
							iter_193_3.color = arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_193_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps10128 = nil
			end

			local var_193_8 = 0
			local var_193_9 = 0.15

			if var_193_8 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_10 = arg_190_1:FormatText(StoryNameCfg[595].name)

				arg_190_1.leftNameTxt_.text = var_193_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_11 = arg_190_1:GetWordFromCfg(417111046)
				local var_193_12 = arg_190_1:FormatText(var_193_11.content)

				arg_190_1.text_.text = var_193_12

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_13 = 6
				local var_193_14 = utf8.len(var_193_12)
				local var_193_15 = var_193_13 <= 0 and var_193_9 or var_193_9 * (var_193_14 / var_193_13)

				if var_193_15 > 0 and var_193_9 < var_193_15 then
					arg_190_1.talkMaxDuration = var_193_15

					if var_193_15 + var_193_8 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_15 + var_193_8
					end
				end

				arg_190_1.text_.text = var_193_12
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111046", "story_v_out_417111.awb") ~= 0 then
					local var_193_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111046", "story_v_out_417111.awb") / 1000

					if var_193_16 + var_193_8 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_16 + var_193_8
					end

					if var_193_11.prefab_name ~= "" and arg_190_1.actors_[var_193_11.prefab_name] ~= nil then
						local var_193_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_11.prefab_name].transform, "story_v_out_417111", "417111046", "story_v_out_417111.awb")

						arg_190_1:RecordAudio("417111046", var_193_17)
						arg_190_1:RecordAudio("417111046", var_193_17)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_417111", "417111046", "story_v_out_417111.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_417111", "417111046", "story_v_out_417111.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_18 = math.max(var_193_9, arg_190_1.talkMaxDuration)

			if var_193_8 <= arg_190_1.time_ and arg_190_1.time_ < var_193_8 + var_193_18 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_8) / var_193_18

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_8 + var_193_18 and arg_190_1.time_ < var_193_8 + var_193_18 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417111047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417111047
		arg_194_1.duration_ = 12.9

		local var_194_0 = {
			zh = 8.3,
			ja = 12.9
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
				arg_194_0:Play417111048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 1.125

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[595].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_3 = arg_194_1:GetWordFromCfg(417111047)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111047", "story_v_out_417111.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111047", "story_v_out_417111.awb") / 1000

					if var_197_8 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_0
					end

					if var_197_3.prefab_name ~= "" and arg_194_1.actors_[var_197_3.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_3.prefab_name].transform, "story_v_out_417111", "417111047", "story_v_out_417111.awb")

						arg_194_1:RecordAudio("417111047", var_197_9)
						arg_194_1:RecordAudio("417111047", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417111", "417111047", "story_v_out_417111.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417111", "417111047", "story_v_out_417111.awb")
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
	Play417111048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417111048
		arg_198_1.duration_ = 9.83

		local var_198_0 = {
			zh = 4.2,
			ja = 9.833
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
				arg_198_0:Play417111049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10128"].transform
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.var_.moveOldPos10128 = var_201_0.localPosition
				var_201_0.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("10128", 3)

				local var_201_2 = var_201_0.childCount

				for iter_201_0 = 0, var_201_2 - 1 do
					local var_201_3 = var_201_0:GetChild(iter_201_0)

					if var_201_3.name == "" or not string.find(var_201_3.name, "split") then
						var_201_3.gameObject:SetActive(true)
					else
						var_201_3.gameObject:SetActive(false)
					end
				end
			end

			local var_201_4 = 0.001

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_4 then
				local var_201_5 = (arg_198_1.time_ - var_201_1) / var_201_4
				local var_201_6 = Vector3.New(0, -347, -300)

				var_201_0.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10128, var_201_6, var_201_5)
			end

			if arg_198_1.time_ >= var_201_1 + var_201_4 and arg_198_1.time_ < var_201_1 + var_201_4 + arg_201_0 then
				var_201_0.localPosition = Vector3.New(0, -347, -300)
			end

			local var_201_7 = 0
			local var_201_8 = 0.525

			if var_201_7 < arg_198_1.time_ and arg_198_1.time_ <= var_201_7 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_9 = arg_198_1:FormatText(StoryNameCfg[595].name)

				arg_198_1.leftNameTxt_.text = var_201_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(417111048)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_12 = 21
				local var_201_13 = utf8.len(var_201_11)
				local var_201_14 = var_201_12 <= 0 and var_201_8 or var_201_8 * (var_201_13 / var_201_12)

				if var_201_14 > 0 and var_201_8 < var_201_14 then
					arg_198_1.talkMaxDuration = var_201_14

					if var_201_14 + var_201_7 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_7
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111048", "story_v_out_417111.awb") ~= 0 then
					local var_201_15 = manager.audio:GetVoiceLength("story_v_out_417111", "417111048", "story_v_out_417111.awb") / 1000

					if var_201_15 + var_201_7 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_15 + var_201_7
					end

					if var_201_10.prefab_name ~= "" and arg_198_1.actors_[var_201_10.prefab_name] ~= nil then
						local var_201_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_10.prefab_name].transform, "story_v_out_417111", "417111048", "story_v_out_417111.awb")

						arg_198_1:RecordAudio("417111048", var_201_16)
						arg_198_1:RecordAudio("417111048", var_201_16)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417111", "417111048", "story_v_out_417111.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417111", "417111048", "story_v_out_417111.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_17 = math.max(var_201_8, arg_198_1.talkMaxDuration)

			if var_201_7 <= arg_198_1.time_ and arg_198_1.time_ < var_201_7 + var_201_17 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_7) / var_201_17

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_7 + var_201_17 and arg_198_1.time_ < var_201_7 + var_201_17 + arg_201_0 then
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
	Play417111049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417111049
		arg_202_1.duration_ = 10.9

		local var_202_0 = {
			zh = 4.3,
			ja = 10.9
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
				arg_202_0:Play417111050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["10128"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps10128 == nil then
				arg_202_1.var_.actorSpriteComps10128 = var_205_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.actorSpriteComps10128 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								local var_205_4 = Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor2.r, var_205_3)
								local var_205_5 = Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor2.g, var_205_3)
								local var_205_6 = Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor2.b, var_205_3)

								iter_205_1.color = Color.New(var_205_4, var_205_5, var_205_6)
							else
								local var_205_7 = Mathf.Lerp(iter_205_1.color.r, 0.5, var_205_3)

								iter_205_1.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps10128 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_205_3 then
						if arg_202_1.isInRecall_ then
							iter_205_3.color = arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_205_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps10128 = nil
			end

			local var_205_8 = 0
			local var_205_9 = 0.4

			if var_205_8 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_10 = arg_202_1:FormatText(StoryNameCfg[1138].name)

				arg_202_1.leftNameTxt_.text = var_205_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_11 = arg_202_1:GetWordFromCfg(417111049)
				local var_205_12 = arg_202_1:FormatText(var_205_11.content)

				arg_202_1.text_.text = var_205_12

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_13 = 16
				local var_205_14 = utf8.len(var_205_12)
				local var_205_15 = var_205_13 <= 0 and var_205_9 or var_205_9 * (var_205_14 / var_205_13)

				if var_205_15 > 0 and var_205_9 < var_205_15 then
					arg_202_1.talkMaxDuration = var_205_15

					if var_205_15 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_15 + var_205_8
					end
				end

				arg_202_1.text_.text = var_205_12
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111049", "story_v_out_417111.awb") ~= 0 then
					local var_205_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111049", "story_v_out_417111.awb") / 1000

					if var_205_16 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_16 + var_205_8
					end

					if var_205_11.prefab_name ~= "" and arg_202_1.actors_[var_205_11.prefab_name] ~= nil then
						local var_205_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_11.prefab_name].transform, "story_v_out_417111", "417111049", "story_v_out_417111.awb")

						arg_202_1:RecordAudio("417111049", var_205_17)
						arg_202_1:RecordAudio("417111049", var_205_17)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417111", "417111049", "story_v_out_417111.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417111", "417111049", "story_v_out_417111.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_18 = math.max(var_205_9, arg_202_1.talkMaxDuration)

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_18 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_8) / var_205_18

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_8 + var_205_18 and arg_202_1.time_ < var_205_8 + var_205_18 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play417111050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417111050
		arg_206_1.duration_ = 7.2

		local var_206_0 = {
			zh = 7.2,
			ja = 6.966
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
				arg_206_0:Play417111051(arg_206_1)
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

			local var_209_8 = 0
			local var_209_9 = 0.875

			if var_209_8 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_10 = arg_206_1:FormatText(StoryNameCfg[595].name)

				arg_206_1.leftNameTxt_.text = var_209_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_11 = arg_206_1:GetWordFromCfg(417111050)
				local var_209_12 = arg_206_1:FormatText(var_209_11.content)

				arg_206_1.text_.text = var_209_12

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 35
				local var_209_14 = utf8.len(var_209_12)
				local var_209_15 = var_209_13 <= 0 and var_209_9 or var_209_9 * (var_209_14 / var_209_13)

				if var_209_15 > 0 and var_209_9 < var_209_15 then
					arg_206_1.talkMaxDuration = var_209_15

					if var_209_15 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_15 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_12
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111050", "story_v_out_417111.awb") ~= 0 then
					local var_209_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111050", "story_v_out_417111.awb") / 1000

					if var_209_16 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_16 + var_209_8
					end

					if var_209_11.prefab_name ~= "" and arg_206_1.actors_[var_209_11.prefab_name] ~= nil then
						local var_209_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_11.prefab_name].transform, "story_v_out_417111", "417111050", "story_v_out_417111.awb")

						arg_206_1:RecordAudio("417111050", var_209_17)
						arg_206_1:RecordAudio("417111050", var_209_17)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417111", "417111050", "story_v_out_417111.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417111", "417111050", "story_v_out_417111.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_18 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_18 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_18

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_18 and arg_206_1.time_ < var_209_8 + var_209_18 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play417111051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417111051
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417111052(arg_210_1)
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
			local var_213_9 = 0.7

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

				local var_213_10 = arg_210_1:GetWordFromCfg(417111051)
				local var_213_11 = arg_210_1:FormatText(var_213_10.content)

				arg_210_1.text_.text = var_213_11

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_12 = 28
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
	Play417111052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417111052
		arg_214_1.duration_ = 5.8

		local var_214_0 = {
			zh = 5.8,
			ja = 5.3
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
				arg_214_0:Play417111053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.6

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[1138].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(417111052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111052", "story_v_out_417111.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111052", "story_v_out_417111.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_417111", "417111052", "story_v_out_417111.awb")

						arg_214_1:RecordAudio("417111052", var_217_9)
						arg_214_1:RecordAudio("417111052", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417111", "417111052", "story_v_out_417111.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417111", "417111052", "story_v_out_417111.awb")
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
	Play417111053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417111053
		arg_218_1.duration_ = 6.8

		local var_218_0 = {
			zh = 4.1,
			ja = 6.8
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
				arg_218_0:Play417111054(arg_218_1)
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

			local var_221_8 = arg_218_1.actors_["10128"].transform
			local var_221_9 = 0

			if var_221_9 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 then
				arg_218_1.var_.moveOldPos10128 = var_221_8.localPosition
				var_221_8.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10128", 3)

				local var_221_10 = var_221_8.childCount

				for iter_221_4 = 0, var_221_10 - 1 do
					local var_221_11 = var_221_8:GetChild(iter_221_4)

					if var_221_11.name == "split_6" or not string.find(var_221_11.name, "split") then
						var_221_11.gameObject:SetActive(true)
					else
						var_221_11.gameObject:SetActive(false)
					end
				end
			end

			local var_221_12 = 0.001

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_12 then
				local var_221_13 = (arg_218_1.time_ - var_221_9) / var_221_12
				local var_221_14 = Vector3.New(0, -347, -300)

				var_221_8.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10128, var_221_14, var_221_13)
			end

			if arg_218_1.time_ >= var_221_9 + var_221_12 and arg_218_1.time_ < var_221_9 + var_221_12 + arg_221_0 then
				var_221_8.localPosition = Vector3.New(0, -347, -300)
			end

			local var_221_15 = 0
			local var_221_16 = 0.525

			if var_221_15 < arg_218_1.time_ and arg_218_1.time_ <= var_221_15 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_17 = arg_218_1:FormatText(StoryNameCfg[595].name)

				arg_218_1.leftNameTxt_.text = var_221_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_18 = arg_218_1:GetWordFromCfg(417111053)
				local var_221_19 = arg_218_1:FormatText(var_221_18.content)

				arg_218_1.text_.text = var_221_19

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_20 = 21
				local var_221_21 = utf8.len(var_221_19)
				local var_221_22 = var_221_20 <= 0 and var_221_16 or var_221_16 * (var_221_21 / var_221_20)

				if var_221_22 > 0 and var_221_16 < var_221_22 then
					arg_218_1.talkMaxDuration = var_221_22

					if var_221_22 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_22 + var_221_15
					end
				end

				arg_218_1.text_.text = var_221_19
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111053", "story_v_out_417111.awb") ~= 0 then
					local var_221_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111053", "story_v_out_417111.awb") / 1000

					if var_221_23 + var_221_15 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_23 + var_221_15
					end

					if var_221_18.prefab_name ~= "" and arg_218_1.actors_[var_221_18.prefab_name] ~= nil then
						local var_221_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_18.prefab_name].transform, "story_v_out_417111", "417111053", "story_v_out_417111.awb")

						arg_218_1:RecordAudio("417111053", var_221_24)
						arg_218_1:RecordAudio("417111053", var_221_24)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417111", "417111053", "story_v_out_417111.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417111", "417111053", "story_v_out_417111.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_25 = math.max(var_221_16, arg_218_1.talkMaxDuration)

			if var_221_15 <= arg_218_1.time_ and arg_218_1.time_ < var_221_15 + var_221_25 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_15) / var_221_25

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_15 + var_221_25 and arg_218_1.time_ < var_221_15 + var_221_25 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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

		arg_218_1:InitPlayNodeList()
	end,
	Play417111054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417111054
		arg_222_1.duration_ = 10.3

		local var_222_0 = {
			zh = 6.7,
			ja = 10.3
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
				arg_222_0:Play417111055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10128"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps10128 == nil then
				arg_222_1.var_.actorSpriteComps10128 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps10128 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 0.5, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps10128 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_225_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10128 = nil
			end

			local var_225_8 = 0
			local var_225_9 = 0.725

			if var_225_8 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_10 = arg_222_1:FormatText(StoryNameCfg[1138].name)

				arg_222_1.leftNameTxt_.text = var_225_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_11 = arg_222_1:GetWordFromCfg(417111054)
				local var_225_12 = arg_222_1:FormatText(var_225_11.content)

				arg_222_1.text_.text = var_225_12

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 29
				local var_225_14 = utf8.len(var_225_12)
				local var_225_15 = var_225_13 <= 0 and var_225_9 or var_225_9 * (var_225_14 / var_225_13)

				if var_225_15 > 0 and var_225_9 < var_225_15 then
					arg_222_1.talkMaxDuration = var_225_15

					if var_225_15 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_15 + var_225_8
					end
				end

				arg_222_1.text_.text = var_225_12
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111054", "story_v_out_417111.awb") ~= 0 then
					local var_225_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111054", "story_v_out_417111.awb") / 1000

					if var_225_16 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_16 + var_225_8
					end

					if var_225_11.prefab_name ~= "" and arg_222_1.actors_[var_225_11.prefab_name] ~= nil then
						local var_225_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_11.prefab_name].transform, "story_v_out_417111", "417111054", "story_v_out_417111.awb")

						arg_222_1:RecordAudio("417111054", var_225_17)
						arg_222_1:RecordAudio("417111054", var_225_17)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417111", "417111054", "story_v_out_417111.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417111", "417111054", "story_v_out_417111.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_18 = math.max(var_225_9, arg_222_1.talkMaxDuration)

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_18 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_8) / var_225_18

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_8 + var_225_18 and arg_222_1.time_ < var_225_8 + var_225_18 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play417111055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417111055
		arg_226_1.duration_ = 3.33

		local var_226_0 = {
			zh = 2.633,
			ja = 3.333
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417111056(arg_226_1)
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
								local var_229_4 = Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, var_229_3)
								local var_229_5 = Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, var_229_3)
								local var_229_6 = Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, var_229_3)

								iter_229_1.color = Color.New(var_229_4, var_229_5, var_229_6)
							else
								local var_229_7 = Mathf.Lerp(iter_229_1.color.r, 1, var_229_3)

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
							iter_229_3.color = arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_229_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_226_1.var_.actorSpriteComps10128 = nil
			end

			local var_229_8 = 0
			local var_229_9 = 0.35

			if var_229_8 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_10 = arg_226_1:FormatText(StoryNameCfg[595].name)

				arg_226_1.leftNameTxt_.text = var_229_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_11 = arg_226_1:GetWordFromCfg(417111055)
				local var_229_12 = arg_226_1:FormatText(var_229_11.content)

				arg_226_1.text_.text = var_229_12

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_13 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111055", "story_v_out_417111.awb") ~= 0 then
					local var_229_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111055", "story_v_out_417111.awb") / 1000

					if var_229_16 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_16 + var_229_8
					end

					if var_229_11.prefab_name ~= "" and arg_226_1.actors_[var_229_11.prefab_name] ~= nil then
						local var_229_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_11.prefab_name].transform, "story_v_out_417111", "417111055", "story_v_out_417111.awb")

						arg_226_1:RecordAudio("417111055", var_229_17)
						arg_226_1:RecordAudio("417111055", var_229_17)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417111", "417111055", "story_v_out_417111.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417111", "417111055", "story_v_out_417111.awb")
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
	Play417111056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417111056
		arg_230_1.duration_ = 8.73

		local var_230_0 = {
			zh = 4.166,
			ja = 8.733
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
				arg_230_0:Play417111057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0
			local var_233_1 = 0.6

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_2 = arg_230_1:FormatText(StoryNameCfg[595].name)

				arg_230_1.leftNameTxt_.text = var_233_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:GetWordFromCfg(417111056)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 24
				local var_233_6 = utf8.len(var_233_4)
				local var_233_7 = var_233_5 <= 0 and var_233_1 or var_233_1 * (var_233_6 / var_233_5)

				if var_233_7 > 0 and var_233_1 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111056", "story_v_out_417111.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111056", "story_v_out_417111.awb") / 1000

					if var_233_8 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_0
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_out_417111", "417111056", "story_v_out_417111.awb")

						arg_230_1:RecordAudio("417111056", var_233_9)
						arg_230_1:RecordAudio("417111056", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_417111", "417111056", "story_v_out_417111.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_417111", "417111056", "story_v_out_417111.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_10 and arg_230_1.time_ < var_233_0 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play417111057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417111057
		arg_234_1.duration_ = 12.53

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417111058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 2.00066666666667

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				local var_237_1 = manager.ui.mainCamera.transform.localPosition
				local var_237_2 = Vector3.New(0, 0, 10) + Vector3.New(var_237_1.x, var_237_1.y, 0)
				local var_237_3 = arg_234_1.bgs_.I07a

				var_237_3.transform.localPosition = var_237_2
				var_237_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_4 = var_237_3:GetComponent("SpriteRenderer")

				if var_237_4 and var_237_4.sprite then
					local var_237_5 = (var_237_3.transform.localPosition - var_237_1).z
					local var_237_6 = manager.ui.mainCameraCom_
					local var_237_7 = 2 * var_237_5 * Mathf.Tan(var_237_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_237_8 = var_237_7 * var_237_6.aspect
					local var_237_9 = var_237_4.sprite.bounds.size.x
					local var_237_10 = var_237_4.sprite.bounds.size.y
					local var_237_11 = var_237_8 / var_237_9
					local var_237_12 = var_237_7 / var_237_10
					local var_237_13 = var_237_12 < var_237_11 and var_237_11 or var_237_12

					var_237_3.transform.localScale = Vector3.New(var_237_13, var_237_13, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "I07a" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_14 = 0

			if var_237_14 < arg_234_1.time_ and arg_234_1.time_ <= var_237_14 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_15 = 2

			if var_237_14 <= arg_234_1.time_ and arg_234_1.time_ < var_237_14 + var_237_15 then
				local var_237_16 = (arg_234_1.time_ - var_237_14) / var_237_15
				local var_237_17 = Color.New(0, 0, 0)

				var_237_17.a = Mathf.Lerp(0, 1, var_237_16)
				arg_234_1.mask_.color = var_237_17
			end

			if arg_234_1.time_ >= var_237_14 + var_237_15 and arg_234_1.time_ < var_237_14 + var_237_15 + arg_237_0 then
				local var_237_18 = Color.New(0, 0, 0)

				var_237_18.a = 1
				arg_234_1.mask_.color = var_237_18
			end

			local var_237_19 = 7.53466666666666

			if var_237_19 < arg_234_1.time_ and arg_234_1.time_ <= var_237_19 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			local var_237_20 = 0.3

			if arg_234_1.time_ >= var_237_19 + var_237_20 and arg_234_1.time_ < var_237_19 + var_237_20 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			local var_237_21 = arg_234_1.actors_["10128"]
			local var_237_22 = 1.96666666666667

			if var_237_22 < arg_234_1.time_ and arg_234_1.time_ <= var_237_22 + arg_237_0 and not isNil(var_237_21) and arg_234_1.var_.actorSpriteComps10128 == nil then
				arg_234_1.var_.actorSpriteComps10128 = var_237_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_23 = 0.2

			if var_237_22 <= arg_234_1.time_ and arg_234_1.time_ < var_237_22 + var_237_23 and not isNil(var_237_21) then
				local var_237_24 = (arg_234_1.time_ - var_237_22) / var_237_23

				if arg_234_1.var_.actorSpriteComps10128 then
					for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_237_3 then
							if arg_234_1.isInRecall_ then
								local var_237_25 = Mathf.Lerp(iter_237_3.color.r, arg_234_1.hightColor2.r, var_237_24)
								local var_237_26 = Mathf.Lerp(iter_237_3.color.g, arg_234_1.hightColor2.g, var_237_24)
								local var_237_27 = Mathf.Lerp(iter_237_3.color.b, arg_234_1.hightColor2.b, var_237_24)

								iter_237_3.color = Color.New(var_237_25, var_237_26, var_237_27)
							else
								local var_237_28 = Mathf.Lerp(iter_237_3.color.r, 0.5, var_237_24)

								iter_237_3.color = Color.New(var_237_28, var_237_28, var_237_28)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_22 + var_237_23 and arg_234_1.time_ < var_237_22 + var_237_23 + arg_237_0 and not isNil(var_237_21) and arg_234_1.var_.actorSpriteComps10128 then
				for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_237_5 then
						if arg_234_1.isInRecall_ then
							iter_237_5.color = arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_237_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps10128 = nil
			end

			local var_237_29 = arg_234_1.actors_["10128"].transform
			local var_237_30 = 1.96666666666667

			if var_237_30 < arg_234_1.time_ and arg_234_1.time_ <= var_237_30 + arg_237_0 then
				arg_234_1.var_.moveOldPos10128 = var_237_29.localPosition
				var_237_29.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10128", 7)

				local var_237_31 = var_237_29.childCount

				for iter_237_6 = 0, var_237_31 - 1 do
					local var_237_32 = var_237_29:GetChild(iter_237_6)

					if var_237_32.name == "" or not string.find(var_237_32.name, "split") then
						var_237_32.gameObject:SetActive(true)
					else
						var_237_32.gameObject:SetActive(false)
					end
				end
			end

			local var_237_33 = 0.001

			if var_237_30 <= arg_234_1.time_ and arg_234_1.time_ < var_237_30 + var_237_33 then
				local var_237_34 = (arg_234_1.time_ - var_237_30) / var_237_33
				local var_237_35 = Vector3.New(0, -2000, -300)

				var_237_29.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10128, var_237_35, var_237_34)
			end

			if arg_234_1.time_ >= var_237_30 + var_237_33 and arg_234_1.time_ < var_237_30 + var_237_33 + arg_237_0 then
				var_237_29.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_237_36 = 0
			local var_237_37 = 0.2

			if var_237_36 < arg_234_1.time_ and arg_234_1.time_ <= var_237_36 + arg_237_0 then
				local var_237_38 = "play"
				local var_237_39 = "music"

				arg_234_1:AudioAction(var_237_38, var_237_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_237_40 = ""
				local var_237_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_237_41 ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_41 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_41

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_41
						arg_234_1.bgmTxt2_.text = var_237_41
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_237_42 = 1.7
			local var_237_43 = 1

			if var_237_42 < arg_234_1.time_ and arg_234_1.time_ <= var_237_42 + arg_237_0 then
				local var_237_44 = "play"
				local var_237_45 = "music"

				arg_234_1:AudioAction(var_237_44, var_237_45, "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison.awb")

				local var_237_46 = ""
				local var_237_47 = manager.audio:GetAudioName("bgm_activity_3_10_story_prison", "bgm_activity_3_10_story_prison")

				if var_237_47 ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_47 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_47

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_47
						arg_234_1.bgmTxt2_.text = var_237_47
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_237_48 = 7.40066666666666
			local var_237_49 = 1

			if var_237_48 < arg_234_1.time_ and arg_234_1.time_ <= var_237_48 + arg_237_0 then
				local var_237_50 = "play"
				local var_237_51 = "effect"

				arg_234_1:AudioAction(var_237_50, var_237_51, "se_story_1310", "se_story_1310_dooropen", "")
			end

			local var_237_52 = 2.00066666666667

			if var_237_52 < arg_234_1.time_ and arg_234_1.time_ <= var_237_52 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = false

				arg_234_1:SetGaussion(false)
			end

			local var_237_53 = 1

			if var_237_52 <= arg_234_1.time_ and arg_234_1.time_ < var_237_52 + var_237_53 then
				local var_237_54 = (arg_234_1.time_ - var_237_52) / var_237_53
				local var_237_55 = Color.New(0, 0, 0)

				var_237_55.a = Mathf.Lerp(1, 0, var_237_54)
				arg_234_1.mask_.color = var_237_55
			end

			if arg_234_1.time_ >= var_237_52 + var_237_53 and arg_234_1.time_ < var_237_52 + var_237_53 + arg_237_0 then
				local var_237_56 = Color.New(0, 0, 0)
				local var_237_57 = 0

				arg_234_1.mask_.enabled = false
				var_237_56.a = var_237_57
				arg_234_1.mask_.color = var_237_56
			end

			local var_237_58 = 2.00066666666667
			local var_237_59 = 3
			local var_237_60 = "I07a"

			if var_237_58 < arg_234_1.time_ and arg_234_1.time_ <= var_237_58 + arg_237_0 then
				arg_234_1.timestampController_:SetSelectedState("show")
				arg_234_1.timestampAni_:Play("in")

				arg_234_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_237_60)

				arg_234_1.timestampColorController_:SetSelectedState("cold")
				arg_234_1.timeColdImg_:SetAlpha(0.031)

				local var_237_61 = arg_234_1:GetWordFromCfg(501083)
				local var_237_62 = arg_234_1:FormatText(var_237_61.content)

				arg_234_1.text_timeText_.text = var_237_62

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_timeText_)

				local var_237_63 = arg_234_1:GetWordFromCfg(501084)
				local var_237_64 = arg_234_1:FormatText(var_237_63.content)

				arg_234_1.text_siteText_.text = var_237_64

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_siteText_)
			end

			if arg_234_1.time_ >= var_237_58 + var_237_59 and arg_234_1.time_ < var_237_58 + var_237_59 + arg_237_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_234_1.timestampAni_, "out", function()
					arg_234_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_237_65 = 5.00066666666666

			if var_237_65 < arg_234_1.time_ and arg_234_1.time_ <= var_237_65 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_66 = 1.2

			if var_237_65 <= arg_234_1.time_ and arg_234_1.time_ < var_237_65 + var_237_66 then
				local var_237_67 = (arg_234_1.time_ - var_237_65) / var_237_66
				local var_237_68 = Color.New(0, 0, 0)

				var_237_68.a = Mathf.Lerp(0, 1, var_237_67)
				arg_234_1.mask_.color = var_237_68
			end

			if arg_234_1.time_ >= var_237_65 + var_237_66 and arg_234_1.time_ < var_237_65 + var_237_66 + arg_237_0 then
				local var_237_69 = Color.New(0, 0, 0)

				var_237_69.a = 1
				arg_234_1.mask_.color = var_237_69
			end

			local var_237_70 = 6.20066666666666

			if var_237_70 < arg_234_1.time_ and arg_234_1.time_ <= var_237_70 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_71 = 1.2

			if var_237_70 <= arg_234_1.time_ and arg_234_1.time_ < var_237_70 + var_237_71 then
				local var_237_72 = (arg_234_1.time_ - var_237_70) / var_237_71
				local var_237_73 = Color.New(0, 0, 0)

				var_237_73.a = Mathf.Lerp(1, 0, var_237_72)
				arg_234_1.mask_.color = var_237_73
			end

			if arg_234_1.time_ >= var_237_70 + var_237_71 and arg_234_1.time_ < var_237_70 + var_237_71 + arg_237_0 then
				local var_237_74 = Color.New(0, 0, 0)
				local var_237_75 = 0

				arg_234_1.mask_.enabled = false
				var_237_74.a = var_237_75
				arg_234_1.mask_.color = var_237_74
			end

			local var_237_76 = 2.00066666666667

			if var_237_76 < arg_234_1.time_ and arg_234_1.time_ <= var_237_76 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			local var_237_77 = 3

			if arg_234_1.time_ >= var_237_76 + var_237_77 and arg_234_1.time_ < var_237_76 + var_237_77 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_78 = 7.53466666666666
			local var_237_79 = 1.4

			if var_237_78 < arg_234_1.time_ and arg_234_1.time_ <= var_237_78 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_80 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_80:setOnUpdate(LuaHelper.FloatAction(function(arg_241_0)
					arg_234_1.dialogCg_.alpha = arg_241_0
				end))
				var_237_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_81 = arg_234_1:GetWordFromCfg(417111057)
				local var_237_82 = arg_234_1:FormatText(var_237_81.content)

				arg_234_1.text_.text = var_237_82

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_83 = 56
				local var_237_84 = utf8.len(var_237_82)
				local var_237_85 = var_237_83 <= 0 and var_237_79 or var_237_79 * (var_237_84 / var_237_83)

				if var_237_85 > 0 and var_237_79 < var_237_85 then
					arg_234_1.talkMaxDuration = var_237_85
					var_237_78 = var_237_78 + 0.3

					if var_237_85 + var_237_78 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_85 + var_237_78
					end
				end

				arg_234_1.text_.text = var_237_82
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_86 = var_237_78 + 0.3
			local var_237_87 = math.max(var_237_79, arg_234_1.talkMaxDuration)

			if var_237_86 <= arg_234_1.time_ and arg_234_1.time_ < var_237_86 + var_237_87 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_86) / var_237_87

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_86 + var_237_87 and arg_234_1.time_ < var_237_86 + var_237_87 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play417111058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 417111058
		arg_243_1.duration_ = 3.77

		local var_243_0 = {
			zh = 3.766,
			ja = 3.033
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
				arg_243_0:Play417111059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.325

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[1109].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:GetWordFromCfg(417111058)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 13
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111058", "story_v_out_417111.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111058", "story_v_out_417111.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_417111", "417111058", "story_v_out_417111.awb")

						arg_243_1:RecordAudio("417111058", var_246_9)
						arg_243_1:RecordAudio("417111058", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_417111", "417111058", "story_v_out_417111.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_417111", "417111058", "story_v_out_417111.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play417111059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 417111059
		arg_247_1.duration_ = 3.2

		local var_247_0 = {
			zh = 3.2,
			ja = 2.133
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
				arg_247_0:Play417111060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = "10113"

			if arg_247_1.actors_[var_250_0] == nil then
				local var_250_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_250_1) then
					local var_250_2 = Object.Instantiate(var_250_1, arg_247_1.canvasGo_.transform)

					var_250_2.transform:SetSiblingIndex(1)

					var_250_2.name = var_250_0
					var_250_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_247_1.actors_[var_250_0] = var_250_2

					local var_250_3 = var_250_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_247_1.isInRecall_ then
						for iter_250_0, iter_250_1 in ipairs(var_250_3) do
							iter_250_1.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_250_4 = arg_247_1.actors_["10113"]
			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.actorSpriteComps10113 == nil then
				arg_247_1.var_.actorSpriteComps10113 = var_250_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_6 = 0.2

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 and not isNil(var_250_4) then
				local var_250_7 = (arg_247_1.time_ - var_250_5) / var_250_6

				if arg_247_1.var_.actorSpriteComps10113 then
					for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_250_3 then
							if arg_247_1.isInRecall_ then
								local var_250_8 = Mathf.Lerp(iter_250_3.color.r, arg_247_1.hightColor1.r, var_250_7)
								local var_250_9 = Mathf.Lerp(iter_250_3.color.g, arg_247_1.hightColor1.g, var_250_7)
								local var_250_10 = Mathf.Lerp(iter_250_3.color.b, arg_247_1.hightColor1.b, var_250_7)

								iter_250_3.color = Color.New(var_250_8, var_250_9, var_250_10)
							else
								local var_250_11 = Mathf.Lerp(iter_250_3.color.r, 1, var_250_7)

								iter_250_3.color = Color.New(var_250_11, var_250_11, var_250_11)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.actorSpriteComps10113 then
				for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_250_5 then
						if arg_247_1.isInRecall_ then
							iter_250_5.color = arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_250_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10113 = nil
			end

			local var_250_12 = arg_247_1.actors_["1034"]
			local var_250_13 = 0

			if var_250_13 < arg_247_1.time_ and arg_247_1.time_ <= var_250_13 + arg_250_0 and not isNil(var_250_12) and arg_247_1.var_.actorSpriteComps1034 == nil then
				arg_247_1.var_.actorSpriteComps1034 = var_250_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_14 = 0.2

			if var_250_13 <= arg_247_1.time_ and arg_247_1.time_ < var_250_13 + var_250_14 and not isNil(var_250_12) then
				local var_250_15 = (arg_247_1.time_ - var_250_13) / var_250_14

				if arg_247_1.var_.actorSpriteComps1034 then
					for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_250_7 then
							if arg_247_1.isInRecall_ then
								local var_250_16 = Mathf.Lerp(iter_250_7.color.r, arg_247_1.hightColor2.r, var_250_15)
								local var_250_17 = Mathf.Lerp(iter_250_7.color.g, arg_247_1.hightColor2.g, var_250_15)
								local var_250_18 = Mathf.Lerp(iter_250_7.color.b, arg_247_1.hightColor2.b, var_250_15)

								iter_250_7.color = Color.New(var_250_16, var_250_17, var_250_18)
							else
								local var_250_19 = Mathf.Lerp(iter_250_7.color.r, 0.5, var_250_15)

								iter_250_7.color = Color.New(var_250_19, var_250_19, var_250_19)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_13 + var_250_14 and arg_247_1.time_ < var_250_13 + var_250_14 + arg_250_0 and not isNil(var_250_12) and arg_247_1.var_.actorSpriteComps1034 then
				for iter_250_8, iter_250_9 in pairs(arg_247_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_250_9 then
						if arg_247_1.isInRecall_ then
							iter_250_9.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps1034 = nil
			end

			local var_250_20 = arg_247_1.actors_["1034"].transform
			local var_250_21 = 0

			if var_250_21 < arg_247_1.time_ and arg_247_1.time_ <= var_250_21 + arg_250_0 then
				arg_247_1.var_.moveOldPos1034 = var_250_20.localPosition
				var_250_20.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1034", 7)

				local var_250_22 = var_250_20.childCount

				for iter_250_10 = 0, var_250_22 - 1 do
					local var_250_23 = var_250_20:GetChild(iter_250_10)

					if var_250_23.name == "" or not string.find(var_250_23.name, "split") then
						var_250_23.gameObject:SetActive(true)
					else
						var_250_23.gameObject:SetActive(false)
					end
				end
			end

			local var_250_24 = 0.001

			if var_250_21 <= arg_247_1.time_ and arg_247_1.time_ < var_250_21 + var_250_24 then
				local var_250_25 = (arg_247_1.time_ - var_250_21) / var_250_24
				local var_250_26 = Vector3.New(0, -2000, 0)

				var_250_20.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1034, var_250_26, var_250_25)
			end

			if arg_247_1.time_ >= var_250_21 + var_250_24 and arg_247_1.time_ < var_250_21 + var_250_24 + arg_250_0 then
				var_250_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_27 = arg_247_1.actors_["10113"].transform
			local var_250_28 = 0

			if var_250_28 < arg_247_1.time_ and arg_247_1.time_ <= var_250_28 + arg_250_0 then
				arg_247_1.var_.moveOldPos10113 = var_250_27.localPosition
				var_250_27.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10113", 3)

				local var_250_29 = var_250_27.childCount

				for iter_250_11 = 0, var_250_29 - 1 do
					local var_250_30 = var_250_27:GetChild(iter_250_11)

					if var_250_30.name == "" or not string.find(var_250_30.name, "split") then
						var_250_30.gameObject:SetActive(true)
					else
						var_250_30.gameObject:SetActive(false)
					end
				end
			end

			local var_250_31 = 0.001

			if var_250_28 <= arg_247_1.time_ and arg_247_1.time_ < var_250_28 + var_250_31 then
				local var_250_32 = (arg_247_1.time_ - var_250_28) / var_250_31
				local var_250_33 = Vector3.New(-30.38, -328.4, -517.4)

				var_250_27.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10113, var_250_33, var_250_32)
			end

			if arg_247_1.time_ >= var_250_28 + var_250_31 and arg_247_1.time_ < var_250_28 + var_250_31 + arg_250_0 then
				var_250_27.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_250_34 = 0
			local var_250_35 = 0.425

			if var_250_34 < arg_247_1.time_ and arg_247_1.time_ <= var_250_34 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_36 = arg_247_1:FormatText(StoryNameCfg[1117].name)

				arg_247_1.leftNameTxt_.text = var_250_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_37 = arg_247_1:GetWordFromCfg(417111059)
				local var_250_38 = arg_247_1:FormatText(var_250_37.content)

				arg_247_1.text_.text = var_250_38

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_39 = 17
				local var_250_40 = utf8.len(var_250_38)
				local var_250_41 = var_250_39 <= 0 and var_250_35 or var_250_35 * (var_250_40 / var_250_39)

				if var_250_41 > 0 and var_250_35 < var_250_41 then
					arg_247_1.talkMaxDuration = var_250_41

					if var_250_41 + var_250_34 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_41 + var_250_34
					end
				end

				arg_247_1.text_.text = var_250_38
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111059", "story_v_out_417111.awb") ~= 0 then
					local var_250_42 = manager.audio:GetVoiceLength("story_v_out_417111", "417111059", "story_v_out_417111.awb") / 1000

					if var_250_42 + var_250_34 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_42 + var_250_34
					end

					if var_250_37.prefab_name ~= "" and arg_247_1.actors_[var_250_37.prefab_name] ~= nil then
						local var_250_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_37.prefab_name].transform, "story_v_out_417111", "417111059", "story_v_out_417111.awb")

						arg_247_1:RecordAudio("417111059", var_250_43)
						arg_247_1:RecordAudio("417111059", var_250_43)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_417111", "417111059", "story_v_out_417111.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_417111", "417111059", "story_v_out_417111.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_44 = math.max(var_250_35, arg_247_1.talkMaxDuration)

			if var_250_34 <= arg_247_1.time_ and arg_247_1.time_ < var_250_34 + var_250_44 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_34) / var_250_44

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_34 + var_250_44 and arg_247_1.time_ < var_250_34 + var_250_44 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play417111060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 417111060
		arg_251_1.duration_ = 9.43

		local var_251_0 = {
			zh = 5.4,
			ja = 9.433
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
				arg_251_0:Play417111061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1034"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps1034 == nil then
				arg_251_1.var_.actorSpriteComps1034 = var_254_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.actorSpriteComps1034 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								local var_254_4 = Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, var_254_3)
								local var_254_5 = Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, var_254_3)
								local var_254_6 = Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, var_254_3)

								iter_254_1.color = Color.New(var_254_4, var_254_5, var_254_6)
							else
								local var_254_7 = Mathf.Lerp(iter_254_1.color.r, 1, var_254_3)

								iter_254_1.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.actorSpriteComps1034 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_254_3 then
						if arg_251_1.isInRecall_ then
							iter_254_3.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps1034 = nil
			end

			local var_254_8 = arg_251_1.actors_["10113"]
			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps10113 == nil then
				arg_251_1.var_.actorSpriteComps10113 = var_254_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_10 = 0.2

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_10 and not isNil(var_254_8) then
				local var_254_11 = (arg_251_1.time_ - var_254_9) / var_254_10

				if arg_251_1.var_.actorSpriteComps10113 then
					for iter_254_4, iter_254_5 in pairs(arg_251_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_254_5 then
							if arg_251_1.isInRecall_ then
								local var_254_12 = Mathf.Lerp(iter_254_5.color.r, arg_251_1.hightColor2.r, var_254_11)
								local var_254_13 = Mathf.Lerp(iter_254_5.color.g, arg_251_1.hightColor2.g, var_254_11)
								local var_254_14 = Mathf.Lerp(iter_254_5.color.b, arg_251_1.hightColor2.b, var_254_11)

								iter_254_5.color = Color.New(var_254_12, var_254_13, var_254_14)
							else
								local var_254_15 = Mathf.Lerp(iter_254_5.color.r, 0.5, var_254_11)

								iter_254_5.color = Color.New(var_254_15, var_254_15, var_254_15)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_9 + var_254_10 and arg_251_1.time_ < var_254_9 + var_254_10 + arg_254_0 and not isNil(var_254_8) and arg_251_1.var_.actorSpriteComps10113 then
				for iter_254_6, iter_254_7 in pairs(arg_251_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_254_7 then
						if arg_251_1.isInRecall_ then
							iter_254_7.color = arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_254_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10113 = nil
			end

			local var_254_16 = arg_251_1.actors_["1034"].transform
			local var_254_17 = 0

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				arg_251_1.var_.moveOldPos1034 = var_254_16.localPosition
				var_254_16.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1034", 2)

				local var_254_18 = var_254_16.childCount

				for iter_254_8 = 0, var_254_18 - 1 do
					local var_254_19 = var_254_16:GetChild(iter_254_8)

					if var_254_19.name == "" or not string.find(var_254_19.name, "split") then
						var_254_19.gameObject:SetActive(true)
					else
						var_254_19.gameObject:SetActive(false)
					end
				end
			end

			local var_254_20 = 0.001

			if var_254_17 <= arg_251_1.time_ and arg_251_1.time_ < var_254_17 + var_254_20 then
				local var_254_21 = (arg_251_1.time_ - var_254_17) / var_254_20
				local var_254_22 = Vector3.New(-390, -331.9, -324)

				var_254_16.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1034, var_254_22, var_254_21)
			end

			if arg_251_1.time_ >= var_254_17 + var_254_20 and arg_251_1.time_ < var_254_17 + var_254_20 + arg_254_0 then
				var_254_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_254_23 = arg_251_1.actors_["10113"].transform
			local var_254_24 = 0

			if var_254_24 < arg_251_1.time_ and arg_251_1.time_ <= var_254_24 + arg_254_0 then
				arg_251_1.var_.moveOldPos10113 = var_254_23.localPosition
				var_254_23.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10113", 4)

				local var_254_25 = var_254_23.childCount

				for iter_254_9 = 0, var_254_25 - 1 do
					local var_254_26 = var_254_23:GetChild(iter_254_9)

					if var_254_26.name == "" or not string.find(var_254_26.name, "split") then
						var_254_26.gameObject:SetActive(true)
					else
						var_254_26.gameObject:SetActive(false)
					end
				end
			end

			local var_254_27 = 0.001

			if var_254_24 <= arg_251_1.time_ and arg_251_1.time_ < var_254_24 + var_254_27 then
				local var_254_28 = (arg_251_1.time_ - var_254_24) / var_254_27
				local var_254_29 = Vector3.New(377.3, -328.4, -517.4)

				var_254_23.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10113, var_254_29, var_254_28)
			end

			if arg_251_1.time_ >= var_254_24 + var_254_27 and arg_251_1.time_ < var_254_24 + var_254_27 + arg_254_0 then
				var_254_23.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_254_30 = 0
			local var_254_31 = 0.475

			if var_254_30 < arg_251_1.time_ and arg_251_1.time_ <= var_254_30 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_32 = arg_251_1:FormatText(StoryNameCfg[1109].name)

				arg_251_1.leftNameTxt_.text = var_254_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_33 = arg_251_1:GetWordFromCfg(417111060)
				local var_254_34 = arg_251_1:FormatText(var_254_33.content)

				arg_251_1.text_.text = var_254_34

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_35 = 19
				local var_254_36 = utf8.len(var_254_34)
				local var_254_37 = var_254_35 <= 0 and var_254_31 or var_254_31 * (var_254_36 / var_254_35)

				if var_254_37 > 0 and var_254_31 < var_254_37 then
					arg_251_1.talkMaxDuration = var_254_37

					if var_254_37 + var_254_30 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_37 + var_254_30
					end
				end

				arg_251_1.text_.text = var_254_34
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111060", "story_v_out_417111.awb") ~= 0 then
					local var_254_38 = manager.audio:GetVoiceLength("story_v_out_417111", "417111060", "story_v_out_417111.awb") / 1000

					if var_254_38 + var_254_30 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_38 + var_254_30
					end

					if var_254_33.prefab_name ~= "" and arg_251_1.actors_[var_254_33.prefab_name] ~= nil then
						local var_254_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_33.prefab_name].transform, "story_v_out_417111", "417111060", "story_v_out_417111.awb")

						arg_251_1:RecordAudio("417111060", var_254_39)
						arg_251_1:RecordAudio("417111060", var_254_39)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_417111", "417111060", "story_v_out_417111.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_417111", "417111060", "story_v_out_417111.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_40 = math.max(var_254_31, arg_251_1.talkMaxDuration)

			if var_254_30 <= arg_251_1.time_ and arg_251_1.time_ < var_254_30 + var_254_40 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_30) / var_254_40

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_30 + var_254_40 and arg_251_1.time_ < var_254_30 + var_254_40 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play417111061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 417111061
		arg_255_1.duration_ = 9.87

		local var_255_0 = {
			zh = 7.466,
			ja = 9.866
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
				arg_255_0:Play417111062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10113"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10113 == nil then
				arg_255_1.var_.actorSpriteComps10113 = var_258_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.actorSpriteComps10113 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								local var_258_4 = Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, var_258_3)
								local var_258_5 = Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, var_258_3)
								local var_258_6 = Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, var_258_3)

								iter_258_1.color = Color.New(var_258_4, var_258_5, var_258_6)
							else
								local var_258_7 = Mathf.Lerp(iter_258_1.color.r, 1, var_258_3)

								iter_258_1.color = Color.New(var_258_7, var_258_7, var_258_7)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.actorSpriteComps10113 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_258_3 then
						if arg_255_1.isInRecall_ then
							iter_258_3.color = arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_258_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps10113 = nil
			end

			local var_258_8 = arg_255_1.actors_["1034"]
			local var_258_9 = 0

			if var_258_9 < arg_255_1.time_ and arg_255_1.time_ <= var_258_9 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps1034 == nil then
				arg_255_1.var_.actorSpriteComps1034 = var_258_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_10 = 0.2

			if var_258_9 <= arg_255_1.time_ and arg_255_1.time_ < var_258_9 + var_258_10 and not isNil(var_258_8) then
				local var_258_11 = (arg_255_1.time_ - var_258_9) / var_258_10

				if arg_255_1.var_.actorSpriteComps1034 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								local var_258_12 = Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor2.r, var_258_11)
								local var_258_13 = Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor2.g, var_258_11)
								local var_258_14 = Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor2.b, var_258_11)

								iter_258_5.color = Color.New(var_258_12, var_258_13, var_258_14)
							else
								local var_258_15 = Mathf.Lerp(iter_258_5.color.r, 0.5, var_258_11)

								iter_258_5.color = Color.New(var_258_15, var_258_15, var_258_15)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= var_258_9 + var_258_10 and arg_255_1.time_ < var_258_9 + var_258_10 + arg_258_0 and not isNil(var_258_8) and arg_255_1.var_.actorSpriteComps1034 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_258_7 then
						if arg_255_1.isInRecall_ then
							iter_258_7.color = arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_258_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_255_1.var_.actorSpriteComps1034 = nil
			end

			local var_258_16 = 0
			local var_258_17 = 1.025

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_18 = arg_255_1:FormatText(StoryNameCfg[1117].name)

				arg_255_1.leftNameTxt_.text = var_258_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_19 = arg_255_1:GetWordFromCfg(417111061)
				local var_258_20 = arg_255_1:FormatText(var_258_19.content)

				arg_255_1.text_.text = var_258_20

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_21 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111061", "story_v_out_417111.awb") ~= 0 then
					local var_258_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111061", "story_v_out_417111.awb") / 1000

					if var_258_24 + var_258_16 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_24 + var_258_16
					end

					if var_258_19.prefab_name ~= "" and arg_255_1.actors_[var_258_19.prefab_name] ~= nil then
						local var_258_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_19.prefab_name].transform, "story_v_out_417111", "417111061", "story_v_out_417111.awb")

						arg_255_1:RecordAudio("417111061", var_258_25)
						arg_255_1:RecordAudio("417111061", var_258_25)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_417111", "417111061", "story_v_out_417111.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_417111", "417111061", "story_v_out_417111.awb")
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
	Play417111062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 417111062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play417111063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10113"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10113 == nil then
				arg_259_1.var_.actorSpriteComps10113 = var_262_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.actorSpriteComps10113 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								local var_262_4 = Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor2.r, var_262_3)
								local var_262_5 = Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor2.g, var_262_3)
								local var_262_6 = Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor2.b, var_262_3)

								iter_262_1.color = Color.New(var_262_4, var_262_5, var_262_6)
							else
								local var_262_7 = Mathf.Lerp(iter_262_1.color.r, 0.5, var_262_3)

								iter_262_1.color = Color.New(var_262_7, var_262_7, var_262_7)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.actorSpriteComps10113 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_262_3 then
						if arg_259_1.isInRecall_ then
							iter_262_3.color = arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_262_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_259_1.var_.actorSpriteComps10113 = nil
			end

			local var_262_8 = 0
			local var_262_9 = 1.5

			if var_262_8 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_10 = arg_259_1:GetWordFromCfg(417111062)
				local var_262_11 = arg_259_1:FormatText(var_262_10.content)

				arg_259_1.text_.text = var_262_11

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_12 = 60
				local var_262_13 = utf8.len(var_262_11)
				local var_262_14 = var_262_12 <= 0 and var_262_9 or var_262_9 * (var_262_13 / var_262_12)

				if var_262_14 > 0 and var_262_9 < var_262_14 then
					arg_259_1.talkMaxDuration = var_262_14

					if var_262_14 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_11
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_15 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_15 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_8) / var_262_15

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_8 + var_262_15 and arg_259_1.time_ < var_262_8 + var_262_15 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play417111063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 417111063
		arg_263_1.duration_ = 4.03

		local var_263_0 = {
			zh = 2.766,
			ja = 4.033
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
				arg_263_0:Play417111064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1034"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1034 == nil then
				arg_263_1.var_.actorSpriteComps1034 = var_266_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.actorSpriteComps1034 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.actorSpriteComps1034 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_266_3 then
						if arg_263_1.isInRecall_ then
							iter_266_3.color = arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_266_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_263_1.var_.actorSpriteComps1034 = nil
			end

			local var_266_8 = arg_263_1.actors_["1034"].transform
			local var_266_9 = 0

			if var_266_9 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.var_.moveOldPos1034 = var_266_8.localPosition
				var_266_8.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("1034", 2)

				local var_266_10 = var_266_8.childCount

				for iter_266_4 = 0, var_266_10 - 1 do
					local var_266_11 = var_266_8:GetChild(iter_266_4)

					if var_266_11.name == "" or not string.find(var_266_11.name, "split") then
						var_266_11.gameObject:SetActive(true)
					else
						var_266_11.gameObject:SetActive(false)
					end
				end
			end

			local var_266_12 = 0.001

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_12 then
				local var_266_13 = (arg_263_1.time_ - var_266_9) / var_266_12
				local var_266_14 = Vector3.New(-390, -331.9, -324)

				var_266_8.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1034, var_266_14, var_266_13)
			end

			if arg_263_1.time_ >= var_266_9 + var_266_12 and arg_263_1.time_ < var_266_9 + var_266_12 + arg_266_0 then
				var_266_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_266_15 = 0
			local var_266_16 = 0.3

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[1109].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(417111063)
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111063", "story_v_out_417111.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111063", "story_v_out_417111.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_out_417111", "417111063", "story_v_out_417111.awb")

						arg_263_1:RecordAudio("417111063", var_266_24)
						arg_263_1:RecordAudio("417111063", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_417111", "417111063", "story_v_out_417111.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_417111", "417111063", "story_v_out_417111.awb")
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
				actorName = "1034",
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
	Play417111064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 417111064
		arg_267_1.duration_ = 6.73

		local var_267_0 = {
			zh = 5.666,
			ja = 6.733
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
				arg_267_0:Play417111065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10113"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10113 == nil then
				arg_267_1.var_.actorSpriteComps10113 = var_270_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_2 = 0.2

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 and not isNil(var_270_0) then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.actorSpriteComps10113 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								local var_270_4 = Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, var_270_3)
								local var_270_5 = Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, var_270_3)
								local var_270_6 = Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, var_270_3)

								iter_270_1.color = Color.New(var_270_4, var_270_5, var_270_6)
							else
								local var_270_7 = Mathf.Lerp(iter_270_1.color.r, 1, var_270_3)

								iter_270_1.color = Color.New(var_270_7, var_270_7, var_270_7)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and not isNil(var_270_0) and arg_267_1.var_.actorSpriteComps10113 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_270_3 then
						if arg_267_1.isInRecall_ then
							iter_270_3.color = arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_270_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps10113 = nil
			end

			local var_270_8 = arg_267_1.actors_["1034"]
			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 and not isNil(var_270_8) and arg_267_1.var_.actorSpriteComps1034 == nil then
				arg_267_1.var_.actorSpriteComps1034 = var_270_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_10 = 0.2

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_10 and not isNil(var_270_8) then
				local var_270_11 = (arg_267_1.time_ - var_270_9) / var_270_10

				if arg_267_1.var_.actorSpriteComps1034 then
					for iter_270_4, iter_270_5 in pairs(arg_267_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_270_5 then
							if arg_267_1.isInRecall_ then
								local var_270_12 = Mathf.Lerp(iter_270_5.color.r, arg_267_1.hightColor2.r, var_270_11)
								local var_270_13 = Mathf.Lerp(iter_270_5.color.g, arg_267_1.hightColor2.g, var_270_11)
								local var_270_14 = Mathf.Lerp(iter_270_5.color.b, arg_267_1.hightColor2.b, var_270_11)

								iter_270_5.color = Color.New(var_270_12, var_270_13, var_270_14)
							else
								local var_270_15 = Mathf.Lerp(iter_270_5.color.r, 0.5, var_270_11)

								iter_270_5.color = Color.New(var_270_15, var_270_15, var_270_15)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 and not isNil(var_270_8) and arg_267_1.var_.actorSpriteComps1034 then
				for iter_270_6, iter_270_7 in pairs(arg_267_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_270_7 then
						if arg_267_1.isInRecall_ then
							iter_270_7.color = arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_270_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_267_1.var_.actorSpriteComps1034 = nil
			end

			local var_270_16 = 0
			local var_270_17 = 0.725

			if var_270_16 < arg_267_1.time_ and arg_267_1.time_ <= var_270_16 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_18 = arg_267_1:FormatText(StoryNameCfg[1117].name)

				arg_267_1.leftNameTxt_.text = var_270_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_19 = arg_267_1:GetWordFromCfg(417111064)
				local var_270_20 = arg_267_1:FormatText(var_270_19.content)

				arg_267_1.text_.text = var_270_20

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_21 = 29
				local var_270_22 = utf8.len(var_270_20)
				local var_270_23 = var_270_21 <= 0 and var_270_17 or var_270_17 * (var_270_22 / var_270_21)

				if var_270_23 > 0 and var_270_17 < var_270_23 then
					arg_267_1.talkMaxDuration = var_270_23

					if var_270_23 + var_270_16 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_23 + var_270_16
					end
				end

				arg_267_1.text_.text = var_270_20
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111064", "story_v_out_417111.awb") ~= 0 then
					local var_270_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111064", "story_v_out_417111.awb") / 1000

					if var_270_24 + var_270_16 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_24 + var_270_16
					end

					if var_270_19.prefab_name ~= "" and arg_267_1.actors_[var_270_19.prefab_name] ~= nil then
						local var_270_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_19.prefab_name].transform, "story_v_out_417111", "417111064", "story_v_out_417111.awb")

						arg_267_1:RecordAudio("417111064", var_270_25)
						arg_267_1:RecordAudio("417111064", var_270_25)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_417111", "417111064", "story_v_out_417111.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_417111", "417111064", "story_v_out_417111.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_26 = math.max(var_270_17, arg_267_1.talkMaxDuration)

			if var_270_16 <= arg_267_1.time_ and arg_267_1.time_ < var_270_16 + var_270_26 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_16) / var_270_26

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_16 + var_270_26 and arg_267_1.time_ < var_270_16 + var_270_26 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play417111065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 417111065
		arg_271_1.duration_ = 11.1

		local var_271_0 = {
			zh = 9.433,
			ja = 11.1
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
				arg_271_0:Play417111066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1034"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1034 == nil then
				arg_271_1.var_.actorSpriteComps1034 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps1034 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1034 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1034 = nil
			end

			local var_274_8 = arg_271_1.actors_["10113"]
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps10113 == nil then
				arg_271_1.var_.actorSpriteComps10113 = var_274_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_10 = 0.2

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_10 and not isNil(var_274_8) then
				local var_274_11 = (arg_271_1.time_ - var_274_9) / var_274_10

				if arg_271_1.var_.actorSpriteComps10113 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_271_1.time_ >= var_274_9 + var_274_10 and arg_271_1.time_ < var_274_9 + var_274_10 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps10113 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_274_7 then
						if arg_271_1.isInRecall_ then
							iter_274_7.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps10113 = nil
			end

			local var_274_16 = 0
			local var_274_17 = 1.125

			if var_274_16 < arg_271_1.time_ and arg_271_1.time_ <= var_274_16 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_18 = arg_271_1:FormatText(StoryNameCfg[1109].name)

				arg_271_1.leftNameTxt_.text = var_274_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_19 = arg_271_1:GetWordFromCfg(417111065)
				local var_274_20 = arg_271_1:FormatText(var_274_19.content)

				arg_271_1.text_.text = var_274_20

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_21 = 44
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111065", "story_v_out_417111.awb") ~= 0 then
					local var_274_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111065", "story_v_out_417111.awb") / 1000

					if var_274_24 + var_274_16 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_24 + var_274_16
					end

					if var_274_19.prefab_name ~= "" and arg_271_1.actors_[var_274_19.prefab_name] ~= nil then
						local var_274_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_19.prefab_name].transform, "story_v_out_417111", "417111065", "story_v_out_417111.awb")

						arg_271_1:RecordAudio("417111065", var_274_25)
						arg_271_1:RecordAudio("417111065", var_274_25)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_417111", "417111065", "story_v_out_417111.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_417111", "417111065", "story_v_out_417111.awb")
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
	Play417111066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 417111066
		arg_275_1.duration_ = 13.5

		local var_275_0 = {
			zh = 9.7,
			ja = 13.5
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
				arg_275_0:Play417111067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["10113"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10113 == nil then
				arg_275_1.var_.actorSpriteComps10113 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps10113 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								local var_278_4 = Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, var_278_3)
								local var_278_5 = Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, var_278_3)
								local var_278_6 = Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, var_278_3)

								iter_278_1.color = Color.New(var_278_4, var_278_5, var_278_6)
							else
								local var_278_7 = Mathf.Lerp(iter_278_1.color.r, 1, var_278_3)

								iter_278_1.color = Color.New(var_278_7, var_278_7, var_278_7)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps10113 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_278_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps10113 = nil
			end

			local var_278_8 = arg_275_1.actors_["1034"]
			local var_278_9 = 0

			if var_278_9 < arg_275_1.time_ and arg_275_1.time_ <= var_278_9 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps1034 == nil then
				arg_275_1.var_.actorSpriteComps1034 = var_278_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_10 = 0.2

			if var_278_9 <= arg_275_1.time_ and arg_275_1.time_ < var_278_9 + var_278_10 and not isNil(var_278_8) then
				local var_278_11 = (arg_275_1.time_ - var_278_9) / var_278_10

				if arg_275_1.var_.actorSpriteComps1034 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_278_5 then
							if arg_275_1.isInRecall_ then
								local var_278_12 = Mathf.Lerp(iter_278_5.color.r, arg_275_1.hightColor2.r, var_278_11)
								local var_278_13 = Mathf.Lerp(iter_278_5.color.g, arg_275_1.hightColor2.g, var_278_11)
								local var_278_14 = Mathf.Lerp(iter_278_5.color.b, arg_275_1.hightColor2.b, var_278_11)

								iter_278_5.color = Color.New(var_278_12, var_278_13, var_278_14)
							else
								local var_278_15 = Mathf.Lerp(iter_278_5.color.r, 0.5, var_278_11)

								iter_278_5.color = Color.New(var_278_15, var_278_15, var_278_15)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= var_278_9 + var_278_10 and arg_275_1.time_ < var_278_9 + var_278_10 + arg_278_0 and not isNil(var_278_8) and arg_275_1.var_.actorSpriteComps1034 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_278_7 then
						if arg_275_1.isInRecall_ then
							iter_278_7.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1034 = nil
			end

			local var_278_16 = 0
			local var_278_17 = 1.15

			if var_278_16 < arg_275_1.time_ and arg_275_1.time_ <= var_278_16 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_18 = arg_275_1:FormatText(StoryNameCfg[1117].name)

				arg_275_1.leftNameTxt_.text = var_278_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_19 = arg_275_1:GetWordFromCfg(417111066)
				local var_278_20 = arg_275_1:FormatText(var_278_19.content)

				arg_275_1.text_.text = var_278_20

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_21 = 46
				local var_278_22 = utf8.len(var_278_20)
				local var_278_23 = var_278_21 <= 0 and var_278_17 or var_278_17 * (var_278_22 / var_278_21)

				if var_278_23 > 0 and var_278_17 < var_278_23 then
					arg_275_1.talkMaxDuration = var_278_23

					if var_278_23 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_23 + var_278_16
					end
				end

				arg_275_1.text_.text = var_278_20
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111066", "story_v_out_417111.awb") ~= 0 then
					local var_278_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111066", "story_v_out_417111.awb") / 1000

					if var_278_24 + var_278_16 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_24 + var_278_16
					end

					if var_278_19.prefab_name ~= "" and arg_275_1.actors_[var_278_19.prefab_name] ~= nil then
						local var_278_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_19.prefab_name].transform, "story_v_out_417111", "417111066", "story_v_out_417111.awb")

						arg_275_1:RecordAudio("417111066", var_278_25)
						arg_275_1:RecordAudio("417111066", var_278_25)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_417111", "417111066", "story_v_out_417111.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_417111", "417111066", "story_v_out_417111.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_26 = math.max(var_278_17, arg_275_1.talkMaxDuration)

			if var_278_16 <= arg_275_1.time_ and arg_275_1.time_ < var_278_16 + var_278_26 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_16) / var_278_26

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_16 + var_278_26 and arg_275_1.time_ < var_278_16 + var_278_26 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play417111067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 417111067
		arg_279_1.duration_ = 6.1

		local var_279_0 = {
			zh = 3.6,
			ja = 6.1
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
				arg_279_0:Play417111068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1034"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1034 == nil then
				arg_279_1.var_.actorSpriteComps1034 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps1034 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								local var_282_4 = Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor1.r, var_282_3)
								local var_282_5 = Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor1.g, var_282_3)
								local var_282_6 = Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor1.b, var_282_3)

								iter_282_1.color = Color.New(var_282_4, var_282_5, var_282_6)
							else
								local var_282_7 = Mathf.Lerp(iter_282_1.color.r, 1, var_282_3)

								iter_282_1.color = Color.New(var_282_7, var_282_7, var_282_7)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1034 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1034 = nil
			end

			local var_282_8 = arg_279_1.actors_["10113"]
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps10113 == nil then
				arg_279_1.var_.actorSpriteComps10113 = var_282_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_10 = 0.2

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_10 and not isNil(var_282_8) then
				local var_282_11 = (arg_279_1.time_ - var_282_9) / var_282_10

				if arg_279_1.var_.actorSpriteComps10113 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_282_5 then
							if arg_279_1.isInRecall_ then
								local var_282_12 = Mathf.Lerp(iter_282_5.color.r, arg_279_1.hightColor2.r, var_282_11)
								local var_282_13 = Mathf.Lerp(iter_282_5.color.g, arg_279_1.hightColor2.g, var_282_11)
								local var_282_14 = Mathf.Lerp(iter_282_5.color.b, arg_279_1.hightColor2.b, var_282_11)

								iter_282_5.color = Color.New(var_282_12, var_282_13, var_282_14)
							else
								local var_282_15 = Mathf.Lerp(iter_282_5.color.r, 0.5, var_282_11)

								iter_282_5.color = Color.New(var_282_15, var_282_15, var_282_15)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= var_282_9 + var_282_10 and arg_279_1.time_ < var_282_9 + var_282_10 + arg_282_0 and not isNil(var_282_8) and arg_279_1.var_.actorSpriteComps10113 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_282_7 then
						if arg_279_1.isInRecall_ then
							iter_282_7.color = arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_282_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps10113 = nil
			end

			local var_282_16 = arg_279_1.actors_["1034"].transform
			local var_282_17 = 0

			if var_282_17 < arg_279_1.time_ and arg_279_1.time_ <= var_282_17 + arg_282_0 then
				arg_279_1.var_.moveOldPos1034 = var_282_16.localPosition
				var_282_16.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1034", 2)

				local var_282_18 = var_282_16.childCount

				for iter_282_8 = 0, var_282_18 - 1 do
					local var_282_19 = var_282_16:GetChild(iter_282_8)

					if var_282_19.name == "split_6" or not string.find(var_282_19.name, "split") then
						var_282_19.gameObject:SetActive(true)
					else
						var_282_19.gameObject:SetActive(false)
					end
				end
			end

			local var_282_20 = 0.001

			if var_282_17 <= arg_279_1.time_ and arg_279_1.time_ < var_282_17 + var_282_20 then
				local var_282_21 = (arg_279_1.time_ - var_282_17) / var_282_20
				local var_282_22 = Vector3.New(-390, -331.9, -324)

				var_282_16.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1034, var_282_22, var_282_21)
			end

			if arg_279_1.time_ >= var_282_17 + var_282_20 and arg_279_1.time_ < var_282_17 + var_282_20 + arg_282_0 then
				var_282_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_282_23 = 0
			local var_282_24 = 0.45

			if var_282_23 < arg_279_1.time_ and arg_279_1.time_ <= var_282_23 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_25 = arg_279_1:FormatText(StoryNameCfg[1109].name)

				arg_279_1.leftNameTxt_.text = var_282_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_26 = arg_279_1:GetWordFromCfg(417111067)
				local var_282_27 = arg_279_1:FormatText(var_282_26.content)

				arg_279_1.text_.text = var_282_27

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_28 = 18
				local var_282_29 = utf8.len(var_282_27)
				local var_282_30 = var_282_28 <= 0 and var_282_24 or var_282_24 * (var_282_29 / var_282_28)

				if var_282_30 > 0 and var_282_24 < var_282_30 then
					arg_279_1.talkMaxDuration = var_282_30

					if var_282_30 + var_282_23 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_30 + var_282_23
					end
				end

				arg_279_1.text_.text = var_282_27
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111067", "story_v_out_417111.awb") ~= 0 then
					local var_282_31 = manager.audio:GetVoiceLength("story_v_out_417111", "417111067", "story_v_out_417111.awb") / 1000

					if var_282_31 + var_282_23 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_31 + var_282_23
					end

					if var_282_26.prefab_name ~= "" and arg_279_1.actors_[var_282_26.prefab_name] ~= nil then
						local var_282_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_26.prefab_name].transform, "story_v_out_417111", "417111067", "story_v_out_417111.awb")

						arg_279_1:RecordAudio("417111067", var_282_32)
						arg_279_1:RecordAudio("417111067", var_282_32)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_417111", "417111067", "story_v_out_417111.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_417111", "417111067", "story_v_out_417111.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_33 = math.max(var_282_24, arg_279_1.talkMaxDuration)

			if var_282_23 <= arg_279_1.time_ and arg_279_1.time_ < var_282_23 + var_282_33 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_23) / var_282_33

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_23 + var_282_33 and arg_279_1.time_ < var_282_23 + var_282_33 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play417111068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 417111068
		arg_283_1.duration_ = 3.47

		local var_283_0 = {
			zh = 3.266,
			ja = 3.466
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
				arg_283_0:Play417111069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10113"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10113 == nil then
				arg_283_1.var_.actorSpriteComps10113 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps10113 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps10113 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_286_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps10113 = nil
			end

			local var_286_8 = arg_283_1.actors_["1034"]
			local var_286_9 = 0

			if var_286_9 < arg_283_1.time_ and arg_283_1.time_ <= var_286_9 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.actorSpriteComps1034 == nil then
				arg_283_1.var_.actorSpriteComps1034 = var_286_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_10 = 0.2

			if var_286_9 <= arg_283_1.time_ and arg_283_1.time_ < var_286_9 + var_286_10 and not isNil(var_286_8) then
				local var_286_11 = (arg_283_1.time_ - var_286_9) / var_286_10

				if arg_283_1.var_.actorSpriteComps1034 then
					for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_283_1.time_ >= var_286_9 + var_286_10 and arg_283_1.time_ < var_286_9 + var_286_10 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.actorSpriteComps1034 then
				for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_286_7 then
						if arg_283_1.isInRecall_ then
							iter_286_7.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps1034 = nil
			end

			local var_286_16 = arg_283_1.actors_["10113"].transform
			local var_286_17 = 0

			if var_286_17 < arg_283_1.time_ and arg_283_1.time_ <= var_286_17 + arg_286_0 then
				arg_283_1.var_.moveOldPos10113 = var_286_16.localPosition
				var_286_16.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10113", 4)

				local var_286_18 = var_286_16.childCount

				for iter_286_8 = 0, var_286_18 - 1 do
					local var_286_19 = var_286_16:GetChild(iter_286_8)

					if var_286_19.name == "split_6" or not string.find(var_286_19.name, "split") then
						var_286_19.gameObject:SetActive(true)
					else
						var_286_19.gameObject:SetActive(false)
					end
				end
			end

			local var_286_20 = 0.001

			if var_286_17 <= arg_283_1.time_ and arg_283_1.time_ < var_286_17 + var_286_20 then
				local var_286_21 = (arg_283_1.time_ - var_286_17) / var_286_20
				local var_286_22 = Vector3.New(377.3, -328.4, -517.4)

				var_286_16.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10113, var_286_22, var_286_21)
			end

			if arg_283_1.time_ >= var_286_17 + var_286_20 and arg_283_1.time_ < var_286_17 + var_286_20 + arg_286_0 then
				var_286_16.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_286_23 = 0
			local var_286_24 = 0.4

			if var_286_23 < arg_283_1.time_ and arg_283_1.time_ <= var_286_23 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_25 = arg_283_1:FormatText(StoryNameCfg[1117].name)

				arg_283_1.leftNameTxt_.text = var_286_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_26 = arg_283_1:GetWordFromCfg(417111068)
				local var_286_27 = arg_283_1:FormatText(var_286_26.content)

				arg_283_1.text_.text = var_286_27

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_28 = 16
				local var_286_29 = utf8.len(var_286_27)
				local var_286_30 = var_286_28 <= 0 and var_286_24 or var_286_24 * (var_286_29 / var_286_28)

				if var_286_30 > 0 and var_286_24 < var_286_30 then
					arg_283_1.talkMaxDuration = var_286_30

					if var_286_30 + var_286_23 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_30 + var_286_23
					end
				end

				arg_283_1.text_.text = var_286_27
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111068", "story_v_out_417111.awb") ~= 0 then
					local var_286_31 = manager.audio:GetVoiceLength("story_v_out_417111", "417111068", "story_v_out_417111.awb") / 1000

					if var_286_31 + var_286_23 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_31 + var_286_23
					end

					if var_286_26.prefab_name ~= "" and arg_283_1.actors_[var_286_26.prefab_name] ~= nil then
						local var_286_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_26.prefab_name].transform, "story_v_out_417111", "417111068", "story_v_out_417111.awb")

						arg_283_1:RecordAudio("417111068", var_286_32)
						arg_283_1:RecordAudio("417111068", var_286_32)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_417111", "417111068", "story_v_out_417111.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_417111", "417111068", "story_v_out_417111.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_33 = math.max(var_286_24, arg_283_1.talkMaxDuration)

			if var_286_23 <= arg_283_1.time_ and arg_283_1.time_ < var_286_23 + var_286_33 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_23) / var_286_33

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_23 + var_286_33 and arg_283_1.time_ < var_286_23 + var_286_33 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play417111069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 417111069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play417111070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["10113"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10113 == nil then
				arg_287_1.var_.actorSpriteComps10113 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps10113 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_290_1 then
							if arg_287_1.isInRecall_ then
								local var_290_4 = Mathf.Lerp(iter_290_1.color.r, arg_287_1.hightColor2.r, var_290_3)
								local var_290_5 = Mathf.Lerp(iter_290_1.color.g, arg_287_1.hightColor2.g, var_290_3)
								local var_290_6 = Mathf.Lerp(iter_290_1.color.b, arg_287_1.hightColor2.b, var_290_3)

								iter_290_1.color = Color.New(var_290_4, var_290_5, var_290_6)
							else
								local var_290_7 = Mathf.Lerp(iter_290_1.color.r, 0.5, var_290_3)

								iter_290_1.color = Color.New(var_290_7, var_290_7, var_290_7)
							end
						end
					end
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps10113 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_290_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps10113 = nil
			end

			local var_290_8 = arg_287_1.actors_["1034"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos1034 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1034", 2)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "split_6" or not string.find(var_290_11.name, "split") then
						var_290_11.gameObject:SetActive(true)
					else
						var_290_11.gameObject:SetActive(false)
					end
				end
			end

			local var_290_12 = 0.001

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(-390, -331.9, -324)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1034, var_290_14, var_290_13)
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_290_15 = 0
			local var_290_16 = 0.825

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_17 = arg_287_1:GetWordFromCfg(417111069)
				local var_290_18 = arg_287_1:FormatText(var_290_17.content)

				arg_287_1.text_.text = var_290_18

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_19 = 33
				local var_290_20 = utf8.len(var_290_18)
				local var_290_21 = var_290_19 <= 0 and var_290_16 or var_290_16 * (var_290_20 / var_290_19)

				if var_290_21 > 0 and var_290_16 < var_290_21 then
					arg_287_1.talkMaxDuration = var_290_21

					if var_290_21 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_21 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_18
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_22 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_22 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_22

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_22 and arg_287_1.time_ < var_290_15 + var_290_22 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play417111070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 417111070
		arg_291_1.duration_ = 3.83

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play417111071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1034"]
			local var_294_1 = 1.06666666666667

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1034 == nil then
				arg_291_1.var_.actorSpriteComps1034 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1034 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1034 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_294_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1034 = nil
			end

			local var_294_8 = arg_291_1.actors_["1034"].transform
			local var_294_9 = 1.06666666666667

			if var_294_9 < arg_291_1.time_ and arg_291_1.time_ <= var_294_9 + arg_294_0 then
				arg_291_1.var_.moveOldPos1034 = var_294_8.localPosition
				var_294_8.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1034", 7)

				local var_294_10 = var_294_8.childCount

				for iter_294_4 = 0, var_294_10 - 1 do
					local var_294_11 = var_294_8:GetChild(iter_294_4)

					if var_294_11.name == "" or not string.find(var_294_11.name, "split") then
						var_294_11.gameObject:SetActive(true)
					else
						var_294_11.gameObject:SetActive(false)
					end
				end
			end

			local var_294_12 = 0.001

			if var_294_9 <= arg_291_1.time_ and arg_291_1.time_ < var_294_9 + var_294_12 then
				local var_294_13 = (arg_291_1.time_ - var_294_9) / var_294_12
				local var_294_14 = Vector3.New(0, -2000, 0)

				var_294_8.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1034, var_294_14, var_294_13)
			end

			if arg_291_1.time_ >= var_294_9 + var_294_12 and arg_291_1.time_ < var_294_9 + var_294_12 + arg_294_0 then
				var_294_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_15 = arg_291_1.actors_["10113"].transform
			local var_294_16 = 1.06666666666667

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.var_.moveOldPos10113 = var_294_15.localPosition
				var_294_15.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10113", 7)

				local var_294_17 = var_294_15.childCount

				for iter_294_5 = 0, var_294_17 - 1 do
					local var_294_18 = var_294_15:GetChild(iter_294_5)

					if var_294_18.name == "" or not string.find(var_294_18.name, "split") then
						var_294_18.gameObject:SetActive(true)
					else
						var_294_18.gameObject:SetActive(false)
					end
				end
			end

			local var_294_19 = 0.001

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_19 then
				local var_294_20 = (arg_291_1.time_ - var_294_16) / var_294_19
				local var_294_21 = Vector3.New(0, -2000, 0)

				var_294_15.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10113, var_294_21, var_294_20)
			end

			if arg_291_1.time_ >= var_294_16 + var_294_19 and arg_291_1.time_ < var_294_16 + var_294_19 + arg_294_0 then
				var_294_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_22 = 1.1

			if var_294_22 < arg_291_1.time_ and arg_291_1.time_ <= var_294_22 + arg_294_0 then
				arg_291_1.cswbg_:SetActive(true)

				local var_294_23 = arg_291_1.cswt_:GetComponent("RectTransform")

				arg_291_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_294_23.offsetMin = Vector2.New(400, 105)
				var_294_23.offsetMax = Vector2.New(-400, -200)

				local var_294_24 = arg_291_1:GetWordFromCfg(419104)
				local var_294_25 = arg_291_1:FormatText(var_294_24.content)

				arg_291_1.cswt_.text = var_294_25

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.cswt_)

				arg_291_1.cswt_.fontSize = 100
				arg_291_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_291_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_291_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_294_26 = 1.1

			if var_294_26 < arg_291_1.time_ and arg_291_1.time_ <= var_294_26 + arg_294_0 then
				local var_294_27 = arg_291_1.fswbg_.transform:Find("textbox/adapt/content") or arg_291_1.fswbg_.transform:Find("textbox/content")
				local var_294_28 = arg_291_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_294_29 = var_294_27:GetComponent("Text")
				local var_294_30 = var_294_27:GetComponent("RectTransform")

				var_294_29.alignment = UnityEngine.TextAnchor.LowerCenter
				var_294_30.offsetMin = Vector2.New(0, 0)
				var_294_30.offsetMax = Vector2.New(0, 0)
			end

			local var_294_31 = 1.1

			if var_294_31 < arg_291_1.time_ and arg_291_1.time_ <= var_294_31 + arg_294_0 then
				arg_291_1.fswbg_:SetActive(true)
				arg_291_1.dialog_:SetActive(false)

				arg_291_1.fswtw_.percent = 0

				local var_294_32 = arg_291_1:GetWordFromCfg(417111070)
				local var_294_33 = arg_291_1:FormatText(var_294_32.content)

				arg_291_1.fswt_.text = var_294_33

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.fswt_)

				arg_291_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_291_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_291_1.fswtw_:SetDirty()

				arg_291_1.typewritterCharCountI18N = 0

				SetActive(arg_291_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_291_1:ShowNextGo(false)
			end

			local var_294_34 = 1.86666666666667

			if var_294_34 < arg_291_1.time_ and arg_291_1.time_ <= var_294_34 + arg_294_0 then
				arg_291_1.var_.oldValueTypewriter = arg_291_1.fswtw_.percent

				SetActive(arg_291_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_291_1:ShowNextGo(false)
			end

			local var_294_35 = 8
			local var_294_36 = 0.533333333333333
			local var_294_37 = arg_291_1:GetWordFromCfg(417111070)
			local var_294_38 = arg_291_1:FormatText(var_294_37.content)
			local var_294_39, var_294_40 = arg_291_1:GetPercentByPara(var_294_38, 1)

			if var_294_34 < arg_291_1.time_ and arg_291_1.time_ <= var_294_34 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				local var_294_41 = var_294_35 <= 0 and var_294_36 or var_294_36 * ((var_294_40 - arg_291_1.typewritterCharCountI18N) / var_294_35)

				if var_294_41 > 0 and var_294_36 < var_294_41 then
					arg_291_1.talkMaxDuration = var_294_41

					if var_294_41 + var_294_34 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_41 + var_294_34
					end
				end
			end

			local var_294_42 = 0.533333333333333
			local var_294_43 = math.max(var_294_42, arg_291_1.talkMaxDuration)

			if var_294_34 <= arg_291_1.time_ and arg_291_1.time_ < var_294_34 + var_294_43 then
				local var_294_44 = (arg_291_1.time_ - var_294_34) / var_294_43

				arg_291_1.fswtw_.percent = Mathf.Lerp(arg_291_1.var_.oldValueTypewriter, var_294_39, var_294_44)
				arg_291_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_291_1.fswtw_:SetDirty()
			end

			if arg_291_1.time_ >= var_294_34 + var_294_43 and arg_291_1.time_ < var_294_34 + var_294_43 + arg_294_0 then
				arg_291_1.fswtw_.percent = var_294_39

				arg_291_1.fswtw_:SetDirty()
				arg_291_1:ShowNextGo(true)

				arg_291_1.typewritterCharCountI18N = var_294_40
			end

			local var_294_45 = 0

			if var_294_45 < arg_291_1.time_ and arg_291_1.time_ <= var_294_45 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_46 = 1.1

			if var_294_45 <= arg_291_1.time_ and arg_291_1.time_ < var_294_45 + var_294_46 then
				local var_294_47 = (arg_291_1.time_ - var_294_45) / var_294_46
				local var_294_48 = Color.New(0, 0, 0)

				var_294_48.a = Mathf.Lerp(0, 1, var_294_47)
				arg_291_1.mask_.color = var_294_48
			end

			if arg_291_1.time_ >= var_294_45 + var_294_46 and arg_291_1.time_ < var_294_45 + var_294_46 + arg_294_0 then
				local var_294_49 = Color.New(0, 0, 0)

				var_294_49.a = 1
				arg_291_1.mask_.color = var_294_49
			end

			local var_294_50 = 1.1

			if var_294_50 < arg_291_1.time_ and arg_291_1.time_ <= var_294_50 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_51 = 2

			if var_294_50 <= arg_291_1.time_ and arg_291_1.time_ < var_294_50 + var_294_51 then
				local var_294_52 = (arg_291_1.time_ - var_294_50) / var_294_51
				local var_294_53 = Color.New(0, 0, 0)

				var_294_53.a = Mathf.Lerp(1, 0, var_294_52)
				arg_291_1.mask_.color = var_294_53
			end

			if arg_291_1.time_ >= var_294_50 + var_294_51 and arg_291_1.time_ < var_294_50 + var_294_51 + arg_294_0 then
				local var_294_54 = Color.New(0, 0, 0)
				local var_294_55 = 0

				arg_291_1.mask_.enabled = false
				var_294_54.a = var_294_55
				arg_291_1.mask_.color = var_294_54
			end

			local var_294_56 = "STblack"

			if arg_291_1.bgs_[var_294_56] == nil then
				local var_294_57 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_57:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_294_56)
				var_294_57.name = var_294_56
				var_294_57.transform.parent = arg_291_1.stage_.transform
				var_294_57.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_[var_294_56] = var_294_57
			end

			local var_294_58 = 1.1

			if var_294_58 < arg_291_1.time_ and arg_291_1.time_ <= var_294_58 + arg_294_0 then
				local var_294_59 = manager.ui.mainCamera.transform.localPosition
				local var_294_60 = Vector3.New(0, 0, 10) + Vector3.New(var_294_59.x, var_294_59.y, 0)
				local var_294_61 = arg_291_1.bgs_.STblack

				var_294_61.transform.localPosition = var_294_60
				var_294_61.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_62 = var_294_61:GetComponent("SpriteRenderer")

				if var_294_62 and var_294_62.sprite then
					local var_294_63 = (var_294_61.transform.localPosition - var_294_59).z
					local var_294_64 = manager.ui.mainCameraCom_
					local var_294_65 = 2 * var_294_63 * Mathf.Tan(var_294_64.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_294_66 = var_294_65 * var_294_64.aspect
					local var_294_67 = var_294_62.sprite.bounds.size.x
					local var_294_68 = var_294_62.sprite.bounds.size.y
					local var_294_69 = var_294_66 / var_294_67
					local var_294_70 = var_294_65 / var_294_68
					local var_294_71 = var_294_70 < var_294_69 and var_294_69 or var_294_70

					var_294_61.transform.localScale = Vector3.New(var_294_71, var_294_71, 0)
				end

				for iter_294_6, iter_294_7 in pairs(arg_291_1.bgs_) do
					if iter_294_6 ~= "STblack" then
						iter_294_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_72 = 1.76666666666667
			local var_294_73 = 2.066
			local var_294_74 = manager.audio:GetVoiceLength("story_v_out_417111", "417111070", "") / 1000

			if var_294_74 > 0 and var_294_73 < var_294_74 and var_294_74 + var_294_72 > arg_291_1.duration_ then
				local var_294_75 = var_294_74

				arg_291_1.duration_ = var_294_74 + var_294_72
			end

			if var_294_72 < arg_291_1.time_ and arg_291_1.time_ <= var_294_72 + arg_294_0 then
				local var_294_76 = "play"
				local var_294_77 = "voice"

				arg_291_1:AudioAction(var_294_76, var_294_77, "story_v_out_417111", "417111070", "")
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play417111071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 417111071
		arg_295_1.duration_ = 12.33

		local var_295_0 = {
			zh = 11.333,
			ja = 12.333
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
				arg_295_0:Play417111072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10113"]
			local var_298_1 = 3.1

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10113 == nil then
				arg_295_1.var_.actorSpriteComps10113 = var_298_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_2 = 0.2

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.actorSpriteComps10113 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.actorSpriteComps10113 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_298_3 then
						if arg_295_1.isInRecall_ then
							iter_298_3.color = arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_298_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_295_1.var_.actorSpriteComps10113 = nil
			end

			local var_298_8 = arg_295_1.actors_["10113"].transform
			local var_298_9 = 3.1

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 then
				arg_295_1.var_.moveOldPos10113 = var_298_8.localPosition
				var_298_8.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10113", 3)

				local var_298_10 = var_298_8.childCount

				for iter_298_4 = 0, var_298_10 - 1 do
					local var_298_11 = var_298_8:GetChild(iter_298_4)

					if var_298_11.name == "" or not string.find(var_298_11.name, "split") then
						var_298_11.gameObject:SetActive(true)
					else
						var_298_11.gameObject:SetActive(false)
					end
				end
			end

			local var_298_12 = 0.001

			if var_298_9 <= arg_295_1.time_ and arg_295_1.time_ < var_298_9 + var_298_12 then
				local var_298_13 = (arg_295_1.time_ - var_298_9) / var_298_12
				local var_298_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_298_8.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10113, var_298_14, var_298_13)
			end

			if arg_295_1.time_ >= var_298_9 + var_298_12 and arg_295_1.time_ < var_298_9 + var_298_12 + arg_298_0 then
				var_298_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_298_15 = 1.3

			if var_298_15 < arg_295_1.time_ and arg_295_1.time_ <= var_298_15 + arg_298_0 then
				arg_295_1.cswbg_:SetActive(false)
			end

			local var_298_16 = 1.3

			if var_298_16 < arg_295_1.time_ and arg_295_1.time_ <= var_298_16 + arg_298_0 then
				local var_298_17 = arg_295_1.fswbg_.transform:Find("textbox/adapt/content") or arg_295_1.fswbg_.transform:Find("textbox/content")
				local var_298_18 = arg_295_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_298_19 = var_298_17:GetComponent("Text")
				local var_298_20 = var_298_17:GetComponent("RectTransform")

				var_298_19.alignment = UnityEngine.TextAnchor.LowerCenter
				var_298_20.offsetMin = Vector2.New(0, 0)
				var_298_20.offsetMax = Vector2.New(0, 0)
			end

			local var_298_21 = 1.3

			if var_298_21 < arg_295_1.time_ and arg_295_1.time_ <= var_298_21 + arg_298_0 then
				arg_295_1.fswbg_:SetActive(false)
				arg_295_1.dialog_:SetActive(false)
				SetActive(arg_295_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_295_1:ShowNextGo(false)
			end

			local var_298_22 = 1.334

			if var_298_22 < arg_295_1.time_ and arg_295_1.time_ <= var_298_22 + arg_298_0 then
				arg_295_1.fswbg_:SetActive(false)
				arg_295_1.dialog_:SetActive(false)
				SetActive(arg_295_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_295_1:ShowNextGo(false)
			end

			local var_298_23 = 0

			if var_298_23 < arg_295_1.time_ and arg_295_1.time_ <= var_298_23 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_24 = 1.3

			if var_298_23 <= arg_295_1.time_ and arg_295_1.time_ < var_298_23 + var_298_24 then
				local var_298_25 = (arg_295_1.time_ - var_298_23) / var_298_24
				local var_298_26 = Color.New(0, 0, 0)

				var_298_26.a = Mathf.Lerp(0, 1, var_298_25)
				arg_295_1.mask_.color = var_298_26
			end

			if arg_295_1.time_ >= var_298_23 + var_298_24 and arg_295_1.time_ < var_298_23 + var_298_24 + arg_298_0 then
				local var_298_27 = Color.New(0, 0, 0)

				var_298_27.a = 1
				arg_295_1.mask_.color = var_298_27
			end

			local var_298_28 = 1.3

			if var_298_28 < arg_295_1.time_ and arg_295_1.time_ <= var_298_28 + arg_298_0 then
				arg_295_1.mask_.enabled = true
				arg_295_1.mask_.raycastTarget = true

				arg_295_1:SetGaussion(false)
			end

			local var_298_29 = 2

			if var_298_28 <= arg_295_1.time_ and arg_295_1.time_ < var_298_28 + var_298_29 then
				local var_298_30 = (arg_295_1.time_ - var_298_28) / var_298_29
				local var_298_31 = Color.New(0, 0, 0)

				var_298_31.a = Mathf.Lerp(1, 0, var_298_30)
				arg_295_1.mask_.color = var_298_31
			end

			if arg_295_1.time_ >= var_298_28 + var_298_29 and arg_295_1.time_ < var_298_28 + var_298_29 + arg_298_0 then
				local var_298_32 = Color.New(0, 0, 0)
				local var_298_33 = 0

				arg_295_1.mask_.enabled = false
				var_298_32.a = var_298_33
				arg_295_1.mask_.color = var_298_32
			end

			local var_298_34 = 1.3

			if var_298_34 < arg_295_1.time_ and arg_295_1.time_ <= var_298_34 + arg_298_0 then
				local var_298_35 = manager.ui.mainCamera.transform.localPosition
				local var_298_36 = Vector3.New(0, 0, 10) + Vector3.New(var_298_35.x, var_298_35.y, 0)
				local var_298_37 = arg_295_1.bgs_.I07a

				var_298_37.transform.localPosition = var_298_36
				var_298_37.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_298_38 = var_298_37:GetComponent("SpriteRenderer")

				if var_298_38 and var_298_38.sprite then
					local var_298_39 = (var_298_37.transform.localPosition - var_298_35).z
					local var_298_40 = manager.ui.mainCameraCom_
					local var_298_41 = 2 * var_298_39 * Mathf.Tan(var_298_40.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_298_42 = var_298_41 * var_298_40.aspect
					local var_298_43 = var_298_38.sprite.bounds.size.x
					local var_298_44 = var_298_38.sprite.bounds.size.y
					local var_298_45 = var_298_42 / var_298_43
					local var_298_46 = var_298_41 / var_298_44
					local var_298_47 = var_298_46 < var_298_45 and var_298_45 or var_298_46

					var_298_37.transform.localScale = Vector3.New(var_298_47, var_298_47, 0)
				end

				for iter_298_5, iter_298_6 in pairs(arg_295_1.bgs_) do
					if iter_298_5 ~= "I07a" then
						iter_298_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_298_48 = arg_295_1.actors_["10113"]
			local var_298_49 = 3.099999999999

			if var_298_49 < arg_295_1.time_ and arg_295_1.time_ <= var_298_49 + arg_298_0 then
				local var_298_50 = var_298_48:GetComponentInChildren(typeof(CanvasGroup))

				if var_298_50 then
					arg_295_1.var_.alphaOldValue10113 = var_298_50.alpha
					arg_295_1.var_.characterEffect10113 = var_298_50
				end

				arg_295_1.var_.alphaOldValue10113 = 0
			end

			local var_298_51 = 0.200000000001

			if var_298_49 <= arg_295_1.time_ and arg_295_1.time_ < var_298_49 + var_298_51 then
				local var_298_52 = (arg_295_1.time_ - var_298_49) / var_298_51
				local var_298_53 = Mathf.Lerp(arg_295_1.var_.alphaOldValue10113, 1, var_298_52)

				if arg_295_1.var_.characterEffect10113 then
					arg_295_1.var_.characterEffect10113.alpha = var_298_53
				end
			end

			if arg_295_1.time_ >= var_298_49 + var_298_51 and arg_295_1.time_ < var_298_49 + var_298_51 + arg_298_0 and arg_295_1.var_.characterEffect10113 then
				arg_295_1.var_.characterEffect10113.alpha = 1
			end

			if arg_295_1.frameCnt_ <= 1 then
				arg_295_1.dialog_:SetActive(false)
			end

			local var_298_54 = 3.3
			local var_298_55 = 0.925

			if var_298_54 < arg_295_1.time_ and arg_295_1.time_ <= var_298_54 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0

				arg_295_1.dialog_:SetActive(true)

				arg_295_1.dialogCg_.alpha = 0

				local var_298_56 = LeanTween.value(arg_295_1.dialog_, 0, 1, 0.3)

				var_298_56:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_295_1.dialogCg_.alpha = arg_299_0
				end))
				var_298_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_295_1.dialog_)
					var_298_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_295_1.duration_ = arg_295_1.duration_ + 0.3

				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_57 = arg_295_1:FormatText(StoryNameCfg[1117].name)

				arg_295_1.leftNameTxt_.text = var_298_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_58 = arg_295_1:GetWordFromCfg(417111071)
				local var_298_59 = arg_295_1:FormatText(var_298_58.content)

				arg_295_1.text_.text = var_298_59

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_60 = 37
				local var_298_61 = utf8.len(var_298_59)
				local var_298_62 = var_298_60 <= 0 and var_298_55 or var_298_55 * (var_298_61 / var_298_60)

				if var_298_62 > 0 and var_298_55 < var_298_62 then
					arg_295_1.talkMaxDuration = var_298_62
					var_298_54 = var_298_54 + 0.3

					if var_298_62 + var_298_54 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_62 + var_298_54
					end
				end

				arg_295_1.text_.text = var_298_59
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111071", "story_v_out_417111.awb") ~= 0 then
					local var_298_63 = manager.audio:GetVoiceLength("story_v_out_417111", "417111071", "story_v_out_417111.awb") / 1000

					if var_298_63 + var_298_54 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_63 + var_298_54
					end

					if var_298_58.prefab_name ~= "" and arg_295_1.actors_[var_298_58.prefab_name] ~= nil then
						local var_298_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_58.prefab_name].transform, "story_v_out_417111", "417111071", "story_v_out_417111.awb")

						arg_295_1:RecordAudio("417111071", var_298_64)
						arg_295_1:RecordAudio("417111071", var_298_64)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_417111", "417111071", "story_v_out_417111.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_417111", "417111071", "story_v_out_417111.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_65 = var_298_54 + 0.3
			local var_298_66 = math.max(var_298_55, arg_295_1.talkMaxDuration)

			if var_298_65 <= arg_295_1.time_ and arg_295_1.time_ < var_298_65 + var_298_66 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_65) / var_298_66

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_65 + var_298_66 and arg_295_1.time_ < var_298_65 + var_298_66 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play417111072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 417111072
		arg_301_1.duration_ = 6.83

		local var_301_0 = {
			zh = 6.833,
			ja = 5.2
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play417111073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["10113"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos10113 = var_304_0.localPosition
				var_304_0.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10113", 3)

				local var_304_2 = var_304_0.childCount

				for iter_304_0 = 0, var_304_2 - 1 do
					local var_304_3 = var_304_0:GetChild(iter_304_0)

					if var_304_3.name == "" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_4 then
				local var_304_5 = (arg_301_1.time_ - var_304_1) / var_304_4
				local var_304_6 = Vector3.New(-30.38, -328.4, -517.4)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10113, var_304_6, var_304_5)
			end

			if arg_301_1.time_ >= var_304_1 + var_304_4 and arg_301_1.time_ < var_304_1 + var_304_4 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_304_7 = 0
			local var_304_8 = 0.8

			if var_304_7 < arg_301_1.time_ and arg_301_1.time_ <= var_304_7 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_9 = arg_301_1:FormatText(StoryNameCfg[1117].name)

				arg_301_1.leftNameTxt_.text = var_304_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_10 = arg_301_1:GetWordFromCfg(417111072)
				local var_304_11 = arg_301_1:FormatText(var_304_10.content)

				arg_301_1.text_.text = var_304_11

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_12 = 32
				local var_304_13 = utf8.len(var_304_11)
				local var_304_14 = var_304_12 <= 0 and var_304_8 or var_304_8 * (var_304_13 / var_304_12)

				if var_304_14 > 0 and var_304_8 < var_304_14 then
					arg_301_1.talkMaxDuration = var_304_14

					if var_304_14 + var_304_7 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_14 + var_304_7
					end
				end

				arg_301_1.text_.text = var_304_11
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111072", "story_v_out_417111.awb") ~= 0 then
					local var_304_15 = manager.audio:GetVoiceLength("story_v_out_417111", "417111072", "story_v_out_417111.awb") / 1000

					if var_304_15 + var_304_7 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_15 + var_304_7
					end

					if var_304_10.prefab_name ~= "" and arg_301_1.actors_[var_304_10.prefab_name] ~= nil then
						local var_304_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_10.prefab_name].transform, "story_v_out_417111", "417111072", "story_v_out_417111.awb")

						arg_301_1:RecordAudio("417111072", var_304_16)
						arg_301_1:RecordAudio("417111072", var_304_16)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_417111", "417111072", "story_v_out_417111.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_417111", "417111072", "story_v_out_417111.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_17 = math.max(var_304_8, arg_301_1.talkMaxDuration)

			if var_304_7 <= arg_301_1.time_ and arg_301_1.time_ < var_304_7 + var_304_17 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_7) / var_304_17

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_7 + var_304_17 and arg_301_1.time_ < var_304_7 + var_304_17 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play417111073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 417111073
		arg_305_1.duration_ = 1.4

		local var_305_0 = {
			zh = 1.3,
			ja = 1.4
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
				arg_305_0:Play417111074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1034"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps1034 == nil then
				arg_305_1.var_.actorSpriteComps1034 = var_308_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_2 = 0.2

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.actorSpriteComps1034 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_308_1 then
							if arg_305_1.isInRecall_ then
								local var_308_4 = Mathf.Lerp(iter_308_1.color.r, arg_305_1.hightColor1.r, var_308_3)
								local var_308_5 = Mathf.Lerp(iter_308_1.color.g, arg_305_1.hightColor1.g, var_308_3)
								local var_308_6 = Mathf.Lerp(iter_308_1.color.b, arg_305_1.hightColor1.b, var_308_3)

								iter_308_1.color = Color.New(var_308_4, var_308_5, var_308_6)
							else
								local var_308_7 = Mathf.Lerp(iter_308_1.color.r, 1, var_308_3)

								iter_308_1.color = Color.New(var_308_7, var_308_7, var_308_7)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps1034 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_308_3 then
						if arg_305_1.isInRecall_ then
							iter_308_3.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1034 = nil
			end

			local var_308_8 = arg_305_1.actors_["10113"]
			local var_308_9 = 0

			if var_308_9 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps10113 == nil then
				arg_305_1.var_.actorSpriteComps10113 = var_308_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_10 = 0.2

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_10 and not isNil(var_308_8) then
				local var_308_11 = (arg_305_1.time_ - var_308_9) / var_308_10

				if arg_305_1.var_.actorSpriteComps10113 then
					for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_308_5 then
							if arg_305_1.isInRecall_ then
								local var_308_12 = Mathf.Lerp(iter_308_5.color.r, arg_305_1.hightColor2.r, var_308_11)
								local var_308_13 = Mathf.Lerp(iter_308_5.color.g, arg_305_1.hightColor2.g, var_308_11)
								local var_308_14 = Mathf.Lerp(iter_308_5.color.b, arg_305_1.hightColor2.b, var_308_11)

								iter_308_5.color = Color.New(var_308_12, var_308_13, var_308_14)
							else
								local var_308_15 = Mathf.Lerp(iter_308_5.color.r, 0.5, var_308_11)

								iter_308_5.color = Color.New(var_308_15, var_308_15, var_308_15)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_9 + var_308_10 and arg_305_1.time_ < var_308_9 + var_308_10 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps10113 then
				for iter_308_6, iter_308_7 in pairs(arg_305_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_308_7 then
						if arg_305_1.isInRecall_ then
							iter_308_7.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10113 = nil
			end

			local var_308_16 = arg_305_1.actors_["1034"].transform
			local var_308_17 = 0

			if var_308_17 < arg_305_1.time_ and arg_305_1.time_ <= var_308_17 + arg_308_0 then
				arg_305_1.var_.moveOldPos1034 = var_308_16.localPosition
				var_308_16.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1034", 3)

				local var_308_18 = var_308_16.childCount

				for iter_308_8 = 0, var_308_18 - 1 do
					local var_308_19 = var_308_16:GetChild(iter_308_8)

					if var_308_19.name == "" or not string.find(var_308_19.name, "split") then
						var_308_19.gameObject:SetActive(true)
					else
						var_308_19.gameObject:SetActive(false)
					end
				end
			end

			local var_308_20 = 0.001

			if var_308_17 <= arg_305_1.time_ and arg_305_1.time_ < var_308_17 + var_308_20 then
				local var_308_21 = (arg_305_1.time_ - var_308_17) / var_308_20
				local var_308_22 = Vector3.New(0, -331.9, -324)

				var_308_16.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1034, var_308_22, var_308_21)
			end

			if arg_305_1.time_ >= var_308_17 + var_308_20 and arg_305_1.time_ < var_308_17 + var_308_20 + arg_308_0 then
				var_308_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_308_23 = arg_305_1.actors_["10113"].transform
			local var_308_24 = 0

			if var_308_24 < arg_305_1.time_ and arg_305_1.time_ <= var_308_24 + arg_308_0 then
				arg_305_1.var_.moveOldPos10113 = var_308_23.localPosition
				var_308_23.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10113", 7)

				local var_308_25 = var_308_23.childCount

				for iter_308_9 = 0, var_308_25 - 1 do
					local var_308_26 = var_308_23:GetChild(iter_308_9)

					if var_308_26.name == "" or not string.find(var_308_26.name, "split") then
						var_308_26.gameObject:SetActive(true)
					else
						var_308_26.gameObject:SetActive(false)
					end
				end
			end

			local var_308_27 = 0.001

			if var_308_24 <= arg_305_1.time_ and arg_305_1.time_ < var_308_24 + var_308_27 then
				local var_308_28 = (arg_305_1.time_ - var_308_24) / var_308_27
				local var_308_29 = Vector3.New(0, -2000, 0)

				var_308_23.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10113, var_308_29, var_308_28)
			end

			if arg_305_1.time_ >= var_308_24 + var_308_27 and arg_305_1.time_ < var_308_24 + var_308_27 + arg_308_0 then
				var_308_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_308_30 = 0
			local var_308_31 = 0.125

			if var_308_30 < arg_305_1.time_ and arg_305_1.time_ <= var_308_30 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_32 = arg_305_1:FormatText(StoryNameCfg[1109].name)

				arg_305_1.leftNameTxt_.text = var_308_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_33 = arg_305_1:GetWordFromCfg(417111073)
				local var_308_34 = arg_305_1:FormatText(var_308_33.content)

				arg_305_1.text_.text = var_308_34

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_35 = 5
				local var_308_36 = utf8.len(var_308_34)
				local var_308_37 = var_308_35 <= 0 and var_308_31 or var_308_31 * (var_308_36 / var_308_35)

				if var_308_37 > 0 and var_308_31 < var_308_37 then
					arg_305_1.talkMaxDuration = var_308_37

					if var_308_37 + var_308_30 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_37 + var_308_30
					end
				end

				arg_305_1.text_.text = var_308_34
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111073", "story_v_out_417111.awb") ~= 0 then
					local var_308_38 = manager.audio:GetVoiceLength("story_v_out_417111", "417111073", "story_v_out_417111.awb") / 1000

					if var_308_38 + var_308_30 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_38 + var_308_30
					end

					if var_308_33.prefab_name ~= "" and arg_305_1.actors_[var_308_33.prefab_name] ~= nil then
						local var_308_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_33.prefab_name].transform, "story_v_out_417111", "417111073", "story_v_out_417111.awb")

						arg_305_1:RecordAudio("417111073", var_308_39)
						arg_305_1:RecordAudio("417111073", var_308_39)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_417111", "417111073", "story_v_out_417111.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_417111", "417111073", "story_v_out_417111.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_40 = math.max(var_308_31, arg_305_1.talkMaxDuration)

			if var_308_30 <= arg_305_1.time_ and arg_305_1.time_ < var_308_30 + var_308_40 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_30) / var_308_40

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_30 + var_308_40 and arg_305_1.time_ < var_308_30 + var_308_40 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
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

		arg_305_1:InitPlayNodeList()
	end,
	Play417111074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 417111074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play417111075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["1034"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps1034 == nil then
				arg_309_1.var_.actorSpriteComps1034 = var_312_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_2 = 0.2

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.actorSpriteComps1034 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								local var_312_4 = Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor2.r, var_312_3)
								local var_312_5 = Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor2.g, var_312_3)
								local var_312_6 = Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor2.b, var_312_3)

								iter_312_1.color = Color.New(var_312_4, var_312_5, var_312_6)
							else
								local var_312_7 = Mathf.Lerp(iter_312_1.color.r, 0.5, var_312_3)

								iter_312_1.color = Color.New(var_312_7, var_312_7, var_312_7)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps1034 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_312_3 then
						if arg_309_1.isInRecall_ then
							iter_312_3.color = arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_312_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps1034 = nil
			end

			local var_312_8 = 0.05
			local var_312_9 = 1

			if var_312_8 < arg_309_1.time_ and arg_309_1.time_ <= var_312_8 + arg_312_0 then
				local var_312_10 = "play"
				local var_312_11 = "effect"

				arg_309_1:AudioAction(var_312_10, var_312_11, "se_story_1310", "se_story_1310_footstep04", "")
			end

			local var_312_12 = 0
			local var_312_13 = 1.3

			if var_312_12 < arg_309_1.time_ and arg_309_1.time_ <= var_312_12 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_14 = arg_309_1:GetWordFromCfg(417111074)
				local var_312_15 = arg_309_1:FormatText(var_312_14.content)

				arg_309_1.text_.text = var_312_15

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_16 = 52
				local var_312_17 = utf8.len(var_312_15)
				local var_312_18 = var_312_16 <= 0 and var_312_13 or var_312_13 * (var_312_17 / var_312_16)

				if var_312_18 > 0 and var_312_13 < var_312_18 then
					arg_309_1.talkMaxDuration = var_312_18

					if var_312_18 + var_312_12 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_18 + var_312_12
					end
				end

				arg_309_1.text_.text = var_312_15
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_19 = math.max(var_312_13, arg_309_1.talkMaxDuration)

			if var_312_12 <= arg_309_1.time_ and arg_309_1.time_ < var_312_12 + var_312_19 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_12) / var_312_19

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_12 + var_312_19 and arg_309_1.time_ < var_312_12 + var_312_19 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play417111075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 417111075
		arg_313_1.duration_ = 8.6

		local var_313_0 = {
			zh = 7.1,
			ja = 8.6
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
				arg_313_0:Play417111076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10113"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps10113 == nil then
				arg_313_1.var_.actorSpriteComps10113 = var_316_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_2 = 0.2

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.actorSpriteComps10113 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								local var_316_4 = Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor1.r, var_316_3)
								local var_316_5 = Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor1.g, var_316_3)
								local var_316_6 = Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor1.b, var_316_3)

								iter_316_1.color = Color.New(var_316_4, var_316_5, var_316_6)
							else
								local var_316_7 = Mathf.Lerp(iter_316_1.color.r, 1, var_316_3)

								iter_316_1.color = Color.New(var_316_7, var_316_7, var_316_7)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps10113 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_316_3 then
						if arg_313_1.isInRecall_ then
							iter_316_3.color = arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_316_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps10113 = nil
			end

			local var_316_8 = arg_313_1.actors_["10113"].transform
			local var_316_9 = 0

			if var_316_9 < arg_313_1.time_ and arg_313_1.time_ <= var_316_9 + arg_316_0 then
				arg_313_1.var_.moveOldPos10113 = var_316_8.localPosition
				var_316_8.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10113", 4)

				local var_316_10 = var_316_8.childCount

				for iter_316_4 = 0, var_316_10 - 1 do
					local var_316_11 = var_316_8:GetChild(iter_316_4)

					if var_316_11.name == "" or not string.find(var_316_11.name, "split") then
						var_316_11.gameObject:SetActive(true)
					else
						var_316_11.gameObject:SetActive(false)
					end
				end
			end

			local var_316_12 = 0.001

			if var_316_9 <= arg_313_1.time_ and arg_313_1.time_ < var_316_9 + var_316_12 then
				local var_316_13 = (arg_313_1.time_ - var_316_9) / var_316_12
				local var_316_14 = Vector3.New(377.3, -328.4, -517.4)

				var_316_8.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10113, var_316_14, var_316_13)
			end

			if arg_313_1.time_ >= var_316_9 + var_316_12 and arg_313_1.time_ < var_316_9 + var_316_12 + arg_316_0 then
				var_316_8.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_316_15 = arg_313_1.actors_["1034"].transform
			local var_316_16 = 0

			if var_316_16 < arg_313_1.time_ and arg_313_1.time_ <= var_316_16 + arg_316_0 then
				arg_313_1.var_.moveOldPos1034 = var_316_15.localPosition
				var_316_15.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("1034", 2)

				local var_316_17 = var_316_15.childCount

				for iter_316_5 = 0, var_316_17 - 1 do
					local var_316_18 = var_316_15:GetChild(iter_316_5)

					if var_316_18.name == "" or not string.find(var_316_18.name, "split") then
						var_316_18.gameObject:SetActive(true)
					else
						var_316_18.gameObject:SetActive(false)
					end
				end
			end

			local var_316_19 = 0.001

			if var_316_16 <= arg_313_1.time_ and arg_313_1.time_ < var_316_16 + var_316_19 then
				local var_316_20 = (arg_313_1.time_ - var_316_16) / var_316_19
				local var_316_21 = Vector3.New(-390, -331.9, -324)

				var_316_15.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1034, var_316_21, var_316_20)
			end

			if arg_313_1.time_ >= var_316_16 + var_316_19 and arg_313_1.time_ < var_316_16 + var_316_19 + arg_316_0 then
				var_316_15.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_316_22 = 0
			local var_316_23 = 0.625

			if var_316_22 < arg_313_1.time_ and arg_313_1.time_ <= var_316_22 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_24 = arg_313_1:FormatText(StoryNameCfg[1117].name)

				arg_313_1.leftNameTxt_.text = var_316_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_25 = arg_313_1:GetWordFromCfg(417111075)
				local var_316_26 = arg_313_1:FormatText(var_316_25.content)

				arg_313_1.text_.text = var_316_26

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_27 = 25
				local var_316_28 = utf8.len(var_316_26)
				local var_316_29 = var_316_27 <= 0 and var_316_23 or var_316_23 * (var_316_28 / var_316_27)

				if var_316_29 > 0 and var_316_23 < var_316_29 then
					arg_313_1.talkMaxDuration = var_316_29

					if var_316_29 + var_316_22 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_29 + var_316_22
					end
				end

				arg_313_1.text_.text = var_316_26
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111075", "story_v_out_417111.awb") ~= 0 then
					local var_316_30 = manager.audio:GetVoiceLength("story_v_out_417111", "417111075", "story_v_out_417111.awb") / 1000

					if var_316_30 + var_316_22 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_30 + var_316_22
					end

					if var_316_25.prefab_name ~= "" and arg_313_1.actors_[var_316_25.prefab_name] ~= nil then
						local var_316_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_25.prefab_name].transform, "story_v_out_417111", "417111075", "story_v_out_417111.awb")

						arg_313_1:RecordAudio("417111075", var_316_31)
						arg_313_1:RecordAudio("417111075", var_316_31)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_417111", "417111075", "story_v_out_417111.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_417111", "417111075", "story_v_out_417111.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_32 = math.max(var_316_23, arg_313_1.talkMaxDuration)

			if var_316_22 <= arg_313_1.time_ and arg_313_1.time_ < var_316_22 + var_316_32 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_22) / var_316_32

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_22 + var_316_32 and arg_313_1.time_ < var_316_22 + var_316_32 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play417111076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 417111076
		arg_317_1.duration_ = 4.2

		local var_317_0 = {
			zh = 4.2,
			ja = 3.5
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
				arg_317_0:Play417111077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1034"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps1034 == nil then
				arg_317_1.var_.actorSpriteComps1034 = var_320_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_2 = 0.2

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.actorSpriteComps1034 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								local var_320_4 = Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor1.r, var_320_3)
								local var_320_5 = Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor1.g, var_320_3)
								local var_320_6 = Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor1.b, var_320_3)

								iter_320_1.color = Color.New(var_320_4, var_320_5, var_320_6)
							else
								local var_320_7 = Mathf.Lerp(iter_320_1.color.r, 1, var_320_3)

								iter_320_1.color = Color.New(var_320_7, var_320_7, var_320_7)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps1034 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_320_3 then
						if arg_317_1.isInRecall_ then
							iter_320_3.color = arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_320_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps1034 = nil
			end

			local var_320_8 = arg_317_1.actors_["10113"]
			local var_320_9 = 0

			if var_320_9 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 and not isNil(var_320_8) and arg_317_1.var_.actorSpriteComps10113 == nil then
				arg_317_1.var_.actorSpriteComps10113 = var_320_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_10 = 0.2

			if var_320_9 <= arg_317_1.time_ and arg_317_1.time_ < var_320_9 + var_320_10 and not isNil(var_320_8) then
				local var_320_11 = (arg_317_1.time_ - var_320_9) / var_320_10

				if arg_317_1.var_.actorSpriteComps10113 then
					for iter_320_4, iter_320_5 in pairs(arg_317_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_320_5 then
							if arg_317_1.isInRecall_ then
								local var_320_12 = Mathf.Lerp(iter_320_5.color.r, arg_317_1.hightColor2.r, var_320_11)
								local var_320_13 = Mathf.Lerp(iter_320_5.color.g, arg_317_1.hightColor2.g, var_320_11)
								local var_320_14 = Mathf.Lerp(iter_320_5.color.b, arg_317_1.hightColor2.b, var_320_11)

								iter_320_5.color = Color.New(var_320_12, var_320_13, var_320_14)
							else
								local var_320_15 = Mathf.Lerp(iter_320_5.color.r, 0.5, var_320_11)

								iter_320_5.color = Color.New(var_320_15, var_320_15, var_320_15)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= var_320_9 + var_320_10 and arg_317_1.time_ < var_320_9 + var_320_10 + arg_320_0 and not isNil(var_320_8) and arg_317_1.var_.actorSpriteComps10113 then
				for iter_320_6, iter_320_7 in pairs(arg_317_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_320_7 then
						if arg_317_1.isInRecall_ then
							iter_320_7.color = arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_320_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps10113 = nil
			end

			local var_320_16 = 0
			local var_320_17 = 0.425

			if var_320_16 < arg_317_1.time_ and arg_317_1.time_ <= var_320_16 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_18 = arg_317_1:FormatText(StoryNameCfg[1109].name)

				arg_317_1.leftNameTxt_.text = var_320_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_19 = arg_317_1:GetWordFromCfg(417111076)
				local var_320_20 = arg_317_1:FormatText(var_320_19.content)

				arg_317_1.text_.text = var_320_20

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_21 = 17
				local var_320_22 = utf8.len(var_320_20)
				local var_320_23 = var_320_21 <= 0 and var_320_17 or var_320_17 * (var_320_22 / var_320_21)

				if var_320_23 > 0 and var_320_17 < var_320_23 then
					arg_317_1.talkMaxDuration = var_320_23

					if var_320_23 + var_320_16 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_23 + var_320_16
					end
				end

				arg_317_1.text_.text = var_320_20
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111076", "story_v_out_417111.awb") ~= 0 then
					local var_320_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111076", "story_v_out_417111.awb") / 1000

					if var_320_24 + var_320_16 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_24 + var_320_16
					end

					if var_320_19.prefab_name ~= "" and arg_317_1.actors_[var_320_19.prefab_name] ~= nil then
						local var_320_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_19.prefab_name].transform, "story_v_out_417111", "417111076", "story_v_out_417111.awb")

						arg_317_1:RecordAudio("417111076", var_320_25)
						arg_317_1:RecordAudio("417111076", var_320_25)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_417111", "417111076", "story_v_out_417111.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_417111", "417111076", "story_v_out_417111.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_26 = math.max(var_320_17, arg_317_1.talkMaxDuration)

			if var_320_16 <= arg_317_1.time_ and arg_317_1.time_ < var_320_16 + var_320_26 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_16) / var_320_26

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_16 + var_320_26 and arg_317_1.time_ < var_320_16 + var_320_26 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play417111077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 417111077
		arg_321_1.duration_ = 7.6

		local var_321_0 = {
			zh = 3.733,
			ja = 7.6
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
				arg_321_0:Play417111078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.425

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[1109].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:GetWordFromCfg(417111077)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 17
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111077", "story_v_out_417111.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111077", "story_v_out_417111.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_417111", "417111077", "story_v_out_417111.awb")

						arg_321_1:RecordAudio("417111077", var_324_9)
						arg_321_1:RecordAudio("417111077", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_417111", "417111077", "story_v_out_417111.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_417111", "417111077", "story_v_out_417111.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play417111078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 417111078
		arg_325_1.duration_ = 12.07

		local var_325_0 = {
			zh = 9.6,
			ja = 12.066
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
				arg_325_0:Play417111079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["10113"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps10113 == nil then
				arg_325_1.var_.actorSpriteComps10113 = var_328_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.actorSpriteComps10113 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								local var_328_4 = Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor1.r, var_328_3)
								local var_328_5 = Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor1.g, var_328_3)
								local var_328_6 = Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor1.b, var_328_3)

								iter_328_1.color = Color.New(var_328_4, var_328_5, var_328_6)
							else
								local var_328_7 = Mathf.Lerp(iter_328_1.color.r, 1, var_328_3)

								iter_328_1.color = Color.New(var_328_7, var_328_7, var_328_7)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps10113 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_328_3 then
						if arg_325_1.isInRecall_ then
							iter_328_3.color = arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_328_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps10113 = nil
			end

			local var_328_8 = arg_325_1.actors_["1034"]
			local var_328_9 = 0

			if var_328_9 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 and not isNil(var_328_8) and arg_325_1.var_.actorSpriteComps1034 == nil then
				arg_325_1.var_.actorSpriteComps1034 = var_328_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_10 = 0.2

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_10 and not isNil(var_328_8) then
				local var_328_11 = (arg_325_1.time_ - var_328_9) / var_328_10

				if arg_325_1.var_.actorSpriteComps1034 then
					for iter_328_4, iter_328_5 in pairs(arg_325_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_328_5 then
							if arg_325_1.isInRecall_ then
								local var_328_12 = Mathf.Lerp(iter_328_5.color.r, arg_325_1.hightColor2.r, var_328_11)
								local var_328_13 = Mathf.Lerp(iter_328_5.color.g, arg_325_1.hightColor2.g, var_328_11)
								local var_328_14 = Mathf.Lerp(iter_328_5.color.b, arg_325_1.hightColor2.b, var_328_11)

								iter_328_5.color = Color.New(var_328_12, var_328_13, var_328_14)
							else
								local var_328_15 = Mathf.Lerp(iter_328_5.color.r, 0.5, var_328_11)

								iter_328_5.color = Color.New(var_328_15, var_328_15, var_328_15)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_9 + var_328_10 and arg_325_1.time_ < var_328_9 + var_328_10 + arg_328_0 and not isNil(var_328_8) and arg_325_1.var_.actorSpriteComps1034 then
				for iter_328_6, iter_328_7 in pairs(arg_325_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_328_7 then
						if arg_325_1.isInRecall_ then
							iter_328_7.color = arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_328_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps1034 = nil
			end

			local var_328_16 = 0
			local var_328_17 = 1.05

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_18 = arg_325_1:FormatText(StoryNameCfg[1117].name)

				arg_325_1.leftNameTxt_.text = var_328_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_19 = arg_325_1:GetWordFromCfg(417111078)
				local var_328_20 = arg_325_1:FormatText(var_328_19.content)

				arg_325_1.text_.text = var_328_20

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_21 = 42
				local var_328_22 = utf8.len(var_328_20)
				local var_328_23 = var_328_21 <= 0 and var_328_17 or var_328_17 * (var_328_22 / var_328_21)

				if var_328_23 > 0 and var_328_17 < var_328_23 then
					arg_325_1.talkMaxDuration = var_328_23

					if var_328_23 + var_328_16 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_23 + var_328_16
					end
				end

				arg_325_1.text_.text = var_328_20
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111078", "story_v_out_417111.awb") ~= 0 then
					local var_328_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111078", "story_v_out_417111.awb") / 1000

					if var_328_24 + var_328_16 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_24 + var_328_16
					end

					if var_328_19.prefab_name ~= "" and arg_325_1.actors_[var_328_19.prefab_name] ~= nil then
						local var_328_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_19.prefab_name].transform, "story_v_out_417111", "417111078", "story_v_out_417111.awb")

						arg_325_1:RecordAudio("417111078", var_328_25)
						arg_325_1:RecordAudio("417111078", var_328_25)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_417111", "417111078", "story_v_out_417111.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_417111", "417111078", "story_v_out_417111.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_26 = math.max(var_328_17, arg_325_1.talkMaxDuration)

			if var_328_16 <= arg_325_1.time_ and arg_325_1.time_ < var_328_16 + var_328_26 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_16) / var_328_26

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_16 + var_328_26 and arg_325_1.time_ < var_328_16 + var_328_26 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play417111079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 417111079
		arg_329_1.duration_ = 8.57

		local var_329_0 = {
			zh = 7.7,
			ja = 8.566
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
				arg_329_0:Play417111080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1034"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1034 == nil then
				arg_329_1.var_.actorSpriteComps1034 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.2

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps1034 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								local var_332_4 = Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor1.r, var_332_3)
								local var_332_5 = Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor1.g, var_332_3)
								local var_332_6 = Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor1.b, var_332_3)

								iter_332_1.color = Color.New(var_332_4, var_332_5, var_332_6)
							else
								local var_332_7 = Mathf.Lerp(iter_332_1.color.r, 1, var_332_3)

								iter_332_1.color = Color.New(var_332_7, var_332_7, var_332_7)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps1034 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps1034 = nil
			end

			local var_332_8 = arg_329_1.actors_["10113"]
			local var_332_9 = 0

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps10113 == nil then
				arg_329_1.var_.actorSpriteComps10113 = var_332_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_10 = 0.2

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_10 and not isNil(var_332_8) then
				local var_332_11 = (arg_329_1.time_ - var_332_9) / var_332_10

				if arg_329_1.var_.actorSpriteComps10113 then
					for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_332_5 then
							if arg_329_1.isInRecall_ then
								local var_332_12 = Mathf.Lerp(iter_332_5.color.r, arg_329_1.hightColor2.r, var_332_11)
								local var_332_13 = Mathf.Lerp(iter_332_5.color.g, arg_329_1.hightColor2.g, var_332_11)
								local var_332_14 = Mathf.Lerp(iter_332_5.color.b, arg_329_1.hightColor2.b, var_332_11)

								iter_332_5.color = Color.New(var_332_12, var_332_13, var_332_14)
							else
								local var_332_15 = Mathf.Lerp(iter_332_5.color.r, 0.5, var_332_11)

								iter_332_5.color = Color.New(var_332_15, var_332_15, var_332_15)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= var_332_9 + var_332_10 and arg_329_1.time_ < var_332_9 + var_332_10 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps10113 then
				for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_332_7 then
						if arg_329_1.isInRecall_ then
							iter_332_7.color = arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_332_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps10113 = nil
			end

			local var_332_16 = arg_329_1.actors_["1034"].transform
			local var_332_17 = 0

			if var_332_17 < arg_329_1.time_ and arg_329_1.time_ <= var_332_17 + arg_332_0 then
				arg_329_1.var_.moveOldPos1034 = var_332_16.localPosition
				var_332_16.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("1034", 2)

				local var_332_18 = var_332_16.childCount

				for iter_332_8 = 0, var_332_18 - 1 do
					local var_332_19 = var_332_16:GetChild(iter_332_8)

					if var_332_19.name == "split_6" or not string.find(var_332_19.name, "split") then
						var_332_19.gameObject:SetActive(true)
					else
						var_332_19.gameObject:SetActive(false)
					end
				end
			end

			local var_332_20 = 0.001

			if var_332_17 <= arg_329_1.time_ and arg_329_1.time_ < var_332_17 + var_332_20 then
				local var_332_21 = (arg_329_1.time_ - var_332_17) / var_332_20
				local var_332_22 = Vector3.New(-390, -331.9, -324)

				var_332_16.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1034, var_332_22, var_332_21)
			end

			if arg_329_1.time_ >= var_332_17 + var_332_20 and arg_329_1.time_ < var_332_17 + var_332_20 + arg_332_0 then
				var_332_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_332_23 = 0
			local var_332_24 = 0.75

			if var_332_23 < arg_329_1.time_ and arg_329_1.time_ <= var_332_23 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_25 = arg_329_1:FormatText(StoryNameCfg[1109].name)

				arg_329_1.leftNameTxt_.text = var_332_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_26 = arg_329_1:GetWordFromCfg(417111079)
				local var_332_27 = arg_329_1:FormatText(var_332_26.content)

				arg_329_1.text_.text = var_332_27

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_28 = 30
				local var_332_29 = utf8.len(var_332_27)
				local var_332_30 = var_332_28 <= 0 and var_332_24 or var_332_24 * (var_332_29 / var_332_28)

				if var_332_30 > 0 and var_332_24 < var_332_30 then
					arg_329_1.talkMaxDuration = var_332_30

					if var_332_30 + var_332_23 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_30 + var_332_23
					end
				end

				arg_329_1.text_.text = var_332_27
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111079", "story_v_out_417111.awb") ~= 0 then
					local var_332_31 = manager.audio:GetVoiceLength("story_v_out_417111", "417111079", "story_v_out_417111.awb") / 1000

					if var_332_31 + var_332_23 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_31 + var_332_23
					end

					if var_332_26.prefab_name ~= "" and arg_329_1.actors_[var_332_26.prefab_name] ~= nil then
						local var_332_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_26.prefab_name].transform, "story_v_out_417111", "417111079", "story_v_out_417111.awb")

						arg_329_1:RecordAudio("417111079", var_332_32)
						arg_329_1:RecordAudio("417111079", var_332_32)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_417111", "417111079", "story_v_out_417111.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_417111", "417111079", "story_v_out_417111.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_33 = math.max(var_332_24, arg_329_1.talkMaxDuration)

			if var_332_23 <= arg_329_1.time_ and arg_329_1.time_ < var_332_23 + var_332_33 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_23) / var_332_33

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_23 + var_332_33 and arg_329_1.time_ < var_332_23 + var_332_33 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play417111080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 417111080
		arg_333_1.duration_ = 7.8

		local var_333_0 = {
			zh = 6.1,
			ja = 7.8
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
				arg_333_0:Play417111081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0
			local var_336_1 = 0.675

			if var_336_0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_2 = arg_333_1:FormatText(StoryNameCfg[1109].name)

				arg_333_1.leftNameTxt_.text = var_336_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:GetWordFromCfg(417111080)
				local var_336_4 = arg_333_1:FormatText(var_336_3.content)

				arg_333_1.text_.text = var_336_4

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111080", "story_v_out_417111.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111080", "story_v_out_417111.awb") / 1000

					if var_336_8 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_0
					end

					if var_336_3.prefab_name ~= "" and arg_333_1.actors_[var_336_3.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_3.prefab_name].transform, "story_v_out_417111", "417111080", "story_v_out_417111.awb")

						arg_333_1:RecordAudio("417111080", var_336_9)
						arg_333_1:RecordAudio("417111080", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_417111", "417111080", "story_v_out_417111.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_417111", "417111080", "story_v_out_417111.awb")
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
	Play417111081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 417111081
		arg_337_1.duration_ = 4.4

		local var_337_0 = {
			zh = 4.4,
			ja = 4.3
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play417111082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10113"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps10113 == nil then
				arg_337_1.var_.actorSpriteComps10113 = var_340_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_2 = 0.2

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.actorSpriteComps10113 then
					for iter_340_0, iter_340_1 in pairs(arg_337_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_340_1 then
							if arg_337_1.isInRecall_ then
								local var_340_4 = Mathf.Lerp(iter_340_1.color.r, arg_337_1.hightColor1.r, var_340_3)
								local var_340_5 = Mathf.Lerp(iter_340_1.color.g, arg_337_1.hightColor1.g, var_340_3)
								local var_340_6 = Mathf.Lerp(iter_340_1.color.b, arg_337_1.hightColor1.b, var_340_3)

								iter_340_1.color = Color.New(var_340_4, var_340_5, var_340_6)
							else
								local var_340_7 = Mathf.Lerp(iter_340_1.color.r, 1, var_340_3)

								iter_340_1.color = Color.New(var_340_7, var_340_7, var_340_7)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.actorSpriteComps10113 then
				for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_340_3 then
						if arg_337_1.isInRecall_ then
							iter_340_3.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps10113 = nil
			end

			local var_340_8 = arg_337_1.actors_["1034"]
			local var_340_9 = 0

			if var_340_9 < arg_337_1.time_ and arg_337_1.time_ <= var_340_9 + arg_340_0 and not isNil(var_340_8) and arg_337_1.var_.actorSpriteComps1034 == nil then
				arg_337_1.var_.actorSpriteComps1034 = var_340_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_10 = 0.2

			if var_340_9 <= arg_337_1.time_ and arg_337_1.time_ < var_340_9 + var_340_10 and not isNil(var_340_8) then
				local var_340_11 = (arg_337_1.time_ - var_340_9) / var_340_10

				if arg_337_1.var_.actorSpriteComps1034 then
					for iter_340_4, iter_340_5 in pairs(arg_337_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_340_5 then
							if arg_337_1.isInRecall_ then
								local var_340_12 = Mathf.Lerp(iter_340_5.color.r, arg_337_1.hightColor2.r, var_340_11)
								local var_340_13 = Mathf.Lerp(iter_340_5.color.g, arg_337_1.hightColor2.g, var_340_11)
								local var_340_14 = Mathf.Lerp(iter_340_5.color.b, arg_337_1.hightColor2.b, var_340_11)

								iter_340_5.color = Color.New(var_340_12, var_340_13, var_340_14)
							else
								local var_340_15 = Mathf.Lerp(iter_340_5.color.r, 0.5, var_340_11)

								iter_340_5.color = Color.New(var_340_15, var_340_15, var_340_15)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_9 + var_340_10 and arg_337_1.time_ < var_340_9 + var_340_10 + arg_340_0 and not isNil(var_340_8) and arg_337_1.var_.actorSpriteComps1034 then
				for iter_340_6, iter_340_7 in pairs(arg_337_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_340_7 then
						if arg_337_1.isInRecall_ then
							iter_340_7.color = arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_340_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps1034 = nil
			end

			local var_340_16 = arg_337_1.actors_["10113"].transform
			local var_340_17 = 0

			if var_340_17 < arg_337_1.time_ and arg_337_1.time_ <= var_340_17 + arg_340_0 then
				arg_337_1.var_.moveOldPos10113 = var_340_16.localPosition
				var_340_16.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10113", 4)

				local var_340_18 = var_340_16.childCount

				for iter_340_8 = 0, var_340_18 - 1 do
					local var_340_19 = var_340_16:GetChild(iter_340_8)

					if var_340_19.name == "split_4" or not string.find(var_340_19.name, "split") then
						var_340_19.gameObject:SetActive(true)
					else
						var_340_19.gameObject:SetActive(false)
					end
				end
			end

			local var_340_20 = 0.001

			if var_340_17 <= arg_337_1.time_ and arg_337_1.time_ < var_340_17 + var_340_20 then
				local var_340_21 = (arg_337_1.time_ - var_340_17) / var_340_20
				local var_340_22 = Vector3.New(377.3, -328.4, -517.4)

				var_340_16.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10113, var_340_22, var_340_21)
			end

			if arg_337_1.time_ >= var_340_17 + var_340_20 and arg_337_1.time_ < var_340_17 + var_340_20 + arg_340_0 then
				var_340_16.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_340_23 = 0
			local var_340_24 = 0.375

			if var_340_23 < arg_337_1.time_ and arg_337_1.time_ <= var_340_23 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_25 = arg_337_1:FormatText(StoryNameCfg[1117].name)

				arg_337_1.leftNameTxt_.text = var_340_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_26 = arg_337_1:GetWordFromCfg(417111081)
				local var_340_27 = arg_337_1:FormatText(var_340_26.content)

				arg_337_1.text_.text = var_340_27

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_28 = 15
				local var_340_29 = utf8.len(var_340_27)
				local var_340_30 = var_340_28 <= 0 and var_340_24 or var_340_24 * (var_340_29 / var_340_28)

				if var_340_30 > 0 and var_340_24 < var_340_30 then
					arg_337_1.talkMaxDuration = var_340_30

					if var_340_30 + var_340_23 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_30 + var_340_23
					end
				end

				arg_337_1.text_.text = var_340_27
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111081", "story_v_out_417111.awb") ~= 0 then
					local var_340_31 = manager.audio:GetVoiceLength("story_v_out_417111", "417111081", "story_v_out_417111.awb") / 1000

					if var_340_31 + var_340_23 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_31 + var_340_23
					end

					if var_340_26.prefab_name ~= "" and arg_337_1.actors_[var_340_26.prefab_name] ~= nil then
						local var_340_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_26.prefab_name].transform, "story_v_out_417111", "417111081", "story_v_out_417111.awb")

						arg_337_1:RecordAudio("417111081", var_340_32)
						arg_337_1:RecordAudio("417111081", var_340_32)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_417111", "417111081", "story_v_out_417111.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_417111", "417111081", "story_v_out_417111.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_33 = math.max(var_340_24, arg_337_1.talkMaxDuration)

			if var_340_23 <= arg_337_1.time_ and arg_337_1.time_ < var_340_23 + var_340_33 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_23) / var_340_33

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_23 + var_340_33 and arg_337_1.time_ < var_340_23 + var_340_33 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
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

		arg_337_1:InitPlayNodeList()
	end,
	Play417111082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 417111082
		arg_341_1.duration_ = 9.8

		local var_341_0 = {
			zh = 9.8,
			ja = 3.966
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play417111083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10113"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos10113 = var_344_0.localPosition
				var_344_0.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10113", 4)

				local var_344_2 = var_344_0.childCount

				for iter_344_0 = 0, var_344_2 - 1 do
					local var_344_3 = var_344_0:GetChild(iter_344_0)

					if var_344_3.name == "split_6" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_4 then
				local var_344_5 = (arg_341_1.time_ - var_344_1) / var_344_4
				local var_344_6 = Vector3.New(377.3, -328.4, -517.4)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10113, var_344_6, var_344_5)
			end

			if arg_341_1.time_ >= var_344_1 + var_344_4 and arg_341_1.time_ < var_344_1 + var_344_4 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_344_7 = 0
			local var_344_8 = 1.025

			if var_344_7 < arg_341_1.time_ and arg_341_1.time_ <= var_344_7 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_9 = arg_341_1:FormatText(StoryNameCfg[1117].name)

				arg_341_1.leftNameTxt_.text = var_344_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_10 = arg_341_1:GetWordFromCfg(417111082)
				local var_344_11 = arg_341_1:FormatText(var_344_10.content)

				arg_341_1.text_.text = var_344_11

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_12 = 41
				local var_344_13 = utf8.len(var_344_11)
				local var_344_14 = var_344_12 <= 0 and var_344_8 or var_344_8 * (var_344_13 / var_344_12)

				if var_344_14 > 0 and var_344_8 < var_344_14 then
					arg_341_1.talkMaxDuration = var_344_14

					if var_344_14 + var_344_7 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_7
					end
				end

				arg_341_1.text_.text = var_344_11
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111082", "story_v_out_417111.awb") ~= 0 then
					local var_344_15 = manager.audio:GetVoiceLength("story_v_out_417111", "417111082", "story_v_out_417111.awb") / 1000

					if var_344_15 + var_344_7 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_15 + var_344_7
					end

					if var_344_10.prefab_name ~= "" and arg_341_1.actors_[var_344_10.prefab_name] ~= nil then
						local var_344_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_10.prefab_name].transform, "story_v_out_417111", "417111082", "story_v_out_417111.awb")

						arg_341_1:RecordAudio("417111082", var_344_16)
						arg_341_1:RecordAudio("417111082", var_344_16)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_417111", "417111082", "story_v_out_417111.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_417111", "417111082", "story_v_out_417111.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_17 = math.max(var_344_8, arg_341_1.talkMaxDuration)

			if var_344_7 <= arg_341_1.time_ and arg_341_1.time_ < var_344_7 + var_344_17 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_7) / var_344_17

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_7 + var_344_17 and arg_341_1.time_ < var_344_7 + var_344_17 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play417111083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 417111083
		arg_345_1.duration_ = 10.17

		local var_345_0 = {
			zh = 6.933,
			ja = 10.166
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
				arg_345_0:Play417111084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 0.775

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_2 = arg_345_1:FormatText(StoryNameCfg[1117].name)

				arg_345_1.leftNameTxt_.text = var_348_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_3 = arg_345_1:GetWordFromCfg(417111083)
				local var_348_4 = arg_345_1:FormatText(var_348_3.content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 31
				local var_348_6 = utf8.len(var_348_4)
				local var_348_7 = var_348_5 <= 0 and var_348_1 or var_348_1 * (var_348_6 / var_348_5)

				if var_348_7 > 0 and var_348_1 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111083", "story_v_out_417111.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111083", "story_v_out_417111.awb") / 1000

					if var_348_8 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_0
					end

					if var_348_3.prefab_name ~= "" and arg_345_1.actors_[var_348_3.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_3.prefab_name].transform, "story_v_out_417111", "417111083", "story_v_out_417111.awb")

						arg_345_1:RecordAudio("417111083", var_348_9)
						arg_345_1:RecordAudio("417111083", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_417111", "417111083", "story_v_out_417111.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_417111", "417111083", "story_v_out_417111.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_10 and arg_345_1.time_ < var_348_0 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play417111084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 417111084
		arg_349_1.duration_ = 15.83

		local var_349_0 = {
			zh = 13.566,
			ja = 15.833
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play417111085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 1.3

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[1117].name)

				arg_349_1.leftNameTxt_.text = var_352_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_3 = arg_349_1:GetWordFromCfg(417111084)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 52
				local var_352_6 = utf8.len(var_352_4)
				local var_352_7 = var_352_5 <= 0 and var_352_1 or var_352_1 * (var_352_6 / var_352_5)

				if var_352_7 > 0 and var_352_1 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111084", "story_v_out_417111.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111084", "story_v_out_417111.awb") / 1000

					if var_352_8 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_0
					end

					if var_352_3.prefab_name ~= "" and arg_349_1.actors_[var_352_3.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_3.prefab_name].transform, "story_v_out_417111", "417111084", "story_v_out_417111.awb")

						arg_349_1:RecordAudio("417111084", var_352_9)
						arg_349_1:RecordAudio("417111084", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_417111", "417111084", "story_v_out_417111.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_417111", "417111084", "story_v_out_417111.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_10 and arg_349_1.time_ < var_352_0 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play417111085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 417111085
		arg_353_1.duration_ = 7.17

		local var_353_0 = {
			zh = 6.533,
			ja = 7.166
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
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play417111086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1034"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps1034 == nil then
				arg_353_1.var_.actorSpriteComps1034 = var_356_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_2 = 0.2

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.actorSpriteComps1034 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								local var_356_4 = Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, var_356_3)
								local var_356_5 = Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, var_356_3)
								local var_356_6 = Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, var_356_3)

								iter_356_1.color = Color.New(var_356_4, var_356_5, var_356_6)
							else
								local var_356_7 = Mathf.Lerp(iter_356_1.color.r, 1, var_356_3)

								iter_356_1.color = Color.New(var_356_7, var_356_7, var_356_7)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps1034 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_356_3 then
						if arg_353_1.isInRecall_ then
							iter_356_3.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps1034 = nil
			end

			local var_356_8 = arg_353_1.actors_["10113"]
			local var_356_9 = 0

			if var_356_9 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 and not isNil(var_356_8) and arg_353_1.var_.actorSpriteComps10113 == nil then
				arg_353_1.var_.actorSpriteComps10113 = var_356_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_10 = 0.2

			if var_356_9 <= arg_353_1.time_ and arg_353_1.time_ < var_356_9 + var_356_10 and not isNil(var_356_8) then
				local var_356_11 = (arg_353_1.time_ - var_356_9) / var_356_10

				if arg_353_1.var_.actorSpriteComps10113 then
					for iter_356_4, iter_356_5 in pairs(arg_353_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_356_5 then
							if arg_353_1.isInRecall_ then
								local var_356_12 = Mathf.Lerp(iter_356_5.color.r, arg_353_1.hightColor2.r, var_356_11)
								local var_356_13 = Mathf.Lerp(iter_356_5.color.g, arg_353_1.hightColor2.g, var_356_11)
								local var_356_14 = Mathf.Lerp(iter_356_5.color.b, arg_353_1.hightColor2.b, var_356_11)

								iter_356_5.color = Color.New(var_356_12, var_356_13, var_356_14)
							else
								local var_356_15 = Mathf.Lerp(iter_356_5.color.r, 0.5, var_356_11)

								iter_356_5.color = Color.New(var_356_15, var_356_15, var_356_15)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_9 + var_356_10 and arg_353_1.time_ < var_356_9 + var_356_10 + arg_356_0 and not isNil(var_356_8) and arg_353_1.var_.actorSpriteComps10113 then
				for iter_356_6, iter_356_7 in pairs(arg_353_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_356_7 then
						if arg_353_1.isInRecall_ then
							iter_356_7.color = arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_356_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps10113 = nil
			end

			local var_356_16 = 0
			local var_356_17 = 0.725

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_18 = arg_353_1:FormatText(StoryNameCfg[1109].name)

				arg_353_1.leftNameTxt_.text = var_356_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_19 = arg_353_1:GetWordFromCfg(417111085)
				local var_356_20 = arg_353_1:FormatText(var_356_19.content)

				arg_353_1.text_.text = var_356_20

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_21 = 29
				local var_356_22 = utf8.len(var_356_20)
				local var_356_23 = var_356_21 <= 0 and var_356_17 or var_356_17 * (var_356_22 / var_356_21)

				if var_356_23 > 0 and var_356_17 < var_356_23 then
					arg_353_1.talkMaxDuration = var_356_23

					if var_356_23 + var_356_16 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_23 + var_356_16
					end
				end

				arg_353_1.text_.text = var_356_20
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111085", "story_v_out_417111.awb") ~= 0 then
					local var_356_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111085", "story_v_out_417111.awb") / 1000

					if var_356_24 + var_356_16 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_24 + var_356_16
					end

					if var_356_19.prefab_name ~= "" and arg_353_1.actors_[var_356_19.prefab_name] ~= nil then
						local var_356_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_19.prefab_name].transform, "story_v_out_417111", "417111085", "story_v_out_417111.awb")

						arg_353_1:RecordAudio("417111085", var_356_25)
						arg_353_1:RecordAudio("417111085", var_356_25)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_417111", "417111085", "story_v_out_417111.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_417111", "417111085", "story_v_out_417111.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_26 = math.max(var_356_17, arg_353_1.talkMaxDuration)

			if var_356_16 <= arg_353_1.time_ and arg_353_1.time_ < var_356_16 + var_356_26 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_16) / var_356_26

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_16 + var_356_26 and arg_353_1.time_ < var_356_16 + var_356_26 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play417111086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 417111086
		arg_357_1.duration_ = 11.03

		local var_357_0 = {
			zh = 7.766,
			ja = 11.033
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play417111087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["10113"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps10113 == nil then
				arg_357_1.var_.actorSpriteComps10113 = var_360_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_2 = 0.2

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.actorSpriteComps10113 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								local var_360_4 = Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, var_360_3)
								local var_360_5 = Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, var_360_3)
								local var_360_6 = Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, var_360_3)

								iter_360_1.color = Color.New(var_360_4, var_360_5, var_360_6)
							else
								local var_360_7 = Mathf.Lerp(iter_360_1.color.r, 1, var_360_3)

								iter_360_1.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps10113 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_360_3 then
						if arg_357_1.isInRecall_ then
							iter_360_3.color = arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_360_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps10113 = nil
			end

			local var_360_8 = arg_357_1.actors_["1034"]
			local var_360_9 = 0

			if var_360_9 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps1034 == nil then
				arg_357_1.var_.actorSpriteComps1034 = var_360_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_10 = 0.2

			if var_360_9 <= arg_357_1.time_ and arg_357_1.time_ < var_360_9 + var_360_10 and not isNil(var_360_8) then
				local var_360_11 = (arg_357_1.time_ - var_360_9) / var_360_10

				if arg_357_1.var_.actorSpriteComps1034 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								local var_360_12 = Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor2.r, var_360_11)
								local var_360_13 = Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor2.g, var_360_11)
								local var_360_14 = Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor2.b, var_360_11)

								iter_360_5.color = Color.New(var_360_12, var_360_13, var_360_14)
							else
								local var_360_15 = Mathf.Lerp(iter_360_5.color.r, 0.5, var_360_11)

								iter_360_5.color = Color.New(var_360_15, var_360_15, var_360_15)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_9 + var_360_10 and arg_357_1.time_ < var_360_9 + var_360_10 + arg_360_0 and not isNil(var_360_8) and arg_357_1.var_.actorSpriteComps1034 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_360_7 then
						if arg_357_1.isInRecall_ then
							iter_360_7.color = arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_360_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1034 = nil
			end

			local var_360_16 = arg_357_1.actors_["10113"].transform
			local var_360_17 = 0

			if var_360_17 < arg_357_1.time_ and arg_357_1.time_ <= var_360_17 + arg_360_0 then
				arg_357_1.var_.moveOldPos10113 = var_360_16.localPosition
				var_360_16.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("10113", 4)

				local var_360_18 = var_360_16.childCount

				for iter_360_8 = 0, var_360_18 - 1 do
					local var_360_19 = var_360_16:GetChild(iter_360_8)

					if var_360_19.name == "split_4" or not string.find(var_360_19.name, "split") then
						var_360_19.gameObject:SetActive(true)
					else
						var_360_19.gameObject:SetActive(false)
					end
				end
			end

			local var_360_20 = 0.001

			if var_360_17 <= arg_357_1.time_ and arg_357_1.time_ < var_360_17 + var_360_20 then
				local var_360_21 = (arg_357_1.time_ - var_360_17) / var_360_20
				local var_360_22 = Vector3.New(377.3, -328.4, -517.4)

				var_360_16.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10113, var_360_22, var_360_21)
			end

			if arg_357_1.time_ >= var_360_17 + var_360_20 and arg_357_1.time_ < var_360_17 + var_360_20 + arg_360_0 then
				var_360_16.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_360_23 = 0
			local var_360_24 = 0.925

			if var_360_23 < arg_357_1.time_ and arg_357_1.time_ <= var_360_23 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_25 = arg_357_1:FormatText(StoryNameCfg[1117].name)

				arg_357_1.leftNameTxt_.text = var_360_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_26 = arg_357_1:GetWordFromCfg(417111086)
				local var_360_27 = arg_357_1:FormatText(var_360_26.content)

				arg_357_1.text_.text = var_360_27

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_28 = 37
				local var_360_29 = utf8.len(var_360_27)
				local var_360_30 = var_360_28 <= 0 and var_360_24 or var_360_24 * (var_360_29 / var_360_28)

				if var_360_30 > 0 and var_360_24 < var_360_30 then
					arg_357_1.talkMaxDuration = var_360_30

					if var_360_30 + var_360_23 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_30 + var_360_23
					end
				end

				arg_357_1.text_.text = var_360_27
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111086", "story_v_out_417111.awb") ~= 0 then
					local var_360_31 = manager.audio:GetVoiceLength("story_v_out_417111", "417111086", "story_v_out_417111.awb") / 1000

					if var_360_31 + var_360_23 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_31 + var_360_23
					end

					if var_360_26.prefab_name ~= "" and arg_357_1.actors_[var_360_26.prefab_name] ~= nil then
						local var_360_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_26.prefab_name].transform, "story_v_out_417111", "417111086", "story_v_out_417111.awb")

						arg_357_1:RecordAudio("417111086", var_360_32)
						arg_357_1:RecordAudio("417111086", var_360_32)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_417111", "417111086", "story_v_out_417111.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_417111", "417111086", "story_v_out_417111.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_33 = math.max(var_360_24, arg_357_1.talkMaxDuration)

			if var_360_23 <= arg_357_1.time_ and arg_357_1.time_ < var_360_23 + var_360_33 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_23) / var_360_33

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_23 + var_360_33 and arg_357_1.time_ < var_360_23 + var_360_33 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play417111087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 417111087
		arg_361_1.duration_ = 7.23

		local var_361_0 = {
			zh = 5.066,
			ja = 7.233
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play417111088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["10113"].transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.var_.moveOldPos10113 = var_364_0.localPosition
				var_364_0.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10113", 4)

				local var_364_2 = var_364_0.childCount

				for iter_364_0 = 0, var_364_2 - 1 do
					local var_364_3 = var_364_0:GetChild(iter_364_0)

					if var_364_3.name == "split_6" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_4 then
				local var_364_5 = (arg_361_1.time_ - var_364_1) / var_364_4
				local var_364_6 = Vector3.New(377.3, -328.4, -517.4)

				var_364_0.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10113, var_364_6, var_364_5)
			end

			if arg_361_1.time_ >= var_364_1 + var_364_4 and arg_361_1.time_ < var_364_1 + var_364_4 + arg_364_0 then
				var_364_0.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_364_7 = 0
			local var_364_8 = 0.65

			if var_364_7 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_9 = arg_361_1:FormatText(StoryNameCfg[1117].name)

				arg_361_1.leftNameTxt_.text = var_364_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_10 = arg_361_1:GetWordFromCfg(417111087)
				local var_364_11 = arg_361_1:FormatText(var_364_10.content)

				arg_361_1.text_.text = var_364_11

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_12 = 26
				local var_364_13 = utf8.len(var_364_11)
				local var_364_14 = var_364_12 <= 0 and var_364_8 or var_364_8 * (var_364_13 / var_364_12)

				if var_364_14 > 0 and var_364_8 < var_364_14 then
					arg_361_1.talkMaxDuration = var_364_14

					if var_364_14 + var_364_7 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_14 + var_364_7
					end
				end

				arg_361_1.text_.text = var_364_11
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111087", "story_v_out_417111.awb") ~= 0 then
					local var_364_15 = manager.audio:GetVoiceLength("story_v_out_417111", "417111087", "story_v_out_417111.awb") / 1000

					if var_364_15 + var_364_7 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_15 + var_364_7
					end

					if var_364_10.prefab_name ~= "" and arg_361_1.actors_[var_364_10.prefab_name] ~= nil then
						local var_364_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_10.prefab_name].transform, "story_v_out_417111", "417111087", "story_v_out_417111.awb")

						arg_361_1:RecordAudio("417111087", var_364_16)
						arg_361_1:RecordAudio("417111087", var_364_16)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_417111", "417111087", "story_v_out_417111.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_417111", "417111087", "story_v_out_417111.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_17 = math.max(var_364_8, arg_361_1.talkMaxDuration)

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_17 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_7) / var_364_17

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_7 + var_364_17 and arg_361_1.time_ < var_364_7 + var_364_17 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play417111088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 417111088
		arg_365_1.duration_ = 8.3

		local var_365_0 = {
			zh = 6.633,
			ja = 8.3
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play417111089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1034"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.actorSpriteComps1034 == nil then
				arg_365_1.var_.actorSpriteComps1034 = var_368_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_2 = 0.2

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.actorSpriteComps1034 then
					for iter_368_0, iter_368_1 in pairs(arg_365_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_368_1 then
							if arg_365_1.isInRecall_ then
								local var_368_4 = Mathf.Lerp(iter_368_1.color.r, arg_365_1.hightColor1.r, var_368_3)
								local var_368_5 = Mathf.Lerp(iter_368_1.color.g, arg_365_1.hightColor1.g, var_368_3)
								local var_368_6 = Mathf.Lerp(iter_368_1.color.b, arg_365_1.hightColor1.b, var_368_3)

								iter_368_1.color = Color.New(var_368_4, var_368_5, var_368_6)
							else
								local var_368_7 = Mathf.Lerp(iter_368_1.color.r, 1, var_368_3)

								iter_368_1.color = Color.New(var_368_7, var_368_7, var_368_7)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.actorSpriteComps1034 then
				for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_368_3 then
						if arg_365_1.isInRecall_ then
							iter_368_3.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps1034 = nil
			end

			local var_368_8 = arg_365_1.actors_["10113"]
			local var_368_9 = 0

			if var_368_9 < arg_365_1.time_ and arg_365_1.time_ <= var_368_9 + arg_368_0 and not isNil(var_368_8) and arg_365_1.var_.actorSpriteComps10113 == nil then
				arg_365_1.var_.actorSpriteComps10113 = var_368_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_10 = 0.2

			if var_368_9 <= arg_365_1.time_ and arg_365_1.time_ < var_368_9 + var_368_10 and not isNil(var_368_8) then
				local var_368_11 = (arg_365_1.time_ - var_368_9) / var_368_10

				if arg_365_1.var_.actorSpriteComps10113 then
					for iter_368_4, iter_368_5 in pairs(arg_365_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_368_5 then
							if arg_365_1.isInRecall_ then
								local var_368_12 = Mathf.Lerp(iter_368_5.color.r, arg_365_1.hightColor2.r, var_368_11)
								local var_368_13 = Mathf.Lerp(iter_368_5.color.g, arg_365_1.hightColor2.g, var_368_11)
								local var_368_14 = Mathf.Lerp(iter_368_5.color.b, arg_365_1.hightColor2.b, var_368_11)

								iter_368_5.color = Color.New(var_368_12, var_368_13, var_368_14)
							else
								local var_368_15 = Mathf.Lerp(iter_368_5.color.r, 0.5, var_368_11)

								iter_368_5.color = Color.New(var_368_15, var_368_15, var_368_15)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_9 + var_368_10 and arg_365_1.time_ < var_368_9 + var_368_10 + arg_368_0 and not isNil(var_368_8) and arg_365_1.var_.actorSpriteComps10113 then
				for iter_368_6, iter_368_7 in pairs(arg_365_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_368_7 then
						if arg_365_1.isInRecall_ then
							iter_368_7.color = arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_368_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps10113 = nil
			end

			local var_368_16 = arg_365_1.actors_["1034"].transform
			local var_368_17 = 0

			if var_368_17 < arg_365_1.time_ and arg_365_1.time_ <= var_368_17 + arg_368_0 then
				arg_365_1.var_.moveOldPos1034 = var_368_16.localPosition
				var_368_16.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1034", 2)

				local var_368_18 = var_368_16.childCount

				for iter_368_8 = 0, var_368_18 - 1 do
					local var_368_19 = var_368_16:GetChild(iter_368_8)

					if var_368_19.name == "split_6" or not string.find(var_368_19.name, "split") then
						var_368_19.gameObject:SetActive(true)
					else
						var_368_19.gameObject:SetActive(false)
					end
				end
			end

			local var_368_20 = 0.001

			if var_368_17 <= arg_365_1.time_ and arg_365_1.time_ < var_368_17 + var_368_20 then
				local var_368_21 = (arg_365_1.time_ - var_368_17) / var_368_20
				local var_368_22 = Vector3.New(-390, -331.9, -324)

				var_368_16.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1034, var_368_22, var_368_21)
			end

			if arg_365_1.time_ >= var_368_17 + var_368_20 and arg_365_1.time_ < var_368_17 + var_368_20 + arg_368_0 then
				var_368_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_368_23 = 0
			local var_368_24 = 0.75

			if var_368_23 < arg_365_1.time_ and arg_365_1.time_ <= var_368_23 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_25 = arg_365_1:FormatText(StoryNameCfg[1109].name)

				arg_365_1.leftNameTxt_.text = var_368_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_26 = arg_365_1:GetWordFromCfg(417111088)
				local var_368_27 = arg_365_1:FormatText(var_368_26.content)

				arg_365_1.text_.text = var_368_27

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_28 = 30
				local var_368_29 = utf8.len(var_368_27)
				local var_368_30 = var_368_28 <= 0 and var_368_24 or var_368_24 * (var_368_29 / var_368_28)

				if var_368_30 > 0 and var_368_24 < var_368_30 then
					arg_365_1.talkMaxDuration = var_368_30

					if var_368_30 + var_368_23 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_30 + var_368_23
					end
				end

				arg_365_1.text_.text = var_368_27
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111088", "story_v_out_417111.awb") ~= 0 then
					local var_368_31 = manager.audio:GetVoiceLength("story_v_out_417111", "417111088", "story_v_out_417111.awb") / 1000

					if var_368_31 + var_368_23 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_31 + var_368_23
					end

					if var_368_26.prefab_name ~= "" and arg_365_1.actors_[var_368_26.prefab_name] ~= nil then
						local var_368_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_26.prefab_name].transform, "story_v_out_417111", "417111088", "story_v_out_417111.awb")

						arg_365_1:RecordAudio("417111088", var_368_32)
						arg_365_1:RecordAudio("417111088", var_368_32)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_417111", "417111088", "story_v_out_417111.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_417111", "417111088", "story_v_out_417111.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_33 = math.max(var_368_24, arg_365_1.talkMaxDuration)

			if var_368_23 <= arg_365_1.time_ and arg_365_1.time_ < var_368_23 + var_368_33 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_23) / var_368_33

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_23 + var_368_33 and arg_365_1.time_ < var_368_23 + var_368_33 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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

		arg_365_1:InitPlayNodeList()
	end,
	Play417111089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 417111089
		arg_369_1.duration_ = 4.13

		local var_369_0 = {
			zh = 2.333,
			ja = 4.133
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
				arg_369_0:Play417111090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["10113"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps10113 == nil then
				arg_369_1.var_.actorSpriteComps10113 = var_372_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_2 = 0.2

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.actorSpriteComps10113 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps10113 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_372_3 then
						if arg_369_1.isInRecall_ then
							iter_372_3.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps10113 = nil
			end

			local var_372_8 = arg_369_1.actors_["1034"]
			local var_372_9 = 0

			if var_372_9 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 and not isNil(var_372_8) and arg_369_1.var_.actorSpriteComps1034 == nil then
				arg_369_1.var_.actorSpriteComps1034 = var_372_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_10 = 0.2

			if var_372_9 <= arg_369_1.time_ and arg_369_1.time_ < var_372_9 + var_372_10 and not isNil(var_372_8) then
				local var_372_11 = (arg_369_1.time_ - var_372_9) / var_372_10

				if arg_369_1.var_.actorSpriteComps1034 then
					for iter_372_4, iter_372_5 in pairs(arg_369_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_372_5 then
							if arg_369_1.isInRecall_ then
								local var_372_12 = Mathf.Lerp(iter_372_5.color.r, arg_369_1.hightColor2.r, var_372_11)
								local var_372_13 = Mathf.Lerp(iter_372_5.color.g, arg_369_1.hightColor2.g, var_372_11)
								local var_372_14 = Mathf.Lerp(iter_372_5.color.b, arg_369_1.hightColor2.b, var_372_11)

								iter_372_5.color = Color.New(var_372_12, var_372_13, var_372_14)
							else
								local var_372_15 = Mathf.Lerp(iter_372_5.color.r, 0.5, var_372_11)

								iter_372_5.color = Color.New(var_372_15, var_372_15, var_372_15)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_9 + var_372_10 and arg_369_1.time_ < var_372_9 + var_372_10 + arg_372_0 and not isNil(var_372_8) and arg_369_1.var_.actorSpriteComps1034 then
				for iter_372_6, iter_372_7 in pairs(arg_369_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_372_7 then
						if arg_369_1.isInRecall_ then
							iter_372_7.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1034 = nil
			end

			local var_372_16 = 0
			local var_372_17 = 0.275

			if var_372_16 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_18 = arg_369_1:FormatText(StoryNameCfg[1117].name)

				arg_369_1.leftNameTxt_.text = var_372_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_19 = arg_369_1:GetWordFromCfg(417111089)
				local var_372_20 = arg_369_1:FormatText(var_372_19.content)

				arg_369_1.text_.text = var_372_20

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_21 = 11
				local var_372_22 = utf8.len(var_372_20)
				local var_372_23 = var_372_21 <= 0 and var_372_17 or var_372_17 * (var_372_22 / var_372_21)

				if var_372_23 > 0 and var_372_17 < var_372_23 then
					arg_369_1.talkMaxDuration = var_372_23

					if var_372_23 + var_372_16 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_23 + var_372_16
					end
				end

				arg_369_1.text_.text = var_372_20
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111089", "story_v_out_417111.awb") ~= 0 then
					local var_372_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111089", "story_v_out_417111.awb") / 1000

					if var_372_24 + var_372_16 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_24 + var_372_16
					end

					if var_372_19.prefab_name ~= "" and arg_369_1.actors_[var_372_19.prefab_name] ~= nil then
						local var_372_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_19.prefab_name].transform, "story_v_out_417111", "417111089", "story_v_out_417111.awb")

						arg_369_1:RecordAudio("417111089", var_372_25)
						arg_369_1:RecordAudio("417111089", var_372_25)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_417111", "417111089", "story_v_out_417111.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_417111", "417111089", "story_v_out_417111.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_26 = math.max(var_372_17, arg_369_1.talkMaxDuration)

			if var_372_16 <= arg_369_1.time_ and arg_369_1.time_ < var_372_16 + var_372_26 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_16) / var_372_26

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_16 + var_372_26 and arg_369_1.time_ < var_372_16 + var_372_26 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play417111090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 417111090
		arg_373_1.duration_ = 1.93

		local var_373_0 = {
			zh = 1.033,
			ja = 1.933
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
				arg_373_0:Play417111091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1034"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps1034 == nil then
				arg_373_1.var_.actorSpriteComps1034 = var_376_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_2 = 0.2

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.actorSpriteComps1034 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								local var_376_4 = Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, var_376_3)
								local var_376_5 = Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, var_376_3)
								local var_376_6 = Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, var_376_3)

								iter_376_1.color = Color.New(var_376_4, var_376_5, var_376_6)
							else
								local var_376_7 = Mathf.Lerp(iter_376_1.color.r, 1, var_376_3)

								iter_376_1.color = Color.New(var_376_7, var_376_7, var_376_7)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps1034 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_376_3 then
						if arg_373_1.isInRecall_ then
							iter_376_3.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps1034 = nil
			end

			local var_376_8 = arg_373_1.actors_["10113"]
			local var_376_9 = 0

			if var_376_9 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 and not isNil(var_376_8) and arg_373_1.var_.actorSpriteComps10113 == nil then
				arg_373_1.var_.actorSpriteComps10113 = var_376_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_10 = 0.2

			if var_376_9 <= arg_373_1.time_ and arg_373_1.time_ < var_376_9 + var_376_10 and not isNil(var_376_8) then
				local var_376_11 = (arg_373_1.time_ - var_376_9) / var_376_10

				if arg_373_1.var_.actorSpriteComps10113 then
					for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_376_5 then
							if arg_373_1.isInRecall_ then
								local var_376_12 = Mathf.Lerp(iter_376_5.color.r, arg_373_1.hightColor2.r, var_376_11)
								local var_376_13 = Mathf.Lerp(iter_376_5.color.g, arg_373_1.hightColor2.g, var_376_11)
								local var_376_14 = Mathf.Lerp(iter_376_5.color.b, arg_373_1.hightColor2.b, var_376_11)

								iter_376_5.color = Color.New(var_376_12, var_376_13, var_376_14)
							else
								local var_376_15 = Mathf.Lerp(iter_376_5.color.r, 0.5, var_376_11)

								iter_376_5.color = Color.New(var_376_15, var_376_15, var_376_15)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_9 + var_376_10 and arg_373_1.time_ < var_376_9 + var_376_10 + arg_376_0 and not isNil(var_376_8) and arg_373_1.var_.actorSpriteComps10113 then
				for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_376_7 then
						if arg_373_1.isInRecall_ then
							iter_376_7.color = arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_376_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps10113 = nil
			end

			local var_376_16 = arg_373_1.actors_["1034"].transform
			local var_376_17 = 0

			if var_376_17 < arg_373_1.time_ and arg_373_1.time_ <= var_376_17 + arg_376_0 then
				arg_373_1.var_.moveOldPos1034 = var_376_16.localPosition
				var_376_16.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1034", 2)

				local var_376_18 = var_376_16.childCount

				for iter_376_8 = 0, var_376_18 - 1 do
					local var_376_19 = var_376_16:GetChild(iter_376_8)

					if var_376_19.name == "split_6" or not string.find(var_376_19.name, "split") then
						var_376_19.gameObject:SetActive(true)
					else
						var_376_19.gameObject:SetActive(false)
					end
				end
			end

			local var_376_20 = 0.001

			if var_376_17 <= arg_373_1.time_ and arg_373_1.time_ < var_376_17 + var_376_20 then
				local var_376_21 = (arg_373_1.time_ - var_376_17) / var_376_20
				local var_376_22 = Vector3.New(-390, -331.9, -324)

				var_376_16.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1034, var_376_22, var_376_21)
			end

			if arg_373_1.time_ >= var_376_17 + var_376_20 and arg_373_1.time_ < var_376_17 + var_376_20 + arg_376_0 then
				var_376_16.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_376_23 = 0
			local var_376_24 = 0.125

			if var_376_23 < arg_373_1.time_ and arg_373_1.time_ <= var_376_23 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_25 = arg_373_1:FormatText(StoryNameCfg[1109].name)

				arg_373_1.leftNameTxt_.text = var_376_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_26 = arg_373_1:GetWordFromCfg(417111090)
				local var_376_27 = arg_373_1:FormatText(var_376_26.content)

				arg_373_1.text_.text = var_376_27

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_28 = 5
				local var_376_29 = utf8.len(var_376_27)
				local var_376_30 = var_376_28 <= 0 and var_376_24 or var_376_24 * (var_376_29 / var_376_28)

				if var_376_30 > 0 and var_376_24 < var_376_30 then
					arg_373_1.talkMaxDuration = var_376_30

					if var_376_30 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_30 + var_376_23
					end
				end

				arg_373_1.text_.text = var_376_27
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111090", "story_v_out_417111.awb") ~= 0 then
					local var_376_31 = manager.audio:GetVoiceLength("story_v_out_417111", "417111090", "story_v_out_417111.awb") / 1000

					if var_376_31 + var_376_23 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_31 + var_376_23
					end

					if var_376_26.prefab_name ~= "" and arg_373_1.actors_[var_376_26.prefab_name] ~= nil then
						local var_376_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_26.prefab_name].transform, "story_v_out_417111", "417111090", "story_v_out_417111.awb")

						arg_373_1:RecordAudio("417111090", var_376_32)
						arg_373_1:RecordAudio("417111090", var_376_32)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_417111", "417111090", "story_v_out_417111.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_417111", "417111090", "story_v_out_417111.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_33 = math.max(var_376_24, arg_373_1.talkMaxDuration)

			if var_376_23 <= arg_373_1.time_ and arg_373_1.time_ < var_376_23 + var_376_33 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_23) / var_376_33

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_23 + var_376_33 and arg_373_1.time_ < var_376_23 + var_376_33 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
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

		arg_373_1:InitPlayNodeList()
	end,
	Play417111091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 417111091
		arg_377_1.duration_ = 4.2

		local var_377_0 = {
			zh = 2.566,
			ja = 4.2
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
				arg_377_0:Play417111092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["10113"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.actorSpriteComps10113 == nil then
				arg_377_1.var_.actorSpriteComps10113 = var_380_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_2 = 0.2

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.actorSpriteComps10113 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								local var_380_4 = Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor1.r, var_380_3)
								local var_380_5 = Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor1.g, var_380_3)
								local var_380_6 = Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor1.b, var_380_3)

								iter_380_1.color = Color.New(var_380_4, var_380_5, var_380_6)
							else
								local var_380_7 = Mathf.Lerp(iter_380_1.color.r, 1, var_380_3)

								iter_380_1.color = Color.New(var_380_7, var_380_7, var_380_7)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.actorSpriteComps10113 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_380_3 then
						if arg_377_1.isInRecall_ then
							iter_380_3.color = arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_380_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps10113 = nil
			end

			local var_380_8 = arg_377_1.actors_["1034"]
			local var_380_9 = 0

			if var_380_9 < arg_377_1.time_ and arg_377_1.time_ <= var_380_9 + arg_380_0 and not isNil(var_380_8) and arg_377_1.var_.actorSpriteComps1034 == nil then
				arg_377_1.var_.actorSpriteComps1034 = var_380_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_10 = 0.2

			if var_380_9 <= arg_377_1.time_ and arg_377_1.time_ < var_380_9 + var_380_10 and not isNil(var_380_8) then
				local var_380_11 = (arg_377_1.time_ - var_380_9) / var_380_10

				if arg_377_1.var_.actorSpriteComps1034 then
					for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_380_5 then
							if arg_377_1.isInRecall_ then
								local var_380_12 = Mathf.Lerp(iter_380_5.color.r, arg_377_1.hightColor2.r, var_380_11)
								local var_380_13 = Mathf.Lerp(iter_380_5.color.g, arg_377_1.hightColor2.g, var_380_11)
								local var_380_14 = Mathf.Lerp(iter_380_5.color.b, arg_377_1.hightColor2.b, var_380_11)

								iter_380_5.color = Color.New(var_380_12, var_380_13, var_380_14)
							else
								local var_380_15 = Mathf.Lerp(iter_380_5.color.r, 0.5, var_380_11)

								iter_380_5.color = Color.New(var_380_15, var_380_15, var_380_15)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_9 + var_380_10 and arg_377_1.time_ < var_380_9 + var_380_10 + arg_380_0 and not isNil(var_380_8) and arg_377_1.var_.actorSpriteComps1034 then
				for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_380_7 then
						if arg_377_1.isInRecall_ then
							iter_380_7.color = arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_380_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps1034 = nil
			end

			local var_380_16 = arg_377_1.actors_["10113"].transform
			local var_380_17 = 0

			if var_380_17 < arg_377_1.time_ and arg_377_1.time_ <= var_380_17 + arg_380_0 then
				arg_377_1.var_.moveOldPos10113 = var_380_16.localPosition
				var_380_16.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10113", 4)

				local var_380_18 = var_380_16.childCount

				for iter_380_8 = 0, var_380_18 - 1 do
					local var_380_19 = var_380_16:GetChild(iter_380_8)

					if var_380_19.name == "" or not string.find(var_380_19.name, "split") then
						var_380_19.gameObject:SetActive(true)
					else
						var_380_19.gameObject:SetActive(false)
					end
				end
			end

			local var_380_20 = 0.001

			if var_380_17 <= arg_377_1.time_ and arg_377_1.time_ < var_380_17 + var_380_20 then
				local var_380_21 = (arg_377_1.time_ - var_380_17) / var_380_20
				local var_380_22 = Vector3.New(377.3, -328.4, -517.4)

				var_380_16.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10113, var_380_22, var_380_21)
			end

			if arg_377_1.time_ >= var_380_17 + var_380_20 and arg_377_1.time_ < var_380_17 + var_380_20 + arg_380_0 then
				var_380_16.localPosition = Vector3.New(377.3, -328.4, -517.4)
			end

			local var_380_23 = 0
			local var_380_24 = 0.3

			if var_380_23 < arg_377_1.time_ and arg_377_1.time_ <= var_380_23 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_25 = arg_377_1:FormatText(StoryNameCfg[1117].name)

				arg_377_1.leftNameTxt_.text = var_380_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_26 = arg_377_1:GetWordFromCfg(417111091)
				local var_380_27 = arg_377_1:FormatText(var_380_26.content)

				arg_377_1.text_.text = var_380_27

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_28 = 12
				local var_380_29 = utf8.len(var_380_27)
				local var_380_30 = var_380_28 <= 0 and var_380_24 or var_380_24 * (var_380_29 / var_380_28)

				if var_380_30 > 0 and var_380_24 < var_380_30 then
					arg_377_1.talkMaxDuration = var_380_30

					if var_380_30 + var_380_23 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_30 + var_380_23
					end
				end

				arg_377_1.text_.text = var_380_27
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111091", "story_v_out_417111.awb") ~= 0 then
					local var_380_31 = manager.audio:GetVoiceLength("story_v_out_417111", "417111091", "story_v_out_417111.awb") / 1000

					if var_380_31 + var_380_23 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_31 + var_380_23
					end

					if var_380_26.prefab_name ~= "" and arg_377_1.actors_[var_380_26.prefab_name] ~= nil then
						local var_380_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_26.prefab_name].transform, "story_v_out_417111", "417111091", "story_v_out_417111.awb")

						arg_377_1:RecordAudio("417111091", var_380_32)
						arg_377_1:RecordAudio("417111091", var_380_32)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_417111", "417111091", "story_v_out_417111.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_417111", "417111091", "story_v_out_417111.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_33 = math.max(var_380_24, arg_377_1.talkMaxDuration)

			if var_380_23 <= arg_377_1.time_ and arg_377_1.time_ < var_380_23 + var_380_33 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_23) / var_380_33

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_23 + var_380_33 and arg_377_1.time_ < var_380_23 + var_380_33 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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

		arg_377_1:InitPlayNodeList()
	end,
	Play417111092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 417111092
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play417111093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["10113"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.actorSpriteComps10113 == nil then
				arg_381_1.var_.actorSpriteComps10113 = var_384_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_2 = 0.2

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.actorSpriteComps10113 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_384_1 then
							if arg_381_1.isInRecall_ then
								local var_384_4 = Mathf.Lerp(iter_384_1.color.r, arg_381_1.hightColor2.r, var_384_3)
								local var_384_5 = Mathf.Lerp(iter_384_1.color.g, arg_381_1.hightColor2.g, var_384_3)
								local var_384_6 = Mathf.Lerp(iter_384_1.color.b, arg_381_1.hightColor2.b, var_384_3)

								iter_384_1.color = Color.New(var_384_4, var_384_5, var_384_6)
							else
								local var_384_7 = Mathf.Lerp(iter_384_1.color.r, 0.5, var_384_3)

								iter_384_1.color = Color.New(var_384_7, var_384_7, var_384_7)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.actorSpriteComps10113 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_384_3 then
						if arg_381_1.isInRecall_ then
							iter_384_3.color = arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_384_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps10113 = nil
			end

			local var_384_8 = arg_381_1.actors_["1034"].transform
			local var_384_9 = 0

			if var_384_9 < arg_381_1.time_ and arg_381_1.time_ <= var_384_9 + arg_384_0 then
				arg_381_1.var_.moveOldPos1034 = var_384_8.localPosition
				var_384_8.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1034", 7)

				local var_384_10 = var_384_8.childCount

				for iter_384_4 = 0, var_384_10 - 1 do
					local var_384_11 = var_384_8:GetChild(iter_384_4)

					if var_384_11.name == "" or not string.find(var_384_11.name, "split") then
						var_384_11.gameObject:SetActive(true)
					else
						var_384_11.gameObject:SetActive(false)
					end
				end
			end

			local var_384_12 = 0.001

			if var_384_9 <= arg_381_1.time_ and arg_381_1.time_ < var_384_9 + var_384_12 then
				local var_384_13 = (arg_381_1.time_ - var_384_9) / var_384_12
				local var_384_14 = Vector3.New(0, -2000, 0)

				var_384_8.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1034, var_384_14, var_384_13)
			end

			if arg_381_1.time_ >= var_384_9 + var_384_12 and arg_381_1.time_ < var_384_9 + var_384_12 + arg_384_0 then
				var_384_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_384_15 = arg_381_1.actors_["10113"].transform
			local var_384_16 = 0

			if var_384_16 < arg_381_1.time_ and arg_381_1.time_ <= var_384_16 + arg_384_0 then
				arg_381_1.var_.moveOldPos10113 = var_384_15.localPosition
				var_384_15.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10113", 7)

				local var_384_17 = var_384_15.childCount

				for iter_384_5 = 0, var_384_17 - 1 do
					local var_384_18 = var_384_15:GetChild(iter_384_5)

					if var_384_18.name == "" or not string.find(var_384_18.name, "split") then
						var_384_18.gameObject:SetActive(true)
					else
						var_384_18.gameObject:SetActive(false)
					end
				end
			end

			local var_384_19 = 0.001

			if var_384_16 <= arg_381_1.time_ and arg_381_1.time_ < var_384_16 + var_384_19 then
				local var_384_20 = (arg_381_1.time_ - var_384_16) / var_384_19
				local var_384_21 = Vector3.New(0, -2000, 0)

				var_384_15.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10113, var_384_21, var_384_20)
			end

			if arg_381_1.time_ >= var_384_16 + var_384_19 and arg_381_1.time_ < var_384_16 + var_384_19 + arg_384_0 then
				var_384_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_384_22 = 0
			local var_384_23 = 0.575

			if var_384_22 < arg_381_1.time_ and arg_381_1.time_ <= var_384_22 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_24 = arg_381_1:GetWordFromCfg(417111092)
				local var_384_25 = arg_381_1:FormatText(var_384_24.content)

				arg_381_1.text_.text = var_384_25

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_26 = 23
				local var_384_27 = utf8.len(var_384_25)
				local var_384_28 = var_384_26 <= 0 and var_384_23 or var_384_23 * (var_384_27 / var_384_26)

				if var_384_28 > 0 and var_384_23 < var_384_28 then
					arg_381_1.talkMaxDuration = var_384_28

					if var_384_28 + var_384_22 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_28 + var_384_22
					end
				end

				arg_381_1.text_.text = var_384_25
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_29 = math.max(var_384_23, arg_381_1.talkMaxDuration)

			if var_384_22 <= arg_381_1.time_ and arg_381_1.time_ < var_384_22 + var_384_29 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_22) / var_384_29

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_22 + var_384_29 and arg_381_1.time_ < var_384_22 + var_384_29 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play417111093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 417111093
		arg_385_1.duration_ = 5.97

		local var_385_0 = {
			zh = 4.066,
			ja = 5.966
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
				arg_385_0:Play417111094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["10113"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.actorSpriteComps10113 == nil then
				arg_385_1.var_.actorSpriteComps10113 = var_388_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_2 = 0.2

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.actorSpriteComps10113 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps10113:ToTable()) do
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

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.actorSpriteComps10113 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_388_3 then
						if arg_385_1.isInRecall_ then
							iter_388_3.color = arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_388_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps10113 = nil
			end

			local var_388_8 = arg_385_1.actors_["10113"].transform
			local var_388_9 = 0

			if var_388_9 < arg_385_1.time_ and arg_385_1.time_ <= var_388_9 + arg_388_0 then
				arg_385_1.var_.moveOldPos10113 = var_388_8.localPosition
				var_388_8.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10113", 3)

				local var_388_10 = var_388_8.childCount

				for iter_388_4 = 0, var_388_10 - 1 do
					local var_388_11 = var_388_8:GetChild(iter_388_4)

					if var_388_11.name == "" or not string.find(var_388_11.name, "split") then
						var_388_11.gameObject:SetActive(true)
					else
						var_388_11.gameObject:SetActive(false)
					end
				end
			end

			local var_388_12 = 0.001

			if var_388_9 <= arg_385_1.time_ and arg_385_1.time_ < var_388_9 + var_388_12 then
				local var_388_13 = (arg_385_1.time_ - var_388_9) / var_388_12
				local var_388_14 = Vector3.New(-30.38, -328.4, -517.4)

				var_388_8.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10113, var_388_14, var_388_13)
			end

			if arg_385_1.time_ >= var_388_9 + var_388_12 and arg_385_1.time_ < var_388_9 + var_388_12 + arg_388_0 then
				var_388_8.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_388_15 = 0
			local var_388_16 = 0.475

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_17 = arg_385_1:FormatText(StoryNameCfg[1117].name)

				arg_385_1.leftNameTxt_.text = var_388_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_18 = arg_385_1:GetWordFromCfg(417111093)
				local var_388_19 = arg_385_1:FormatText(var_388_18.content)

				arg_385_1.text_.text = var_388_19

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_20 = 19
				local var_388_21 = utf8.len(var_388_19)
				local var_388_22 = var_388_20 <= 0 and var_388_16 or var_388_16 * (var_388_21 / var_388_20)

				if var_388_22 > 0 and var_388_16 < var_388_22 then
					arg_385_1.talkMaxDuration = var_388_22

					if var_388_22 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_22 + var_388_15
					end
				end

				arg_385_1.text_.text = var_388_19
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111093", "story_v_out_417111.awb") ~= 0 then
					local var_388_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111093", "story_v_out_417111.awb") / 1000

					if var_388_23 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_23 + var_388_15
					end

					if var_388_18.prefab_name ~= "" and arg_385_1.actors_[var_388_18.prefab_name] ~= nil then
						local var_388_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_18.prefab_name].transform, "story_v_out_417111", "417111093", "story_v_out_417111.awb")

						arg_385_1:RecordAudio("417111093", var_388_24)
						arg_385_1:RecordAudio("417111093", var_388_24)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_417111", "417111093", "story_v_out_417111.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_417111", "417111093", "story_v_out_417111.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_25 = math.max(var_388_16, arg_385_1.talkMaxDuration)

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_25 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_15) / var_388_25

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_15 + var_388_25 and arg_385_1.time_ < var_388_15 + var_388_25 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	Play417111094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 417111094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play417111095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["10113"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps10113 == nil then
				arg_389_1.var_.actorSpriteComps10113 = var_392_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_2 = 0.2

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.actorSpriteComps10113 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								local var_392_4 = Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor2.r, var_392_3)
								local var_392_5 = Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor2.g, var_392_3)
								local var_392_6 = Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor2.b, var_392_3)

								iter_392_1.color = Color.New(var_392_4, var_392_5, var_392_6)
							else
								local var_392_7 = Mathf.Lerp(iter_392_1.color.r, 0.5, var_392_3)

								iter_392_1.color = Color.New(var_392_7, var_392_7, var_392_7)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps10113 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_392_3 then
						if arg_389_1.isInRecall_ then
							iter_392_3.color = arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_392_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps10113 = nil
			end

			local var_392_8 = arg_389_1.actors_["10113"].transform
			local var_392_9 = 0

			if var_392_9 < arg_389_1.time_ and arg_389_1.time_ <= var_392_9 + arg_392_0 then
				arg_389_1.var_.moveOldPos10113 = var_392_8.localPosition
				var_392_8.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("10113", 7)

				local var_392_10 = var_392_8.childCount

				for iter_392_4 = 0, var_392_10 - 1 do
					local var_392_11 = var_392_8:GetChild(iter_392_4)

					if var_392_11.name == "" or not string.find(var_392_11.name, "split") then
						var_392_11.gameObject:SetActive(true)
					else
						var_392_11.gameObject:SetActive(false)
					end
				end
			end

			local var_392_12 = 0.001

			if var_392_9 <= arg_389_1.time_ and arg_389_1.time_ < var_392_9 + var_392_12 then
				local var_392_13 = (arg_389_1.time_ - var_392_9) / var_392_12
				local var_392_14 = Vector3.New(0, -2000, 0)

				var_392_8.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos10113, var_392_14, var_392_13)
			end

			if arg_389_1.time_ >= var_392_9 + var_392_12 and arg_389_1.time_ < var_392_9 + var_392_12 + arg_392_0 then
				var_392_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_392_15 = 0
			local var_392_16 = 1.475

			if var_392_15 < arg_389_1.time_ and arg_389_1.time_ <= var_392_15 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_17 = arg_389_1:GetWordFromCfg(417111094)
				local var_392_18 = arg_389_1:FormatText(var_392_17.content)

				arg_389_1.text_.text = var_392_18

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_19 = 59
				local var_392_20 = utf8.len(var_392_18)
				local var_392_21 = var_392_19 <= 0 and var_392_16 or var_392_16 * (var_392_20 / var_392_19)

				if var_392_21 > 0 and var_392_16 < var_392_21 then
					arg_389_1.talkMaxDuration = var_392_21

					if var_392_21 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_21 + var_392_15
					end
				end

				arg_389_1.text_.text = var_392_18
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_22 = math.max(var_392_16, arg_389_1.talkMaxDuration)

			if var_392_15 <= arg_389_1.time_ and arg_389_1.time_ < var_392_15 + var_392_22 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_15) / var_392_22

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_15 + var_392_22 and arg_389_1.time_ < var_392_15 + var_392_22 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play417111095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 417111095
		arg_393_1.duration_ = 1.87

		local var_393_0 = {
			zh = 1.1,
			ja = 1.866
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
				arg_393_0:Play417111096(arg_393_1)
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

			local var_396_8 = arg_393_1.actors_["1034"].transform
			local var_396_9 = 0

			if var_396_9 < arg_393_1.time_ and arg_393_1.time_ <= var_396_9 + arg_396_0 then
				arg_393_1.var_.moveOldPos1034 = var_396_8.localPosition
				var_396_8.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1034", 3)

				local var_396_10 = var_396_8.childCount

				for iter_396_4 = 0, var_396_10 - 1 do
					local var_396_11 = var_396_8:GetChild(iter_396_4)

					if var_396_11.name == "split_6" or not string.find(var_396_11.name, "split") then
						var_396_11.gameObject:SetActive(true)
					else
						var_396_11.gameObject:SetActive(false)
					end
				end
			end

			local var_396_12 = 0.001

			if var_396_9 <= arg_393_1.time_ and arg_393_1.time_ < var_396_9 + var_396_12 then
				local var_396_13 = (arg_393_1.time_ - var_396_9) / var_396_12
				local var_396_14 = Vector3.New(0, -331.9, -324)

				var_396_8.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1034, var_396_14, var_396_13)
			end

			if arg_393_1.time_ >= var_396_9 + var_396_12 and arg_393_1.time_ < var_396_9 + var_396_12 + arg_396_0 then
				var_396_8.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_396_15 = 0
			local var_396_16 = 0.1

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_17 = arg_393_1:FormatText(StoryNameCfg[1109].name)

				arg_393_1.leftNameTxt_.text = var_396_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_18 = arg_393_1:GetWordFromCfg(417111095)
				local var_396_19 = arg_393_1:FormatText(var_396_18.content)

				arg_393_1.text_.text = var_396_19

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_20 = 4
				local var_396_21 = utf8.len(var_396_19)
				local var_396_22 = var_396_20 <= 0 and var_396_16 or var_396_16 * (var_396_21 / var_396_20)

				if var_396_22 > 0 and var_396_16 < var_396_22 then
					arg_393_1.talkMaxDuration = var_396_22

					if var_396_22 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_22 + var_396_15
					end
				end

				arg_393_1.text_.text = var_396_19
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111095", "story_v_out_417111.awb") ~= 0 then
					local var_396_23 = manager.audio:GetVoiceLength("story_v_out_417111", "417111095", "story_v_out_417111.awb") / 1000

					if var_396_23 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_23 + var_396_15
					end

					if var_396_18.prefab_name ~= "" and arg_393_1.actors_[var_396_18.prefab_name] ~= nil then
						local var_396_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_18.prefab_name].transform, "story_v_out_417111", "417111095", "story_v_out_417111.awb")

						arg_393_1:RecordAudio("417111095", var_396_24)
						arg_393_1:RecordAudio("417111095", var_396_24)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_417111", "417111095", "story_v_out_417111.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_417111", "417111095", "story_v_out_417111.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_25 = math.max(var_396_16, arg_393_1.talkMaxDuration)

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_25 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_15) / var_396_25

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_15 + var_396_25 and arg_393_1.time_ < var_396_15 + var_396_25 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
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

		arg_393_1:InitPlayNodeList()
	end,
	Play417111096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 417111096
		arg_397_1.duration_ = 5.17

		local var_397_0 = {
			zh = 2.1,
			ja = 5.166
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
				arg_397_0:Play417111097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["10113"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps10113 == nil then
				arg_397_1.var_.actorSpriteComps10113 = var_400_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.actorSpriteComps10113 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								local var_400_4 = Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor1.r, var_400_3)
								local var_400_5 = Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor1.g, var_400_3)
								local var_400_6 = Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor1.b, var_400_3)

								iter_400_1.color = Color.New(var_400_4, var_400_5, var_400_6)
							else
								local var_400_7 = Mathf.Lerp(iter_400_1.color.r, 1, var_400_3)

								iter_400_1.color = Color.New(var_400_7, var_400_7, var_400_7)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps10113 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_400_3 then
						if arg_397_1.isInRecall_ then
							iter_400_3.color = arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_400_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps10113 = nil
			end

			local var_400_8 = arg_397_1.actors_["1034"]
			local var_400_9 = 0

			if var_400_9 < arg_397_1.time_ and arg_397_1.time_ <= var_400_9 + arg_400_0 and not isNil(var_400_8) and arg_397_1.var_.actorSpriteComps1034 == nil then
				arg_397_1.var_.actorSpriteComps1034 = var_400_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_10 = 0.2

			if var_400_9 <= arg_397_1.time_ and arg_397_1.time_ < var_400_9 + var_400_10 and not isNil(var_400_8) then
				local var_400_11 = (arg_397_1.time_ - var_400_9) / var_400_10

				if arg_397_1.var_.actorSpriteComps1034 then
					for iter_400_4, iter_400_5 in pairs(arg_397_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_400_5 then
							if arg_397_1.isInRecall_ then
								local var_400_12 = Mathf.Lerp(iter_400_5.color.r, arg_397_1.hightColor2.r, var_400_11)
								local var_400_13 = Mathf.Lerp(iter_400_5.color.g, arg_397_1.hightColor2.g, var_400_11)
								local var_400_14 = Mathf.Lerp(iter_400_5.color.b, arg_397_1.hightColor2.b, var_400_11)

								iter_400_5.color = Color.New(var_400_12, var_400_13, var_400_14)
							else
								local var_400_15 = Mathf.Lerp(iter_400_5.color.r, 0.5, var_400_11)

								iter_400_5.color = Color.New(var_400_15, var_400_15, var_400_15)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_9 + var_400_10 and arg_397_1.time_ < var_400_9 + var_400_10 + arg_400_0 and not isNil(var_400_8) and arg_397_1.var_.actorSpriteComps1034 then
				for iter_400_6, iter_400_7 in pairs(arg_397_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_400_7 then
						if arg_397_1.isInRecall_ then
							iter_400_7.color = arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_400_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps1034 = nil
			end

			local var_400_16 = 0
			local var_400_17 = 0.2

			if var_400_16 < arg_397_1.time_ and arg_397_1.time_ <= var_400_16 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_18 = arg_397_1:FormatText(StoryNameCfg[1117].name)

				arg_397_1.leftNameTxt_.text = var_400_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_1")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_19 = arg_397_1:GetWordFromCfg(417111096)
				local var_400_20 = arg_397_1:FormatText(var_400_19.content)

				arg_397_1.text_.text = var_400_20

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_21 = 8
				local var_400_22 = utf8.len(var_400_20)
				local var_400_23 = var_400_21 <= 0 and var_400_17 or var_400_17 * (var_400_22 / var_400_21)

				if var_400_23 > 0 and var_400_17 < var_400_23 then
					arg_397_1.talkMaxDuration = var_400_23

					if var_400_23 + var_400_16 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_23 + var_400_16
					end
				end

				arg_397_1.text_.text = var_400_20
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111096", "story_v_out_417111.awb") ~= 0 then
					local var_400_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111096", "story_v_out_417111.awb") / 1000

					if var_400_24 + var_400_16 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_24 + var_400_16
					end

					if var_400_19.prefab_name ~= "" and arg_397_1.actors_[var_400_19.prefab_name] ~= nil then
						local var_400_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_19.prefab_name].transform, "story_v_out_417111", "417111096", "story_v_out_417111.awb")

						arg_397_1:RecordAudio("417111096", var_400_25)
						arg_397_1:RecordAudio("417111096", var_400_25)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_417111", "417111096", "story_v_out_417111.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_417111", "417111096", "story_v_out_417111.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_26 = math.max(var_400_17, arg_397_1.talkMaxDuration)

			if var_400_16 <= arg_397_1.time_ and arg_397_1.time_ < var_400_16 + var_400_26 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_16) / var_400_26

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_16 + var_400_26 and arg_397_1.time_ < var_400_16 + var_400_26 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play417111097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 417111097
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play417111098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10113"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10113 == nil then
				arg_401_1.var_.actorSpriteComps10113 = var_404_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_2 = 0.2

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.actorSpriteComps10113 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								local var_404_4 = Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor2.r, var_404_3)
								local var_404_5 = Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor2.g, var_404_3)
								local var_404_6 = Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor2.b, var_404_3)

								iter_404_1.color = Color.New(var_404_4, var_404_5, var_404_6)
							else
								local var_404_7 = Mathf.Lerp(iter_404_1.color.r, 0.5, var_404_3)

								iter_404_1.color = Color.New(var_404_7, var_404_7, var_404_7)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10113 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_404_3 then
						if arg_401_1.isInRecall_ then
							iter_404_3.color = arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_404_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps10113 = nil
			end

			local var_404_8 = arg_401_1.actors_["1034"].transform
			local var_404_9 = 0

			if var_404_9 < arg_401_1.time_ and arg_401_1.time_ <= var_404_9 + arg_404_0 then
				arg_401_1.var_.moveOldPos1034 = var_404_8.localPosition
				var_404_8.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("1034", 7)

				local var_404_10 = var_404_8.childCount

				for iter_404_4 = 0, var_404_10 - 1 do
					local var_404_11 = var_404_8:GetChild(iter_404_4)

					if var_404_11.name == "" or not string.find(var_404_11.name, "split") then
						var_404_11.gameObject:SetActive(true)
					else
						var_404_11.gameObject:SetActive(false)
					end
				end
			end

			local var_404_12 = 0.001

			if var_404_9 <= arg_401_1.time_ and arg_401_1.time_ < var_404_9 + var_404_12 then
				local var_404_13 = (arg_401_1.time_ - var_404_9) / var_404_12
				local var_404_14 = Vector3.New(0, -2000, 0)

				var_404_8.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1034, var_404_14, var_404_13)
			end

			if arg_401_1.time_ >= var_404_9 + var_404_12 and arg_401_1.time_ < var_404_9 + var_404_12 + arg_404_0 then
				var_404_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_404_15 = 0
			local var_404_16 = 0.625

			if var_404_15 < arg_401_1.time_ and arg_401_1.time_ <= var_404_15 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_17 = arg_401_1:GetWordFromCfg(417111097)
				local var_404_18 = arg_401_1:FormatText(var_404_17.content)

				arg_401_1.text_.text = var_404_18

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_19 = 25
				local var_404_20 = utf8.len(var_404_18)
				local var_404_21 = var_404_19 <= 0 and var_404_16 or var_404_16 * (var_404_20 / var_404_19)

				if var_404_21 > 0 and var_404_16 < var_404_21 then
					arg_401_1.talkMaxDuration = var_404_21

					if var_404_21 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_21 + var_404_15
					end
				end

				arg_401_1.text_.text = var_404_18
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_22 = math.max(var_404_16, arg_401_1.talkMaxDuration)

			if var_404_15 <= arg_401_1.time_ and arg_401_1.time_ < var_404_15 + var_404_22 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_15) / var_404_22

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_15 + var_404_22 and arg_401_1.time_ < var_404_15 + var_404_22 + arg_404_0 then
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
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play417111098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 417111098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play417111099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0
			local var_408_1 = 1.075

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_2 = arg_405_1:GetWordFromCfg(417111098)
				local var_408_3 = arg_405_1:FormatText(var_408_2.content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 43
				local var_408_5 = utf8.len(var_408_3)
				local var_408_6 = var_408_4 <= 0 and var_408_1 or var_408_1 * (var_408_5 / var_408_4)

				if var_408_6 > 0 and var_408_1 < var_408_6 then
					arg_405_1.talkMaxDuration = var_408_6

					if var_408_6 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_6 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_7 and arg_405_1.time_ < var_408_0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play417111099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 417111099
		arg_409_1.duration_ = 3.47

		local var_409_0 = {
			zh = 1.033,
			ja = 3.466
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play417111100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0
			local var_412_1 = 0.075

			if var_412_0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_2 = arg_409_1:FormatText(StoryNameCfg[1109].name)

				arg_409_1.leftNameTxt_.text = var_412_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(417111099)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 3
				local var_412_6 = utf8.len(var_412_4)
				local var_412_7 = var_412_5 <= 0 and var_412_1 or var_412_1 * (var_412_6 / var_412_5)

				if var_412_7 > 0 and var_412_1 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_0
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111099", "story_v_out_417111.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111099", "story_v_out_417111.awb") / 1000

					if var_412_8 + var_412_0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_0
					end

					if var_412_3.prefab_name ~= "" and arg_409_1.actors_[var_412_3.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_3.prefab_name].transform, "story_v_out_417111", "417111099", "story_v_out_417111.awb")

						arg_409_1:RecordAudio("417111099", var_412_9)
						arg_409_1:RecordAudio("417111099", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_417111", "417111099", "story_v_out_417111.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_417111", "417111099", "story_v_out_417111.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_1, arg_409_1.talkMaxDuration)

			if var_412_0 <= arg_409_1.time_ and arg_409_1.time_ < var_412_0 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_0) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_0 + var_412_10 and arg_409_1.time_ < var_412_0 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play417111100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 417111100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play417111101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1034"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps1034 == nil then
				arg_413_1.var_.actorSpriteComps1034 = var_416_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_2 = 0.2

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.actorSpriteComps1034 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								local var_416_4 = Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor2.r, var_416_3)
								local var_416_5 = Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor2.g, var_416_3)
								local var_416_6 = Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor2.b, var_416_3)

								iter_416_1.color = Color.New(var_416_4, var_416_5, var_416_6)
							else
								local var_416_7 = Mathf.Lerp(iter_416_1.color.r, 0.5, var_416_3)

								iter_416_1.color = Color.New(var_416_7, var_416_7, var_416_7)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.actorSpriteComps1034 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_416_3 then
						if arg_413_1.isInRecall_ then
							iter_416_3.color = arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_416_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_413_1.var_.actorSpriteComps1034 = nil
			end

			local var_416_8 = arg_413_1.actors_["1034"].transform
			local var_416_9 = 0

			if var_416_9 < arg_413_1.time_ and arg_413_1.time_ <= var_416_9 + arg_416_0 then
				arg_413_1.var_.moveOldPos1034 = var_416_8.localPosition
				var_416_8.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("1034", 7)

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
				local var_416_14 = Vector3.New(0, -2000, 0)

				var_416_8.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1034, var_416_14, var_416_13)
			end

			if arg_413_1.time_ >= var_416_9 + var_416_12 and arg_413_1.time_ < var_416_9 + var_416_12 + arg_416_0 then
				var_416_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_416_15 = 1.53333333333333
			local var_416_16 = 1

			if var_416_15 < arg_413_1.time_ and arg_413_1.time_ <= var_416_15 + arg_416_0 then
				local var_416_17 = "play"
				local var_416_18 = "effect"

				arg_413_1:AudioAction(var_416_17, var_416_18, "se_story_120_00", "se_story_120_00_sword04", "")
			end

			local var_416_19 = 0
			local var_416_20 = 1.875

			if var_416_19 < arg_413_1.time_ and arg_413_1.time_ <= var_416_19 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_21 = arg_413_1:GetWordFromCfg(417111100)
				local var_416_22 = arg_413_1:FormatText(var_416_21.content)

				arg_413_1.text_.text = var_416_22

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_23 = 75
				local var_416_24 = utf8.len(var_416_22)
				local var_416_25 = var_416_23 <= 0 and var_416_20 or var_416_20 * (var_416_24 / var_416_23)

				if var_416_25 > 0 and var_416_20 < var_416_25 then
					arg_413_1.talkMaxDuration = var_416_25

					if var_416_25 + var_416_19 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_25 + var_416_19
					end
				end

				arg_413_1.text_.text = var_416_22
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_26 = math.max(var_416_20, arg_413_1.talkMaxDuration)

			if var_416_19 <= arg_413_1.time_ and arg_413_1.time_ < var_416_19 + var_416_26 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_19) / var_416_26

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_19 + var_416_26 and arg_413_1.time_ < var_416_19 + var_416_26 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play417111101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 417111101
		arg_417_1.duration_ = 6.47

		local var_417_0 = {
			zh = 2.466,
			ja = 6.466
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
				arg_417_0:Play417111102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 0.3

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[1109].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(417111101)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111101", "story_v_out_417111.awb") ~= 0 then
					local var_420_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111101", "story_v_out_417111.awb") / 1000

					if var_420_8 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_8 + var_420_0
					end

					if var_420_3.prefab_name ~= "" and arg_417_1.actors_[var_420_3.prefab_name] ~= nil then
						local var_420_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_3.prefab_name].transform, "story_v_out_417111", "417111101", "story_v_out_417111.awb")

						arg_417_1:RecordAudio("417111101", var_420_9)
						arg_417_1:RecordAudio("417111101", var_420_9)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_417111", "417111101", "story_v_out_417111.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_417111", "417111101", "story_v_out_417111.awb")
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
	Play417111102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 417111102
		arg_421_1.duration_ = 1.07

		local var_421_0 = {
			zh = 0.999999999999,
			ja = 1.066
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
				arg_421_0:Play417111103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["10113"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.actorSpriteComps10113 == nil then
				arg_421_1.var_.actorSpriteComps10113 = var_424_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_2 = 0.2

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.actorSpriteComps10113 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_424_1 then
							if arg_421_1.isInRecall_ then
								local var_424_4 = Mathf.Lerp(iter_424_1.color.r, arg_421_1.hightColor1.r, var_424_3)
								local var_424_5 = Mathf.Lerp(iter_424_1.color.g, arg_421_1.hightColor1.g, var_424_3)
								local var_424_6 = Mathf.Lerp(iter_424_1.color.b, arg_421_1.hightColor1.b, var_424_3)

								iter_424_1.color = Color.New(var_424_4, var_424_5, var_424_6)
							else
								local var_424_7 = Mathf.Lerp(iter_424_1.color.r, 1, var_424_3)

								iter_424_1.color = Color.New(var_424_7, var_424_7, var_424_7)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.actorSpriteComps10113 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_424_3 then
						if arg_421_1.isInRecall_ then
							iter_424_3.color = arg_421_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_424_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_421_1.var_.actorSpriteComps10113 = nil
			end

			local var_424_8 = arg_421_1.actors_["1034"]
			local var_424_9 = 0

			if var_424_9 < arg_421_1.time_ and arg_421_1.time_ <= var_424_9 + arg_424_0 and not isNil(var_424_8) and arg_421_1.var_.actorSpriteComps1034 == nil then
				arg_421_1.var_.actorSpriteComps1034 = var_424_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_10 = 0.2

			if var_424_9 <= arg_421_1.time_ and arg_421_1.time_ < var_424_9 + var_424_10 and not isNil(var_424_8) then
				local var_424_11 = (arg_421_1.time_ - var_424_9) / var_424_10

				if arg_421_1.var_.actorSpriteComps1034 then
					for iter_424_4, iter_424_5 in pairs(arg_421_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_424_5 then
							if arg_421_1.isInRecall_ then
								local var_424_12 = Mathf.Lerp(iter_424_5.color.r, arg_421_1.hightColor2.r, var_424_11)
								local var_424_13 = Mathf.Lerp(iter_424_5.color.g, arg_421_1.hightColor2.g, var_424_11)
								local var_424_14 = Mathf.Lerp(iter_424_5.color.b, arg_421_1.hightColor2.b, var_424_11)

								iter_424_5.color = Color.New(var_424_12, var_424_13, var_424_14)
							else
								local var_424_15 = Mathf.Lerp(iter_424_5.color.r, 0.5, var_424_11)

								iter_424_5.color = Color.New(var_424_15, var_424_15, var_424_15)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= var_424_9 + var_424_10 and arg_421_1.time_ < var_424_9 + var_424_10 + arg_424_0 and not isNil(var_424_8) and arg_421_1.var_.actorSpriteComps1034 then
				for iter_424_6, iter_424_7 in pairs(arg_421_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_424_7 then
						if arg_421_1.isInRecall_ then
							iter_424_7.color = arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_424_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_421_1.var_.actorSpriteComps1034 = nil
			end

			local var_424_16 = 0
			local var_424_17 = 0.1

			if var_424_16 < arg_421_1.time_ and arg_421_1.time_ <= var_424_16 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_18 = arg_421_1:FormatText(StoryNameCfg[1117].name)

				arg_421_1.leftNameTxt_.text = var_424_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10113_split_5")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_19 = arg_421_1:GetWordFromCfg(417111102)
				local var_424_20 = arg_421_1:FormatText(var_424_19.content)

				arg_421_1.text_.text = var_424_20

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_21 = 4
				local var_424_22 = utf8.len(var_424_20)
				local var_424_23 = var_424_21 <= 0 and var_424_17 or var_424_17 * (var_424_22 / var_424_21)

				if var_424_23 > 0 and var_424_17 < var_424_23 then
					arg_421_1.talkMaxDuration = var_424_23

					if var_424_23 + var_424_16 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_23 + var_424_16
					end
				end

				arg_421_1.text_.text = var_424_20
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111102", "story_v_out_417111.awb") ~= 0 then
					local var_424_24 = manager.audio:GetVoiceLength("story_v_out_417111", "417111102", "story_v_out_417111.awb") / 1000

					if var_424_24 + var_424_16 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_24 + var_424_16
					end

					if var_424_19.prefab_name ~= "" and arg_421_1.actors_[var_424_19.prefab_name] ~= nil then
						local var_424_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_19.prefab_name].transform, "story_v_out_417111", "417111102", "story_v_out_417111.awb")

						arg_421_1:RecordAudio("417111102", var_424_25)
						arg_421_1:RecordAudio("417111102", var_424_25)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_417111", "417111102", "story_v_out_417111.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_417111", "417111102", "story_v_out_417111.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_26 = math.max(var_424_17, arg_421_1.talkMaxDuration)

			if var_424_16 <= arg_421_1.time_ and arg_421_1.time_ < var_424_16 + var_424_26 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_16) / var_424_26

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_16 + var_424_26 and arg_421_1.time_ < var_424_16 + var_424_26 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play417111103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 417111103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play417111104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["10113"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10113 == nil then
				arg_425_1.var_.actorSpriteComps10113 = var_428_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_2 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.actorSpriteComps10113 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								local var_428_4 = Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor2.r, var_428_3)
								local var_428_5 = Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor2.g, var_428_3)
								local var_428_6 = Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor2.b, var_428_3)

								iter_428_1.color = Color.New(var_428_4, var_428_5, var_428_6)
							else
								local var_428_7 = Mathf.Lerp(iter_428_1.color.r, 0.5, var_428_3)

								iter_428_1.color = Color.New(var_428_7, var_428_7, var_428_7)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.actorSpriteComps10113 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_428_3 then
						if arg_425_1.isInRecall_ then
							iter_428_3.color = arg_425_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_428_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_425_1.var_.actorSpriteComps10113 = nil
			end

			local var_428_8 = arg_425_1.actors_["1034"].transform
			local var_428_9 = 0

			if var_428_9 < arg_425_1.time_ and arg_425_1.time_ <= var_428_9 + arg_428_0 then
				arg_425_1.var_.moveOldPos1034 = var_428_8.localPosition
				var_428_8.localScale = Vector3.New(1, 1, 1)

				arg_425_1:CheckSpriteTmpPos("1034", 7)

				local var_428_10 = var_428_8.childCount

				for iter_428_4 = 0, var_428_10 - 1 do
					local var_428_11 = var_428_8:GetChild(iter_428_4)

					if var_428_11.name == "" or not string.find(var_428_11.name, "split") then
						var_428_11.gameObject:SetActive(true)
					else
						var_428_11.gameObject:SetActive(false)
					end
				end
			end

			local var_428_12 = 0.001

			if var_428_9 <= arg_425_1.time_ and arg_425_1.time_ < var_428_9 + var_428_12 then
				local var_428_13 = (arg_425_1.time_ - var_428_9) / var_428_12
				local var_428_14 = Vector3.New(0, -2000, 0)

				var_428_8.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1034, var_428_14, var_428_13)
			end

			if arg_425_1.time_ >= var_428_9 + var_428_12 and arg_425_1.time_ < var_428_9 + var_428_12 + arg_428_0 then
				var_428_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_428_15 = 1
			local var_428_16 = 1

			if var_428_15 < arg_425_1.time_ and arg_425_1.time_ <= var_428_15 + arg_428_0 then
				local var_428_17 = "play"
				local var_428_18 = "effect"

				arg_425_1:AudioAction(var_428_17, var_428_18, "se_story_1310", "se_story_1310_push01", "")
			end

			local var_428_19 = 0
			local var_428_20 = 1.075

			if var_428_19 < arg_425_1.time_ and arg_425_1.time_ <= var_428_19 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_21 = arg_425_1:GetWordFromCfg(417111103)
				local var_428_22 = arg_425_1:FormatText(var_428_21.content)

				arg_425_1.text_.text = var_428_22

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_23 = 43
				local var_428_24 = utf8.len(var_428_22)
				local var_428_25 = var_428_23 <= 0 and var_428_20 or var_428_20 * (var_428_24 / var_428_23)

				if var_428_25 > 0 and var_428_20 < var_428_25 then
					arg_425_1.talkMaxDuration = var_428_25

					if var_428_25 + var_428_19 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_25 + var_428_19
					end
				end

				arg_425_1.text_.text = var_428_22
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_26 = math.max(var_428_20, arg_425_1.talkMaxDuration)

			if var_428_19 <= arg_425_1.time_ and arg_425_1.time_ < var_428_19 + var_428_26 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_19) / var_428_26

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_19 + var_428_26 and arg_425_1.time_ < var_428_19 + var_428_26 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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

		arg_425_1:InitPlayNodeList()
	end,
	Play417111104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 417111104
		arg_429_1.duration_ = 6.78

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play417111105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = "I16i"

			if arg_429_1.bgs_[var_432_0] == nil then
				local var_432_1 = Object.Instantiate(arg_429_1.paintGo_)

				var_432_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_432_0)
				var_432_1.name = var_432_0
				var_432_1.transform.parent = arg_429_1.stage_.transform
				var_432_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_429_1.bgs_[var_432_0] = var_432_1
			end

			local var_432_2 = 0.433333333333333

			if var_432_2 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				local var_432_3 = manager.ui.mainCamera.transform.localPosition
				local var_432_4 = Vector3.New(0, 0, 10) + Vector3.New(var_432_3.x, var_432_3.y, 0)
				local var_432_5 = arg_429_1.bgs_.I16i

				var_432_5.transform.localPosition = var_432_4
				var_432_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_432_6 = var_432_5:GetComponent("SpriteRenderer")

				if var_432_6 and var_432_6.sprite then
					local var_432_7 = (var_432_5.transform.localPosition - var_432_3).z
					local var_432_8 = manager.ui.mainCameraCom_
					local var_432_9 = 2 * var_432_7 * Mathf.Tan(var_432_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_432_10 = var_432_9 * var_432_8.aspect
					local var_432_11 = var_432_6.sprite.bounds.size.x
					local var_432_12 = var_432_6.sprite.bounds.size.y
					local var_432_13 = var_432_10 / var_432_11
					local var_432_14 = var_432_9 / var_432_12
					local var_432_15 = var_432_14 < var_432_13 and var_432_13 or var_432_14

					var_432_5.transform.localScale = Vector3.New(var_432_15, var_432_15, 0)
				end

				for iter_432_0, iter_432_1 in pairs(arg_429_1.bgs_) do
					if iter_432_0 ~= "I16i" then
						iter_432_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_432_16 = 0

			if var_432_16 < arg_429_1.time_ and arg_429_1.time_ <= var_432_16 + arg_432_0 then
				arg_429_1.allBtn_.enabled = false
			end

			local var_432_17 = 0.3

			if arg_429_1.time_ >= var_432_16 + var_432_17 and arg_429_1.time_ < var_432_16 + var_432_17 + arg_432_0 then
				arg_429_1.allBtn_.enabled = true
			end

			local var_432_18 = 0

			if var_432_18 < arg_429_1.time_ and arg_429_1.time_ <= var_432_18 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_19 = 0.433333333333333

			if var_432_18 <= arg_429_1.time_ and arg_429_1.time_ < var_432_18 + var_432_19 then
				local var_432_20 = (arg_429_1.time_ - var_432_18) / var_432_19
				local var_432_21 = Color.New(1, 1, 1)

				var_432_21.a = Mathf.Lerp(0, 1, var_432_20)
				arg_429_1.mask_.color = var_432_21
			end

			if arg_429_1.time_ >= var_432_18 + var_432_19 and arg_429_1.time_ < var_432_18 + var_432_19 + arg_432_0 then
				local var_432_22 = Color.New(1, 1, 1)

				var_432_22.a = 1
				arg_429_1.mask_.color = var_432_22
			end

			local var_432_23 = 0.433333333333333

			if var_432_23 < arg_429_1.time_ and arg_429_1.time_ <= var_432_23 + arg_432_0 then
				arg_429_1.mask_.enabled = true
				arg_429_1.mask_.raycastTarget = true

				arg_429_1:SetGaussion(false)
			end

			local var_432_24 = 1.35

			if var_432_23 <= arg_429_1.time_ and arg_429_1.time_ < var_432_23 + var_432_24 then
				local var_432_25 = (arg_429_1.time_ - var_432_23) / var_432_24
				local var_432_26 = Color.New(1, 1, 1)

				var_432_26.a = Mathf.Lerp(1, 0, var_432_25)
				arg_429_1.mask_.color = var_432_26
			end

			if arg_429_1.time_ >= var_432_23 + var_432_24 and arg_429_1.time_ < var_432_23 + var_432_24 + arg_432_0 then
				local var_432_27 = Color.New(1, 1, 1)
				local var_432_28 = 0

				arg_429_1.mask_.enabled = false
				var_432_27.a = var_432_28
				arg_429_1.mask_.color = var_432_27
			end

			local var_432_29 = manager.ui.mainCamera.transform
			local var_432_30 = 0.433333333333333

			if var_432_30 < arg_429_1.time_ and arg_429_1.time_ <= var_432_30 + arg_432_0 then
				arg_429_1.var_.shakeOldPos = var_432_29.localPosition
			end

			local var_432_31 = 1.4

			if var_432_30 <= arg_429_1.time_ and arg_429_1.time_ < var_432_30 + var_432_31 then
				local var_432_32 = (arg_429_1.time_ - var_432_30) / 0.066
				local var_432_33, var_432_34 = math.modf(var_432_32)

				var_432_29.localPosition = Vector3.New(var_432_34 * 0.13, var_432_34 * 0.13, var_432_34 * 0.13) + arg_429_1.var_.shakeOldPos
			end

			if arg_429_1.time_ >= var_432_30 + var_432_31 and arg_429_1.time_ < var_432_30 + var_432_31 + arg_432_0 then
				var_432_29.localPosition = arg_429_1.var_.shakeOldPos
			end

			local var_432_35 = 0.05
			local var_432_36 = 1

			if var_432_35 < arg_429_1.time_ and arg_429_1.time_ <= var_432_35 + arg_432_0 then
				local var_432_37 = "play"
				local var_432_38 = "effect"

				arg_429_1:AudioAction(var_432_37, var_432_38, "se_story_120_00", "se_story_120_00_door_break02", "")
			end

			local var_432_39 = 0
			local var_432_40 = 0.2

			if var_432_39 < arg_429_1.time_ and arg_429_1.time_ <= var_432_39 + arg_432_0 then
				local var_432_41 = "play"
				local var_432_42 = "music"

				arg_429_1:AudioAction(var_432_41, var_432_42, "ui_battle", "ui_battle_stopbgm", "")

				local var_432_43 = ""
				local var_432_44 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_432_44 ~= "" then
					if arg_429_1.bgmTxt_.text ~= var_432_44 and arg_429_1.bgmTxt_.text ~= "" then
						if arg_429_1.bgmTxt2_.text ~= "" then
							arg_429_1.bgmTxt_.text = arg_429_1.bgmTxt2_.text
						end

						arg_429_1.bgmTxt2_.text = var_432_44

						arg_429_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_429_1.bgmTxt_.text = var_432_44
						arg_429_1.bgmTxt2_.text = var_432_44
					end

					if arg_429_1.bgmTimer then
						arg_429_1.bgmTimer:Stop()

						arg_429_1.bgmTimer = nil
					end

					if arg_429_1.settingData.show_music_name == 1 then
						arg_429_1.musicController:SetSelectedState("show")
						arg_429_1.musicAnimator_:Play("open", 0, 0)

						if arg_429_1.settingData.music_time ~= 0 then
							arg_429_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_429_1.settingData.music_time), function()
								if arg_429_1 == nil or isNil(arg_429_1.bgmTxt_) then
									return
								end

								arg_429_1.musicController:SetSelectedState("hide")
								arg_429_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_432_45 = 0.466666666666667
			local var_432_46 = 1

			if var_432_45 < arg_429_1.time_ and arg_429_1.time_ <= var_432_45 + arg_432_0 then
				local var_432_47 = "play"
				local var_432_48 = "music"

				arg_429_1:AudioAction(var_432_47, var_432_48, "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg.awb")

				local var_432_49 = ""
				local var_432_50 = manager.audio:GetAudioName("bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg")

				if var_432_50 ~= "" then
					if arg_429_1.bgmTxt_.text ~= var_432_50 and arg_429_1.bgmTxt_.text ~= "" then
						if arg_429_1.bgmTxt2_.text ~= "" then
							arg_429_1.bgmTxt_.text = arg_429_1.bgmTxt2_.text
						end

						arg_429_1.bgmTxt2_.text = var_432_50

						arg_429_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_429_1.bgmTxt_.text = var_432_50
						arg_429_1.bgmTxt2_.text = var_432_50
					end

					if arg_429_1.bgmTimer then
						arg_429_1.bgmTimer:Stop()

						arg_429_1.bgmTimer = nil
					end

					if arg_429_1.settingData.show_music_name == 1 then
						arg_429_1.musicController:SetSelectedState("show")
						arg_429_1.musicAnimator_:Play("open", 0, 0)

						if arg_429_1.settingData.music_time ~= 0 then
							arg_429_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_429_1.settingData.music_time), function()
								if arg_429_1 == nil or isNil(arg_429_1.bgmTxt_) then
									return
								end

								arg_429_1.musicController:SetSelectedState("hide")
								arg_429_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_429_1.frameCnt_ <= 1 then
				arg_429_1.dialog_:SetActive(false)
			end

			local var_432_51 = 1.78333333333333
			local var_432_52 = 0.65

			if var_432_51 < arg_429_1.time_ and arg_429_1.time_ <= var_432_51 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0

				arg_429_1.dialog_:SetActive(true)

				arg_429_1.dialogCg_.alpha = 0

				local var_432_53 = LeanTween.value(arg_429_1.dialog_, 0, 1, 0.3)

				var_432_53:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_429_1.dialogCg_.alpha = arg_435_0
				end))
				var_432_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_429_1.dialog_)
					var_432_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_429_1.duration_ = arg_429_1.duration_ + 0.3

				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_54 = arg_429_1:GetWordFromCfg(417111104)
				local var_432_55 = arg_429_1:FormatText(var_432_54.content)

				arg_429_1.text_.text = var_432_55

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_56 = 26
				local var_432_57 = utf8.len(var_432_55)
				local var_432_58 = var_432_56 <= 0 and var_432_52 or var_432_52 * (var_432_57 / var_432_56)

				if var_432_58 > 0 and var_432_52 < var_432_58 then
					arg_429_1.talkMaxDuration = var_432_58
					var_432_51 = var_432_51 + 0.3

					if var_432_58 + var_432_51 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_58 + var_432_51
					end
				end

				arg_429_1.text_.text = var_432_55
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_59 = var_432_51 + 0.3
			local var_432_60 = math.max(var_432_52, arg_429_1.talkMaxDuration)

			if var_432_59 <= arg_429_1.time_ and arg_429_1.time_ < var_432_59 + var_432_60 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_59) / var_432_60

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_59 + var_432_60 and arg_429_1.time_ < var_432_59 + var_432_60 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play417111105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 417111105
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play417111106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.1
			local var_440_1 = 1

			if var_440_0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_0 + arg_440_0 then
				local var_440_2 = "play"
				local var_440_3 = "effect"

				arg_437_1:AudioAction(var_440_2, var_440_3, "se_story_1310", "se_story_1310_dodge", "")
			end

			local var_440_4 = 0
			local var_440_5 = 1.375

			if var_440_4 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(417111105)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_8 = 55
				local var_440_9 = utf8.len(var_440_7)
				local var_440_10 = var_440_8 <= 0 and var_440_5 or var_440_5 * (var_440_9 / var_440_8)

				if var_440_10 > 0 and var_440_5 < var_440_10 then
					arg_437_1.talkMaxDuration = var_440_10

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_11 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_11 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_11

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_11 and arg_437_1.time_ < var_440_4 + var_440_11 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play417111106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 417111106
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play417111107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0
			local var_444_1 = 1.25

			if var_444_0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_2 = arg_441_1:GetWordFromCfg(417111106)
				local var_444_3 = arg_441_1:FormatText(var_444_2.content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 50
				local var_444_5 = utf8.len(var_444_3)
				local var_444_6 = var_444_4 <= 0 and var_444_1 or var_444_1 * (var_444_5 / var_444_4)

				if var_444_6 > 0 and var_444_1 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_7 and arg_441_1.time_ < var_444_0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play417111107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 417111107
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play417111108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.233333333333333
			local var_448_1 = 1

			if var_448_0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_0 + arg_448_0 then
				local var_448_2 = "play"
				local var_448_3 = "effect"

				arg_445_1:AudioAction(var_448_2, var_448_3, "se_story_1310", "se_story_1310_motorcycle01", "")
			end

			local var_448_4 = 0
			local var_448_5 = 1.925

			if var_448_4 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_6 = arg_445_1:GetWordFromCfg(417111107)
				local var_448_7 = arg_445_1:FormatText(var_448_6.content)

				arg_445_1.text_.text = var_448_7

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_8 = 77
				local var_448_9 = utf8.len(var_448_7)
				local var_448_10 = var_448_8 <= 0 and var_448_5 or var_448_5 * (var_448_9 / var_448_8)

				if var_448_10 > 0 and var_448_5 < var_448_10 then
					arg_445_1.talkMaxDuration = var_448_10

					if var_448_10 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_4
					end
				end

				arg_445_1.text_.text = var_448_7
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_11 = math.max(var_448_5, arg_445_1.talkMaxDuration)

			if var_448_4 <= arg_445_1.time_ and arg_445_1.time_ < var_448_4 + var_448_11 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_4) / var_448_11

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_4 + var_448_11 and arg_445_1.time_ < var_448_4 + var_448_11 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play417111108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 417111108
		arg_449_1.duration_ = 3.3

		local var_449_0 = {
			zh = 1.966,
			ja = 3.3
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play417111109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0
			local var_452_1 = 0.275

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_2 = arg_449_1:FormatText(StoryNameCfg[1109].name)

				arg_449_1.leftNameTxt_.text = var_452_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:GetWordFromCfg(417111108)
				local var_452_4 = arg_449_1:FormatText(var_452_3.content)

				arg_449_1.text_.text = var_452_4

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 11
				local var_452_6 = utf8.len(var_452_4)
				local var_452_7 = var_452_5 <= 0 and var_452_1 or var_452_1 * (var_452_6 / var_452_5)

				if var_452_7 > 0 and var_452_1 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_0
					end
				end

				arg_449_1.text_.text = var_452_4
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111108", "story_v_out_417111.awb") ~= 0 then
					local var_452_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111108", "story_v_out_417111.awb") / 1000

					if var_452_8 + var_452_0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_8 + var_452_0
					end

					if var_452_3.prefab_name ~= "" and arg_449_1.actors_[var_452_3.prefab_name] ~= nil then
						local var_452_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_3.prefab_name].transform, "story_v_out_417111", "417111108", "story_v_out_417111.awb")

						arg_449_1:RecordAudio("417111108", var_452_9)
						arg_449_1:RecordAudio("417111108", var_452_9)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_417111", "417111108", "story_v_out_417111.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_417111", "417111108", "story_v_out_417111.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_1, arg_449_1.talkMaxDuration)

			if var_452_0 <= arg_449_1.time_ and arg_449_1.time_ < var_452_0 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_0) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_0 + var_452_10 and arg_449_1.time_ < var_452_0 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play417111109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 417111109
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play417111110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.35
			local var_456_1 = 1

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				local var_456_2 = "play"
				local var_456_3 = "effect"

				arg_453_1:AudioAction(var_456_2, var_456_3, "se_story_136", "se_story_136_gun", "")
			end

			local var_456_4 = 0
			local var_456_5 = 1.35

			if var_456_4 < arg_453_1.time_ and arg_453_1.time_ <= var_456_4 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_6 = arg_453_1:GetWordFromCfg(417111109)
				local var_456_7 = arg_453_1:FormatText(var_456_6.content)

				arg_453_1.text_.text = var_456_7

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_8 = 54
				local var_456_9 = utf8.len(var_456_7)
				local var_456_10 = var_456_8 <= 0 and var_456_5 or var_456_5 * (var_456_9 / var_456_8)

				if var_456_10 > 0 and var_456_5 < var_456_10 then
					arg_453_1.talkMaxDuration = var_456_10

					if var_456_10 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_4
					end
				end

				arg_453_1.text_.text = var_456_7
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_11 = math.max(var_456_5, arg_453_1.talkMaxDuration)

			if var_456_4 <= arg_453_1.time_ and arg_453_1.time_ < var_456_4 + var_456_11 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_4) / var_456_11

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_4 + var_456_11 and arg_453_1.time_ < var_456_4 + var_456_11 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play417111110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 417111110
		arg_457_1.duration_ = 6.44

		local var_457_0 = {
			zh = 6.44166666666666,
			ja = 6.04166666666666
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play417111111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = "SS1704"

			if arg_457_1.bgs_[var_460_0] == nil then
				local var_460_1 = Object.Instantiate(arg_457_1.paintGo_)

				var_460_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_460_0)
				var_460_1.name = var_460_0
				var_460_1.transform.parent = arg_457_1.stage_.transform
				var_460_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_457_1.bgs_[var_460_0] = var_460_1
			end

			local var_460_2 = 2.36666666666667

			if var_460_2 < arg_457_1.time_ and arg_457_1.time_ <= var_460_2 + arg_460_0 then
				local var_460_3 = manager.ui.mainCamera.transform.localPosition
				local var_460_4 = Vector3.New(0, 0, 10) + Vector3.New(var_460_3.x, var_460_3.y, 0)
				local var_460_5 = arg_457_1.bgs_.SS1704

				var_460_5.transform.localPosition = var_460_4
				var_460_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_460_6 = var_460_5:GetComponent("SpriteRenderer")

				if var_460_6 and var_460_6.sprite then
					local var_460_7 = (var_460_5.transform.localPosition - var_460_3).z
					local var_460_8 = manager.ui.mainCameraCom_
					local var_460_9 = 2 * var_460_7 * Mathf.Tan(var_460_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_460_10 = var_460_9 * var_460_8.aspect
					local var_460_11 = var_460_6.sprite.bounds.size.x
					local var_460_12 = var_460_6.sprite.bounds.size.y
					local var_460_13 = var_460_10 / var_460_11
					local var_460_14 = var_460_9 / var_460_12
					local var_460_15 = var_460_14 < var_460_13 and var_460_13 or var_460_14

					var_460_5.transform.localScale = Vector3.New(var_460_15, var_460_15, 0)
				end

				for iter_460_0, iter_460_1 in pairs(arg_457_1.bgs_) do
					if iter_460_0 ~= "SS1704" then
						iter_460_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_460_16 = 2.43333333333333

			if var_460_16 < arg_457_1.time_ and arg_457_1.time_ <= var_460_16 + arg_460_0 then
				arg_457_1.allBtn_.enabled = false
			end

			local var_460_17 = 0.3

			if arg_457_1.time_ >= var_460_16 + var_460_17 and arg_457_1.time_ < var_460_16 + var_460_17 + arg_460_0 then
				arg_457_1.allBtn_.enabled = true
			end

			local var_460_18 = 0

			if var_460_18 < arg_457_1.time_ and arg_457_1.time_ <= var_460_18 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_19 = 2.36666666666667

			if var_460_18 <= arg_457_1.time_ and arg_457_1.time_ < var_460_18 + var_460_19 then
				local var_460_20 = (arg_457_1.time_ - var_460_18) / var_460_19
				local var_460_21 = Color.New(0, 0, 0)

				var_460_21.a = Mathf.Lerp(0, 1, var_460_20)
				arg_457_1.mask_.color = var_460_21
			end

			if arg_457_1.time_ >= var_460_18 + var_460_19 and arg_457_1.time_ < var_460_18 + var_460_19 + arg_460_0 then
				local var_460_22 = Color.New(0, 0, 0)

				var_460_22.a = 1
				arg_457_1.mask_.color = var_460_22
			end

			local var_460_23 = 2.36666666666667

			if var_460_23 < arg_457_1.time_ and arg_457_1.time_ <= var_460_23 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_24 = 2.56666666666667

			if var_460_23 <= arg_457_1.time_ and arg_457_1.time_ < var_460_23 + var_460_24 then
				local var_460_25 = (arg_457_1.time_ - var_460_23) / var_460_24
				local var_460_26 = Color.New(0, 0, 0)

				var_460_26.a = Mathf.Lerp(1, 0, var_460_25)
				arg_457_1.mask_.color = var_460_26
			end

			if arg_457_1.time_ >= var_460_23 + var_460_24 and arg_457_1.time_ < var_460_23 + var_460_24 + arg_460_0 then
				local var_460_27 = Color.New(0, 0, 0)
				local var_460_28 = 0

				arg_457_1.mask_.enabled = false
				var_460_27.a = var_460_28
				arg_457_1.mask_.color = var_460_27
			end

			local var_460_29 = arg_457_1.bgs_.SS1704.transform
			local var_460_30 = 2.36666666666667

			if var_460_30 < arg_457_1.time_ and arg_457_1.time_ <= var_460_30 + arg_460_0 then
				arg_457_1.var_.moveOldPosSS1704 = var_460_29.localPosition
			end

			local var_460_31 = 0.001

			if var_460_30 <= arg_457_1.time_ and arg_457_1.time_ < var_460_30 + var_460_31 then
				local var_460_32 = (arg_457_1.time_ - var_460_30) / var_460_31
				local var_460_33 = Vector3.New(0, 1, 10)

				var_460_29.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPosSS1704, var_460_33, var_460_32)
			end

			if arg_457_1.time_ >= var_460_30 + var_460_31 and arg_457_1.time_ < var_460_30 + var_460_31 + arg_460_0 then
				var_460_29.localPosition = Vector3.New(0, 1, 10)
			end

			local var_460_34 = arg_457_1.bgs_.SS1704.transform
			local var_460_35 = 2.66666666666667

			if var_460_35 < arg_457_1.time_ and arg_457_1.time_ <= var_460_35 + arg_460_0 then
				arg_457_1.var_.moveOldPosSS1704 = var_460_34.localPosition
			end

			local var_460_36 = 2.21666666666667

			if var_460_35 <= arg_457_1.time_ and arg_457_1.time_ < var_460_35 + var_460_36 then
				local var_460_37 = (arg_457_1.time_ - var_460_35) / var_460_36
				local var_460_38 = Vector3.New(0, 1, 9)

				var_460_34.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPosSS1704, var_460_38, var_460_37)
			end

			if arg_457_1.time_ >= var_460_35 + var_460_36 and arg_457_1.time_ < var_460_35 + var_460_36 + arg_460_0 then
				var_460_34.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_457_1.frameCnt_ <= 1 then
				arg_457_1.dialog_:SetActive(false)
			end

			local var_460_39 = 3.74166666666666
			local var_460_40 = 0.325

			if var_460_39 < arg_457_1.time_ and arg_457_1.time_ <= var_460_39 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0

				arg_457_1.dialog_:SetActive(true)

				arg_457_1.dialogCg_.alpha = 0

				local var_460_41 = LeanTween.value(arg_457_1.dialog_, 0, 1, 0.3)

				var_460_41:setOnUpdate(LuaHelper.FloatAction(function(arg_461_0)
					arg_457_1.dialogCg_.alpha = arg_461_0
				end))
				var_460_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_457_1.dialog_)
					var_460_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_457_1.duration_ = arg_457_1.duration_ + 0.3

				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_42 = arg_457_1:FormatText(StoryNameCfg[672].name)

				arg_457_1.leftNameTxt_.text = var_460_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_43 = arg_457_1:GetWordFromCfg(417111110)
				local var_460_44 = arg_457_1:FormatText(var_460_43.content)

				arg_457_1.text_.text = var_460_44

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_45 = 13
				local var_460_46 = utf8.len(var_460_44)
				local var_460_47 = var_460_45 <= 0 and var_460_40 or var_460_40 * (var_460_46 / var_460_45)

				if var_460_47 > 0 and var_460_40 < var_460_47 then
					arg_457_1.talkMaxDuration = var_460_47
					var_460_39 = var_460_39 + 0.3

					if var_460_47 + var_460_39 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_47 + var_460_39
					end
				end

				arg_457_1.text_.text = var_460_44
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111110", "story_v_out_417111.awb") ~= 0 then
					local var_460_48 = manager.audio:GetVoiceLength("story_v_out_417111", "417111110", "story_v_out_417111.awb") / 1000

					if var_460_48 + var_460_39 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_48 + var_460_39
					end

					if var_460_43.prefab_name ~= "" and arg_457_1.actors_[var_460_43.prefab_name] ~= nil then
						local var_460_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_43.prefab_name].transform, "story_v_out_417111", "417111110", "story_v_out_417111.awb")

						arg_457_1:RecordAudio("417111110", var_460_49)
						arg_457_1:RecordAudio("417111110", var_460_49)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_417111", "417111110", "story_v_out_417111.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_417111", "417111110", "story_v_out_417111.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_50 = var_460_39 + 0.3
			local var_460_51 = math.max(var_460_40, arg_457_1.talkMaxDuration)

			if var_460_50 <= arg_457_1.time_ and arg_457_1.time_ < var_460_50 + var_460_51 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_50) / var_460_51

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_50 + var_460_51 and arg_457_1.time_ < var_460_50 + var_460_51 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.21666666666667,
				className = "StoryMoveNode",
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play417111111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 417111111
		arg_463_1.duration_ = 8.4

		local var_463_0 = {
			zh = 5.833,
			ja = 8.4
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
				arg_463_0:Play417111112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.75

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_2 = arg_463_1:FormatText(StoryNameCfg[672].name)

				arg_463_1.leftNameTxt_.text = var_466_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_3 = arg_463_1:GetWordFromCfg(417111111)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_5 = 30
				local var_466_6 = utf8.len(var_466_4)
				local var_466_7 = var_466_5 <= 0 and var_466_1 or var_466_1 * (var_466_6 / var_466_5)

				if var_466_7 > 0 and var_466_1 < var_466_7 then
					arg_463_1.talkMaxDuration = var_466_7

					if var_466_7 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111111", "story_v_out_417111.awb") ~= 0 then
					local var_466_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111111", "story_v_out_417111.awb") / 1000

					if var_466_8 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_8 + var_466_0
					end

					if var_466_3.prefab_name ~= "" and arg_463_1.actors_[var_466_3.prefab_name] ~= nil then
						local var_466_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_3.prefab_name].transform, "story_v_out_417111", "417111111", "story_v_out_417111.awb")

						arg_463_1:RecordAudio("417111111", var_466_9)
						arg_463_1:RecordAudio("417111111", var_466_9)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_417111", "417111111", "story_v_out_417111.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_417111", "417111111", "story_v_out_417111.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_10 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_10 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_10

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_10 and arg_463_1.time_ < var_466_0 + var_466_10 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play417111112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 417111112
		arg_467_1.duration_ = 6.13

		local var_467_0 = {
			zh = 4.133,
			ja = 6.133
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
				arg_467_0:Play417111113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 0.575

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_2 = arg_467_1:FormatText(StoryNameCfg[672].name)

				arg_467_1.leftNameTxt_.text = var_470_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_3 = arg_467_1:GetWordFromCfg(417111112)
				local var_470_4 = arg_467_1:FormatText(var_470_3.content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 23
				local var_470_6 = utf8.len(var_470_4)
				local var_470_7 = var_470_5 <= 0 and var_470_1 or var_470_1 * (var_470_6 / var_470_5)

				if var_470_7 > 0 and var_470_1 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111112", "story_v_out_417111.awb") ~= 0 then
					local var_470_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111112", "story_v_out_417111.awb") / 1000

					if var_470_8 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_0
					end

					if var_470_3.prefab_name ~= "" and arg_467_1.actors_[var_470_3.prefab_name] ~= nil then
						local var_470_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_3.prefab_name].transform, "story_v_out_417111", "417111112", "story_v_out_417111.awb")

						arg_467_1:RecordAudio("417111112", var_470_9)
						arg_467_1:RecordAudio("417111112", var_470_9)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_417111", "417111112", "story_v_out_417111.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_417111", "417111112", "story_v_out_417111.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_10 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_10 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_10

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_10 and arg_467_1.time_ < var_470_0 + var_470_10 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play417111113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 417111113
		arg_471_1.duration_ = 7.73

		local var_471_0 = {
			zh = 4.9,
			ja = 7.733
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play417111114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = 0
			local var_474_1 = 0.525

			if var_474_0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_2 = arg_471_1:FormatText(StoryNameCfg[672].name)

				arg_471_1.leftNameTxt_.text = var_474_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_3 = arg_471_1:GetWordFromCfg(417111113)
				local var_474_4 = arg_471_1:FormatText(var_474_3.content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_5 = 21
				local var_474_6 = utf8.len(var_474_4)
				local var_474_7 = var_474_5 <= 0 and var_474_1 or var_474_1 * (var_474_6 / var_474_5)

				if var_474_7 > 0 and var_474_1 < var_474_7 then
					arg_471_1.talkMaxDuration = var_474_7

					if var_474_7 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111113", "story_v_out_417111.awb") ~= 0 then
					local var_474_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111113", "story_v_out_417111.awb") / 1000

					if var_474_8 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_8 + var_474_0
					end

					if var_474_3.prefab_name ~= "" and arg_471_1.actors_[var_474_3.prefab_name] ~= nil then
						local var_474_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_3.prefab_name].transform, "story_v_out_417111", "417111113", "story_v_out_417111.awb")

						arg_471_1:RecordAudio("417111113", var_474_9)
						arg_471_1:RecordAudio("417111113", var_474_9)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_417111", "417111113", "story_v_out_417111.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_417111", "417111113", "story_v_out_417111.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_10 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_10 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_10

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_10 and arg_471_1.time_ < var_474_0 + var_474_10 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play417111114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 417111114
		arg_475_1.duration_ = 4.17

		local var_475_0 = {
			zh = 3.433,
			ja = 4.166
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play417111115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1034"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.actorSpriteComps1034 == nil then
				arg_475_1.var_.actorSpriteComps1034 = var_478_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_2 = 0.2

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 and not isNil(var_478_0) then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.actorSpriteComps1034 then
					for iter_478_0, iter_478_1 in pairs(arg_475_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_478_1 then
							if arg_475_1.isInRecall_ then
								local var_478_4 = Mathf.Lerp(iter_478_1.color.r, arg_475_1.hightColor1.r, var_478_3)
								local var_478_5 = Mathf.Lerp(iter_478_1.color.g, arg_475_1.hightColor1.g, var_478_3)
								local var_478_6 = Mathf.Lerp(iter_478_1.color.b, arg_475_1.hightColor1.b, var_478_3)

								iter_478_1.color = Color.New(var_478_4, var_478_5, var_478_6)
							else
								local var_478_7 = Mathf.Lerp(iter_478_1.color.r, 1, var_478_3)

								iter_478_1.color = Color.New(var_478_7, var_478_7, var_478_7)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and not isNil(var_478_0) and arg_475_1.var_.actorSpriteComps1034 then
				for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_478_3 then
						if arg_475_1.isInRecall_ then
							iter_478_3.color = arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_478_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_475_1.var_.actorSpriteComps1034 = nil
			end

			local var_478_8 = 0
			local var_478_9 = 0.325

			if var_478_8 < arg_475_1.time_ and arg_475_1.time_ <= var_478_8 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_10 = arg_475_1:FormatText(StoryNameCfg[1109].name)

				arg_475_1.leftNameTxt_.text = var_478_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_11 = arg_475_1:GetWordFromCfg(417111114)
				local var_478_12 = arg_475_1:FormatText(var_478_11.content)

				arg_475_1.text_.text = var_478_12

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_13 = 13
				local var_478_14 = utf8.len(var_478_12)
				local var_478_15 = var_478_13 <= 0 and var_478_9 or var_478_9 * (var_478_14 / var_478_13)

				if var_478_15 > 0 and var_478_9 < var_478_15 then
					arg_475_1.talkMaxDuration = var_478_15

					if var_478_15 + var_478_8 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_15 + var_478_8
					end
				end

				arg_475_1.text_.text = var_478_12
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111114", "story_v_out_417111.awb") ~= 0 then
					local var_478_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111114", "story_v_out_417111.awb") / 1000

					if var_478_16 + var_478_8 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_16 + var_478_8
					end

					if var_478_11.prefab_name ~= "" and arg_475_1.actors_[var_478_11.prefab_name] ~= nil then
						local var_478_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_11.prefab_name].transform, "story_v_out_417111", "417111114", "story_v_out_417111.awb")

						arg_475_1:RecordAudio("417111114", var_478_17)
						arg_475_1:RecordAudio("417111114", var_478_17)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_417111", "417111114", "story_v_out_417111.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_417111", "417111114", "story_v_out_417111.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_18 = math.max(var_478_9, arg_475_1.talkMaxDuration)

			if var_478_8 <= arg_475_1.time_ and arg_475_1.time_ < var_478_8 + var_478_18 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_8) / var_478_18

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_8 + var_478_18 and arg_475_1.time_ < var_478_8 + var_478_18 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play417111115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 417111115
		arg_479_1.duration_ = 5

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play417111116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = arg_479_1.actors_["1034"]
			local var_482_1 = 0

			if var_482_1 < arg_479_1.time_ and arg_479_1.time_ <= var_482_1 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.actorSpriteComps1034 == nil then
				arg_479_1.var_.actorSpriteComps1034 = var_482_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_2 = 0.2

			if var_482_1 <= arg_479_1.time_ and arg_479_1.time_ < var_482_1 + var_482_2 and not isNil(var_482_0) then
				local var_482_3 = (arg_479_1.time_ - var_482_1) / var_482_2

				if arg_479_1.var_.actorSpriteComps1034 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								local var_482_4 = Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor2.r, var_482_3)
								local var_482_5 = Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor2.g, var_482_3)
								local var_482_6 = Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor2.b, var_482_3)

								iter_482_1.color = Color.New(var_482_4, var_482_5, var_482_6)
							else
								local var_482_7 = Mathf.Lerp(iter_482_1.color.r, 0.5, var_482_3)

								iter_482_1.color = Color.New(var_482_7, var_482_7, var_482_7)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= var_482_1 + var_482_2 and arg_479_1.time_ < var_482_1 + var_482_2 + arg_482_0 and not isNil(var_482_0) and arg_479_1.var_.actorSpriteComps1034 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_482_3 then
						if arg_479_1.isInRecall_ then
							iter_482_3.color = arg_479_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_482_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_479_1.var_.actorSpriteComps1034 = nil
			end

			local var_482_8 = 0.2
			local var_482_9 = 1

			if var_482_8 < arg_479_1.time_ and arg_479_1.time_ <= var_482_8 + arg_482_0 then
				local var_482_10 = "play"
				local var_482_11 = "effect"

				arg_479_1:AudioAction(var_482_10, var_482_11, "se_story_123_01", "se_story_123_01_gun", "")
			end

			local var_482_12 = 0
			local var_482_13 = 1.15

			if var_482_12 < arg_479_1.time_ and arg_479_1.time_ <= var_482_12 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, false)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_14 = arg_479_1:GetWordFromCfg(417111115)
				local var_482_15 = arg_479_1:FormatText(var_482_14.content)

				arg_479_1.text_.text = var_482_15

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_16 = 46
				local var_482_17 = utf8.len(var_482_15)
				local var_482_18 = var_482_16 <= 0 and var_482_13 or var_482_13 * (var_482_17 / var_482_16)

				if var_482_18 > 0 and var_482_13 < var_482_18 then
					arg_479_1.talkMaxDuration = var_482_18

					if var_482_18 + var_482_12 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_18 + var_482_12
					end
				end

				arg_479_1.text_.text = var_482_15
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)
				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_19 = math.max(var_482_13, arg_479_1.talkMaxDuration)

			if var_482_12 <= arg_479_1.time_ and arg_479_1.time_ < var_482_12 + var_482_19 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_12) / var_482_19

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_12 + var_482_19 and arg_479_1.time_ < var_482_12 + var_482_19 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play417111116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 417111116
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play417111117(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 1.1

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_2 = arg_483_1:GetWordFromCfg(417111116)
				local var_486_3 = arg_483_1:FormatText(var_486_2.content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_4 = 44
				local var_486_5 = utf8.len(var_486_3)
				local var_486_6 = var_486_4 <= 0 and var_486_1 or var_486_1 * (var_486_5 / var_486_4)

				if var_486_6 > 0 and var_486_1 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_7 and arg_483_1.time_ < var_486_0 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play417111117 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 417111117
		arg_487_1.duration_ = 5.13

		local var_487_0 = {
			zh = 3.866,
			ja = 5.133
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play417111118(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["1034"]
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 and not isNil(var_490_0) and arg_487_1.var_.actorSpriteComps1034 == nil then
				arg_487_1.var_.actorSpriteComps1034 = var_490_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_490_2 = 0.2

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 and not isNil(var_490_0) then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2

				if arg_487_1.var_.actorSpriteComps1034 then
					for iter_490_0, iter_490_1 in pairs(arg_487_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_490_1 then
							if arg_487_1.isInRecall_ then
								local var_490_4 = Mathf.Lerp(iter_490_1.color.r, arg_487_1.hightColor1.r, var_490_3)
								local var_490_5 = Mathf.Lerp(iter_490_1.color.g, arg_487_1.hightColor1.g, var_490_3)
								local var_490_6 = Mathf.Lerp(iter_490_1.color.b, arg_487_1.hightColor1.b, var_490_3)

								iter_490_1.color = Color.New(var_490_4, var_490_5, var_490_6)
							else
								local var_490_7 = Mathf.Lerp(iter_490_1.color.r, 1, var_490_3)

								iter_490_1.color = Color.New(var_490_7, var_490_7, var_490_7)
							end
						end
					end
				end
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 and not isNil(var_490_0) and arg_487_1.var_.actorSpriteComps1034 then
				for iter_490_2, iter_490_3 in pairs(arg_487_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_490_3 then
						if arg_487_1.isInRecall_ then
							iter_490_3.color = arg_487_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_490_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_487_1.var_.actorSpriteComps1034 = nil
			end

			local var_490_8 = 0
			local var_490_9 = 0.45

			if var_490_8 < arg_487_1.time_ and arg_487_1.time_ <= var_490_8 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_10 = arg_487_1:FormatText(StoryNameCfg[1109].name)

				arg_487_1.leftNameTxt_.text = var_490_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_11 = arg_487_1:GetWordFromCfg(417111117)
				local var_490_12 = arg_487_1:FormatText(var_490_11.content)

				arg_487_1.text_.text = var_490_12

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_13 = 18
				local var_490_14 = utf8.len(var_490_12)
				local var_490_15 = var_490_13 <= 0 and var_490_9 or var_490_9 * (var_490_14 / var_490_13)

				if var_490_15 > 0 and var_490_9 < var_490_15 then
					arg_487_1.talkMaxDuration = var_490_15

					if var_490_15 + var_490_8 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_15 + var_490_8
					end
				end

				arg_487_1.text_.text = var_490_12
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111117", "story_v_out_417111.awb") ~= 0 then
					local var_490_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111117", "story_v_out_417111.awb") / 1000

					if var_490_16 + var_490_8 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_16 + var_490_8
					end

					if var_490_11.prefab_name ~= "" and arg_487_1.actors_[var_490_11.prefab_name] ~= nil then
						local var_490_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_11.prefab_name].transform, "story_v_out_417111", "417111117", "story_v_out_417111.awb")

						arg_487_1:RecordAudio("417111117", var_490_17)
						arg_487_1:RecordAudio("417111117", var_490_17)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_417111", "417111117", "story_v_out_417111.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_417111", "417111117", "story_v_out_417111.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_18 = math.max(var_490_9, arg_487_1.talkMaxDuration)

			if var_490_8 <= arg_487_1.time_ and arg_487_1.time_ < var_490_8 + var_490_18 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_8) / var_490_18

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_8 + var_490_18 and arg_487_1.time_ < var_490_8 + var_490_18 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play417111118 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 417111118
		arg_491_1.duration_ = 5.3

		local var_491_0 = {
			zh = 3.7,
			ja = 5.3
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play417111119(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 0.475

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_2 = arg_491_1:FormatText(StoryNameCfg[1109].name)

				arg_491_1.leftNameTxt_.text = var_494_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_3 = arg_491_1:GetWordFromCfg(417111118)
				local var_494_4 = arg_491_1:FormatText(var_494_3.content)

				arg_491_1.text_.text = var_494_4

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 19
				local var_494_6 = utf8.len(var_494_4)
				local var_494_7 = var_494_5 <= 0 and var_494_1 or var_494_1 * (var_494_6 / var_494_5)

				if var_494_7 > 0 and var_494_1 < var_494_7 then
					arg_491_1.talkMaxDuration = var_494_7

					if var_494_7 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_7 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_4
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111118", "story_v_out_417111.awb") ~= 0 then
					local var_494_8 = manager.audio:GetVoiceLength("story_v_out_417111", "417111118", "story_v_out_417111.awb") / 1000

					if var_494_8 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_8 + var_494_0
					end

					if var_494_3.prefab_name ~= "" and arg_491_1.actors_[var_494_3.prefab_name] ~= nil then
						local var_494_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_3.prefab_name].transform, "story_v_out_417111", "417111118", "story_v_out_417111.awb")

						arg_491_1:RecordAudio("417111118", var_494_9)
						arg_491_1:RecordAudio("417111118", var_494_9)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_417111", "417111118", "story_v_out_417111.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_417111", "417111118", "story_v_out_417111.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_10 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_10 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_10

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_10 and arg_491_1.time_ < var_494_0 + var_494_10 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play417111119 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 417111119
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play417111120(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["1034"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.actorSpriteComps1034 == nil then
				arg_495_1.var_.actorSpriteComps1034 = var_498_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_2 = 0.2

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 and not isNil(var_498_0) then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.actorSpriteComps1034 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								local var_498_4 = Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor2.r, var_498_3)
								local var_498_5 = Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor2.g, var_498_3)
								local var_498_6 = Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor2.b, var_498_3)

								iter_498_1.color = Color.New(var_498_4, var_498_5, var_498_6)
							else
								local var_498_7 = Mathf.Lerp(iter_498_1.color.r, 0.5, var_498_3)

								iter_498_1.color = Color.New(var_498_7, var_498_7, var_498_7)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and not isNil(var_498_0) and arg_495_1.var_.actorSpriteComps1034 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_498_3 then
						if arg_495_1.isInRecall_ then
							iter_498_3.color = arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_498_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_495_1.var_.actorSpriteComps1034 = nil
			end

			local var_498_8 = 0
			local var_498_9 = 0.75

			if var_498_8 < arg_495_1.time_ and arg_495_1.time_ <= var_498_8 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, false)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_10 = arg_495_1:GetWordFromCfg(417111119)
				local var_498_11 = arg_495_1:FormatText(var_498_10.content)

				arg_495_1.text_.text = var_498_11

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_12 = 30
				local var_498_13 = utf8.len(var_498_11)
				local var_498_14 = var_498_12 <= 0 and var_498_9 or var_498_9 * (var_498_13 / var_498_12)

				if var_498_14 > 0 and var_498_9 < var_498_14 then
					arg_495_1.talkMaxDuration = var_498_14

					if var_498_14 + var_498_8 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_14 + var_498_8
					end
				end

				arg_495_1.text_.text = var_498_11
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_15 = math.max(var_498_9, arg_495_1.talkMaxDuration)

			if var_498_8 <= arg_495_1.time_ and arg_495_1.time_ < var_498_8 + var_498_15 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_8) / var_498_15

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_8 + var_498_15 and arg_495_1.time_ < var_498_8 + var_498_15 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play417111120 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 417111120
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play417111121(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 0.775

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_2 = arg_499_1:GetWordFromCfg(417111120)
				local var_502_3 = arg_499_1:FormatText(var_502_2.content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 31
				local var_502_5 = utf8.len(var_502_3)
				local var_502_6 = var_502_4 <= 0 and var_502_1 or var_502_1 * (var_502_5 / var_502_4)

				if var_502_6 > 0 and var_502_1 < var_502_6 then
					arg_499_1.talkMaxDuration = var_502_6

					if var_502_6 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_6 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_7 and arg_499_1.time_ < var_502_0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play417111121 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 417111121
		arg_503_1.duration_ = 6.27

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play417111122(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = manager.ui.mainCamera.transform
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				local var_506_2 = arg_503_1.var_.effect385
				local var_506_3
				local var_506_4 = var_506_0

				if not var_506_2 then
					var_506_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), var_506_4)
					var_506_2.name = "385"
					arg_503_1.var_.effect385 = var_506_2
				else
					var_506_2.transform:SetParent(var_506_4)
				end

				var_506_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_506_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_506_5 = manager.ui.mainCameraCom_
				local var_506_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_506_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_506_7 = var_506_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_506_8 = 15
				local var_506_9 = 2 * var_506_8 * Mathf.Tan(var_506_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_506_5.aspect
				local var_506_10 = 1
				local var_506_11 = 1.7777777777777777

				if var_506_11 < var_506_5.aspect then
					var_506_10 = var_506_9 / (2 * var_506_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_506_11)
				end

				for iter_506_0, iter_506_1 in ipairs(var_506_7) do
					local var_506_12 = iter_506_1.transform.localScale

					iter_506_1.transform.localScale = Vector3.New(var_506_12.x / var_506_6 * var_506_10, var_506_12.y / var_506_6, var_506_12.z)
				end
			end

			local var_506_13 = 0

			if var_506_13 < arg_503_1.time_ and arg_503_1.time_ <= var_506_13 + arg_506_0 then
				arg_503_1.mask_.enabled = true
				arg_503_1.mask_.raycastTarget = true

				arg_503_1:SetGaussion(false)
			end

			local var_506_14 = 0.266666666666667

			if var_506_13 <= arg_503_1.time_ and arg_503_1.time_ < var_506_13 + var_506_14 then
				local var_506_15 = (arg_503_1.time_ - var_506_13) / var_506_14
				local var_506_16 = Color.New(1, 1, 1)

				var_506_16.a = Mathf.Lerp(1, 0, var_506_15)
				arg_503_1.mask_.color = var_506_16
			end

			if arg_503_1.time_ >= var_506_13 + var_506_14 and arg_503_1.time_ < var_506_13 + var_506_14 + arg_506_0 then
				local var_506_17 = Color.New(1, 1, 1)
				local var_506_18 = 0

				arg_503_1.mask_.enabled = false
				var_506_17.a = var_506_18
				arg_503_1.mask_.color = var_506_17
			end

			local var_506_19 = arg_503_1.bgs_.SS1704.transform
			local var_506_20 = 0

			if var_506_20 < arg_503_1.time_ and arg_503_1.time_ <= var_506_20 + arg_506_0 then
				arg_503_1.var_.moveOldPosSS1704 = var_506_19.localPosition
			end

			local var_506_21 = 0.001

			if var_506_20 <= arg_503_1.time_ and arg_503_1.time_ < var_506_20 + var_506_21 then
				local var_506_22 = (arg_503_1.time_ - var_506_20) / var_506_21
				local var_506_23 = Vector3.New(0, 1, 9)

				var_506_19.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPosSS1704, var_506_23, var_506_22)
			end

			if arg_503_1.time_ >= var_506_20 + var_506_21 and arg_503_1.time_ < var_506_20 + var_506_21 + arg_506_0 then
				var_506_19.localPosition = Vector3.New(0, 1, 9)
			end

			local var_506_24 = arg_503_1.bgs_.SS1704.transform
			local var_506_25 = 0.0166666666666667

			if var_506_25 < arg_503_1.time_ and arg_503_1.time_ <= var_506_25 + arg_506_0 then
				arg_503_1.var_.moveOldPosSS1704 = var_506_24.localPosition
			end

			local var_506_26 = 0.816666666666667

			if var_506_25 <= arg_503_1.time_ and arg_503_1.time_ < var_506_25 + var_506_26 then
				local var_506_27 = (arg_503_1.time_ - var_506_25) / var_506_26
				local var_506_28 = Vector3.New(0, 1, 10)

				var_506_24.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPosSS1704, var_506_28, var_506_27)
			end

			if arg_503_1.time_ >= var_506_25 + var_506_26 and arg_503_1.time_ < var_506_25 + var_506_26 + arg_506_0 then
				var_506_24.localPosition = Vector3.New(0, 1, 10)
			end

			local var_506_29 = 0

			if var_506_29 < arg_503_1.time_ and arg_503_1.time_ <= var_506_29 + arg_506_0 then
				arg_503_1.allBtn_.enabled = false
			end

			local var_506_30 = 1.73771769693121

			if arg_503_1.time_ >= var_506_29 + var_506_30 and arg_503_1.time_ < var_506_29 + var_506_30 + arg_506_0 then
				arg_503_1.allBtn_.enabled = true
			end

			local var_506_31 = 0.266666666666667
			local var_506_32 = 1

			if var_506_31 < arg_503_1.time_ and arg_503_1.time_ <= var_506_31 + arg_506_0 then
				local var_506_33 = "play"
				local var_506_34 = "effect"

				arg_503_1:AudioAction(var_506_33, var_506_34, "se_story_1310", "se_story_1310_motorcycle02", "")
			end

			if arg_503_1.frameCnt_ <= 1 then
				arg_503_1.dialog_:SetActive(false)
			end

			local var_506_35 = 1.26666666666667
			local var_506_36 = 1.1

			if var_506_35 < arg_503_1.time_ and arg_503_1.time_ <= var_506_35 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0

				arg_503_1.dialog_:SetActive(true)

				arg_503_1.dialogCg_.alpha = 0

				local var_506_37 = LeanTween.value(arg_503_1.dialog_, 0, 1, 0.3)

				var_506_37:setOnUpdate(LuaHelper.FloatAction(function(arg_507_0)
					arg_503_1.dialogCg_.alpha = arg_507_0
				end))
				var_506_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_503_1.dialog_)
					var_506_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_503_1.duration_ = arg_503_1.duration_ + 0.3

				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_38 = arg_503_1:GetWordFromCfg(417111121)
				local var_506_39 = arg_503_1:FormatText(var_506_38.content)

				arg_503_1.text_.text = var_506_39

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_40 = 44
				local var_506_41 = utf8.len(var_506_39)
				local var_506_42 = var_506_40 <= 0 and var_506_36 or var_506_36 * (var_506_41 / var_506_40)

				if var_506_42 > 0 and var_506_36 < var_506_42 then
					arg_503_1.talkMaxDuration = var_506_42
					var_506_35 = var_506_35 + 0.3

					if var_506_42 + var_506_35 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_42 + var_506_35
					end
				end

				arg_503_1.text_.text = var_506_39
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_43 = var_506_35 + 0.3
			local var_506_44 = math.max(var_506_36, arg_503_1.talkMaxDuration)

			if var_506_43 <= arg_503_1.time_ and arg_503_1.time_ < var_506_43 + var_506_44 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_43) / var_506_44

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_43 + var_506_44 and arg_503_1.time_ < var_506_43 + var_506_44 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.816666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play417111122 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 417111122
		arg_509_1.duration_ = 7.87

		local var_509_0 = {
			zh = 4.8,
			ja = 7.866
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
			arg_509_1.auto_ = false
		end

		function arg_509_1.playNext_(arg_511_0)
			arg_509_1.onStoryFinished_()
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["1034"]
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.actorSpriteComps1034 == nil then
				arg_509_1.var_.actorSpriteComps1034 = var_512_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_512_2 = 0.2

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 and not isNil(var_512_0) then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2

				if arg_509_1.var_.actorSpriteComps1034 then
					for iter_512_0, iter_512_1 in pairs(arg_509_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.actorSpriteComps1034 then
				for iter_512_2, iter_512_3 in pairs(arg_509_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_512_3 then
						if arg_509_1.isInRecall_ then
							iter_512_3.color = arg_509_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_512_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_509_1.var_.actorSpriteComps1034 = nil
			end

			local var_512_8 = 0
			local var_512_9 = 0.65

			if var_512_8 < arg_509_1.time_ and arg_509_1.time_ <= var_512_8 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				local var_512_10 = arg_509_1:FormatText(StoryNameCfg[1109].name)

				arg_509_1.leftNameTxt_.text = var_512_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_11 = arg_509_1:GetWordFromCfg(417111122)
				local var_512_12 = arg_509_1:FormatText(var_512_11.content)

				arg_509_1.text_.text = var_512_12

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_13 = 26
				local var_512_14 = utf8.len(var_512_12)
				local var_512_15 = var_512_13 <= 0 and var_512_9 or var_512_9 * (var_512_14 / var_512_13)

				if var_512_15 > 0 and var_512_9 < var_512_15 then
					arg_509_1.talkMaxDuration = var_512_15

					if var_512_15 + var_512_8 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_15 + var_512_8
					end
				end

				arg_509_1.text_.text = var_512_12
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417111", "417111122", "story_v_out_417111.awb") ~= 0 then
					local var_512_16 = manager.audio:GetVoiceLength("story_v_out_417111", "417111122", "story_v_out_417111.awb") / 1000

					if var_512_16 + var_512_8 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_16 + var_512_8
					end

					if var_512_11.prefab_name ~= "" and arg_509_1.actors_[var_512_11.prefab_name] ~= nil then
						local var_512_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_11.prefab_name].transform, "story_v_out_417111", "417111122", "story_v_out_417111.awb")

						arg_509_1:RecordAudio("417111122", var_512_17)
						arg_509_1:RecordAudio("417111122", var_512_17)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_417111", "417111122", "story_v_out_417111.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_417111", "417111122", "story_v_out_417111.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_18 = math.max(var_512_9, arg_509_1.talkMaxDuration)

			if var_512_8 <= arg_509_1.time_ and arg_509_1.time_ < var_512_8 + var_512_18 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_8) / var_512_18

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_8 + var_512_18 and arg_509_1.time_ < var_512_8 + var_512_18 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I16i",
		"TextureConfig/Background/SS1704"
	},
	voices = {
		"story_v_out_417111.awb"
	}
}
