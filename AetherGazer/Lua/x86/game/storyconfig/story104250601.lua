return {
	Play425061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425061001
		arg_1_1.duration_ = 7.84

		local var_1_0 = {
			zh = 5.77500033333333,
			ja = 7.84100033333333
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
				arg_1_0:Play425061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 4.20000033333333

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.3

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "1037"

			if arg_1_1.actors_[var_4_2] == nil then
				local var_4_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_4_3) then
					local var_4_4 = Object.Instantiate(var_4_3, arg_1_1.canvasGo_.transform)

					var_4_4.transform:SetSiblingIndex(1)

					var_4_4.name = var_4_2
					var_4_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_2] = var_4_4

					local var_4_5 = var_4_4:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_0, iter_4_1 in ipairs(var_4_5) do
							iter_4_1.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_6 = arg_1_1.actors_["1037"]
			local var_4_7 = 4.20000033333333

			if var_4_7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 and not isNil(var_4_6) and arg_1_1.var_.actorSpriteComps1037 == nil then
				arg_1_1.var_.actorSpriteComps1037 = var_4_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_8 = 0.2

			if var_4_7 <= arg_1_1.time_ and arg_1_1.time_ < var_4_7 + var_4_8 and not isNil(var_4_6) then
				local var_4_9 = (arg_1_1.time_ - var_4_7) / var_4_8

				if arg_1_1.var_.actorSpriteComps1037 then
					for iter_4_2, iter_4_3 in pairs(arg_1_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_4_3 then
							if arg_1_1.isInRecall_ then
								local var_4_10 = Mathf.Lerp(iter_4_3.color.r, arg_1_1.hightColor1.r, var_4_9)
								local var_4_11 = Mathf.Lerp(iter_4_3.color.g, arg_1_1.hightColor1.g, var_4_9)
								local var_4_12 = Mathf.Lerp(iter_4_3.color.b, arg_1_1.hightColor1.b, var_4_9)

								iter_4_3.color = Color.New(var_4_10, var_4_11, var_4_12)
							else
								local var_4_13 = Mathf.Lerp(iter_4_3.color.r, 1, var_4_9)

								iter_4_3.color = Color.New(var_4_13, var_4_13, var_4_13)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_7 + var_4_8 and arg_1_1.time_ < var_4_7 + var_4_8 + arg_4_0 and not isNil(var_4_6) and arg_1_1.var_.actorSpriteComps1037 then
				for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_4_5 then
						if arg_1_1.isInRecall_ then
							iter_4_5.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1037 = nil
			end

			local var_4_14 = arg_1_1.actors_["1037"].transform
			local var_4_15 = 4.20000033333333

			if var_4_15 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.var_.moveOldPos1037 = var_4_14.localPosition
				var_4_14.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1037", 3)

				local var_4_16 = var_4_14.childCount

				for iter_4_6 = 0, var_4_16 - 1 do
					local var_4_17 = var_4_14:GetChild(iter_4_6)

					if var_4_17.name == "" or not string.find(var_4_17.name, "split") then
						var_4_17.gameObject:SetActive(true)
					else
						var_4_17.gameObject:SetActive(false)
					end
				end
			end

			local var_4_18 = 0.001

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_18 then
				local var_4_19 = (arg_1_1.time_ - var_4_15) / var_4_18
				local var_4_20 = Vector3.New(0, -430, -55)

				var_4_14.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1037, var_4_20, var_4_19)
			end

			if arg_1_1.time_ >= var_4_15 + var_4_18 and arg_1_1.time_ < var_4_15 + var_4_18 + arg_4_0 then
				var_4_14.localPosition = Vector3.New(0, -430, -55)
			end

			local var_4_21 = 0
			local var_4_22 = 1.999999999999
			local var_4_23 = "ST60"

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_23)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_24 = arg_1_1:GetWordFromCfg(501102)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_timeText_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_26 = arg_1_1:GetWordFromCfg(501113)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_siteText_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_28 = 2.00000033333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_29 = 1.2

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Color.New(0, 0, 0)

				var_4_31.a = Mathf.Lerp(0, 1, var_4_30)
				arg_1_1.mask_.color = var_4_31
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				local var_4_32 = Color.New(0, 0, 0)

				var_4_32.a = 1
				arg_1_1.mask_.color = var_4_32
			end

			local var_4_33 = 3.20000033333333

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_34 = 1.2

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				local var_4_35 = (arg_1_1.time_ - var_4_33) / var_4_34
				local var_4_36 = Color.New(0, 0, 0)

				var_4_36.a = Mathf.Lerp(1, 0, var_4_35)
				arg_1_1.mask_.color = var_4_36
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				local var_4_37 = Color.New(0, 0, 0)
				local var_4_38 = 0

				arg_1_1.mask_.enabled = false
				var_4_37.a = var_4_38
				arg_1_1.mask_.color = var_4_37
			end

			local var_4_39 = "ST60"

			if arg_1_1.bgs_[var_4_39] == nil then
				local var_4_40 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_40:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_39)
				var_4_40.name = var_4_39
				var_4_40.transform.parent = arg_1_1.stage_.transform
				var_4_40.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_39] = var_4_40
			end

			local var_4_41 = 3.33333332935837e-07

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_42 = manager.ui.mainCamera.transform.localPosition
				local var_4_43 = Vector3.New(0, 0, 10) + Vector3.New(var_4_42.x, var_4_42.y, 0)
				local var_4_44 = arg_1_1.bgs_.ST60

				var_4_44.transform.localPosition = var_4_43
				var_4_44.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_45 = var_4_44:GetComponent("SpriteRenderer")

				if var_4_45 and var_4_45.sprite then
					local var_4_46 = (var_4_44.transform.localPosition - var_4_42).z
					local var_4_47 = manager.ui.mainCameraCom_
					local var_4_48 = 2 * var_4_46 * Mathf.Tan(var_4_47.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_49 = var_4_48 * var_4_47.aspect
					local var_4_50 = var_4_45.sprite.bounds.size.x
					local var_4_51 = var_4_45.sprite.bounds.size.y
					local var_4_52 = var_4_49 / var_4_50
					local var_4_53 = var_4_48 / var_4_51
					local var_4_54 = var_4_53 < var_4_52 and var_4_52 or var_4_53

					var_4_44.transform.localScale = Vector3.New(var_4_54, var_4_54, 0)
				end

				for iter_4_7, iter_4_8 in pairs(arg_1_1.bgs_) do
					if iter_4_7 ~= "ST60" then
						iter_4_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_55 = 0
			local var_4_56 = 0.3

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_61 = 2.9
			local var_4_62 = 1

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				local var_4_63 = "play"
				local var_4_64 = "music"

				arg_1_1:AudioAction(var_4_63, var_4_64, "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic.awb")

				local var_4_65 = ""
				local var_4_66 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily_acoustic", "bgm_activity_3_10_story_daily_acoustic")

				if var_4_66 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_66 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_66

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_66
						arg_1_1.bgmTxt2_.text = var_4_66
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

			local var_4_67 = 2.9
			local var_4_68 = 1

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				local var_4_69 = "play"
				local var_4_70 = "effect"

				arg_1_1:AudioAction(var_4_69, var_4_70, "se_story_147", "se_story_147_amb_rooftop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_71 = 4.37500033333333
			local var_4_72 = 0.125

			if var_4_71 < arg_1_1.time_ and arg_1_1.time_ <= var_4_71 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_73 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_73:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_74 = arg_1_1:FormatText(StoryNameCfg[15].name)

				arg_1_1.leftNameTxt_.text = var_4_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_75 = arg_1_1:GetWordFromCfg(425061001)
				local var_4_76 = arg_1_1:FormatText(var_4_75.content)

				arg_1_1.text_.text = var_4_76

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_77 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061001", "story_v_out_425061.awb") ~= 0 then
					local var_4_80 = manager.audio:GetVoiceLength("story_v_out_425061", "425061001", "story_v_out_425061.awb") / 1000

					if var_4_80 + var_4_71 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_80 + var_4_71
					end

					if var_4_75.prefab_name ~= "" and arg_1_1.actors_[var_4_75.prefab_name] ~= nil then
						local var_4_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_75.prefab_name].transform, "story_v_out_425061", "425061001", "story_v_out_425061.awb")

						arg_1_1:RecordAudio("425061001", var_4_81)
						arg_1_1:RecordAudio("425061001", var_4_81)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425061", "425061001", "story_v_out_425061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425061", "425061001", "story_v_out_425061.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.20000033333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play425061002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 425061002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play425061003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["1037"].transform
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.moveOldPos1037 = var_13_0.localPosition
				var_13_0.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1037", 7)

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
				local var_13_6 = Vector3.New(1500, -2000, 0)

				var_13_0.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1037, var_13_6, var_13_5)
			end

			if arg_10_1.time_ >= var_13_1 + var_13_4 and arg_10_1.time_ < var_13_1 + var_13_4 + arg_13_0 then
				var_13_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_13_7 = 0
			local var_13_8 = 0.75

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

				local var_13_9 = arg_10_1:GetWordFromCfg(425061002)
				local var_13_10 = arg_10_1:FormatText(var_13_9.content)

				arg_10_1.text_.text = var_13_10

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_11 = 30
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
				actorName = "1037",
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
	Play425061003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 425061003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play425061004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 0.975

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_2 = arg_14_1:FormatText(StoryNameCfg[7].name)

				arg_14_1.leftNameTxt_.text = var_17_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_3 = arg_14_1:GetWordFromCfg(425061003)
				local var_17_4 = arg_14_1:FormatText(var_17_3.content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 39
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
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_8 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_8 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_8

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_8 and arg_14_1.time_ < var_17_0 + var_17_8 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play425061004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 425061004
		arg_18_1.duration_ = 3.73

		local var_18_0 = {
			zh = 2.266,
			ja = 3.733
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
				arg_18_0:Play425061005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1037"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1037 == nil then
				arg_18_1.var_.actorSpriteComps1037 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps1037 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1037 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_21_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps1037 = nil
			end

			local var_21_8 = arg_18_1.actors_["1037"].transform
			local var_21_9 = 0

			if var_21_9 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1.var_.moveOldPos1037 = var_21_8.localPosition
				var_21_8.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1037", 3)

				local var_21_10 = var_21_8.childCount

				for iter_21_4 = 0, var_21_10 - 1 do
					local var_21_11 = var_21_8:GetChild(iter_21_4)

					if var_21_11.name == "split_5" or not string.find(var_21_11.name, "split") then
						var_21_11.gameObject:SetActive(true)
					else
						var_21_11.gameObject:SetActive(false)
					end
				end
			end

			local var_21_12 = 0.001

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_12 then
				local var_21_13 = (arg_18_1.time_ - var_21_9) / var_21_12
				local var_21_14 = Vector3.New(0, -430, -55)

				var_21_8.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1037, var_21_14, var_21_13)
			end

			if arg_18_1.time_ >= var_21_9 + var_21_12 and arg_18_1.time_ < var_21_9 + var_21_12 + arg_21_0 then
				var_21_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_21_15 = 0
			local var_21_16 = 0.225

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_17 = arg_18_1:FormatText(StoryNameCfg[15].name)

				arg_18_1.leftNameTxt_.text = var_21_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_18 = arg_18_1:GetWordFromCfg(425061004)
				local var_21_19 = arg_18_1:FormatText(var_21_18.content)

				arg_18_1.text_.text = var_21_19

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_20 = 9
				local var_21_21 = utf8.len(var_21_19)
				local var_21_22 = var_21_20 <= 0 and var_21_16 or var_21_16 * (var_21_21 / var_21_20)

				if var_21_22 > 0 and var_21_16 < var_21_22 then
					arg_18_1.talkMaxDuration = var_21_22

					if var_21_22 + var_21_15 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_22 + var_21_15
					end
				end

				arg_18_1.text_.text = var_21_19
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061004", "story_v_out_425061.awb") ~= 0 then
					local var_21_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061004", "story_v_out_425061.awb") / 1000

					if var_21_23 + var_21_15 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_23 + var_21_15
					end

					if var_21_18.prefab_name ~= "" and arg_18_1.actors_[var_21_18.prefab_name] ~= nil then
						local var_21_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_18.prefab_name].transform, "story_v_out_425061", "425061004", "story_v_out_425061.awb")

						arg_18_1:RecordAudio("425061004", var_21_24)
						arg_18_1:RecordAudio("425061004", var_21_24)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_425061", "425061004", "story_v_out_425061.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_425061", "425061004", "story_v_out_425061.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_25 = math.max(var_21_16, arg_18_1.talkMaxDuration)

			if var_21_15 <= arg_18_1.time_ and arg_18_1.time_ < var_21_15 + var_21_25 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_15) / var_21_25

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_15 + var_21_25 and arg_18_1.time_ < var_21_15 + var_21_25 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play425061005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 425061005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play425061006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1037"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1037 == nil then
				arg_22_1.var_.actorSpriteComps1037 = var_25_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_2 = 0.2

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.actorSpriteComps1037 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.actorSpriteComps1037 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_25_3 then
						if arg_22_1.isInRecall_ then
							iter_25_3.color = arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_25_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_22_1.var_.actorSpriteComps1037 = nil
			end

			local var_25_8 = 0
			local var_25_9 = 0.95

			if var_25_8 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_10 = arg_22_1:FormatText(StoryNameCfg[7].name)

				arg_22_1.leftNameTxt_.text = var_25_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_11 = arg_22_1:GetWordFromCfg(425061005)
				local var_25_12 = arg_22_1:FormatText(var_25_11.content)

				arg_22_1.text_.text = var_25_12

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_13 = 38
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
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_16 = math.max(var_25_9, arg_22_1.talkMaxDuration)

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_16 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_8) / var_25_16

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_8 + var_25_16 and arg_22_1.time_ < var_25_8 + var_25_16 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play425061006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 425061006
		arg_26_1.duration_ = 8.8

		local var_26_0 = {
			zh = 4.9,
			ja = 8.8
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
				arg_26_0:Play425061007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1037"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1037 == nil then
				arg_26_1.var_.actorSpriteComps1037 = var_29_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.actorSpriteComps1037 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1037 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_29_3 then
						if arg_26_1.isInRecall_ then
							iter_29_3.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1037 = nil
			end

			local var_29_8 = arg_26_1.actors_["1037"].transform
			local var_29_9 = 0

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 then
				arg_26_1.var_.moveOldPos1037 = var_29_8.localPosition
				var_29_8.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1037", 3)

				local var_29_10 = var_29_8.childCount

				for iter_29_4 = 0, var_29_10 - 1 do
					local var_29_11 = var_29_8:GetChild(iter_29_4)

					if var_29_11.name == "split_4" then
						var_29_11:SetAsLastSibling()
						var_29_11.gameObject:SetActive(true)

						arg_26_1.var_.actorSpriteSplit1037 = var_29_11.gameObject:GetComponent(typeof(Image))

						arg_26_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_29_12 = 0.5

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_12 then
				local var_29_13 = (arg_26_1.time_ - var_29_9) / var_29_12
				local var_29_14 = Vector3.New(0, -430, -55)

				var_29_8.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1037, var_29_14, var_29_13)

				if arg_26_1.var_.actorSpriteSplit1037 ~= nil then
					arg_26_1.var_.actorSpriteSplit1037:SetAlpha(var_29_13)
				end
			end

			if arg_26_1.time_ >= var_29_9 + var_29_12 and arg_26_1.time_ < var_29_9 + var_29_12 + arg_29_0 then
				var_29_8.localPosition = Vector3.New(0, -430, -55)

				if arg_26_1.var_.actorSpriteSplit1037 ~= nil then
					arg_26_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_29_15 = 0
			local var_29_16 = 0.5

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_17 = arg_26_1:FormatText(StoryNameCfg[15].name)

				arg_26_1.leftNameTxt_.text = var_29_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_18 = arg_26_1:GetWordFromCfg(425061006)
				local var_29_19 = arg_26_1:FormatText(var_29_18.content)

				arg_26_1.text_.text = var_29_19

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061006", "story_v_out_425061.awb") ~= 0 then
					local var_29_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061006", "story_v_out_425061.awb") / 1000

					if var_29_23 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_15
					end

					if var_29_18.prefab_name ~= "" and arg_26_1.actors_[var_29_18.prefab_name] ~= nil then
						local var_29_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_18.prefab_name].transform, "story_v_out_425061", "425061006", "story_v_out_425061.awb")

						arg_26_1:RecordAudio("425061006", var_29_24)
						arg_26_1:RecordAudio("425061006", var_29_24)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_425061", "425061006", "story_v_out_425061.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_425061", "425061006", "story_v_out_425061.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play425061007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 425061007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play425061008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1037"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1037 == nil then
				arg_30_1.var_.actorSpriteComps1037 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps1037 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1037 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1037 = nil
			end

			local var_33_8 = 0
			local var_33_9 = 0.25

			if var_33_8 < arg_30_1.time_ and arg_30_1.time_ <= var_33_8 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_10 = arg_30_1:FormatText(StoryNameCfg[7].name)

				arg_30_1.leftNameTxt_.text = var_33_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_11 = arg_30_1:GetWordFromCfg(425061007)
				local var_33_12 = arg_30_1:FormatText(var_33_11.content)

				arg_30_1.text_.text = var_33_12

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_13 = 10
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
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_16 = math.max(var_33_9, arg_30_1.talkMaxDuration)

			if var_33_8 <= arg_30_1.time_ and arg_30_1.time_ < var_33_8 + var_33_16 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_8) / var_33_16

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_8 + var_33_16 and arg_30_1.time_ < var_33_8 + var_33_16 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play425061008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 425061008
		arg_34_1.duration_ = 8.3

		local var_34_0 = {
			zh = 7.1,
			ja = 8.3
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
				arg_34_0:Play425061009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1037"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1037 == nil then
				arg_34_1.var_.actorSpriteComps1037 = var_37_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.actorSpriteComps1037 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1037 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_37_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1037 = nil
			end

			local var_37_8 = arg_34_1.actors_["1037"].transform
			local var_37_9 = 0

			if var_37_9 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 then
				arg_34_1.var_.moveOldPos1037 = var_37_8.localPosition
				var_37_8.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1037", 3)

				local var_37_10 = var_37_8.childCount

				for iter_37_4 = 0, var_37_10 - 1 do
					local var_37_11 = var_37_8:GetChild(iter_37_4)

					if var_37_11.name == "split_1" then
						var_37_11:SetAsLastSibling()
						var_37_11.gameObject:SetActive(true)

						arg_34_1.var_.actorSpriteSplit1037 = var_37_11.gameObject:GetComponent(typeof(Image))

						arg_34_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_37_12 = 0.2

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_12 then
				local var_37_13 = (arg_34_1.time_ - var_37_9) / var_37_12
				local var_37_14 = Vector3.New(0, -430, -55)

				var_37_8.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1037, var_37_14, var_37_13)

				if arg_34_1.var_.actorSpriteSplit1037 ~= nil then
					arg_34_1.var_.actorSpriteSplit1037:SetAlpha(var_37_13)
				end
			end

			if arg_34_1.time_ >= var_37_9 + var_37_12 and arg_34_1.time_ < var_37_9 + var_37_12 + arg_37_0 then
				var_37_8.localPosition = Vector3.New(0, -430, -55)

				if arg_34_1.var_.actorSpriteSplit1037 ~= nil then
					arg_34_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_37_15 = 0
			local var_37_16 = 0.85

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_17 = arg_34_1:FormatText(StoryNameCfg[15].name)

				arg_34_1.leftNameTxt_.text = var_37_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_18 = arg_34_1:GetWordFromCfg(425061008)
				local var_37_19 = arg_34_1:FormatText(var_37_18.content)

				arg_34_1.text_.text = var_37_19

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_20 = 34
				local var_37_21 = utf8.len(var_37_19)
				local var_37_22 = var_37_20 <= 0 and var_37_16 or var_37_16 * (var_37_21 / var_37_20)

				if var_37_22 > 0 and var_37_16 < var_37_22 then
					arg_34_1.talkMaxDuration = var_37_22

					if var_37_22 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_22 + var_37_15
					end
				end

				arg_34_1.text_.text = var_37_19
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061008", "story_v_out_425061.awb") ~= 0 then
					local var_37_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061008", "story_v_out_425061.awb") / 1000

					if var_37_23 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_23 + var_37_15
					end

					if var_37_18.prefab_name ~= "" and arg_34_1.actors_[var_37_18.prefab_name] ~= nil then
						local var_37_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_18.prefab_name].transform, "story_v_out_425061", "425061008", "story_v_out_425061.awb")

						arg_34_1:RecordAudio("425061008", var_37_24)
						arg_34_1:RecordAudio("425061008", var_37_24)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_425061", "425061008", "story_v_out_425061.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_425061", "425061008", "story_v_out_425061.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_25 = math.max(var_37_16, arg_34_1.talkMaxDuration)

			if var_37_15 <= arg_34_1.time_ and arg_34_1.time_ < var_37_15 + var_37_25 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_15) / var_37_25

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_15 + var_37_25 and arg_34_1.time_ < var_37_15 + var_37_25 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play425061009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 425061009
		arg_38_1.duration_ = 13.4

		local var_38_0 = {
			zh = 10.433,
			ja = 13.4
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
				arg_38_0:Play425061010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 1.125

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[15].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:GetWordFromCfg(425061009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 45
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061009", "story_v_out_425061.awb") ~= 0 then
					local var_41_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061009", "story_v_out_425061.awb") / 1000

					if var_41_8 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_0
					end

					if var_41_3.prefab_name ~= "" and arg_38_1.actors_[var_41_3.prefab_name] ~= nil then
						local var_41_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_3.prefab_name].transform, "story_v_out_425061", "425061009", "story_v_out_425061.awb")

						arg_38_1:RecordAudio("425061009", var_41_9)
						arg_38_1:RecordAudio("425061009", var_41_9)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_425061", "425061009", "story_v_out_425061.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_425061", "425061009", "story_v_out_425061.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_10 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_10 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_10

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_10 and arg_38_1.time_ < var_41_0 + var_41_10 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play425061010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 425061010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play425061011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1037"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1037 == nil then
				arg_42_1.var_.actorSpriteComps1037 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1037 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1037 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1037 = nil
			end

			local var_45_8 = 0
			local var_45_9 = 0.35

			if var_45_8 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_10 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_11 = arg_42_1:GetWordFromCfg(425061010)
				local var_45_12 = arg_42_1:FormatText(var_45_11.content)

				arg_42_1.text_.text = var_45_12

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 14
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
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_16 = math.max(var_45_9, arg_42_1.talkMaxDuration)

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_16 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_8) / var_45_16

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_8 + var_45_16 and arg_42_1.time_ < var_45_8 + var_45_16 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play425061011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 425061011
		arg_46_1.duration_ = 9.23

		local var_46_0 = {
			zh = 5.866,
			ja = 9.233
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
				arg_46_0:Play425061012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1037"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1037 == nil then
				arg_46_1.var_.actorSpriteComps1037 = var_49_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.actorSpriteComps1037 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1037 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_49_3 then
						if arg_46_1.isInRecall_ then
							iter_49_3.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_49_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps1037 = nil
			end

			local var_49_8 = arg_46_1.actors_["1037"].transform
			local var_49_9 = 0

			if var_49_9 < arg_46_1.time_ and arg_46_1.time_ <= var_49_9 + arg_49_0 then
				arg_46_1.var_.moveOldPos1037 = var_49_8.localPosition
				var_49_8.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1037", 3)

				local var_49_10 = var_49_8.childCount

				for iter_49_4 = 0, var_49_10 - 1 do
					local var_49_11 = var_49_8:GetChild(iter_49_4)

					if var_49_11.name == "split_4" then
						var_49_11:SetAsLastSibling()
						var_49_11.gameObject:SetActive(true)

						arg_46_1.var_.actorSpriteSplit1037 = var_49_11.gameObject:GetComponent(typeof(Image))

						arg_46_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_49_12 = 0.2

			if var_49_9 <= arg_46_1.time_ and arg_46_1.time_ < var_49_9 + var_49_12 then
				local var_49_13 = (arg_46_1.time_ - var_49_9) / var_49_12
				local var_49_14 = Vector3.New(0, -430, -55)

				var_49_8.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1037, var_49_14, var_49_13)

				if arg_46_1.var_.actorSpriteSplit1037 ~= nil then
					arg_46_1.var_.actorSpriteSplit1037:SetAlpha(var_49_13)
				end
			end

			if arg_46_1.time_ >= var_49_9 + var_49_12 and arg_46_1.time_ < var_49_9 + var_49_12 + arg_49_0 then
				var_49_8.localPosition = Vector3.New(0, -430, -55)

				if arg_46_1.var_.actorSpriteSplit1037 ~= nil then
					arg_46_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_49_15 = 0
			local var_49_16 = 0.55

			if var_49_15 < arg_46_1.time_ and arg_46_1.time_ <= var_49_15 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_17 = arg_46_1:FormatText(StoryNameCfg[15].name)

				arg_46_1.leftNameTxt_.text = var_49_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_18 = arg_46_1:GetWordFromCfg(425061011)
				local var_49_19 = arg_46_1:FormatText(var_49_18.content)

				arg_46_1.text_.text = var_49_19

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_20 = 22
				local var_49_21 = utf8.len(var_49_19)
				local var_49_22 = var_49_20 <= 0 and var_49_16 or var_49_16 * (var_49_21 / var_49_20)

				if var_49_22 > 0 and var_49_16 < var_49_22 then
					arg_46_1.talkMaxDuration = var_49_22

					if var_49_22 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_22 + var_49_15
					end
				end

				arg_46_1.text_.text = var_49_19
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061011", "story_v_out_425061.awb") ~= 0 then
					local var_49_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061011", "story_v_out_425061.awb") / 1000

					if var_49_23 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_15
					end

					if var_49_18.prefab_name ~= "" and arg_46_1.actors_[var_49_18.prefab_name] ~= nil then
						local var_49_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_18.prefab_name].transform, "story_v_out_425061", "425061011", "story_v_out_425061.awb")

						arg_46_1:RecordAudio("425061011", var_49_24)
						arg_46_1:RecordAudio("425061011", var_49_24)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_425061", "425061011", "story_v_out_425061.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_425061", "425061011", "story_v_out_425061.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_25 = math.max(var_49_16, arg_46_1.talkMaxDuration)

			if var_49_15 <= arg_46_1.time_ and arg_46_1.time_ < var_49_15 + var_49_25 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_15) / var_49_25

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_15 + var_49_25 and arg_46_1.time_ < var_49_15 + var_49_25 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play425061012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 425061012
		arg_50_1.duration_ = 15.2

		local var_50_0 = {
			zh = 10.666,
			ja = 15.2
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
				arg_50_0:Play425061013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 1.075

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[15].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_3 = arg_50_1:GetWordFromCfg(425061012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 43
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061012", "story_v_out_425061.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061012", "story_v_out_425061.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_425061", "425061012", "story_v_out_425061.awb")

						arg_50_1:RecordAudio("425061012", var_53_9)
						arg_50_1:RecordAudio("425061012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_425061", "425061012", "story_v_out_425061.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_425061", "425061012", "story_v_out_425061.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play425061013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 425061013
		arg_54_1.duration_ = 10.03

		local var_54_0 = {
			zh = 8.3,
			ja = 10.033
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
				arg_54_0:Play425061014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 0.625

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_2 = arg_54_1:FormatText(StoryNameCfg[15].name)

				arg_54_1.leftNameTxt_.text = var_57_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_3 = arg_54_1:GetWordFromCfg(425061013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 25
				local var_57_6 = utf8.len(var_57_4)
				local var_57_7 = var_57_5 <= 0 and var_57_1 or var_57_1 * (var_57_6 / var_57_5)

				if var_57_7 > 0 and var_57_1 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061013", "story_v_out_425061.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061013", "story_v_out_425061.awb") / 1000

					if var_57_8 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_0
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_425061", "425061013", "story_v_out_425061.awb")

						arg_54_1:RecordAudio("425061013", var_57_9)
						arg_54_1:RecordAudio("425061013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_425061", "425061013", "story_v_out_425061.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_425061", "425061013", "story_v_out_425061.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_10 and arg_54_1.time_ < var_57_0 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play425061014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 425061014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play425061015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1037"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1037 == nil then
				arg_58_1.var_.actorSpriteComps1037 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps1037 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								local var_61_4 = Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor2.r, var_61_3)
								local var_61_5 = Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor2.g, var_61_3)
								local var_61_6 = Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor2.b, var_61_3)

								iter_61_1.color = Color.New(var_61_4, var_61_5, var_61_6)
							else
								local var_61_7 = Mathf.Lerp(iter_61_1.color.r, 0.5, var_61_3)

								iter_61_1.color = Color.New(var_61_7, var_61_7, var_61_7)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1037 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1037 = nil
			end

			local var_61_8 = 0
			local var_61_9 = 0.925

			if var_61_8 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_10 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_11 = arg_58_1:GetWordFromCfg(425061014)
				local var_61_12 = arg_58_1:FormatText(var_61_11.content)

				arg_58_1.text_.text = var_61_12

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 37
				local var_61_14 = utf8.len(var_61_12)
				local var_61_15 = var_61_13 <= 0 and var_61_9 or var_61_9 * (var_61_14 / var_61_13)

				if var_61_15 > 0 and var_61_9 < var_61_15 then
					arg_58_1.talkMaxDuration = var_61_15

					if var_61_15 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_15 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_12
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_16 and arg_58_1.time_ < var_61_8 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play425061015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 425061015
		arg_62_1.duration_ = 11.5

		local var_62_0 = {
			zh = 6.5,
			ja = 11.5
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
				arg_62_0:Play425061016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1037"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1037 == nil then
				arg_62_1.var_.actorSpriteComps1037 = var_65_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.actorSpriteComps1037 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.actorSpriteComps1037 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_65_3 then
						if arg_62_1.isInRecall_ then
							iter_65_3.color = arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_65_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_62_1.var_.actorSpriteComps1037 = nil
			end

			local var_65_8 = 0
			local var_65_9 = 0.75

			if var_65_8 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_10 = arg_62_1:FormatText(StoryNameCfg[15].name)

				arg_62_1.leftNameTxt_.text = var_65_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_11 = arg_62_1:GetWordFromCfg(425061015)
				local var_65_12 = arg_62_1:FormatText(var_65_11.content)

				arg_62_1.text_.text = var_65_12

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061015", "story_v_out_425061.awb") ~= 0 then
					local var_65_16 = manager.audio:GetVoiceLength("story_v_out_425061", "425061015", "story_v_out_425061.awb") / 1000

					if var_65_16 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_16 + var_65_8
					end

					if var_65_11.prefab_name ~= "" and arg_62_1.actors_[var_65_11.prefab_name] ~= nil then
						local var_65_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_11.prefab_name].transform, "story_v_out_425061", "425061015", "story_v_out_425061.awb")

						arg_62_1:RecordAudio("425061015", var_65_17)
						arg_62_1:RecordAudio("425061015", var_65_17)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_425061", "425061015", "story_v_out_425061.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_425061", "425061015", "story_v_out_425061.awb")
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
	Play425061016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 425061016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play425061017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1037"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1037 == nil then
				arg_66_1.var_.actorSpriteComps1037 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps1037 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps1037 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps1037 = nil
			end

			local var_69_8 = 0
			local var_69_9 = 0.825

			if var_69_8 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_10 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_11 = arg_66_1:GetWordFromCfg(425061016)
				local var_69_12 = arg_66_1:FormatText(var_69_11.content)

				arg_66_1.text_.text = var_69_12

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_13 = 33
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
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_16 and arg_66_1.time_ < var_69_8 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play425061017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 425061017
		arg_70_1.duration_ = 4.9

		local var_70_0 = {
			zh = 3.1,
			ja = 4.9
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
				arg_70_0:Play425061018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1037"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1037 == nil then
				arg_70_1.var_.actorSpriteComps1037 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps1037 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps1037 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_73_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps1037 = nil
			end

			local var_73_8 = arg_70_1.actors_["1037"].transform
			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.var_.moveOldPos1037 = var_73_8.localPosition
				var_73_8.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1037", 3)

				local var_73_10 = var_73_8.childCount

				for iter_73_4 = 0, var_73_10 - 1 do
					local var_73_11 = var_73_8:GetChild(iter_73_4)

					if var_73_11.name == "split_3" then
						var_73_11:SetAsLastSibling()
						var_73_11.gameObject:SetActive(true)

						arg_70_1.var_.actorSpriteSplit1037 = var_73_11.gameObject:GetComponent(typeof(Image))

						arg_70_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_73_12 = 0.5

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_12 then
				local var_73_13 = (arg_70_1.time_ - var_73_9) / var_73_12
				local var_73_14 = Vector3.New(0, -430, -55)

				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1037, var_73_14, var_73_13)

				if arg_70_1.var_.actorSpriteSplit1037 ~= nil then
					arg_70_1.var_.actorSpriteSplit1037:SetAlpha(var_73_13)
				end
			end

			if arg_70_1.time_ >= var_73_9 + var_73_12 and arg_70_1.time_ < var_73_9 + var_73_12 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(0, -430, -55)

				if arg_70_1.var_.actorSpriteSplit1037 ~= nil then
					arg_70_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_73_15 = 0
			local var_73_16 = 0.25

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_17 = arg_70_1:FormatText(StoryNameCfg[15].name)

				arg_70_1.leftNameTxt_.text = var_73_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_18 = arg_70_1:GetWordFromCfg(425061017)
				local var_73_19 = arg_70_1:FormatText(var_73_18.content)

				arg_70_1.text_.text = var_73_19

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_20 = 10
				local var_73_21 = utf8.len(var_73_19)
				local var_73_22 = var_73_20 <= 0 and var_73_16 or var_73_16 * (var_73_21 / var_73_20)

				if var_73_22 > 0 and var_73_16 < var_73_22 then
					arg_70_1.talkMaxDuration = var_73_22

					if var_73_22 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_22 + var_73_15
					end
				end

				arg_70_1.text_.text = var_73_19
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061017", "story_v_out_425061.awb") ~= 0 then
					local var_73_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061017", "story_v_out_425061.awb") / 1000

					if var_73_23 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_15
					end

					if var_73_18.prefab_name ~= "" and arg_70_1.actors_[var_73_18.prefab_name] ~= nil then
						local var_73_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_18.prefab_name].transform, "story_v_out_425061", "425061017", "story_v_out_425061.awb")

						arg_70_1:RecordAudio("425061017", var_73_24)
						arg_70_1:RecordAudio("425061017", var_73_24)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_425061", "425061017", "story_v_out_425061.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_425061", "425061017", "story_v_out_425061.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_25 = math.max(var_73_16, arg_70_1.talkMaxDuration)

			if var_73_15 <= arg_70_1.time_ and arg_70_1.time_ < var_73_15 + var_73_25 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_15) / var_73_25

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_15 + var_73_25 and arg_70_1.time_ < var_73_15 + var_73_25 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play425061018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 425061018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play425061019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1037"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1037 == nil then
				arg_74_1.var_.actorSpriteComps1037 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps1037 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 0.5, var_77_3)

								iter_77_1.color = Color.New(var_77_7, var_77_7, var_77_7)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1037 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1037 = nil
			end

			local var_77_8 = 0
			local var_77_9 = 0.1

			if var_77_8 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_10 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_11 = arg_74_1:GetWordFromCfg(425061018)
				local var_77_12 = arg_74_1:FormatText(var_77_11.content)

				arg_74_1.text_.text = var_77_12

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 4
				local var_77_14 = utf8.len(var_77_12)
				local var_77_15 = var_77_13 <= 0 and var_77_9 or var_77_9 * (var_77_14 / var_77_13)

				if var_77_15 > 0 and var_77_9 < var_77_15 then
					arg_74_1.talkMaxDuration = var_77_15

					if var_77_15 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_15 + var_77_8
					end
				end

				arg_74_1.text_.text = var_77_12
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_9, arg_74_1.talkMaxDuration)

			if var_77_8 <= arg_74_1.time_ and arg_74_1.time_ < var_77_8 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_8) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_8 + var_77_16 and arg_74_1.time_ < var_77_8 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play425061019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 425061019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play425061020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1037"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1037 = var_81_0.localPosition
				var_81_0.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1037", 7)

				local var_81_2 = var_81_0.childCount

				for iter_81_0 = 0, var_81_2 - 1 do
					local var_81_3 = var_81_0:GetChild(iter_81_0)

					if var_81_3.name == "" or not string.find(var_81_3.name, "split") then
						var_81_3.gameObject:SetActive(true)
					else
						var_81_3.gameObject:SetActive(false)
					end
				end
			end

			local var_81_4 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_4 then
				local var_81_5 = (arg_78_1.time_ - var_81_1) / var_81_4
				local var_81_6 = Vector3.New(1500, -2000, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1037, var_81_6, var_81_5)
			end

			if arg_78_1.time_ >= var_81_1 + var_81_4 and arg_78_1.time_ < var_81_1 + var_81_4 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_81_7 = 0.533333333333333
			local var_81_8 = 1

			if var_81_7 < arg_78_1.time_ and arg_78_1.time_ <= var_81_7 + arg_81_0 then
				local var_81_9 = "play"
				local var_81_10 = "effect"

				arg_78_1:AudioAction(var_81_9, var_81_10, "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_81_11 = 0
			local var_81_12 = 1.65

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_13 = arg_78_1:GetWordFromCfg(425061019)
				local var_81_14 = arg_78_1:FormatText(var_81_13.content)

				arg_78_1.text_.text = var_81_14

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_15 = 66
				local var_81_16 = utf8.len(var_81_14)
				local var_81_17 = var_81_15 <= 0 and var_81_12 or var_81_12 * (var_81_16 / var_81_15)

				if var_81_17 > 0 and var_81_12 < var_81_17 then
					arg_78_1.talkMaxDuration = var_81_17

					if var_81_17 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_17 + var_81_11
					end
				end

				arg_78_1.text_.text = var_81_14
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_18 = math.max(var_81_12, arg_78_1.talkMaxDuration)

			if var_81_11 <= arg_78_1.time_ and arg_78_1.time_ < var_81_11 + var_81_18 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_11) / var_81_18

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_11 + var_81_18 and arg_78_1.time_ < var_81_11 + var_81_18 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 425061020
		arg_82_1.duration_ = 3.73

		local var_82_0 = {
			zh = 1.7,
			ja = 3.733
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
				arg_82_0:Play425061021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1037"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1037 == nil then
				arg_82_1.var_.actorSpriteComps1037 = var_85_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_2 = 0.2

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.actorSpriteComps1037 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.actorSpriteComps1037 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_85_3 then
						if arg_82_1.isInRecall_ then
							iter_85_3.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_85_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps1037 = nil
			end

			local var_85_8 = arg_82_1.actors_["1037"].transform
			local var_85_9 = 0

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 then
				arg_82_1.var_.moveOldPos1037 = var_85_8.localPosition
				var_85_8.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("1037", 3)

				local var_85_10 = var_85_8.childCount

				for iter_85_4 = 0, var_85_10 - 1 do
					local var_85_11 = var_85_8:GetChild(iter_85_4)

					if var_85_11.name == "" or not string.find(var_85_11.name, "split") then
						var_85_11.gameObject:SetActive(true)
					else
						var_85_11.gameObject:SetActive(false)
					end
				end
			end

			local var_85_12 = 0.001

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_12 then
				local var_85_13 = (arg_82_1.time_ - var_85_9) / var_85_12
				local var_85_14 = Vector3.New(0, -430, -55)

				var_85_8.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1037, var_85_14, var_85_13)
			end

			if arg_82_1.time_ >= var_85_9 + var_85_12 and arg_82_1.time_ < var_85_9 + var_85_12 + arg_85_0 then
				var_85_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_85_15 = 0
			local var_85_16 = 0.125

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_17 = arg_82_1:FormatText(StoryNameCfg[15].name)

				arg_82_1.leftNameTxt_.text = var_85_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_18 = arg_82_1:GetWordFromCfg(425061020)
				local var_85_19 = arg_82_1:FormatText(var_85_18.content)

				arg_82_1.text_.text = var_85_19

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_20 = 5
				local var_85_21 = utf8.len(var_85_19)
				local var_85_22 = var_85_20 <= 0 and var_85_16 or var_85_16 * (var_85_21 / var_85_20)

				if var_85_22 > 0 and var_85_16 < var_85_22 then
					arg_82_1.talkMaxDuration = var_85_22

					if var_85_22 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_15
					end
				end

				arg_82_1.text_.text = var_85_19
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061020", "story_v_out_425061.awb") ~= 0 then
					local var_85_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061020", "story_v_out_425061.awb") / 1000

					if var_85_23 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_15
					end

					if var_85_18.prefab_name ~= "" and arg_82_1.actors_[var_85_18.prefab_name] ~= nil then
						local var_85_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_18.prefab_name].transform, "story_v_out_425061", "425061020", "story_v_out_425061.awb")

						arg_82_1:RecordAudio("425061020", var_85_24)
						arg_82_1:RecordAudio("425061020", var_85_24)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_425061", "425061020", "story_v_out_425061.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_425061", "425061020", "story_v_out_425061.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_25 = math.max(var_85_16, arg_82_1.talkMaxDuration)

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_25 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_15) / var_85_25

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_15 + var_85_25 and arg_82_1.time_ < var_85_15 + var_85_25 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play425061021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 425061021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play425061022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1037"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1037 == nil then
				arg_86_1.var_.actorSpriteComps1037 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps1037 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1037 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps1037 = nil
			end

			local var_89_8 = 0
			local var_89_9 = 0.275

			if var_89_8 < arg_86_1.time_ and arg_86_1.time_ <= var_89_8 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_10 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_11 = arg_86_1:GetWordFromCfg(425061021)
				local var_89_12 = arg_86_1:FormatText(var_89_11.content)

				arg_86_1.text_.text = var_89_12

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_13 = 11
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
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_9, arg_86_1.talkMaxDuration)

			if var_89_8 <= arg_86_1.time_ and arg_86_1.time_ < var_89_8 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_8) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_8 + var_89_16 and arg_86_1.time_ < var_89_8 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play425061022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 425061022
		arg_90_1.duration_ = 8.17

		local var_90_0 = {
			zh = 6.2,
			ja = 8.166
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
				arg_90_0:Play425061023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1037"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1037 == nil then
				arg_90_1.var_.actorSpriteComps1037 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps1037 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1037 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1037 = nil
			end

			local var_93_8 = arg_90_1.actors_["1037"].transform
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.var_.moveOldPos1037 = var_93_8.localPosition
				var_93_8.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("1037", 3)

				local var_93_10 = var_93_8.childCount

				for iter_93_4 = 0, var_93_10 - 1 do
					local var_93_11 = var_93_8:GetChild(iter_93_4)

					if var_93_11.name == "split_4" then
						var_93_11:SetAsLastSibling()
						var_93_11.gameObject:SetActive(true)

						arg_90_1.var_.actorSpriteSplit1037 = var_93_11.gameObject:GetComponent(typeof(Image))

						arg_90_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_93_12 = 0.2

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_12 then
				local var_93_13 = (arg_90_1.time_ - var_93_9) / var_93_12
				local var_93_14 = Vector3.New(0, -430, -55)

				var_93_8.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1037, var_93_14, var_93_13)

				if arg_90_1.var_.actorSpriteSplit1037 ~= nil then
					arg_90_1.var_.actorSpriteSplit1037:SetAlpha(var_93_13)
				end
			end

			if arg_90_1.time_ >= var_93_9 + var_93_12 and arg_90_1.time_ < var_93_9 + var_93_12 + arg_93_0 then
				var_93_8.localPosition = Vector3.New(0, -430, -55)

				if arg_90_1.var_.actorSpriteSplit1037 ~= nil then
					arg_90_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_93_15 = 0
			local var_93_16 = 0.6

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_17 = arg_90_1:FormatText(StoryNameCfg[15].name)

				arg_90_1.leftNameTxt_.text = var_93_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(425061022)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 24
				local var_93_21 = utf8.len(var_93_19)
				local var_93_22 = var_93_20 <= 0 and var_93_16 or var_93_16 * (var_93_21 / var_93_20)

				if var_93_22 > 0 and var_93_16 < var_93_22 then
					arg_90_1.talkMaxDuration = var_93_22

					if var_93_22 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061022", "story_v_out_425061.awb") ~= 0 then
					local var_93_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061022", "story_v_out_425061.awb") / 1000

					if var_93_23 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_23 + var_93_15
					end

					if var_93_18.prefab_name ~= "" and arg_90_1.actors_[var_93_18.prefab_name] ~= nil then
						local var_93_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_18.prefab_name].transform, "story_v_out_425061", "425061022", "story_v_out_425061.awb")

						arg_90_1:RecordAudio("425061022", var_93_24)
						arg_90_1:RecordAudio("425061022", var_93_24)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_425061", "425061022", "story_v_out_425061.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_425061", "425061022", "story_v_out_425061.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_25 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_25 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_25

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_25 and arg_90_1.time_ < var_93_15 + var_93_25 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play425061023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 425061023
		arg_94_1.duration_ = 8.97

		local var_94_0 = {
			zh = 4.833,
			ja = 8.966
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
				arg_94_0:Play425061024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.575

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[15].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(425061023)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061023", "story_v_out_425061.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061023", "story_v_out_425061.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_425061", "425061023", "story_v_out_425061.awb")

						arg_94_1:RecordAudio("425061023", var_97_9)
						arg_94_1:RecordAudio("425061023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_425061", "425061023", "story_v_out_425061.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_425061", "425061023", "story_v_out_425061.awb")
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
	Play425061024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 425061024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play425061025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1037"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1037 == nil then
				arg_98_1.var_.actorSpriteComps1037 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps1037 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								local var_101_4 = Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor2.r, var_101_3)
								local var_101_5 = Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor2.g, var_101_3)
								local var_101_6 = Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor2.b, var_101_3)

								iter_101_1.color = Color.New(var_101_4, var_101_5, var_101_6)
							else
								local var_101_7 = Mathf.Lerp(iter_101_1.color.r, 0.5, var_101_3)

								iter_101_1.color = Color.New(var_101_7, var_101_7, var_101_7)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps1037 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_101_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps1037 = nil
			end

			local var_101_8 = 0
			local var_101_9 = 1.175

			if var_101_8 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_10 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_11 = arg_98_1:GetWordFromCfg(425061024)
				local var_101_12 = arg_98_1:FormatText(var_101_11.content)

				arg_98_1.text_.text = var_101_12

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 47
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
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_16 and arg_98_1.time_ < var_101_8 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play425061025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 425061025
		arg_102_1.duration_ = 10.13

		local var_102_0 = {
			zh = 8.466,
			ja = 10.133
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
				arg_102_0:Play425061026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1037"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1037 == nil then
				arg_102_1.var_.actorSpriteComps1037 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps1037 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps1037 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps1037 = nil
			end

			local var_105_8 = 0
			local var_105_9 = 0.9

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_10 = arg_102_1:FormatText(StoryNameCfg[15].name)

				arg_102_1.leftNameTxt_.text = var_105_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_11 = arg_102_1:GetWordFromCfg(425061025)
				local var_105_12 = arg_102_1:FormatText(var_105_11.content)

				arg_102_1.text_.text = var_105_12

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_13 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061025", "story_v_out_425061.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_425061", "425061025", "story_v_out_425061.awb") / 1000

					if var_105_16 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_8
					end

					if var_105_11.prefab_name ~= "" and arg_102_1.actors_[var_105_11.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_11.prefab_name].transform, "story_v_out_425061", "425061025", "story_v_out_425061.awb")

						arg_102_1:RecordAudio("425061025", var_105_17)
						arg_102_1:RecordAudio("425061025", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_425061", "425061025", "story_v_out_425061.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_425061", "425061025", "story_v_out_425061.awb")
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
	Play425061026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 425061026
		arg_106_1.duration_ = 10.9

		local var_106_0 = {
			zh = 9,
			ja = 10.9
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
				arg_106_0:Play425061027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 1.05

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[15].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:GetWordFromCfg(425061026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 42
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061026", "story_v_out_425061.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061026", "story_v_out_425061.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_425061", "425061026", "story_v_out_425061.awb")

						arg_106_1:RecordAudio("425061026", var_109_9)
						arg_106_1:RecordAudio("425061026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_425061", "425061026", "story_v_out_425061.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_425061", "425061026", "story_v_out_425061.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play425061027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 425061027
		arg_110_1.duration_ = 5.7

		local var_110_0 = {
			zh = 3.8,
			ja = 5.7
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
				arg_110_0:Play425061028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1037"].transform
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.var_.moveOldPos1037 = var_113_0.localPosition
				var_113_0.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("1037", 3)

				local var_113_2 = var_113_0.childCount

				for iter_113_0 = 0, var_113_2 - 1 do
					local var_113_3 = var_113_0:GetChild(iter_113_0)

					if var_113_3.name == "split_4" or not string.find(var_113_3.name, "split") then
						var_113_3.gameObject:SetActive(true)
					else
						var_113_3.gameObject:SetActive(false)
					end
				end
			end

			local var_113_4 = 0.001

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_4 then
				local var_113_5 = (arg_110_1.time_ - var_113_1) / var_113_4
				local var_113_6 = Vector3.New(0, -430, -55)

				var_113_0.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1037, var_113_6, var_113_5)
			end

			if arg_110_1.time_ >= var_113_1 + var_113_4 and arg_110_1.time_ < var_113_1 + var_113_4 + arg_113_0 then
				var_113_0.localPosition = Vector3.New(0, -430, -55)
			end

			local var_113_7 = 0
			local var_113_8 = 0.3

			if var_113_7 < arg_110_1.time_ and arg_110_1.time_ <= var_113_7 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_9 = arg_110_1:FormatText(StoryNameCfg[15].name)

				arg_110_1.leftNameTxt_.text = var_113_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_10 = arg_110_1:GetWordFromCfg(425061027)
				local var_113_11 = arg_110_1:FormatText(var_113_10.content)

				arg_110_1.text_.text = var_113_11

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_12 = 12
				local var_113_13 = utf8.len(var_113_11)
				local var_113_14 = var_113_12 <= 0 and var_113_8 or var_113_8 * (var_113_13 / var_113_12)

				if var_113_14 > 0 and var_113_8 < var_113_14 then
					arg_110_1.talkMaxDuration = var_113_14

					if var_113_14 + var_113_7 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_7
					end
				end

				arg_110_1.text_.text = var_113_11
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061027", "story_v_out_425061.awb") ~= 0 then
					local var_113_15 = manager.audio:GetVoiceLength("story_v_out_425061", "425061027", "story_v_out_425061.awb") / 1000

					if var_113_15 + var_113_7 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_7
					end

					if var_113_10.prefab_name ~= "" and arg_110_1.actors_[var_113_10.prefab_name] ~= nil then
						local var_113_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_10.prefab_name].transform, "story_v_out_425061", "425061027", "story_v_out_425061.awb")

						arg_110_1:RecordAudio("425061027", var_113_16)
						arg_110_1:RecordAudio("425061027", var_113_16)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_425061", "425061027", "story_v_out_425061.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_425061", "425061027", "story_v_out_425061.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_17 = math.max(var_113_8, arg_110_1.talkMaxDuration)

			if var_113_7 <= arg_110_1.time_ and arg_110_1.time_ < var_113_7 + var_113_17 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_7) / var_113_17

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_7 + var_113_17 and arg_110_1.time_ < var_113_7 + var_113_17 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play425061028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 425061028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play425061029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1037"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps1037 == nil then
				arg_114_1.var_.actorSpriteComps1037 = var_117_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.actorSpriteComps1037 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								local var_117_4 = Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor2.r, var_117_3)
								local var_117_5 = Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor2.g, var_117_3)
								local var_117_6 = Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor2.b, var_117_3)

								iter_117_1.color = Color.New(var_117_4, var_117_5, var_117_6)
							else
								local var_117_7 = Mathf.Lerp(iter_117_1.color.r, 0.5, var_117_3)

								iter_117_1.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps1037 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_117_3 then
						if arg_114_1.isInRecall_ then
							iter_117_3.color = arg_114_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_117_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps1037 = nil
			end

			local var_117_8 = 0
			local var_117_9 = 0.2

			if var_117_8 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_10 = arg_114_1:FormatText(StoryNameCfg[7].name)

				arg_114_1.leftNameTxt_.text = var_117_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_11 = arg_114_1:GetWordFromCfg(425061028)
				local var_117_12 = arg_114_1:FormatText(var_117_11.content)

				arg_114_1.text_.text = var_117_12

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_13 = 8
				local var_117_14 = utf8.len(var_117_12)
				local var_117_15 = var_117_13 <= 0 and var_117_9 or var_117_9 * (var_117_14 / var_117_13)

				if var_117_15 > 0 and var_117_9 < var_117_15 then
					arg_114_1.talkMaxDuration = var_117_15

					if var_117_15 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_15 + var_117_8
					end
				end

				arg_114_1.text_.text = var_117_12
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_16 = math.max(var_117_9, arg_114_1.talkMaxDuration)

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_16 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_8) / var_117_16

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_8 + var_117_16 and arg_114_1.time_ < var_117_8 + var_117_16 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play425061029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 425061029
		arg_118_1.duration_ = 9.73

		local var_118_0 = {
			zh = 9.733,
			ja = 8.5
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
				arg_118_0:Play425061030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1037"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps1037 == nil then
				arg_118_1.var_.actorSpriteComps1037 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps1037 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps1037 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_121_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps1037 = nil
			end

			local var_121_8 = 0
			local var_121_9 = 1.025

			if var_121_8 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_10 = arg_118_1:FormatText(StoryNameCfg[15].name)

				arg_118_1.leftNameTxt_.text = var_121_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_11 = arg_118_1:GetWordFromCfg(425061029)
				local var_121_12 = arg_118_1:FormatText(var_121_11.content)

				arg_118_1.text_.text = var_121_12

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 64
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061029", "story_v_out_425061.awb") ~= 0 then
					local var_121_16 = manager.audio:GetVoiceLength("story_v_out_425061", "425061029", "story_v_out_425061.awb") / 1000

					if var_121_16 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_16 + var_121_8
					end

					if var_121_11.prefab_name ~= "" and arg_118_1.actors_[var_121_11.prefab_name] ~= nil then
						local var_121_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_11.prefab_name].transform, "story_v_out_425061", "425061029", "story_v_out_425061.awb")

						arg_118_1:RecordAudio("425061029", var_121_17)
						arg_118_1:RecordAudio("425061029", var_121_17)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_425061", "425061029", "story_v_out_425061.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_425061", "425061029", "story_v_out_425061.awb")
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
	Play425061030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 425061030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play425061031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1037"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps1037 == nil then
				arg_122_1.var_.actorSpriteComps1037 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps1037 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps1037 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_125_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps1037 = nil
			end

			local var_125_8 = 0
			local var_125_9 = 1.05

			if var_125_8 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_10 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_11 = arg_122_1:GetWordFromCfg(425061030)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 42
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
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_16 and arg_122_1.time_ < var_125_8 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play425061031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 425061031
		arg_126_1.duration_ = 2.77

		local var_126_0 = {
			zh = 1.733,
			ja = 2.766
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
				arg_126_0:Play425061032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1037"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps1037 == nil then
				arg_126_1.var_.actorSpriteComps1037 = var_129_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.actorSpriteComps1037 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps1037 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_129_3 then
						if arg_126_1.isInRecall_ then
							iter_129_3.color = arg_126_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_129_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps1037 = nil
			end

			local var_129_8 = arg_126_1.actors_["1037"].transform
			local var_129_9 = 0

			if var_129_9 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 then
				arg_126_1.var_.moveOldPos1037 = var_129_8.localPosition
				var_129_8.localScale = Vector3.New(1, 1, 1)

				arg_126_1:CheckSpriteTmpPos("1037", 3)

				local var_129_10 = var_129_8.childCount

				for iter_129_4 = 0, var_129_10 - 1 do
					local var_129_11 = var_129_8:GetChild(iter_129_4)

					if var_129_11.name == "split_1" then
						var_129_11:SetAsLastSibling()
						var_129_11.gameObject:SetActive(true)

						arg_126_1.var_.actorSpriteSplit1037 = var_129_11.gameObject:GetComponent(typeof(Image))

						arg_126_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_129_12 = 0.2

			if var_129_9 <= arg_126_1.time_ and arg_126_1.time_ < var_129_9 + var_129_12 then
				local var_129_13 = (arg_126_1.time_ - var_129_9) / var_129_12
				local var_129_14 = Vector3.New(0, -430, -55)

				var_129_8.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1037, var_129_14, var_129_13)

				if arg_126_1.var_.actorSpriteSplit1037 ~= nil then
					arg_126_1.var_.actorSpriteSplit1037:SetAlpha(var_129_13)
				end
			end

			if arg_126_1.time_ >= var_129_9 + var_129_12 and arg_126_1.time_ < var_129_9 + var_129_12 + arg_129_0 then
				var_129_8.localPosition = Vector3.New(0, -430, -55)

				if arg_126_1.var_.actorSpriteSplit1037 ~= nil then
					arg_126_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_129_15 = 0
			local var_129_16 = 0.125

			if var_129_15 < arg_126_1.time_ and arg_126_1.time_ <= var_129_15 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_17 = arg_126_1:FormatText(StoryNameCfg[15].name)

				arg_126_1.leftNameTxt_.text = var_129_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_18 = arg_126_1:GetWordFromCfg(425061031)
				local var_129_19 = arg_126_1:FormatText(var_129_18.content)

				arg_126_1.text_.text = var_129_19

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_20 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061031", "story_v_out_425061.awb") ~= 0 then
					local var_129_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061031", "story_v_out_425061.awb") / 1000

					if var_129_23 + var_129_15 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_23 + var_129_15
					end

					if var_129_18.prefab_name ~= "" and arg_126_1.actors_[var_129_18.prefab_name] ~= nil then
						local var_129_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_18.prefab_name].transform, "story_v_out_425061", "425061031", "story_v_out_425061.awb")

						arg_126_1:RecordAudio("425061031", var_129_24)
						arg_126_1:RecordAudio("425061031", var_129_24)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_425061", "425061031", "story_v_out_425061.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_425061", "425061031", "story_v_out_425061.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play425061032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 425061032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play425061033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1037"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps1037 == nil then
				arg_130_1.var_.actorSpriteComps1037 = var_133_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.actorSpriteComps1037 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.actorSpriteComps1037 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_133_3 then
						if arg_130_1.isInRecall_ then
							iter_133_3.color = arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_133_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_130_1.var_.actorSpriteComps1037 = nil
			end

			local var_133_8 = 0
			local var_133_9 = 1.2

			if var_133_8 < arg_130_1.time_ and arg_130_1.time_ <= var_133_8 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_10 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_11 = arg_130_1:GetWordFromCfg(425061032)
				local var_133_12 = arg_130_1:FormatText(var_133_11.content)

				arg_130_1.text_.text = var_133_12

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_13 = 48
				local var_133_14 = utf8.len(var_133_12)
				local var_133_15 = var_133_13 <= 0 and var_133_9 or var_133_9 * (var_133_14 / var_133_13)

				if var_133_15 > 0 and var_133_9 < var_133_15 then
					arg_130_1.talkMaxDuration = var_133_15

					if var_133_15 + var_133_8 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_15 + var_133_8
					end
				end

				arg_130_1.text_.text = var_133_12
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_16 = math.max(var_133_9, arg_130_1.talkMaxDuration)

			if var_133_8 <= arg_130_1.time_ and arg_130_1.time_ < var_133_8 + var_133_16 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_8) / var_133_16

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_8 + var_133_16 and arg_130_1.time_ < var_133_8 + var_133_16 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play425061033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 425061033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play425061034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(425061033)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 40
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
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_8 and arg_134_1.time_ < var_137_0 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play425061034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 425061034
		arg_138_1.duration_ = 2.07

		local var_138_0 = {
			zh = 2.066,
			ja = 2
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
				arg_138_0:Play425061035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1037"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps1037 == nil then
				arg_138_1.var_.actorSpriteComps1037 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps1037 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps1037 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_141_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps1037 = nil
			end

			local var_141_8 = arg_138_1.actors_["1037"].transform
			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1.var_.moveOldPos1037 = var_141_8.localPosition
				var_141_8.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("1037", 3)

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
				local var_141_14 = Vector3.New(0, -430, -55)

				var_141_8.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1037, var_141_14, var_141_13)
			end

			if arg_138_1.time_ >= var_141_9 + var_141_12 and arg_138_1.time_ < var_141_9 + var_141_12 + arg_141_0 then
				var_141_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_141_15 = 0
			local var_141_16 = 0.05

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_17 = arg_138_1:FormatText(StoryNameCfg[15].name)

				arg_138_1.leftNameTxt_.text = var_141_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_18 = arg_138_1:GetWordFromCfg(425061034)
				local var_141_19 = arg_138_1:FormatText(var_141_18.content)

				arg_138_1.text_.text = var_141_19

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_20 = 2
				local var_141_21 = utf8.len(var_141_19)
				local var_141_22 = var_141_20 <= 0 and var_141_16 or var_141_16 * (var_141_21 / var_141_20)

				if var_141_22 > 0 and var_141_16 < var_141_22 then
					arg_138_1.talkMaxDuration = var_141_22

					if var_141_22 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_22 + var_141_15
					end
				end

				arg_138_1.text_.text = var_141_19
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061034", "story_v_out_425061.awb") ~= 0 then
					local var_141_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061034", "story_v_out_425061.awb") / 1000

					if var_141_23 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_23 + var_141_15
					end

					if var_141_18.prefab_name ~= "" and arg_138_1.actors_[var_141_18.prefab_name] ~= nil then
						local var_141_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_18.prefab_name].transform, "story_v_out_425061", "425061034", "story_v_out_425061.awb")

						arg_138_1:RecordAudio("425061034", var_141_24)
						arg_138_1:RecordAudio("425061034", var_141_24)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_425061", "425061034", "story_v_out_425061.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_425061", "425061034", "story_v_out_425061.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_25 = math.max(var_141_16, arg_138_1.talkMaxDuration)

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_25 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_15) / var_141_25

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_15 + var_141_25 and arg_138_1.time_ < var_141_15 + var_141_25 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 425061035
		arg_142_1.duration_ = 8.6

		local var_142_0 = {
			zh = 8.6,
			ja = 7.833
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
				arg_142_0:Play425061036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1037"].transform
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.var_.moveOldPos1037 = var_145_0.localPosition
				var_145_0.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("1037", 3)

				local var_145_2 = var_145_0.childCount

				for iter_145_0 = 0, var_145_2 - 1 do
					local var_145_3 = var_145_0:GetChild(iter_145_0)

					if var_145_3.name == "" or not string.find(var_145_3.name, "split") then
						var_145_3.gameObject:SetActive(true)
					else
						var_145_3.gameObject:SetActive(false)
					end
				end
			end

			local var_145_4 = 0.001

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_4 then
				local var_145_5 = (arg_142_1.time_ - var_145_1) / var_145_4
				local var_145_6 = Vector3.New(0, -430, -55)

				var_145_0.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1037, var_145_6, var_145_5)
			end

			if arg_142_1.time_ >= var_145_1 + var_145_4 and arg_142_1.time_ < var_145_1 + var_145_4 + arg_145_0 then
				var_145_0.localPosition = Vector3.New(0, -430, -55)
			end

			local var_145_7 = 0
			local var_145_8 = 0.95

			if var_145_7 < arg_142_1.time_ and arg_142_1.time_ <= var_145_7 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_9 = arg_142_1:FormatText(StoryNameCfg[15].name)

				arg_142_1.leftNameTxt_.text = var_145_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_10 = arg_142_1:GetWordFromCfg(425061035)
				local var_145_11 = arg_142_1:FormatText(var_145_10.content)

				arg_142_1.text_.text = var_145_11

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_12 = 38
				local var_145_13 = utf8.len(var_145_11)
				local var_145_14 = var_145_12 <= 0 and var_145_8 or var_145_8 * (var_145_13 / var_145_12)

				if var_145_14 > 0 and var_145_8 < var_145_14 then
					arg_142_1.talkMaxDuration = var_145_14

					if var_145_14 + var_145_7 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_14 + var_145_7
					end
				end

				arg_142_1.text_.text = var_145_11
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061035", "story_v_out_425061.awb") ~= 0 then
					local var_145_15 = manager.audio:GetVoiceLength("story_v_out_425061", "425061035", "story_v_out_425061.awb") / 1000

					if var_145_15 + var_145_7 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_15 + var_145_7
					end

					if var_145_10.prefab_name ~= "" and arg_142_1.actors_[var_145_10.prefab_name] ~= nil then
						local var_145_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_10.prefab_name].transform, "story_v_out_425061", "425061035", "story_v_out_425061.awb")

						arg_142_1:RecordAudio("425061035", var_145_16)
						arg_142_1:RecordAudio("425061035", var_145_16)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_425061", "425061035", "story_v_out_425061.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_425061", "425061035", "story_v_out_425061.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_17 = math.max(var_145_8, arg_142_1.talkMaxDuration)

			if var_145_7 <= arg_142_1.time_ and arg_142_1.time_ < var_145_7 + var_145_17 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_7) / var_145_17

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_7 + var_145_17 and arg_142_1.time_ < var_145_7 + var_145_17 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 425061036
		arg_146_1.duration_ = 1

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"

			SetActive(arg_146_1.choicesGo_, true)

			for iter_147_0, iter_147_1 in ipairs(arg_146_1.choices_) do
				local var_147_0 = iter_147_0 <= 1

				SetActive(iter_147_1.go, var_147_0)
			end

			arg_146_1.choices_[1].txt.text = arg_146_1:FormatText(StoryChoiceCfg[1535].name)
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play425061037(arg_146_1)
			end

			arg_146_1:RecordChoiceLog(425061036, 1535)
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1037"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps1037 == nil then
				arg_146_1.var_.actorSpriteComps1037 = var_149_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.actorSpriteComps1037 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps1037 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_149_3 then
						if arg_146_1.isInRecall_ then
							iter_149_3.color = arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_149_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps1037 = nil
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play425061037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 425061037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play425061038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.425

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[7].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:GetWordFromCfg(425061037)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 17
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
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_8 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_8 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_8

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_8 and arg_150_1.time_ < var_153_0 + var_153_8 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play425061038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 425061038
		arg_154_1.duration_ = 1.23

		local var_154_0 = {
			zh = 1.233,
			ja = 1
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
				arg_154_0:Play425061039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1037"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps1037 == nil then
				arg_154_1.var_.actorSpriteComps1037 = var_157_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.actorSpriteComps1037 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps1037 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_157_3 then
						if arg_154_1.isInRecall_ then
							iter_157_3.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_157_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps1037 = nil
			end

			local var_157_8 = arg_154_1.actors_["1037"].transform
			local var_157_9 = 0

			if var_157_9 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 then
				arg_154_1.var_.moveOldPos1037 = var_157_8.localPosition
				var_157_8.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1037", 3)

				local var_157_10 = var_157_8.childCount

				for iter_157_4 = 0, var_157_10 - 1 do
					local var_157_11 = var_157_8:GetChild(iter_157_4)

					if var_157_11.name == "" or not string.find(var_157_11.name, "split") then
						var_157_11.gameObject:SetActive(true)
					else
						var_157_11.gameObject:SetActive(false)
					end
				end
			end

			local var_157_12 = 0.001

			if var_157_9 <= arg_154_1.time_ and arg_154_1.time_ < var_157_9 + var_157_12 then
				local var_157_13 = (arg_154_1.time_ - var_157_9) / var_157_12
				local var_157_14 = Vector3.New(0, -430, -55)

				var_157_8.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1037, var_157_14, var_157_13)
			end

			if arg_154_1.time_ >= var_157_9 + var_157_12 and arg_154_1.time_ < var_157_9 + var_157_12 + arg_157_0 then
				var_157_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_157_15 = 0
			local var_157_16 = 0.125

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_17 = arg_154_1:FormatText(StoryNameCfg[15].name)

				arg_154_1.leftNameTxt_.text = var_157_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_18 = arg_154_1:GetWordFromCfg(425061038)
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061038", "story_v_out_425061.awb") ~= 0 then
					local var_157_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061038", "story_v_out_425061.awb") / 1000

					if var_157_23 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_23 + var_157_15
					end

					if var_157_18.prefab_name ~= "" and arg_154_1.actors_[var_157_18.prefab_name] ~= nil then
						local var_157_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_18.prefab_name].transform, "story_v_out_425061", "425061038", "story_v_out_425061.awb")

						arg_154_1:RecordAudio("425061038", var_157_24)
						arg_154_1:RecordAudio("425061038", var_157_24)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_425061", "425061038", "story_v_out_425061.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_425061", "425061038", "story_v_out_425061.awb")
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
				actorName = "1037",
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
	Play425061039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 425061039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play425061040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1037"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps1037 == nil then
				arg_158_1.var_.actorSpriteComps1037 = var_161_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_2 = 0.2

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.actorSpriteComps1037 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps1037 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_161_3 then
						if arg_158_1.isInRecall_ then
							iter_161_3.color = arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_161_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_158_1.var_.actorSpriteComps1037 = nil
			end

			local var_161_8 = 0
			local var_161_9 = 0.525

			if var_161_8 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_10 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_11 = arg_158_1:GetWordFromCfg(425061039)
				local var_161_12 = arg_158_1:FormatText(var_161_11.content)

				arg_158_1.text_.text = var_161_12

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_13 = 21
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
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_16 and arg_158_1.time_ < var_161_8 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play425061040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 425061040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play425061041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1037"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1037 = var_165_0.localPosition
				var_165_0.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("1037", 7)

				local var_165_2 = var_165_0.childCount

				for iter_165_0 = 0, var_165_2 - 1 do
					local var_165_3 = var_165_0:GetChild(iter_165_0)

					if var_165_3.name == "" or not string.find(var_165_3.name, "split") then
						var_165_3.gameObject:SetActive(true)
					else
						var_165_3.gameObject:SetActive(false)
					end
				end
			end

			local var_165_4 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_4 then
				local var_165_5 = (arg_162_1.time_ - var_165_1) / var_165_4
				local var_165_6 = Vector3.New(1500, -2000, 0)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1037, var_165_6, var_165_5)
			end

			if arg_162_1.time_ >= var_165_1 + var_165_4 and arg_162_1.time_ < var_165_1 + var_165_4 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_165_7 = 0.7
			local var_165_8 = 1

			if var_165_7 < arg_162_1.time_ and arg_162_1.time_ <= var_165_7 + arg_165_0 then
				local var_165_9 = "play"
				local var_165_10 = "effect"

				arg_162_1:AudioAction(var_165_9, var_165_10, "se_story_130", "se_story_130_paper", "")
			end

			local var_165_11 = 0
			local var_165_12 = 1.25

			if var_165_11 < arg_162_1.time_ and arg_162_1.time_ <= var_165_11 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_13 = arg_162_1:GetWordFromCfg(425061040)
				local var_165_14 = arg_162_1:FormatText(var_165_13.content)

				arg_162_1.text_.text = var_165_14

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_15 = 50
				local var_165_16 = utf8.len(var_165_14)
				local var_165_17 = var_165_15 <= 0 and var_165_12 or var_165_12 * (var_165_16 / var_165_15)

				if var_165_17 > 0 and var_165_12 < var_165_17 then
					arg_162_1.talkMaxDuration = var_165_17

					if var_165_17 + var_165_11 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_17 + var_165_11
					end
				end

				arg_162_1.text_.text = var_165_14
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_18 = math.max(var_165_12, arg_162_1.talkMaxDuration)

			if var_165_11 <= arg_162_1.time_ and arg_162_1.time_ < var_165_11 + var_165_18 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_11) / var_165_18

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_11 + var_165_18 and arg_162_1.time_ < var_165_11 + var_165_18 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play425061041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 425061041
		arg_166_1.duration_ = 14.7

		local var_166_0 = {
			zh = 10.8,
			ja = 14.7
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
				arg_166_0:Play425061042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1037"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps1037 == nil then
				arg_166_1.var_.actorSpriteComps1037 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps1037 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor1.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor1.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor1.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 1, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps1037 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_169_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps1037 = nil
			end

			local var_169_8 = arg_166_1.actors_["1037"].transform
			local var_169_9 = 0

			if var_169_9 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.var_.moveOldPos1037 = var_169_8.localPosition
				var_169_8.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1037", 3)

				local var_169_10 = var_169_8.childCount

				for iter_169_4 = 0, var_169_10 - 1 do
					local var_169_11 = var_169_8:GetChild(iter_169_4)

					if var_169_11.name == "" or not string.find(var_169_11.name, "split") then
						var_169_11.gameObject:SetActive(true)
					else
						var_169_11.gameObject:SetActive(false)
					end
				end
			end

			local var_169_12 = 0.001

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_12 then
				local var_169_13 = (arg_166_1.time_ - var_169_9) / var_169_12
				local var_169_14 = Vector3.New(0, -430, -55)

				var_169_8.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1037, var_169_14, var_169_13)
			end

			if arg_166_1.time_ >= var_169_9 + var_169_12 and arg_166_1.time_ < var_169_9 + var_169_12 + arg_169_0 then
				var_169_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_169_15 = 0
			local var_169_16 = 1.45

			if var_169_15 < arg_166_1.time_ and arg_166_1.time_ <= var_169_15 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_17 = arg_166_1:FormatText(StoryNameCfg[15].name)

				arg_166_1.leftNameTxt_.text = var_169_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_18 = arg_166_1:GetWordFromCfg(425061041)
				local var_169_19 = arg_166_1:FormatText(var_169_18.content)

				arg_166_1.text_.text = var_169_19

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_20 = 58
				local var_169_21 = utf8.len(var_169_19)
				local var_169_22 = var_169_20 <= 0 and var_169_16 or var_169_16 * (var_169_21 / var_169_20)

				if var_169_22 > 0 and var_169_16 < var_169_22 then
					arg_166_1.talkMaxDuration = var_169_22

					if var_169_22 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_22 + var_169_15
					end
				end

				arg_166_1.text_.text = var_169_19
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061041", "story_v_out_425061.awb") ~= 0 then
					local var_169_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061041", "story_v_out_425061.awb") / 1000

					if var_169_23 + var_169_15 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_15
					end

					if var_169_18.prefab_name ~= "" and arg_166_1.actors_[var_169_18.prefab_name] ~= nil then
						local var_169_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_18.prefab_name].transform, "story_v_out_425061", "425061041", "story_v_out_425061.awb")

						arg_166_1:RecordAudio("425061041", var_169_24)
						arg_166_1:RecordAudio("425061041", var_169_24)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_425061", "425061041", "story_v_out_425061.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_425061", "425061041", "story_v_out_425061.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_25 = math.max(var_169_16, arg_166_1.talkMaxDuration)

			if var_169_15 <= arg_166_1.time_ and arg_166_1.time_ < var_169_15 + var_169_25 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_15) / var_169_25

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_15 + var_169_25 and arg_166_1.time_ < var_169_15 + var_169_25 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play425061042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 425061042
		arg_170_1.duration_ = 7.27

		local var_170_0 = {
			zh = 6.733,
			ja = 7.266
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
				arg_170_0:Play425061043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.7

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[15].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:GetWordFromCfg(425061042)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061042", "story_v_out_425061.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061042", "story_v_out_425061.awb") / 1000

					if var_173_8 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_0
					end

					if var_173_3.prefab_name ~= "" and arg_170_1.actors_[var_173_3.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_3.prefab_name].transform, "story_v_out_425061", "425061042", "story_v_out_425061.awb")

						arg_170_1:RecordAudio("425061042", var_173_9)
						arg_170_1:RecordAudio("425061042", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_425061", "425061042", "story_v_out_425061.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_425061", "425061042", "story_v_out_425061.awb")
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
	Play425061043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 425061043
		arg_174_1.duration_ = 1

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"

			SetActive(arg_174_1.choicesGo_, true)

			for iter_175_0, iter_175_1 in ipairs(arg_174_1.choices_) do
				local var_175_0 = iter_175_0 <= 1

				SetActive(iter_175_1.go, var_175_0)
			end

			arg_174_1.choices_[1].txt.text = arg_174_1:FormatText(StoryChoiceCfg[1536].name)
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play425061044(arg_174_1)
			end

			arg_174_1:RecordChoiceLog(425061043, 1536)
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1037"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps1037 == nil then
				arg_174_1.var_.actorSpriteComps1037 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps1037 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps1037 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps1037 = nil
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play425061044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 425061044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play425061045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.675

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[7].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(425061044)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 27
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
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_8 and arg_178_1.time_ < var_181_0 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play425061045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 425061045
		arg_182_1.duration_ = 5.5

		local var_182_0 = {
			zh = 4.8,
			ja = 5.5
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
				arg_182_0:Play425061046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1037"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1037 == nil then
				arg_182_1.var_.actorSpriteComps1037 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps1037 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 1, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps1037 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_185_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps1037 = nil
			end

			local var_185_8 = arg_182_1.actors_["1037"].transform
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 then
				arg_182_1.var_.moveOldPos1037 = var_185_8.localPosition
				var_185_8.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("1037", 3)

				local var_185_10 = var_185_8.childCount

				for iter_185_4 = 0, var_185_10 - 1 do
					local var_185_11 = var_185_8:GetChild(iter_185_4)

					if var_185_11.name == "split_5" then
						var_185_11:SetAsLastSibling()
						var_185_11.gameObject:SetActive(true)

						arg_182_1.var_.actorSpriteSplit1037 = var_185_11.gameObject:GetComponent(typeof(Image))

						arg_182_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_185_12 = 0.2

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_12 then
				local var_185_13 = (arg_182_1.time_ - var_185_9) / var_185_12
				local var_185_14 = Vector3.New(0, -430, -55)

				var_185_8.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1037, var_185_14, var_185_13)

				if arg_182_1.var_.actorSpriteSplit1037 ~= nil then
					arg_182_1.var_.actorSpriteSplit1037:SetAlpha(var_185_13)
				end
			end

			if arg_182_1.time_ >= var_185_9 + var_185_12 and arg_182_1.time_ < var_185_9 + var_185_12 + arg_185_0 then
				var_185_8.localPosition = Vector3.New(0, -430, -55)

				if arg_182_1.var_.actorSpriteSplit1037 ~= nil then
					arg_182_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_185_15 = 0
			local var_185_16 = 0.375

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_17 = arg_182_1:FormatText(StoryNameCfg[15].name)

				arg_182_1.leftNameTxt_.text = var_185_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_18 = arg_182_1:GetWordFromCfg(425061045)
				local var_185_19 = arg_182_1:FormatText(var_185_18.content)

				arg_182_1.text_.text = var_185_19

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_20 = 15
				local var_185_21 = utf8.len(var_185_19)
				local var_185_22 = var_185_20 <= 0 and var_185_16 or var_185_16 * (var_185_21 / var_185_20)

				if var_185_22 > 0 and var_185_16 < var_185_22 then
					arg_182_1.talkMaxDuration = var_185_22

					if var_185_22 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_22 + var_185_15
					end
				end

				arg_182_1.text_.text = var_185_19
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061045", "story_v_out_425061.awb") ~= 0 then
					local var_185_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061045", "story_v_out_425061.awb") / 1000

					if var_185_23 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_23 + var_185_15
					end

					if var_185_18.prefab_name ~= "" and arg_182_1.actors_[var_185_18.prefab_name] ~= nil then
						local var_185_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_18.prefab_name].transform, "story_v_out_425061", "425061045", "story_v_out_425061.awb")

						arg_182_1:RecordAudio("425061045", var_185_24)
						arg_182_1:RecordAudio("425061045", var_185_24)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_425061", "425061045", "story_v_out_425061.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_425061", "425061045", "story_v_out_425061.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_25 = math.max(var_185_16, arg_182_1.talkMaxDuration)

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_25 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_15) / var_185_25

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_15 + var_185_25 and arg_182_1.time_ < var_185_15 + var_185_25 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play425061046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 425061046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play425061047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1037"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps1037 == nil then
				arg_186_1.var_.actorSpriteComps1037 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps1037 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps1037 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps1037 = nil
			end

			local var_189_8 = 0
			local var_189_9 = 0.45

			if var_189_8 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_10 = arg_186_1:FormatText(StoryNameCfg[7].name)

				arg_186_1.leftNameTxt_.text = var_189_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_11 = arg_186_1:GetWordFromCfg(425061046)
				local var_189_12 = arg_186_1:FormatText(var_189_11.content)

				arg_186_1.text_.text = var_189_12

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 18
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
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_16 and arg_186_1.time_ < var_189_8 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play425061047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 425061047
		arg_190_1.duration_ = 11.83

		local var_190_0 = {
			zh = 9.8,
			ja = 11.833
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
				arg_190_0:Play425061048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1037"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps1037 == nil then
				arg_190_1.var_.actorSpriteComps1037 = var_193_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.actorSpriteComps1037 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.actorSpriteComps1037 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_193_3 then
						if arg_190_1.isInRecall_ then
							iter_193_3.color = arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_193_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_190_1.var_.actorSpriteComps1037 = nil
			end

			local var_193_8 = arg_190_1.actors_["1037"].transform
			local var_193_9 = 0

			if var_193_9 < arg_190_1.time_ and arg_190_1.time_ <= var_193_9 + arg_193_0 then
				arg_190_1.var_.moveOldPos1037 = var_193_8.localPosition
				var_193_8.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("1037", 3)

				local var_193_10 = var_193_8.childCount

				for iter_193_4 = 0, var_193_10 - 1 do
					local var_193_11 = var_193_8:GetChild(iter_193_4)

					if var_193_11.name == "split_1" then
						var_193_11:SetAsLastSibling()
						var_193_11.gameObject:SetActive(true)

						arg_190_1.var_.actorSpriteSplit1037 = var_193_11.gameObject:GetComponent(typeof(Image))

						arg_190_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_193_12 = 0.2

			if var_193_9 <= arg_190_1.time_ and arg_190_1.time_ < var_193_9 + var_193_12 then
				local var_193_13 = (arg_190_1.time_ - var_193_9) / var_193_12
				local var_193_14 = Vector3.New(0, -430, -55)

				var_193_8.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1037, var_193_14, var_193_13)

				if arg_190_1.var_.actorSpriteSplit1037 ~= nil then
					arg_190_1.var_.actorSpriteSplit1037:SetAlpha(var_193_13)
				end
			end

			if arg_190_1.time_ >= var_193_9 + var_193_12 and arg_190_1.time_ < var_193_9 + var_193_12 + arg_193_0 then
				var_193_8.localPosition = Vector3.New(0, -430, -55)

				if arg_190_1.var_.actorSpriteSplit1037 ~= nil then
					arg_190_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_193_15 = 0
			local var_193_16 = 0.975

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_17 = arg_190_1:FormatText(StoryNameCfg[15].name)

				arg_190_1.leftNameTxt_.text = var_193_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_18 = arg_190_1:GetWordFromCfg(425061047)
				local var_193_19 = arg_190_1:FormatText(var_193_18.content)

				arg_190_1.text_.text = var_193_19

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_20 = 39
				local var_193_21 = utf8.len(var_193_19)
				local var_193_22 = var_193_20 <= 0 and var_193_16 or var_193_16 * (var_193_21 / var_193_20)

				if var_193_22 > 0 and var_193_16 < var_193_22 then
					arg_190_1.talkMaxDuration = var_193_22

					if var_193_22 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_15
					end
				end

				arg_190_1.text_.text = var_193_19
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061047", "story_v_out_425061.awb") ~= 0 then
					local var_193_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061047", "story_v_out_425061.awb") / 1000

					if var_193_23 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_23 + var_193_15
					end

					if var_193_18.prefab_name ~= "" and arg_190_1.actors_[var_193_18.prefab_name] ~= nil then
						local var_193_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_18.prefab_name].transform, "story_v_out_425061", "425061047", "story_v_out_425061.awb")

						arg_190_1:RecordAudio("425061047", var_193_24)
						arg_190_1:RecordAudio("425061047", var_193_24)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_425061", "425061047", "story_v_out_425061.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_425061", "425061047", "story_v_out_425061.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_25 = math.max(var_193_16, arg_190_1.talkMaxDuration)

			if var_193_15 <= arg_190_1.time_ and arg_190_1.time_ < var_193_15 + var_193_25 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_15) / var_193_25

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_15 + var_193_25 and arg_190_1.time_ < var_193_15 + var_193_25 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play425061048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 425061048
		arg_194_1.duration_ = 10.6

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play425061049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_1 = 1.2

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_1 then
				local var_197_2 = (arg_194_1.time_ - var_197_0) / var_197_1
				local var_197_3 = Color.New(0, 0, 0)

				var_197_3.a = Mathf.Lerp(0, 1, var_197_2)
				arg_194_1.mask_.color = var_197_3
			end

			if arg_194_1.time_ >= var_197_0 + var_197_1 and arg_194_1.time_ < var_197_0 + var_197_1 + arg_197_0 then
				local var_197_4 = Color.New(0, 0, 0)

				var_197_4.a = 1
				arg_194_1.mask_.color = var_197_4
			end

			local var_197_5 = 1.2

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_6 = 1.2

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_6 then
				local var_197_7 = (arg_194_1.time_ - var_197_5) / var_197_6
				local var_197_8 = Color.New(0, 0, 0)

				var_197_8.a = Mathf.Lerp(1, 0, var_197_7)
				arg_194_1.mask_.color = var_197_8
			end

			if arg_194_1.time_ >= var_197_5 + var_197_6 and arg_194_1.time_ < var_197_5 + var_197_6 + arg_197_0 then
				local var_197_9 = Color.New(0, 0, 0)
				local var_197_10 = 0

				arg_194_1.mask_.enabled = false
				var_197_9.a = var_197_10
				arg_194_1.mask_.color = var_197_9
			end

			local var_197_11 = 5.60000033333333

			if var_197_11 < arg_194_1.time_ and arg_194_1.time_ <= var_197_11 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			local var_197_12 = 0.95

			if arg_194_1.time_ >= var_197_11 + var_197_12 and arg_194_1.time_ < var_197_11 + var_197_12 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end

			local var_197_13 = arg_194_1.actors_["1037"].transform
			local var_197_14 = 1.2

			if var_197_14 < arg_194_1.time_ and arg_194_1.time_ <= var_197_14 + arg_197_0 then
				arg_194_1.var_.moveOldPos1037 = var_197_13.localPosition
				var_197_13.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1037", 7)

				local var_197_15 = var_197_13.childCount

				for iter_197_0 = 0, var_197_15 - 1 do
					local var_197_16 = var_197_13:GetChild(iter_197_0)

					if var_197_16.name == "" or not string.find(var_197_16.name, "split") then
						var_197_16.gameObject:SetActive(true)
					else
						var_197_16.gameObject:SetActive(false)
					end
				end
			end

			local var_197_17 = 0.001

			if var_197_14 <= arg_194_1.time_ and arg_194_1.time_ < var_197_14 + var_197_17 then
				local var_197_18 = (arg_194_1.time_ - var_197_14) / var_197_17
				local var_197_19 = Vector3.New(1500, -2000, 0)

				var_197_13.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1037, var_197_19, var_197_18)
			end

			if arg_194_1.time_ >= var_197_14 + var_197_17 and arg_194_1.time_ < var_197_14 + var_197_17 + arg_197_0 then
				var_197_13.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_197_20 = 1.2
			local var_197_21 = 1.999999999999
			local var_197_22 = "ST10"

			if var_197_20 < arg_194_1.time_ and arg_194_1.time_ <= var_197_20 + arg_197_0 then
				arg_194_1.timestampController_:SetSelectedState("show")
				arg_194_1.timestampAni_:Play("in")

				arg_194_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_197_22)

				arg_194_1.timestampColorController_:SetSelectedState("cold")
				arg_194_1.timeColdImg_:SetAlpha(0.031)

				local var_197_23 = arg_194_1:GetWordFromCfg(501119)
				local var_197_24 = arg_194_1:FormatText(var_197_23.content)

				arg_194_1.text_timeText_.text = var_197_24

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_timeText_)

				local var_197_25 = arg_194_1:GetWordFromCfg(501113)
				local var_197_26 = arg_194_1:FormatText(var_197_25.content)

				arg_194_1.text_siteText_.text = var_197_26

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_siteText_)
			end

			if arg_194_1.time_ >= var_197_20 + var_197_21 and arg_194_1.time_ < var_197_20 + var_197_21 + arg_197_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_194_1.timestampAni_, "out", function()
					arg_194_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_197_27 = 3.20000033333333

			if var_197_27 < arg_194_1.time_ and arg_194_1.time_ <= var_197_27 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_28 = 1.2

			if var_197_27 <= arg_194_1.time_ and arg_194_1.time_ < var_197_27 + var_197_28 then
				local var_197_29 = (arg_194_1.time_ - var_197_27) / var_197_28
				local var_197_30 = Color.New(0, 0, 0)

				var_197_30.a = Mathf.Lerp(0, 1, var_197_29)
				arg_194_1.mask_.color = var_197_30
			end

			if arg_194_1.time_ >= var_197_27 + var_197_28 and arg_194_1.time_ < var_197_27 + var_197_28 + arg_197_0 then
				local var_197_31 = Color.New(0, 0, 0)

				var_197_31.a = 1
				arg_194_1.mask_.color = var_197_31
			end

			local var_197_32 = 4.40000033333333

			if var_197_32 < arg_194_1.time_ and arg_194_1.time_ <= var_197_32 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_33 = 1.2

			if var_197_32 <= arg_194_1.time_ and arg_194_1.time_ < var_197_32 + var_197_33 then
				local var_197_34 = (arg_194_1.time_ - var_197_32) / var_197_33
				local var_197_35 = Color.New(0, 0, 0)

				var_197_35.a = Mathf.Lerp(1, 0, var_197_34)
				arg_194_1.mask_.color = var_197_35
			end

			if arg_194_1.time_ >= var_197_32 + var_197_33 and arg_194_1.time_ < var_197_32 + var_197_33 + arg_197_0 then
				local var_197_36 = Color.New(0, 0, 0)
				local var_197_37 = 0

				arg_194_1.mask_.enabled = false
				var_197_36.a = var_197_37
				arg_194_1.mask_.color = var_197_36
			end

			local var_197_38 = "ST10"

			if arg_194_1.bgs_[var_197_38] == nil then
				local var_197_39 = Object.Instantiate(arg_194_1.paintGo_)

				var_197_39:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_197_38)
				var_197_39.name = var_197_38
				var_197_39.transform.parent = arg_194_1.stage_.transform
				var_197_39.transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.bgs_[var_197_38] = var_197_39
			end

			local var_197_40 = 1.2

			if var_197_40 < arg_194_1.time_ and arg_194_1.time_ <= var_197_40 + arg_197_0 then
				local var_197_41 = manager.ui.mainCamera.transform.localPosition
				local var_197_42 = Vector3.New(0, 0, 10) + Vector3.New(var_197_41.x, var_197_41.y, 0)
				local var_197_43 = arg_194_1.bgs_.ST10

				var_197_43.transform.localPosition = var_197_42
				var_197_43.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_197_44 = var_197_43:GetComponent("SpriteRenderer")

				if var_197_44 and var_197_44.sprite then
					local var_197_45 = (var_197_43.transform.localPosition - var_197_41).z
					local var_197_46 = manager.ui.mainCameraCom_
					local var_197_47 = 2 * var_197_45 * Mathf.Tan(var_197_46.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_197_48 = var_197_47 * var_197_46.aspect
					local var_197_49 = var_197_44.sprite.bounds.size.x
					local var_197_50 = var_197_44.sprite.bounds.size.y
					local var_197_51 = var_197_48 / var_197_49
					local var_197_52 = var_197_47 / var_197_50
					local var_197_53 = var_197_52 < var_197_51 and var_197_51 or var_197_52

					var_197_43.transform.localScale = Vector3.New(var_197_53, var_197_53, 0)
				end

				for iter_197_1, iter_197_2 in pairs(arg_194_1.bgs_) do
					if iter_197_1 ~= "ST10" then
						iter_197_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_197_54 = 0.1
			local var_197_55 = 1

			if var_197_54 < arg_194_1.time_ and arg_194_1.time_ <= var_197_54 + arg_197_0 then
				local var_197_56 = "stop"
				local var_197_57 = "effect"

				arg_194_1:AudioAction(var_197_56, var_197_57, "se_story_147", "se_story_147_amb_rooftop", "")
			end

			local var_197_58 = 4
			local var_197_59 = 1

			if var_197_58 < arg_194_1.time_ and arg_194_1.time_ <= var_197_58 + arg_197_0 then
				local var_197_60 = "play"
				local var_197_61 = "effect"

				arg_194_1:AudioAction(var_197_60, var_197_61, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_62 = 5.60000033333333
			local var_197_63 = 0.95

			if var_197_62 < arg_194_1.time_ and arg_194_1.time_ <= var_197_62 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_64 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_64:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_194_1.dialogCg_.alpha = arg_199_0
				end))
				var_197_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_65 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_66 = arg_194_1:GetWordFromCfg(425061048)
				local var_197_67 = arg_194_1:FormatText(var_197_66.content)

				arg_194_1.text_.text = var_197_67

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_68 = 38
				local var_197_69 = utf8.len(var_197_67)
				local var_197_70 = var_197_68 <= 0 and var_197_63 or var_197_63 * (var_197_69 / var_197_68)

				if var_197_70 > 0 and var_197_63 < var_197_70 then
					arg_194_1.talkMaxDuration = var_197_70
					var_197_62 = var_197_62 + 0.3

					if var_197_70 + var_197_62 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_70 + var_197_62
					end
				end

				arg_194_1.text_.text = var_197_67
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_71 = var_197_62 + 0.3
			local var_197_72 = math.max(var_197_63, arg_194_1.talkMaxDuration)

			if var_197_71 <= arg_194_1.time_ and arg_194_1.time_ < var_197_71 + var_197_72 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_71) / var_197_72

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_71 + var_197_72 and arg_194_1.time_ < var_197_71 + var_197_72 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play425061049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 425061049
		arg_201_1.duration_ = 13.8

		local var_201_0 = {
			zh = 10.1,
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
				arg_201_0:Play425061050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = "1033"

			if arg_201_1.actors_[var_204_0] == nil then
				local var_204_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_204_1) then
					local var_204_2 = Object.Instantiate(var_204_1, arg_201_1.canvasGo_.transform)

					var_204_2.transform:SetSiblingIndex(1)

					var_204_2.name = var_204_0
					var_204_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_201_1.actors_[var_204_0] = var_204_2

					local var_204_3 = var_204_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_201_1.isInRecall_ then
						for iter_204_0, iter_204_1 in ipairs(var_204_3) do
							iter_204_1.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_204_4 = arg_201_1.actors_["1033"]
			local var_204_5 = 0

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.actorSpriteComps1033 == nil then
				arg_201_1.var_.actorSpriteComps1033 = var_204_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_6 = 0.2

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_6 and not isNil(var_204_4) then
				local var_204_7 = (arg_201_1.time_ - var_204_5) / var_204_6

				if arg_201_1.var_.actorSpriteComps1033 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								local var_204_8 = Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor1.r, var_204_7)
								local var_204_9 = Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor1.g, var_204_7)
								local var_204_10 = Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor1.b, var_204_7)

								iter_204_3.color = Color.New(var_204_8, var_204_9, var_204_10)
							else
								local var_204_11 = Mathf.Lerp(iter_204_3.color.r, 1, var_204_7)

								iter_204_3.color = Color.New(var_204_11, var_204_11, var_204_11)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_5 + var_204_6 and arg_201_1.time_ < var_204_5 + var_204_6 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.actorSpriteComps1033 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_204_5 then
						if arg_201_1.isInRecall_ then
							iter_204_5.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1033 = nil
			end

			local var_204_12 = arg_201_1.actors_["1033"].transform
			local var_204_13 = 0

			if var_204_13 < arg_201_1.time_ and arg_201_1.time_ <= var_204_13 + arg_204_0 then
				arg_201_1.var_.moveOldPos1033 = var_204_12.localPosition
				var_204_12.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1033", 3)

				local var_204_14 = var_204_12.childCount

				for iter_204_6 = 0, var_204_14 - 1 do
					local var_204_15 = var_204_12:GetChild(iter_204_6)

					if var_204_15.name == "" or not string.find(var_204_15.name, "split") then
						var_204_15.gameObject:SetActive(true)
					else
						var_204_15.gameObject:SetActive(false)
					end
				end
			end

			local var_204_16 = 0.001

			if var_204_13 <= arg_201_1.time_ and arg_201_1.time_ < var_204_13 + var_204_16 then
				local var_204_17 = (arg_201_1.time_ - var_204_13) / var_204_16
				local var_204_18 = Vector3.New(0, -420, 0)

				var_204_12.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1033, var_204_18, var_204_17)
			end

			if arg_201_1.time_ >= var_204_13 + var_204_16 and arg_201_1.time_ < var_204_13 + var_204_16 + arg_204_0 then
				var_204_12.localPosition = Vector3.New(0, -420, 0)
			end

			local var_204_19 = 0
			local var_204_20 = 1.25

			if var_204_19 < arg_201_1.time_ and arg_201_1.time_ <= var_204_19 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_21 = arg_201_1:FormatText(StoryNameCfg[236].name)

				arg_201_1.leftNameTxt_.text = var_204_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_22 = arg_201_1:GetWordFromCfg(425061049)
				local var_204_23 = arg_201_1:FormatText(var_204_22.content)

				arg_201_1.text_.text = var_204_23

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_24 = 50
				local var_204_25 = utf8.len(var_204_23)
				local var_204_26 = var_204_24 <= 0 and var_204_20 or var_204_20 * (var_204_25 / var_204_24)

				if var_204_26 > 0 and var_204_20 < var_204_26 then
					arg_201_1.talkMaxDuration = var_204_26

					if var_204_26 + var_204_19 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_26 + var_204_19
					end
				end

				arg_201_1.text_.text = var_204_23
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061049", "story_v_out_425061.awb") ~= 0 then
					local var_204_27 = manager.audio:GetVoiceLength("story_v_out_425061", "425061049", "story_v_out_425061.awb") / 1000

					if var_204_27 + var_204_19 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_27 + var_204_19
					end

					if var_204_22.prefab_name ~= "" and arg_201_1.actors_[var_204_22.prefab_name] ~= nil then
						local var_204_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_22.prefab_name].transform, "story_v_out_425061", "425061049", "story_v_out_425061.awb")

						arg_201_1:RecordAudio("425061049", var_204_28)
						arg_201_1:RecordAudio("425061049", var_204_28)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_425061", "425061049", "story_v_out_425061.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_425061", "425061049", "story_v_out_425061.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_29 = math.max(var_204_20, arg_201_1.talkMaxDuration)

			if var_204_19 <= arg_201_1.time_ and arg_201_1.time_ < var_204_19 + var_204_29 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_19) / var_204_29

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_19 + var_204_29 and arg_201_1.time_ < var_204_19 + var_204_29 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 425061050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play425061051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1033"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1033 == nil then
				arg_205_1.var_.actorSpriteComps1033 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps1033 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								local var_208_4 = Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor2.r, var_208_3)
								local var_208_5 = Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor2.g, var_208_3)
								local var_208_6 = Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor2.b, var_208_3)

								iter_208_1.color = Color.New(var_208_4, var_208_5, var_208_6)
							else
								local var_208_7 = Mathf.Lerp(iter_208_1.color.r, 0.5, var_208_3)

								iter_208_1.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1033 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1033 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 0.5

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_10 = arg_205_1:FormatText(StoryNameCfg[7].name)

				arg_205_1.leftNameTxt_.text = var_208_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_11 = arg_205_1:GetWordFromCfg(425061050)
				local var_208_12 = arg_205_1:FormatText(var_208_11.content)

				arg_205_1.text_.text = var_208_12

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 20
				local var_208_14 = utf8.len(var_208_12)
				local var_208_15 = var_208_13 <= 0 and var_208_9 or var_208_9 * (var_208_14 / var_208_13)

				if var_208_15 > 0 and var_208_9 < var_208_15 then
					arg_205_1.talkMaxDuration = var_208_15

					if var_208_15 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_15 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_12
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_16 and arg_205_1.time_ < var_208_8 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play425061051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 425061051
		arg_209_1.duration_ = 10.7

		local var_209_0 = {
			zh = 6.666,
			ja = 10.7
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
				arg_209_0:Play425061052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1033"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1033 == nil then
				arg_209_1.var_.actorSpriteComps1033 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps1033 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								local var_212_4 = Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor1.r, var_212_3)
								local var_212_5 = Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor1.g, var_212_3)
								local var_212_6 = Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor1.b, var_212_3)

								iter_212_1.color = Color.New(var_212_4, var_212_5, var_212_6)
							else
								local var_212_7 = Mathf.Lerp(iter_212_1.color.r, 1, var_212_3)

								iter_212_1.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps1033 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps1033 = nil
			end

			local var_212_8 = arg_209_1.actors_["1033"].transform
			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.var_.moveOldPos1033 = var_212_8.localPosition
				var_212_8.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("1033", 3)

				local var_212_10 = var_212_8.childCount

				for iter_212_4 = 0, var_212_10 - 1 do
					local var_212_11 = var_212_8:GetChild(iter_212_4)

					if var_212_11.name == "" or not string.find(var_212_11.name, "split") then
						var_212_11.gameObject:SetActive(true)
					else
						var_212_11.gameObject:SetActive(false)
					end
				end
			end

			local var_212_12 = 0.001

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_12 then
				local var_212_13 = (arg_209_1.time_ - var_212_9) / var_212_12
				local var_212_14 = Vector3.New(0, -420, 0)

				var_212_8.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1033, var_212_14, var_212_13)
			end

			if arg_209_1.time_ >= var_212_9 + var_212_12 and arg_209_1.time_ < var_212_9 + var_212_12 + arg_212_0 then
				var_212_8.localPosition = Vector3.New(0, -420, 0)
			end

			local var_212_15 = 0
			local var_212_16 = 0.85

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_17 = arg_209_1:FormatText(StoryNameCfg[236].name)

				arg_209_1.leftNameTxt_.text = var_212_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_18 = arg_209_1:GetWordFromCfg(425061051)
				local var_212_19 = arg_209_1:FormatText(var_212_18.content)

				arg_209_1.text_.text = var_212_19

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 34
				local var_212_21 = utf8.len(var_212_19)
				local var_212_22 = var_212_20 <= 0 and var_212_16 or var_212_16 * (var_212_21 / var_212_20)

				if var_212_22 > 0 and var_212_16 < var_212_22 then
					arg_209_1.talkMaxDuration = var_212_22

					if var_212_22 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_19
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061051", "story_v_out_425061.awb") ~= 0 then
					local var_212_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061051", "story_v_out_425061.awb") / 1000

					if var_212_23 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_15
					end

					if var_212_18.prefab_name ~= "" and arg_209_1.actors_[var_212_18.prefab_name] ~= nil then
						local var_212_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_18.prefab_name].transform, "story_v_out_425061", "425061051", "story_v_out_425061.awb")

						arg_209_1:RecordAudio("425061051", var_212_24)
						arg_209_1:RecordAudio("425061051", var_212_24)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_425061", "425061051", "story_v_out_425061.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_425061", "425061051", "story_v_out_425061.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_25 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_25 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_15) / var_212_25

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_15 + var_212_25 and arg_209_1.time_ < var_212_15 + var_212_25 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play425061052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 425061052
		arg_213_1.duration_ = 9.43

		local var_213_0 = {
			zh = 9.433,
			ja = 8.833
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
				arg_213_0:Play425061053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = "1066"

			if arg_213_1.actors_[var_216_0] == nil then
				local var_216_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1066")

				if not isNil(var_216_1) then
					local var_216_2 = Object.Instantiate(var_216_1, arg_213_1.canvasGo_.transform)

					var_216_2.transform:SetSiblingIndex(1)

					var_216_2.name = var_216_0
					var_216_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_213_1.actors_[var_216_0] = var_216_2

					local var_216_3 = var_216_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_213_1.isInRecall_ then
						for iter_216_0, iter_216_1 in ipairs(var_216_3) do
							iter_216_1.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_216_4 = arg_213_1.actors_["1066"]
			local var_216_5 = 0

			if var_216_5 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.actorSpriteComps1066 == nil then
				arg_213_1.var_.actorSpriteComps1066 = var_216_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_6 = 0.2

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_6 and not isNil(var_216_4) then
				local var_216_7 = (arg_213_1.time_ - var_216_5) / var_216_6

				if arg_213_1.var_.actorSpriteComps1066 then
					for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_216_3 then
							if arg_213_1.isInRecall_ then
								local var_216_8 = Mathf.Lerp(iter_216_3.color.r, arg_213_1.hightColor1.r, var_216_7)
								local var_216_9 = Mathf.Lerp(iter_216_3.color.g, arg_213_1.hightColor1.g, var_216_7)
								local var_216_10 = Mathf.Lerp(iter_216_3.color.b, arg_213_1.hightColor1.b, var_216_7)

								iter_216_3.color = Color.New(var_216_8, var_216_9, var_216_10)
							else
								local var_216_11 = Mathf.Lerp(iter_216_3.color.r, 1, var_216_7)

								iter_216_3.color = Color.New(var_216_11, var_216_11, var_216_11)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_5 + var_216_6 and arg_213_1.time_ < var_216_5 + var_216_6 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.actorSpriteComps1066 then
				for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_216_5 then
						if arg_213_1.isInRecall_ then
							iter_216_5.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1066 = nil
			end

			local var_216_12 = arg_213_1.actors_["1033"]
			local var_216_13 = 0

			if var_216_13 < arg_213_1.time_ and arg_213_1.time_ <= var_216_13 + arg_216_0 and not isNil(var_216_12) and arg_213_1.var_.actorSpriteComps1033 == nil then
				arg_213_1.var_.actorSpriteComps1033 = var_216_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_14 = 0.2

			if var_216_13 <= arg_213_1.time_ and arg_213_1.time_ < var_216_13 + var_216_14 and not isNil(var_216_12) then
				local var_216_15 = (arg_213_1.time_ - var_216_13) / var_216_14

				if arg_213_1.var_.actorSpriteComps1033 then
					for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_216_7 then
							if arg_213_1.isInRecall_ then
								local var_216_16 = Mathf.Lerp(iter_216_7.color.r, arg_213_1.hightColor2.r, var_216_15)
								local var_216_17 = Mathf.Lerp(iter_216_7.color.g, arg_213_1.hightColor2.g, var_216_15)
								local var_216_18 = Mathf.Lerp(iter_216_7.color.b, arg_213_1.hightColor2.b, var_216_15)

								iter_216_7.color = Color.New(var_216_16, var_216_17, var_216_18)
							else
								local var_216_19 = Mathf.Lerp(iter_216_7.color.r, 0.5, var_216_15)

								iter_216_7.color = Color.New(var_216_19, var_216_19, var_216_19)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_13 + var_216_14 and arg_213_1.time_ < var_216_13 + var_216_14 + arg_216_0 and not isNil(var_216_12) and arg_213_1.var_.actorSpriteComps1033 then
				for iter_216_8, iter_216_9 in pairs(arg_213_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_216_9 then
						if arg_213_1.isInRecall_ then
							iter_216_9.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps1033 = nil
			end

			local var_216_20 = arg_213_1.actors_["1066"].transform
			local var_216_21 = 0

			if var_216_21 < arg_213_1.time_ and arg_213_1.time_ <= var_216_21 + arg_216_0 then
				arg_213_1.var_.moveOldPos1066 = var_216_20.localPosition
				var_216_20.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1066", 4)

				local var_216_22 = var_216_20.childCount

				for iter_216_10 = 0, var_216_22 - 1 do
					local var_216_23 = var_216_20:GetChild(iter_216_10)

					if var_216_23.name == "" or not string.find(var_216_23.name, "split") then
						var_216_23.gameObject:SetActive(true)
					else
						var_216_23.gameObject:SetActive(false)
					end
				end
			end

			local var_216_24 = 0.001

			if var_216_21 <= arg_213_1.time_ and arg_213_1.time_ < var_216_21 + var_216_24 then
				local var_216_25 = (arg_213_1.time_ - var_216_21) / var_216_24
				local var_216_26 = Vector3.New(453.9, -399.1, -303.3)

				var_216_20.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1066, var_216_26, var_216_25)
			end

			if arg_213_1.time_ >= var_216_21 + var_216_24 and arg_213_1.time_ < var_216_21 + var_216_24 + arg_216_0 then
				var_216_20.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_216_27 = arg_213_1.actors_["1033"].transform
			local var_216_28 = 0

			if var_216_28 < arg_213_1.time_ and arg_213_1.time_ <= var_216_28 + arg_216_0 then
				arg_213_1.var_.moveOldPos1033 = var_216_27.localPosition
				var_216_27.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("1033", 2)

				local var_216_29 = var_216_27.childCount

				for iter_216_11 = 0, var_216_29 - 1 do
					local var_216_30 = var_216_27:GetChild(iter_216_11)

					if var_216_30.name == "" or not string.find(var_216_30.name, "split") then
						var_216_30.gameObject:SetActive(true)
					else
						var_216_30.gameObject:SetActive(false)
					end
				end
			end

			local var_216_31 = 0.001

			if var_216_28 <= arg_213_1.time_ and arg_213_1.time_ < var_216_28 + var_216_31 then
				local var_216_32 = (arg_213_1.time_ - var_216_28) / var_216_31
				local var_216_33 = Vector3.New(-390, -420, 0)

				var_216_27.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1033, var_216_33, var_216_32)
			end

			if arg_213_1.time_ >= var_216_28 + var_216_31 and arg_213_1.time_ < var_216_28 + var_216_31 + arg_216_0 then
				var_216_27.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_216_34 = 0
			local var_216_35 = 1.125

			if var_216_34 < arg_213_1.time_ and arg_213_1.time_ <= var_216_34 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_36 = arg_213_1:FormatText(StoryNameCfg[32].name)

				arg_213_1.leftNameTxt_.text = var_216_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_37 = arg_213_1:GetWordFromCfg(425061052)
				local var_216_38 = arg_213_1:FormatText(var_216_37.content)

				arg_213_1.text_.text = var_216_38

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_39 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061052", "story_v_out_425061.awb") ~= 0 then
					local var_216_42 = manager.audio:GetVoiceLength("story_v_out_425061", "425061052", "story_v_out_425061.awb") / 1000

					if var_216_42 + var_216_34 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_42 + var_216_34
					end

					if var_216_37.prefab_name ~= "" and arg_213_1.actors_[var_216_37.prefab_name] ~= nil then
						local var_216_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_37.prefab_name].transform, "story_v_out_425061", "425061052", "story_v_out_425061.awb")

						arg_213_1:RecordAudio("425061052", var_216_43)
						arg_213_1:RecordAudio("425061052", var_216_43)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_425061", "425061052", "story_v_out_425061.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_425061", "425061052", "story_v_out_425061.awb")
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
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 425061053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play425061054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1066"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps1066 == nil then
				arg_217_1.var_.actorSpriteComps1066 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 0.2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps1066 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 0.5, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps1066 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps1066 = nil
			end

			local var_220_8 = 0
			local var_220_9 = 0.675

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_10 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_11 = arg_217_1:GetWordFromCfg(425061053)
				local var_220_12 = arg_217_1:FormatText(var_220_11.content)

				arg_217_1.text_.text = var_220_12

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 27
				local var_220_14 = utf8.len(var_220_12)
				local var_220_15 = var_220_13 <= 0 and var_220_9 or var_220_9 * (var_220_14 / var_220_13)

				if var_220_15 > 0 and var_220_9 < var_220_15 then
					arg_217_1.talkMaxDuration = var_220_15

					if var_220_15 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_15 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_12
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play425061054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 425061054
		arg_221_1.duration_ = 2.37

		local var_221_0 = {
			zh = 2.366,
			ja = 1.7
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
				arg_221_0:Play425061055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1066"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1066 == nil then
				arg_221_1.var_.actorSpriteComps1066 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps1066 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor1.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor1.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor1.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 1, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1066 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1066 = nil
			end

			local var_224_8 = arg_221_1.actors_["1066"].transform
			local var_224_9 = 0

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.var_.moveOldPos1066 = var_224_8.localPosition
				var_224_8.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1066", 4)

				local var_224_10 = var_224_8.childCount

				for iter_224_4 = 0, var_224_10 - 1 do
					local var_224_11 = var_224_8:GetChild(iter_224_4)

					if var_224_11.name == "" or not string.find(var_224_11.name, "split") then
						var_224_11.gameObject:SetActive(true)
					else
						var_224_11.gameObject:SetActive(false)
					end
				end
			end

			local var_224_12 = 0.001

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_12 then
				local var_224_13 = (arg_221_1.time_ - var_224_9) / var_224_12
				local var_224_14 = Vector3.New(453.9, -399.1, -303.3)

				var_224_8.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1066, var_224_14, var_224_13)
			end

			if arg_221_1.time_ >= var_224_9 + var_224_12 and arg_221_1.time_ < var_224_9 + var_224_12 + arg_224_0 then
				var_224_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_224_15 = 0
			local var_224_16 = 0.275

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[32].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(425061054)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 11
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061054", "story_v_out_425061.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061054", "story_v_out_425061.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_425061", "425061054", "story_v_out_425061.awb")

						arg_221_1:RecordAudio("425061054", var_224_24)
						arg_221_1:RecordAudio("425061054", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_425061", "425061054", "story_v_out_425061.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_425061", "425061054", "story_v_out_425061.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
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
	Play425061055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 425061055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play425061056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1066"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps1066 == nil then
				arg_225_1.var_.actorSpriteComps1066 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps1066 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								local var_228_4 = Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor2.r, var_228_3)
								local var_228_5 = Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor2.g, var_228_3)
								local var_228_6 = Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor2.b, var_228_3)

								iter_228_1.color = Color.New(var_228_4, var_228_5, var_228_6)
							else
								local var_228_7 = Mathf.Lerp(iter_228_1.color.r, 0.5, var_228_3)

								iter_228_1.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps1066 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1066 = nil
			end

			local var_228_8 = 0
			local var_228_9 = 0.4

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_10 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_11 = arg_225_1:GetWordFromCfg(425061055)
				local var_228_12 = arg_225_1:FormatText(var_228_11.content)

				arg_225_1.text_.text = var_228_12

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 16
				local var_228_14 = utf8.len(var_228_12)
				local var_228_15 = var_228_13 <= 0 and var_228_9 or var_228_9 * (var_228_14 / var_228_13)

				if var_228_15 > 0 and var_228_9 < var_228_15 then
					arg_225_1.talkMaxDuration = var_228_15

					if var_228_15 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_15 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_12
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_16 and arg_225_1.time_ < var_228_8 + var_228_16 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play425061056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 425061056
		arg_229_1.duration_ = 11.93

		local var_229_0 = {
			zh = 7.566,
			ja = 11.933
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
				arg_229_0:Play425061057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1033"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1033 == nil then
				arg_229_1.var_.actorSpriteComps1033 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps1033 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								local var_232_4 = Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor1.r, var_232_3)
								local var_232_5 = Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor1.g, var_232_3)
								local var_232_6 = Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor1.b, var_232_3)

								iter_232_1.color = Color.New(var_232_4, var_232_5, var_232_6)
							else
								local var_232_7 = Mathf.Lerp(iter_232_1.color.r, 1, var_232_3)

								iter_232_1.color = Color.New(var_232_7, var_232_7, var_232_7)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1033 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1033 = nil
			end

			local var_232_8 = arg_229_1.actors_["1033"].transform
			local var_232_9 = 0

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				arg_229_1.var_.moveOldPos1033 = var_232_8.localPosition
				var_232_8.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1033", 2)

				local var_232_10 = var_232_8.childCount

				for iter_232_4 = 0, var_232_10 - 1 do
					local var_232_11 = var_232_8:GetChild(iter_232_4)

					if var_232_11.name == "" or not string.find(var_232_11.name, "split") then
						var_232_11.gameObject:SetActive(true)
					else
						var_232_11.gameObject:SetActive(false)
					end
				end
			end

			local var_232_12 = 0.001

			if var_232_9 <= arg_229_1.time_ and arg_229_1.time_ < var_232_9 + var_232_12 then
				local var_232_13 = (arg_229_1.time_ - var_232_9) / var_232_12
				local var_232_14 = Vector3.New(-390, -420, 0)

				var_232_8.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1033, var_232_14, var_232_13)
			end

			if arg_229_1.time_ >= var_232_9 + var_232_12 and arg_229_1.time_ < var_232_9 + var_232_12 + arg_232_0 then
				var_232_8.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_232_15 = 0
			local var_232_16 = 1

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_17 = arg_229_1:FormatText(StoryNameCfg[236].name)

				arg_229_1.leftNameTxt_.text = var_232_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_18 = arg_229_1:GetWordFromCfg(425061056)
				local var_232_19 = arg_229_1:FormatText(var_232_18.content)

				arg_229_1.text_.text = var_232_19

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_20 = 40
				local var_232_21 = utf8.len(var_232_19)
				local var_232_22 = var_232_20 <= 0 and var_232_16 or var_232_16 * (var_232_21 / var_232_20)

				if var_232_22 > 0 and var_232_16 < var_232_22 then
					arg_229_1.talkMaxDuration = var_232_22

					if var_232_22 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_22 + var_232_15
					end
				end

				arg_229_1.text_.text = var_232_19
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061056", "story_v_out_425061.awb") ~= 0 then
					local var_232_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061056", "story_v_out_425061.awb") / 1000

					if var_232_23 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_15
					end

					if var_232_18.prefab_name ~= "" and arg_229_1.actors_[var_232_18.prefab_name] ~= nil then
						local var_232_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_18.prefab_name].transform, "story_v_out_425061", "425061056", "story_v_out_425061.awb")

						arg_229_1:RecordAudio("425061056", var_232_24)
						arg_229_1:RecordAudio("425061056", var_232_24)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_425061", "425061056", "story_v_out_425061.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_425061", "425061056", "story_v_out_425061.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_25 = math.max(var_232_16, arg_229_1.talkMaxDuration)

			if var_232_15 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_25 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_15) / var_232_25

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_15 + var_232_25 and arg_229_1.time_ < var_232_15 + var_232_25 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play425061057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 425061057
		arg_233_1.duration_ = 9.6

		local var_233_0 = {
			zh = 8.366,
			ja = 9.6
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
				arg_233_0:Play425061058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1033"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1033 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("1033", 2)

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
				local var_236_6 = Vector3.New(-390, -420, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1033, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_236_7 = 0
			local var_236_8 = 1.125

			if var_236_7 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_9 = arg_233_1:FormatText(StoryNameCfg[236].name)

				arg_233_1.leftNameTxt_.text = var_236_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(425061057)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_12 = 45
				local var_236_13 = utf8.len(var_236_11)
				local var_236_14 = var_236_12 <= 0 and var_236_8 or var_236_8 * (var_236_13 / var_236_12)

				if var_236_14 > 0 and var_236_8 < var_236_14 then
					arg_233_1.talkMaxDuration = var_236_14

					if var_236_14 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_7
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061057", "story_v_out_425061.awb") ~= 0 then
					local var_236_15 = manager.audio:GetVoiceLength("story_v_out_425061", "425061057", "story_v_out_425061.awb") / 1000

					if var_236_15 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_7
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_425061", "425061057", "story_v_out_425061.awb")

						arg_233_1:RecordAudio("425061057", var_236_16)
						arg_233_1:RecordAudio("425061057", var_236_16)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_425061", "425061057", "story_v_out_425061.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_425061", "425061057", "story_v_out_425061.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_17 = math.max(var_236_8, arg_233_1.talkMaxDuration)

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_17 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_7) / var_236_17

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_7 + var_236_17 and arg_233_1.time_ < var_236_7 + var_236_17 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 425061058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play425061059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["1033"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos1033 = var_240_0.localPosition
				var_240_0.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1033", 7)

				local var_240_2 = var_240_0.childCount

				for iter_240_0 = 0, var_240_2 - 1 do
					local var_240_3 = var_240_0:GetChild(iter_240_0)

					if var_240_3.name == "" or not string.find(var_240_3.name, "split") then
						var_240_3.gameObject:SetActive(true)
					else
						var_240_3.gameObject:SetActive(false)
					end
				end
			end

			local var_240_4 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_4 then
				local var_240_5 = (arg_237_1.time_ - var_240_1) / var_240_4
				local var_240_6 = Vector3.New(0, -2000, 0)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1033, var_240_6, var_240_5)
			end

			if arg_237_1.time_ >= var_240_1 + var_240_4 and arg_237_1.time_ < var_240_1 + var_240_4 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_7 = arg_237_1.actors_["1066"].transform
			local var_240_8 = 0

			if var_240_8 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.var_.moveOldPos1066 = var_240_7.localPosition
				var_240_7.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("1066", 7)

				local var_240_9 = var_240_7.childCount

				for iter_240_1 = 0, var_240_9 - 1 do
					local var_240_10 = var_240_7:GetChild(iter_240_1)

					if var_240_10.name == "" or not string.find(var_240_10.name, "split") then
						var_240_10.gameObject:SetActive(true)
					else
						var_240_10.gameObject:SetActive(false)
					end
				end
			end

			local var_240_11 = 0.001

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_11 then
				local var_240_12 = (arg_237_1.time_ - var_240_8) / var_240_11
				local var_240_13 = Vector3.New(0, -2000, 0)

				var_240_7.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1066, var_240_13, var_240_12)
			end

			if arg_237_1.time_ >= var_240_8 + var_240_11 and arg_237_1.time_ < var_240_8 + var_240_11 + arg_240_0 then
				var_240_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_14 = 0
			local var_240_15 = 1.175

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_16 = arg_237_1:GetWordFromCfg(425061058)
				local var_240_17 = arg_237_1:FormatText(var_240_16.content)

				arg_237_1.text_.text = var_240_17

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_18 = 47
				local var_240_19 = utf8.len(var_240_17)
				local var_240_20 = var_240_18 <= 0 and var_240_15 or var_240_15 * (var_240_19 / var_240_18)

				if var_240_20 > 0 and var_240_15 < var_240_20 then
					arg_237_1.talkMaxDuration = var_240_20

					if var_240_20 + var_240_14 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_20 + var_240_14
					end
				end

				arg_237_1.text_.text = var_240_17
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_21 = math.max(var_240_15, arg_237_1.talkMaxDuration)

			if var_240_14 <= arg_237_1.time_ and arg_237_1.time_ < var_240_14 + var_240_21 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_14) / var_240_21

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_14 + var_240_21 and arg_237_1.time_ < var_240_14 + var_240_21 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
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
	Play425061059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 425061059
		arg_241_1.duration_ = 6.87

		local var_241_0 = {
			zh = 3.033,
			ja = 6.866
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
				arg_241_0:Play425061060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1037"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps1037 == nil then
				arg_241_1.var_.actorSpriteComps1037 = var_244_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.actorSpriteComps1037 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_244_1 then
							if arg_241_1.isInRecall_ then
								local var_244_4 = Mathf.Lerp(iter_244_1.color.r, arg_241_1.hightColor1.r, var_244_3)
								local var_244_5 = Mathf.Lerp(iter_244_1.color.g, arg_241_1.hightColor1.g, var_244_3)
								local var_244_6 = Mathf.Lerp(iter_244_1.color.b, arg_241_1.hightColor1.b, var_244_3)

								iter_244_1.color = Color.New(var_244_4, var_244_5, var_244_6)
							else
								local var_244_7 = Mathf.Lerp(iter_244_1.color.r, 1, var_244_3)

								iter_244_1.color = Color.New(var_244_7, var_244_7, var_244_7)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps1037 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_244_3 then
						if arg_241_1.isInRecall_ then
							iter_244_3.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps1037 = nil
			end

			local var_244_8 = arg_241_1.actors_["1037"].transform
			local var_244_9 = 0

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 then
				arg_241_1.var_.moveOldPos1037 = var_244_8.localPosition
				var_244_8.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("1037", 3)

				local var_244_10 = var_244_8.childCount

				for iter_244_4 = 0, var_244_10 - 1 do
					local var_244_11 = var_244_8:GetChild(iter_244_4)

					if var_244_11.name == "" or not string.find(var_244_11.name, "split") then
						var_244_11.gameObject:SetActive(true)
					else
						var_244_11.gameObject:SetActive(false)
					end
				end
			end

			local var_244_12 = 0.001

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_12 then
				local var_244_13 = (arg_241_1.time_ - var_244_9) / var_244_12
				local var_244_14 = Vector3.New(0, -430, -55)

				var_244_8.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1037, var_244_14, var_244_13)
			end

			if arg_241_1.time_ >= var_244_9 + var_244_12 and arg_241_1.time_ < var_244_9 + var_244_12 + arg_244_0 then
				var_244_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_244_15 = 0
			local var_244_16 = 0.3

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_17 = arg_241_1:FormatText(StoryNameCfg[15].name)

				arg_241_1.leftNameTxt_.text = var_244_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_18 = arg_241_1:GetWordFromCfg(425061059)
				local var_244_19 = arg_241_1:FormatText(var_244_18.content)

				arg_241_1.text_.text = var_244_19

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_20 = 12
				local var_244_21 = utf8.len(var_244_19)
				local var_244_22 = var_244_20 <= 0 and var_244_16 or var_244_16 * (var_244_21 / var_244_20)

				if var_244_22 > 0 and var_244_16 < var_244_22 then
					arg_241_1.talkMaxDuration = var_244_22

					if var_244_22 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_22 + var_244_15
					end
				end

				arg_241_1.text_.text = var_244_19
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061059", "story_v_out_425061.awb") ~= 0 then
					local var_244_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061059", "story_v_out_425061.awb") / 1000

					if var_244_23 + var_244_15 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_23 + var_244_15
					end

					if var_244_18.prefab_name ~= "" and arg_241_1.actors_[var_244_18.prefab_name] ~= nil then
						local var_244_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_18.prefab_name].transform, "story_v_out_425061", "425061059", "story_v_out_425061.awb")

						arg_241_1:RecordAudio("425061059", var_244_24)
						arg_241_1:RecordAudio("425061059", var_244_24)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_425061", "425061059", "story_v_out_425061.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_425061", "425061059", "story_v_out_425061.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_25 = math.max(var_244_16, arg_241_1.talkMaxDuration)

			if var_244_15 <= arg_241_1.time_ and arg_241_1.time_ < var_244_15 + var_244_25 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_15) / var_244_25

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_15 + var_244_25 and arg_241_1.time_ < var_244_15 + var_244_25 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 425061060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play425061061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1037"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps1037 == nil then
				arg_245_1.var_.actorSpriteComps1037 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 0.2

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps1037 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								local var_248_4 = Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor2.r, var_248_3)
								local var_248_5 = Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor2.g, var_248_3)
								local var_248_6 = Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor2.b, var_248_3)

								iter_248_1.color = Color.New(var_248_4, var_248_5, var_248_6)
							else
								local var_248_7 = Mathf.Lerp(iter_248_1.color.r, 0.5, var_248_3)

								iter_248_1.color = Color.New(var_248_7, var_248_7, var_248_7)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps1037 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1037 = nil
			end

			local var_248_8 = 0
			local var_248_9 = 0.15

			if var_248_8 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_10 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_11 = arg_245_1:GetWordFromCfg(425061060)
				local var_248_12 = arg_245_1:FormatText(var_248_11.content)

				arg_245_1.text_.text = var_248_12

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 6
				local var_248_14 = utf8.len(var_248_12)
				local var_248_15 = var_248_13 <= 0 and var_248_9 or var_248_9 * (var_248_14 / var_248_13)

				if var_248_15 > 0 and var_248_9 < var_248_15 then
					arg_245_1.talkMaxDuration = var_248_15

					if var_248_15 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_15 + var_248_8
					end
				end

				arg_245_1.text_.text = var_248_12
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_16 and arg_245_1.time_ < var_248_8 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play425061061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 425061061
		arg_249_1.duration_ = 8.9

		local var_249_0 = {
			zh = 8.166,
			ja = 8.9
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
				arg_249_0:Play425061062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1037"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps1037 == nil then
				arg_249_1.var_.actorSpriteComps1037 = var_252_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.actorSpriteComps1037 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_252_1 then
							if arg_249_1.isInRecall_ then
								local var_252_4 = Mathf.Lerp(iter_252_1.color.r, arg_249_1.hightColor1.r, var_252_3)
								local var_252_5 = Mathf.Lerp(iter_252_1.color.g, arg_249_1.hightColor1.g, var_252_3)
								local var_252_6 = Mathf.Lerp(iter_252_1.color.b, arg_249_1.hightColor1.b, var_252_3)

								iter_252_1.color = Color.New(var_252_4, var_252_5, var_252_6)
							else
								local var_252_7 = Mathf.Lerp(iter_252_1.color.r, 1, var_252_3)

								iter_252_1.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps1037 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_252_3 then
						if arg_249_1.isInRecall_ then
							iter_252_3.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps1037 = nil
			end

			local var_252_8 = arg_249_1.actors_["1037"].transform
			local var_252_9 = 0

			if var_252_9 < arg_249_1.time_ and arg_249_1.time_ <= var_252_9 + arg_252_0 then
				arg_249_1.var_.moveOldPos1037 = var_252_8.localPosition
				var_252_8.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("1037", 3)

				local var_252_10 = var_252_8.childCount

				for iter_252_4 = 0, var_252_10 - 1 do
					local var_252_11 = var_252_8:GetChild(iter_252_4)

					if var_252_11.name == "split_1" or not string.find(var_252_11.name, "split") then
						var_252_11.gameObject:SetActive(true)
					else
						var_252_11.gameObject:SetActive(false)
					end
				end
			end

			local var_252_12 = 0.001

			if var_252_9 <= arg_249_1.time_ and arg_249_1.time_ < var_252_9 + var_252_12 then
				local var_252_13 = (arg_249_1.time_ - var_252_9) / var_252_12
				local var_252_14 = Vector3.New(0, -430, -55)

				var_252_8.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1037, var_252_14, var_252_13)
			end

			if arg_249_1.time_ >= var_252_9 + var_252_12 and arg_249_1.time_ < var_252_9 + var_252_12 + arg_252_0 then
				var_252_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_252_15 = 0
			local var_252_16 = 0.975

			if var_252_15 < arg_249_1.time_ and arg_249_1.time_ <= var_252_15 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_17 = arg_249_1:FormatText(StoryNameCfg[15].name)

				arg_249_1.leftNameTxt_.text = var_252_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_18 = arg_249_1:GetWordFromCfg(425061061)
				local var_252_19 = arg_249_1:FormatText(var_252_18.content)

				arg_249_1.text_.text = var_252_19

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061061", "story_v_out_425061.awb") ~= 0 then
					local var_252_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061061", "story_v_out_425061.awb") / 1000

					if var_252_23 + var_252_15 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_15
					end

					if var_252_18.prefab_name ~= "" and arg_249_1.actors_[var_252_18.prefab_name] ~= nil then
						local var_252_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_18.prefab_name].transform, "story_v_out_425061", "425061061", "story_v_out_425061.awb")

						arg_249_1:RecordAudio("425061061", var_252_24)
						arg_249_1:RecordAudio("425061061", var_252_24)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_425061", "425061061", "story_v_out_425061.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_425061", "425061061", "story_v_out_425061.awb")
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
				actorName = "1037",
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
	Play425061062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 425061062
		arg_253_1.duration_ = 11.83

		local var_253_0 = {
			zh = 8.833,
			ja = 11.833
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
				arg_253_0:Play425061063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.125

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[15].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:GetWordFromCfg(425061062)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 45
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061062", "story_v_out_425061.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_out_425061", "425061062", "story_v_out_425061.awb") / 1000

					if var_256_8 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_0
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_425061", "425061062", "story_v_out_425061.awb")

						arg_253_1:RecordAudio("425061062", var_256_9)
						arg_253_1:RecordAudio("425061062", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_425061", "425061062", "story_v_out_425061.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_425061", "425061062", "story_v_out_425061.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_10 and arg_253_1.time_ < var_256_0 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play425061063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 425061063
		arg_257_1.duration_ = 2.9

		local var_257_0 = {
			zh = 2.9,
			ja = 2.3
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
				arg_257_0:Play425061064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1066"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps1066 == nil then
				arg_257_1.var_.actorSpriteComps1066 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.034

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps1066 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								local var_260_4 = Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor1.r, var_260_3)
								local var_260_5 = Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor1.g, var_260_3)
								local var_260_6 = Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor1.b, var_260_3)

								iter_260_1.color = Color.New(var_260_4, var_260_5, var_260_6)
							else
								local var_260_7 = Mathf.Lerp(iter_260_1.color.r, 1, var_260_3)

								iter_260_1.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps1066 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1066 = nil
			end

			local var_260_8 = arg_257_1.actors_["1037"]
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps1037 == nil then
				arg_257_1.var_.actorSpriteComps1037 = var_260_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_10 = 0.034

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_10 and not isNil(var_260_8) then
				local var_260_11 = (arg_257_1.time_ - var_260_9) / var_260_10

				if arg_257_1.var_.actorSpriteComps1037 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_260_5 then
							if arg_257_1.isInRecall_ then
								local var_260_12 = Mathf.Lerp(iter_260_5.color.r, arg_257_1.hightColor2.r, var_260_11)
								local var_260_13 = Mathf.Lerp(iter_260_5.color.g, arg_257_1.hightColor2.g, var_260_11)
								local var_260_14 = Mathf.Lerp(iter_260_5.color.b, arg_257_1.hightColor2.b, var_260_11)

								iter_260_5.color = Color.New(var_260_12, var_260_13, var_260_14)
							else
								local var_260_15 = Mathf.Lerp(iter_260_5.color.r, 0.5, var_260_11)

								iter_260_5.color = Color.New(var_260_15, var_260_15, var_260_15)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_9 + var_260_10 and arg_257_1.time_ < var_260_9 + var_260_10 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps1037 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_260_7 then
						if arg_257_1.isInRecall_ then
							iter_260_7.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1037 = nil
			end

			local var_260_16 = arg_257_1.actors_["1037"].transform
			local var_260_17 = 0

			if var_260_17 < arg_257_1.time_ and arg_257_1.time_ <= var_260_17 + arg_260_0 then
				arg_257_1.var_.moveOldPos1037 = var_260_16.localPosition
				var_260_16.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1037", 2)

				local var_260_18 = var_260_16.childCount

				for iter_260_8 = 0, var_260_18 - 1 do
					local var_260_19 = var_260_16:GetChild(iter_260_8)

					if var_260_19.name == "split_1" or not string.find(var_260_19.name, "split") then
						var_260_19.gameObject:SetActive(true)
					else
						var_260_19.gameObject:SetActive(false)
					end
				end
			end

			local var_260_20 = 0.001

			if var_260_17 <= arg_257_1.time_ and arg_257_1.time_ < var_260_17 + var_260_20 then
				local var_260_21 = (arg_257_1.time_ - var_260_17) / var_260_20
				local var_260_22 = Vector3.New(-390, -430, -55)

				var_260_16.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1037, var_260_22, var_260_21)
			end

			if arg_257_1.time_ >= var_260_17 + var_260_20 and arg_257_1.time_ < var_260_17 + var_260_20 + arg_260_0 then
				var_260_16.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_260_23 = arg_257_1.actors_["1066"].transform
			local var_260_24 = 0

			if var_260_24 < arg_257_1.time_ and arg_257_1.time_ <= var_260_24 + arg_260_0 then
				arg_257_1.var_.moveOldPos1066 = var_260_23.localPosition
				var_260_23.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1066", 4)

				local var_260_25 = var_260_23.childCount

				for iter_260_9 = 0, var_260_25 - 1 do
					local var_260_26 = var_260_23:GetChild(iter_260_9)

					if var_260_26.name == "split_3" or not string.find(var_260_26.name, "split") then
						var_260_26.gameObject:SetActive(true)
					else
						var_260_26.gameObject:SetActive(false)
					end
				end
			end

			local var_260_27 = 0.001

			if var_260_24 <= arg_257_1.time_ and arg_257_1.time_ < var_260_24 + var_260_27 then
				local var_260_28 = (arg_257_1.time_ - var_260_24) / var_260_27
				local var_260_29 = Vector3.New(453.9, -399.1, -303.3)

				var_260_23.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1066, var_260_29, var_260_28)
			end

			if arg_257_1.time_ >= var_260_24 + var_260_27 and arg_257_1.time_ < var_260_24 + var_260_27 + arg_260_0 then
				var_260_23.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_260_30 = 0
			local var_260_31 = 0.275

			if var_260_30 < arg_257_1.time_ and arg_257_1.time_ <= var_260_30 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_32 = arg_257_1:FormatText(StoryNameCfg[32].name)

				arg_257_1.leftNameTxt_.text = var_260_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_33 = arg_257_1:GetWordFromCfg(425061063)
				local var_260_34 = arg_257_1:FormatText(var_260_33.content)

				arg_257_1.text_.text = var_260_34

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_35 = 11
				local var_260_36 = utf8.len(var_260_34)
				local var_260_37 = var_260_35 <= 0 and var_260_31 or var_260_31 * (var_260_36 / var_260_35)

				if var_260_37 > 0 and var_260_31 < var_260_37 then
					arg_257_1.talkMaxDuration = var_260_37

					if var_260_37 + var_260_30 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_37 + var_260_30
					end
				end

				arg_257_1.text_.text = var_260_34
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061063", "story_v_out_425061.awb") ~= 0 then
					local var_260_38 = manager.audio:GetVoiceLength("story_v_out_425061", "425061063", "story_v_out_425061.awb") / 1000

					if var_260_38 + var_260_30 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_38 + var_260_30
					end

					if var_260_33.prefab_name ~= "" and arg_257_1.actors_[var_260_33.prefab_name] ~= nil then
						local var_260_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_33.prefab_name].transform, "story_v_out_425061", "425061063", "story_v_out_425061.awb")

						arg_257_1:RecordAudio("425061063", var_260_39)
						arg_257_1:RecordAudio("425061063", var_260_39)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_425061", "425061063", "story_v_out_425061.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_425061", "425061063", "story_v_out_425061.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_40 = math.max(var_260_31, arg_257_1.talkMaxDuration)

			if var_260_30 <= arg_257_1.time_ and arg_257_1.time_ < var_260_30 + var_260_40 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_30) / var_260_40

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_30 + var_260_40 and arg_257_1.time_ < var_260_30 + var_260_40 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
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
	Play425061064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 425061064
		arg_261_1.duration_ = 1.3

		local var_261_0 = {
			zh = 1.266,
			ja = 1.3
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
				arg_261_0:Play425061065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1033"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps1033 == nil then
				arg_261_1.var_.actorSpriteComps1033 = var_264_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_2 = 0.2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.actorSpriteComps1033 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								local var_264_4 = Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor1.r, var_264_3)
								local var_264_5 = Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor1.g, var_264_3)
								local var_264_6 = Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor1.b, var_264_3)

								iter_264_1.color = Color.New(var_264_4, var_264_5, var_264_6)
							else
								local var_264_7 = Mathf.Lerp(iter_264_1.color.r, 1, var_264_3)

								iter_264_1.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps1033 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_264_3 then
						if arg_261_1.isInRecall_ then
							iter_264_3.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1033 = nil
			end

			local var_264_8 = arg_261_1.actors_["1066"]
			local var_264_9 = 0

			if var_264_9 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps1066 == nil then
				arg_261_1.var_.actorSpriteComps1066 = var_264_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_10 = 0.2

			if var_264_9 <= arg_261_1.time_ and arg_261_1.time_ < var_264_9 + var_264_10 and not isNil(var_264_8) then
				local var_264_11 = (arg_261_1.time_ - var_264_9) / var_264_10

				if arg_261_1.var_.actorSpriteComps1066 then
					for iter_264_4, iter_264_5 in pairs(arg_261_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_264_5 then
							if arg_261_1.isInRecall_ then
								local var_264_12 = Mathf.Lerp(iter_264_5.color.r, arg_261_1.hightColor2.r, var_264_11)
								local var_264_13 = Mathf.Lerp(iter_264_5.color.g, arg_261_1.hightColor2.g, var_264_11)
								local var_264_14 = Mathf.Lerp(iter_264_5.color.b, arg_261_1.hightColor2.b, var_264_11)

								iter_264_5.color = Color.New(var_264_12, var_264_13, var_264_14)
							else
								local var_264_15 = Mathf.Lerp(iter_264_5.color.r, 0.5, var_264_11)

								iter_264_5.color = Color.New(var_264_15, var_264_15, var_264_15)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_9 + var_264_10 and arg_261_1.time_ < var_264_9 + var_264_10 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.actorSpriteComps1066 then
				for iter_264_6, iter_264_7 in pairs(arg_261_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_264_7 then
						if arg_261_1.isInRecall_ then
							iter_264_7.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1066 = nil
			end

			local var_264_16 = arg_261_1.actors_["1033"].transform
			local var_264_17 = 0

			if var_264_17 < arg_261_1.time_ and arg_261_1.time_ <= var_264_17 + arg_264_0 then
				arg_261_1.var_.moveOldPos1033 = var_264_16.localPosition
				var_264_16.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1033", 2)

				local var_264_18 = var_264_16.childCount

				for iter_264_8 = 0, var_264_18 - 1 do
					local var_264_19 = var_264_16:GetChild(iter_264_8)

					if var_264_19.name == "split_6" or not string.find(var_264_19.name, "split") then
						var_264_19.gameObject:SetActive(true)
					else
						var_264_19.gameObject:SetActive(false)
					end
				end
			end

			local var_264_20 = 0.001

			if var_264_17 <= arg_261_1.time_ and arg_261_1.time_ < var_264_17 + var_264_20 then
				local var_264_21 = (arg_261_1.time_ - var_264_17) / var_264_20
				local var_264_22 = Vector3.New(-390, -420, 0)

				var_264_16.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1033, var_264_22, var_264_21)
			end

			if arg_261_1.time_ >= var_264_17 + var_264_20 and arg_261_1.time_ < var_264_17 + var_264_20 + arg_264_0 then
				var_264_16.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_264_23 = arg_261_1.actors_["1037"].transform
			local var_264_24 = 0

			if var_264_24 < arg_261_1.time_ and arg_261_1.time_ <= var_264_24 + arg_264_0 then
				arg_261_1.var_.moveOldPos1037 = var_264_23.localPosition
				var_264_23.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("1037", 7)

				local var_264_25 = var_264_23.childCount

				for iter_264_9 = 0, var_264_25 - 1 do
					local var_264_26 = var_264_23:GetChild(iter_264_9)

					if var_264_26.name == "" or not string.find(var_264_26.name, "split") then
						var_264_26.gameObject:SetActive(true)
					else
						var_264_26.gameObject:SetActive(false)
					end
				end
			end

			local var_264_27 = 0.001

			if var_264_24 <= arg_261_1.time_ and arg_261_1.time_ < var_264_24 + var_264_27 then
				local var_264_28 = (arg_261_1.time_ - var_264_24) / var_264_27
				local var_264_29 = Vector3.New(1500, -2000, 0)

				var_264_23.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1037, var_264_29, var_264_28)
			end

			if arg_261_1.time_ >= var_264_24 + var_264_27 and arg_261_1.time_ < var_264_24 + var_264_27 + arg_264_0 then
				var_264_23.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_264_30 = 0
			local var_264_31 = 0.125

			if var_264_30 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_32 = arg_261_1:FormatText(StoryNameCfg[236].name)

				arg_261_1.leftNameTxt_.text = var_264_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_33 = arg_261_1:GetWordFromCfg(425061064)
				local var_264_34 = arg_261_1:FormatText(var_264_33.content)

				arg_261_1.text_.text = var_264_34

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_35 = 5
				local var_264_36 = utf8.len(var_264_34)
				local var_264_37 = var_264_35 <= 0 and var_264_31 or var_264_31 * (var_264_36 / var_264_35)

				if var_264_37 > 0 and var_264_31 < var_264_37 then
					arg_261_1.talkMaxDuration = var_264_37

					if var_264_37 + var_264_30 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_37 + var_264_30
					end
				end

				arg_261_1.text_.text = var_264_34
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061064", "story_v_out_425061.awb") ~= 0 then
					local var_264_38 = manager.audio:GetVoiceLength("story_v_out_425061", "425061064", "story_v_out_425061.awb") / 1000

					if var_264_38 + var_264_30 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_38 + var_264_30
					end

					if var_264_33.prefab_name ~= "" and arg_261_1.actors_[var_264_33.prefab_name] ~= nil then
						local var_264_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_33.prefab_name].transform, "story_v_out_425061", "425061064", "story_v_out_425061.awb")

						arg_261_1:RecordAudio("425061064", var_264_39)
						arg_261_1:RecordAudio("425061064", var_264_39)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_425061", "425061064", "story_v_out_425061.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_425061", "425061064", "story_v_out_425061.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_40 = math.max(var_264_31, arg_261_1.talkMaxDuration)

			if var_264_30 <= arg_261_1.time_ and arg_261_1.time_ < var_264_30 + var_264_40 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_30) / var_264_40

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_30 + var_264_40 and arg_261_1.time_ < var_264_30 + var_264_40 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
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
	Play425061065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 425061065
		arg_265_1.duration_ = 12.9

		local var_265_0 = {
			zh = 8.466,
			ja = 12.9
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
				arg_265_0:Play425061066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 2

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				local var_268_1 = manager.ui.mainCamera.transform.localPosition
				local var_268_2 = Vector3.New(0, 0, 10) + Vector3.New(var_268_1.x, var_268_1.y, 0)
				local var_268_3 = arg_265_1.bgs_.ST10

				var_268_3.transform.localPosition = var_268_2
				var_268_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_4 = var_268_3:GetComponent("SpriteRenderer")

				if var_268_4 and var_268_4.sprite then
					local var_268_5 = (var_268_3.transform.localPosition - var_268_1).z
					local var_268_6 = manager.ui.mainCameraCom_
					local var_268_7 = 2 * var_268_5 * Mathf.Tan(var_268_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_268_8 = var_268_7 * var_268_6.aspect
					local var_268_9 = var_268_4.sprite.bounds.size.x
					local var_268_10 = var_268_4.sprite.bounds.size.y
					local var_268_11 = var_268_8 / var_268_9
					local var_268_12 = var_268_7 / var_268_10
					local var_268_13 = var_268_12 < var_268_11 and var_268_11 or var_268_12

					var_268_3.transform.localScale = Vector3.New(var_268_13, var_268_13, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "ST10" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_14 = 4

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			local var_268_15 = 0.3

			if arg_265_1.time_ >= var_268_14 + var_268_15 and arg_265_1.time_ < var_268_14 + var_268_15 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_17 = 2

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17
				local var_268_19 = Color.New(0, 0, 0)

				var_268_19.a = Mathf.Lerp(0, 1, var_268_18)
				arg_265_1.mask_.color = var_268_19
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 then
				local var_268_20 = Color.New(0, 0, 0)

				var_268_20.a = 1
				arg_265_1.mask_.color = var_268_20
			end

			local var_268_21 = 2

			if var_268_21 < arg_265_1.time_ and arg_265_1.time_ <= var_268_21 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_22 = 2

			if var_268_21 <= arg_265_1.time_ and arg_265_1.time_ < var_268_21 + var_268_22 then
				local var_268_23 = (arg_265_1.time_ - var_268_21) / var_268_22
				local var_268_24 = Color.New(0, 0, 0)

				var_268_24.a = Mathf.Lerp(1, 0, var_268_23)
				arg_265_1.mask_.color = var_268_24
			end

			if arg_265_1.time_ >= var_268_21 + var_268_22 and arg_265_1.time_ < var_268_21 + var_268_22 + arg_268_0 then
				local var_268_25 = Color.New(0, 0, 0)
				local var_268_26 = 0

				arg_265_1.mask_.enabled = false
				var_268_25.a = var_268_26
				arg_265_1.mask_.color = var_268_25
			end

			local var_268_27 = arg_265_1.actors_["1033"].transform
			local var_268_28 = 1.96666666666667

			if var_268_28 < arg_265_1.time_ and arg_265_1.time_ <= var_268_28 + arg_268_0 then
				arg_265_1.var_.moveOldPos1033 = var_268_27.localPosition
				var_268_27.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1033", 7)

				local var_268_29 = var_268_27.childCount

				for iter_268_2 = 0, var_268_29 - 1 do
					local var_268_30 = var_268_27:GetChild(iter_268_2)

					if var_268_30.name == "" or not string.find(var_268_30.name, "split") then
						var_268_30.gameObject:SetActive(true)
					else
						var_268_30.gameObject:SetActive(false)
					end
				end
			end

			local var_268_31 = 0.001

			if var_268_28 <= arg_265_1.time_ and arg_265_1.time_ < var_268_28 + var_268_31 then
				local var_268_32 = (arg_265_1.time_ - var_268_28) / var_268_31
				local var_268_33 = Vector3.New(0, -2000, 0)

				var_268_27.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1033, var_268_33, var_268_32)
			end

			if arg_265_1.time_ >= var_268_28 + var_268_31 and arg_265_1.time_ < var_268_28 + var_268_31 + arg_268_0 then
				var_268_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_268_34 = arg_265_1.actors_["1033"].transform
			local var_268_35 = 3.966

			if var_268_35 < arg_265_1.time_ and arg_265_1.time_ <= var_268_35 + arg_268_0 then
				arg_265_1.var_.moveOldPos1033 = var_268_34.localPosition
				var_268_34.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1033", 3)

				local var_268_36 = var_268_34.childCount

				for iter_268_3 = 0, var_268_36 - 1 do
					local var_268_37 = var_268_34:GetChild(iter_268_3)

					if var_268_37.name == "" or not string.find(var_268_37.name, "split") then
						var_268_37.gameObject:SetActive(true)
					else
						var_268_37.gameObject:SetActive(false)
					end
				end
			end

			local var_268_38 = 0.001

			if var_268_35 <= arg_265_1.time_ and arg_265_1.time_ < var_268_35 + var_268_38 then
				local var_268_39 = (arg_265_1.time_ - var_268_35) / var_268_38
				local var_268_40 = Vector3.New(0, -420, 0)

				var_268_34.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1033, var_268_40, var_268_39)
			end

			if arg_265_1.time_ >= var_268_35 + var_268_38 and arg_265_1.time_ < var_268_35 + var_268_38 + arg_268_0 then
				var_268_34.localPosition = Vector3.New(0, -420, 0)
			end

			local var_268_41 = arg_265_1.actors_["1066"].transform
			local var_268_42 = 1.96666666666667

			if var_268_42 < arg_265_1.time_ and arg_265_1.time_ <= var_268_42 + arg_268_0 then
				arg_265_1.var_.moveOldPos1066 = var_268_41.localPosition
				var_268_41.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1066", 7)

				local var_268_43 = var_268_41.childCount

				for iter_268_4 = 0, var_268_43 - 1 do
					local var_268_44 = var_268_41:GetChild(iter_268_4)

					if var_268_44.name == "" or not string.find(var_268_44.name, "split") then
						var_268_44.gameObject:SetActive(true)
					else
						var_268_44.gameObject:SetActive(false)
					end
				end
			end

			local var_268_45 = 0.001

			if var_268_42 <= arg_265_1.time_ and arg_265_1.time_ < var_268_42 + var_268_45 then
				local var_268_46 = (arg_265_1.time_ - var_268_42) / var_268_45
				local var_268_47 = Vector3.New(0, -2000, 0)

				var_268_41.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1066, var_268_47, var_268_46)
			end

			if arg_265_1.time_ >= var_268_42 + var_268_45 and arg_265_1.time_ < var_268_42 + var_268_45 + arg_268_0 then
				var_268_41.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_268_48 = arg_265_1.actors_["1033"]
			local var_268_49 = 3.8

			if var_268_49 < arg_265_1.time_ and arg_265_1.time_ <= var_268_49 + arg_268_0 and not isNil(var_268_48) and arg_265_1.var_.actorSpriteComps1033 == nil then
				arg_265_1.var_.actorSpriteComps1033 = var_268_48:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_50 = 0.2

			if var_268_49 <= arg_265_1.time_ and arg_265_1.time_ < var_268_49 + var_268_50 and not isNil(var_268_48) then
				local var_268_51 = (arg_265_1.time_ - var_268_49) / var_268_50

				if arg_265_1.var_.actorSpriteComps1033 then
					for iter_268_5, iter_268_6 in pairs(arg_265_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_268_6 then
							if arg_265_1.isInRecall_ then
								local var_268_52 = Mathf.Lerp(iter_268_6.color.r, arg_265_1.hightColor1.r, var_268_51)
								local var_268_53 = Mathf.Lerp(iter_268_6.color.g, arg_265_1.hightColor1.g, var_268_51)
								local var_268_54 = Mathf.Lerp(iter_268_6.color.b, arg_265_1.hightColor1.b, var_268_51)

								iter_268_6.color = Color.New(var_268_52, var_268_53, var_268_54)
							else
								local var_268_55 = Mathf.Lerp(iter_268_6.color.r, 1, var_268_51)

								iter_268_6.color = Color.New(var_268_55, var_268_55, var_268_55)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_49 + var_268_50 and arg_265_1.time_ < var_268_49 + var_268_50 + arg_268_0 and not isNil(var_268_48) and arg_265_1.var_.actorSpriteComps1033 then
				for iter_268_7, iter_268_8 in pairs(arg_265_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_268_8 then
						if arg_265_1.isInRecall_ then
							iter_268_8.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1033 = nil
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_56 = 4
			local var_268_57 = 0.55

			if var_268_56 < arg_265_1.time_ and arg_265_1.time_ <= var_268_56 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_58 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_58:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_59 = arg_265_1:FormatText(StoryNameCfg[236].name)

				arg_265_1.leftNameTxt_.text = var_268_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_60 = arg_265_1:GetWordFromCfg(425061065)
				local var_268_61 = arg_265_1:FormatText(var_268_60.content)

				arg_265_1.text_.text = var_268_61

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_62 = 22
				local var_268_63 = utf8.len(var_268_61)
				local var_268_64 = var_268_62 <= 0 and var_268_57 or var_268_57 * (var_268_63 / var_268_62)

				if var_268_64 > 0 and var_268_57 < var_268_64 then
					arg_265_1.talkMaxDuration = var_268_64
					var_268_56 = var_268_56 + 0.3

					if var_268_64 + var_268_56 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_64 + var_268_56
					end
				end

				arg_265_1.text_.text = var_268_61
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061065", "story_v_out_425061.awb") ~= 0 then
					local var_268_65 = manager.audio:GetVoiceLength("story_v_out_425061", "425061065", "story_v_out_425061.awb") / 1000

					if var_268_65 + var_268_56 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_65 + var_268_56
					end

					if var_268_60.prefab_name ~= "" and arg_265_1.actors_[var_268_60.prefab_name] ~= nil then
						local var_268_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_60.prefab_name].transform, "story_v_out_425061", "425061065", "story_v_out_425061.awb")

						arg_265_1:RecordAudio("425061065", var_268_66)
						arg_265_1:RecordAudio("425061065", var_268_66)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_425061", "425061065", "story_v_out_425061.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_425061", "425061065", "story_v_out_425061.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_67 = var_268_56 + 0.3
			local var_268_68 = math.max(var_268_57, arg_265_1.talkMaxDuration)

			if var_268_67 <= arg_265_1.time_ and arg_265_1.time_ < var_268_67 + var_268_68 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_67) / var_268_68

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_67 + var_268_68 and arg_265_1.time_ < var_268_67 + var_268_68 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play425061066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 425061066
		arg_271_1.duration_ = 4.8

		local var_271_0 = {
			zh = 4.8,
			ja = 4.266
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
				arg_271_0:Play425061067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1066"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1066 == nil then
				arg_271_1.var_.actorSpriteComps1066 = var_274_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.actorSpriteComps1066 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.actorSpriteComps1066 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_274_3 then
						if arg_271_1.isInRecall_ then
							iter_274_3.color = arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_274_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1066 = nil
			end

			local var_274_8 = arg_271_1.actors_["1033"]
			local var_274_9 = 0

			if var_274_9 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps1033 == nil then
				arg_271_1.var_.actorSpriteComps1033 = var_274_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_10 = 0.2

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_10 and not isNil(var_274_8) then
				local var_274_11 = (arg_271_1.time_ - var_274_9) / var_274_10

				if arg_271_1.var_.actorSpriteComps1033 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_271_1.time_ >= var_274_9 + var_274_10 and arg_271_1.time_ < var_274_9 + var_274_10 + arg_274_0 and not isNil(var_274_8) and arg_271_1.var_.actorSpriteComps1033 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_274_7 then
						if arg_271_1.isInRecall_ then
							iter_274_7.color = arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_274_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_271_1.var_.actorSpriteComps1033 = nil
			end

			local var_274_16 = arg_271_1.actors_["1066"].transform
			local var_274_17 = 0

			if var_274_17 < arg_271_1.time_ and arg_271_1.time_ <= var_274_17 + arg_274_0 then
				arg_271_1.var_.moveOldPos1066 = var_274_16.localPosition
				var_274_16.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1066", 4)

				local var_274_18 = var_274_16.childCount

				for iter_274_8 = 0, var_274_18 - 1 do
					local var_274_19 = var_274_16:GetChild(iter_274_8)

					if var_274_19.name == "" or not string.find(var_274_19.name, "split") then
						var_274_19.gameObject:SetActive(true)
					else
						var_274_19.gameObject:SetActive(false)
					end
				end
			end

			local var_274_20 = 0.001

			if var_274_17 <= arg_271_1.time_ and arg_271_1.time_ < var_274_17 + var_274_20 then
				local var_274_21 = (arg_271_1.time_ - var_274_17) / var_274_20
				local var_274_22 = Vector3.New(453.9, -399.1, -303.3)

				var_274_16.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1066, var_274_22, var_274_21)
			end

			if arg_271_1.time_ >= var_274_17 + var_274_20 and arg_271_1.time_ < var_274_17 + var_274_20 + arg_274_0 then
				var_274_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_274_23 = arg_271_1.actors_["1033"].transform
			local var_274_24 = 0

			if var_274_24 < arg_271_1.time_ and arg_271_1.time_ <= var_274_24 + arg_274_0 then
				arg_271_1.var_.moveOldPos1033 = var_274_23.localPosition
				var_274_23.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1033", 2)

				local var_274_25 = var_274_23.childCount

				for iter_274_9 = 0, var_274_25 - 1 do
					local var_274_26 = var_274_23:GetChild(iter_274_9)

					if var_274_26.name == "" or not string.find(var_274_26.name, "split") then
						var_274_26.gameObject:SetActive(true)
					else
						var_274_26.gameObject:SetActive(false)
					end
				end
			end

			local var_274_27 = 0.001

			if var_274_24 <= arg_271_1.time_ and arg_271_1.time_ < var_274_24 + var_274_27 then
				local var_274_28 = (arg_271_1.time_ - var_274_24) / var_274_27
				local var_274_29 = Vector3.New(-390, -420, 0)

				var_274_23.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1033, var_274_29, var_274_28)
			end

			if arg_271_1.time_ >= var_274_24 + var_274_27 and arg_271_1.time_ < var_274_24 + var_274_27 + arg_274_0 then
				var_274_23.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_274_30 = 0
			local var_274_31 = 0.575

			if var_274_30 < arg_271_1.time_ and arg_271_1.time_ <= var_274_30 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_32 = arg_271_1:FormatText(StoryNameCfg[32].name)

				arg_271_1.leftNameTxt_.text = var_274_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_33 = arg_271_1:GetWordFromCfg(425061066)
				local var_274_34 = arg_271_1:FormatText(var_274_33.content)

				arg_271_1.text_.text = var_274_34

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_35 = 23
				local var_274_36 = utf8.len(var_274_34)
				local var_274_37 = var_274_35 <= 0 and var_274_31 or var_274_31 * (var_274_36 / var_274_35)

				if var_274_37 > 0 and var_274_31 < var_274_37 then
					arg_271_1.talkMaxDuration = var_274_37

					if var_274_37 + var_274_30 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_37 + var_274_30
					end
				end

				arg_271_1.text_.text = var_274_34
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061066", "story_v_out_425061.awb") ~= 0 then
					local var_274_38 = manager.audio:GetVoiceLength("story_v_out_425061", "425061066", "story_v_out_425061.awb") / 1000

					if var_274_38 + var_274_30 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_38 + var_274_30
					end

					if var_274_33.prefab_name ~= "" and arg_271_1.actors_[var_274_33.prefab_name] ~= nil then
						local var_274_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_33.prefab_name].transform, "story_v_out_425061", "425061066", "story_v_out_425061.awb")

						arg_271_1:RecordAudio("425061066", var_274_39)
						arg_271_1:RecordAudio("425061066", var_274_39)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_425061", "425061066", "story_v_out_425061.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_425061", "425061066", "story_v_out_425061.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_40 = math.max(var_274_31, arg_271_1.talkMaxDuration)

			if var_274_30 <= arg_271_1.time_ and arg_271_1.time_ < var_274_30 + var_274_40 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_30) / var_274_40

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_30 + var_274_40 and arg_271_1.time_ < var_274_30 + var_274_40 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 425061067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play425061068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1066"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1066 == nil then
				arg_275_1.var_.actorSpriteComps1066 = var_278_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_2 = 0.2

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.actorSpriteComps1066 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.actorSpriteComps1066 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_278_3 then
						if arg_275_1.isInRecall_ then
							iter_278_3.color = arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_278_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_275_1.var_.actorSpriteComps1066 = nil
			end

			local var_278_8 = 0
			local var_278_9 = 1.225

			if var_278_8 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_10 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_11 = arg_275_1:GetWordFromCfg(425061067)
				local var_278_12 = arg_275_1:FormatText(var_278_11.content)

				arg_275_1.text_.text = var_278_12

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 49
				local var_278_14 = utf8.len(var_278_12)
				local var_278_15 = var_278_13 <= 0 and var_278_9 or var_278_9 * (var_278_14 / var_278_13)

				if var_278_15 > 0 and var_278_9 < var_278_15 then
					arg_275_1.talkMaxDuration = var_278_15

					if var_278_15 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_15 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_12
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_16 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_16 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_16

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_16 and arg_275_1.time_ < var_278_8 + var_278_16 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play425061068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 425061068
		arg_279_1.duration_ = 4.5

		local var_279_0 = {
			zh = 3.4,
			ja = 4.5
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
				arg_279_0:Play425061069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1033"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1033 == nil then
				arg_279_1.var_.actorSpriteComps1033 = var_282_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.actorSpriteComps1033 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.actorSpriteComps1033 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_282_3 then
						if arg_279_1.isInRecall_ then
							iter_282_3.color = arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_282_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_279_1.var_.actorSpriteComps1033 = nil
			end

			local var_282_8 = arg_279_1.actors_["1033"].transform
			local var_282_9 = 0

			if var_282_9 < arg_279_1.time_ and arg_279_1.time_ <= var_282_9 + arg_282_0 then
				arg_279_1.var_.moveOldPos1033 = var_282_8.localPosition
				var_282_8.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("1033", 2)

				local var_282_10 = var_282_8.childCount

				for iter_282_4 = 0, var_282_10 - 1 do
					local var_282_11 = var_282_8:GetChild(iter_282_4)

					if var_282_11.name == "" or not string.find(var_282_11.name, "split") then
						var_282_11.gameObject:SetActive(true)
					else
						var_282_11.gameObject:SetActive(false)
					end
				end
			end

			local var_282_12 = 0.001

			if var_282_9 <= arg_279_1.time_ and arg_279_1.time_ < var_282_9 + var_282_12 then
				local var_282_13 = (arg_279_1.time_ - var_282_9) / var_282_12
				local var_282_14 = Vector3.New(-390, -420, 0)

				var_282_8.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1033, var_282_14, var_282_13)
			end

			if arg_279_1.time_ >= var_282_9 + var_282_12 and arg_279_1.time_ < var_282_9 + var_282_12 + arg_282_0 then
				var_282_8.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_282_15 = 0
			local var_282_16 = 0.425

			if var_282_15 < arg_279_1.time_ and arg_279_1.time_ <= var_282_15 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_17 = arg_279_1:FormatText(StoryNameCfg[236].name)

				arg_279_1.leftNameTxt_.text = var_282_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_18 = arg_279_1:GetWordFromCfg(425061068)
				local var_282_19 = arg_279_1:FormatText(var_282_18.content)

				arg_279_1.text_.text = var_282_19

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_20 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061068", "story_v_out_425061.awb") ~= 0 then
					local var_282_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061068", "story_v_out_425061.awb") / 1000

					if var_282_23 + var_282_15 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_15
					end

					if var_282_18.prefab_name ~= "" and arg_279_1.actors_[var_282_18.prefab_name] ~= nil then
						local var_282_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_18.prefab_name].transform, "story_v_out_425061", "425061068", "story_v_out_425061.awb")

						arg_279_1:RecordAudio("425061068", var_282_24)
						arg_279_1:RecordAudio("425061068", var_282_24)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_425061", "425061068", "story_v_out_425061.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_425061", "425061068", "story_v_out_425061.awb")
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
				actorName = "1033",
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
	Play425061069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 425061069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play425061070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1033"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1033 == nil then
				arg_283_1.var_.actorSpriteComps1033 = var_286_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.actorSpriteComps1033 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								local var_286_4 = Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor2.r, var_286_3)
								local var_286_5 = Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor2.g, var_286_3)
								local var_286_6 = Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor2.b, var_286_3)

								iter_286_1.color = Color.New(var_286_4, var_286_5, var_286_6)
							else
								local var_286_7 = Mathf.Lerp(iter_286_1.color.r, 0.5, var_286_3)

								iter_286_1.color = Color.New(var_286_7, var_286_7, var_286_7)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.actorSpriteComps1033 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_286_3 then
						if arg_283_1.isInRecall_ then
							iter_286_3.color = arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_286_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_283_1.var_.actorSpriteComps1033 = nil
			end

			local var_286_8 = 0
			local var_286_9 = 0.475

			if var_286_8 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_10 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_11 = arg_283_1:GetWordFromCfg(425061069)
				local var_286_12 = arg_283_1:FormatText(var_286_11.content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 19
				local var_286_14 = utf8.len(var_286_12)
				local var_286_15 = var_286_13 <= 0 and var_286_9 or var_286_9 * (var_286_14 / var_286_13)

				if var_286_15 > 0 and var_286_9 < var_286_15 then
					arg_283_1.talkMaxDuration = var_286_15

					if var_286_15 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_15 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_16 and arg_283_1.time_ < var_286_8 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play425061070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 425061070
		arg_287_1.duration_ = 2.27

		local var_287_0 = {
			zh = 2.266,
			ja = 1.7
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
				arg_287_0:Play425061071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1033"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1033 == nil then
				arg_287_1.var_.actorSpriteComps1033 = var_290_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_2 = 0.2

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.actorSpriteComps1033 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.actorSpriteComps1033 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_290_3 then
						if arg_287_1.isInRecall_ then
							iter_290_3.color = arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_290_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_287_1.var_.actorSpriteComps1033 = nil
			end

			local var_290_8 = arg_287_1.actors_["1033"].transform
			local var_290_9 = 0

			if var_290_9 < arg_287_1.time_ and arg_287_1.time_ <= var_290_9 + arg_290_0 then
				arg_287_1.var_.moveOldPos1033 = var_290_8.localPosition
				var_290_8.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("1033", 2)

				local var_290_10 = var_290_8.childCount

				for iter_290_4 = 0, var_290_10 - 1 do
					local var_290_11 = var_290_8:GetChild(iter_290_4)

					if var_290_11.name == "split_4" or not string.find(var_290_11.name, "split") then
						var_290_11.gameObject:SetActive(true)
					else
						var_290_11.gameObject:SetActive(false)
					end
				end
			end

			local var_290_12 = 0.001

			if var_290_9 <= arg_287_1.time_ and arg_287_1.time_ < var_290_9 + var_290_12 then
				local var_290_13 = (arg_287_1.time_ - var_290_9) / var_290_12
				local var_290_14 = Vector3.New(-390, -420, 0)

				var_290_8.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1033, var_290_14, var_290_13)
			end

			if arg_287_1.time_ >= var_290_9 + var_290_12 and arg_287_1.time_ < var_290_9 + var_290_12 + arg_290_0 then
				var_290_8.localPosition = Vector3.New(-390, -420, 0)
			end

			local var_290_15 = 0
			local var_290_16 = 0.175

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_17 = arg_287_1:FormatText(StoryNameCfg[236].name)

				arg_287_1.leftNameTxt_.text = var_290_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_18 = arg_287_1:GetWordFromCfg(425061070)
				local var_290_19 = arg_287_1:FormatText(var_290_18.content)

				arg_287_1.text_.text = var_290_19

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_20 = 7
				local var_290_21 = utf8.len(var_290_19)
				local var_290_22 = var_290_20 <= 0 and var_290_16 or var_290_16 * (var_290_21 / var_290_20)

				if var_290_22 > 0 and var_290_16 < var_290_22 then
					arg_287_1.talkMaxDuration = var_290_22

					if var_290_22 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_22 + var_290_15
					end
				end

				arg_287_1.text_.text = var_290_19
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061070", "story_v_out_425061.awb") ~= 0 then
					local var_290_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061070", "story_v_out_425061.awb") / 1000

					if var_290_23 + var_290_15 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_23 + var_290_15
					end

					if var_290_18.prefab_name ~= "" and arg_287_1.actors_[var_290_18.prefab_name] ~= nil then
						local var_290_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_18.prefab_name].transform, "story_v_out_425061", "425061070", "story_v_out_425061.awb")

						arg_287_1:RecordAudio("425061070", var_290_24)
						arg_287_1:RecordAudio("425061070", var_290_24)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_425061", "425061070", "story_v_out_425061.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_425061", "425061070", "story_v_out_425061.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_25 = math.max(var_290_16, arg_287_1.talkMaxDuration)

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_25 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_15) / var_290_25

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_15 + var_290_25 and arg_287_1.time_ < var_290_15 + var_290_25 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
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
	Play425061071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 425061071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play425061072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1033"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1033 == nil then
				arg_291_1.var_.actorSpriteComps1033 = var_294_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_2 = 0.2

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.actorSpriteComps1033 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								local var_294_4 = Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, var_294_3)
								local var_294_5 = Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, var_294_3)
								local var_294_6 = Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, var_294_3)

								iter_294_1.color = Color.New(var_294_4, var_294_5, var_294_6)
							else
								local var_294_7 = Mathf.Lerp(iter_294_1.color.r, 0.5, var_294_3)

								iter_294_1.color = Color.New(var_294_7, var_294_7, var_294_7)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.actorSpriteComps1033 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_294_3 then
						if arg_291_1.isInRecall_ then
							iter_294_3.color = arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_294_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_291_1.var_.actorSpriteComps1033 = nil
			end

			local var_294_8 = 0
			local var_294_9 = 0.75

			if var_294_8 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_10 = arg_291_1:FormatText(StoryNameCfg[7].name)

				arg_291_1.leftNameTxt_.text = var_294_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_11 = arg_291_1:GetWordFromCfg(425061071)
				local var_294_12 = arg_291_1:FormatText(var_294_11.content)

				arg_291_1.text_.text = var_294_12

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_13 = 30
				local var_294_14 = utf8.len(var_294_12)
				local var_294_15 = var_294_13 <= 0 and var_294_9 or var_294_9 * (var_294_14 / var_294_13)

				if var_294_15 > 0 and var_294_9 < var_294_15 then
					arg_291_1.talkMaxDuration = var_294_15

					if var_294_15 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_15 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_12
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_16 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_16 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_16

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_16 and arg_291_1.time_ < var_294_8 + var_294_16 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play425061072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 425061072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play425061073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.625

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[7].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(425061072)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 25
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_8 and arg_295_1.time_ < var_298_0 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play425061073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 425061073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play425061074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.9

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[7].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:GetWordFromCfg(425061073)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 36
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_8 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_8 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_8

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_8 and arg_299_1.time_ < var_302_0 + var_302_8 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play425061074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 425061074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play425061075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1033"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos1033 = var_306_0.localPosition
				var_306_0.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1033", 7)

				local var_306_2 = var_306_0.childCount

				for iter_306_0 = 0, var_306_2 - 1 do
					local var_306_3 = var_306_0:GetChild(iter_306_0)

					if var_306_3.name == "" or not string.find(var_306_3.name, "split") then
						var_306_3.gameObject:SetActive(true)
					else
						var_306_3.gameObject:SetActive(false)
					end
				end
			end

			local var_306_4 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_4 then
				local var_306_5 = (arg_303_1.time_ - var_306_1) / var_306_4
				local var_306_6 = Vector3.New(0, -2000, 0)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1033, var_306_6, var_306_5)
			end

			if arg_303_1.time_ >= var_306_1 + var_306_4 and arg_303_1.time_ < var_306_1 + var_306_4 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_7 = arg_303_1.actors_["1066"].transform
			local var_306_8 = 0

			if var_306_8 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.var_.moveOldPos1066 = var_306_7.localPosition
				var_306_7.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1066", 7)

				local var_306_9 = var_306_7.childCount

				for iter_306_1 = 0, var_306_9 - 1 do
					local var_306_10 = var_306_7:GetChild(iter_306_1)

					if var_306_10.name == "" or not string.find(var_306_10.name, "split") then
						var_306_10.gameObject:SetActive(true)
					else
						var_306_10.gameObject:SetActive(false)
					end
				end
			end

			local var_306_11 = 0.001

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_11 then
				local var_306_12 = (arg_303_1.time_ - var_306_8) / var_306_11
				local var_306_13 = Vector3.New(0, -2000, 0)

				var_306_7.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1066, var_306_13, var_306_12)
			end

			if arg_303_1.time_ >= var_306_8 + var_306_11 and arg_303_1.time_ < var_306_8 + var_306_11 + arg_306_0 then
				var_306_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_14 = 0
			local var_306_15 = 1.1

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_16 = arg_303_1:GetWordFromCfg(425061074)
				local var_306_17 = arg_303_1:FormatText(var_306_16.content)

				arg_303_1.text_.text = var_306_17

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_18 = 44
				local var_306_19 = utf8.len(var_306_17)
				local var_306_20 = var_306_18 <= 0 and var_306_15 or var_306_15 * (var_306_19 / var_306_18)

				if var_306_20 > 0 and var_306_15 < var_306_20 then
					arg_303_1.talkMaxDuration = var_306_20

					if var_306_20 + var_306_14 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_20 + var_306_14
					end
				end

				arg_303_1.text_.text = var_306_17
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_21 = math.max(var_306_15, arg_303_1.talkMaxDuration)

			if var_306_14 <= arg_303_1.time_ and arg_303_1.time_ < var_306_14 + var_306_21 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_14) / var_306_21

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_14 + var_306_21 and arg_303_1.time_ < var_306_14 + var_306_21 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1066",
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
	Play425061075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 425061075
		arg_307_1.duration_ = 18.3

		local var_307_0 = {
			zh = 11.666,
			ja = 18.3
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
				arg_307_0:Play425061076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = "ST13"

			if arg_307_1.bgs_[var_310_0] == nil then
				local var_310_1 = Object.Instantiate(arg_307_1.paintGo_)

				var_310_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_310_0)
				var_310_1.name = var_310_0
				var_310_1.transform.parent = arg_307_1.stage_.transform
				var_310_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.bgs_[var_310_0] = var_310_1
			end

			local var_310_2 = 1

			if var_310_2 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				local var_310_3 = manager.ui.mainCamera.transform.localPosition
				local var_310_4 = Vector3.New(0, 0, 10) + Vector3.New(var_310_3.x, var_310_3.y, 0)
				local var_310_5 = arg_307_1.bgs_.ST13

				var_310_5.transform.localPosition = var_310_4
				var_310_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_310_6 = var_310_5:GetComponent("SpriteRenderer")

				if var_310_6 and var_310_6.sprite then
					local var_310_7 = (var_310_5.transform.localPosition - var_310_3).z
					local var_310_8 = manager.ui.mainCameraCom_
					local var_310_9 = 2 * var_310_7 * Mathf.Tan(var_310_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_310_10 = var_310_9 * var_310_8.aspect
					local var_310_11 = var_310_6.sprite.bounds.size.x
					local var_310_12 = var_310_6.sprite.bounds.size.y
					local var_310_13 = var_310_10 / var_310_11
					local var_310_14 = var_310_9 / var_310_12
					local var_310_15 = var_310_14 < var_310_13 and var_310_13 or var_310_14

					var_310_5.transform.localScale = Vector3.New(var_310_15, var_310_15, 0)
				end

				for iter_310_0, iter_310_1 in pairs(arg_307_1.bgs_) do
					if iter_310_0 ~= "ST13" then
						iter_310_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_310_16 = 2.7

			if var_310_16 < arg_307_1.time_ and arg_307_1.time_ <= var_310_16 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			local var_310_17 = 0.3

			if arg_307_1.time_ >= var_310_16 + var_310_17 and arg_307_1.time_ < var_310_16 + var_310_17 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_18 = 0

			if var_310_18 < arg_307_1.time_ and arg_307_1.time_ <= var_310_18 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_19 = 1

			if var_310_18 <= arg_307_1.time_ and arg_307_1.time_ < var_310_18 + var_310_19 then
				local var_310_20 = (arg_307_1.time_ - var_310_18) / var_310_19
				local var_310_21 = Color.New(0, 0, 0)

				var_310_21.a = Mathf.Lerp(0, 1, var_310_20)
				arg_307_1.mask_.color = var_310_21
			end

			if arg_307_1.time_ >= var_310_18 + var_310_19 and arg_307_1.time_ < var_310_18 + var_310_19 + arg_310_0 then
				local var_310_22 = Color.New(0, 0, 0)

				var_310_22.a = 1
				arg_307_1.mask_.color = var_310_22
			end

			local var_310_23 = 1

			if var_310_23 < arg_307_1.time_ and arg_307_1.time_ <= var_310_23 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_24 = 2

			if var_310_23 <= arg_307_1.time_ and arg_307_1.time_ < var_310_23 + var_310_24 then
				local var_310_25 = (arg_307_1.time_ - var_310_23) / var_310_24
				local var_310_26 = Color.New(0, 0, 0)

				var_310_26.a = Mathf.Lerp(1, 0, var_310_25)
				arg_307_1.mask_.color = var_310_26
			end

			if arg_307_1.time_ >= var_310_23 + var_310_24 and arg_307_1.time_ < var_310_23 + var_310_24 + arg_310_0 then
				local var_310_27 = Color.New(0, 0, 0)
				local var_310_28 = 0

				arg_307_1.mask_.enabled = false
				var_310_27.a = var_310_28
				arg_307_1.mask_.color = var_310_27
			end

			local var_310_29 = arg_307_1.actors_["1033"]
			local var_310_30 = 2.7

			if var_310_30 < arg_307_1.time_ and arg_307_1.time_ <= var_310_30 + arg_310_0 and not isNil(var_310_29) and arg_307_1.var_.actorSpriteComps1033 == nil then
				arg_307_1.var_.actorSpriteComps1033 = var_310_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_31 = 0.2

			if var_310_30 <= arg_307_1.time_ and arg_307_1.time_ < var_310_30 + var_310_31 and not isNil(var_310_29) then
				local var_310_32 = (arg_307_1.time_ - var_310_30) / var_310_31

				if arg_307_1.var_.actorSpriteComps1033 then
					for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_310_3 then
							if arg_307_1.isInRecall_ then
								local var_310_33 = Mathf.Lerp(iter_310_3.color.r, arg_307_1.hightColor1.r, var_310_32)
								local var_310_34 = Mathf.Lerp(iter_310_3.color.g, arg_307_1.hightColor1.g, var_310_32)
								local var_310_35 = Mathf.Lerp(iter_310_3.color.b, arg_307_1.hightColor1.b, var_310_32)

								iter_310_3.color = Color.New(var_310_33, var_310_34, var_310_35)
							else
								local var_310_36 = Mathf.Lerp(iter_310_3.color.r, 1, var_310_32)

								iter_310_3.color = Color.New(var_310_36, var_310_36, var_310_36)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= var_310_30 + var_310_31 and arg_307_1.time_ < var_310_30 + var_310_31 + arg_310_0 and not isNil(var_310_29) and arg_307_1.var_.actorSpriteComps1033 then
				for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_310_5 then
						if arg_307_1.isInRecall_ then
							iter_310_5.color = arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_310_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_307_1.var_.actorSpriteComps1033 = nil
			end

			local var_310_37 = arg_307_1.actors_["1033"].transform
			local var_310_38 = 2.7

			if var_310_38 < arg_307_1.time_ and arg_307_1.time_ <= var_310_38 + arg_310_0 then
				arg_307_1.var_.moveOldPos1033 = var_310_37.localPosition
				var_310_37.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1033", 3)

				local var_310_39 = var_310_37.childCount

				for iter_310_6 = 0, var_310_39 - 1 do
					local var_310_40 = var_310_37:GetChild(iter_310_6)

					if var_310_40.name == "" or not string.find(var_310_40.name, "split") then
						var_310_40.gameObject:SetActive(true)
					else
						var_310_40.gameObject:SetActive(false)
					end
				end
			end

			local var_310_41 = 0.001

			if var_310_38 <= arg_307_1.time_ and arg_307_1.time_ < var_310_38 + var_310_41 then
				local var_310_42 = (arg_307_1.time_ - var_310_38) / var_310_41
				local var_310_43 = Vector3.New(0, -420, 0)

				var_310_37.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1033, var_310_43, var_310_42)
			end

			if arg_307_1.time_ >= var_310_38 + var_310_41 and arg_307_1.time_ < var_310_38 + var_310_41 + arg_310_0 then
				var_310_37.localPosition = Vector3.New(0, -420, 0)
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_44 = 3
			local var_310_45 = 0.925

			if var_310_44 < arg_307_1.time_ and arg_307_1.time_ <= var_310_44 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_46 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_46:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_47 = arg_307_1:FormatText(StoryNameCfg[236].name)

				arg_307_1.leftNameTxt_.text = var_310_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_48 = arg_307_1:GetWordFromCfg(425061075)
				local var_310_49 = arg_307_1:FormatText(var_310_48.content)

				arg_307_1.text_.text = var_310_49

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_50 = 37
				local var_310_51 = utf8.len(var_310_49)
				local var_310_52 = var_310_50 <= 0 and var_310_45 or var_310_45 * (var_310_51 / var_310_50)

				if var_310_52 > 0 and var_310_45 < var_310_52 then
					arg_307_1.talkMaxDuration = var_310_52
					var_310_44 = var_310_44 + 0.3

					if var_310_52 + var_310_44 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_52 + var_310_44
					end
				end

				arg_307_1.text_.text = var_310_49
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061075", "story_v_out_425061.awb") ~= 0 then
					local var_310_53 = manager.audio:GetVoiceLength("story_v_out_425061", "425061075", "story_v_out_425061.awb") / 1000

					if var_310_53 + var_310_44 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_53 + var_310_44
					end

					if var_310_48.prefab_name ~= "" and arg_307_1.actors_[var_310_48.prefab_name] ~= nil then
						local var_310_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_48.prefab_name].transform, "story_v_out_425061", "425061075", "story_v_out_425061.awb")

						arg_307_1:RecordAudio("425061075", var_310_54)
						arg_307_1:RecordAudio("425061075", var_310_54)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_425061", "425061075", "story_v_out_425061.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_425061", "425061075", "story_v_out_425061.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_55 = var_310_44 + 0.3
			local var_310_56 = math.max(var_310_45, arg_307_1.talkMaxDuration)

			if var_310_55 <= arg_307_1.time_ and arg_307_1.time_ < var_310_55 + var_310_56 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_55) / var_310_56

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_55 + var_310_56 and arg_307_1.time_ < var_310_55 + var_310_56 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play425061076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 425061076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play425061077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1033"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps1033 == nil then
				arg_313_1.var_.actorSpriteComps1033 = var_316_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_2 = 0.2

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.actorSpriteComps1033 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								local var_316_4 = Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor2.r, var_316_3)
								local var_316_5 = Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor2.g, var_316_3)
								local var_316_6 = Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor2.b, var_316_3)

								iter_316_1.color = Color.New(var_316_4, var_316_5, var_316_6)
							else
								local var_316_7 = Mathf.Lerp(iter_316_1.color.r, 0.5, var_316_3)

								iter_316_1.color = Color.New(var_316_7, var_316_7, var_316_7)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps1033 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_316_3 then
						if arg_313_1.isInRecall_ then
							iter_316_3.color = arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_316_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps1033 = nil
			end

			local var_316_8 = 0
			local var_316_9 = 0.25

			if var_316_8 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_10 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_11 = arg_313_1:GetWordFromCfg(425061076)
				local var_316_12 = arg_313_1:FormatText(var_316_11.content)

				arg_313_1.text_.text = var_316_12

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 10
				local var_316_14 = utf8.len(var_316_12)
				local var_316_15 = var_316_13 <= 0 and var_316_9 or var_316_9 * (var_316_14 / var_316_13)

				if var_316_15 > 0 and var_316_9 < var_316_15 then
					arg_313_1.talkMaxDuration = var_316_15

					if var_316_15 + var_316_8 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_15 + var_316_8
					end
				end

				arg_313_1.text_.text = var_316_12
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_9, arg_313_1.talkMaxDuration)

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_8) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_8 + var_316_16 and arg_313_1.time_ < var_316_8 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play425061077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 425061077
		arg_317_1.duration_ = 7.6

		local var_317_0 = {
			zh = 5.233,
			ja = 7.6
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
			arg_317_1.auto_ = false
		end

		function arg_317_1.playNext_(arg_319_0)
			arg_317_1.onStoryFinished_()
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1033"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps1033 == nil then
				arg_317_1.var_.actorSpriteComps1033 = var_320_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_2 = 0.2

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.actorSpriteComps1033 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps1033:ToTable()) do
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

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.actorSpriteComps1033 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_320_3 then
						if arg_317_1.isInRecall_ then
							iter_320_3.color = arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_320_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_317_1.var_.actorSpriteComps1033 = nil
			end

			local var_320_8 = arg_317_1.actors_["1033"].transform
			local var_320_9 = 0

			if var_320_9 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 then
				arg_317_1.var_.moveOldPos1033 = var_320_8.localPosition
				var_320_8.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("1033", 3)

				local var_320_10 = var_320_8.childCount

				for iter_320_4 = 0, var_320_10 - 1 do
					local var_320_11 = var_320_8:GetChild(iter_320_4)

					if var_320_11.name == "split_6" then
						var_320_11:SetAsLastSibling()
						var_320_11.gameObject:SetActive(true)

						arg_317_1.var_.actorSpriteSplit1033 = var_320_11.gameObject:GetComponent(typeof(Image))

						arg_317_1.var_.actorSpriteSplit1033:SetAlpha(0)
					end
				end
			end

			local var_320_12 = 0.2

			if var_320_9 <= arg_317_1.time_ and arg_317_1.time_ < var_320_9 + var_320_12 then
				local var_320_13 = (arg_317_1.time_ - var_320_9) / var_320_12
				local var_320_14 = Vector3.New(0, -420, 0)

				var_320_8.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1033, var_320_14, var_320_13)

				if arg_317_1.var_.actorSpriteSplit1033 ~= nil then
					arg_317_1.var_.actorSpriteSplit1033:SetAlpha(var_320_13)
				end
			end

			if arg_317_1.time_ >= var_320_9 + var_320_12 and arg_317_1.time_ < var_320_9 + var_320_12 + arg_320_0 then
				var_320_8.localPosition = Vector3.New(0, -420, 0)

				if arg_317_1.var_.actorSpriteSplit1033 ~= nil then
					arg_317_1.var_.actorSpriteSplit1033:SetAlpha(1)
				end
			end

			local var_320_15 = 0
			local var_320_16 = 0.575

			if var_320_15 < arg_317_1.time_ and arg_317_1.time_ <= var_320_15 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_17 = arg_317_1:FormatText(StoryNameCfg[236].name)

				arg_317_1.leftNameTxt_.text = var_320_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_18 = arg_317_1:GetWordFromCfg(425061077)
				local var_320_19 = arg_317_1:FormatText(var_320_18.content)

				arg_317_1.text_.text = var_320_19

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_20 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_425061", "425061077", "story_v_out_425061.awb") ~= 0 then
					local var_320_23 = manager.audio:GetVoiceLength("story_v_out_425061", "425061077", "story_v_out_425061.awb") / 1000

					if var_320_23 + var_320_15 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_23 + var_320_15
					end

					if var_320_18.prefab_name ~= "" and arg_317_1.actors_[var_320_18.prefab_name] ~= nil then
						local var_320_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_18.prefab_name].transform, "story_v_out_425061", "425061077", "story_v_out_425061.awb")

						arg_317_1:RecordAudio("425061077", var_320_24)
						arg_317_1:RecordAudio("425061077", var_320_24)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_425061", "425061077", "story_v_out_425061.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_425061", "425061077", "story_v_out_425061.awb")
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
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/ST13"
	},
	voices = {
		"story_v_out_425061.awb"
	}
}
