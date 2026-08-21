return {
	Play425081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425081001
		arg_1_1.duration_ = 9.77

		local var_1_0 = {
			zh = 8.16666666666667,
			ja = 9.76666666666667
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
				arg_1_0:Play425081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1.999999999999
			local var_4_2 = "ST0404"

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_3 = arg_1_1:GetWordFromCfg(501110)
				local var_4_4 = arg_1_1:FormatText(var_4_3.content)

				arg_1_1.text_timeText_.text = var_4_4

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_5 = arg_1_1:GetWordFromCfg(501111)
				local var_4_6 = arg_1_1:FormatText(var_4_5.content)

				arg_1_1.text_siteText_.text = var_4_6

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_7 = 2.00000033333333

			if var_4_7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_8 = 1.2

			if var_4_7 <= arg_1_1.time_ and arg_1_1.time_ < var_4_7 + var_4_8 then
				local var_4_9 = (arg_1_1.time_ - var_4_7) / var_4_8
				local var_4_10 = Color.New(0, 0, 0)

				var_4_10.a = Mathf.Lerp(0, 1, var_4_9)
				arg_1_1.mask_.color = var_4_10
			end

			if arg_1_1.time_ >= var_4_7 + var_4_8 and arg_1_1.time_ < var_4_7 + var_4_8 + arg_4_0 then
				local var_4_11 = Color.New(0, 0, 0)

				var_4_11.a = 1
				arg_1_1.mask_.color = var_4_11
			end

			local var_4_12 = 3.20000033333333

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_13 = 1.2

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13
				local var_4_15 = Color.New(0, 0, 0)

				var_4_15.a = Mathf.Lerp(1, 0, var_4_14)
				arg_1_1.mask_.color = var_4_15
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 then
				local var_4_16 = Color.New(0, 0, 0)
				local var_4_17 = 0

				arg_1_1.mask_.enabled = false
				var_4_16.a = var_4_17
				arg_1_1.mask_.color = var_4_16
			end

			local var_4_18 = "ST0404"

			if arg_1_1.bgs_[var_4_18] == nil then
				local var_4_19 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_18)
				var_4_19.name = var_4_18
				var_4_19.transform.parent = arg_1_1.stage_.transform
				var_4_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_18] = var_4_19
			end

			local var_4_20 = 0

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				local var_4_21 = manager.ui.mainCamera.transform.localPosition
				local var_4_22 = Vector3.New(0, 0, 10) + Vector3.New(var_4_21.x, var_4_21.y, 0)
				local var_4_23 = arg_1_1.bgs_.ST0404

				var_4_23.transform.localPosition = var_4_22
				var_4_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_24 = var_4_23:GetComponent("SpriteRenderer")

				if var_4_24 and var_4_24.sprite then
					local var_4_25 = (var_4_23.transform.localPosition - var_4_21).z
					local var_4_26 = manager.ui.mainCameraCom_
					local var_4_27 = 2 * var_4_25 * Mathf.Tan(var_4_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_28 = var_4_27 * var_4_26.aspect
					local var_4_29 = var_4_24.sprite.bounds.size.x
					local var_4_30 = var_4_24.sprite.bounds.size.y
					local var_4_31 = var_4_28 / var_4_29
					local var_4_32 = var_4_27 / var_4_30
					local var_4_33 = var_4_32 < var_4_31 and var_4_31 or var_4_32

					var_4_23.transform.localScale = Vector3.New(var_4_33, var_4_33, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0404" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_34 = 4.40000033333333

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_35 = 0.300000000001

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_36 = "1080"

			if arg_1_1.actors_[var_4_36] == nil then
				local var_4_37 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1080")

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

			local var_4_40 = arg_1_1.actors_["1080"]
			local var_4_41 = 4.20000033333333

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.actorSpriteComps1080 == nil then
				arg_1_1.var_.actorSpriteComps1080 = var_4_40:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_42 = 0.2

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.actorSpriteComps1080 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_44 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_43)
								local var_4_45 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_43)
								local var_4_46 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_43)

								iter_4_5.color = Color.New(var_4_44, var_4_45, var_4_46)
							else
								local var_4_47 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_43)

								iter_4_5.color = Color.New(var_4_47, var_4_47, var_4_47)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.actorSpriteComps1080 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1080 = nil
			end

			local var_4_48 = arg_1_1.actors_["1080"].transform
			local var_4_49 = 4.20000033333333

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.var_.moveOldPos1080 = var_4_48.localPosition
				var_4_48.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1080", 2)

				local var_4_50 = var_4_48.childCount

				for iter_4_8 = 0, var_4_50 - 1 do
					local var_4_51 = var_4_48:GetChild(iter_4_8)

					if var_4_51.name == "" or not string.find(var_4_51.name, "split") then
						var_4_51.gameObject:SetActive(true)
					else
						var_4_51.gameObject:SetActive(false)
					end
				end
			end

			local var_4_52 = 0.001

			if var_4_49 <= arg_1_1.time_ and arg_1_1.time_ < var_4_49 + var_4_52 then
				local var_4_53 = (arg_1_1.time_ - var_4_49) / var_4_52
				local var_4_54 = Vector3.New(-390, -378, -170)

				var_4_48.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1080, var_4_54, var_4_53)
			end

			if arg_1_1.time_ >= var_4_49 + var_4_52 and arg_1_1.time_ < var_4_49 + var_4_52 + arg_4_0 then
				var_4_48.localPosition = Vector3.New(-390, -378, -170)
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

			local var_4_61 = 0.433333333333333
			local var_4_62 = 1

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				local var_4_63 = "play"
				local var_4_64 = "music"

				arg_1_1:AudioAction(var_4_63, var_4_64, "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy.awb")

				local var_4_65 = ""
				local var_4_66 = manager.audio:GetAudioName("bgm_activity_4_7_story_snowy", "bgm_activity_4_7_story_snowy")

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

			local var_4_67 = 2.76666666666667
			local var_4_68 = 1

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				local var_4_69 = "play"
				local var_4_70 = "effect"

				arg_1_1:AudioAction(var_4_69, var_4_70, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_71 = 4.36666666666667
			local var_4_72 = 0.5

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

				local var_4_74 = arg_1_1:FormatText(StoryNameCfg[55].name)

				arg_1_1.leftNameTxt_.text = var_4_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_75 = arg_1_1:GetWordFromCfg(425081001)
				local var_4_76 = arg_1_1:FormatText(var_4_75.content)

				arg_1_1.text_.text = var_4_76

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_77 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081001", "story_v_out_425081.awb") ~= 0 then
					local var_4_80 = manager.audio:GetVoiceLength("story_v_out_425081", "425081001", "story_v_out_425081.awb") / 1000

					if var_4_80 + var_4_71 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_80 + var_4_71
					end

					if var_4_75.prefab_name ~= "" and arg_1_1.actors_[var_4_75.prefab_name] ~= nil then
						local var_4_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_75.prefab_name].transform, "story_v_out_425081", "425081001", "story_v_out_425081.awb")

						arg_1_1:RecordAudio("425081001", var_4_81)
						arg_1_1:RecordAudio("425081001", var_4_81)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425081", "425081001", "story_v_out_425081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425081", "425081001", "story_v_out_425081.awb")
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
				actorName = "1080",
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
	Play425081002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 425081002
		arg_10_1.duration_ = 3.3

		local var_10_0 = {
			zh = 1.6,
			ja = 3.3
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
				arg_10_0:Play425081003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "1086"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

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

			local var_13_4 = arg_10_1.actors_["1086"]
			local var_13_5 = 0

			if var_13_5 < arg_10_1.time_ and arg_10_1.time_ <= var_13_5 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1086 == nil then
				arg_10_1.var_.actorSpriteComps1086 = var_13_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_6 = 0.2

			if var_13_5 <= arg_10_1.time_ and arg_10_1.time_ < var_13_5 + var_13_6 and not isNil(var_13_4) then
				local var_13_7 = (arg_10_1.time_ - var_13_5) / var_13_6

				if arg_10_1.var_.actorSpriteComps1086 then
					for iter_13_2, iter_13_3 in pairs(arg_10_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_10_1.time_ >= var_13_5 + var_13_6 and arg_10_1.time_ < var_13_5 + var_13_6 + arg_13_0 and not isNil(var_13_4) and arg_10_1.var_.actorSpriteComps1086 then
				for iter_13_4, iter_13_5 in pairs(arg_10_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_13_5 then
						if arg_10_1.isInRecall_ then
							iter_13_5.color = arg_10_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_13_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps1086 = nil
			end

			local var_13_12 = arg_10_1.actors_["1080"]
			local var_13_13 = 0

			if var_13_13 < arg_10_1.time_ and arg_10_1.time_ <= var_13_13 + arg_13_0 and not isNil(var_13_12) and arg_10_1.var_.actorSpriteComps1080 == nil then
				arg_10_1.var_.actorSpriteComps1080 = var_13_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_13_14 = 0.2

			if var_13_13 <= arg_10_1.time_ and arg_10_1.time_ < var_13_13 + var_13_14 and not isNil(var_13_12) then
				local var_13_15 = (arg_10_1.time_ - var_13_13) / var_13_14

				if arg_10_1.var_.actorSpriteComps1080 then
					for iter_13_6, iter_13_7 in pairs(arg_10_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_10_1.time_ >= var_13_13 + var_13_14 and arg_10_1.time_ < var_13_13 + var_13_14 + arg_13_0 and not isNil(var_13_12) and arg_10_1.var_.actorSpriteComps1080 then
				for iter_13_8, iter_13_9 in pairs(arg_10_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_13_9 then
						if arg_10_1.isInRecall_ then
							iter_13_9.color = arg_10_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_13_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_10_1.var_.actorSpriteComps1080 = nil
			end

			local var_13_20 = arg_10_1.actors_["1086"].transform
			local var_13_21 = 0

			if var_13_21 < arg_10_1.time_ and arg_10_1.time_ <= var_13_21 + arg_13_0 then
				arg_10_1.var_.moveOldPos1086 = var_13_20.localPosition
				var_13_20.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1086", 4)

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
				local var_13_26 = Vector3.New(390, -404.2, -237.9)

				var_13_20.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1086, var_13_26, var_13_25)
			end

			if arg_10_1.time_ >= var_13_21 + var_13_24 and arg_10_1.time_ < var_13_21 + var_13_24 + arg_13_0 then
				var_13_20.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_13_27 = 0
			local var_13_28 = 0.2

			if var_13_27 < arg_10_1.time_ and arg_10_1.time_ <= var_13_27 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_29 = arg_10_1:FormatText(StoryNameCfg[1080].name)

				arg_10_1.leftNameTxt_.text = var_13_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_30 = arg_10_1:GetWordFromCfg(425081002)
				local var_13_31 = arg_10_1:FormatText(var_13_30.content)

				arg_10_1.text_.text = var_13_31

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_32 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081002", "story_v_out_425081.awb") ~= 0 then
					local var_13_35 = manager.audio:GetVoiceLength("story_v_out_425081", "425081002", "story_v_out_425081.awb") / 1000

					if var_13_35 + var_13_27 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_35 + var_13_27
					end

					if var_13_30.prefab_name ~= "" and arg_10_1.actors_[var_13_30.prefab_name] ~= nil then
						local var_13_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_30.prefab_name].transform, "story_v_out_425081", "425081002", "story_v_out_425081.awb")

						arg_10_1:RecordAudio("425081002", var_13_36)
						arg_10_1:RecordAudio("425081002", var_13_36)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_425081", "425081002", "story_v_out_425081.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_425081", "425081002", "story_v_out_425081.awb")
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
				actorName = "1086",
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
	Play425081003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 425081003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play425081004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1080"].transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.moveOldPos1080 = var_17_0.localPosition
				var_17_0.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1080", 7)

				local var_17_2 = var_17_0.childCount

				for iter_17_0 = 0, var_17_2 - 1 do
					local var_17_3 = var_17_0:GetChild(iter_17_0)

					if var_17_3.name == "" or not string.find(var_17_3.name, "split") then
						var_17_3.gameObject:SetActive(true)
					else
						var_17_3.gameObject:SetActive(false)
					end
				end
			end

			local var_17_4 = 0.001

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_4 then
				local var_17_5 = (arg_14_1.time_ - var_17_1) / var_17_4
				local var_17_6 = Vector3.New(0, -2000, 0)

				var_17_0.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1080, var_17_6, var_17_5)
			end

			if arg_14_1.time_ >= var_17_1 + var_17_4 and arg_14_1.time_ < var_17_1 + var_17_4 + arg_17_0 then
				var_17_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_17_7 = arg_14_1.actors_["1086"].transform
			local var_17_8 = 0

			if var_17_8 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.var_.moveOldPos1086 = var_17_7.localPosition
				var_17_7.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1086", 7)

				local var_17_9 = var_17_7.childCount

				for iter_17_1 = 0, var_17_9 - 1 do
					local var_17_10 = var_17_7:GetChild(iter_17_1)

					if var_17_10.name == "" or not string.find(var_17_10.name, "split") then
						var_17_10.gameObject:SetActive(true)
					else
						var_17_10.gameObject:SetActive(false)
					end
				end
			end

			local var_17_11 = 0.001

			if var_17_8 <= arg_14_1.time_ and arg_14_1.time_ < var_17_8 + var_17_11 then
				local var_17_12 = (arg_14_1.time_ - var_17_8) / var_17_11
				local var_17_13 = Vector3.New(0, -2000, 0)

				var_17_7.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1086, var_17_13, var_17_12)
			end

			if arg_14_1.time_ >= var_17_8 + var_17_11 and arg_14_1.time_ < var_17_8 + var_17_11 + arg_17_0 then
				var_17_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_17_14 = 0.133333333333333
			local var_17_15 = 1

			if var_17_14 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				local var_17_16 = "play"
				local var_17_17 = "effect"

				arg_14_1:AudioAction(var_17_16, var_17_17, "se_story_side_1068", "se_story_1068_footstep", "")
			end

			local var_17_18 = 0
			local var_17_19 = 0.85

			if var_17_18 < arg_14_1.time_ and arg_14_1.time_ <= var_17_18 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_20 = arg_14_1:GetWordFromCfg(425081003)
				local var_17_21 = arg_14_1:FormatText(var_17_20.content)

				arg_14_1.text_.text = var_17_21

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_22 = 34
				local var_17_23 = utf8.len(var_17_21)
				local var_17_24 = var_17_22 <= 0 and var_17_19 or var_17_19 * (var_17_23 / var_17_22)

				if var_17_24 > 0 and var_17_19 < var_17_24 then
					arg_14_1.talkMaxDuration = var_17_24

					if var_17_24 + var_17_18 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_24 + var_17_18
					end
				end

				arg_14_1.text_.text = var_17_21
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_25 = math.max(var_17_19, arg_14_1.talkMaxDuration)

			if var_17_18 <= arg_14_1.time_ and arg_14_1.time_ < var_17_18 + var_17_25 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_18) / var_17_25

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_18 + var_17_25 and arg_14_1.time_ < var_17_18 + var_17_25 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play425081004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 425081004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play425081005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.4

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_2 = arg_18_1:GetWordFromCfg(425081004)
				local var_21_3 = arg_18_1:FormatText(var_21_2.content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 56
				local var_21_5 = utf8.len(var_21_3)
				local var_21_6 = var_21_4 <= 0 and var_21_1 or var_21_1 * (var_21_5 / var_21_4)

				if var_21_6 > 0 and var_21_1 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_7 and arg_18_1.time_ < var_21_0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play425081005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 425081005
		arg_22_1.duration_ = 6.1

		local var_22_0 = {
			zh = 3.466,
			ja = 6.1
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
				arg_22_0:Play425081006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 0.4

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_2 = arg_22_1:FormatText(StoryNameCfg[1430].name)

				arg_22_1.leftNameTxt_.text = var_25_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_3 = arg_22_1:GetWordFromCfg(425081005)
				local var_25_4 = arg_22_1:FormatText(var_25_3.content)

				arg_22_1.text_.text = var_25_4

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 16
				local var_25_6 = utf8.len(var_25_4)
				local var_25_7 = var_25_5 <= 0 and var_25_1 or var_25_1 * (var_25_6 / var_25_5)

				if var_25_7 > 0 and var_25_1 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_4
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081005", "story_v_out_425081.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081005", "story_v_out_425081.awb") / 1000

					if var_25_8 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_0
					end

					if var_25_3.prefab_name ~= "" and arg_22_1.actors_[var_25_3.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_3.prefab_name].transform, "story_v_out_425081", "425081005", "story_v_out_425081.awb")

						arg_22_1:RecordAudio("425081005", var_25_9)
						arg_22_1:RecordAudio("425081005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_425081", "425081005", "story_v_out_425081.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_425081", "425081005", "story_v_out_425081.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_10 and arg_22_1.time_ < var_25_0 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play425081006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 425081006
		arg_26_1.duration_ = 3.93

		local var_26_0 = {
			zh = 3.133,
			ja = 3.933
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
				arg_26_0:Play425081007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1086"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1086 == nil then
				arg_26_1.var_.actorSpriteComps1086 = var_29_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.actorSpriteComps1086 then
					for iter_29_0, iter_29_1 in pairs(arg_26_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.actorSpriteComps1086 then
				for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_29_3 then
						if arg_26_1.isInRecall_ then
							iter_29_3.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1086 = nil
			end

			local var_29_8 = arg_26_1.actors_["1086"].transform
			local var_29_9 = 0

			if var_29_9 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 then
				arg_26_1.var_.moveOldPos1086 = var_29_8.localPosition
				var_29_8.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1086", 3)

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
				local var_29_14 = Vector3.New(0, -404.2, -237.9)

				var_29_8.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1086, var_29_14, var_29_13)
			end

			if arg_26_1.time_ >= var_29_9 + var_29_12 and arg_26_1.time_ < var_29_9 + var_29_12 + arg_29_0 then
				var_29_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_29_15 = 0
			local var_29_16 = 0.35

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_17 = arg_26_1:FormatText(StoryNameCfg[1080].name)

				arg_26_1.leftNameTxt_.text = var_29_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_18 = arg_26_1:GetWordFromCfg(425081006)
				local var_29_19 = arg_26_1:FormatText(var_29_18.content)

				arg_26_1.text_.text = var_29_19

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081006", "story_v_out_425081.awb") ~= 0 then
					local var_29_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081006", "story_v_out_425081.awb") / 1000

					if var_29_23 + var_29_15 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_23 + var_29_15
					end

					if var_29_18.prefab_name ~= "" and arg_26_1.actors_[var_29_18.prefab_name] ~= nil then
						local var_29_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_18.prefab_name].transform, "story_v_out_425081", "425081006", "story_v_out_425081.awb")

						arg_26_1:RecordAudio("425081006", var_29_24)
						arg_26_1:RecordAudio("425081006", var_29_24)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_425081", "425081006", "story_v_out_425081.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_425081", "425081006", "story_v_out_425081.awb")
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
				actorName = "1086",
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
	Play425081007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 425081007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play425081008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1086"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1086 == nil then
				arg_30_1.var_.actorSpriteComps1086 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps1086 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1086 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1086 = nil
			end

			local var_33_8 = 0
			local var_33_9 = 0.725

			if var_33_8 < arg_30_1.time_ and arg_30_1.time_ <= var_33_8 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_10 = arg_30_1:GetWordFromCfg(425081007)
				local var_33_11 = arg_30_1:FormatText(var_33_10.content)

				arg_30_1.text_.text = var_33_11

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_12 = 29
				local var_33_13 = utf8.len(var_33_11)
				local var_33_14 = var_33_12 <= 0 and var_33_9 or var_33_9 * (var_33_13 / var_33_12)

				if var_33_14 > 0 and var_33_9 < var_33_14 then
					arg_30_1.talkMaxDuration = var_33_14

					if var_33_14 + var_33_8 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_14 + var_33_8
					end
				end

				arg_30_1.text_.text = var_33_11
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_15 = math.max(var_33_9, arg_30_1.talkMaxDuration)

			if var_33_8 <= arg_30_1.time_ and arg_30_1.time_ < var_33_8 + var_33_15 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_8) / var_33_15

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_8 + var_33_15 and arg_30_1.time_ < var_33_8 + var_33_15 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play425081008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 425081008
		arg_34_1.duration_ = 4.4

		local var_34_0 = {
			zh = 3.8,
			ja = 4.4
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
				arg_34_0:Play425081009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1086"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1086 == nil then
				arg_34_1.var_.actorSpriteComps1086 = var_37_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.actorSpriteComps1086 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.actorSpriteComps1086 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_37_3 then
						if arg_34_1.isInRecall_ then
							iter_37_3.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_37_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_34_1.var_.actorSpriteComps1086 = nil
			end

			local var_37_8 = arg_34_1.actors_["1086"].transform
			local var_37_9 = 0

			if var_37_9 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 then
				arg_34_1.var_.moveOldPos1086 = var_37_8.localPosition
				var_37_8.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1086", 3)

				local var_37_10 = var_37_8.childCount

				for iter_37_4 = 0, var_37_10 - 1 do
					local var_37_11 = var_37_8:GetChild(iter_37_4)

					if var_37_11.name == "split_2" then
						var_37_11:SetAsLastSibling()
						var_37_11.gameObject:SetActive(true)

						arg_34_1.var_.actorSpriteSplit1086 = var_37_11.gameObject:GetComponent(typeof(Image))

						arg_34_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_37_12 = 0.5

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_12 then
				local var_37_13 = (arg_34_1.time_ - var_37_9) / var_37_12
				local var_37_14 = Vector3.New(0, -404.2, -237.9)

				var_37_8.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1086, var_37_14, var_37_13)

				if arg_34_1.var_.actorSpriteSplit1086 ~= nil then
					arg_34_1.var_.actorSpriteSplit1086:SetAlpha(var_37_13)
				end
			end

			if arg_34_1.time_ >= var_37_9 + var_37_12 and arg_34_1.time_ < var_37_9 + var_37_12 + arg_37_0 then
				var_37_8.localPosition = Vector3.New(0, -404.2, -237.9)

				if arg_34_1.var_.actorSpriteSplit1086 ~= nil then
					arg_34_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_37_15 = 0
			local var_37_16 = 0.275

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_17 = arg_34_1:FormatText(StoryNameCfg[1080].name)

				arg_34_1.leftNameTxt_.text = var_37_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_18 = arg_34_1:GetWordFromCfg(425081008)
				local var_37_19 = arg_34_1:FormatText(var_37_18.content)

				arg_34_1.text_.text = var_37_19

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_20 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081008", "story_v_out_425081.awb") ~= 0 then
					local var_37_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081008", "story_v_out_425081.awb") / 1000

					if var_37_23 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_23 + var_37_15
					end

					if var_37_18.prefab_name ~= "" and arg_34_1.actors_[var_37_18.prefab_name] ~= nil then
						local var_37_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_18.prefab_name].transform, "story_v_out_425081", "425081008", "story_v_out_425081.awb")

						arg_34_1:RecordAudio("425081008", var_37_24)
						arg_34_1:RecordAudio("425081008", var_37_24)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_425081", "425081008", "story_v_out_425081.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_425081", "425081008", "story_v_out_425081.awb")
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
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play425081009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 425081009
		arg_38_1.duration_ = 6.67

		local var_38_0 = {
			zh = 5.5,
			ja = 6.666
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
				arg_38_0:Play425081010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1086"].transform
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.var_.moveOldPos1086 = var_41_0.localPosition
				var_41_0.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1086", 3)

				local var_41_2 = var_41_0.childCount

				for iter_41_0 = 0, var_41_2 - 1 do
					local var_41_3 = var_41_0:GetChild(iter_41_0)

					if var_41_3.name == "" then
						var_41_3:SetAsLastSibling()
						var_41_3.gameObject:SetActive(true)

						arg_38_1.var_.actorSpriteSplit1086 = var_41_3.gameObject:GetComponent(typeof(Image))

						arg_38_1.var_.actorSpriteSplit1086:SetAlpha(0)
					end
				end
			end

			local var_41_4 = 0.5

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_4 then
				local var_41_5 = (arg_38_1.time_ - var_41_1) / var_41_4
				local var_41_6 = Vector3.New(0, -404.2, -237.9)

				var_41_0.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1086, var_41_6, var_41_5)

				if arg_38_1.var_.actorSpriteSplit1086 ~= nil then
					arg_38_1.var_.actorSpriteSplit1086:SetAlpha(var_41_5)
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_4 and arg_38_1.time_ < var_41_1 + var_41_4 + arg_41_0 then
				var_41_0.localPosition = Vector3.New(0, -404.2, -237.9)

				if arg_38_1.var_.actorSpriteSplit1086 ~= nil then
					arg_38_1.var_.actorSpriteSplit1086:SetAlpha(1)
				end
			end

			local var_41_7 = 0
			local var_41_8 = 0.525

			if var_41_7 < arg_38_1.time_ and arg_38_1.time_ <= var_41_7 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_9 = arg_38_1:FormatText(StoryNameCfg[1080].name)

				arg_38_1.leftNameTxt_.text = var_41_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_10 = arg_38_1:GetWordFromCfg(425081009)
				local var_41_11 = arg_38_1:FormatText(var_41_10.content)

				arg_38_1.text_.text = var_41_11

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_12 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081009", "story_v_out_425081.awb") ~= 0 then
					local var_41_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081009", "story_v_out_425081.awb") / 1000

					if var_41_15 + var_41_7 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_7
					end

					if var_41_10.prefab_name ~= "" and arg_38_1.actors_[var_41_10.prefab_name] ~= nil then
						local var_41_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_10.prefab_name].transform, "story_v_out_425081", "425081009", "story_v_out_425081.awb")

						arg_38_1:RecordAudio("425081009", var_41_16)
						arg_38_1:RecordAudio("425081009", var_41_16)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_425081", "425081009", "story_v_out_425081.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_425081", "425081009", "story_v_out_425081.awb")
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
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play425081010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 425081010
		arg_42_1.duration_ = 7.97

		local var_42_0 = {
			zh = 5.1,
			ja = 7.966
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
				arg_42_0:Play425081011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1086"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1086 == nil then
				arg_42_1.var_.actorSpriteComps1086 = var_45_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_2 = 0.2

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.actorSpriteComps1086 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.actorSpriteComps1086 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_45_3 then
						if arg_42_1.isInRecall_ then
							iter_45_3.color = arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_45_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_42_1.var_.actorSpriteComps1086 = nil
			end

			local var_45_8 = 0
			local var_45_9 = 0.5

			if var_45_8 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_10 = arg_42_1:FormatText(StoryNameCfg[1430].name)

				arg_42_1.leftNameTxt_.text = var_45_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_11 = arg_42_1:GetWordFromCfg(425081010)
				local var_45_12 = arg_42_1:FormatText(var_45_11.content)

				arg_42_1.text_.text = var_45_12

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_13 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081010", "story_v_out_425081.awb") ~= 0 then
					local var_45_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081010", "story_v_out_425081.awb") / 1000

					if var_45_16 + var_45_8 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_16 + var_45_8
					end

					if var_45_11.prefab_name ~= "" and arg_42_1.actors_[var_45_11.prefab_name] ~= nil then
						local var_45_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_11.prefab_name].transform, "story_v_out_425081", "425081010", "story_v_out_425081.awb")

						arg_42_1:RecordAudio("425081010", var_45_17)
						arg_42_1:RecordAudio("425081010", var_45_17)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_425081", "425081010", "story_v_out_425081.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_425081", "425081010", "story_v_out_425081.awb")
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
	Play425081011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 425081011
		arg_46_1.duration_ = 6.43

		local var_46_0 = {
			zh = 3,
			ja = 6.433
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
				arg_46_0:Play425081012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1086"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1086 == nil then
				arg_46_1.var_.actorSpriteComps1086 = var_49_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.actorSpriteComps1086 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.actorSpriteComps1086 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_49_3 then
						if arg_46_1.isInRecall_ then
							iter_49_3.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_49_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps1086 = nil
			end

			local var_49_8 = arg_46_1.actors_["1086"].transform
			local var_49_9 = 0

			if var_49_9 < arg_46_1.time_ and arg_46_1.time_ <= var_49_9 + arg_49_0 then
				arg_46_1.var_.moveOldPos1086 = var_49_8.localPosition
				var_49_8.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1086", 3)

				local var_49_10 = var_49_8.childCount

				for iter_49_4 = 0, var_49_10 - 1 do
					local var_49_11 = var_49_8:GetChild(iter_49_4)

					if var_49_11.name == "" or not string.find(var_49_11.name, "split") then
						var_49_11.gameObject:SetActive(true)
					else
						var_49_11.gameObject:SetActive(false)
					end
				end
			end

			local var_49_12 = 0.001

			if var_49_9 <= arg_46_1.time_ and arg_46_1.time_ < var_49_9 + var_49_12 then
				local var_49_13 = (arg_46_1.time_ - var_49_9) / var_49_12
				local var_49_14 = Vector3.New(0, -404.2, -237.9)

				var_49_8.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1086, var_49_14, var_49_13)
			end

			if arg_46_1.time_ >= var_49_9 + var_49_12 and arg_46_1.time_ < var_49_9 + var_49_12 + arg_49_0 then
				var_49_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_49_15 = 0
			local var_49_16 = 0.375

			if var_49_15 < arg_46_1.time_ and arg_46_1.time_ <= var_49_15 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_17 = arg_46_1:FormatText(StoryNameCfg[1080].name)

				arg_46_1.leftNameTxt_.text = var_49_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_18 = arg_46_1:GetWordFromCfg(425081011)
				local var_49_19 = arg_46_1:FormatText(var_49_18.content)

				arg_46_1.text_.text = var_49_19

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081011", "story_v_out_425081.awb") ~= 0 then
					local var_49_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081011", "story_v_out_425081.awb") / 1000

					if var_49_23 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_15
					end

					if var_49_18.prefab_name ~= "" and arg_46_1.actors_[var_49_18.prefab_name] ~= nil then
						local var_49_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_18.prefab_name].transform, "story_v_out_425081", "425081011", "story_v_out_425081.awb")

						arg_46_1:RecordAudio("425081011", var_49_24)
						arg_46_1:RecordAudio("425081011", var_49_24)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_425081", "425081011", "story_v_out_425081.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_425081", "425081011", "story_v_out_425081.awb")
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
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play425081012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 425081012
		arg_50_1.duration_ = 4.2

		local var_50_0 = {
			zh = 3,
			ja = 4.2
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
				arg_50_0:Play425081013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1086"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps1086 == nil then
				arg_50_1.var_.actorSpriteComps1086 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps1086 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								local var_53_4 = Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor2.r, var_53_3)
								local var_53_5 = Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor2.g, var_53_3)
								local var_53_6 = Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor2.b, var_53_3)

								iter_53_1.color = Color.New(var_53_4, var_53_5, var_53_6)
							else
								local var_53_7 = Mathf.Lerp(iter_53_1.color.r, 0.5, var_53_3)

								iter_53_1.color = Color.New(var_53_7, var_53_7, var_53_7)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps1086 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_53_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps1086 = nil
			end

			local var_53_8 = 0
			local var_53_9 = 0.3

			if var_53_8 < arg_50_1.time_ and arg_50_1.time_ <= var_53_8 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_10 = arg_50_1:FormatText(StoryNameCfg[1430].name)

				arg_50_1.leftNameTxt_.text = var_53_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_11 = arg_50_1:GetWordFromCfg(425081012)
				local var_53_12 = arg_50_1:FormatText(var_53_11.content)

				arg_50_1.text_.text = var_53_12

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_13 = 12
				local var_53_14 = utf8.len(var_53_12)
				local var_53_15 = var_53_13 <= 0 and var_53_9 or var_53_9 * (var_53_14 / var_53_13)

				if var_53_15 > 0 and var_53_9 < var_53_15 then
					arg_50_1.talkMaxDuration = var_53_15

					if var_53_15 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_15 + var_53_8
					end
				end

				arg_50_1.text_.text = var_53_12
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081012", "story_v_out_425081.awb") ~= 0 then
					local var_53_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081012", "story_v_out_425081.awb") / 1000

					if var_53_16 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_16 + var_53_8
					end

					if var_53_11.prefab_name ~= "" and arg_50_1.actors_[var_53_11.prefab_name] ~= nil then
						local var_53_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_11.prefab_name].transform, "story_v_out_425081", "425081012", "story_v_out_425081.awb")

						arg_50_1:RecordAudio("425081012", var_53_17)
						arg_50_1:RecordAudio("425081012", var_53_17)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_425081", "425081012", "story_v_out_425081.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_425081", "425081012", "story_v_out_425081.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_18 = math.max(var_53_9, arg_50_1.talkMaxDuration)

			if var_53_8 <= arg_50_1.time_ and arg_50_1.time_ < var_53_8 + var_53_18 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_8) / var_53_18

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_8 + var_53_18 and arg_50_1.time_ < var_53_8 + var_53_18 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play425081013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 425081013
		arg_54_1.duration_ = 4.57

		local var_54_0 = {
			zh = 4,
			ja = 4.566
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
				arg_54_0:Play425081014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1086"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1086 == nil then
				arg_54_1.var_.actorSpriteComps1086 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps1086 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1086 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1086 = nil
			end

			local var_57_8 = arg_54_1.actors_["1086"].transform
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 then
				arg_54_1.var_.moveOldPos1086 = var_57_8.localPosition
				var_57_8.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1086", 3)

				local var_57_10 = var_57_8.childCount

				for iter_57_4 = 0, var_57_10 - 1 do
					local var_57_11 = var_57_8:GetChild(iter_57_4)

					if var_57_11.name == "" or not string.find(var_57_11.name, "split") then
						var_57_11.gameObject:SetActive(true)
					else
						var_57_11.gameObject:SetActive(false)
					end
				end
			end

			local var_57_12 = 0.001

			if var_57_9 <= arg_54_1.time_ and arg_54_1.time_ < var_57_9 + var_57_12 then
				local var_57_13 = (arg_54_1.time_ - var_57_9) / var_57_12
				local var_57_14 = Vector3.New(0, -404.2, -237.9)

				var_57_8.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1086, var_57_14, var_57_13)
			end

			if arg_54_1.time_ >= var_57_9 + var_57_12 and arg_54_1.time_ < var_57_9 + var_57_12 + arg_57_0 then
				var_57_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_57_15 = 0
			local var_57_16 = 0.375

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_17 = arg_54_1:FormatText(StoryNameCfg[1080].name)

				arg_54_1.leftNameTxt_.text = var_57_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_18 = arg_54_1:GetWordFromCfg(425081013)
				local var_57_19 = arg_54_1:FormatText(var_57_18.content)

				arg_54_1.text_.text = var_57_19

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 15
				local var_57_21 = utf8.len(var_57_19)
				local var_57_22 = var_57_20 <= 0 and var_57_16 or var_57_16 * (var_57_21 / var_57_20)

				if var_57_22 > 0 and var_57_16 < var_57_22 then
					arg_54_1.talkMaxDuration = var_57_22

					if var_57_22 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_22 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_19
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081013", "story_v_out_425081.awb") ~= 0 then
					local var_57_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081013", "story_v_out_425081.awb") / 1000

					if var_57_23 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_15
					end

					if var_57_18.prefab_name ~= "" and arg_54_1.actors_[var_57_18.prefab_name] ~= nil then
						local var_57_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_18.prefab_name].transform, "story_v_out_425081", "425081013", "story_v_out_425081.awb")

						arg_54_1:RecordAudio("425081013", var_57_24)
						arg_54_1:RecordAudio("425081013", var_57_24)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_425081", "425081013", "story_v_out_425081.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_425081", "425081013", "story_v_out_425081.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_25 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_25 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_15) / var_57_25

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_15 + var_57_25 and arg_54_1.time_ < var_57_15 + var_57_25 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play425081014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 425081014
		arg_58_1.duration_ = 8.6

		local var_58_0 = {
			zh = 5.2,
			ja = 8.6
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
				arg_58_0:Play425081015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1086"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1086 == nil then
				arg_58_1.var_.actorSpriteComps1086 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps1086 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1086 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1086 = nil
			end

			local var_61_8 = 0
			local var_61_9 = 0.6

			if var_61_8 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_10 = arg_58_1:FormatText(StoryNameCfg[1430].name)

				arg_58_1.leftNameTxt_.text = var_61_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_11 = arg_58_1:GetWordFromCfg(425081014)
				local var_61_12 = arg_58_1:FormatText(var_61_11.content)

				arg_58_1.text_.text = var_61_12

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081014", "story_v_out_425081.awb") ~= 0 then
					local var_61_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081014", "story_v_out_425081.awb") / 1000

					if var_61_16 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_16 + var_61_8
					end

					if var_61_11.prefab_name ~= "" and arg_58_1.actors_[var_61_11.prefab_name] ~= nil then
						local var_61_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_11.prefab_name].transform, "story_v_out_425081", "425081014", "story_v_out_425081.awb")

						arg_58_1:RecordAudio("425081014", var_61_17)
						arg_58_1:RecordAudio("425081014", var_61_17)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_425081", "425081014", "story_v_out_425081.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_425081", "425081014", "story_v_out_425081.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_18 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_18 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_18

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_18 and arg_58_1.time_ < var_61_8 + var_61_18 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play425081015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 425081015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play425081016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1086"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos1086 = var_65_0.localPosition
				var_65_0.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1086", 7)

				local var_65_2 = var_65_0.childCount

				for iter_65_0 = 0, var_65_2 - 1 do
					local var_65_3 = var_65_0:GetChild(iter_65_0)

					if var_65_3.name == "" or not string.find(var_65_3.name, "split") then
						var_65_3.gameObject:SetActive(true)
					else
						var_65_3.gameObject:SetActive(false)
					end
				end
			end

			local var_65_4 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_4 then
				local var_65_5 = (arg_62_1.time_ - var_65_1) / var_65_4
				local var_65_6 = Vector3.New(0, -2000, 0)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1086, var_65_6, var_65_5)
			end

			if arg_62_1.time_ >= var_65_1 + var_65_4 and arg_62_1.time_ < var_65_1 + var_65_4 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_65_7 = 0
			local var_65_8 = 0.475

			if var_65_7 < arg_62_1.time_ and arg_62_1.time_ <= var_65_7 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_9 = arg_62_1:GetWordFromCfg(425081015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 19
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_8 or var_65_8 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_8 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_7 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_7
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_14 = math.max(var_65_8, arg_62_1.talkMaxDuration)

			if var_65_7 <= arg_62_1.time_ and arg_62_1.time_ < var_65_7 + var_65_14 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_7) / var_65_14

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_7 + var_65_14 and arg_62_1.time_ < var_65_7 + var_65_14 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play425081016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 425081016
		arg_66_1.duration_ = 9.47

		local var_66_0 = {
			zh = 8.3,
			ja = 9.466
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
				arg_66_0:Play425081017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.9

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[1430].name)

				arg_66_1.leftNameTxt_.text = var_69_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:GetWordFromCfg(425081016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 36
				local var_69_6 = utf8.len(var_69_4)
				local var_69_7 = var_69_5 <= 0 and var_69_1 or var_69_1 * (var_69_6 / var_69_5)

				if var_69_7 > 0 and var_69_1 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081016", "story_v_out_425081.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081016", "story_v_out_425081.awb") / 1000

					if var_69_8 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_0
					end

					if var_69_3.prefab_name ~= "" and arg_66_1.actors_[var_69_3.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_3.prefab_name].transform, "story_v_out_425081", "425081016", "story_v_out_425081.awb")

						arg_66_1:RecordAudio("425081016", var_69_9)
						arg_66_1:RecordAudio("425081016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_425081", "425081016", "story_v_out_425081.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_425081", "425081016", "story_v_out_425081.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_10 and arg_66_1.time_ < var_69_0 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play425081017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 425081017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play425081018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 0.9

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

				local var_73_2 = arg_70_1:GetWordFromCfg(425081017)
				local var_73_3 = arg_70_1:FormatText(var_73_2.content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 36
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
	Play425081018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 425081018
		arg_74_1.duration_ = 10.5

		local var_74_0 = {
			zh = 10.5,
			ja = 7.6
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
				arg_74_0:Play425081019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1086"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1086 == nil then
				arg_74_1.var_.actorSpriteComps1086 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps1086 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps1086 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_77_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps1086 = nil
			end

			local var_77_8 = arg_74_1.actors_["1086"].transform
			local var_77_9 = 0

			if var_77_9 < arg_74_1.time_ and arg_74_1.time_ <= var_77_9 + arg_77_0 then
				arg_74_1.var_.moveOldPos1086 = var_77_8.localPosition
				var_77_8.localScale = Vector3.New(1, 1, 1)

				arg_74_1:CheckSpriteTmpPos("1086", 3)

				local var_77_10 = var_77_8.childCount

				for iter_77_4 = 0, var_77_10 - 1 do
					local var_77_11 = var_77_8:GetChild(iter_77_4)

					if var_77_11.name == "split_2" or not string.find(var_77_11.name, "split") then
						var_77_11.gameObject:SetActive(true)
					else
						var_77_11.gameObject:SetActive(false)
					end
				end
			end

			local var_77_12 = 0.001

			if var_77_9 <= arg_74_1.time_ and arg_74_1.time_ < var_77_9 + var_77_12 then
				local var_77_13 = (arg_74_1.time_ - var_77_9) / var_77_12
				local var_77_14 = Vector3.New(0, -404.2, -237.9)

				var_77_8.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1086, var_77_14, var_77_13)
			end

			if arg_74_1.time_ >= var_77_9 + var_77_12 and arg_74_1.time_ < var_77_9 + var_77_12 + arg_77_0 then
				var_77_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_77_15 = 0
			local var_77_16 = 0.9

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_17 = arg_74_1:FormatText(StoryNameCfg[1080].name)

				arg_74_1.leftNameTxt_.text = var_77_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_18 = arg_74_1:GetWordFromCfg(425081018)
				local var_77_19 = arg_74_1:FormatText(var_77_18.content)

				arg_74_1.text_.text = var_77_19

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_20 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081018", "story_v_out_425081.awb") ~= 0 then
					local var_77_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081018", "story_v_out_425081.awb") / 1000

					if var_77_23 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_23 + var_77_15
					end

					if var_77_18.prefab_name ~= "" and arg_74_1.actors_[var_77_18.prefab_name] ~= nil then
						local var_77_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_18.prefab_name].transform, "story_v_out_425081", "425081018", "story_v_out_425081.awb")

						arg_74_1:RecordAudio("425081018", var_77_24)
						arg_74_1:RecordAudio("425081018", var_77_24)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_425081", "425081018", "story_v_out_425081.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_425081", "425081018", "story_v_out_425081.awb")
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
				actorName = "1086",
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
	Play425081019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 425081019
		arg_78_1.duration_ = 7.23

		local var_78_0 = {
			zh = 5.733,
			ja = 7.233
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
				arg_78_0:Play425081020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = "M01h"

			if arg_78_1.bgs_[var_81_0] == nil then
				local var_81_1 = Object.Instantiate(arg_78_1.paintGo_)

				var_81_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_81_0)
				var_81_1.name = var_81_0
				var_81_1.transform.parent = arg_78_1.stage_.transform
				var_81_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.bgs_[var_81_0] = var_81_1
			end

			local var_81_2 = 2

			if var_81_2 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				local var_81_3 = manager.ui.mainCamera.transform.localPosition
				local var_81_4 = Vector3.New(0, 0, 10) + Vector3.New(var_81_3.x, var_81_3.y, 0)
				local var_81_5 = arg_78_1.bgs_.M01h

				var_81_5.transform.localPosition = var_81_4
				var_81_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_6 = var_81_5:GetComponent("SpriteRenderer")

				if var_81_6 and var_81_6.sprite then
					local var_81_7 = (var_81_5.transform.localPosition - var_81_3).z
					local var_81_8 = manager.ui.mainCameraCom_
					local var_81_9 = 2 * var_81_7 * Mathf.Tan(var_81_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_10 = var_81_9 * var_81_8.aspect
					local var_81_11 = var_81_6.sprite.bounds.size.x
					local var_81_12 = var_81_6.sprite.bounds.size.y
					local var_81_13 = var_81_10 / var_81_11
					local var_81_14 = var_81_9 / var_81_12
					local var_81_15 = var_81_14 < var_81_13 and var_81_13 or var_81_14

					var_81_5.transform.localScale = Vector3.New(var_81_15, var_81_15, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "M01h" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_16 = 4

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			local var_81_17 = 0.3

			if arg_78_1.time_ >= var_81_16 + var_81_17 and arg_78_1.time_ < var_81_16 + var_81_17 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			local var_81_18 = 0

			if var_81_18 < arg_78_1.time_ and arg_78_1.time_ <= var_81_18 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_19 = 2

			if var_81_18 <= arg_78_1.time_ and arg_78_1.time_ < var_81_18 + var_81_19 then
				local var_81_20 = (arg_78_1.time_ - var_81_18) / var_81_19
				local var_81_21 = Color.New(0, 0, 0)

				var_81_21.a = Mathf.Lerp(0, 1, var_81_20)
				arg_78_1.mask_.color = var_81_21
			end

			if arg_78_1.time_ >= var_81_18 + var_81_19 and arg_78_1.time_ < var_81_18 + var_81_19 + arg_81_0 then
				local var_81_22 = Color.New(0, 0, 0)

				var_81_22.a = 1
				arg_78_1.mask_.color = var_81_22
			end

			local var_81_23 = 2

			if var_81_23 < arg_78_1.time_ and arg_78_1.time_ <= var_81_23 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_24 = 2

			if var_81_23 <= arg_78_1.time_ and arg_78_1.time_ < var_81_23 + var_81_24 then
				local var_81_25 = (arg_78_1.time_ - var_81_23) / var_81_24
				local var_81_26 = Color.New(0, 0, 0)

				var_81_26.a = Mathf.Lerp(1, 0, var_81_25)
				arg_78_1.mask_.color = var_81_26
			end

			if arg_78_1.time_ >= var_81_23 + var_81_24 and arg_78_1.time_ < var_81_23 + var_81_24 + arg_81_0 then
				local var_81_27 = Color.New(0, 0, 0)
				local var_81_28 = 0

				arg_78_1.mask_.enabled = false
				var_81_27.a = var_81_28
				arg_78_1.mask_.color = var_81_27
			end

			local var_81_29 = arg_78_1.actors_["1086"].transform
			local var_81_30 = 2

			if var_81_30 < arg_78_1.time_ and arg_78_1.time_ <= var_81_30 + arg_81_0 then
				arg_78_1.var_.moveOldPos1086 = var_81_29.localPosition
				var_81_29.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1086", 7)

				local var_81_31 = var_81_29.childCount

				for iter_81_2 = 0, var_81_31 - 1 do
					local var_81_32 = var_81_29:GetChild(iter_81_2)

					if var_81_32.name == "" or not string.find(var_81_32.name, "split") then
						var_81_32.gameObject:SetActive(true)
					else
						var_81_32.gameObject:SetActive(false)
					end
				end
			end

			local var_81_33 = 0.001

			if var_81_30 <= arg_78_1.time_ and arg_78_1.time_ < var_81_30 + var_81_33 then
				local var_81_34 = (arg_78_1.time_ - var_81_30) / var_81_33
				local var_81_35 = Vector3.New(0, -2000, 0)

				var_81_29.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1086, var_81_35, var_81_34)
			end

			if arg_78_1.time_ >= var_81_30 + var_81_33 and arg_78_1.time_ < var_81_30 + var_81_33 + arg_81_0 then
				var_81_29.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_36 = 4
			local var_81_37 = 0.1

			if var_81_36 < arg_78_1.time_ and arg_78_1.time_ <= var_81_36 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_38 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_38:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_39 = arg_78_1:FormatText(StoryNameCfg[56].name)

				arg_78_1.leftNameTxt_.text = var_81_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_40 = arg_78_1:GetWordFromCfg(425081019)
				local var_81_41 = arg_78_1:FormatText(var_81_40.content)

				arg_78_1.text_.text = var_81_41

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_42 = 4
				local var_81_43 = utf8.len(var_81_41)
				local var_81_44 = var_81_42 <= 0 and var_81_37 or var_81_37 * (var_81_43 / var_81_42)

				if var_81_44 > 0 and var_81_37 < var_81_44 then
					arg_78_1.talkMaxDuration = var_81_44
					var_81_36 = var_81_36 + 0.3

					if var_81_44 + var_81_36 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_44 + var_81_36
					end
				end

				arg_78_1.text_.text = var_81_41
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081019", "story_v_out_425081.awb") ~= 0 then
					local var_81_45 = manager.audio:GetVoiceLength("story_v_out_425081", "425081019", "story_v_out_425081.awb") / 1000

					if var_81_45 + var_81_36 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_45 + var_81_36
					end

					if var_81_40.prefab_name ~= "" and arg_78_1.actors_[var_81_40.prefab_name] ~= nil then
						local var_81_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_40.prefab_name].transform, "story_v_out_425081", "425081019", "story_v_out_425081.awb")

						arg_78_1:RecordAudio("425081019", var_81_46)
						arg_78_1:RecordAudio("425081019", var_81_46)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_425081", "425081019", "story_v_out_425081.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_425081", "425081019", "story_v_out_425081.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_47 = var_81_36 + 0.3
			local var_81_48 = math.max(var_81_37, arg_78_1.talkMaxDuration)

			if var_81_47 <= arg_78_1.time_ and arg_78_1.time_ < var_81_47 + var_81_48 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_47) / var_81_48

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_47 + var_81_48 and arg_78_1.time_ < var_81_47 + var_81_48 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1027",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.266,
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(5, 5, 0)
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play425081020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 425081020
		arg_84_1.duration_ = 1.9

		local var_84_0 = {
			zh = 1.9,
			ja = 1.766
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play425081021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1080"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps1080 == nil then
				arg_84_1.var_.actorSpriteComps1080 = var_87_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.actorSpriteComps1080 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								local var_87_4 = Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, var_87_3)
								local var_87_5 = Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, var_87_3)
								local var_87_6 = Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, var_87_3)

								iter_87_1.color = Color.New(var_87_4, var_87_5, var_87_6)
							else
								local var_87_7 = Mathf.Lerp(iter_87_1.color.r, 1, var_87_3)

								iter_87_1.color = Color.New(var_87_7, var_87_7, var_87_7)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.actorSpriteComps1080 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_87_3 then
						if arg_84_1.isInRecall_ then
							iter_87_3.color = arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_87_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_84_1.var_.actorSpriteComps1080 = nil
			end

			local var_87_8 = arg_84_1.actors_["1080"].transform
			local var_87_9 = 0

			if var_87_9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1.var_.moveOldPos1080 = var_87_8.localPosition
				var_87_8.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1080", 3)

				local var_87_10 = var_87_8.childCount

				for iter_87_4 = 0, var_87_10 - 1 do
					local var_87_11 = var_87_8:GetChild(iter_87_4)

					if var_87_11.name == "" or not string.find(var_87_11.name, "split") then
						var_87_11.gameObject:SetActive(true)
					else
						var_87_11.gameObject:SetActive(false)
					end
				end
			end

			local var_87_12 = 0.001

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_12 then
				local var_87_13 = (arg_84_1.time_ - var_87_9) / var_87_12
				local var_87_14 = Vector3.New(0, -378, -170)

				var_87_8.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1080, var_87_14, var_87_13)
			end

			if arg_84_1.time_ >= var_87_9 + var_87_12 and arg_84_1.time_ < var_87_9 + var_87_12 + arg_87_0 then
				var_87_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_87_15 = 0
			local var_87_16 = 0.175

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[55].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(425081020)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 7
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081020", "story_v_out_425081.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081020", "story_v_out_425081.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_out_425081", "425081020", "story_v_out_425081.awb")

						arg_84_1:RecordAudio("425081020", var_87_24)
						arg_84_1:RecordAudio("425081020", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_425081", "425081020", "story_v_out_425081.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_425081", "425081020", "story_v_out_425081.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play425081021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 425081021
		arg_88_1.duration_ = 5.5

		local var_88_0 = {
			zh = 3.8,
			ja = 5.5
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play425081022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1080"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps1080 == nil then
				arg_88_1.var_.actorSpriteComps1080 = var_91_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.actorSpriteComps1080 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								local var_91_4 = Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor2.r, var_91_3)
								local var_91_5 = Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor2.g, var_91_3)
								local var_91_6 = Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor2.b, var_91_3)

								iter_91_1.color = Color.New(var_91_4, var_91_5, var_91_6)
							else
								local var_91_7 = Mathf.Lerp(iter_91_1.color.r, 0.5, var_91_3)

								iter_91_1.color = Color.New(var_91_7, var_91_7, var_91_7)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.actorSpriteComps1080 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_91_3 then
						if arg_88_1.isInRecall_ then
							iter_91_3.color = arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_91_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_88_1.var_.actorSpriteComps1080 = nil
			end

			local var_91_8 = 0
			local var_91_9 = 0.4

			if var_91_8 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_10 = arg_88_1:FormatText(StoryNameCfg[56].name)

				arg_88_1.leftNameTxt_.text = var_91_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_11 = arg_88_1:GetWordFromCfg(425081021)
				local var_91_12 = arg_88_1:FormatText(var_91_11.content)

				arg_88_1.text_.text = var_91_12

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 16
				local var_91_14 = utf8.len(var_91_12)
				local var_91_15 = var_91_13 <= 0 and var_91_9 or var_91_9 * (var_91_14 / var_91_13)

				if var_91_15 > 0 and var_91_9 < var_91_15 then
					arg_88_1.talkMaxDuration = var_91_15

					if var_91_15 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_15 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_12
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081021", "story_v_out_425081.awb") ~= 0 then
					local var_91_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081021", "story_v_out_425081.awb") / 1000

					if var_91_16 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_16 + var_91_8
					end

					if var_91_11.prefab_name ~= "" and arg_88_1.actors_[var_91_11.prefab_name] ~= nil then
						local var_91_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_11.prefab_name].transform, "story_v_out_425081", "425081021", "story_v_out_425081.awb")

						arg_88_1:RecordAudio("425081021", var_91_17)
						arg_88_1:RecordAudio("425081021", var_91_17)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_425081", "425081021", "story_v_out_425081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_425081", "425081021", "story_v_out_425081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_18 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_18 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_18

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_18 and arg_88_1.time_ < var_91_8 + var_91_18 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play425081022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 425081022
		arg_92_1.duration_ = 8.07

		local var_92_0 = {
			zh = 5.766,
			ja = 8.066
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play425081023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.725

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[56].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(425081022)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 29
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081022", "story_v_out_425081.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081022", "story_v_out_425081.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_425081", "425081022", "story_v_out_425081.awb")

						arg_92_1:RecordAudio("425081022", var_95_9)
						arg_92_1:RecordAudio("425081022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_425081", "425081022", "story_v_out_425081.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_425081", "425081022", "story_v_out_425081.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play425081023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 425081023
		arg_96_1.duration_ = 3.67

		local var_96_0 = {
			zh = 1.1,
			ja = 3.666
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
				arg_96_0:Play425081024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1080"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1080 == nil then
				arg_96_1.var_.actorSpriteComps1080 = var_99_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_2 = 0.2

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.actorSpriteComps1080 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.actorSpriteComps1080 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_99_3 then
						if arg_96_1.isInRecall_ then
							iter_99_3.color = arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_99_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_96_1.var_.actorSpriteComps1080 = nil
			end

			local var_99_8 = 0
			local var_99_9 = 0.175

			if var_99_8 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_10 = arg_96_1:FormatText(StoryNameCfg[55].name)

				arg_96_1.leftNameTxt_.text = var_99_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_11 = arg_96_1:GetWordFromCfg(425081023)
				local var_99_12 = arg_96_1:FormatText(var_99_11.content)

				arg_96_1.text_.text = var_99_12

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_13 = 7
				local var_99_14 = utf8.len(var_99_12)
				local var_99_15 = var_99_13 <= 0 and var_99_9 or var_99_9 * (var_99_14 / var_99_13)

				if var_99_15 > 0 and var_99_9 < var_99_15 then
					arg_96_1.talkMaxDuration = var_99_15

					if var_99_15 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_15 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_12
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081023", "story_v_out_425081.awb") ~= 0 then
					local var_99_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081023", "story_v_out_425081.awb") / 1000

					if var_99_16 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_16 + var_99_8
					end

					if var_99_11.prefab_name ~= "" and arg_96_1.actors_[var_99_11.prefab_name] ~= nil then
						local var_99_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_11.prefab_name].transform, "story_v_out_425081", "425081023", "story_v_out_425081.awb")

						arg_96_1:RecordAudio("425081023", var_99_17)
						arg_96_1:RecordAudio("425081023", var_99_17)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_425081", "425081023", "story_v_out_425081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_425081", "425081023", "story_v_out_425081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_18 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_18 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_18

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_18 and arg_96_1.time_ < var_99_8 + var_99_18 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play425081024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 425081024
		arg_100_1.duration_ = 4.23

		local var_100_0 = {
			zh = 3.433,
			ja = 4.233
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
				arg_100_0:Play425081025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1080"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1080 == nil then
				arg_100_1.var_.actorSpriteComps1080 = var_103_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_2 = 0.2

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.actorSpriteComps1080 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								local var_103_4 = Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor2.r, var_103_3)
								local var_103_5 = Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor2.g, var_103_3)
								local var_103_6 = Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor2.b, var_103_3)

								iter_103_1.color = Color.New(var_103_4, var_103_5, var_103_6)
							else
								local var_103_7 = Mathf.Lerp(iter_103_1.color.r, 0.5, var_103_3)

								iter_103_1.color = Color.New(var_103_7, var_103_7, var_103_7)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.actorSpriteComps1080 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_103_3 then
						if arg_100_1.isInRecall_ then
							iter_103_3.color = arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_103_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_100_1.var_.actorSpriteComps1080 = nil
			end

			local var_103_8 = 0
			local var_103_9 = 0.275

			if var_103_8 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_10 = arg_100_1:FormatText(StoryNameCfg[56].name)

				arg_100_1.leftNameTxt_.text = var_103_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_11 = arg_100_1:GetWordFromCfg(425081024)
				local var_103_12 = arg_100_1:FormatText(var_103_11.content)

				arg_100_1.text_.text = var_103_12

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 11
				local var_103_14 = utf8.len(var_103_12)
				local var_103_15 = var_103_13 <= 0 and var_103_9 or var_103_9 * (var_103_14 / var_103_13)

				if var_103_15 > 0 and var_103_9 < var_103_15 then
					arg_100_1.talkMaxDuration = var_103_15

					if var_103_15 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_12
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081024", "story_v_out_425081.awb") ~= 0 then
					local var_103_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081024", "story_v_out_425081.awb") / 1000

					if var_103_16 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_16 + var_103_8
					end

					if var_103_11.prefab_name ~= "" and arg_100_1.actors_[var_103_11.prefab_name] ~= nil then
						local var_103_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_11.prefab_name].transform, "story_v_out_425081", "425081024", "story_v_out_425081.awb")

						arg_100_1:RecordAudio("425081024", var_103_17)
						arg_100_1:RecordAudio("425081024", var_103_17)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_425081", "425081024", "story_v_out_425081.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_425081", "425081024", "story_v_out_425081.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_18 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_18 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_18

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_18 and arg_100_1.time_ < var_103_8 + var_103_18 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play425081025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 425081025
		arg_104_1.duration_ = 5.77

		local var_104_0 = {
			zh = 3.466,
			ja = 5.766
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
				arg_104_0:Play425081026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.275

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[56].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(425081025)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081025", "story_v_out_425081.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081025", "story_v_out_425081.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_425081", "425081025", "story_v_out_425081.awb")

						arg_104_1:RecordAudio("425081025", var_107_9)
						arg_104_1:RecordAudio("425081025", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_425081", "425081025", "story_v_out_425081.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_425081", "425081025", "story_v_out_425081.awb")
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
	Play425081026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 425081026
		arg_108_1.duration_ = 2.47

		local var_108_0 = {
			zh = 1.5,
			ja = 2.466
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
				arg_108_0:Play425081027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1080"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1080 == nil then
				arg_108_1.var_.actorSpriteComps1080 = var_111_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.actorSpriteComps1080 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.actorSpriteComps1080 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_111_3 then
						if arg_108_1.isInRecall_ then
							iter_111_3.color = arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_111_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_108_1.var_.actorSpriteComps1080 = nil
			end

			local var_111_8 = 0
			local var_111_9 = 0.175

			if var_111_8 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_10 = arg_108_1:FormatText(StoryNameCfg[55].name)

				arg_108_1.leftNameTxt_.text = var_111_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_11 = arg_108_1:GetWordFromCfg(425081026)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 7
				local var_111_14 = utf8.len(var_111_12)
				local var_111_15 = var_111_13 <= 0 and var_111_9 or var_111_9 * (var_111_14 / var_111_13)

				if var_111_15 > 0 and var_111_9 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_12
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081026", "story_v_out_425081.awb") ~= 0 then
					local var_111_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081026", "story_v_out_425081.awb") / 1000

					if var_111_16 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_8
					end

					if var_111_11.prefab_name ~= "" and arg_108_1.actors_[var_111_11.prefab_name] ~= nil then
						local var_111_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_11.prefab_name].transform, "story_v_out_425081", "425081026", "story_v_out_425081.awb")

						arg_108_1:RecordAudio("425081026", var_111_17)
						arg_108_1:RecordAudio("425081026", var_111_17)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_425081", "425081026", "story_v_out_425081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_425081", "425081026", "story_v_out_425081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_18 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_18 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_18

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_18 and arg_108_1.time_ < var_111_8 + var_111_18 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play425081027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 425081027
		arg_112_1.duration_ = 10.9

		local var_112_0 = {
			zh = 9.266,
			ja = 10.9
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
				arg_112_0:Play425081028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1080"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1080 == nil then
				arg_112_1.var_.actorSpriteComps1080 = var_115_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_2 = 0.2

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.actorSpriteComps1080 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.actorSpriteComps1080 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_115_3 then
						if arg_112_1.isInRecall_ then
							iter_115_3.color = arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_115_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_112_1.var_.actorSpriteComps1080 = nil
			end

			local var_115_8 = 0
			local var_115_9 = 1

			if var_115_8 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_10 = arg_112_1:FormatText(StoryNameCfg[56].name)

				arg_112_1.leftNameTxt_.text = var_115_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_11 = arg_112_1:GetWordFromCfg(425081027)
				local var_115_12 = arg_112_1:FormatText(var_115_11.content)

				arg_112_1.text_.text = var_115_12

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081027", "story_v_out_425081.awb") ~= 0 then
					local var_115_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081027", "story_v_out_425081.awb") / 1000

					if var_115_16 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_16 + var_115_8
					end

					if var_115_11.prefab_name ~= "" and arg_112_1.actors_[var_115_11.prefab_name] ~= nil then
						local var_115_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_11.prefab_name].transform, "story_v_out_425081", "425081027", "story_v_out_425081.awb")

						arg_112_1:RecordAudio("425081027", var_115_17)
						arg_112_1:RecordAudio("425081027", var_115_17)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_425081", "425081027", "story_v_out_425081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_425081", "425081027", "story_v_out_425081.awb")
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
	Play425081028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 425081028
		arg_116_1.duration_ = 7.93

		local var_116_0 = {
			zh = 7.933,
			ja = 5.566
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
				arg_116_0:Play425081029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 0.7

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[56].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:GetWordFromCfg(425081028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 28
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081028", "story_v_out_425081.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081028", "story_v_out_425081.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_425081", "425081028", "story_v_out_425081.awb")

						arg_116_1:RecordAudio("425081028", var_119_9)
						arg_116_1:RecordAudio("425081028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_425081", "425081028", "story_v_out_425081.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_425081", "425081028", "story_v_out_425081.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play425081029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 425081029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play425081030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1080"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1080 = var_123_0.localPosition
				var_123_0.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("1080", 7)

				local var_123_2 = var_123_0.childCount

				for iter_123_0 = 0, var_123_2 - 1 do
					local var_123_3 = var_123_0:GetChild(iter_123_0)

					if var_123_3.name == "" or not string.find(var_123_3.name, "split") then
						var_123_3.gameObject:SetActive(true)
					else
						var_123_3.gameObject:SetActive(false)
					end
				end
			end

			local var_123_4 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_4 then
				local var_123_5 = (arg_120_1.time_ - var_123_1) / var_123_4
				local var_123_6 = Vector3.New(0, -2000, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1080, var_123_6, var_123_5)
			end

			if arg_120_1.time_ >= var_123_1 + var_123_4 and arg_120_1.time_ < var_123_1 + var_123_4 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_123_7 = 0
			local var_123_8 = 0.525

			if var_123_7 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_9 = arg_120_1:GetWordFromCfg(425081029)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 21
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_8 or var_123_8 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_8 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_7 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_7
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_8, arg_120_1.talkMaxDuration)

			if var_123_7 <= arg_120_1.time_ and arg_120_1.time_ < var_123_7 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_7) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_7 + var_123_14 and arg_120_1.time_ < var_123_7 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 425081030
		arg_124_1.duration_ = 17.4

		local var_124_0 = {
			zh = 12.9,
			ja = 17.4
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
				arg_124_0:Play425081031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1080"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1080 == nil then
				arg_124_1.var_.actorSpriteComps1080 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps1080 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1080 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1080 = nil
			end

			local var_127_8 = arg_124_1.actors_["1080"].transform
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.var_.moveOldPos1080 = var_127_8.localPosition
				var_127_8.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("1080", 3)

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
				local var_127_14 = Vector3.New(0, -378, -170)

				var_127_8.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1080, var_127_14, var_127_13)
			end

			if arg_124_1.time_ >= var_127_9 + var_127_12 and arg_124_1.time_ < var_127_9 + var_127_12 + arg_127_0 then
				var_127_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_127_15 = 0
			local var_127_16 = 1.2

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_17 = arg_124_1:FormatText(StoryNameCfg[55].name)

				arg_124_1.leftNameTxt_.text = var_127_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(425081030)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 71
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081030", "story_v_out_425081.awb") ~= 0 then
					local var_127_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081030", "story_v_out_425081.awb") / 1000

					if var_127_23 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_15
					end

					if var_127_18.prefab_name ~= "" and arg_124_1.actors_[var_127_18.prefab_name] ~= nil then
						local var_127_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_18.prefab_name].transform, "story_v_out_425081", "425081030", "story_v_out_425081.awb")

						arg_124_1:RecordAudio("425081030", var_127_24)
						arg_124_1:RecordAudio("425081030", var_127_24)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_425081", "425081030", "story_v_out_425081.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_425081", "425081030", "story_v_out_425081.awb")
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
				actorName = "1080",
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
	Play425081031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 425081031
		arg_128_1.duration_ = 10.27

		local var_128_0 = {
			zh = 9.7,
			ja = 10.266
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
				arg_128_0:Play425081032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1080"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1080 = var_131_0.localPosition
				var_131_0.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1080", 3)

				local var_131_2 = var_131_0.childCount

				for iter_131_0 = 0, var_131_2 - 1 do
					local var_131_3 = var_131_0:GetChild(iter_131_0)

					if var_131_3.name == "" or not string.find(var_131_3.name, "split") then
						var_131_3.gameObject:SetActive(true)
					else
						var_131_3.gameObject:SetActive(false)
					end
				end
			end

			local var_131_4 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_4 then
				local var_131_5 = (arg_128_1.time_ - var_131_1) / var_131_4
				local var_131_6 = Vector3.New(0, -378, -170)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1080, var_131_6, var_131_5)
			end

			if arg_128_1.time_ >= var_131_1 + var_131_4 and arg_128_1.time_ < var_131_1 + var_131_4 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -378, -170)
			end

			local var_131_7 = 0
			local var_131_8 = 0.9

			if var_131_7 < arg_128_1.time_ and arg_128_1.time_ <= var_131_7 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_9 = arg_128_1:FormatText(StoryNameCfg[55].name)

				arg_128_1.leftNameTxt_.text = var_131_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_10 = arg_128_1:GetWordFromCfg(425081031)
				local var_131_11 = arg_128_1:FormatText(var_131_10.content)

				arg_128_1.text_.text = var_131_11

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_12 = 59
				local var_131_13 = utf8.len(var_131_11)
				local var_131_14 = var_131_12 <= 0 and var_131_8 or var_131_8 * (var_131_13 / var_131_12)

				if var_131_14 > 0 and var_131_8 < var_131_14 then
					arg_128_1.talkMaxDuration = var_131_14

					if var_131_14 + var_131_7 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_7
					end
				end

				arg_128_1.text_.text = var_131_11
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081031", "story_v_out_425081.awb") ~= 0 then
					local var_131_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081031", "story_v_out_425081.awb") / 1000

					if var_131_15 + var_131_7 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_15 + var_131_7
					end

					if var_131_10.prefab_name ~= "" and arg_128_1.actors_[var_131_10.prefab_name] ~= nil then
						local var_131_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_10.prefab_name].transform, "story_v_out_425081", "425081031", "story_v_out_425081.awb")

						arg_128_1:RecordAudio("425081031", var_131_16)
						arg_128_1:RecordAudio("425081031", var_131_16)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_425081", "425081031", "story_v_out_425081.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_425081", "425081031", "story_v_out_425081.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_17 = math.max(var_131_8, arg_128_1.talkMaxDuration)

			if var_131_7 <= arg_128_1.time_ and arg_128_1.time_ < var_131_7 + var_131_17 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_7) / var_131_17

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_7 + var_131_17 and arg_128_1.time_ < var_131_7 + var_131_17 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 425081032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play425081033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1080"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1080 == nil then
				arg_132_1.var_.actorSpriteComps1080 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps1080 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1080 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1080 = nil
			end

			local var_135_8 = arg_132_1.actors_["1080"].transform
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1.var_.moveOldPos1080 = var_135_8.localPosition
				var_135_8.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1080", 7)

				local var_135_10 = var_135_8.childCount

				for iter_135_4 = 0, var_135_10 - 1 do
					local var_135_11 = var_135_8:GetChild(iter_135_4)

					if var_135_11.name == "" or not string.find(var_135_11.name, "split") then
						var_135_11.gameObject:SetActive(true)
					else
						var_135_11.gameObject:SetActive(false)
					end
				end
			end

			local var_135_12 = 0.001

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_12 then
				local var_135_13 = (arg_132_1.time_ - var_135_9) / var_135_12
				local var_135_14 = Vector3.New(0, -2000, 0)

				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1080, var_135_14, var_135_13)
			end

			if arg_132_1.time_ >= var_135_9 + var_135_12 and arg_132_1.time_ < var_135_9 + var_135_12 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_15 = 0.133333333333333
			local var_135_16 = 1

			if var_135_15 < arg_132_1.time_ and arg_132_1.time_ <= var_135_15 + arg_135_0 then
				local var_135_17 = "play"
				local var_135_18 = "effect"

				arg_132_1:AudioAction(var_135_17, var_135_18, "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_135_19 = 0
			local var_135_20 = 1.075

			if var_135_19 < arg_132_1.time_ and arg_132_1.time_ <= var_135_19 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_21 = arg_132_1:GetWordFromCfg(425081032)
				local var_135_22 = arg_132_1:FormatText(var_135_21.content)

				arg_132_1.text_.text = var_135_22

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_23 = 43
				local var_135_24 = utf8.len(var_135_22)
				local var_135_25 = var_135_23 <= 0 and var_135_20 or var_135_20 * (var_135_24 / var_135_23)

				if var_135_25 > 0 and var_135_20 < var_135_25 then
					arg_132_1.talkMaxDuration = var_135_25

					if var_135_25 + var_135_19 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_25 + var_135_19
					end
				end

				arg_132_1.text_.text = var_135_22
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_26 = math.max(var_135_20, arg_132_1.talkMaxDuration)

			if var_135_19 <= arg_132_1.time_ and arg_132_1.time_ < var_135_19 + var_135_26 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_19) / var_135_26

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_19 + var_135_26 and arg_132_1.time_ < var_135_19 + var_135_26 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 425081033
		arg_136_1.duration_ = 4.33

		local var_136_0 = {
			zh = 3.333,
			ja = 4.333
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
				arg_136_0:Play425081034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.25

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[56].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(425081033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 10
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081033", "story_v_out_425081.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081033", "story_v_out_425081.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_425081", "425081033", "story_v_out_425081.awb")

						arg_136_1:RecordAudio("425081033", var_139_9)
						arg_136_1:RecordAudio("425081033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_425081", "425081033", "story_v_out_425081.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_425081", "425081033", "story_v_out_425081.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play425081034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 425081034
		arg_140_1.duration_ = 2.07

		local var_140_0 = {
			zh = 2.066,
			ja = 1.333
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
				arg_140_0:Play425081035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1080"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1080 == nil then
				arg_140_1.var_.actorSpriteComps1080 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1080 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								local var_143_4 = Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, var_143_3)
								local var_143_5 = Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, var_143_3)
								local var_143_6 = Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, var_143_3)

								iter_143_1.color = Color.New(var_143_4, var_143_5, var_143_6)
							else
								local var_143_7 = Mathf.Lerp(iter_143_1.color.r, 1, var_143_3)

								iter_143_1.color = Color.New(var_143_7, var_143_7, var_143_7)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1080 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_143_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1080 = nil
			end

			local var_143_8 = arg_140_1.actors_["1080"].transform
			local var_143_9 = 0

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.var_.moveOldPos1080 = var_143_8.localPosition
				var_143_8.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1080", 3)

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
				local var_143_14 = Vector3.New(0, -378, -170)

				var_143_8.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1080, var_143_14, var_143_13)
			end

			if arg_140_1.time_ >= var_143_9 + var_143_12 and arg_140_1.time_ < var_143_9 + var_143_12 + arg_143_0 then
				var_143_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_143_15 = 0
			local var_143_16 = 0.05

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_17 = arg_140_1:FormatText(StoryNameCfg[55].name)

				arg_140_1.leftNameTxt_.text = var_143_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_18 = arg_140_1:GetWordFromCfg(425081034)
				local var_143_19 = arg_140_1:FormatText(var_143_18.content)

				arg_140_1.text_.text = var_143_19

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_20 = 2
				local var_143_21 = utf8.len(var_143_19)
				local var_143_22 = var_143_20 <= 0 and var_143_16 or var_143_16 * (var_143_21 / var_143_20)

				if var_143_22 > 0 and var_143_16 < var_143_22 then
					arg_140_1.talkMaxDuration = var_143_22

					if var_143_22 + var_143_15 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_22 + var_143_15
					end
				end

				arg_140_1.text_.text = var_143_19
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081034", "story_v_out_425081.awb") ~= 0 then
					local var_143_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081034", "story_v_out_425081.awb") / 1000

					if var_143_23 + var_143_15 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_23 + var_143_15
					end

					if var_143_18.prefab_name ~= "" and arg_140_1.actors_[var_143_18.prefab_name] ~= nil then
						local var_143_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_18.prefab_name].transform, "story_v_out_425081", "425081034", "story_v_out_425081.awb")

						arg_140_1:RecordAudio("425081034", var_143_24)
						arg_140_1:RecordAudio("425081034", var_143_24)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_425081", "425081034", "story_v_out_425081.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_425081", "425081034", "story_v_out_425081.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_25 = math.max(var_143_16, arg_140_1.talkMaxDuration)

			if var_143_15 <= arg_140_1.time_ and arg_140_1.time_ < var_143_15 + var_143_25 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_15) / var_143_25

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_15 + var_143_25 and arg_140_1.time_ < var_143_15 + var_143_25 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 425081035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play425081036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1080"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1080 = var_147_0.localPosition
				var_147_0.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1080", 7)

				local var_147_2 = var_147_0.childCount

				for iter_147_0 = 0, var_147_2 - 1 do
					local var_147_3 = var_147_0:GetChild(iter_147_0)

					if var_147_3.name == "" or not string.find(var_147_3.name, "split") then
						var_147_3.gameObject:SetActive(true)
					else
						var_147_3.gameObject:SetActive(false)
					end
				end
			end

			local var_147_4 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_4 then
				local var_147_5 = (arg_144_1.time_ - var_147_1) / var_147_4
				local var_147_6 = Vector3.New(0, -2000, 0)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1080, var_147_6, var_147_5)
			end

			if arg_144_1.time_ >= var_147_1 + var_147_4 and arg_144_1.time_ < var_147_1 + var_147_4 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_7 = 0
			local var_147_8 = 0.825

			if var_147_7 < arg_144_1.time_ and arg_144_1.time_ <= var_147_7 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_9 = arg_144_1:GetWordFromCfg(425081035)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 33
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_8 or var_147_8 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_8 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_7 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_7
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_8, arg_144_1.talkMaxDuration)

			if var_147_7 <= arg_144_1.time_ and arg_144_1.time_ < var_147_7 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_7) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_7 + var_147_14 and arg_144_1.time_ < var_147_7 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 425081036
		arg_148_1.duration_ = 5.6

		local var_148_0 = {
			zh = 4.433,
			ja = 5.6
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
				arg_148_0:Play425081037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.425

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[56].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(425081036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 17
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081036", "story_v_out_425081.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081036", "story_v_out_425081.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_425081", "425081036", "story_v_out_425081.awb")

						arg_148_1:RecordAudio("425081036", var_151_9)
						arg_148_1:RecordAudio("425081036", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_425081", "425081036", "story_v_out_425081.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_425081", "425081036", "story_v_out_425081.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_10 and arg_148_1.time_ < var_151_0 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play425081037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 425081037
		arg_152_1.duration_ = 5.23

		local var_152_0 = {
			zh = 5.233,
			ja = 5.166
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
				arg_152_0:Play425081038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.6

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[56].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(425081037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 24
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081037", "story_v_out_425081.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081037", "story_v_out_425081.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_425081", "425081037", "story_v_out_425081.awb")

						arg_152_1:RecordAudio("425081037", var_155_9)
						arg_152_1:RecordAudio("425081037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_425081", "425081037", "story_v_out_425081.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_425081", "425081037", "story_v_out_425081.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play425081038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 425081038
		arg_156_1.duration_ = 1.8

		local var_156_0 = {
			zh = 1.466,
			ja = 1.8
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
				arg_156_0:Play425081039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1080"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1080 = var_159_0.localPosition
				var_159_0.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1080", 3)

				local var_159_2 = var_159_0.childCount

				for iter_159_0 = 0, var_159_2 - 1 do
					local var_159_3 = var_159_0:GetChild(iter_159_0)

					if var_159_3.name == "" or not string.find(var_159_3.name, "split") then
						var_159_3.gameObject:SetActive(true)
					else
						var_159_3.gameObject:SetActive(false)
					end
				end
			end

			local var_159_4 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_4 then
				local var_159_5 = (arg_156_1.time_ - var_159_1) / var_159_4
				local var_159_6 = Vector3.New(0, -378, -170)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1080, var_159_6, var_159_5)
			end

			if arg_156_1.time_ >= var_159_1 + var_159_4 and arg_156_1.time_ < var_159_1 + var_159_4 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, -378, -170)
			end

			local var_159_7 = arg_156_1.actors_["1080"]
			local var_159_8 = 0

			if var_159_8 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 and not isNil(var_159_7) and arg_156_1.var_.actorSpriteComps1080 == nil then
				arg_156_1.var_.actorSpriteComps1080 = var_159_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_9 = 0.2

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_9 and not isNil(var_159_7) then
				local var_159_10 = (arg_156_1.time_ - var_159_8) / var_159_9

				if arg_156_1.var_.actorSpriteComps1080 then
					for iter_159_1, iter_159_2 in pairs(arg_156_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_159_2 then
							if arg_156_1.isInRecall_ then
								local var_159_11 = Mathf.Lerp(iter_159_2.color.r, arg_156_1.hightColor1.r, var_159_10)
								local var_159_12 = Mathf.Lerp(iter_159_2.color.g, arg_156_1.hightColor1.g, var_159_10)
								local var_159_13 = Mathf.Lerp(iter_159_2.color.b, arg_156_1.hightColor1.b, var_159_10)

								iter_159_2.color = Color.New(var_159_11, var_159_12, var_159_13)
							else
								local var_159_14 = Mathf.Lerp(iter_159_2.color.r, 1, var_159_10)

								iter_159_2.color = Color.New(var_159_14, var_159_14, var_159_14)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_8 + var_159_9 and arg_156_1.time_ < var_159_8 + var_159_9 + arg_159_0 and not isNil(var_159_7) and arg_156_1.var_.actorSpriteComps1080 then
				for iter_159_3, iter_159_4 in pairs(arg_156_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_159_4 then
						if arg_156_1.isInRecall_ then
							iter_159_4.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_159_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1080 = nil
			end

			local var_159_15 = 0
			local var_159_16 = 0.125

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_17 = arg_156_1:FormatText(StoryNameCfg[55].name)

				arg_156_1.leftNameTxt_.text = var_159_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_18 = arg_156_1:GetWordFromCfg(425081038)
				local var_159_19 = arg_156_1:FormatText(var_159_18.content)

				arg_156_1.text_.text = var_159_19

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_20 = 5
				local var_159_21 = utf8.len(var_159_19)
				local var_159_22 = var_159_20 <= 0 and var_159_16 or var_159_16 * (var_159_21 / var_159_20)

				if var_159_22 > 0 and var_159_16 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22

					if var_159_22 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_19
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081038", "story_v_out_425081.awb") ~= 0 then
					local var_159_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081038", "story_v_out_425081.awb") / 1000

					if var_159_23 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_15
					end

					if var_159_18.prefab_name ~= "" and arg_156_1.actors_[var_159_18.prefab_name] ~= nil then
						local var_159_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_18.prefab_name].transform, "story_v_out_425081", "425081038", "story_v_out_425081.awb")

						arg_156_1:RecordAudio("425081038", var_159_24)
						arg_156_1:RecordAudio("425081038", var_159_24)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_425081", "425081038", "story_v_out_425081.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_425081", "425081038", "story_v_out_425081.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_25 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_15) / var_159_25

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_15 + var_159_25 and arg_156_1.time_ < var_159_15 + var_159_25 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play425081039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 425081039
		arg_160_1.duration_ = 9.6

		local var_160_0 = {
			zh = 6.333,
			ja = 9.6
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
				arg_160_0:Play425081040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1080"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1080 == nil then
				arg_160_1.var_.actorSpriteComps1080 = var_163_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.actorSpriteComps1080 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1080 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_163_3 then
						if arg_160_1.isInRecall_ then
							iter_163_3.color = arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_163_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps1080 = nil
			end

			local var_163_8 = 0
			local var_163_9 = 0.575

			if var_163_8 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_10 = arg_160_1:FormatText(StoryNameCfg[56].name)

				arg_160_1.leftNameTxt_.text = var_163_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_11 = arg_160_1:GetWordFromCfg(425081039)
				local var_163_12 = arg_160_1:FormatText(var_163_11.content)

				arg_160_1.text_.text = var_163_12

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_13 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081039", "story_v_out_425081.awb") ~= 0 then
					local var_163_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081039", "story_v_out_425081.awb") / 1000

					if var_163_16 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_16 + var_163_8
					end

					if var_163_11.prefab_name ~= "" and arg_160_1.actors_[var_163_11.prefab_name] ~= nil then
						local var_163_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_11.prefab_name].transform, "story_v_out_425081", "425081039", "story_v_out_425081.awb")

						arg_160_1:RecordAudio("425081039", var_163_17)
						arg_160_1:RecordAudio("425081039", var_163_17)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_425081", "425081039", "story_v_out_425081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_425081", "425081039", "story_v_out_425081.awb")
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
	Play425081040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 425081040
		arg_164_1.duration_ = 1.6

		local var_164_0 = {
			zh = 1.6,
			ja = 0.999999999999
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
				arg_164_0:Play425081041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1080"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.actorSpriteComps1080 == nil then
				arg_164_1.var_.actorSpriteComps1080 = var_167_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_2 = 0.2

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.actorSpriteComps1080 then
					for iter_167_0, iter_167_1 in pairs(arg_164_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_167_1 then
							if arg_164_1.isInRecall_ then
								local var_167_4 = Mathf.Lerp(iter_167_1.color.r, arg_164_1.hightColor1.r, var_167_3)
								local var_167_5 = Mathf.Lerp(iter_167_1.color.g, arg_164_1.hightColor1.g, var_167_3)
								local var_167_6 = Mathf.Lerp(iter_167_1.color.b, arg_164_1.hightColor1.b, var_167_3)

								iter_167_1.color = Color.New(var_167_4, var_167_5, var_167_6)
							else
								local var_167_7 = Mathf.Lerp(iter_167_1.color.r, 1, var_167_3)

								iter_167_1.color = Color.New(var_167_7, var_167_7, var_167_7)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.actorSpriteComps1080 then
				for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_167_3 then
						if arg_164_1.isInRecall_ then
							iter_167_3.color = arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_167_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_164_1.var_.actorSpriteComps1080 = nil
			end

			local var_167_8 = 0
			local var_167_9 = 0.05

			if var_167_8 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_10 = arg_164_1:FormatText(StoryNameCfg[55].name)

				arg_164_1.leftNameTxt_.text = var_167_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_11 = arg_164_1:GetWordFromCfg(425081040)
				local var_167_12 = arg_164_1:FormatText(var_167_11.content)

				arg_164_1.text_.text = var_167_12

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_13 = 2
				local var_167_14 = utf8.len(var_167_12)
				local var_167_15 = var_167_13 <= 0 and var_167_9 or var_167_9 * (var_167_14 / var_167_13)

				if var_167_15 > 0 and var_167_9 < var_167_15 then
					arg_164_1.talkMaxDuration = var_167_15

					if var_167_15 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_15 + var_167_8
					end
				end

				arg_164_1.text_.text = var_167_12
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081040", "story_v_out_425081.awb") ~= 0 then
					local var_167_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081040", "story_v_out_425081.awb") / 1000

					if var_167_16 + var_167_8 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_16 + var_167_8
					end

					if var_167_11.prefab_name ~= "" and arg_164_1.actors_[var_167_11.prefab_name] ~= nil then
						local var_167_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_11.prefab_name].transform, "story_v_out_425081", "425081040", "story_v_out_425081.awb")

						arg_164_1:RecordAudio("425081040", var_167_17)
						arg_164_1:RecordAudio("425081040", var_167_17)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_425081", "425081040", "story_v_out_425081.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_425081", "425081040", "story_v_out_425081.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_18 = math.max(var_167_9, arg_164_1.talkMaxDuration)

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_18 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_8) / var_167_18

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_8 + var_167_18 and arg_164_1.time_ < var_167_8 + var_167_18 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play425081041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 425081041
		arg_168_1.duration_ = 11.17

		local var_168_0 = {
			zh = 6.666,
			ja = 11.166
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
				arg_168_0:Play425081042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1080"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1080 == nil then
				arg_168_1.var_.actorSpriteComps1080 = var_171_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.actorSpriteComps1080 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_171_1 then
							if arg_168_1.isInRecall_ then
								local var_171_4 = Mathf.Lerp(iter_171_1.color.r, arg_168_1.hightColor2.r, var_171_3)
								local var_171_5 = Mathf.Lerp(iter_171_1.color.g, arg_168_1.hightColor2.g, var_171_3)
								local var_171_6 = Mathf.Lerp(iter_171_1.color.b, arg_168_1.hightColor2.b, var_171_3)

								iter_171_1.color = Color.New(var_171_4, var_171_5, var_171_6)
							else
								local var_171_7 = Mathf.Lerp(iter_171_1.color.r, 0.5, var_171_3)

								iter_171_1.color = Color.New(var_171_7, var_171_7, var_171_7)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1080 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_171_3 then
						if arg_168_1.isInRecall_ then
							iter_171_3.color = arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_171_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps1080 = nil
			end

			local var_171_8 = 0
			local var_171_9 = 0.675

			if var_171_8 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_10 = arg_168_1:FormatText(StoryNameCfg[56].name)

				arg_168_1.leftNameTxt_.text = var_171_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_11 = arg_168_1:GetWordFromCfg(425081041)
				local var_171_12 = arg_168_1:FormatText(var_171_11.content)

				arg_168_1.text_.text = var_171_12

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_13 = 27
				local var_171_14 = utf8.len(var_171_12)
				local var_171_15 = var_171_13 <= 0 and var_171_9 or var_171_9 * (var_171_14 / var_171_13)

				if var_171_15 > 0 and var_171_9 < var_171_15 then
					arg_168_1.talkMaxDuration = var_171_15

					if var_171_15 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_15 + var_171_8
					end
				end

				arg_168_1.text_.text = var_171_12
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081041", "story_v_out_425081.awb") ~= 0 then
					local var_171_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081041", "story_v_out_425081.awb") / 1000

					if var_171_16 + var_171_8 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_16 + var_171_8
					end

					if var_171_11.prefab_name ~= "" and arg_168_1.actors_[var_171_11.prefab_name] ~= nil then
						local var_171_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_11.prefab_name].transform, "story_v_out_425081", "425081041", "story_v_out_425081.awb")

						arg_168_1:RecordAudio("425081041", var_171_17)
						arg_168_1:RecordAudio("425081041", var_171_17)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_425081", "425081041", "story_v_out_425081.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_425081", "425081041", "story_v_out_425081.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_18 = math.max(var_171_9, arg_168_1.talkMaxDuration)

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_18 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_8) / var_171_18

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_8 + var_171_18 and arg_168_1.time_ < var_171_8 + var_171_18 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play425081042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 425081042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play425081043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1080"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1080 = var_175_0.localPosition
				var_175_0.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("1080", 7)

				local var_175_2 = var_175_0.childCount

				for iter_175_0 = 0, var_175_2 - 1 do
					local var_175_3 = var_175_0:GetChild(iter_175_0)

					if var_175_3.name == "" or not string.find(var_175_3.name, "split") then
						var_175_3.gameObject:SetActive(true)
					else
						var_175_3.gameObject:SetActive(false)
					end
				end
			end

			local var_175_4 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_4 then
				local var_175_5 = (arg_172_1.time_ - var_175_1) / var_175_4
				local var_175_6 = Vector3.New(0, -2000, 0)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1080, var_175_6, var_175_5)
			end

			if arg_172_1.time_ >= var_175_1 + var_175_4 and arg_172_1.time_ < var_175_1 + var_175_4 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_175_7 = 0
			local var_175_8 = 1.025

			if var_175_7 < arg_172_1.time_ and arg_172_1.time_ <= var_175_7 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_9 = arg_172_1:GetWordFromCfg(425081042)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 41
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_8 or var_175_8 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_8 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_7 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_7
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_8, arg_172_1.talkMaxDuration)

			if var_175_7 <= arg_172_1.time_ and arg_172_1.time_ < var_175_7 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_7) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_7 + var_175_14 and arg_172_1.time_ < var_175_7 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 425081043
		arg_176_1.duration_ = 3.83

		local var_176_0 = {
			zh = 1.1,
			ja = 3.833
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
				arg_176_0:Play425081044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1080"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1080 == nil then
				arg_176_1.var_.actorSpriteComps1080 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps1080 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1080 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps1080 = nil
			end

			local var_179_8 = arg_176_1.actors_["1080"].transform
			local var_179_9 = 0

			if var_179_9 < arg_176_1.time_ and arg_176_1.time_ <= var_179_9 + arg_179_0 then
				arg_176_1.var_.moveOldPos1080 = var_179_8.localPosition
				var_179_8.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("1080", 3)

				local var_179_10 = var_179_8.childCount

				for iter_179_4 = 0, var_179_10 - 1 do
					local var_179_11 = var_179_8:GetChild(iter_179_4)

					if var_179_11.name == "" or not string.find(var_179_11.name, "split") then
						var_179_11.gameObject:SetActive(true)
					else
						var_179_11.gameObject:SetActive(false)
					end
				end
			end

			local var_179_12 = 0.001

			if var_179_9 <= arg_176_1.time_ and arg_176_1.time_ < var_179_9 + var_179_12 then
				local var_179_13 = (arg_176_1.time_ - var_179_9) / var_179_12
				local var_179_14 = Vector3.New(0, -378, -170)

				var_179_8.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1080, var_179_14, var_179_13)
			end

			if arg_176_1.time_ >= var_179_9 + var_179_12 and arg_176_1.time_ < var_179_9 + var_179_12 + arg_179_0 then
				var_179_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_179_15 = 0
			local var_179_16 = 0.1

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[55].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(425081043)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 4
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081043", "story_v_out_425081.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081043", "story_v_out_425081.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_out_425081", "425081043", "story_v_out_425081.awb")

						arg_176_1:RecordAudio("425081043", var_179_24)
						arg_176_1:RecordAudio("425081043", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_425081", "425081043", "story_v_out_425081.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_425081", "425081043", "story_v_out_425081.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_25 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_25 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_25

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_25 and arg_176_1.time_ < var_179_15 + var_179_25 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play425081044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 425081044
		arg_180_1.duration_ = 1.7

		local var_180_0 = {
			zh = 1.7,
			ja = 1.566
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
				arg_180_0:Play425081045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1080"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1080 == nil then
				arg_180_1.var_.actorSpriteComps1080 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps1080 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								local var_183_4 = Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor2.r, var_183_3)
								local var_183_5 = Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor2.g, var_183_3)
								local var_183_6 = Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor2.b, var_183_3)

								iter_183_1.color = Color.New(var_183_4, var_183_5, var_183_6)
							else
								local var_183_7 = Mathf.Lerp(iter_183_1.color.r, 0.5, var_183_3)

								iter_183_1.color = Color.New(var_183_7, var_183_7, var_183_7)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1080 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1080 = nil
			end

			local var_183_8 = 0
			local var_183_9 = 0.075

			if var_183_8 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_10 = arg_180_1:FormatText(StoryNameCfg[56].name)

				arg_180_1.leftNameTxt_.text = var_183_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_11 = arg_180_1:GetWordFromCfg(425081044)
				local var_183_12 = arg_180_1:FormatText(var_183_11.content)

				arg_180_1.text_.text = var_183_12

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081044", "story_v_out_425081.awb") ~= 0 then
					local var_183_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081044", "story_v_out_425081.awb") / 1000

					if var_183_16 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_16 + var_183_8
					end

					if var_183_11.prefab_name ~= "" and arg_180_1.actors_[var_183_11.prefab_name] ~= nil then
						local var_183_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_11.prefab_name].transform, "story_v_out_425081", "425081044", "story_v_out_425081.awb")

						arg_180_1:RecordAudio("425081044", var_183_17)
						arg_180_1:RecordAudio("425081044", var_183_17)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_425081", "425081044", "story_v_out_425081.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_425081", "425081044", "story_v_out_425081.awb")
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
	Play425081045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 425081045
		arg_184_1.duration_ = 7.1

		local var_184_0 = {
			zh = 5.266,
			ja = 7.1
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
				arg_184_0:Play425081046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1080"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1080 == nil then
				arg_184_1.var_.actorSpriteComps1080 = var_187_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_2 = 0.2

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.actorSpriteComps1080 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.actorSpriteComps1080 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_187_3 then
						if arg_184_1.isInRecall_ then
							iter_187_3.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps1080 = nil
			end

			local var_187_8 = 0
			local var_187_9 = 0.7

			if var_187_8 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_10 = arg_184_1:FormatText(StoryNameCfg[55].name)

				arg_184_1.leftNameTxt_.text = var_187_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_11 = arg_184_1:GetWordFromCfg(425081045)
				local var_187_12 = arg_184_1:FormatText(var_187_11.content)

				arg_184_1.text_.text = var_187_12

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_13 = 28
				local var_187_14 = utf8.len(var_187_12)
				local var_187_15 = var_187_13 <= 0 and var_187_9 or var_187_9 * (var_187_14 / var_187_13)

				if var_187_15 > 0 and var_187_9 < var_187_15 then
					arg_184_1.talkMaxDuration = var_187_15

					if var_187_15 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_15 + var_187_8
					end
				end

				arg_184_1.text_.text = var_187_12
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081045", "story_v_out_425081.awb") ~= 0 then
					local var_187_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081045", "story_v_out_425081.awb") / 1000

					if var_187_16 + var_187_8 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_16 + var_187_8
					end

					if var_187_11.prefab_name ~= "" and arg_184_1.actors_[var_187_11.prefab_name] ~= nil then
						local var_187_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_11.prefab_name].transform, "story_v_out_425081", "425081045", "story_v_out_425081.awb")

						arg_184_1:RecordAudio("425081045", var_187_17)
						arg_184_1:RecordAudio("425081045", var_187_17)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_425081", "425081045", "story_v_out_425081.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_425081", "425081045", "story_v_out_425081.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_18 = math.max(var_187_9, arg_184_1.talkMaxDuration)

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_18 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_8) / var_187_18

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_8 + var_187_18 and arg_184_1.time_ < var_187_8 + var_187_18 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play425081046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 425081046
		arg_188_1.duration_ = 2.83

		local var_188_0 = {
			zh = 2.3,
			ja = 2.833
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
				arg_188_0:Play425081047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1080"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps1080 == nil then
				arg_188_1.var_.actorSpriteComps1080 = var_191_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_2 = 0.2

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.actorSpriteComps1080 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.actorSpriteComps1080 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_191_3 then
						if arg_188_1.isInRecall_ then
							iter_191_3.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps1080 = nil
			end

			local var_191_8 = 0
			local var_191_9 = 0.15

			if var_191_8 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_10 = arg_188_1:FormatText(StoryNameCfg[56].name)

				arg_188_1.leftNameTxt_.text = var_191_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_11 = arg_188_1:GetWordFromCfg(425081046)
				local var_191_12 = arg_188_1:FormatText(var_191_11.content)

				arg_188_1.text_.text = var_191_12

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081046", "story_v_out_425081.awb") ~= 0 then
					local var_191_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081046", "story_v_out_425081.awb") / 1000

					if var_191_16 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_16 + var_191_8
					end

					if var_191_11.prefab_name ~= "" and arg_188_1.actors_[var_191_11.prefab_name] ~= nil then
						local var_191_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_11.prefab_name].transform, "story_v_out_425081", "425081046", "story_v_out_425081.awb")

						arg_188_1:RecordAudio("425081046", var_191_17)
						arg_188_1:RecordAudio("425081046", var_191_17)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_425081", "425081046", "story_v_out_425081.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_425081", "425081046", "story_v_out_425081.awb")
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
	Play425081047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 425081047
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play425081048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1080"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos1080 = var_195_0.localPosition
				var_195_0.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1080", 7)

				local var_195_2 = var_195_0.childCount

				for iter_195_0 = 0, var_195_2 - 1 do
					local var_195_3 = var_195_0:GetChild(iter_195_0)

					if var_195_3.name == "" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_4 then
				local var_195_5 = (arg_192_1.time_ - var_195_1) / var_195_4
				local var_195_6 = Vector3.New(0, -2000, 0)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1080, var_195_6, var_195_5)
			end

			if arg_192_1.time_ >= var_195_1 + var_195_4 and arg_192_1.time_ < var_195_1 + var_195_4 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_195_7 = 0
			local var_195_8 = 1.15

			if var_195_7 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_9 = arg_192_1:GetWordFromCfg(425081047)
				local var_195_10 = arg_192_1:FormatText(var_195_9.content)

				arg_192_1.text_.text = var_195_10

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_11 = 46
				local var_195_12 = utf8.len(var_195_10)
				local var_195_13 = var_195_11 <= 0 and var_195_8 or var_195_8 * (var_195_12 / var_195_11)

				if var_195_13 > 0 and var_195_8 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_7
					end
				end

				arg_192_1.text_.text = var_195_10
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_14 = math.max(var_195_8, arg_192_1.talkMaxDuration)

			if var_195_7 <= arg_192_1.time_ and arg_192_1.time_ < var_195_7 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_7) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_7 + var_195_14 and arg_192_1.time_ < var_195_7 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play425081048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 425081048
		arg_196_1.duration_ = 6.1

		local var_196_0 = {
			zh = 3.833,
			ja = 6.1
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
				arg_196_0:Play425081049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1080"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps1080 == nil then
				arg_196_1.var_.actorSpriteComps1080 = var_199_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_2 = 0.2

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.actorSpriteComps1080 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								local var_199_4 = Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, var_199_3)
								local var_199_5 = Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, var_199_3)
								local var_199_6 = Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, var_199_3)

								iter_199_1.color = Color.New(var_199_4, var_199_5, var_199_6)
							else
								local var_199_7 = Mathf.Lerp(iter_199_1.color.r, 1, var_199_3)

								iter_199_1.color = Color.New(var_199_7, var_199_7, var_199_7)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.actorSpriteComps1080 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_199_3 then
						if arg_196_1.isInRecall_ then
							iter_199_3.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps1080 = nil
			end

			local var_199_8 = arg_196_1.actors_["1080"].transform
			local var_199_9 = 0

			if var_199_9 < arg_196_1.time_ and arg_196_1.time_ <= var_199_9 + arg_199_0 then
				arg_196_1.var_.moveOldPos1080 = var_199_8.localPosition
				var_199_8.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1080", 3)

				local var_199_10 = var_199_8.childCount

				for iter_199_4 = 0, var_199_10 - 1 do
					local var_199_11 = var_199_8:GetChild(iter_199_4)

					if var_199_11.name == "" or not string.find(var_199_11.name, "split") then
						var_199_11.gameObject:SetActive(true)
					else
						var_199_11.gameObject:SetActive(false)
					end
				end
			end

			local var_199_12 = 0.001

			if var_199_9 <= arg_196_1.time_ and arg_196_1.time_ < var_199_9 + var_199_12 then
				local var_199_13 = (arg_196_1.time_ - var_199_9) / var_199_12
				local var_199_14 = Vector3.New(0, -378, -170)

				var_199_8.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1080, var_199_14, var_199_13)
			end

			if arg_196_1.time_ >= var_199_9 + var_199_12 and arg_196_1.time_ < var_199_9 + var_199_12 + arg_199_0 then
				var_199_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_199_15 = 0
			local var_199_16 = 0.375

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_17 = arg_196_1:FormatText(StoryNameCfg[55].name)

				arg_196_1.leftNameTxt_.text = var_199_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_18 = arg_196_1:GetWordFromCfg(425081048)
				local var_199_19 = arg_196_1:FormatText(var_199_18.content)

				arg_196_1.text_.text = var_199_19

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_20 = 15
				local var_199_21 = utf8.len(var_199_19)
				local var_199_22 = var_199_20 <= 0 and var_199_16 or var_199_16 * (var_199_21 / var_199_20)

				if var_199_22 > 0 and var_199_16 < var_199_22 then
					arg_196_1.talkMaxDuration = var_199_22

					if var_199_22 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_22 + var_199_15
					end
				end

				arg_196_1.text_.text = var_199_19
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081048", "story_v_out_425081.awb") ~= 0 then
					local var_199_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081048", "story_v_out_425081.awb") / 1000

					if var_199_23 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_23 + var_199_15
					end

					if var_199_18.prefab_name ~= "" and arg_196_1.actors_[var_199_18.prefab_name] ~= nil then
						local var_199_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_18.prefab_name].transform, "story_v_out_425081", "425081048", "story_v_out_425081.awb")

						arg_196_1:RecordAudio("425081048", var_199_24)
						arg_196_1:RecordAudio("425081048", var_199_24)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_425081", "425081048", "story_v_out_425081.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_425081", "425081048", "story_v_out_425081.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_25 = math.max(var_199_16, arg_196_1.talkMaxDuration)

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_25 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_15) / var_199_25

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_15 + var_199_25 and arg_196_1.time_ < var_199_15 + var_199_25 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 425081049
		arg_200_1.duration_ = 8.57

		local var_200_0 = {
			zh = 7.2,
			ja = 8.566
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
				arg_200_0:Play425081050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1080"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos1080 = var_203_0.localPosition
				var_203_0.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1080", 3)

				local var_203_2 = var_203_0.childCount

				for iter_203_0 = 0, var_203_2 - 1 do
					local var_203_3 = var_203_0:GetChild(iter_203_0)

					if var_203_3.name == "" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_4 then
				local var_203_5 = (arg_200_1.time_ - var_203_1) / var_203_4
				local var_203_6 = Vector3.New(0, -378, -170)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1080, var_203_6, var_203_5)
			end

			if arg_200_1.time_ >= var_203_1 + var_203_4 and arg_200_1.time_ < var_203_1 + var_203_4 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -378, -170)
			end

			local var_203_7 = 0
			local var_203_8 = 0.675

			if var_203_7 < arg_200_1.time_ and arg_200_1.time_ <= var_203_7 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_9 = arg_200_1:FormatText(StoryNameCfg[55].name)

				arg_200_1.leftNameTxt_.text = var_203_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_10 = arg_200_1:GetWordFromCfg(425081049)
				local var_203_11 = arg_200_1:FormatText(var_203_10.content)

				arg_200_1.text_.text = var_203_11

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_12 = 27
				local var_203_13 = utf8.len(var_203_11)
				local var_203_14 = var_203_12 <= 0 and var_203_8 or var_203_8 * (var_203_13 / var_203_12)

				if var_203_14 > 0 and var_203_8 < var_203_14 then
					arg_200_1.talkMaxDuration = var_203_14

					if var_203_14 + var_203_7 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_14 + var_203_7
					end
				end

				arg_200_1.text_.text = var_203_11
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081049", "story_v_out_425081.awb") ~= 0 then
					local var_203_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081049", "story_v_out_425081.awb") / 1000

					if var_203_15 + var_203_7 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_15 + var_203_7
					end

					if var_203_10.prefab_name ~= "" and arg_200_1.actors_[var_203_10.prefab_name] ~= nil then
						local var_203_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_10.prefab_name].transform, "story_v_out_425081", "425081049", "story_v_out_425081.awb")

						arg_200_1:RecordAudio("425081049", var_203_16)
						arg_200_1:RecordAudio("425081049", var_203_16)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_425081", "425081049", "story_v_out_425081.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_425081", "425081049", "story_v_out_425081.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_17 = math.max(var_203_8, arg_200_1.talkMaxDuration)

			if var_203_7 <= arg_200_1.time_ and arg_200_1.time_ < var_203_7 + var_203_17 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_7) / var_203_17

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_7 + var_203_17 and arg_200_1.time_ < var_203_7 + var_203_17 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 425081050
		arg_204_1.duration_ = 5

		local var_204_0 = {
			zh = 4.833,
			ja = 5
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
				arg_204_0:Play425081051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1080"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos1080 = var_207_0.localPosition
				var_207_0.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("1080", 7)

				local var_207_2 = var_207_0.childCount

				for iter_207_0 = 0, var_207_2 - 1 do
					local var_207_3 = var_207_0:GetChild(iter_207_0)

					if var_207_3.name == "" or not string.find(var_207_3.name, "split") then
						var_207_3.gameObject:SetActive(true)
					else
						var_207_3.gameObject:SetActive(false)
					end
				end
			end

			local var_207_4 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_4 then
				local var_207_5 = (arg_204_1.time_ - var_207_1) / var_207_4
				local var_207_6 = Vector3.New(0, -2000, 0)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1080, var_207_6, var_207_5)
			end

			if arg_204_1.time_ >= var_207_1 + var_207_4 and arg_204_1.time_ < var_207_1 + var_207_4 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_207_7 = 0
			local var_207_8 = 0.275

			if var_207_7 < arg_204_1.time_ and arg_204_1.time_ <= var_207_7 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_9 = arg_204_1:FormatText(StoryNameCfg[56].name)

				arg_204_1.leftNameTxt_.text = var_207_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_10 = arg_204_1:GetWordFromCfg(425081050)
				local var_207_11 = arg_204_1:FormatText(var_207_10.content)

				arg_204_1.text_.text = var_207_11

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_12 = 11
				local var_207_13 = utf8.len(var_207_11)
				local var_207_14 = var_207_12 <= 0 and var_207_8 or var_207_8 * (var_207_13 / var_207_12)

				if var_207_14 > 0 and var_207_8 < var_207_14 then
					arg_204_1.talkMaxDuration = var_207_14

					if var_207_14 + var_207_7 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_7
					end
				end

				arg_204_1.text_.text = var_207_11
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081050", "story_v_out_425081.awb") ~= 0 then
					local var_207_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081050", "story_v_out_425081.awb") / 1000

					if var_207_15 + var_207_7 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_15 + var_207_7
					end

					if var_207_10.prefab_name ~= "" and arg_204_1.actors_[var_207_10.prefab_name] ~= nil then
						local var_207_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_10.prefab_name].transform, "story_v_out_425081", "425081050", "story_v_out_425081.awb")

						arg_204_1:RecordAudio("425081050", var_207_16)
						arg_204_1:RecordAudio("425081050", var_207_16)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_425081", "425081050", "story_v_out_425081.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_425081", "425081050", "story_v_out_425081.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_17 = math.max(var_207_8, arg_204_1.talkMaxDuration)

			if var_207_7 <= arg_204_1.time_ and arg_204_1.time_ < var_207_7 + var_207_17 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_7) / var_207_17

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_7 + var_207_17 and arg_204_1.time_ < var_207_7 + var_207_17 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 425081051
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play425081052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = "1027"

			if arg_208_1.actors_[var_211_0] == nil then
				local var_211_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1027")

				if not isNil(var_211_1) then
					local var_211_2 = Object.Instantiate(var_211_1, arg_208_1.canvasGo_.transform)

					var_211_2.transform:SetSiblingIndex(1)

					var_211_2.name = var_211_0
					var_211_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_208_1.actors_[var_211_0] = var_211_2

					local var_211_3 = var_211_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_208_1.isInRecall_ then
						for iter_211_0, iter_211_1 in ipairs(var_211_3) do
							iter_211_1.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_211_4 = arg_208_1.actors_["1027"].transform
			local var_211_5 = 0

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1.var_.moveOldPos1027 = var_211_4.localPosition
				var_211_4.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("1027", 7)

				local var_211_6 = var_211_4.childCount

				for iter_211_2 = 0, var_211_6 - 1 do
					local var_211_7 = var_211_4:GetChild(iter_211_2)

					if var_211_7.name == "" or not string.find(var_211_7.name, "split") then
						var_211_7.gameObject:SetActive(true)
					else
						var_211_7.gameObject:SetActive(false)
					end
				end
			end

			local var_211_8 = 0.001

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_8 then
				local var_211_9 = (arg_208_1.time_ - var_211_5) / var_211_8
				local var_211_10 = Vector3.New(0, -2000, 0)

				var_211_4.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1027, var_211_10, var_211_9)
			end

			if arg_208_1.time_ >= var_211_5 + var_211_8 and arg_208_1.time_ < var_211_5 + var_211_8 + arg_211_0 then
				var_211_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_211_11 = 0.133333333333333
			local var_211_12 = 1

			if var_211_11 < arg_208_1.time_ and arg_208_1.time_ <= var_211_11 + arg_211_0 then
				local var_211_13 = "play"
				local var_211_14 = "effect"

				arg_208_1:AudioAction(var_211_13, var_211_14, "se_story_1311", "se_story_1311_clap01", "")
			end

			local var_211_15 = 0
			local var_211_16 = 0.825

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_17 = arg_208_1:GetWordFromCfg(425081051)
				local var_211_18 = arg_208_1:FormatText(var_211_17.content)

				arg_208_1.text_.text = var_211_18

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_19 = 33
				local var_211_20 = utf8.len(var_211_18)
				local var_211_21 = var_211_19 <= 0 and var_211_16 or var_211_16 * (var_211_20 / var_211_19)

				if var_211_21 > 0 and var_211_16 < var_211_21 then
					arg_208_1.talkMaxDuration = var_211_21

					if var_211_21 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_21 + var_211_15
					end
				end

				arg_208_1.text_.text = var_211_18
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_22 = math.max(var_211_16, arg_208_1.talkMaxDuration)

			if var_211_15 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_22 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_15) / var_211_22

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_15 + var_211_22 and arg_208_1.time_ < var_211_15 + var_211_22 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027",
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
	Play425081052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 425081052
		arg_212_1.duration_ = 2.03

		local var_212_0 = {
			zh = 1.5,
			ja = 2.033
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
				arg_212_0:Play425081053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1080"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps1080 == nil then
				arg_212_1.var_.actorSpriteComps1080 = var_215_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_2 = 0.2

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.actorSpriteComps1080 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.actorSpriteComps1080 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_215_3 then
						if arg_212_1.isInRecall_ then
							iter_215_3.color = arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_215_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_212_1.var_.actorSpriteComps1080 = nil
			end

			local var_215_8 = arg_212_1.actors_["1080"].transform
			local var_215_9 = 0

			if var_215_9 < arg_212_1.time_ and arg_212_1.time_ <= var_215_9 + arg_215_0 then
				arg_212_1.var_.moveOldPos1080 = var_215_8.localPosition
				var_215_8.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("1080", 2)

				local var_215_10 = var_215_8.childCount

				for iter_215_4 = 0, var_215_10 - 1 do
					local var_215_11 = var_215_8:GetChild(iter_215_4)

					if var_215_11.name == "" or not string.find(var_215_11.name, "split") then
						var_215_11.gameObject:SetActive(true)
					else
						var_215_11.gameObject:SetActive(false)
					end
				end
			end

			local var_215_12 = 0.001

			if var_215_9 <= arg_212_1.time_ and arg_212_1.time_ < var_215_9 + var_215_12 then
				local var_215_13 = (arg_212_1.time_ - var_215_9) / var_215_12
				local var_215_14 = Vector3.New(-390, -378, -170)

				var_215_8.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1080, var_215_14, var_215_13)
			end

			if arg_212_1.time_ >= var_215_9 + var_215_12 and arg_212_1.time_ < var_215_9 + var_215_12 + arg_215_0 then
				var_215_8.localPosition = Vector3.New(-390, -378, -170)
			end

			local var_215_15 = 0
			local var_215_16 = 0.175

			if var_215_15 < arg_212_1.time_ and arg_212_1.time_ <= var_215_15 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_17 = arg_212_1:FormatText(StoryNameCfg[55].name)

				arg_212_1.leftNameTxt_.text = var_215_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_18 = arg_212_1:GetWordFromCfg(425081052)
				local var_215_19 = arg_212_1:FormatText(var_215_18.content)

				arg_212_1.text_.text = var_215_19

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_20 = 7
				local var_215_21 = utf8.len(var_215_19)
				local var_215_22 = var_215_20 <= 0 and var_215_16 or var_215_16 * (var_215_21 / var_215_20)

				if var_215_22 > 0 and var_215_16 < var_215_22 then
					arg_212_1.talkMaxDuration = var_215_22

					if var_215_22 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_22 + var_215_15
					end
				end

				arg_212_1.text_.text = var_215_19
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081052", "story_v_out_425081.awb") ~= 0 then
					local var_215_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081052", "story_v_out_425081.awb") / 1000

					if var_215_23 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_23 + var_215_15
					end

					if var_215_18.prefab_name ~= "" and arg_212_1.actors_[var_215_18.prefab_name] ~= nil then
						local var_215_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_18.prefab_name].transform, "story_v_out_425081", "425081052", "story_v_out_425081.awb")

						arg_212_1:RecordAudio("425081052", var_215_24)
						arg_212_1:RecordAudio("425081052", var_215_24)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_425081", "425081052", "story_v_out_425081.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_425081", "425081052", "story_v_out_425081.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_25 = math.max(var_215_16, arg_212_1.talkMaxDuration)

			if var_215_15 <= arg_212_1.time_ and arg_212_1.time_ < var_215_15 + var_215_25 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_15) / var_215_25

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_15 + var_215_25 and arg_212_1.time_ < var_215_15 + var_215_25 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 425081053
		arg_216_1.duration_ = 10.93

		local var_216_0 = {
			zh = 10.933,
			ja = 8.6
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
				arg_216_0:Play425081054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1086"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1086 == nil then
				arg_216_1.var_.actorSpriteComps1086 = var_219_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_2 = 0.2

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.actorSpriteComps1086 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.actorSpriteComps1086 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_219_3 then
						if arg_216_1.isInRecall_ then
							iter_219_3.color = arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_219_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps1086 = nil
			end

			local var_219_8 = arg_216_1.actors_["1080"]
			local var_219_9 = 0

			if var_219_9 < arg_216_1.time_ and arg_216_1.time_ <= var_219_9 + arg_219_0 and not isNil(var_219_8) and arg_216_1.var_.actorSpriteComps1080 == nil then
				arg_216_1.var_.actorSpriteComps1080 = var_219_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_10 = 0.2

			if var_219_9 <= arg_216_1.time_ and arg_216_1.time_ < var_219_9 + var_219_10 and not isNil(var_219_8) then
				local var_219_11 = (arg_216_1.time_ - var_219_9) / var_219_10

				if arg_216_1.var_.actorSpriteComps1080 then
					for iter_219_4, iter_219_5 in pairs(arg_216_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_216_1.time_ >= var_219_9 + var_219_10 and arg_216_1.time_ < var_219_9 + var_219_10 + arg_219_0 and not isNil(var_219_8) and arg_216_1.var_.actorSpriteComps1080 then
				for iter_219_6, iter_219_7 in pairs(arg_216_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_219_7 then
						if arg_216_1.isInRecall_ then
							iter_219_7.color = arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_219_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_216_1.var_.actorSpriteComps1080 = nil
			end

			local var_219_16 = arg_216_1.actors_["1086"].transform
			local var_219_17 = 0

			if var_219_17 < arg_216_1.time_ and arg_216_1.time_ <= var_219_17 + arg_219_0 then
				arg_216_1.var_.moveOldPos1086 = var_219_16.localPosition
				var_219_16.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1086", 4)

				local var_219_18 = var_219_16.childCount

				for iter_219_8 = 0, var_219_18 - 1 do
					local var_219_19 = var_219_16:GetChild(iter_219_8)

					if var_219_19.name == "split_1" or not string.find(var_219_19.name, "split") then
						var_219_19.gameObject:SetActive(true)
					else
						var_219_19.gameObject:SetActive(false)
					end
				end
			end

			local var_219_20 = 0.001

			if var_219_17 <= arg_216_1.time_ and arg_216_1.time_ < var_219_17 + var_219_20 then
				local var_219_21 = (arg_216_1.time_ - var_219_17) / var_219_20
				local var_219_22 = Vector3.New(390, -404.2, -237.9)

				var_219_16.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1086, var_219_22, var_219_21)
			end

			if arg_216_1.time_ >= var_219_17 + var_219_20 and arg_216_1.time_ < var_219_17 + var_219_20 + arg_219_0 then
				var_219_16.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_219_23 = 0
			local var_219_24 = 1.25

			if var_219_23 < arg_216_1.time_ and arg_216_1.time_ <= var_219_23 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_25 = arg_216_1:FormatText(StoryNameCfg[1080].name)

				arg_216_1.leftNameTxt_.text = var_219_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_26 = arg_216_1:GetWordFromCfg(425081053)
				local var_219_27 = arg_216_1:FormatText(var_219_26.content)

				arg_216_1.text_.text = var_219_27

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_28 = 50
				local var_219_29 = utf8.len(var_219_27)
				local var_219_30 = var_219_28 <= 0 and var_219_24 or var_219_24 * (var_219_29 / var_219_28)

				if var_219_30 > 0 and var_219_24 < var_219_30 then
					arg_216_1.talkMaxDuration = var_219_30

					if var_219_30 + var_219_23 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_30 + var_219_23
					end
				end

				arg_216_1.text_.text = var_219_27
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081053", "story_v_out_425081.awb") ~= 0 then
					local var_219_31 = manager.audio:GetVoiceLength("story_v_out_425081", "425081053", "story_v_out_425081.awb") / 1000

					if var_219_31 + var_219_23 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_31 + var_219_23
					end

					if var_219_26.prefab_name ~= "" and arg_216_1.actors_[var_219_26.prefab_name] ~= nil then
						local var_219_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_26.prefab_name].transform, "story_v_out_425081", "425081053", "story_v_out_425081.awb")

						arg_216_1:RecordAudio("425081053", var_219_32)
						arg_216_1:RecordAudio("425081053", var_219_32)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_425081", "425081053", "story_v_out_425081.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_425081", "425081053", "story_v_out_425081.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_33 = math.max(var_219_24, arg_216_1.talkMaxDuration)

			if var_219_23 <= arg_216_1.time_ and arg_216_1.time_ < var_219_23 + var_219_33 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_23) / var_219_33

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_23 + var_219_33 and arg_216_1.time_ < var_219_23 + var_219_33 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play425081054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 425081054
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play425081055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1086"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps1086 == nil then
				arg_220_1.var_.actorSpriteComps1086 = var_223_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_2 = 0.2

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.actorSpriteComps1086 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								local var_223_4 = Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, var_223_3)
								local var_223_5 = Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, var_223_3)
								local var_223_6 = Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, var_223_3)

								iter_223_1.color = Color.New(var_223_4, var_223_5, var_223_6)
							else
								local var_223_7 = Mathf.Lerp(iter_223_1.color.r, 0.5, var_223_3)

								iter_223_1.color = Color.New(var_223_7, var_223_7, var_223_7)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.actorSpriteComps1086 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_223_3 then
						if arg_220_1.isInRecall_ then
							iter_223_3.color = arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_223_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps1086 = nil
			end

			local var_223_8 = arg_220_1.actors_["1080"].transform
			local var_223_9 = 0

			if var_223_9 < arg_220_1.time_ and arg_220_1.time_ <= var_223_9 + arg_223_0 then
				arg_220_1.var_.moveOldPos1080 = var_223_8.localPosition
				var_223_8.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("1080", 7)

				local var_223_10 = var_223_8.childCount

				for iter_223_4 = 0, var_223_10 - 1 do
					local var_223_11 = var_223_8:GetChild(iter_223_4)

					if var_223_11.name == "" or not string.find(var_223_11.name, "split") then
						var_223_11.gameObject:SetActive(true)
					else
						var_223_11.gameObject:SetActive(false)
					end
				end
			end

			local var_223_12 = 0.001

			if var_223_9 <= arg_220_1.time_ and arg_220_1.time_ < var_223_9 + var_223_12 then
				local var_223_13 = (arg_220_1.time_ - var_223_9) / var_223_12
				local var_223_14 = Vector3.New(0, -2000, 0)

				var_223_8.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1080, var_223_14, var_223_13)
			end

			if arg_220_1.time_ >= var_223_9 + var_223_12 and arg_220_1.time_ < var_223_9 + var_223_12 + arg_223_0 then
				var_223_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_223_15 = arg_220_1.actors_["1086"].transform
			local var_223_16 = 0

			if var_223_16 < arg_220_1.time_ and arg_220_1.time_ <= var_223_16 + arg_223_0 then
				arg_220_1.var_.moveOldPos1086 = var_223_15.localPosition
				var_223_15.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("1086", 7)

				local var_223_17 = var_223_15.childCount

				for iter_223_5 = 0, var_223_17 - 1 do
					local var_223_18 = var_223_15:GetChild(iter_223_5)

					if var_223_18.name == "" or not string.find(var_223_18.name, "split") then
						var_223_18.gameObject:SetActive(true)
					else
						var_223_18.gameObject:SetActive(false)
					end
				end
			end

			local var_223_19 = 0.001

			if var_223_16 <= arg_220_1.time_ and arg_220_1.time_ < var_223_16 + var_223_19 then
				local var_223_20 = (arg_220_1.time_ - var_223_16) / var_223_19
				local var_223_21 = Vector3.New(0, -2000, 0)

				var_223_15.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1086, var_223_21, var_223_20)
			end

			if arg_220_1.time_ >= var_223_16 + var_223_19 and arg_220_1.time_ < var_223_16 + var_223_19 + arg_223_0 then
				var_223_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_223_22 = 0.133333333333333
			local var_223_23 = 1

			if var_223_22 < arg_220_1.time_ and arg_220_1.time_ <= var_223_22 + arg_223_0 then
				local var_223_24 = "play"
				local var_223_25 = "effect"

				arg_220_1:AudioAction(var_223_24, var_223_25, "se_story_147", "se_story_147_foley_cloth", "")
			end

			local var_223_26 = 0
			local var_223_27 = 0.725

			if var_223_26 < arg_220_1.time_ and arg_220_1.time_ <= var_223_26 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_28 = arg_220_1:GetWordFromCfg(425081054)
				local var_223_29 = arg_220_1:FormatText(var_223_28.content)

				arg_220_1.text_.text = var_223_29

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_30 = 29
				local var_223_31 = utf8.len(var_223_29)
				local var_223_32 = var_223_30 <= 0 and var_223_27 or var_223_27 * (var_223_31 / var_223_30)

				if var_223_32 > 0 and var_223_27 < var_223_32 then
					arg_220_1.talkMaxDuration = var_223_32

					if var_223_32 + var_223_26 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_32 + var_223_26
					end
				end

				arg_220_1.text_.text = var_223_29
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_33 = math.max(var_223_27, arg_220_1.talkMaxDuration)

			if var_223_26 <= arg_220_1.time_ and arg_220_1.time_ < var_223_26 + var_223_33 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_26) / var_223_33

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_26 + var_223_33 and arg_220_1.time_ < var_223_26 + var_223_33 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play425081055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 425081055
		arg_224_1.duration_ = 10.1

		local var_224_0 = {
			zh = 7.466,
			ja = 10.1
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
				arg_224_0:Play425081056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1080"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps1080 == nil then
				arg_224_1.var_.actorSpriteComps1080 = var_227_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_2 = 0.2

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.actorSpriteComps1080 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.actorSpriteComps1080 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_227_3 then
						if arg_224_1.isInRecall_ then
							iter_227_3.color = arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_227_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps1080 = nil
			end

			local var_227_8 = arg_224_1.actors_["1080"].transform
			local var_227_9 = 0

			if var_227_9 < arg_224_1.time_ and arg_224_1.time_ <= var_227_9 + arg_227_0 then
				arg_224_1.var_.moveOldPos1080 = var_227_8.localPosition
				var_227_8.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("1080", 3)

				local var_227_10 = var_227_8.childCount

				for iter_227_4 = 0, var_227_10 - 1 do
					local var_227_11 = var_227_8:GetChild(iter_227_4)

					if var_227_11.name == "" or not string.find(var_227_11.name, "split") then
						var_227_11.gameObject:SetActive(true)
					else
						var_227_11.gameObject:SetActive(false)
					end
				end
			end

			local var_227_12 = 0.001

			if var_227_9 <= arg_224_1.time_ and arg_224_1.time_ < var_227_9 + var_227_12 then
				local var_227_13 = (arg_224_1.time_ - var_227_9) / var_227_12
				local var_227_14 = Vector3.New(0, -378, -170)

				var_227_8.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1080, var_227_14, var_227_13)
			end

			if arg_224_1.time_ >= var_227_9 + var_227_12 and arg_224_1.time_ < var_227_9 + var_227_12 + arg_227_0 then
				var_227_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_227_15 = 0
			local var_227_16 = 0.675

			if var_227_15 < arg_224_1.time_ and arg_224_1.time_ <= var_227_15 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_17 = arg_224_1:FormatText(StoryNameCfg[55].name)

				arg_224_1.leftNameTxt_.text = var_227_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_18 = arg_224_1:GetWordFromCfg(425081055)
				local var_227_19 = arg_224_1:FormatText(var_227_18.content)

				arg_224_1.text_.text = var_227_19

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_20 = 27
				local var_227_21 = utf8.len(var_227_19)
				local var_227_22 = var_227_20 <= 0 and var_227_16 or var_227_16 * (var_227_21 / var_227_20)

				if var_227_22 > 0 and var_227_16 < var_227_22 then
					arg_224_1.talkMaxDuration = var_227_22

					if var_227_22 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_22 + var_227_15
					end
				end

				arg_224_1.text_.text = var_227_19
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081055", "story_v_out_425081.awb") ~= 0 then
					local var_227_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081055", "story_v_out_425081.awb") / 1000

					if var_227_23 + var_227_15 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_23 + var_227_15
					end

					if var_227_18.prefab_name ~= "" and arg_224_1.actors_[var_227_18.prefab_name] ~= nil then
						local var_227_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_18.prefab_name].transform, "story_v_out_425081", "425081055", "story_v_out_425081.awb")

						arg_224_1:RecordAudio("425081055", var_227_24)
						arg_224_1:RecordAudio("425081055", var_227_24)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_425081", "425081055", "story_v_out_425081.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_425081", "425081055", "story_v_out_425081.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_25 = math.max(var_227_16, arg_224_1.talkMaxDuration)

			if var_227_15 <= arg_224_1.time_ and arg_224_1.time_ < var_227_15 + var_227_25 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_15) / var_227_25

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_15 + var_227_25 and arg_224_1.time_ < var_227_15 + var_227_25 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play425081056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 425081056
		arg_228_1.duration_ = 10.9

		local var_228_0 = {
			zh = 5.933,
			ja = 10.9
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
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play425081057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1080"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos1080 = var_231_0.localPosition
				var_231_0.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("1080", 3)

				local var_231_2 = var_231_0.childCount

				for iter_231_0 = 0, var_231_2 - 1 do
					local var_231_3 = var_231_0:GetChild(iter_231_0)

					if var_231_3.name == "" or not string.find(var_231_3.name, "split") then
						var_231_3.gameObject:SetActive(true)
					else
						var_231_3.gameObject:SetActive(false)
					end
				end
			end

			local var_231_4 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_4 then
				local var_231_5 = (arg_228_1.time_ - var_231_1) / var_231_4
				local var_231_6 = Vector3.New(0, -378, -170)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1080, var_231_6, var_231_5)
			end

			if arg_228_1.time_ >= var_231_1 + var_231_4 and arg_228_1.time_ < var_231_1 + var_231_4 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0, -378, -170)
			end

			local var_231_7 = 0
			local var_231_8 = 0.575

			if var_231_7 < arg_228_1.time_ and arg_228_1.time_ <= var_231_7 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_9 = arg_228_1:FormatText(StoryNameCfg[55].name)

				arg_228_1.leftNameTxt_.text = var_231_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_10 = arg_228_1:GetWordFromCfg(425081056)
				local var_231_11 = arg_228_1:FormatText(var_231_10.content)

				arg_228_1.text_.text = var_231_11

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_12 = 23
				local var_231_13 = utf8.len(var_231_11)
				local var_231_14 = var_231_12 <= 0 and var_231_8 or var_231_8 * (var_231_13 / var_231_12)

				if var_231_14 > 0 and var_231_8 < var_231_14 then
					arg_228_1.talkMaxDuration = var_231_14

					if var_231_14 + var_231_7 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_7
					end
				end

				arg_228_1.text_.text = var_231_11
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081056", "story_v_out_425081.awb") ~= 0 then
					local var_231_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081056", "story_v_out_425081.awb") / 1000

					if var_231_15 + var_231_7 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_15 + var_231_7
					end

					if var_231_10.prefab_name ~= "" and arg_228_1.actors_[var_231_10.prefab_name] ~= nil then
						local var_231_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_10.prefab_name].transform, "story_v_out_425081", "425081056", "story_v_out_425081.awb")

						arg_228_1:RecordAudio("425081056", var_231_16)
						arg_228_1:RecordAudio("425081056", var_231_16)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_425081", "425081056", "story_v_out_425081.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_425081", "425081056", "story_v_out_425081.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_17 = math.max(var_231_8, arg_228_1.talkMaxDuration)

			if var_231_7 <= arg_228_1.time_ and arg_228_1.time_ < var_231_7 + var_231_17 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_7) / var_231_17

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_7 + var_231_17 and arg_228_1.time_ < var_231_7 + var_231_17 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play425081057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 425081057
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play425081058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1080"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps1080 == nil then
				arg_232_1.var_.actorSpriteComps1080 = var_235_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_2 = 0.2

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.actorSpriteComps1080 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								local var_235_4 = Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor2.r, var_235_3)
								local var_235_5 = Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor2.g, var_235_3)
								local var_235_6 = Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor2.b, var_235_3)

								iter_235_1.color = Color.New(var_235_4, var_235_5, var_235_6)
							else
								local var_235_7 = Mathf.Lerp(iter_235_1.color.r, 0.5, var_235_3)

								iter_235_1.color = Color.New(var_235_7, var_235_7, var_235_7)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.actorSpriteComps1080 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_235_3 then
						if arg_232_1.isInRecall_ then
							iter_235_3.color = arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_235_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps1080 = nil
			end

			local var_235_8 = arg_232_1.actors_["1080"].transform
			local var_235_9 = 0

			if var_235_9 < arg_232_1.time_ and arg_232_1.time_ <= var_235_9 + arg_235_0 then
				arg_232_1.var_.moveOldPos1080 = var_235_8.localPosition
				var_235_8.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("1080", 7)

				local var_235_10 = var_235_8.childCount

				for iter_235_4 = 0, var_235_10 - 1 do
					local var_235_11 = var_235_8:GetChild(iter_235_4)

					if var_235_11.name == "" or not string.find(var_235_11.name, "split") then
						var_235_11.gameObject:SetActive(true)
					else
						var_235_11.gameObject:SetActive(false)
					end
				end
			end

			local var_235_12 = 0.001

			if var_235_9 <= arg_232_1.time_ and arg_232_1.time_ < var_235_9 + var_235_12 then
				local var_235_13 = (arg_232_1.time_ - var_235_9) / var_235_12
				local var_235_14 = Vector3.New(0, -2000, 0)

				var_235_8.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1080, var_235_14, var_235_13)
			end

			if arg_232_1.time_ >= var_235_9 + var_235_12 and arg_232_1.time_ < var_235_9 + var_235_12 + arg_235_0 then
				var_235_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_235_15 = 0
			local var_235_16 = 0.6

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_17 = arg_232_1:GetWordFromCfg(425081057)
				local var_235_18 = arg_232_1:FormatText(var_235_17.content)

				arg_232_1.text_.text = var_235_18

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_19 = 24
				local var_235_20 = utf8.len(var_235_18)
				local var_235_21 = var_235_19 <= 0 and var_235_16 or var_235_16 * (var_235_20 / var_235_19)

				if var_235_21 > 0 and var_235_16 < var_235_21 then
					arg_232_1.talkMaxDuration = var_235_21

					if var_235_21 + var_235_15 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_21 + var_235_15
					end
				end

				arg_232_1.text_.text = var_235_18
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_22 = math.max(var_235_16, arg_232_1.talkMaxDuration)

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_22 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_15) / var_235_22

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_15 + var_235_22 and arg_232_1.time_ < var_235_15 + var_235_22 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play425081058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 425081058
		arg_236_1.duration_ = 4.73

		local var_236_0 = {
			zh = 3.633,
			ja = 4.733
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play425081059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["1080"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps1080 == nil then
				arg_236_1.var_.actorSpriteComps1080 = var_239_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_2 = 0.2

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.actorSpriteComps1080 then
					for iter_239_0, iter_239_1 in pairs(arg_236_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_239_1 then
							if arg_236_1.isInRecall_ then
								local var_239_4 = Mathf.Lerp(iter_239_1.color.r, arg_236_1.hightColor1.r, var_239_3)
								local var_239_5 = Mathf.Lerp(iter_239_1.color.g, arg_236_1.hightColor1.g, var_239_3)
								local var_239_6 = Mathf.Lerp(iter_239_1.color.b, arg_236_1.hightColor1.b, var_239_3)

								iter_239_1.color = Color.New(var_239_4, var_239_5, var_239_6)
							else
								local var_239_7 = Mathf.Lerp(iter_239_1.color.r, 1, var_239_3)

								iter_239_1.color = Color.New(var_239_7, var_239_7, var_239_7)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.actorSpriteComps1080 then
				for iter_239_2, iter_239_3 in pairs(arg_236_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_239_3 then
						if arg_236_1.isInRecall_ then
							iter_239_3.color = arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_239_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps1080 = nil
			end

			local var_239_8 = arg_236_1.actors_["1080"].transform
			local var_239_9 = 0

			if var_239_9 < arg_236_1.time_ and arg_236_1.time_ <= var_239_9 + arg_239_0 then
				arg_236_1.var_.moveOldPos1080 = var_239_8.localPosition
				var_239_8.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("1080", 3)

				local var_239_10 = var_239_8.childCount

				for iter_239_4 = 0, var_239_10 - 1 do
					local var_239_11 = var_239_8:GetChild(iter_239_4)

					if var_239_11.name == "" or not string.find(var_239_11.name, "split") then
						var_239_11.gameObject:SetActive(true)
					else
						var_239_11.gameObject:SetActive(false)
					end
				end
			end

			local var_239_12 = 0.001

			if var_239_9 <= arg_236_1.time_ and arg_236_1.time_ < var_239_9 + var_239_12 then
				local var_239_13 = (arg_236_1.time_ - var_239_9) / var_239_12
				local var_239_14 = Vector3.New(0, -378, -170)

				var_239_8.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1080, var_239_14, var_239_13)
			end

			if arg_236_1.time_ >= var_239_9 + var_239_12 and arg_236_1.time_ < var_239_9 + var_239_12 + arg_239_0 then
				var_239_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_239_15 = 0
			local var_239_16 = 0.375

			if var_239_15 < arg_236_1.time_ and arg_236_1.time_ <= var_239_15 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_17 = arg_236_1:FormatText(StoryNameCfg[55].name)

				arg_236_1.leftNameTxt_.text = var_239_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_18 = arg_236_1:GetWordFromCfg(425081058)
				local var_239_19 = arg_236_1:FormatText(var_239_18.content)

				arg_236_1.text_.text = var_239_19

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_20 = 15
				local var_239_21 = utf8.len(var_239_19)
				local var_239_22 = var_239_20 <= 0 and var_239_16 or var_239_16 * (var_239_21 / var_239_20)

				if var_239_22 > 0 and var_239_16 < var_239_22 then
					arg_236_1.talkMaxDuration = var_239_22

					if var_239_22 + var_239_15 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_22 + var_239_15
					end
				end

				arg_236_1.text_.text = var_239_19
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081058", "story_v_out_425081.awb") ~= 0 then
					local var_239_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081058", "story_v_out_425081.awb") / 1000

					if var_239_23 + var_239_15 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_23 + var_239_15
					end

					if var_239_18.prefab_name ~= "" and arg_236_1.actors_[var_239_18.prefab_name] ~= nil then
						local var_239_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_18.prefab_name].transform, "story_v_out_425081", "425081058", "story_v_out_425081.awb")

						arg_236_1:RecordAudio("425081058", var_239_24)
						arg_236_1:RecordAudio("425081058", var_239_24)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_425081", "425081058", "story_v_out_425081.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_425081", "425081058", "story_v_out_425081.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_25 = math.max(var_239_16, arg_236_1.talkMaxDuration)

			if var_239_15 <= arg_236_1.time_ and arg_236_1.time_ < var_239_15 + var_239_25 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_15) / var_239_25

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_15 + var_239_25 and arg_236_1.time_ < var_239_15 + var_239_25 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play425081059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 425081059
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play425081060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1080"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps1080 == nil then
				arg_240_1.var_.actorSpriteComps1080 = var_243_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_2 = 0.2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.actorSpriteComps1080 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								local var_243_4 = Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor2.r, var_243_3)
								local var_243_5 = Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor2.g, var_243_3)
								local var_243_6 = Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor2.b, var_243_3)

								iter_243_1.color = Color.New(var_243_4, var_243_5, var_243_6)
							else
								local var_243_7 = Mathf.Lerp(iter_243_1.color.r, 0.5, var_243_3)

								iter_243_1.color = Color.New(var_243_7, var_243_7, var_243_7)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps1080 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_243_3 then
						if arg_240_1.isInRecall_ then
							iter_243_3.color = arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_243_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps1080 = nil
			end

			local var_243_8 = arg_240_1.actors_["1080"].transform
			local var_243_9 = 0

			if var_243_9 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 then
				arg_240_1.var_.moveOldPos1080 = var_243_8.localPosition
				var_243_8.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("1080", 7)

				local var_243_10 = var_243_8.childCount

				for iter_243_4 = 0, var_243_10 - 1 do
					local var_243_11 = var_243_8:GetChild(iter_243_4)

					if var_243_11.name == "" or not string.find(var_243_11.name, "split") then
						var_243_11.gameObject:SetActive(true)
					else
						var_243_11.gameObject:SetActive(false)
					end
				end
			end

			local var_243_12 = 0.001

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_12 then
				local var_243_13 = (arg_240_1.time_ - var_243_9) / var_243_12
				local var_243_14 = Vector3.New(0, -2000, 0)

				var_243_8.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1080, var_243_14, var_243_13)
			end

			if arg_240_1.time_ >= var_243_9 + var_243_12 and arg_240_1.time_ < var_243_9 + var_243_12 + arg_243_0 then
				var_243_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_243_15 = 0
			local var_243_16 = 0.85

			if var_243_15 < arg_240_1.time_ and arg_240_1.time_ <= var_243_15 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_17 = arg_240_1:GetWordFromCfg(425081059)
				local var_243_18 = arg_240_1:FormatText(var_243_17.content)

				arg_240_1.text_.text = var_243_18

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_19 = 34
				local var_243_20 = utf8.len(var_243_18)
				local var_243_21 = var_243_19 <= 0 and var_243_16 or var_243_16 * (var_243_20 / var_243_19)

				if var_243_21 > 0 and var_243_16 < var_243_21 then
					arg_240_1.talkMaxDuration = var_243_21

					if var_243_21 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_21 + var_243_15
					end
				end

				arg_240_1.text_.text = var_243_18
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_22 = math.max(var_243_16, arg_240_1.talkMaxDuration)

			if var_243_15 <= arg_240_1.time_ and arg_240_1.time_ < var_243_15 + var_243_22 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_15) / var_243_22

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_15 + var_243_22 and arg_240_1.time_ < var_243_15 + var_243_22 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play425081060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 425081060
		arg_244_1.duration_ = 3.3

		local var_244_0 = {
			zh = 3.3,
			ja = 2.6
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play425081061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1086"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps1086 == nil then
				arg_244_1.var_.actorSpriteComps1086 = var_247_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 0.2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.actorSpriteComps1086 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								local var_247_4 = Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, var_247_3)
								local var_247_5 = Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, var_247_3)
								local var_247_6 = Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, var_247_3)

								iter_247_1.color = Color.New(var_247_4, var_247_5, var_247_6)
							else
								local var_247_7 = Mathf.Lerp(iter_247_1.color.r, 1, var_247_3)

								iter_247_1.color = Color.New(var_247_7, var_247_7, var_247_7)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps1086 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_247_3 then
						if arg_244_1.isInRecall_ then
							iter_247_3.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps1086 = nil
			end

			local var_247_8 = arg_244_1.actors_["1086"].transform
			local var_247_9 = 0

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 then
				arg_244_1.var_.moveOldPos1086 = var_247_8.localPosition
				var_247_8.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("1086", 2)

				local var_247_10 = var_247_8.childCount

				for iter_247_4 = 0, var_247_10 - 1 do
					local var_247_11 = var_247_8:GetChild(iter_247_4)

					if var_247_11.name == "split_2" or not string.find(var_247_11.name, "split") then
						var_247_11.gameObject:SetActive(true)
					else
						var_247_11.gameObject:SetActive(false)
					end
				end
			end

			local var_247_12 = 0.001

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_12 then
				local var_247_13 = (arg_244_1.time_ - var_247_9) / var_247_12
				local var_247_14 = Vector3.New(-390, -404.2, -237.9)

				var_247_8.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1086, var_247_14, var_247_13)
			end

			if arg_244_1.time_ >= var_247_9 + var_247_12 and arg_244_1.time_ < var_247_9 + var_247_12 + arg_247_0 then
				var_247_8.localPosition = Vector3.New(-390, -404.2, -237.9)
			end

			local var_247_15 = 0
			local var_247_16 = 0.35

			if var_247_15 < arg_244_1.time_ and arg_244_1.time_ <= var_247_15 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_17 = arg_244_1:FormatText(StoryNameCfg[1080].name)

				arg_244_1.leftNameTxt_.text = var_247_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_18 = arg_244_1:GetWordFromCfg(425081060)
				local var_247_19 = arg_244_1:FormatText(var_247_18.content)

				arg_244_1.text_.text = var_247_19

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_20 = 14
				local var_247_21 = utf8.len(var_247_19)
				local var_247_22 = var_247_20 <= 0 and var_247_16 or var_247_16 * (var_247_21 / var_247_20)

				if var_247_22 > 0 and var_247_16 < var_247_22 then
					arg_244_1.talkMaxDuration = var_247_22

					if var_247_22 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_22 + var_247_15
					end
				end

				arg_244_1.text_.text = var_247_19
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081060", "story_v_out_425081.awb") ~= 0 then
					local var_247_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081060", "story_v_out_425081.awb") / 1000

					if var_247_23 + var_247_15 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_15
					end

					if var_247_18.prefab_name ~= "" and arg_244_1.actors_[var_247_18.prefab_name] ~= nil then
						local var_247_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_18.prefab_name].transform, "story_v_out_425081", "425081060", "story_v_out_425081.awb")

						arg_244_1:RecordAudio("425081060", var_247_24)
						arg_244_1:RecordAudio("425081060", var_247_24)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_425081", "425081060", "story_v_out_425081.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_425081", "425081060", "story_v_out_425081.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_25 = math.max(var_247_16, arg_244_1.talkMaxDuration)

			if var_247_15 <= arg_244_1.time_ and arg_244_1.time_ < var_247_15 + var_247_25 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_15) / var_247_25

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_15 + var_247_25 and arg_244_1.time_ < var_247_15 + var_247_25 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play425081061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 425081061
		arg_248_1.duration_ = 5.63

		local var_248_0 = {
			zh = 2.966,
			ja = 5.633
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play425081062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1080"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps1080 == nil then
				arg_248_1.var_.actorSpriteComps1080 = var_251_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_2 = 0.2

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.actorSpriteComps1080 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								local var_251_4 = Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor1.r, var_251_3)
								local var_251_5 = Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor1.g, var_251_3)
								local var_251_6 = Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor1.b, var_251_3)

								iter_251_1.color = Color.New(var_251_4, var_251_5, var_251_6)
							else
								local var_251_7 = Mathf.Lerp(iter_251_1.color.r, 1, var_251_3)

								iter_251_1.color = Color.New(var_251_7, var_251_7, var_251_7)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.actorSpriteComps1080 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_251_3 then
						if arg_248_1.isInRecall_ then
							iter_251_3.color = arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_251_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps1080 = nil
			end

			local var_251_8 = arg_248_1.actors_["1086"]
			local var_251_9 = 0

			if var_251_9 < arg_248_1.time_ and arg_248_1.time_ <= var_251_9 + arg_251_0 and not isNil(var_251_8) and arg_248_1.var_.actorSpriteComps1086 == nil then
				arg_248_1.var_.actorSpriteComps1086 = var_251_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_10 = 0.2

			if var_251_9 <= arg_248_1.time_ and arg_248_1.time_ < var_251_9 + var_251_10 and not isNil(var_251_8) then
				local var_251_11 = (arg_248_1.time_ - var_251_9) / var_251_10

				if arg_248_1.var_.actorSpriteComps1086 then
					for iter_251_4, iter_251_5 in pairs(arg_248_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_251_5 then
							if arg_248_1.isInRecall_ then
								local var_251_12 = Mathf.Lerp(iter_251_5.color.r, arg_248_1.hightColor2.r, var_251_11)
								local var_251_13 = Mathf.Lerp(iter_251_5.color.g, arg_248_1.hightColor2.g, var_251_11)
								local var_251_14 = Mathf.Lerp(iter_251_5.color.b, arg_248_1.hightColor2.b, var_251_11)

								iter_251_5.color = Color.New(var_251_12, var_251_13, var_251_14)
							else
								local var_251_15 = Mathf.Lerp(iter_251_5.color.r, 0.5, var_251_11)

								iter_251_5.color = Color.New(var_251_15, var_251_15, var_251_15)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_9 + var_251_10 and arg_248_1.time_ < var_251_9 + var_251_10 + arg_251_0 and not isNil(var_251_8) and arg_248_1.var_.actorSpriteComps1086 then
				for iter_251_6, iter_251_7 in pairs(arg_248_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_251_7 then
						if arg_248_1.isInRecall_ then
							iter_251_7.color = arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_251_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps1086 = nil
			end

			local var_251_16 = arg_248_1.actors_["1080"].transform
			local var_251_17 = 0

			if var_251_17 < arg_248_1.time_ and arg_248_1.time_ <= var_251_17 + arg_251_0 then
				arg_248_1.var_.moveOldPos1080 = var_251_16.localPosition
				var_251_16.localScale = Vector3.New(1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("1080", 4)

				local var_251_18 = var_251_16.childCount

				for iter_251_8 = 0, var_251_18 - 1 do
					local var_251_19 = var_251_16:GetChild(iter_251_8)

					if var_251_19.name == "" or not string.find(var_251_19.name, "split") then
						var_251_19.gameObject:SetActive(true)
					else
						var_251_19.gameObject:SetActive(false)
					end
				end
			end

			local var_251_20 = 0.001

			if var_251_17 <= arg_248_1.time_ and arg_248_1.time_ < var_251_17 + var_251_20 then
				local var_251_21 = (arg_248_1.time_ - var_251_17) / var_251_20
				local var_251_22 = Vector3.New(390, -378, -170)

				var_251_16.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1080, var_251_22, var_251_21)
			end

			if arg_248_1.time_ >= var_251_17 + var_251_20 and arg_248_1.time_ < var_251_17 + var_251_20 + arg_251_0 then
				var_251_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_251_23 = 0
			local var_251_24 = 0.275

			if var_251_23 < arg_248_1.time_ and arg_248_1.time_ <= var_251_23 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_25 = arg_248_1:FormatText(StoryNameCfg[55].name)

				arg_248_1.leftNameTxt_.text = var_251_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_26 = arg_248_1:GetWordFromCfg(425081061)
				local var_251_27 = arg_248_1:FormatText(var_251_26.content)

				arg_248_1.text_.text = var_251_27

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_28 = 11
				local var_251_29 = utf8.len(var_251_27)
				local var_251_30 = var_251_28 <= 0 and var_251_24 or var_251_24 * (var_251_29 / var_251_28)

				if var_251_30 > 0 and var_251_24 < var_251_30 then
					arg_248_1.talkMaxDuration = var_251_30

					if var_251_30 + var_251_23 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_30 + var_251_23
					end
				end

				arg_248_1.text_.text = var_251_27
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081061", "story_v_out_425081.awb") ~= 0 then
					local var_251_31 = manager.audio:GetVoiceLength("story_v_out_425081", "425081061", "story_v_out_425081.awb") / 1000

					if var_251_31 + var_251_23 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_31 + var_251_23
					end

					if var_251_26.prefab_name ~= "" and arg_248_1.actors_[var_251_26.prefab_name] ~= nil then
						local var_251_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_26.prefab_name].transform, "story_v_out_425081", "425081061", "story_v_out_425081.awb")

						arg_248_1:RecordAudio("425081061", var_251_32)
						arg_248_1:RecordAudio("425081061", var_251_32)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_425081", "425081061", "story_v_out_425081.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_425081", "425081061", "story_v_out_425081.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_33 = math.max(var_251_24, arg_248_1.talkMaxDuration)

			if var_251_23 <= arg_248_1.time_ and arg_248_1.time_ < var_251_23 + var_251_33 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_23) / var_251_33

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_23 + var_251_33 and arg_248_1.time_ < var_251_23 + var_251_33 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play425081062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 425081062
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play425081063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1080"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps1080 == nil then
				arg_252_1.var_.actorSpriteComps1080 = var_255_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_2 = 0.2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.actorSpriteComps1080 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								local var_255_4 = Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor2.r, var_255_3)
								local var_255_5 = Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor2.g, var_255_3)
								local var_255_6 = Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor2.b, var_255_3)

								iter_255_1.color = Color.New(var_255_4, var_255_5, var_255_6)
							else
								local var_255_7 = Mathf.Lerp(iter_255_1.color.r, 0.5, var_255_3)

								iter_255_1.color = Color.New(var_255_7, var_255_7, var_255_7)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps1080 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_255_3 then
						if arg_252_1.isInRecall_ then
							iter_255_3.color = arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_255_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps1080 = nil
			end

			local var_255_8 = arg_252_1.actors_["1080"].transform
			local var_255_9 = 0

			if var_255_9 < arg_252_1.time_ and arg_252_1.time_ <= var_255_9 + arg_255_0 then
				arg_252_1.var_.moveOldPos1080 = var_255_8.localPosition
				var_255_8.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("1080", 7)

				local var_255_10 = var_255_8.childCount

				for iter_255_4 = 0, var_255_10 - 1 do
					local var_255_11 = var_255_8:GetChild(iter_255_4)

					if var_255_11.name == "" or not string.find(var_255_11.name, "split") then
						var_255_11.gameObject:SetActive(true)
					else
						var_255_11.gameObject:SetActive(false)
					end
				end
			end

			local var_255_12 = 0.001

			if var_255_9 <= arg_252_1.time_ and arg_252_1.time_ < var_255_9 + var_255_12 then
				local var_255_13 = (arg_252_1.time_ - var_255_9) / var_255_12
				local var_255_14 = Vector3.New(0, -2000, 0)

				var_255_8.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1080, var_255_14, var_255_13)
			end

			if arg_252_1.time_ >= var_255_9 + var_255_12 and arg_252_1.time_ < var_255_9 + var_255_12 + arg_255_0 then
				var_255_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_255_15 = arg_252_1.actors_["1086"].transform
			local var_255_16 = 0

			if var_255_16 < arg_252_1.time_ and arg_252_1.time_ <= var_255_16 + arg_255_0 then
				arg_252_1.var_.moveOldPos1086 = var_255_15.localPosition
				var_255_15.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("1086", 7)

				local var_255_17 = var_255_15.childCount

				for iter_255_5 = 0, var_255_17 - 1 do
					local var_255_18 = var_255_15:GetChild(iter_255_5)

					if var_255_18.name == "" or not string.find(var_255_18.name, "split") then
						var_255_18.gameObject:SetActive(true)
					else
						var_255_18.gameObject:SetActive(false)
					end
				end
			end

			local var_255_19 = 0.001

			if var_255_16 <= arg_252_1.time_ and arg_252_1.time_ < var_255_16 + var_255_19 then
				local var_255_20 = (arg_252_1.time_ - var_255_16) / var_255_19
				local var_255_21 = Vector3.New(0, -2000, 0)

				var_255_15.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1086, var_255_21, var_255_20)
			end

			if arg_252_1.time_ >= var_255_16 + var_255_19 and arg_252_1.time_ < var_255_16 + var_255_19 + arg_255_0 then
				var_255_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_255_22 = 0
			local var_255_23 = 0.75

			if var_255_22 < arg_252_1.time_ and arg_252_1.time_ <= var_255_22 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_24 = arg_252_1:GetWordFromCfg(425081062)
				local var_255_25 = arg_252_1:FormatText(var_255_24.content)

				arg_252_1.text_.text = var_255_25

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_26 = 30
				local var_255_27 = utf8.len(var_255_25)
				local var_255_28 = var_255_26 <= 0 and var_255_23 or var_255_23 * (var_255_27 / var_255_26)

				if var_255_28 > 0 and var_255_23 < var_255_28 then
					arg_252_1.talkMaxDuration = var_255_28

					if var_255_28 + var_255_22 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_28 + var_255_22
					end
				end

				arg_252_1.text_.text = var_255_25
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_29 = math.max(var_255_23, arg_252_1.talkMaxDuration)

			if var_255_22 <= arg_252_1.time_ and arg_252_1.time_ < var_255_22 + var_255_29 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_22) / var_255_29

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_22 + var_255_29 and arg_252_1.time_ < var_255_22 + var_255_29 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play425081063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 425081063
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play425081064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.133333333333333
			local var_259_1 = 1

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				local var_259_2 = "play"
				local var_259_3 = "effect"

				arg_256_1:AudioAction(var_259_2, var_259_3, "se_story_1311", "se_story_1311_door", "")
			end

			local var_259_4 = 0
			local var_259_5 = 0.8

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(425081063)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_8 = 32
				local var_259_9 = utf8.len(var_259_7)
				local var_259_10 = var_259_8 <= 0 and var_259_5 or var_259_5 * (var_259_9 / var_259_8)

				if var_259_10 > 0 and var_259_5 < var_259_10 then
					arg_256_1.talkMaxDuration = var_259_10

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_11 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_11 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_11

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_11 and arg_256_1.time_ < var_259_4 + var_259_11 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play425081064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 425081064
		arg_260_1.duration_ = 7.5

		local var_260_0 = {
			zh = 7.50000033333333,
			ja = 7.10000033333333
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play425081065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_1 = 1.2

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_1 then
				local var_263_2 = (arg_260_1.time_ - var_263_0) / var_263_1
				local var_263_3 = Color.New(0, 0, 0)

				var_263_3.a = Mathf.Lerp(0, 1, var_263_2)
				arg_260_1.mask_.color = var_263_3
			end

			if arg_260_1.time_ >= var_263_0 + var_263_1 and arg_260_1.time_ < var_263_0 + var_263_1 + arg_263_0 then
				local var_263_4 = Color.New(0, 0, 0)

				var_263_4.a = 1
				arg_260_1.mask_.color = var_263_4
			end

			local var_263_5 = 1.2

			if var_263_5 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_6 = 1.2

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_6 then
				local var_263_7 = (arg_260_1.time_ - var_263_5) / var_263_6
				local var_263_8 = Color.New(0, 0, 0)

				var_263_8.a = Mathf.Lerp(1, 0, var_263_7)
				arg_260_1.mask_.color = var_263_8
			end

			if arg_260_1.time_ >= var_263_5 + var_263_6 and arg_260_1.time_ < var_263_5 + var_263_6 + arg_263_0 then
				local var_263_9 = Color.New(0, 0, 0)
				local var_263_10 = 0

				arg_260_1.mask_.enabled = false
				var_263_9.a = var_263_10
				arg_260_1.mask_.color = var_263_9
			end

			local var_263_11 = 5.30000033333333

			if var_263_11 < arg_260_1.time_ and arg_260_1.time_ <= var_263_11 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			local var_263_12 = 0.3

			if arg_260_1.time_ >= var_263_11 + var_263_12 and arg_260_1.time_ < var_263_11 + var_263_12 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_13 = 1.2
			local var_263_14 = 1.999999999999
			local var_263_15 = "ST01a"

			if var_263_13 < arg_260_1.time_ and arg_260_1.time_ <= var_263_13 + arg_263_0 then
				arg_260_1.timestampController_:SetSelectedState("show")
				arg_260_1.timestampAni_:Play("in")

				arg_260_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_263_15)

				arg_260_1.timestampColorController_:SetSelectedState("cold")
				arg_260_1.timeColdImg_:SetAlpha(0.031)

				local var_263_16 = arg_260_1:GetWordFromCfg(501112)
				local var_263_17 = arg_260_1:FormatText(var_263_16.content)

				arg_260_1.text_timeText_.text = var_263_17

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_timeText_)

				local var_263_18 = arg_260_1:GetWordFromCfg(501113)
				local var_263_19 = arg_260_1:FormatText(var_263_18.content)

				arg_260_1.text_siteText_.text = var_263_19

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_siteText_)
			end

			if arg_260_1.time_ >= var_263_13 + var_263_14 and arg_260_1.time_ < var_263_13 + var_263_14 + arg_263_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_260_1.timestampAni_, "out", function()
					arg_260_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_263_20 = 3.20000033333333

			if var_263_20 < arg_260_1.time_ and arg_260_1.time_ <= var_263_20 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_21 = 1.2

			if var_263_20 <= arg_260_1.time_ and arg_260_1.time_ < var_263_20 + var_263_21 then
				local var_263_22 = (arg_260_1.time_ - var_263_20) / var_263_21
				local var_263_23 = Color.New(0, 0, 0)

				var_263_23.a = Mathf.Lerp(0, 1, var_263_22)
				arg_260_1.mask_.color = var_263_23
			end

			if arg_260_1.time_ >= var_263_20 + var_263_21 and arg_260_1.time_ < var_263_20 + var_263_21 + arg_263_0 then
				local var_263_24 = Color.New(0, 0, 0)

				var_263_24.a = 1
				arg_260_1.mask_.color = var_263_24
			end

			local var_263_25 = 4.40000033333333

			if var_263_25 < arg_260_1.time_ and arg_260_1.time_ <= var_263_25 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_26 = 1.2

			if var_263_25 <= arg_260_1.time_ and arg_260_1.time_ < var_263_25 + var_263_26 then
				local var_263_27 = (arg_260_1.time_ - var_263_25) / var_263_26
				local var_263_28 = Color.New(0, 0, 0)

				var_263_28.a = Mathf.Lerp(1, 0, var_263_27)
				arg_260_1.mask_.color = var_263_28
			end

			if arg_260_1.time_ >= var_263_25 + var_263_26 and arg_260_1.time_ < var_263_25 + var_263_26 + arg_263_0 then
				local var_263_29 = Color.New(0, 0, 0)
				local var_263_30 = 0

				arg_260_1.mask_.enabled = false
				var_263_29.a = var_263_30
				arg_260_1.mask_.color = var_263_29
			end

			local var_263_31 = "ST01a"

			if arg_260_1.bgs_[var_263_31] == nil then
				local var_263_32 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_32:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_263_31)
				var_263_32.name = var_263_31
				var_263_32.transform.parent = arg_260_1.stage_.transform
				var_263_32.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_[var_263_31] = var_263_32
			end

			local var_263_33 = 1.2

			if var_263_33 < arg_260_1.time_ and arg_260_1.time_ <= var_263_33 + arg_263_0 then
				local var_263_34 = manager.ui.mainCamera.transform.localPosition
				local var_263_35 = Vector3.New(0, 0, 10) + Vector3.New(var_263_34.x, var_263_34.y, 0)
				local var_263_36 = arg_260_1.bgs_.ST01a

				var_263_36.transform.localPosition = var_263_35
				var_263_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_37 = var_263_36:GetComponent("SpriteRenderer")

				if var_263_37 and var_263_37.sprite then
					local var_263_38 = (var_263_36.transform.localPosition - var_263_34).z
					local var_263_39 = manager.ui.mainCameraCom_
					local var_263_40 = 2 * var_263_38 * Mathf.Tan(var_263_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_263_41 = var_263_40 * var_263_39.aspect
					local var_263_42 = var_263_37.sprite.bounds.size.x
					local var_263_43 = var_263_37.sprite.bounds.size.y
					local var_263_44 = var_263_41 / var_263_42
					local var_263_45 = var_263_40 / var_263_43
					local var_263_46 = var_263_45 < var_263_44 and var_263_44 or var_263_45

					var_263_36.transform.localScale = Vector3.New(var_263_46, var_263_46, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "ST01a" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_47 = 0.133333333333333
			local var_263_48 = 1

			if var_263_47 < arg_260_1.time_ and arg_260_1.time_ <= var_263_47 + arg_263_0 then
				local var_263_49 = "stop"
				local var_263_50 = "effect"

				arg_260_1:AudioAction(var_263_49, var_263_50, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_263_51 = 3.93333333333333
			local var_263_52 = 1

			if var_263_51 < arg_260_1.time_ and arg_260_1.time_ <= var_263_51 + arg_263_0 then
				local var_263_53 = "play"
				local var_263_54 = "effect"

				arg_260_1:AudioAction(var_263_53, var_263_54, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_263_55 = 0.133333333333333
			local var_263_56 = 0.3

			if var_263_55 < arg_260_1.time_ and arg_260_1.time_ <= var_263_55 + arg_263_0 then
				local var_263_57 = "play"
				local var_263_58 = "music"

				arg_260_1:AudioAction(var_263_57, var_263_58, "ui_battle", "ui_battle_stopbgm", "")

				local var_263_59 = ""
				local var_263_60 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_263_60 ~= "" then
					if arg_260_1.bgmTxt_.text ~= var_263_60 and arg_260_1.bgmTxt_.text ~= "" then
						if arg_260_1.bgmTxt2_.text ~= "" then
							arg_260_1.bgmTxt_.text = arg_260_1.bgmTxt2_.text
						end

						arg_260_1.bgmTxt2_.text = var_263_60

						arg_260_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_260_1.bgmTxt_.text = var_263_60
						arg_260_1.bgmTxt2_.text = var_263_60
					end

					if arg_260_1.bgmTimer then
						arg_260_1.bgmTimer:Stop()

						arg_260_1.bgmTimer = nil
					end

					if arg_260_1.settingData.show_music_name == 1 then
						arg_260_1.musicController:SetSelectedState("show")
						arg_260_1.musicAnimator_:Play("open", 0, 0)

						if arg_260_1.settingData.music_time ~= 0 then
							arg_260_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_260_1.settingData.music_time), function()
								if arg_260_1 == nil or isNil(arg_260_1.bgmTxt_) then
									return
								end

								arg_260_1.musicController:SetSelectedState("hide")
								arg_260_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_61 = 5.50000033333333
			local var_263_62 = 0.1

			if var_263_61 < arg_260_1.time_ and arg_260_1.time_ <= var_263_61 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_63 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_63:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_260_1.dialogCg_.alpha = arg_266_0
				end))
				var_263_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_64 = arg_260_1:FormatText(StoryNameCfg[15].name)

				arg_260_1.leftNameTxt_.text = var_263_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_65 = arg_260_1:GetWordFromCfg(425081064)
				local var_263_66 = arg_260_1:FormatText(var_263_65.content)

				arg_260_1.text_.text = var_263_66

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_67 = 4
				local var_263_68 = utf8.len(var_263_66)
				local var_263_69 = var_263_67 <= 0 and var_263_62 or var_263_62 * (var_263_68 / var_263_67)

				if var_263_69 > 0 and var_263_62 < var_263_69 then
					arg_260_1.talkMaxDuration = var_263_69
					var_263_61 = var_263_61 + 0.3

					if var_263_69 + var_263_61 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_69 + var_263_61
					end
				end

				arg_260_1.text_.text = var_263_66
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081064", "story_v_out_425081.awb") ~= 0 then
					local var_263_70 = manager.audio:GetVoiceLength("story_v_out_425081", "425081064", "story_v_out_425081.awb") / 1000

					if var_263_70 + var_263_61 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_70 + var_263_61
					end

					if var_263_65.prefab_name ~= "" and arg_260_1.actors_[var_263_65.prefab_name] ~= nil then
						local var_263_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_65.prefab_name].transform, "story_v_out_425081", "425081064", "story_v_out_425081.awb")

						arg_260_1:RecordAudio("425081064", var_263_71)
						arg_260_1:RecordAudio("425081064", var_263_71)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_425081", "425081064", "story_v_out_425081.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_425081", "425081064", "story_v_out_425081.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_72 = var_263_61 + 0.3
			local var_263_73 = math.max(var_263_62, arg_260_1.talkMaxDuration)

			if var_263_72 <= arg_260_1.time_ and arg_260_1.time_ < var_263_72 + var_263_73 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_72) / var_263_73

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_72 + var_263_73 and arg_260_1.time_ < var_263_72 + var_263_73 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play425081065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 425081065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play425081066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0
			local var_271_1 = 0.3

			if var_271_0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_0 + arg_271_0 then
				local var_271_2 = "play"
				local var_271_3 = "music"

				arg_268_1:AudioAction(var_271_2, var_271_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_271_4 = ""
				local var_271_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_271_5 ~= "" then
					if arg_268_1.bgmTxt_.text ~= var_271_5 and arg_268_1.bgmTxt_.text ~= "" then
						if arg_268_1.bgmTxt2_.text ~= "" then
							arg_268_1.bgmTxt_.text = arg_268_1.bgmTxt2_.text
						end

						arg_268_1.bgmTxt2_.text = var_271_5

						arg_268_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_268_1.bgmTxt_.text = var_271_5
						arg_268_1.bgmTxt2_.text = var_271_5
					end

					if arg_268_1.bgmTimer then
						arg_268_1.bgmTimer:Stop()

						arg_268_1.bgmTimer = nil
					end

					if arg_268_1.settingData.show_music_name == 1 then
						arg_268_1.musicController:SetSelectedState("show")
						arg_268_1.musicAnimator_:Play("open", 0, 0)

						if arg_268_1.settingData.music_time ~= 0 then
							arg_268_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_268_1.settingData.music_time), function()
								if arg_268_1 == nil or isNil(arg_268_1.bgmTxt_) then
									return
								end

								arg_268_1.musicController:SetSelectedState("hide")
								arg_268_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_271_6 = 0.3
			local var_271_7 = 1

			if var_271_6 < arg_268_1.time_ and arg_268_1.time_ <= var_271_6 + arg_271_0 then
				local var_271_8 = "play"
				local var_271_9 = "music"

				arg_268_1:AudioAction(var_271_8, var_271_9, "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_271_10 = ""
				local var_271_11 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if var_271_11 ~= "" then
					if arg_268_1.bgmTxt_.text ~= var_271_11 and arg_268_1.bgmTxt_.text ~= "" then
						if arg_268_1.bgmTxt2_.text ~= "" then
							arg_268_1.bgmTxt_.text = arg_268_1.bgmTxt2_.text
						end

						arg_268_1.bgmTxt2_.text = var_271_11

						arg_268_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_268_1.bgmTxt_.text = var_271_11
						arg_268_1.bgmTxt2_.text = var_271_11
					end

					if arg_268_1.bgmTimer then
						arg_268_1.bgmTimer:Stop()

						arg_268_1.bgmTimer = nil
					end

					if arg_268_1.settingData.show_music_name == 1 then
						arg_268_1.musicController:SetSelectedState("show")
						arg_268_1.musicAnimator_:Play("open", 0, 0)

						if arg_268_1.settingData.music_time ~= 0 then
							arg_268_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_268_1.settingData.music_time), function()
								if arg_268_1 == nil or isNil(arg_268_1.bgmTxt_) then
									return
								end

								arg_268_1.musicController:SetSelectedState("hide")
								arg_268_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_271_12 = 0
			local var_271_13 = 0.2

			if var_271_12 < arg_268_1.time_ and arg_268_1.time_ <= var_271_12 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_14 = arg_268_1:FormatText(StoryNameCfg[7].name)

				arg_268_1.leftNameTxt_.text = var_271_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_15 = arg_268_1:GetWordFromCfg(425081065)
				local var_271_16 = arg_268_1:FormatText(var_271_15.content)

				arg_268_1.text_.text = var_271_16

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_17 = 8
				local var_271_18 = utf8.len(var_271_16)
				local var_271_19 = var_271_17 <= 0 and var_271_13 or var_271_13 * (var_271_18 / var_271_17)

				if var_271_19 > 0 and var_271_13 < var_271_19 then
					arg_268_1.talkMaxDuration = var_271_19

					if var_271_19 + var_271_12 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_19 + var_271_12
					end
				end

				arg_268_1.text_.text = var_271_16
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_20 = math.max(var_271_13, arg_268_1.talkMaxDuration)

			if var_271_12 <= arg_268_1.time_ and arg_268_1.time_ < var_271_12 + var_271_20 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_12) / var_271_20

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_12 + var_271_20 and arg_268_1.time_ < var_271_12 + var_271_20 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play425081066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 425081066
		arg_274_1.duration_ = 5.27

		local var_274_0 = {
			zh = 5.266,
			ja = 4.933
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
				arg_274_0:Play425081067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = "1037"

			if arg_274_1.actors_[var_277_0] == nil then
				local var_277_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_277_1) then
					local var_277_2 = Object.Instantiate(var_277_1, arg_274_1.canvasGo_.transform)

					var_277_2.transform:SetSiblingIndex(1)

					var_277_2.name = var_277_0
					var_277_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_274_1.actors_[var_277_0] = var_277_2

					local var_277_3 = var_277_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_274_1.isInRecall_ then
						for iter_277_0, iter_277_1 in ipairs(var_277_3) do
							iter_277_1.color = arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_277_4 = arg_274_1.actors_["1037"]
			local var_277_5 = 0

			if var_277_5 < arg_274_1.time_ and arg_274_1.time_ <= var_277_5 + arg_277_0 and not isNil(var_277_4) and arg_274_1.var_.actorSpriteComps1037 == nil then
				arg_274_1.var_.actorSpriteComps1037 = var_277_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_6 = 0.2

			if var_277_5 <= arg_274_1.time_ and arg_274_1.time_ < var_277_5 + var_277_6 and not isNil(var_277_4) then
				local var_277_7 = (arg_274_1.time_ - var_277_5) / var_277_6

				if arg_274_1.var_.actorSpriteComps1037 then
					for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_277_3 then
							if arg_274_1.isInRecall_ then
								local var_277_8 = Mathf.Lerp(iter_277_3.color.r, arg_274_1.hightColor1.r, var_277_7)
								local var_277_9 = Mathf.Lerp(iter_277_3.color.g, arg_274_1.hightColor1.g, var_277_7)
								local var_277_10 = Mathf.Lerp(iter_277_3.color.b, arg_274_1.hightColor1.b, var_277_7)

								iter_277_3.color = Color.New(var_277_8, var_277_9, var_277_10)
							else
								local var_277_11 = Mathf.Lerp(iter_277_3.color.r, 1, var_277_7)

								iter_277_3.color = Color.New(var_277_11, var_277_11, var_277_11)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= var_277_5 + var_277_6 and arg_274_1.time_ < var_277_5 + var_277_6 + arg_277_0 and not isNil(var_277_4) and arg_274_1.var_.actorSpriteComps1037 then
				for iter_277_4, iter_277_5 in pairs(arg_274_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_277_5 then
						if arg_274_1.isInRecall_ then
							iter_277_5.color = arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_277_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_274_1.var_.actorSpriteComps1037 = nil
			end

			local var_277_12 = arg_274_1.actors_["1037"].transform
			local var_277_13 = 0

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1.var_.moveOldPos1037 = var_277_12.localPosition
				var_277_12.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1037", 3)

				local var_277_14 = var_277_12.childCount

				for iter_277_6 = 0, var_277_14 - 1 do
					local var_277_15 = var_277_12:GetChild(iter_277_6)

					if var_277_15.name == "split_4" or not string.find(var_277_15.name, "split") then
						var_277_15.gameObject:SetActive(true)
					else
						var_277_15.gameObject:SetActive(false)
					end
				end
			end

			local var_277_16 = 0.001

			if var_277_13 <= arg_274_1.time_ and arg_274_1.time_ < var_277_13 + var_277_16 then
				local var_277_17 = (arg_274_1.time_ - var_277_13) / var_277_16
				local var_277_18 = Vector3.New(0, -430, -55)

				var_277_12.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1037, var_277_18, var_277_17)
			end

			if arg_274_1.time_ >= var_277_13 + var_277_16 and arg_274_1.time_ < var_277_13 + var_277_16 + arg_277_0 then
				var_277_12.localPosition = Vector3.New(0, -430, -55)
			end

			local var_277_19 = 0
			local var_277_20 = 0.3

			if var_277_19 < arg_274_1.time_ and arg_274_1.time_ <= var_277_19 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_21 = arg_274_1:FormatText(StoryNameCfg[15].name)

				arg_274_1.leftNameTxt_.text = var_277_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_22 = arg_274_1:GetWordFromCfg(425081066)
				local var_277_23 = arg_274_1:FormatText(var_277_22.content)

				arg_274_1.text_.text = var_277_23

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_24 = 12
				local var_277_25 = utf8.len(var_277_23)
				local var_277_26 = var_277_24 <= 0 and var_277_20 or var_277_20 * (var_277_25 / var_277_24)

				if var_277_26 > 0 and var_277_20 < var_277_26 then
					arg_274_1.talkMaxDuration = var_277_26

					if var_277_26 + var_277_19 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_26 + var_277_19
					end
				end

				arg_274_1.text_.text = var_277_23
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081066", "story_v_out_425081.awb") ~= 0 then
					local var_277_27 = manager.audio:GetVoiceLength("story_v_out_425081", "425081066", "story_v_out_425081.awb") / 1000

					if var_277_27 + var_277_19 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_27 + var_277_19
					end

					if var_277_22.prefab_name ~= "" and arg_274_1.actors_[var_277_22.prefab_name] ~= nil then
						local var_277_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_22.prefab_name].transform, "story_v_out_425081", "425081066", "story_v_out_425081.awb")

						arg_274_1:RecordAudio("425081066", var_277_28)
						arg_274_1:RecordAudio("425081066", var_277_28)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_425081", "425081066", "story_v_out_425081.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_425081", "425081066", "story_v_out_425081.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_29 = math.max(var_277_20, arg_274_1.talkMaxDuration)

			if var_277_19 <= arg_274_1.time_ and arg_274_1.time_ < var_277_19 + var_277_29 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_19) / var_277_29

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_19 + var_277_29 and arg_274_1.time_ < var_277_19 + var_277_29 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play425081067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 425081067
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play425081068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["1037"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps1037 == nil then
				arg_278_1.var_.actorSpriteComps1037 = var_281_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_2 = 0.2

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.actorSpriteComps1037 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								local var_281_4 = Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor2.r, var_281_3)
								local var_281_5 = Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor2.g, var_281_3)
								local var_281_6 = Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor2.b, var_281_3)

								iter_281_1.color = Color.New(var_281_4, var_281_5, var_281_6)
							else
								local var_281_7 = Mathf.Lerp(iter_281_1.color.r, 0.5, var_281_3)

								iter_281_1.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps1037 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_281_3 then
						if arg_278_1.isInRecall_ then
							iter_281_3.color = arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_281_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps1037 = nil
			end

			local var_281_8 = 0
			local var_281_9 = 1.2

			if var_281_8 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_10 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_11 = arg_278_1:GetWordFromCfg(425081067)
				local var_281_12 = arg_278_1:FormatText(var_281_11.content)

				arg_278_1.text_.text = var_281_12

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_13 = 48
				local var_281_14 = utf8.len(var_281_12)
				local var_281_15 = var_281_13 <= 0 and var_281_9 or var_281_9 * (var_281_14 / var_281_13)

				if var_281_15 > 0 and var_281_9 < var_281_15 then
					arg_278_1.talkMaxDuration = var_281_15

					if var_281_15 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_15 + var_281_8
					end
				end

				arg_278_1.text_.text = var_281_12
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_16 = math.max(var_281_9, arg_278_1.talkMaxDuration)

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_16 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_8) / var_281_16

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_8 + var_281_16 and arg_278_1.time_ < var_281_8 + var_281_16 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play425081068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 425081068
		arg_282_1.duration_ = 4.57

		local var_282_0 = {
			zh = 2.6,
			ja = 4.566
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
				arg_282_0:Play425081069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1037"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps1037 == nil then
				arg_282_1.var_.actorSpriteComps1037 = var_285_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_2 = 0.2

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.actorSpriteComps1037 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps1037 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_285_3 then
						if arg_282_1.isInRecall_ then
							iter_285_3.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps1037 = nil
			end

			local var_285_8 = 0
			local var_285_9 = 0.2

			if var_285_8 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_10 = arg_282_1:FormatText(StoryNameCfg[15].name)

				arg_282_1.leftNameTxt_.text = var_285_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_11 = arg_282_1:GetWordFromCfg(425081068)
				local var_285_12 = arg_282_1:FormatText(var_285_11.content)

				arg_282_1.text_.text = var_285_12

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_13 = 8
				local var_285_14 = utf8.len(var_285_12)
				local var_285_15 = var_285_13 <= 0 and var_285_9 or var_285_9 * (var_285_14 / var_285_13)

				if var_285_15 > 0 and var_285_9 < var_285_15 then
					arg_282_1.talkMaxDuration = var_285_15

					if var_285_15 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_15 + var_285_8
					end
				end

				arg_282_1.text_.text = var_285_12
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081068", "story_v_out_425081.awb") ~= 0 then
					local var_285_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081068", "story_v_out_425081.awb") / 1000

					if var_285_16 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_16 + var_285_8
					end

					if var_285_11.prefab_name ~= "" and arg_282_1.actors_[var_285_11.prefab_name] ~= nil then
						local var_285_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_11.prefab_name].transform, "story_v_out_425081", "425081068", "story_v_out_425081.awb")

						arg_282_1:RecordAudio("425081068", var_285_17)
						arg_282_1:RecordAudio("425081068", var_285_17)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_425081", "425081068", "story_v_out_425081.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_425081", "425081068", "story_v_out_425081.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_18 = math.max(var_285_9, arg_282_1.talkMaxDuration)

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_18 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_8) / var_285_18

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_8 + var_285_18 and arg_282_1.time_ < var_285_8 + var_285_18 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play425081069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 425081069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play425081070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1037"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps1037 == nil then
				arg_286_1.var_.actorSpriteComps1037 = var_289_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_2 = 0.2

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.actorSpriteComps1037 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								local var_289_4 = Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor2.r, var_289_3)
								local var_289_5 = Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor2.g, var_289_3)
								local var_289_6 = Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor2.b, var_289_3)

								iter_289_1.color = Color.New(var_289_4, var_289_5, var_289_6)
							else
								local var_289_7 = Mathf.Lerp(iter_289_1.color.r, 0.5, var_289_3)

								iter_289_1.color = Color.New(var_289_7, var_289_7, var_289_7)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps1037 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_289_3 then
						if arg_286_1.isInRecall_ then
							iter_289_3.color = arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_289_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps1037 = nil
			end

			local var_289_8 = 0
			local var_289_9 = 0.3

			if var_289_8 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_10 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_11 = arg_286_1:GetWordFromCfg(425081069)
				local var_289_12 = arg_286_1:FormatText(var_289_11.content)

				arg_286_1.text_.text = var_289_12

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_13 = 12
				local var_289_14 = utf8.len(var_289_12)
				local var_289_15 = var_289_13 <= 0 and var_289_9 or var_289_9 * (var_289_14 / var_289_13)

				if var_289_15 > 0 and var_289_9 < var_289_15 then
					arg_286_1.talkMaxDuration = var_289_15

					if var_289_15 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_15 + var_289_8
					end
				end

				arg_286_1.text_.text = var_289_12
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_9, arg_286_1.talkMaxDuration)

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_8) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_8 + var_289_16 and arg_286_1.time_ < var_289_8 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play425081070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 425081070
		arg_290_1.duration_ = 6.63

		local var_290_0 = {
			zh = 6,
			ja = 6.633
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
				arg_290_0:Play425081071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1037"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps1037 == nil then
				arg_290_1.var_.actorSpriteComps1037 = var_293_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_2 = 0.2

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.actorSpriteComps1037 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								local var_293_4 = Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor1.r, var_293_3)
								local var_293_5 = Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor1.g, var_293_3)
								local var_293_6 = Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor1.b, var_293_3)

								iter_293_1.color = Color.New(var_293_4, var_293_5, var_293_6)
							else
								local var_293_7 = Mathf.Lerp(iter_293_1.color.r, 1, var_293_3)

								iter_293_1.color = Color.New(var_293_7, var_293_7, var_293_7)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps1037 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_293_3 then
						if arg_290_1.isInRecall_ then
							iter_293_3.color = arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_293_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps1037 = nil
			end

			local var_293_8 = 0
			local var_293_9 = 0.475

			if var_293_8 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_10 = arg_290_1:FormatText(StoryNameCfg[15].name)

				arg_290_1.leftNameTxt_.text = var_293_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_11 = arg_290_1:GetWordFromCfg(425081070)
				local var_293_12 = arg_290_1:FormatText(var_293_11.content)

				arg_290_1.text_.text = var_293_12

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_13 = 19
				local var_293_14 = utf8.len(var_293_12)
				local var_293_15 = var_293_13 <= 0 and var_293_9 or var_293_9 * (var_293_14 / var_293_13)

				if var_293_15 > 0 and var_293_9 < var_293_15 then
					arg_290_1.talkMaxDuration = var_293_15

					if var_293_15 + var_293_8 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_15 + var_293_8
					end
				end

				arg_290_1.text_.text = var_293_12
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081070", "story_v_out_425081.awb") ~= 0 then
					local var_293_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081070", "story_v_out_425081.awb") / 1000

					if var_293_16 + var_293_8 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_16 + var_293_8
					end

					if var_293_11.prefab_name ~= "" and arg_290_1.actors_[var_293_11.prefab_name] ~= nil then
						local var_293_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_11.prefab_name].transform, "story_v_out_425081", "425081070", "story_v_out_425081.awb")

						arg_290_1:RecordAudio("425081070", var_293_17)
						arg_290_1:RecordAudio("425081070", var_293_17)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_425081", "425081070", "story_v_out_425081.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_425081", "425081070", "story_v_out_425081.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_18 = math.max(var_293_9, arg_290_1.talkMaxDuration)

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_18 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_8) / var_293_18

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_8 + var_293_18 and arg_290_1.time_ < var_293_8 + var_293_18 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play425081071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 425081071
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play425081072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1037"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps1037 == nil then
				arg_294_1.var_.actorSpriteComps1037 = var_297_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_2 = 0.2

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.actorSpriteComps1037 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps1037 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_297_3 then
						if arg_294_1.isInRecall_ then
							iter_297_3.color = arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_297_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_294_1.var_.actorSpriteComps1037 = nil
			end

			local var_297_8 = 0
			local var_297_9 = 0.3

			if var_297_8 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_10 = arg_294_1:FormatText(StoryNameCfg[7].name)

				arg_294_1.leftNameTxt_.text = var_297_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_11 = arg_294_1:GetWordFromCfg(425081071)
				local var_297_12 = arg_294_1:FormatText(var_297_11.content)

				arg_294_1.text_.text = var_297_12

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_13 = 12
				local var_297_14 = utf8.len(var_297_12)
				local var_297_15 = var_297_13 <= 0 and var_297_9 or var_297_9 * (var_297_14 / var_297_13)

				if var_297_15 > 0 and var_297_9 < var_297_15 then
					arg_294_1.talkMaxDuration = var_297_15

					if var_297_15 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_15 + var_297_8
					end
				end

				arg_294_1.text_.text = var_297_12
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_16 = math.max(var_297_9, arg_294_1.talkMaxDuration)

			if var_297_8 <= arg_294_1.time_ and arg_294_1.time_ < var_297_8 + var_297_16 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_8) / var_297_16

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_8 + var_297_16 and arg_294_1.time_ < var_297_8 + var_297_16 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play425081072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 425081072
		arg_298_1.duration_ = 9.37

		local var_298_0 = {
			zh = 8.433,
			ja = 9.366
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
				arg_298_0:Play425081073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["1037"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps1037 == nil then
				arg_298_1.var_.actorSpriteComps1037 = var_301_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_2 = 0.2

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.actorSpriteComps1037 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps1037 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_301_3 then
						if arg_298_1.isInRecall_ then
							iter_301_3.color = arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_301_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps1037 = nil
			end

			local var_301_8 = arg_298_1.actors_["1037"].transform
			local var_301_9 = 0

			if var_301_9 < arg_298_1.time_ and arg_298_1.time_ <= var_301_9 + arg_301_0 then
				arg_298_1.var_.moveOldPos1037 = var_301_8.localPosition
				var_301_8.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("1037", 3)

				local var_301_10 = var_301_8.childCount

				for iter_301_4 = 0, var_301_10 - 1 do
					local var_301_11 = var_301_8:GetChild(iter_301_4)

					if var_301_11.name == "split_5" then
						var_301_11:SetAsLastSibling()
						var_301_11.gameObject:SetActive(true)

						arg_298_1.var_.actorSpriteSplit1037 = var_301_11.gameObject:GetComponent(typeof(Image))

						arg_298_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_301_12 = 0.2

			if var_301_9 <= arg_298_1.time_ and arg_298_1.time_ < var_301_9 + var_301_12 then
				local var_301_13 = (arg_298_1.time_ - var_301_9) / var_301_12
				local var_301_14 = Vector3.New(0, -430, -55)

				var_301_8.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1037, var_301_14, var_301_13)

				if arg_298_1.var_.actorSpriteSplit1037 ~= nil then
					arg_298_1.var_.actorSpriteSplit1037:SetAlpha(var_301_13)
				end
			end

			if arg_298_1.time_ >= var_301_9 + var_301_12 and arg_298_1.time_ < var_301_9 + var_301_12 + arg_301_0 then
				var_301_8.localPosition = Vector3.New(0, -430, -55)

				if arg_298_1.var_.actorSpriteSplit1037 ~= nil then
					arg_298_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_301_15 = 0
			local var_301_16 = 1

			if var_301_15 < arg_298_1.time_ and arg_298_1.time_ <= var_301_15 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_17 = arg_298_1:FormatText(StoryNameCfg[15].name)

				arg_298_1.leftNameTxt_.text = var_301_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_18 = arg_298_1:GetWordFromCfg(425081072)
				local var_301_19 = arg_298_1:FormatText(var_301_18.content)

				arg_298_1.text_.text = var_301_19

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_20 = 40
				local var_301_21 = utf8.len(var_301_19)
				local var_301_22 = var_301_20 <= 0 and var_301_16 or var_301_16 * (var_301_21 / var_301_20)

				if var_301_22 > 0 and var_301_16 < var_301_22 then
					arg_298_1.talkMaxDuration = var_301_22

					if var_301_22 + var_301_15 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_22 + var_301_15
					end
				end

				arg_298_1.text_.text = var_301_19
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081072", "story_v_out_425081.awb") ~= 0 then
					local var_301_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081072", "story_v_out_425081.awb") / 1000

					if var_301_23 + var_301_15 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_23 + var_301_15
					end

					if var_301_18.prefab_name ~= "" and arg_298_1.actors_[var_301_18.prefab_name] ~= nil then
						local var_301_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_18.prefab_name].transform, "story_v_out_425081", "425081072", "story_v_out_425081.awb")

						arg_298_1:RecordAudio("425081072", var_301_24)
						arg_298_1:RecordAudio("425081072", var_301_24)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_425081", "425081072", "story_v_out_425081.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_425081", "425081072", "story_v_out_425081.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_25 = math.max(var_301_16, arg_298_1.talkMaxDuration)

			if var_301_15 <= arg_298_1.time_ and arg_298_1.time_ < var_301_15 + var_301_25 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_15) / var_301_25

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_15 + var_301_25 and arg_298_1.time_ < var_301_15 + var_301_25 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
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

		arg_298_1:InitPlayNodeList()
	end,
	Play425081073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 425081073
		arg_302_1.duration_ = 3.37

		local var_302_0 = {
			zh = 2.533,
			ja = 3.366
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
				arg_302_0:Play425081074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1037"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1037 = var_305_0.localPosition
				var_305_0.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("1037", 3)

				local var_305_2 = var_305_0.childCount

				for iter_305_0 = 0, var_305_2 - 1 do
					local var_305_3 = var_305_0:GetChild(iter_305_0)

					if var_305_3.name == "split_6" then
						var_305_3:SetAsLastSibling()
						var_305_3.gameObject:SetActive(true)

						arg_302_1.var_.actorSpriteSplit1037 = var_305_3.gameObject:GetComponent(typeof(Image))

						arg_302_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_305_4 = 0.5

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_4 then
				local var_305_5 = (arg_302_1.time_ - var_305_1) / var_305_4
				local var_305_6 = Vector3.New(0, -430, -55)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1037, var_305_6, var_305_5)

				if arg_302_1.var_.actorSpriteSplit1037 ~= nil then
					arg_302_1.var_.actorSpriteSplit1037:SetAlpha(var_305_5)
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_4 and arg_302_1.time_ < var_305_1 + var_305_4 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -430, -55)

				if arg_302_1.var_.actorSpriteSplit1037 ~= nil then
					arg_302_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_305_7 = 0
			local var_305_8 = 0.375

			if var_305_7 < arg_302_1.time_ and arg_302_1.time_ <= var_305_7 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_9 = arg_302_1:FormatText(StoryNameCfg[15].name)

				arg_302_1.leftNameTxt_.text = var_305_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_10 = arg_302_1:GetWordFromCfg(425081073)
				local var_305_11 = arg_302_1:FormatText(var_305_10.content)

				arg_302_1.text_.text = var_305_11

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_12 = 15
				local var_305_13 = utf8.len(var_305_11)
				local var_305_14 = var_305_12 <= 0 and var_305_8 or var_305_8 * (var_305_13 / var_305_12)

				if var_305_14 > 0 and var_305_8 < var_305_14 then
					arg_302_1.talkMaxDuration = var_305_14

					if var_305_14 + var_305_7 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_7
					end
				end

				arg_302_1.text_.text = var_305_11
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081073", "story_v_out_425081.awb") ~= 0 then
					local var_305_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081073", "story_v_out_425081.awb") / 1000

					if var_305_15 + var_305_7 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_15 + var_305_7
					end

					if var_305_10.prefab_name ~= "" and arg_302_1.actors_[var_305_10.prefab_name] ~= nil then
						local var_305_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_10.prefab_name].transform, "story_v_out_425081", "425081073", "story_v_out_425081.awb")

						arg_302_1:RecordAudio("425081073", var_305_16)
						arg_302_1:RecordAudio("425081073", var_305_16)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_425081", "425081073", "story_v_out_425081.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_425081", "425081073", "story_v_out_425081.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_17 = math.max(var_305_8, arg_302_1.talkMaxDuration)

			if var_305_7 <= arg_302_1.time_ and arg_302_1.time_ < var_305_7 + var_305_17 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_7) / var_305_17

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_7 + var_305_17 and arg_302_1.time_ < var_305_7 + var_305_17 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	Play425081074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 425081074
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play425081075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1037"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1037 = var_309_0.localPosition
				var_309_0.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("1037", 7)

				local var_309_2 = var_309_0.childCount

				for iter_309_0 = 0, var_309_2 - 1 do
					local var_309_3 = var_309_0:GetChild(iter_309_0)

					if var_309_3.name == "" or not string.find(var_309_3.name, "split") then
						var_309_3.gameObject:SetActive(true)
					else
						var_309_3.gameObject:SetActive(false)
					end
				end
			end

			local var_309_4 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_4 then
				local var_309_5 = (arg_306_1.time_ - var_309_1) / var_309_4
				local var_309_6 = Vector3.New(1500, -2000, 0)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1037, var_309_6, var_309_5)
			end

			if arg_306_1.time_ >= var_309_1 + var_309_4 and arg_306_1.time_ < var_309_1 + var_309_4 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_309_7 = 0.199999999999
			local var_309_8 = 1

			if var_309_7 < arg_306_1.time_ and arg_306_1.time_ <= var_309_7 + arg_309_0 then
				local var_309_9 = "play"
				local var_309_10 = "effect"

				arg_306_1:AudioAction(var_309_9, var_309_10, "se_story_140", "se_story_140_foley_situp", "")
			end

			local var_309_11 = 0
			local var_309_12 = 1.2

			if var_309_11 < arg_306_1.time_ and arg_306_1.time_ <= var_309_11 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_13 = arg_306_1:GetWordFromCfg(425081074)
				local var_309_14 = arg_306_1:FormatText(var_309_13.content)

				arg_306_1.text_.text = var_309_14

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_15 = 48
				local var_309_16 = utf8.len(var_309_14)
				local var_309_17 = var_309_15 <= 0 and var_309_12 or var_309_12 * (var_309_16 / var_309_15)

				if var_309_17 > 0 and var_309_12 < var_309_17 then
					arg_306_1.talkMaxDuration = var_309_17

					if var_309_17 + var_309_11 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_17 + var_309_11
					end
				end

				arg_306_1.text_.text = var_309_14
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_18 = math.max(var_309_12, arg_306_1.talkMaxDuration)

			if var_309_11 <= arg_306_1.time_ and arg_306_1.time_ < var_309_11 + var_309_18 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_11) / var_309_18

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_11 + var_309_18 and arg_306_1.time_ < var_309_11 + var_309_18 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
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

		arg_306_1:InitPlayNodeList()
	end,
	Play425081075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 425081075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play425081076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 0.5

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_2 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:GetWordFromCfg(425081075)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 20
				local var_313_6 = utf8.len(var_313_4)
				local var_313_7 = var_313_5 <= 0 and var_313_1 or var_313_1 * (var_313_6 / var_313_5)

				if var_313_7 > 0 and var_313_1 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_8 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_8 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_8

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_8 and arg_310_1.time_ < var_313_0 + var_313_8 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play425081076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 425081076
		arg_314_1.duration_ = 3.97

		local var_314_0 = {
			zh = 3.4,
			ja = 3.966
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
				arg_314_0:Play425081077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1037"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps1037 == nil then
				arg_314_1.var_.actorSpriteComps1037 = var_317_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_2 = 0.2

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.actorSpriteComps1037 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								local var_317_4 = Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, var_317_3)
								local var_317_5 = Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, var_317_3)
								local var_317_6 = Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, var_317_3)

								iter_317_1.color = Color.New(var_317_4, var_317_5, var_317_6)
							else
								local var_317_7 = Mathf.Lerp(iter_317_1.color.r, 1, var_317_3)

								iter_317_1.color = Color.New(var_317_7, var_317_7, var_317_7)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps1037 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_317_3 then
						if arg_314_1.isInRecall_ then
							iter_317_3.color = arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_317_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps1037 = nil
			end

			local var_317_8 = arg_314_1.actors_["1037"].transform
			local var_317_9 = 0

			if var_317_9 < arg_314_1.time_ and arg_314_1.time_ <= var_317_9 + arg_317_0 then
				arg_314_1.var_.moveOldPos1037 = var_317_8.localPosition
				var_317_8.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("1037", 3)

				local var_317_10 = var_317_8.childCount

				for iter_317_4 = 0, var_317_10 - 1 do
					local var_317_11 = var_317_8:GetChild(iter_317_4)

					if var_317_11.name == "split_6" or not string.find(var_317_11.name, "split") then
						var_317_11.gameObject:SetActive(true)
					else
						var_317_11.gameObject:SetActive(false)
					end
				end
			end

			local var_317_12 = 0.001

			if var_317_9 <= arg_314_1.time_ and arg_314_1.time_ < var_317_9 + var_317_12 then
				local var_317_13 = (arg_314_1.time_ - var_317_9) / var_317_12
				local var_317_14 = Vector3.New(0, -430, -55)

				var_317_8.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1037, var_317_14, var_317_13)
			end

			if arg_314_1.time_ >= var_317_9 + var_317_12 and arg_314_1.time_ < var_317_9 + var_317_12 + arg_317_0 then
				var_317_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_317_15 = 0
			local var_317_16 = 0.325

			if var_317_15 < arg_314_1.time_ and arg_314_1.time_ <= var_317_15 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_17 = arg_314_1:FormatText(StoryNameCfg[15].name)

				arg_314_1.leftNameTxt_.text = var_317_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_18 = arg_314_1:GetWordFromCfg(425081076)
				local var_317_19 = arg_314_1:FormatText(var_317_18.content)

				arg_314_1.text_.text = var_317_19

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_20 = 13
				local var_317_21 = utf8.len(var_317_19)
				local var_317_22 = var_317_20 <= 0 and var_317_16 or var_317_16 * (var_317_21 / var_317_20)

				if var_317_22 > 0 and var_317_16 < var_317_22 then
					arg_314_1.talkMaxDuration = var_317_22

					if var_317_22 + var_317_15 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_22 + var_317_15
					end
				end

				arg_314_1.text_.text = var_317_19
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081076", "story_v_out_425081.awb") ~= 0 then
					local var_317_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081076", "story_v_out_425081.awb") / 1000

					if var_317_23 + var_317_15 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_23 + var_317_15
					end

					if var_317_18.prefab_name ~= "" and arg_314_1.actors_[var_317_18.prefab_name] ~= nil then
						local var_317_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_18.prefab_name].transform, "story_v_out_425081", "425081076", "story_v_out_425081.awb")

						arg_314_1:RecordAudio("425081076", var_317_24)
						arg_314_1:RecordAudio("425081076", var_317_24)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_425081", "425081076", "story_v_out_425081.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_425081", "425081076", "story_v_out_425081.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_25 = math.max(var_317_16, arg_314_1.talkMaxDuration)

			if var_317_15 <= arg_314_1.time_ and arg_314_1.time_ < var_317_15 + var_317_25 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_15) / var_317_25

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_15 + var_317_25 and arg_314_1.time_ < var_317_15 + var_317_25 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
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

		arg_314_1:InitPlayNodeList()
	end,
	Play425081077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 425081077
		arg_318_1.duration_ = 10.53

		local var_318_0 = {
			zh = 6.833,
			ja = 10.533
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
				arg_318_0:Play425081078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1037"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos1037 = var_321_0.localPosition
				var_321_0.localScale = Vector3.New(1, 1, 1)

				arg_318_1:CheckSpriteTmpPos("1037", 3)

				local var_321_2 = var_321_0.childCount

				for iter_321_0 = 0, var_321_2 - 1 do
					local var_321_3 = var_321_0:GetChild(iter_321_0)

					if var_321_3.name == "split_4" then
						var_321_3:SetAsLastSibling()
						var_321_3.gameObject:SetActive(true)

						arg_318_1.var_.actorSpriteSplit1037 = var_321_3.gameObject:GetComponent(typeof(Image))

						arg_318_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_321_4 = 0.3

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_4 then
				local var_321_5 = (arg_318_1.time_ - var_321_1) / var_321_4
				local var_321_6 = Vector3.New(0, -430, -55)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1037, var_321_6, var_321_5)

				if arg_318_1.var_.actorSpriteSplit1037 ~= nil then
					arg_318_1.var_.actorSpriteSplit1037:SetAlpha(var_321_5)
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_4 and arg_318_1.time_ < var_321_1 + var_321_4 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0, -430, -55)

				if arg_318_1.var_.actorSpriteSplit1037 ~= nil then
					arg_318_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_321_7 = 0
			local var_321_8 = 0.8

			if var_321_7 < arg_318_1.time_ and arg_318_1.time_ <= var_321_7 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_9 = arg_318_1:FormatText(StoryNameCfg[15].name)

				arg_318_1.leftNameTxt_.text = var_321_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_10 = arg_318_1:GetWordFromCfg(425081077)
				local var_321_11 = arg_318_1:FormatText(var_321_10.content)

				arg_318_1.text_.text = var_321_11

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_12 = 32
				local var_321_13 = utf8.len(var_321_11)
				local var_321_14 = var_321_12 <= 0 and var_321_8 or var_321_8 * (var_321_13 / var_321_12)

				if var_321_14 > 0 and var_321_8 < var_321_14 then
					arg_318_1.talkMaxDuration = var_321_14

					if var_321_14 + var_321_7 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_14 + var_321_7
					end
				end

				arg_318_1.text_.text = var_321_11
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081077", "story_v_out_425081.awb") ~= 0 then
					local var_321_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081077", "story_v_out_425081.awb") / 1000

					if var_321_15 + var_321_7 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_15 + var_321_7
					end

					if var_321_10.prefab_name ~= "" and arg_318_1.actors_[var_321_10.prefab_name] ~= nil then
						local var_321_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_10.prefab_name].transform, "story_v_out_425081", "425081077", "story_v_out_425081.awb")

						arg_318_1:RecordAudio("425081077", var_321_16)
						arg_318_1:RecordAudio("425081077", var_321_16)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_425081", "425081077", "story_v_out_425081.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_425081", "425081077", "story_v_out_425081.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_17 = math.max(var_321_8, arg_318_1.talkMaxDuration)

			if var_321_7 <= arg_318_1.time_ and arg_318_1.time_ < var_321_7 + var_321_17 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_7) / var_321_17

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_7 + var_321_17 and arg_318_1.time_ < var_321_7 + var_321_17 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play425081078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 425081078
		arg_322_1.duration_ = 8.37

		local var_322_0 = {
			zh = 8.366,
			ja = 7.633
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
				arg_322_0:Play425081079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = "D02b"

			if arg_322_1.bgs_[var_325_0] == nil then
				local var_325_1 = Object.Instantiate(arg_322_1.paintGo_)

				var_325_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_325_0)
				var_325_1.name = var_325_0
				var_325_1.transform.parent = arg_322_1.stage_.transform
				var_325_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.bgs_[var_325_0] = var_325_1
			end

			local var_325_2 = 2

			if var_325_2 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				local var_325_3 = manager.ui.mainCamera.transform.localPosition
				local var_325_4 = Vector3.New(0, 0, 10) + Vector3.New(var_325_3.x, var_325_3.y, 0)
				local var_325_5 = arg_322_1.bgs_.D02b

				var_325_5.transform.localPosition = var_325_4
				var_325_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_325_6 = var_325_5:GetComponent("SpriteRenderer")

				if var_325_6 and var_325_6.sprite then
					local var_325_7 = (var_325_5.transform.localPosition - var_325_3).z
					local var_325_8 = manager.ui.mainCameraCom_
					local var_325_9 = 2 * var_325_7 * Mathf.Tan(var_325_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_325_10 = var_325_9 * var_325_8.aspect
					local var_325_11 = var_325_6.sprite.bounds.size.x
					local var_325_12 = var_325_6.sprite.bounds.size.y
					local var_325_13 = var_325_10 / var_325_11
					local var_325_14 = var_325_9 / var_325_12
					local var_325_15 = var_325_14 < var_325_13 and var_325_13 or var_325_14

					var_325_5.transform.localScale = Vector3.New(var_325_15, var_325_15, 0)
				end

				for iter_325_0, iter_325_1 in pairs(arg_322_1.bgs_) do
					if iter_325_0 ~= "D02b" then
						iter_325_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_325_16 = 4

			if var_325_16 < arg_322_1.time_ and arg_322_1.time_ <= var_325_16 + arg_325_0 then
				arg_322_1.allBtn_.enabled = false
			end

			local var_325_17 = 0.3

			if arg_322_1.time_ >= var_325_16 + var_325_17 and arg_322_1.time_ < var_325_16 + var_325_17 + arg_325_0 then
				arg_322_1.allBtn_.enabled = true
			end

			local var_325_18 = 0

			if var_325_18 < arg_322_1.time_ and arg_322_1.time_ <= var_325_18 + arg_325_0 then
				arg_322_1.mask_.enabled = true
				arg_322_1.mask_.raycastTarget = true

				arg_322_1:SetGaussion(false)
			end

			local var_325_19 = 2

			if var_325_18 <= arg_322_1.time_ and arg_322_1.time_ < var_325_18 + var_325_19 then
				local var_325_20 = (arg_322_1.time_ - var_325_18) / var_325_19
				local var_325_21 = Color.New(0, 0, 0)

				var_325_21.a = Mathf.Lerp(0, 1, var_325_20)
				arg_322_1.mask_.color = var_325_21
			end

			if arg_322_1.time_ >= var_325_18 + var_325_19 and arg_322_1.time_ < var_325_18 + var_325_19 + arg_325_0 then
				local var_325_22 = Color.New(0, 0, 0)

				var_325_22.a = 1
				arg_322_1.mask_.color = var_325_22
			end

			local var_325_23 = 2

			if var_325_23 < arg_322_1.time_ and arg_322_1.time_ <= var_325_23 + arg_325_0 then
				arg_322_1.mask_.enabled = true
				arg_322_1.mask_.raycastTarget = true

				arg_322_1:SetGaussion(false)
			end

			local var_325_24 = 2

			if var_325_23 <= arg_322_1.time_ and arg_322_1.time_ < var_325_23 + var_325_24 then
				local var_325_25 = (arg_322_1.time_ - var_325_23) / var_325_24
				local var_325_26 = Color.New(0, 0, 0)

				var_325_26.a = Mathf.Lerp(1, 0, var_325_25)
				arg_322_1.mask_.color = var_325_26
			end

			if arg_322_1.time_ >= var_325_23 + var_325_24 and arg_322_1.time_ < var_325_23 + var_325_24 + arg_325_0 then
				local var_325_27 = Color.New(0, 0, 0)
				local var_325_28 = 0

				arg_322_1.mask_.enabled = false
				var_325_27.a = var_325_28
				arg_322_1.mask_.color = var_325_27
			end

			local var_325_29 = arg_322_1.actors_["1037"].transform
			local var_325_30 = 2

			if var_325_30 < arg_322_1.time_ and arg_322_1.time_ <= var_325_30 + arg_325_0 then
				arg_322_1.var_.moveOldPos1037 = var_325_29.localPosition
				var_325_29.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("1037", 7)

				local var_325_31 = var_325_29.childCount

				for iter_325_2 = 0, var_325_31 - 1 do
					local var_325_32 = var_325_29:GetChild(iter_325_2)

					if var_325_32.name == "" or not string.find(var_325_32.name, "split") then
						var_325_32.gameObject:SetActive(true)
					else
						var_325_32.gameObject:SetActive(false)
					end
				end
			end

			local var_325_33 = 0.001

			if var_325_30 <= arg_322_1.time_ and arg_322_1.time_ < var_325_30 + var_325_33 then
				local var_325_34 = (arg_322_1.time_ - var_325_30) / var_325_33
				local var_325_35 = Vector3.New(1500, -2000, 0)

				var_325_29.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1037, var_325_35, var_325_34)
			end

			if arg_322_1.time_ >= var_325_30 + var_325_33 and arg_322_1.time_ < var_325_30 + var_325_33 + arg_325_0 then
				var_325_29.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_325_36 = 0.133333333333333
			local var_325_37 = 1

			if var_325_36 < arg_322_1.time_ and arg_322_1.time_ <= var_325_36 + arg_325_0 then
				local var_325_38 = "stop"
				local var_325_39 = "effect"

				arg_322_1:AudioAction(var_325_38, var_325_39, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_325_40 = 1.7
			local var_325_41 = 1

			if var_325_40 < arg_322_1.time_ and arg_322_1.time_ <= var_325_40 + arg_325_0 then
				local var_325_42 = "play"
				local var_325_43 = "effect"

				arg_322_1:AudioAction(var_325_42, var_325_43, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_322_1.frameCnt_ <= 1 then
				arg_322_1.dialog_:SetActive(false)
			end

			local var_325_44 = 4
			local var_325_45 = 0.125

			if var_325_44 < arg_322_1.time_ and arg_322_1.time_ <= var_325_44 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0

				arg_322_1.dialog_:SetActive(true)

				arg_322_1.dialogCg_.alpha = 0

				local var_325_46 = LeanTween.value(arg_322_1.dialog_, 0, 1, 0.3)

				var_325_46:setOnUpdate(LuaHelper.FloatAction(function(arg_326_0)
					arg_322_1.dialogCg_.alpha = arg_326_0
				end))
				var_325_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_322_1.dialog_)
					var_325_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_322_1.duration_ = arg_322_1.duration_ + 0.3

				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_47 = arg_322_1:FormatText(StoryNameCfg[56].name)

				arg_322_1.leftNameTxt_.text = var_325_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_48 = arg_322_1:GetWordFromCfg(425081078)
				local var_325_49 = arg_322_1:FormatText(var_325_48.content)

				arg_322_1.text_.text = var_325_49

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_50 = 5
				local var_325_51 = utf8.len(var_325_49)
				local var_325_52 = var_325_50 <= 0 and var_325_45 or var_325_45 * (var_325_51 / var_325_50)

				if var_325_52 > 0 and var_325_45 < var_325_52 then
					arg_322_1.talkMaxDuration = var_325_52
					var_325_44 = var_325_44 + 0.3

					if var_325_52 + var_325_44 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_52 + var_325_44
					end
				end

				arg_322_1.text_.text = var_325_49
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081078", "story_v_out_425081.awb") ~= 0 then
					local var_325_53 = manager.audio:GetVoiceLength("story_v_out_425081", "425081078", "story_v_out_425081.awb") / 1000

					if var_325_53 + var_325_44 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_53 + var_325_44
					end

					if var_325_48.prefab_name ~= "" and arg_322_1.actors_[var_325_48.prefab_name] ~= nil then
						local var_325_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_48.prefab_name].transform, "story_v_out_425081", "425081078", "story_v_out_425081.awb")

						arg_322_1:RecordAudio("425081078", var_325_54)
						arg_322_1:RecordAudio("425081078", var_325_54)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_425081", "425081078", "story_v_out_425081.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_425081", "425081078", "story_v_out_425081.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_55 = var_325_44 + 0.3
			local var_325_56 = math.max(var_325_45, arg_322_1.talkMaxDuration)

			if var_325_55 <= arg_322_1.time_ and arg_322_1.time_ < var_325_55 + var_325_56 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_55) / var_325_56

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_55 + var_325_56 and arg_322_1.time_ < var_325_55 + var_325_56 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play425081079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 425081079
		arg_328_1.duration_ = 4.3

		local var_328_0 = {
			zh = 4.3,
			ja = 3.2
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play425081080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1080"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps1080 == nil then
				arg_328_1.var_.actorSpriteComps1080 = var_331_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_2 = 0.2

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.actorSpriteComps1080 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								local var_331_4 = Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor1.r, var_331_3)
								local var_331_5 = Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor1.g, var_331_3)
								local var_331_6 = Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor1.b, var_331_3)

								iter_331_1.color = Color.New(var_331_4, var_331_5, var_331_6)
							else
								local var_331_7 = Mathf.Lerp(iter_331_1.color.r, 1, var_331_3)

								iter_331_1.color = Color.New(var_331_7, var_331_7, var_331_7)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.actorSpriteComps1080 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_331_3 then
						if arg_328_1.isInRecall_ then
							iter_331_3.color = arg_328_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_331_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_328_1.var_.actorSpriteComps1080 = nil
			end

			local var_331_8 = arg_328_1.actors_["1080"].transform
			local var_331_9 = 0

			if var_331_9 < arg_328_1.time_ and arg_328_1.time_ <= var_331_9 + arg_331_0 then
				arg_328_1.var_.moveOldPos1080 = var_331_8.localPosition
				var_331_8.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("1080", 3)

				local var_331_10 = var_331_8.childCount

				for iter_331_4 = 0, var_331_10 - 1 do
					local var_331_11 = var_331_8:GetChild(iter_331_4)

					if var_331_11.name == "" or not string.find(var_331_11.name, "split") then
						var_331_11.gameObject:SetActive(true)
					else
						var_331_11.gameObject:SetActive(false)
					end
				end
			end

			local var_331_12 = 0.001

			if var_331_9 <= arg_328_1.time_ and arg_328_1.time_ < var_331_9 + var_331_12 then
				local var_331_13 = (arg_328_1.time_ - var_331_9) / var_331_12
				local var_331_14 = Vector3.New(0, -378, -170)

				var_331_8.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1080, var_331_14, var_331_13)
			end

			if arg_328_1.time_ >= var_331_9 + var_331_12 and arg_328_1.time_ < var_331_9 + var_331_12 + arg_331_0 then
				var_331_8.localPosition = Vector3.New(0, -378, -170)
			end

			local var_331_15 = 0
			local var_331_16 = 0.425

			if var_331_15 < arg_328_1.time_ and arg_328_1.time_ <= var_331_15 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_17 = arg_328_1:FormatText(StoryNameCfg[55].name)

				arg_328_1.leftNameTxt_.text = var_331_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_18 = arg_328_1:GetWordFromCfg(425081079)
				local var_331_19 = arg_328_1:FormatText(var_331_18.content)

				arg_328_1.text_.text = var_331_19

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_20 = 17
				local var_331_21 = utf8.len(var_331_19)
				local var_331_22 = var_331_20 <= 0 and var_331_16 or var_331_16 * (var_331_21 / var_331_20)

				if var_331_22 > 0 and var_331_16 < var_331_22 then
					arg_328_1.talkMaxDuration = var_331_22

					if var_331_22 + var_331_15 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_22 + var_331_15
					end
				end

				arg_328_1.text_.text = var_331_19
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081079", "story_v_out_425081.awb") ~= 0 then
					local var_331_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081079", "story_v_out_425081.awb") / 1000

					if var_331_23 + var_331_15 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_23 + var_331_15
					end

					if var_331_18.prefab_name ~= "" and arg_328_1.actors_[var_331_18.prefab_name] ~= nil then
						local var_331_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_18.prefab_name].transform, "story_v_out_425081", "425081079", "story_v_out_425081.awb")

						arg_328_1:RecordAudio("425081079", var_331_24)
						arg_328_1:RecordAudio("425081079", var_331_24)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_425081", "425081079", "story_v_out_425081.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_425081", "425081079", "story_v_out_425081.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_25 = math.max(var_331_16, arg_328_1.talkMaxDuration)

			if var_331_15 <= arg_328_1.time_ and arg_328_1.time_ < var_331_15 + var_331_25 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_15) / var_331_25

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_15 + var_331_25 and arg_328_1.time_ < var_331_15 + var_331_25 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play425081080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 425081080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play425081081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1080"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.actorSpriteComps1080 == nil then
				arg_332_1.var_.actorSpriteComps1080 = var_335_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_2 = 0.2

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.actorSpriteComps1080 then
					for iter_335_0, iter_335_1 in pairs(arg_332_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_335_1 then
							if arg_332_1.isInRecall_ then
								local var_335_4 = Mathf.Lerp(iter_335_1.color.r, arg_332_1.hightColor2.r, var_335_3)
								local var_335_5 = Mathf.Lerp(iter_335_1.color.g, arg_332_1.hightColor2.g, var_335_3)
								local var_335_6 = Mathf.Lerp(iter_335_1.color.b, arg_332_1.hightColor2.b, var_335_3)

								iter_335_1.color = Color.New(var_335_4, var_335_5, var_335_6)
							else
								local var_335_7 = Mathf.Lerp(iter_335_1.color.r, 0.5, var_335_3)

								iter_335_1.color = Color.New(var_335_7, var_335_7, var_335_7)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.actorSpriteComps1080 then
				for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_335_3 then
						if arg_332_1.isInRecall_ then
							iter_335_3.color = arg_332_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_335_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_332_1.var_.actorSpriteComps1080 = nil
			end

			local var_335_8 = 0
			local var_335_9 = 0.925

			if var_335_8 < arg_332_1.time_ and arg_332_1.time_ <= var_335_8 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_10 = arg_332_1:FormatText(StoryNameCfg[7].name)

				arg_332_1.leftNameTxt_.text = var_335_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_11 = arg_332_1:GetWordFromCfg(425081080)
				local var_335_12 = arg_332_1:FormatText(var_335_11.content)

				arg_332_1.text_.text = var_335_12

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_13 = 37
				local var_335_14 = utf8.len(var_335_12)
				local var_335_15 = var_335_13 <= 0 and var_335_9 or var_335_9 * (var_335_14 / var_335_13)

				if var_335_15 > 0 and var_335_9 < var_335_15 then
					arg_332_1.talkMaxDuration = var_335_15

					if var_335_15 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_15 + var_335_8
					end
				end

				arg_332_1.text_.text = var_335_12
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_16 = math.max(var_335_9, arg_332_1.talkMaxDuration)

			if var_335_8 <= arg_332_1.time_ and arg_332_1.time_ < var_335_8 + var_335_16 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_8) / var_335_16

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_8 + var_335_16 and arg_332_1.time_ < var_335_8 + var_335_16 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play425081081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 425081081
		arg_336_1.duration_ = 1.83

		local var_336_0 = {
			zh = 1.833,
			ja = 0.999999999999
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play425081082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1080"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.actorSpriteComps1080 == nil then
				arg_336_1.var_.actorSpriteComps1080 = var_339_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_2 = 0.2

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.actorSpriteComps1080 then
					for iter_339_0, iter_339_1 in pairs(arg_336_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_339_1 then
							if arg_336_1.isInRecall_ then
								local var_339_4 = Mathf.Lerp(iter_339_1.color.r, arg_336_1.hightColor1.r, var_339_3)
								local var_339_5 = Mathf.Lerp(iter_339_1.color.g, arg_336_1.hightColor1.g, var_339_3)
								local var_339_6 = Mathf.Lerp(iter_339_1.color.b, arg_336_1.hightColor1.b, var_339_3)

								iter_339_1.color = Color.New(var_339_4, var_339_5, var_339_6)
							else
								local var_339_7 = Mathf.Lerp(iter_339_1.color.r, 1, var_339_3)

								iter_339_1.color = Color.New(var_339_7, var_339_7, var_339_7)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.actorSpriteComps1080 then
				for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_339_3 then
						if arg_336_1.isInRecall_ then
							iter_339_3.color = arg_336_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_339_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_336_1.var_.actorSpriteComps1080 = nil
			end

			local var_339_8 = 0
			local var_339_9 = 0.1

			if var_339_8 < arg_336_1.time_ and arg_336_1.time_ <= var_339_8 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_10 = arg_336_1:FormatText(StoryNameCfg[55].name)

				arg_336_1.leftNameTxt_.text = var_339_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_11 = arg_336_1:GetWordFromCfg(425081081)
				local var_339_12 = arg_336_1:FormatText(var_339_11.content)

				arg_336_1.text_.text = var_339_12

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_13 = 4
				local var_339_14 = utf8.len(var_339_12)
				local var_339_15 = var_339_13 <= 0 and var_339_9 or var_339_9 * (var_339_14 / var_339_13)

				if var_339_15 > 0 and var_339_9 < var_339_15 then
					arg_336_1.talkMaxDuration = var_339_15

					if var_339_15 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_15 + var_339_8
					end
				end

				arg_336_1.text_.text = var_339_12
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081081", "story_v_out_425081.awb") ~= 0 then
					local var_339_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081081", "story_v_out_425081.awb") / 1000

					if var_339_16 + var_339_8 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_16 + var_339_8
					end

					if var_339_11.prefab_name ~= "" and arg_336_1.actors_[var_339_11.prefab_name] ~= nil then
						local var_339_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_11.prefab_name].transform, "story_v_out_425081", "425081081", "story_v_out_425081.awb")

						arg_336_1:RecordAudio("425081081", var_339_17)
						arg_336_1:RecordAudio("425081081", var_339_17)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_425081", "425081081", "story_v_out_425081.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_425081", "425081081", "story_v_out_425081.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_18 = math.max(var_339_9, arg_336_1.talkMaxDuration)

			if var_339_8 <= arg_336_1.time_ and arg_336_1.time_ < var_339_8 + var_339_18 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_8) / var_339_18

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_8 + var_339_18 and arg_336_1.time_ < var_339_8 + var_339_18 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play425081082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 425081082
		arg_340_1.duration_ = 8.93

		local var_340_0 = {
			zh = 5.9,
			ja = 8.933
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play425081083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1037"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps1037 == nil then
				arg_340_1.var_.actorSpriteComps1037 = var_343_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_2 = 0.2

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.actorSpriteComps1037 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								local var_343_4 = Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor1.r, var_343_3)
								local var_343_5 = Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor1.g, var_343_3)
								local var_343_6 = Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor1.b, var_343_3)

								iter_343_1.color = Color.New(var_343_4, var_343_5, var_343_6)
							else
								local var_343_7 = Mathf.Lerp(iter_343_1.color.r, 1, var_343_3)

								iter_343_1.color = Color.New(var_343_7, var_343_7, var_343_7)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.actorSpriteComps1037 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_343_3 then
						if arg_340_1.isInRecall_ then
							iter_343_3.color = arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_343_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps1037 = nil
			end

			local var_343_8 = arg_340_1.actors_["1080"]
			local var_343_9 = 0

			if var_343_9 < arg_340_1.time_ and arg_340_1.time_ <= var_343_9 + arg_343_0 and not isNil(var_343_8) and arg_340_1.var_.actorSpriteComps1080 == nil then
				arg_340_1.var_.actorSpriteComps1080 = var_343_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_10 = 0.2

			if var_343_9 <= arg_340_1.time_ and arg_340_1.time_ < var_343_9 + var_343_10 and not isNil(var_343_8) then
				local var_343_11 = (arg_340_1.time_ - var_343_9) / var_343_10

				if arg_340_1.var_.actorSpriteComps1080 then
					for iter_343_4, iter_343_5 in pairs(arg_340_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_343_5 then
							if arg_340_1.isInRecall_ then
								local var_343_12 = Mathf.Lerp(iter_343_5.color.r, arg_340_1.hightColor2.r, var_343_11)
								local var_343_13 = Mathf.Lerp(iter_343_5.color.g, arg_340_1.hightColor2.g, var_343_11)
								local var_343_14 = Mathf.Lerp(iter_343_5.color.b, arg_340_1.hightColor2.b, var_343_11)

								iter_343_5.color = Color.New(var_343_12, var_343_13, var_343_14)
							else
								local var_343_15 = Mathf.Lerp(iter_343_5.color.r, 0.5, var_343_11)

								iter_343_5.color = Color.New(var_343_15, var_343_15, var_343_15)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= var_343_9 + var_343_10 and arg_340_1.time_ < var_343_9 + var_343_10 + arg_343_0 and not isNil(var_343_8) and arg_340_1.var_.actorSpriteComps1080 then
				for iter_343_6, iter_343_7 in pairs(arg_340_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_343_7 then
						if arg_340_1.isInRecall_ then
							iter_343_7.color = arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_343_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_340_1.var_.actorSpriteComps1080 = nil
			end

			local var_343_16 = arg_340_1.actors_["1037"].transform
			local var_343_17 = 0

			if var_343_17 < arg_340_1.time_ and arg_340_1.time_ <= var_343_17 + arg_343_0 then
				arg_340_1.var_.moveOldPos1037 = var_343_16.localPosition
				var_343_16.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("1037", 2)

				local var_343_18 = var_343_16.childCount

				for iter_343_8 = 0, var_343_18 - 1 do
					local var_343_19 = var_343_16:GetChild(iter_343_8)

					if var_343_19.name == "" or not string.find(var_343_19.name, "split") then
						var_343_19.gameObject:SetActive(true)
					else
						var_343_19.gameObject:SetActive(false)
					end
				end
			end

			local var_343_20 = 0.001

			if var_343_17 <= arg_340_1.time_ and arg_340_1.time_ < var_343_17 + var_343_20 then
				local var_343_21 = (arg_340_1.time_ - var_343_17) / var_343_20
				local var_343_22 = Vector3.New(-390, -430, -55)

				var_343_16.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1037, var_343_22, var_343_21)
			end

			if arg_340_1.time_ >= var_343_17 + var_343_20 and arg_340_1.time_ < var_343_17 + var_343_20 + arg_343_0 then
				var_343_16.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_343_23 = arg_340_1.actors_["1080"].transform
			local var_343_24 = 0

			if var_343_24 < arg_340_1.time_ and arg_340_1.time_ <= var_343_24 + arg_343_0 then
				arg_340_1.var_.moveOldPos1080 = var_343_23.localPosition
				var_343_23.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("1080", 4)

				local var_343_25 = var_343_23.childCount

				for iter_343_9 = 0, var_343_25 - 1 do
					local var_343_26 = var_343_23:GetChild(iter_343_9)

					if var_343_26.name == "" or not string.find(var_343_26.name, "split") then
						var_343_26.gameObject:SetActive(true)
					else
						var_343_26.gameObject:SetActive(false)
					end
				end
			end

			local var_343_27 = 0.001

			if var_343_24 <= arg_340_1.time_ and arg_340_1.time_ < var_343_24 + var_343_27 then
				local var_343_28 = (arg_340_1.time_ - var_343_24) / var_343_27
				local var_343_29 = Vector3.New(390, -378, -170)

				var_343_23.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1080, var_343_29, var_343_28)
			end

			if arg_340_1.time_ >= var_343_24 + var_343_27 and arg_340_1.time_ < var_343_24 + var_343_27 + arg_343_0 then
				var_343_23.localPosition = Vector3.New(390, -378, -170)
			end

			local var_343_30 = 0
			local var_343_31 = 0.7

			if var_343_30 < arg_340_1.time_ and arg_340_1.time_ <= var_343_30 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_32 = arg_340_1:FormatText(StoryNameCfg[15].name)

				arg_340_1.leftNameTxt_.text = var_343_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_33 = arg_340_1:GetWordFromCfg(425081082)
				local var_343_34 = arg_340_1:FormatText(var_343_33.content)

				arg_340_1.text_.text = var_343_34

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_35 = 28
				local var_343_36 = utf8.len(var_343_34)
				local var_343_37 = var_343_35 <= 0 and var_343_31 or var_343_31 * (var_343_36 / var_343_35)

				if var_343_37 > 0 and var_343_31 < var_343_37 then
					arg_340_1.talkMaxDuration = var_343_37

					if var_343_37 + var_343_30 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_37 + var_343_30
					end
				end

				arg_340_1.text_.text = var_343_34
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081082", "story_v_out_425081.awb") ~= 0 then
					local var_343_38 = manager.audio:GetVoiceLength("story_v_out_425081", "425081082", "story_v_out_425081.awb") / 1000

					if var_343_38 + var_343_30 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_38 + var_343_30
					end

					if var_343_33.prefab_name ~= "" and arg_340_1.actors_[var_343_33.prefab_name] ~= nil then
						local var_343_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_33.prefab_name].transform, "story_v_out_425081", "425081082", "story_v_out_425081.awb")

						arg_340_1:RecordAudio("425081082", var_343_39)
						arg_340_1:RecordAudio("425081082", var_343_39)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_425081", "425081082", "story_v_out_425081.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_425081", "425081082", "story_v_out_425081.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_40 = math.max(var_343_31, arg_340_1.talkMaxDuration)

			if var_343_30 <= arg_340_1.time_ and arg_340_1.time_ < var_343_30 + var_343_40 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_30) / var_343_40

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_30 + var_343_40 and arg_340_1.time_ < var_343_30 + var_343_40 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
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
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play425081083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 425081083
		arg_344_1.duration_ = 2.73

		local var_344_0 = {
			zh = 2.733,
			ja = 2.6
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
				arg_344_0:Play425081084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1080"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.actorSpriteComps1080 == nil then
				arg_344_1.var_.actorSpriteComps1080 = var_347_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_2 = 0.2

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.actorSpriteComps1080 then
					for iter_347_0, iter_347_1 in pairs(arg_344_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.actorSpriteComps1080 then
				for iter_347_2, iter_347_3 in pairs(arg_344_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_347_3 then
						if arg_344_1.isInRecall_ then
							iter_347_3.color = arg_344_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_347_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_344_1.var_.actorSpriteComps1080 = nil
			end

			local var_347_8 = arg_344_1.actors_["1037"]
			local var_347_9 = 0

			if var_347_9 < arg_344_1.time_ and arg_344_1.time_ <= var_347_9 + arg_347_0 and not isNil(var_347_8) and arg_344_1.var_.actorSpriteComps1037 == nil then
				arg_344_1.var_.actorSpriteComps1037 = var_347_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_10 = 0.2

			if var_347_9 <= arg_344_1.time_ and arg_344_1.time_ < var_347_9 + var_347_10 and not isNil(var_347_8) then
				local var_347_11 = (arg_344_1.time_ - var_347_9) / var_347_10

				if arg_344_1.var_.actorSpriteComps1037 then
					for iter_347_4, iter_347_5 in pairs(arg_344_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_347_5 then
							if arg_344_1.isInRecall_ then
								local var_347_12 = Mathf.Lerp(iter_347_5.color.r, arg_344_1.hightColor2.r, var_347_11)
								local var_347_13 = Mathf.Lerp(iter_347_5.color.g, arg_344_1.hightColor2.g, var_347_11)
								local var_347_14 = Mathf.Lerp(iter_347_5.color.b, arg_344_1.hightColor2.b, var_347_11)

								iter_347_5.color = Color.New(var_347_12, var_347_13, var_347_14)
							else
								local var_347_15 = Mathf.Lerp(iter_347_5.color.r, 0.5, var_347_11)

								iter_347_5.color = Color.New(var_347_15, var_347_15, var_347_15)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= var_347_9 + var_347_10 and arg_344_1.time_ < var_347_9 + var_347_10 + arg_347_0 and not isNil(var_347_8) and arg_344_1.var_.actorSpriteComps1037 then
				for iter_347_6, iter_347_7 in pairs(arg_344_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_347_7 then
						if arg_344_1.isInRecall_ then
							iter_347_7.color = arg_344_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_347_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_344_1.var_.actorSpriteComps1037 = nil
			end

			local var_347_16 = arg_344_1.actors_["1080"].transform
			local var_347_17 = 0

			if var_347_17 < arg_344_1.time_ and arg_344_1.time_ <= var_347_17 + arg_347_0 then
				arg_344_1.var_.moveOldPos1080 = var_347_16.localPosition
				var_347_16.localScale = Vector3.New(1, 1, 1)

				arg_344_1:CheckSpriteTmpPos("1080", 4)

				local var_347_18 = var_347_16.childCount

				for iter_347_8 = 0, var_347_18 - 1 do
					local var_347_19 = var_347_16:GetChild(iter_347_8)

					if var_347_19.name == "" or not string.find(var_347_19.name, "split") then
						var_347_19.gameObject:SetActive(true)
					else
						var_347_19.gameObject:SetActive(false)
					end
				end
			end

			local var_347_20 = 0.001

			if var_347_17 <= arg_344_1.time_ and arg_344_1.time_ < var_347_17 + var_347_20 then
				local var_347_21 = (arg_344_1.time_ - var_347_17) / var_347_20
				local var_347_22 = Vector3.New(390, -378, -170)

				var_347_16.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1080, var_347_22, var_347_21)
			end

			if arg_344_1.time_ >= var_347_17 + var_347_20 and arg_344_1.time_ < var_347_17 + var_347_20 + arg_347_0 then
				var_347_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_347_23 = 0
			local var_347_24 = 0.2

			if var_347_23 < arg_344_1.time_ and arg_344_1.time_ <= var_347_23 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_25 = arg_344_1:FormatText(StoryNameCfg[55].name)

				arg_344_1.leftNameTxt_.text = var_347_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_26 = arg_344_1:GetWordFromCfg(425081083)
				local var_347_27 = arg_344_1:FormatText(var_347_26.content)

				arg_344_1.text_.text = var_347_27

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_28 = 8
				local var_347_29 = utf8.len(var_347_27)
				local var_347_30 = var_347_28 <= 0 and var_347_24 or var_347_24 * (var_347_29 / var_347_28)

				if var_347_30 > 0 and var_347_24 < var_347_30 then
					arg_344_1.talkMaxDuration = var_347_30

					if var_347_30 + var_347_23 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_30 + var_347_23
					end
				end

				arg_344_1.text_.text = var_347_27
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081083", "story_v_out_425081.awb") ~= 0 then
					local var_347_31 = manager.audio:GetVoiceLength("story_v_out_425081", "425081083", "story_v_out_425081.awb") / 1000

					if var_347_31 + var_347_23 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_31 + var_347_23
					end

					if var_347_26.prefab_name ~= "" and arg_344_1.actors_[var_347_26.prefab_name] ~= nil then
						local var_347_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_26.prefab_name].transform, "story_v_out_425081", "425081083", "story_v_out_425081.awb")

						arg_344_1:RecordAudio("425081083", var_347_32)
						arg_344_1:RecordAudio("425081083", var_347_32)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_425081", "425081083", "story_v_out_425081.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_425081", "425081083", "story_v_out_425081.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_33 = math.max(var_347_24, arg_344_1.talkMaxDuration)

			if var_347_23 <= arg_344_1.time_ and arg_344_1.time_ < var_347_23 + var_347_33 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_23) / var_347_33

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_23 + var_347_33 and arg_344_1.time_ < var_347_23 + var_347_33 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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
	Play425081084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 425081084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play425081085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1080"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.actorSpriteComps1080 == nil then
				arg_348_1.var_.actorSpriteComps1080 = var_351_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_2 = 0.2

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.actorSpriteComps1080 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								local var_351_4 = Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor2.r, var_351_3)
								local var_351_5 = Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor2.g, var_351_3)
								local var_351_6 = Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor2.b, var_351_3)

								iter_351_1.color = Color.New(var_351_4, var_351_5, var_351_6)
							else
								local var_351_7 = Mathf.Lerp(iter_351_1.color.r, 0.5, var_351_3)

								iter_351_1.color = Color.New(var_351_7, var_351_7, var_351_7)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.actorSpriteComps1080 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_351_3 then
						if arg_348_1.isInRecall_ then
							iter_351_3.color = arg_348_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_351_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_348_1.var_.actorSpriteComps1080 = nil
			end

			local var_351_8 = arg_348_1.actors_["1080"].transform
			local var_351_9 = 0

			if var_351_9 < arg_348_1.time_ and arg_348_1.time_ <= var_351_9 + arg_351_0 then
				arg_348_1.var_.moveOldPos1080 = var_351_8.localPosition
				var_351_8.localScale = Vector3.New(1, 1, 1)

				arg_348_1:CheckSpriteTmpPos("1080", 7)

				local var_351_10 = var_351_8.childCount

				for iter_351_4 = 0, var_351_10 - 1 do
					local var_351_11 = var_351_8:GetChild(iter_351_4)

					if var_351_11.name == "" or not string.find(var_351_11.name, "split") then
						var_351_11.gameObject:SetActive(true)
					else
						var_351_11.gameObject:SetActive(false)
					end
				end
			end

			local var_351_12 = 0.001

			if var_351_9 <= arg_348_1.time_ and arg_348_1.time_ < var_351_9 + var_351_12 then
				local var_351_13 = (arg_348_1.time_ - var_351_9) / var_351_12
				local var_351_14 = Vector3.New(0, -2000, 0)

				var_351_8.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1080, var_351_14, var_351_13)
			end

			if arg_348_1.time_ >= var_351_9 + var_351_12 and arg_348_1.time_ < var_351_9 + var_351_12 + arg_351_0 then
				var_351_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_351_15 = arg_348_1.actors_["1037"].transform
			local var_351_16 = 0

			if var_351_16 < arg_348_1.time_ and arg_348_1.time_ <= var_351_16 + arg_351_0 then
				arg_348_1.var_.moveOldPos1037 = var_351_15.localPosition
				var_351_15.localScale = Vector3.New(1, 1, 1)

				arg_348_1:CheckSpriteTmpPos("1037", 7)

				local var_351_17 = var_351_15.childCount

				for iter_351_5 = 0, var_351_17 - 1 do
					local var_351_18 = var_351_15:GetChild(iter_351_5)

					if var_351_18.name == "" or not string.find(var_351_18.name, "split") then
						var_351_18.gameObject:SetActive(true)
					else
						var_351_18.gameObject:SetActive(false)
					end
				end
			end

			local var_351_19 = 0.001

			if var_351_16 <= arg_348_1.time_ and arg_348_1.time_ < var_351_16 + var_351_19 then
				local var_351_20 = (arg_348_1.time_ - var_351_16) / var_351_19
				local var_351_21 = Vector3.New(1500, -2000, 0)

				var_351_15.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1037, var_351_21, var_351_20)
			end

			if arg_348_1.time_ >= var_351_16 + var_351_19 and arg_348_1.time_ < var_351_16 + var_351_19 + arg_351_0 then
				var_351_15.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_351_22 = 0
			local var_351_23 = 0.925

			if var_351_22 < arg_348_1.time_ and arg_348_1.time_ <= var_351_22 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_24 = arg_348_1:GetWordFromCfg(425081084)
				local var_351_25 = arg_348_1:FormatText(var_351_24.content)

				arg_348_1.text_.text = var_351_25

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_26 = 37
				local var_351_27 = utf8.len(var_351_25)
				local var_351_28 = var_351_26 <= 0 and var_351_23 or var_351_23 * (var_351_27 / var_351_26)

				if var_351_28 > 0 and var_351_23 < var_351_28 then
					arg_348_1.talkMaxDuration = var_351_28

					if var_351_28 + var_351_22 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_28 + var_351_22
					end
				end

				arg_348_1.text_.text = var_351_25
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_29 = math.max(var_351_23, arg_348_1.talkMaxDuration)

			if var_351_22 <= arg_348_1.time_ and arg_348_1.time_ < var_351_22 + var_351_29 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_22) / var_351_29

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_22 + var_351_29 and arg_348_1.time_ < var_351_22 + var_351_29 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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

		arg_348_1:InitPlayNodeList()
	end,
	Play425081085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 425081085
		arg_352_1.duration_ = 3.6

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play425081086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_1 = 1

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_1 then
				local var_355_2 = (arg_352_1.time_ - var_355_0) / var_355_1
				local var_355_3 = Color.New(0, 0, 0)

				var_355_3.a = Mathf.Lerp(0, 1, var_355_2)
				arg_352_1.mask_.color = var_355_3
			end

			if arg_352_1.time_ >= var_355_0 + var_355_1 and arg_352_1.time_ < var_355_0 + var_355_1 + arg_355_0 then
				local var_355_4 = Color.New(0, 0, 0)

				var_355_4.a = 1
				arg_352_1.mask_.color = var_355_4
			end

			local var_355_5 = 1

			if var_355_5 < arg_352_1.time_ and arg_352_1.time_ <= var_355_5 + arg_355_0 then
				arg_352_1.mask_.enabled = true
				arg_352_1.mask_.raycastTarget = true

				arg_352_1:SetGaussion(false)
			end

			local var_355_6 = 1

			if var_355_5 <= arg_352_1.time_ and arg_352_1.time_ < var_355_5 + var_355_6 then
				local var_355_7 = (arg_352_1.time_ - var_355_5) / var_355_6
				local var_355_8 = Color.New(0, 0, 0)

				var_355_8.a = Mathf.Lerp(1, 0, var_355_7)
				arg_352_1.mask_.color = var_355_8
			end

			if arg_352_1.time_ >= var_355_5 + var_355_6 and arg_352_1.time_ < var_355_5 + var_355_6 + arg_355_0 then
				local var_355_9 = Color.New(0, 0, 0)
				local var_355_10 = 0

				arg_352_1.mask_.enabled = false
				var_355_9.a = var_355_10
				arg_352_1.mask_.color = var_355_9
			end

			local var_355_11 = "STblack"

			if arg_352_1.bgs_[var_355_11] == nil then
				local var_355_12 = Object.Instantiate(arg_352_1.paintGo_)

				var_355_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_355_11)
				var_355_12.name = var_355_11
				var_355_12.transform.parent = arg_352_1.stage_.transform
				var_355_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_352_1.bgs_[var_355_11] = var_355_12
			end

			local var_355_13 = 1

			if var_355_13 < arg_352_1.time_ and arg_352_1.time_ <= var_355_13 + arg_355_0 then
				local var_355_14 = manager.ui.mainCamera.transform.localPosition
				local var_355_15 = Vector3.New(0, 0, 10) + Vector3.New(var_355_14.x, var_355_14.y, 0)
				local var_355_16 = arg_352_1.bgs_.STblack

				var_355_16.transform.localPosition = var_355_15
				var_355_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_355_17 = var_355_16:GetComponent("SpriteRenderer")

				if var_355_17 and var_355_17.sprite then
					local var_355_18 = (var_355_16.transform.localPosition - var_355_14).z
					local var_355_19 = manager.ui.mainCameraCom_
					local var_355_20 = 2 * var_355_18 * Mathf.Tan(var_355_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_355_21 = var_355_20 * var_355_19.aspect
					local var_355_22 = var_355_17.sprite.bounds.size.x
					local var_355_23 = var_355_17.sprite.bounds.size.y
					local var_355_24 = var_355_21 / var_355_22
					local var_355_25 = var_355_20 / var_355_23
					local var_355_26 = var_355_25 < var_355_24 and var_355_24 or var_355_25

					var_355_16.transform.localScale = Vector3.New(var_355_26, var_355_26, 0)
				end

				for iter_355_0, iter_355_1 in pairs(arg_352_1.bgs_) do
					if iter_355_0 ~= "STblack" then
						iter_355_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425081085,
				charCount = 30,
				enableLayoutChange = true,
				duration = 2,
				groupID = "1085",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play425081086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 425081086
		arg_356_1.duration_ = 10.4

		local var_356_0 = {
			zh = 10.133,
			ja = 10.4
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
				arg_356_0:Play425081087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = arg_356_1.actors_["1080"]
			local var_359_1 = 1.8

			if var_359_1 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.actorSpriteComps1080 == nil then
				arg_356_1.var_.actorSpriteComps1080 = var_359_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_2 = 0.2

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_2 and not isNil(var_359_0) then
				local var_359_3 = (arg_356_1.time_ - var_359_1) / var_359_2

				if arg_356_1.var_.actorSpriteComps1080 then
					for iter_359_0, iter_359_1 in pairs(arg_356_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_359_1 then
							if arg_356_1.isInRecall_ then
								local var_359_4 = Mathf.Lerp(iter_359_1.color.r, arg_356_1.hightColor1.r, var_359_3)
								local var_359_5 = Mathf.Lerp(iter_359_1.color.g, arg_356_1.hightColor1.g, var_359_3)
								local var_359_6 = Mathf.Lerp(iter_359_1.color.b, arg_356_1.hightColor1.b, var_359_3)

								iter_359_1.color = Color.New(var_359_4, var_359_5, var_359_6)
							else
								local var_359_7 = Mathf.Lerp(iter_359_1.color.r, 1, var_359_3)

								iter_359_1.color = Color.New(var_359_7, var_359_7, var_359_7)
							end
						end
					end
				end
			end

			if arg_356_1.time_ >= var_359_1 + var_359_2 and arg_356_1.time_ < var_359_1 + var_359_2 + arg_359_0 and not isNil(var_359_0) and arg_356_1.var_.actorSpriteComps1080 then
				for iter_359_2, iter_359_3 in pairs(arg_356_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_359_3 then
						if arg_356_1.isInRecall_ then
							iter_359_3.color = arg_356_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_359_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_356_1.var_.actorSpriteComps1080 = nil
			end

			local var_359_8 = arg_356_1.actors_["1080"].transform
			local var_359_9 = 1.8

			if var_359_9 < arg_356_1.time_ and arg_356_1.time_ <= var_359_9 + arg_359_0 then
				arg_356_1.var_.moveOldPos1080 = var_359_8.localPosition
				var_359_8.localScale = Vector3.New(1, 1, 1)

				arg_356_1:CheckSpriteTmpPos("1080", 2)

				local var_359_10 = var_359_8.childCount

				for iter_359_4 = 0, var_359_10 - 1 do
					local var_359_11 = var_359_8:GetChild(iter_359_4)

					if var_359_11.name == "" or not string.find(var_359_11.name, "split") then
						var_359_11.gameObject:SetActive(true)
					else
						var_359_11.gameObject:SetActive(false)
					end
				end
			end

			local var_359_12 = 0.001

			if var_359_9 <= arg_356_1.time_ and arg_356_1.time_ < var_359_9 + var_359_12 then
				local var_359_13 = (arg_356_1.time_ - var_359_9) / var_359_12
				local var_359_14 = Vector3.New(-390, -378, -170)

				var_359_8.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1080, var_359_14, var_359_13)
			end

			if arg_356_1.time_ >= var_359_9 + var_359_12 and arg_356_1.time_ < var_359_9 + var_359_12 + arg_359_0 then
				var_359_8.localPosition = Vector3.New(-390, -378, -170)
			end

			local var_359_15 = 0

			if var_359_15 < arg_356_1.time_ and arg_356_1.time_ <= var_359_15 + arg_359_0 then
				arg_356_1.mask_.enabled = true
				arg_356_1.mask_.raycastTarget = true

				arg_356_1:SetGaussion(false)
			end

			local var_359_16 = 1

			if var_359_15 <= arg_356_1.time_ and arg_356_1.time_ < var_359_15 + var_359_16 then
				local var_359_17 = (arg_356_1.time_ - var_359_15) / var_359_16
				local var_359_18 = Color.New(0, 0, 0)

				var_359_18.a = Mathf.Lerp(0, 1, var_359_17)
				arg_356_1.mask_.color = var_359_18
			end

			if arg_356_1.time_ >= var_359_15 + var_359_16 and arg_356_1.time_ < var_359_15 + var_359_16 + arg_359_0 then
				local var_359_19 = Color.New(0, 0, 0)

				var_359_19.a = 1
				arg_356_1.mask_.color = var_359_19
			end

			local var_359_20 = 1

			if var_359_20 < arg_356_1.time_ and arg_356_1.time_ <= var_359_20 + arg_359_0 then
				arg_356_1.mask_.enabled = true
				arg_356_1.mask_.raycastTarget = true

				arg_356_1:SetGaussion(false)
			end

			local var_359_21 = 1

			if var_359_20 <= arg_356_1.time_ and arg_356_1.time_ < var_359_20 + var_359_21 then
				local var_359_22 = (arg_356_1.time_ - var_359_20) / var_359_21
				local var_359_23 = Color.New(0, 0, 0)

				var_359_23.a = Mathf.Lerp(1, 0, var_359_22)
				arg_356_1.mask_.color = var_359_23
			end

			if arg_356_1.time_ >= var_359_20 + var_359_21 and arg_356_1.time_ < var_359_20 + var_359_21 + arg_359_0 then
				local var_359_24 = Color.New(0, 0, 0)
				local var_359_25 = 0

				arg_356_1.mask_.enabled = false
				var_359_24.a = var_359_25
				arg_356_1.mask_.color = var_359_24
			end

			local var_359_26 = 1

			if var_359_26 < arg_356_1.time_ and arg_356_1.time_ <= var_359_26 + arg_359_0 then
				local var_359_27 = manager.ui.mainCamera.transform.localPosition
				local var_359_28 = Vector3.New(0, 0, 10) + Vector3.New(var_359_27.x, var_359_27.y, 0)
				local var_359_29 = arg_356_1.bgs_.D02b

				var_359_29.transform.localPosition = var_359_28
				var_359_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_359_30 = var_359_29:GetComponent("SpriteRenderer")

				if var_359_30 and var_359_30.sprite then
					local var_359_31 = (var_359_29.transform.localPosition - var_359_27).z
					local var_359_32 = manager.ui.mainCameraCom_
					local var_359_33 = 2 * var_359_31 * Mathf.Tan(var_359_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_359_34 = var_359_33 * var_359_32.aspect
					local var_359_35 = var_359_30.sprite.bounds.size.x
					local var_359_36 = var_359_30.sprite.bounds.size.y
					local var_359_37 = var_359_34 / var_359_35
					local var_359_38 = var_359_33 / var_359_36
					local var_359_39 = var_359_38 < var_359_37 and var_359_37 or var_359_38

					var_359_29.transform.localScale = Vector3.New(var_359_39, var_359_39, 0)
				end

				for iter_359_5, iter_359_6 in pairs(arg_356_1.bgs_) do
					if iter_359_5 ~= "D02b" then
						iter_359_6.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_359_40 = 2
			local var_359_41 = 0.725

			if var_359_40 < arg_356_1.time_ and arg_356_1.time_ <= var_359_40 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_42 = arg_356_1:FormatText(StoryNameCfg[55].name)

				arg_356_1.leftNameTxt_.text = var_359_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_43 = arg_356_1:GetWordFromCfg(425081086)
				local var_359_44 = arg_356_1:FormatText(var_359_43.content)

				arg_356_1.text_.text = var_359_44

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_45 = 29
				local var_359_46 = utf8.len(var_359_44)
				local var_359_47 = var_359_45 <= 0 and var_359_41 or var_359_41 * (var_359_46 / var_359_45)

				if var_359_47 > 0 and var_359_41 < var_359_47 then
					arg_356_1.talkMaxDuration = var_359_47

					if var_359_47 + var_359_40 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_47 + var_359_40
					end
				end

				arg_356_1.text_.text = var_359_44
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081086", "story_v_out_425081.awb") ~= 0 then
					local var_359_48 = manager.audio:GetVoiceLength("story_v_out_425081", "425081086", "story_v_out_425081.awb") / 1000

					if var_359_48 + var_359_40 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_48 + var_359_40
					end

					if var_359_43.prefab_name ~= "" and arg_356_1.actors_[var_359_43.prefab_name] ~= nil then
						local var_359_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_43.prefab_name].transform, "story_v_out_425081", "425081086", "story_v_out_425081.awb")

						arg_356_1:RecordAudio("425081086", var_359_49)
						arg_356_1:RecordAudio("425081086", var_359_49)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_425081", "425081086", "story_v_out_425081.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_425081", "425081086", "story_v_out_425081.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_50 = math.max(var_359_41, arg_356_1.talkMaxDuration)

			if var_359_40 <= arg_356_1.time_ and arg_356_1.time_ < var_359_40 + var_359_50 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_40) / var_359_50

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_40 + var_359_50 and arg_356_1.time_ < var_359_40 + var_359_50 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				groupID = "1085",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play425081087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 425081087
		arg_360_1.duration_ = 3.17

		local var_360_0 = {
			zh = 2.2,
			ja = 3.166
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
				arg_360_0:Play425081088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1037"]
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.actorSpriteComps1037 == nil then
				arg_360_1.var_.actorSpriteComps1037 = var_363_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_2 = 0.2

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 and not isNil(var_363_0) then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2

				if arg_360_1.var_.actorSpriteComps1037 then
					for iter_363_0, iter_363_1 in pairs(arg_360_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 and not isNil(var_363_0) and arg_360_1.var_.actorSpriteComps1037 then
				for iter_363_2, iter_363_3 in pairs(arg_360_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_363_3 then
						if arg_360_1.isInRecall_ then
							iter_363_3.color = arg_360_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_363_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_360_1.var_.actorSpriteComps1037 = nil
			end

			local var_363_8 = arg_360_1.actors_["1080"]
			local var_363_9 = 0

			if var_363_9 < arg_360_1.time_ and arg_360_1.time_ <= var_363_9 + arg_363_0 and not isNil(var_363_8) and arg_360_1.var_.actorSpriteComps1080 == nil then
				arg_360_1.var_.actorSpriteComps1080 = var_363_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_10 = 0.2

			if var_363_9 <= arg_360_1.time_ and arg_360_1.time_ < var_363_9 + var_363_10 and not isNil(var_363_8) then
				local var_363_11 = (arg_360_1.time_ - var_363_9) / var_363_10

				if arg_360_1.var_.actorSpriteComps1080 then
					for iter_363_4, iter_363_5 in pairs(arg_360_1.var_.actorSpriteComps1080:ToTable()) do
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

			if arg_360_1.time_ >= var_363_9 + var_363_10 and arg_360_1.time_ < var_363_9 + var_363_10 + arg_363_0 and not isNil(var_363_8) and arg_360_1.var_.actorSpriteComps1080 then
				for iter_363_6, iter_363_7 in pairs(arg_360_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_363_7 then
						if arg_360_1.isInRecall_ then
							iter_363_7.color = arg_360_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_363_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_360_1.var_.actorSpriteComps1080 = nil
			end

			local var_363_16 = arg_360_1.actors_["1037"].transform
			local var_363_17 = 0

			if var_363_17 < arg_360_1.time_ and arg_360_1.time_ <= var_363_17 + arg_363_0 then
				arg_360_1.var_.moveOldPos1037 = var_363_16.localPosition
				var_363_16.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("1037", 4)

				local var_363_18 = var_363_16.childCount

				for iter_363_8 = 0, var_363_18 - 1 do
					local var_363_19 = var_363_16:GetChild(iter_363_8)

					if var_363_19.name == "" or not string.find(var_363_19.name, "split") then
						var_363_19.gameObject:SetActive(true)
					else
						var_363_19.gameObject:SetActive(false)
					end
				end
			end

			local var_363_20 = 0.001

			if var_363_17 <= arg_360_1.time_ and arg_360_1.time_ < var_363_17 + var_363_20 then
				local var_363_21 = (arg_360_1.time_ - var_363_17) / var_363_20
				local var_363_22 = Vector3.New(390, -430, -55)

				var_363_16.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1037, var_363_22, var_363_21)
			end

			if arg_360_1.time_ >= var_363_17 + var_363_20 and arg_360_1.time_ < var_363_17 + var_363_20 + arg_363_0 then
				var_363_16.localPosition = Vector3.New(390, -430, -55)
			end

			local var_363_23 = 0
			local var_363_24 = 0.2

			if var_363_23 < arg_360_1.time_ and arg_360_1.time_ <= var_363_23 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_25 = arg_360_1:FormatText(StoryNameCfg[15].name)

				arg_360_1.leftNameTxt_.text = var_363_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_26 = arg_360_1:GetWordFromCfg(425081087)
				local var_363_27 = arg_360_1:FormatText(var_363_26.content)

				arg_360_1.text_.text = var_363_27

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_28 = 8
				local var_363_29 = utf8.len(var_363_27)
				local var_363_30 = var_363_28 <= 0 and var_363_24 or var_363_24 * (var_363_29 / var_363_28)

				if var_363_30 > 0 and var_363_24 < var_363_30 then
					arg_360_1.talkMaxDuration = var_363_30

					if var_363_30 + var_363_23 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_30 + var_363_23
					end
				end

				arg_360_1.text_.text = var_363_27
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081087", "story_v_out_425081.awb") ~= 0 then
					local var_363_31 = manager.audio:GetVoiceLength("story_v_out_425081", "425081087", "story_v_out_425081.awb") / 1000

					if var_363_31 + var_363_23 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_31 + var_363_23
					end

					if var_363_26.prefab_name ~= "" and arg_360_1.actors_[var_363_26.prefab_name] ~= nil then
						local var_363_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_26.prefab_name].transform, "story_v_out_425081", "425081087", "story_v_out_425081.awb")

						arg_360_1:RecordAudio("425081087", var_363_32)
						arg_360_1:RecordAudio("425081087", var_363_32)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_425081", "425081087", "story_v_out_425081.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_425081", "425081087", "story_v_out_425081.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_33 = math.max(var_363_24, arg_360_1.talkMaxDuration)

			if var_363_23 <= arg_360_1.time_ and arg_360_1.time_ < var_363_23 + var_363_33 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_23) / var_363_33

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_23 + var_363_33 and arg_360_1.time_ < var_363_23 + var_363_33 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
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

		arg_360_1:InitPlayNodeList()
	end,
	Play425081088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 425081088
		arg_364_1.duration_ = 4.07

		local var_364_0 = {
			zh = 3.733,
			ja = 4.066
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
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play425081089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1037"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.actorSpriteComps1037 == nil then
				arg_364_1.var_.actorSpriteComps1037 = var_367_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_2 = 0.2

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.actorSpriteComps1037 then
					for iter_367_0, iter_367_1 in pairs(arg_364_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_367_1 then
							if arg_364_1.isInRecall_ then
								local var_367_4 = Mathf.Lerp(iter_367_1.color.r, arg_364_1.hightColor2.r, var_367_3)
								local var_367_5 = Mathf.Lerp(iter_367_1.color.g, arg_364_1.hightColor2.g, var_367_3)
								local var_367_6 = Mathf.Lerp(iter_367_1.color.b, arg_364_1.hightColor2.b, var_367_3)

								iter_367_1.color = Color.New(var_367_4, var_367_5, var_367_6)
							else
								local var_367_7 = Mathf.Lerp(iter_367_1.color.r, 0.5, var_367_3)

								iter_367_1.color = Color.New(var_367_7, var_367_7, var_367_7)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.actorSpriteComps1037 then
				for iter_367_2, iter_367_3 in pairs(arg_364_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_367_3 then
						if arg_364_1.isInRecall_ then
							iter_367_3.color = arg_364_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_367_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_364_1.var_.actorSpriteComps1037 = nil
			end

			local var_367_8 = 0
			local var_367_9 = 0.25

			if var_367_8 < arg_364_1.time_ and arg_364_1.time_ <= var_367_8 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_10 = arg_364_1:FormatText(StoryNameCfg[56].name)

				arg_364_1.leftNameTxt_.text = var_367_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_11 = arg_364_1:GetWordFromCfg(425081088)
				local var_367_12 = arg_364_1:FormatText(var_367_11.content)

				arg_364_1.text_.text = var_367_12

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_13 = 10
				local var_367_14 = utf8.len(var_367_12)
				local var_367_15 = var_367_13 <= 0 and var_367_9 or var_367_9 * (var_367_14 / var_367_13)

				if var_367_15 > 0 and var_367_9 < var_367_15 then
					arg_364_1.talkMaxDuration = var_367_15

					if var_367_15 + var_367_8 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_15 + var_367_8
					end
				end

				arg_364_1.text_.text = var_367_12
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081088", "story_v_out_425081.awb") ~= 0 then
					local var_367_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081088", "story_v_out_425081.awb") / 1000

					if var_367_16 + var_367_8 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_16 + var_367_8
					end

					if var_367_11.prefab_name ~= "" and arg_364_1.actors_[var_367_11.prefab_name] ~= nil then
						local var_367_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_11.prefab_name].transform, "story_v_out_425081", "425081088", "story_v_out_425081.awb")

						arg_364_1:RecordAudio("425081088", var_367_17)
						arg_364_1:RecordAudio("425081088", var_367_17)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_425081", "425081088", "story_v_out_425081.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_425081", "425081088", "story_v_out_425081.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_18 = math.max(var_367_9, arg_364_1.talkMaxDuration)

			if var_367_8 <= arg_364_1.time_ and arg_364_1.time_ < var_367_8 + var_367_18 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_8) / var_367_18

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_8 + var_367_18 and arg_364_1.time_ < var_367_8 + var_367_18 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play425081089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 425081089
		arg_368_1.duration_ = 4.97

		local var_368_0 = {
			zh = 4.6,
			ja = 4.966
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play425081090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.4

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[56].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:GetWordFromCfg(425081089)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 16
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081089", "story_v_out_425081.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081089", "story_v_out_425081.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_425081", "425081089", "story_v_out_425081.awb")

						arg_368_1:RecordAudio("425081089", var_371_9)
						arg_368_1:RecordAudio("425081089", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_425081", "425081089", "story_v_out_425081.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_425081", "425081089", "story_v_out_425081.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play425081090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 425081090
		arg_372_1.duration_ = 8.17

		local var_372_0 = {
			zh = 5.466,
			ja = 8.166
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play425081091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1037"]
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.actorSpriteComps1037 == nil then
				arg_372_1.var_.actorSpriteComps1037 = var_375_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_2 = 0.2

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 and not isNil(var_375_0) then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2

				if arg_372_1.var_.actorSpriteComps1037 then
					for iter_375_0, iter_375_1 in pairs(arg_372_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_375_1 then
							if arg_372_1.isInRecall_ then
								local var_375_4 = Mathf.Lerp(iter_375_1.color.r, arg_372_1.hightColor1.r, var_375_3)
								local var_375_5 = Mathf.Lerp(iter_375_1.color.g, arg_372_1.hightColor1.g, var_375_3)
								local var_375_6 = Mathf.Lerp(iter_375_1.color.b, arg_372_1.hightColor1.b, var_375_3)

								iter_375_1.color = Color.New(var_375_4, var_375_5, var_375_6)
							else
								local var_375_7 = Mathf.Lerp(iter_375_1.color.r, 1, var_375_3)

								iter_375_1.color = Color.New(var_375_7, var_375_7, var_375_7)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 and not isNil(var_375_0) and arg_372_1.var_.actorSpriteComps1037 then
				for iter_375_2, iter_375_3 in pairs(arg_372_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_375_3 then
						if arg_372_1.isInRecall_ then
							iter_375_3.color = arg_372_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_375_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_372_1.var_.actorSpriteComps1037 = nil
			end

			local var_375_8 = arg_372_1.actors_["1037"].transform
			local var_375_9 = 0

			if var_375_9 < arg_372_1.time_ and arg_372_1.time_ <= var_375_9 + arg_375_0 then
				arg_372_1.var_.moveOldPos1037 = var_375_8.localPosition
				var_375_8.localScale = Vector3.New(1, 1, 1)

				arg_372_1:CheckSpriteTmpPos("1037", 4)

				local var_375_10 = var_375_8.childCount

				for iter_375_4 = 0, var_375_10 - 1 do
					local var_375_11 = var_375_8:GetChild(iter_375_4)

					if var_375_11.name == "split_4" then
						var_375_11:SetAsLastSibling()
						var_375_11.gameObject:SetActive(true)

						arg_372_1.var_.actorSpriteSplit1037 = var_375_11.gameObject:GetComponent(typeof(Image))

						arg_372_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_375_12 = 0.2

			if var_375_9 <= arg_372_1.time_ and arg_372_1.time_ < var_375_9 + var_375_12 then
				local var_375_13 = (arg_372_1.time_ - var_375_9) / var_375_12
				local var_375_14 = Vector3.New(390, -430, -55)

				var_375_8.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1037, var_375_14, var_375_13)

				if arg_372_1.var_.actorSpriteSplit1037 ~= nil then
					arg_372_1.var_.actorSpriteSplit1037:SetAlpha(var_375_13)
				end
			end

			if arg_372_1.time_ >= var_375_9 + var_375_12 and arg_372_1.time_ < var_375_9 + var_375_12 + arg_375_0 then
				var_375_8.localPosition = Vector3.New(390, -430, -55)

				if arg_372_1.var_.actorSpriteSplit1037 ~= nil then
					arg_372_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_375_15 = 0
			local var_375_16 = 0.775

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_17 = arg_372_1:FormatText(StoryNameCfg[15].name)

				arg_372_1.leftNameTxt_.text = var_375_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_18 = arg_372_1:GetWordFromCfg(425081090)
				local var_375_19 = arg_372_1:FormatText(var_375_18.content)

				arg_372_1.text_.text = var_375_19

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_20 = 31
				local var_375_21 = utf8.len(var_375_19)
				local var_375_22 = var_375_20 <= 0 and var_375_16 or var_375_16 * (var_375_21 / var_375_20)

				if var_375_22 > 0 and var_375_16 < var_375_22 then
					arg_372_1.talkMaxDuration = var_375_22

					if var_375_22 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_22 + var_375_15
					end
				end

				arg_372_1.text_.text = var_375_19
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081090", "story_v_out_425081.awb") ~= 0 then
					local var_375_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081090", "story_v_out_425081.awb") / 1000

					if var_375_23 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_23 + var_375_15
					end

					if var_375_18.prefab_name ~= "" and arg_372_1.actors_[var_375_18.prefab_name] ~= nil then
						local var_375_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_18.prefab_name].transform, "story_v_out_425081", "425081090", "story_v_out_425081.awb")

						arg_372_1:RecordAudio("425081090", var_375_24)
						arg_372_1:RecordAudio("425081090", var_375_24)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_425081", "425081090", "story_v_out_425081.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_425081", "425081090", "story_v_out_425081.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_25 = math.max(var_375_16, arg_372_1.talkMaxDuration)

			if var_375_15 <= arg_372_1.time_ and arg_372_1.time_ < var_375_15 + var_375_25 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_15) / var_375_25

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_15 + var_375_25 and arg_372_1.time_ < var_375_15 + var_375_25 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
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

		arg_372_1:InitPlayNodeList()
	end,
	Play425081091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 425081091
		arg_376_1.duration_ = 9.83

		local var_376_0 = {
			zh = 6.433,
			ja = 9.833
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play425081092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1037"].transform
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.var_.moveOldPos1037 = var_379_0.localPosition
				var_379_0.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1037", 4)

				local var_379_2 = var_379_0.childCount

				for iter_379_0 = 0, var_379_2 - 1 do
					local var_379_3 = var_379_0:GetChild(iter_379_0)

					if var_379_3.name == "" then
						var_379_3:SetAsLastSibling()
						var_379_3.gameObject:SetActive(true)

						arg_376_1.var_.actorSpriteSplit1037 = var_379_3.gameObject:GetComponent(typeof(Image))

						arg_376_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_379_4 = 0.333333333333333

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_4 then
				local var_379_5 = (arg_376_1.time_ - var_379_1) / var_379_4
				local var_379_6 = Vector3.New(390, -430, -55)

				var_379_0.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1037, var_379_6, var_379_5)

				if arg_376_1.var_.actorSpriteSplit1037 ~= nil then
					arg_376_1.var_.actorSpriteSplit1037:SetAlpha(var_379_5)
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_4 and arg_376_1.time_ < var_379_1 + var_379_4 + arg_379_0 then
				var_379_0.localPosition = Vector3.New(390, -430, -55)

				if arg_376_1.var_.actorSpriteSplit1037 ~= nil then
					arg_376_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_379_7 = 0
			local var_379_8 = 0.775

			if var_379_7 < arg_376_1.time_ and arg_376_1.time_ <= var_379_7 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_9 = arg_376_1:FormatText(StoryNameCfg[15].name)

				arg_376_1.leftNameTxt_.text = var_379_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_10 = arg_376_1:GetWordFromCfg(425081091)
				local var_379_11 = arg_376_1:FormatText(var_379_10.content)

				arg_376_1.text_.text = var_379_11

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_12 = 31
				local var_379_13 = utf8.len(var_379_11)
				local var_379_14 = var_379_12 <= 0 and var_379_8 or var_379_8 * (var_379_13 / var_379_12)

				if var_379_14 > 0 and var_379_8 < var_379_14 then
					arg_376_1.talkMaxDuration = var_379_14

					if var_379_14 + var_379_7 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_14 + var_379_7
					end
				end

				arg_376_1.text_.text = var_379_11
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081091", "story_v_out_425081.awb") ~= 0 then
					local var_379_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081091", "story_v_out_425081.awb") / 1000

					if var_379_15 + var_379_7 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_15 + var_379_7
					end

					if var_379_10.prefab_name ~= "" and arg_376_1.actors_[var_379_10.prefab_name] ~= nil then
						local var_379_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_10.prefab_name].transform, "story_v_out_425081", "425081091", "story_v_out_425081.awb")

						arg_376_1:RecordAudio("425081091", var_379_16)
						arg_376_1:RecordAudio("425081091", var_379_16)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_425081", "425081091", "story_v_out_425081.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_425081", "425081091", "story_v_out_425081.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_17 = math.max(var_379_8, arg_376_1.talkMaxDuration)

			if var_379_7 <= arg_376_1.time_ and arg_376_1.time_ < var_379_7 + var_379_17 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_7) / var_379_17

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_7 + var_379_17 and arg_376_1.time_ < var_379_7 + var_379_17 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play425081092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 425081092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play425081093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = arg_380_1.actors_["1080"].transform
			local var_383_1 = 0

			if var_383_1 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.var_.moveOldPos1080 = var_383_0.localPosition
				var_383_0.localScale = Vector3.New(1, 1, 1)

				arg_380_1:CheckSpriteTmpPos("1080", 7)

				local var_383_2 = var_383_0.childCount

				for iter_383_0 = 0, var_383_2 - 1 do
					local var_383_3 = var_383_0:GetChild(iter_383_0)

					if var_383_3.name == "" or not string.find(var_383_3.name, "split") then
						var_383_3.gameObject:SetActive(true)
					else
						var_383_3.gameObject:SetActive(false)
					end
				end
			end

			local var_383_4 = 0.001

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_4 then
				local var_383_5 = (arg_380_1.time_ - var_383_1) / var_383_4
				local var_383_6 = Vector3.New(0, -2000, 0)

				var_383_0.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1080, var_383_6, var_383_5)
			end

			if arg_380_1.time_ >= var_383_1 + var_383_4 and arg_380_1.time_ < var_383_1 + var_383_4 + arg_383_0 then
				var_383_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_383_7 = arg_380_1.actors_["1037"].transform
			local var_383_8 = 0

			if var_383_8 < arg_380_1.time_ and arg_380_1.time_ <= var_383_8 + arg_383_0 then
				arg_380_1.var_.moveOldPos1037 = var_383_7.localPosition
				var_383_7.localScale = Vector3.New(1, 1, 1)

				arg_380_1:CheckSpriteTmpPos("1037", 7)

				local var_383_9 = var_383_7.childCount

				for iter_383_1 = 0, var_383_9 - 1 do
					local var_383_10 = var_383_7:GetChild(iter_383_1)

					if var_383_10.name == "" or not string.find(var_383_10.name, "split") then
						var_383_10.gameObject:SetActive(true)
					else
						var_383_10.gameObject:SetActive(false)
					end
				end
			end

			local var_383_11 = 0.001

			if var_383_8 <= arg_380_1.time_ and arg_380_1.time_ < var_383_8 + var_383_11 then
				local var_383_12 = (arg_380_1.time_ - var_383_8) / var_383_11
				local var_383_13 = Vector3.New(1500, -2000, 0)

				var_383_7.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1037, var_383_13, var_383_12)
			end

			if arg_380_1.time_ >= var_383_8 + var_383_11 and arg_380_1.time_ < var_383_8 + var_383_11 + arg_383_0 then
				var_383_7.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_383_14 = 0
			local var_383_15 = 0.55

			if var_383_14 < arg_380_1.time_ and arg_380_1.time_ <= var_383_14 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_16 = arg_380_1:GetWordFromCfg(425081092)
				local var_383_17 = arg_380_1:FormatText(var_383_16.content)

				arg_380_1.text_.text = var_383_17

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_18 = 22
				local var_383_19 = utf8.len(var_383_17)
				local var_383_20 = var_383_18 <= 0 and var_383_15 or var_383_15 * (var_383_19 / var_383_18)

				if var_383_20 > 0 and var_383_15 < var_383_20 then
					arg_380_1.talkMaxDuration = var_383_20

					if var_383_20 + var_383_14 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_20 + var_383_14
					end
				end

				arg_380_1.text_.text = var_383_17
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_21 = math.max(var_383_15, arg_380_1.talkMaxDuration)

			if var_383_14 <= arg_380_1.time_ and arg_380_1.time_ < var_383_14 + var_383_21 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_14) / var_383_21

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_14 + var_383_21 and arg_380_1.time_ < var_383_14 + var_383_21 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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

		arg_380_1:InitPlayNodeList()
	end,
	Play425081093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 425081093
		arg_384_1.duration_ = 8.4

		local var_384_0 = {
			zh = 6.566,
			ja = 8.4
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play425081094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1037"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.actorSpriteComps1037 == nil then
				arg_384_1.var_.actorSpriteComps1037 = var_387_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_2 = 0.2

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.actorSpriteComps1037 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								local var_387_4 = Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor1.r, var_387_3)
								local var_387_5 = Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor1.g, var_387_3)
								local var_387_6 = Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor1.b, var_387_3)

								iter_387_1.color = Color.New(var_387_4, var_387_5, var_387_6)
							else
								local var_387_7 = Mathf.Lerp(iter_387_1.color.r, 1, var_387_3)

								iter_387_1.color = Color.New(var_387_7, var_387_7, var_387_7)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.actorSpriteComps1037 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_387_3 then
						if arg_384_1.isInRecall_ then
							iter_387_3.color = arg_384_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_387_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_384_1.var_.actorSpriteComps1037 = nil
			end

			local var_387_8 = arg_384_1.actors_["1037"].transform
			local var_387_9 = 0

			if var_387_9 < arg_384_1.time_ and arg_384_1.time_ <= var_387_9 + arg_387_0 then
				arg_384_1.var_.moveOldPos1037 = var_387_8.localPosition
				var_387_8.localScale = Vector3.New(1, 1, 1)

				arg_384_1:CheckSpriteTmpPos("1037", 3)

				local var_387_10 = var_387_8.childCount

				for iter_387_4 = 0, var_387_10 - 1 do
					local var_387_11 = var_387_8:GetChild(iter_387_4)

					if var_387_11.name == "" or not string.find(var_387_11.name, "split") then
						var_387_11.gameObject:SetActive(true)
					else
						var_387_11.gameObject:SetActive(false)
					end
				end
			end

			local var_387_12 = 0.001

			if var_387_9 <= arg_384_1.time_ and arg_384_1.time_ < var_387_9 + var_387_12 then
				local var_387_13 = (arg_384_1.time_ - var_387_9) / var_387_12
				local var_387_14 = Vector3.New(0, -430, -55)

				var_387_8.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1037, var_387_14, var_387_13)
			end

			if arg_384_1.time_ >= var_387_9 + var_387_12 and arg_384_1.time_ < var_387_9 + var_387_12 + arg_387_0 then
				var_387_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_387_15 = 0
			local var_387_16 = 0.825

			if var_387_15 < arg_384_1.time_ and arg_384_1.time_ <= var_387_15 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_17 = arg_384_1:FormatText(StoryNameCfg[15].name)

				arg_384_1.leftNameTxt_.text = var_387_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_18 = arg_384_1:GetWordFromCfg(425081093)
				local var_387_19 = arg_384_1:FormatText(var_387_18.content)

				arg_384_1.text_.text = var_387_19

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_20 = 33
				local var_387_21 = utf8.len(var_387_19)
				local var_387_22 = var_387_20 <= 0 and var_387_16 or var_387_16 * (var_387_21 / var_387_20)

				if var_387_22 > 0 and var_387_16 < var_387_22 then
					arg_384_1.talkMaxDuration = var_387_22

					if var_387_22 + var_387_15 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_22 + var_387_15
					end
				end

				arg_384_1.text_.text = var_387_19
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081093", "story_v_out_425081.awb") ~= 0 then
					local var_387_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081093", "story_v_out_425081.awb") / 1000

					if var_387_23 + var_387_15 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_23 + var_387_15
					end

					if var_387_18.prefab_name ~= "" and arg_384_1.actors_[var_387_18.prefab_name] ~= nil then
						local var_387_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_18.prefab_name].transform, "story_v_out_425081", "425081093", "story_v_out_425081.awb")

						arg_384_1:RecordAudio("425081093", var_387_24)
						arg_384_1:RecordAudio("425081093", var_387_24)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_425081", "425081093", "story_v_out_425081.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_425081", "425081093", "story_v_out_425081.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_25 = math.max(var_387_16, arg_384_1.talkMaxDuration)

			if var_387_15 <= arg_384_1.time_ and arg_384_1.time_ < var_387_15 + var_387_25 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_15) / var_387_25

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_15 + var_387_25 and arg_384_1.time_ < var_387_15 + var_387_25 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
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

		arg_384_1:InitPlayNodeList()
	end,
	Play425081094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 425081094
		arg_388_1.duration_ = 2.7

		local var_388_0 = {
			zh = 1.433,
			ja = 2.7
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play425081095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1037"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps1037 == nil then
				arg_388_1.var_.actorSpriteComps1037 = var_391_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_2 = 0.2

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.actorSpriteComps1037 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								local var_391_4 = Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor2.r, var_391_3)
								local var_391_5 = Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor2.g, var_391_3)
								local var_391_6 = Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor2.b, var_391_3)

								iter_391_1.color = Color.New(var_391_4, var_391_5, var_391_6)
							else
								local var_391_7 = Mathf.Lerp(iter_391_1.color.r, 0.5, var_391_3)

								iter_391_1.color = Color.New(var_391_7, var_391_7, var_391_7)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.actorSpriteComps1037 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_391_3 then
						if arg_388_1.isInRecall_ then
							iter_391_3.color = arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_391_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_388_1.var_.actorSpriteComps1037 = nil
			end

			local var_391_8 = 0
			local var_391_9 = 0.1

			if var_391_8 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_10 = arg_388_1:FormatText(StoryNameCfg[56].name)

				arg_388_1.leftNameTxt_.text = var_391_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_11 = arg_388_1:GetWordFromCfg(425081094)
				local var_391_12 = arg_388_1:FormatText(var_391_11.content)

				arg_388_1.text_.text = var_391_12

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_13 = 4
				local var_391_14 = utf8.len(var_391_12)
				local var_391_15 = var_391_13 <= 0 and var_391_9 or var_391_9 * (var_391_14 / var_391_13)

				if var_391_15 > 0 and var_391_9 < var_391_15 then
					arg_388_1.talkMaxDuration = var_391_15

					if var_391_15 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_15 + var_391_8
					end
				end

				arg_388_1.text_.text = var_391_12
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081094", "story_v_out_425081.awb") ~= 0 then
					local var_391_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081094", "story_v_out_425081.awb") / 1000

					if var_391_16 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_16 + var_391_8
					end

					if var_391_11.prefab_name ~= "" and arg_388_1.actors_[var_391_11.prefab_name] ~= nil then
						local var_391_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_11.prefab_name].transform, "story_v_out_425081", "425081094", "story_v_out_425081.awb")

						arg_388_1:RecordAudio("425081094", var_391_17)
						arg_388_1:RecordAudio("425081094", var_391_17)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_425081", "425081094", "story_v_out_425081.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_425081", "425081094", "story_v_out_425081.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_18 = math.max(var_391_9, arg_388_1.talkMaxDuration)

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_18 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_8) / var_391_18

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_8 + var_391_18 and arg_388_1.time_ < var_391_8 + var_391_18 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play425081095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 425081095
		arg_392_1.duration_ = 3.27

		local var_392_0 = {
			zh = 2.866,
			ja = 3.266
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play425081096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1080"]
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.actorSpriteComps1080 == nil then
				arg_392_1.var_.actorSpriteComps1080 = var_395_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_2 = 0.2

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 and not isNil(var_395_0) then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2

				if arg_392_1.var_.actorSpriteComps1080 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_395_1 then
							if arg_392_1.isInRecall_ then
								local var_395_4 = Mathf.Lerp(iter_395_1.color.r, arg_392_1.hightColor1.r, var_395_3)
								local var_395_5 = Mathf.Lerp(iter_395_1.color.g, arg_392_1.hightColor1.g, var_395_3)
								local var_395_6 = Mathf.Lerp(iter_395_1.color.b, arg_392_1.hightColor1.b, var_395_3)

								iter_395_1.color = Color.New(var_395_4, var_395_5, var_395_6)
							else
								local var_395_7 = Mathf.Lerp(iter_395_1.color.r, 1, var_395_3)

								iter_395_1.color = Color.New(var_395_7, var_395_7, var_395_7)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.actorSpriteComps1080 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_395_3 then
						if arg_392_1.isInRecall_ then
							iter_395_3.color = arg_392_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_395_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_392_1.var_.actorSpriteComps1080 = nil
			end

			local var_395_8 = arg_392_1.actors_["1027"]
			local var_395_9 = 0

			if var_395_9 < arg_392_1.time_ and arg_392_1.time_ <= var_395_9 + arg_395_0 and not isNil(var_395_8) and arg_392_1.var_.actorSpriteComps1027 == nil then
				arg_392_1.var_.actorSpriteComps1027 = var_395_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_10 = 0.2

			if var_395_9 <= arg_392_1.time_ and arg_392_1.time_ < var_395_9 + var_395_10 and not isNil(var_395_8) then
				local var_395_11 = (arg_392_1.time_ - var_395_9) / var_395_10

				if arg_392_1.var_.actorSpriteComps1027 then
					for iter_395_4, iter_395_5 in pairs(arg_392_1.var_.actorSpriteComps1027:ToTable()) do
						if iter_395_5 then
							if arg_392_1.isInRecall_ then
								local var_395_12 = Mathf.Lerp(iter_395_5.color.r, arg_392_1.hightColor2.r, var_395_11)
								local var_395_13 = Mathf.Lerp(iter_395_5.color.g, arg_392_1.hightColor2.g, var_395_11)
								local var_395_14 = Mathf.Lerp(iter_395_5.color.b, arg_392_1.hightColor2.b, var_395_11)

								iter_395_5.color = Color.New(var_395_12, var_395_13, var_395_14)
							else
								local var_395_15 = Mathf.Lerp(iter_395_5.color.r, 0.5, var_395_11)

								iter_395_5.color = Color.New(var_395_15, var_395_15, var_395_15)
							end
						end
					end
				end
			end

			if arg_392_1.time_ >= var_395_9 + var_395_10 and arg_392_1.time_ < var_395_9 + var_395_10 + arg_395_0 and not isNil(var_395_8) and arg_392_1.var_.actorSpriteComps1027 then
				for iter_395_6, iter_395_7 in pairs(arg_392_1.var_.actorSpriteComps1027:ToTable()) do
					if iter_395_7 then
						if arg_392_1.isInRecall_ then
							iter_395_7.color = arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_395_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_392_1.var_.actorSpriteComps1027 = nil
			end

			local var_395_16 = arg_392_1.actors_["1080"].transform
			local var_395_17 = 0

			if var_395_17 < arg_392_1.time_ and arg_392_1.time_ <= var_395_17 + arg_395_0 then
				arg_392_1.var_.moveOldPos1080 = var_395_16.localPosition
				var_395_16.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("1080", 4)

				local var_395_18 = var_395_16.childCount

				for iter_395_8 = 0, var_395_18 - 1 do
					local var_395_19 = var_395_16:GetChild(iter_395_8)

					if var_395_19.name == "" or not string.find(var_395_19.name, "split") then
						var_395_19.gameObject:SetActive(true)
					else
						var_395_19.gameObject:SetActive(false)
					end
				end
			end

			local var_395_20 = 0.001

			if var_395_17 <= arg_392_1.time_ and arg_392_1.time_ < var_395_17 + var_395_20 then
				local var_395_21 = (arg_392_1.time_ - var_395_17) / var_395_20
				local var_395_22 = Vector3.New(390, -378, -170)

				var_395_16.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1080, var_395_22, var_395_21)
			end

			if arg_392_1.time_ >= var_395_17 + var_395_20 and arg_392_1.time_ < var_395_17 + var_395_20 + arg_395_0 then
				var_395_16.localPosition = Vector3.New(390, -378, -170)
			end

			local var_395_23 = arg_392_1.actors_["1037"].transform
			local var_395_24 = 0

			if var_395_24 < arg_392_1.time_ and arg_392_1.time_ <= var_395_24 + arg_395_0 then
				arg_392_1.var_.moveOldPos1037 = var_395_23.localPosition
				var_395_23.localScale = Vector3.New(1, 1, 1)

				arg_392_1:CheckSpriteTmpPos("1037", 2)

				local var_395_25 = var_395_23.childCount

				for iter_395_9 = 0, var_395_25 - 1 do
					local var_395_26 = var_395_23:GetChild(iter_395_9)

					if var_395_26.name == "split_1" or not string.find(var_395_26.name, "split") then
						var_395_26.gameObject:SetActive(true)
					else
						var_395_26.gameObject:SetActive(false)
					end
				end
			end

			local var_395_27 = 0.001

			if var_395_24 <= arg_392_1.time_ and arg_392_1.time_ < var_395_24 + var_395_27 then
				local var_395_28 = (arg_392_1.time_ - var_395_24) / var_395_27
				local var_395_29 = Vector3.New(-390, -430, -55)

				var_395_23.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1037, var_395_29, var_395_28)
			end

			if arg_392_1.time_ >= var_395_24 + var_395_27 and arg_392_1.time_ < var_395_24 + var_395_27 + arg_395_0 then
				var_395_23.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_395_30 = 0
			local var_395_31 = 0.325

			if var_395_30 < arg_392_1.time_ and arg_392_1.time_ <= var_395_30 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_32 = arg_392_1:FormatText(StoryNameCfg[55].name)

				arg_392_1.leftNameTxt_.text = var_395_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_33 = arg_392_1:GetWordFromCfg(425081095)
				local var_395_34 = arg_392_1:FormatText(var_395_33.content)

				arg_392_1.text_.text = var_395_34

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_35 = 13
				local var_395_36 = utf8.len(var_395_34)
				local var_395_37 = var_395_35 <= 0 and var_395_31 or var_395_31 * (var_395_36 / var_395_35)

				if var_395_37 > 0 and var_395_31 < var_395_37 then
					arg_392_1.talkMaxDuration = var_395_37

					if var_395_37 + var_395_30 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_37 + var_395_30
					end
				end

				arg_392_1.text_.text = var_395_34
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081095", "story_v_out_425081.awb") ~= 0 then
					local var_395_38 = manager.audio:GetVoiceLength("story_v_out_425081", "425081095", "story_v_out_425081.awb") / 1000

					if var_395_38 + var_395_30 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_38 + var_395_30
					end

					if var_395_33.prefab_name ~= "" and arg_392_1.actors_[var_395_33.prefab_name] ~= nil then
						local var_395_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_33.prefab_name].transform, "story_v_out_425081", "425081095", "story_v_out_425081.awb")

						arg_392_1:RecordAudio("425081095", var_395_39)
						arg_392_1:RecordAudio("425081095", var_395_39)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_425081", "425081095", "story_v_out_425081.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_425081", "425081095", "story_v_out_425081.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_40 = math.max(var_395_31, arg_392_1.talkMaxDuration)

			if var_395_30 <= arg_392_1.time_ and arg_392_1.time_ < var_395_30 + var_395_40 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_30) / var_395_40

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_30 + var_395_40 and arg_392_1.time_ < var_395_30 + var_395_40 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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

		arg_392_1:InitPlayNodeList()
	end,
	Play425081096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 425081096
		arg_396_1.duration_ = 8.8

		local var_396_0 = {
			zh = 8.166,
			ja = 8.8
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play425081097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1037"]
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.actorSpriteComps1037 == nil then
				arg_396_1.var_.actorSpriteComps1037 = var_399_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_2 = 0.2

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 and not isNil(var_399_0) then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2

				if arg_396_1.var_.actorSpriteComps1037 then
					for iter_399_0, iter_399_1 in pairs(arg_396_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_399_1 then
							if arg_396_1.isInRecall_ then
								local var_399_4 = Mathf.Lerp(iter_399_1.color.r, arg_396_1.hightColor1.r, var_399_3)
								local var_399_5 = Mathf.Lerp(iter_399_1.color.g, arg_396_1.hightColor1.g, var_399_3)
								local var_399_6 = Mathf.Lerp(iter_399_1.color.b, arg_396_1.hightColor1.b, var_399_3)

								iter_399_1.color = Color.New(var_399_4, var_399_5, var_399_6)
							else
								local var_399_7 = Mathf.Lerp(iter_399_1.color.r, 1, var_399_3)

								iter_399_1.color = Color.New(var_399_7, var_399_7, var_399_7)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 and not isNil(var_399_0) and arg_396_1.var_.actorSpriteComps1037 then
				for iter_399_2, iter_399_3 in pairs(arg_396_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_399_3 then
						if arg_396_1.isInRecall_ then
							iter_399_3.color = arg_396_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_399_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_396_1.var_.actorSpriteComps1037 = nil
			end

			local var_399_8 = arg_396_1.actors_["1080"]
			local var_399_9 = 0

			if var_399_9 < arg_396_1.time_ and arg_396_1.time_ <= var_399_9 + arg_399_0 and not isNil(var_399_8) and arg_396_1.var_.actorSpriteComps1080 == nil then
				arg_396_1.var_.actorSpriteComps1080 = var_399_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_10 = 0.2

			if var_399_9 <= arg_396_1.time_ and arg_396_1.time_ < var_399_9 + var_399_10 and not isNil(var_399_8) then
				local var_399_11 = (arg_396_1.time_ - var_399_9) / var_399_10

				if arg_396_1.var_.actorSpriteComps1080 then
					for iter_399_4, iter_399_5 in pairs(arg_396_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_399_5 then
							if arg_396_1.isInRecall_ then
								local var_399_12 = Mathf.Lerp(iter_399_5.color.r, arg_396_1.hightColor2.r, var_399_11)
								local var_399_13 = Mathf.Lerp(iter_399_5.color.g, arg_396_1.hightColor2.g, var_399_11)
								local var_399_14 = Mathf.Lerp(iter_399_5.color.b, arg_396_1.hightColor2.b, var_399_11)

								iter_399_5.color = Color.New(var_399_12, var_399_13, var_399_14)
							else
								local var_399_15 = Mathf.Lerp(iter_399_5.color.r, 0.5, var_399_11)

								iter_399_5.color = Color.New(var_399_15, var_399_15, var_399_15)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= var_399_9 + var_399_10 and arg_396_1.time_ < var_399_9 + var_399_10 + arg_399_0 and not isNil(var_399_8) and arg_396_1.var_.actorSpriteComps1080 then
				for iter_399_6, iter_399_7 in pairs(arg_396_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_399_7 then
						if arg_396_1.isInRecall_ then
							iter_399_7.color = arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_399_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_396_1.var_.actorSpriteComps1080 = nil
			end

			local var_399_16 = 0
			local var_399_17 = 0.95

			if var_399_16 < arg_396_1.time_ and arg_396_1.time_ <= var_399_16 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_18 = arg_396_1:FormatText(StoryNameCfg[15].name)

				arg_396_1.leftNameTxt_.text = var_399_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_19 = arg_396_1:GetWordFromCfg(425081096)
				local var_399_20 = arg_396_1:FormatText(var_399_19.content)

				arg_396_1.text_.text = var_399_20

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_21 = 38
				local var_399_22 = utf8.len(var_399_20)
				local var_399_23 = var_399_21 <= 0 and var_399_17 or var_399_17 * (var_399_22 / var_399_21)

				if var_399_23 > 0 and var_399_17 < var_399_23 then
					arg_396_1.talkMaxDuration = var_399_23

					if var_399_23 + var_399_16 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_23 + var_399_16
					end
				end

				arg_396_1.text_.text = var_399_20
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081096", "story_v_out_425081.awb") ~= 0 then
					local var_399_24 = manager.audio:GetVoiceLength("story_v_out_425081", "425081096", "story_v_out_425081.awb") / 1000

					if var_399_24 + var_399_16 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_24 + var_399_16
					end

					if var_399_19.prefab_name ~= "" and arg_396_1.actors_[var_399_19.prefab_name] ~= nil then
						local var_399_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_19.prefab_name].transform, "story_v_out_425081", "425081096", "story_v_out_425081.awb")

						arg_396_1:RecordAudio("425081096", var_399_25)
						arg_396_1:RecordAudio("425081096", var_399_25)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_425081", "425081096", "story_v_out_425081.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_425081", "425081096", "story_v_out_425081.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_26 = math.max(var_399_17, arg_396_1.talkMaxDuration)

			if var_399_16 <= arg_396_1.time_ and arg_396_1.time_ < var_399_16 + var_399_26 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_16) / var_399_26

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_16 + var_399_26 and arg_396_1.time_ < var_399_16 + var_399_26 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play425081097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 425081097
		arg_400_1.duration_ = 9.17

		local var_400_0 = {
			zh = 6.633,
			ja = 9.166
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play425081098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1037"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos1037 = var_403_0.localPosition
				var_403_0.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("1037", 2)

				local var_403_2 = var_403_0.childCount

				for iter_403_0 = 0, var_403_2 - 1 do
					local var_403_3 = var_403_0:GetChild(iter_403_0)

					if var_403_3.name == "split_4" then
						var_403_3:SetAsLastSibling()
						var_403_3.gameObject:SetActive(true)

						arg_400_1.var_.actorSpriteSplit1037 = var_403_3.gameObject:GetComponent(typeof(Image))

						arg_400_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_403_4 = 0.333333333333333

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_4 then
				local var_403_5 = (arg_400_1.time_ - var_403_1) / var_403_4
				local var_403_6 = Vector3.New(-390, -430, -55)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1037, var_403_6, var_403_5)

				if arg_400_1.var_.actorSpriteSplit1037 ~= nil then
					arg_400_1.var_.actorSpriteSplit1037:SetAlpha(var_403_5)
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_4 and arg_400_1.time_ < var_403_1 + var_403_4 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(-390, -430, -55)

				if arg_400_1.var_.actorSpriteSplit1037 ~= nil then
					arg_400_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_403_7 = 0
			local var_403_8 = 0.775

			if var_403_7 < arg_400_1.time_ and arg_400_1.time_ <= var_403_7 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_9 = arg_400_1:FormatText(StoryNameCfg[15].name)

				arg_400_1.leftNameTxt_.text = var_403_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_10 = arg_400_1:GetWordFromCfg(425081097)
				local var_403_11 = arg_400_1:FormatText(var_403_10.content)

				arg_400_1.text_.text = var_403_11

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_12 = 31
				local var_403_13 = utf8.len(var_403_11)
				local var_403_14 = var_403_12 <= 0 and var_403_8 or var_403_8 * (var_403_13 / var_403_12)

				if var_403_14 > 0 and var_403_8 < var_403_14 then
					arg_400_1.talkMaxDuration = var_403_14

					if var_403_14 + var_403_7 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_14 + var_403_7
					end
				end

				arg_400_1.text_.text = var_403_11
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081097", "story_v_out_425081.awb") ~= 0 then
					local var_403_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081097", "story_v_out_425081.awb") / 1000

					if var_403_15 + var_403_7 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_15 + var_403_7
					end

					if var_403_10.prefab_name ~= "" and arg_400_1.actors_[var_403_10.prefab_name] ~= nil then
						local var_403_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_10.prefab_name].transform, "story_v_out_425081", "425081097", "story_v_out_425081.awb")

						arg_400_1:RecordAudio("425081097", var_403_16)
						arg_400_1:RecordAudio("425081097", var_403_16)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_425081", "425081097", "story_v_out_425081.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_425081", "425081097", "story_v_out_425081.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_17 = math.max(var_403_8, arg_400_1.talkMaxDuration)

			if var_403_7 <= arg_400_1.time_ and arg_400_1.time_ < var_403_7 + var_403_17 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_7) / var_403_17

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_7 + var_403_17 and arg_400_1.time_ < var_403_7 + var_403_17 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play425081098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 425081098
		arg_404_1.duration_ = 1.87

		local var_404_0 = {
			zh = 1.533,
			ja = 1.866
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play425081099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1080"]
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.actorSpriteComps1080 == nil then
				arg_404_1.var_.actorSpriteComps1080 = var_407_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_2 = 0.2

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 and not isNil(var_407_0) then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2

				if arg_404_1.var_.actorSpriteComps1080 then
					for iter_407_0, iter_407_1 in pairs(arg_404_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_407_1 then
							if arg_404_1.isInRecall_ then
								local var_407_4 = Mathf.Lerp(iter_407_1.color.r, arg_404_1.hightColor2.r, var_407_3)
								local var_407_5 = Mathf.Lerp(iter_407_1.color.g, arg_404_1.hightColor2.g, var_407_3)
								local var_407_6 = Mathf.Lerp(iter_407_1.color.b, arg_404_1.hightColor2.b, var_407_3)

								iter_407_1.color = Color.New(var_407_4, var_407_5, var_407_6)
							else
								local var_407_7 = Mathf.Lerp(iter_407_1.color.r, 0.5, var_407_3)

								iter_407_1.color = Color.New(var_407_7, var_407_7, var_407_7)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 and not isNil(var_407_0) and arg_404_1.var_.actorSpriteComps1080 then
				for iter_407_2, iter_407_3 in pairs(arg_404_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_407_3 then
						if arg_404_1.isInRecall_ then
							iter_407_3.color = arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_407_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_404_1.var_.actorSpriteComps1080 = nil
			end

			local var_407_8 = arg_404_1.actors_["1037"]
			local var_407_9 = 0

			if var_407_9 < arg_404_1.time_ and arg_404_1.time_ <= var_407_9 + arg_407_0 and not isNil(var_407_8) and arg_404_1.var_.actorSpriteComps1037 == nil then
				arg_404_1.var_.actorSpriteComps1037 = var_407_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_10 = 0.2

			if var_407_9 <= arg_404_1.time_ and arg_404_1.time_ < var_407_9 + var_407_10 and not isNil(var_407_8) then
				local var_407_11 = (arg_404_1.time_ - var_407_9) / var_407_10

				if arg_404_1.var_.actorSpriteComps1037 then
					for iter_407_4, iter_407_5 in pairs(arg_404_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_407_5 then
							if arg_404_1.isInRecall_ then
								local var_407_12 = Mathf.Lerp(iter_407_5.color.r, arg_404_1.hightColor2.r, var_407_11)
								local var_407_13 = Mathf.Lerp(iter_407_5.color.g, arg_404_1.hightColor2.g, var_407_11)
								local var_407_14 = Mathf.Lerp(iter_407_5.color.b, arg_404_1.hightColor2.b, var_407_11)

								iter_407_5.color = Color.New(var_407_12, var_407_13, var_407_14)
							else
								local var_407_15 = Mathf.Lerp(iter_407_5.color.r, 0.5, var_407_11)

								iter_407_5.color = Color.New(var_407_15, var_407_15, var_407_15)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= var_407_9 + var_407_10 and arg_404_1.time_ < var_407_9 + var_407_10 + arg_407_0 and not isNil(var_407_8) and arg_404_1.var_.actorSpriteComps1037 then
				for iter_407_6, iter_407_7 in pairs(arg_404_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_407_7 then
						if arg_404_1.isInRecall_ then
							iter_407_7.color = arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_407_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_404_1.var_.actorSpriteComps1037 = nil
			end

			local var_407_16 = 0
			local var_407_17 = 0.1

			if var_407_16 < arg_404_1.time_ and arg_404_1.time_ <= var_407_16 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_18 = arg_404_1:FormatText(StoryNameCfg[56].name)

				arg_404_1.leftNameTxt_.text = var_407_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_19 = arg_404_1:GetWordFromCfg(425081098)
				local var_407_20 = arg_404_1:FormatText(var_407_19.content)

				arg_404_1.text_.text = var_407_20

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_21 = 4
				local var_407_22 = utf8.len(var_407_20)
				local var_407_23 = var_407_21 <= 0 and var_407_17 or var_407_17 * (var_407_22 / var_407_21)

				if var_407_23 > 0 and var_407_17 < var_407_23 then
					arg_404_1.talkMaxDuration = var_407_23

					if var_407_23 + var_407_16 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_23 + var_407_16
					end
				end

				arg_404_1.text_.text = var_407_20
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081098", "story_v_out_425081.awb") ~= 0 then
					local var_407_24 = manager.audio:GetVoiceLength("story_v_out_425081", "425081098", "story_v_out_425081.awb") / 1000

					if var_407_24 + var_407_16 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_24 + var_407_16
					end

					if var_407_19.prefab_name ~= "" and arg_404_1.actors_[var_407_19.prefab_name] ~= nil then
						local var_407_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_19.prefab_name].transform, "story_v_out_425081", "425081098", "story_v_out_425081.awb")

						arg_404_1:RecordAudio("425081098", var_407_25)
						arg_404_1:RecordAudio("425081098", var_407_25)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_425081", "425081098", "story_v_out_425081.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_425081", "425081098", "story_v_out_425081.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_26 = math.max(var_407_17, arg_404_1.talkMaxDuration)

			if var_407_16 <= arg_404_1.time_ and arg_404_1.time_ < var_407_16 + var_407_26 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_16) / var_407_26

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_16 + var_407_26 and arg_404_1.time_ < var_407_16 + var_407_26 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.266,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(5, 5, 5)
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play425081099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 425081099
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play425081100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1080"].transform
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.var_.moveOldPos1080 = var_411_0.localPosition
				var_411_0.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("1080", 7)

				local var_411_2 = var_411_0.childCount

				for iter_411_0 = 0, var_411_2 - 1 do
					local var_411_3 = var_411_0:GetChild(iter_411_0)

					if var_411_3.name == "" or not string.find(var_411_3.name, "split") then
						var_411_3.gameObject:SetActive(true)
					else
						var_411_3.gameObject:SetActive(false)
					end
				end
			end

			local var_411_4 = 0.001

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_4 then
				local var_411_5 = (arg_408_1.time_ - var_411_1) / var_411_4
				local var_411_6 = Vector3.New(0, -2000, 0)

				var_411_0.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1080, var_411_6, var_411_5)
			end

			if arg_408_1.time_ >= var_411_1 + var_411_4 and arg_408_1.time_ < var_411_1 + var_411_4 + arg_411_0 then
				var_411_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_411_7 = arg_408_1.actors_["1037"].transform
			local var_411_8 = 0

			if var_411_8 < arg_408_1.time_ and arg_408_1.time_ <= var_411_8 + arg_411_0 then
				arg_408_1.var_.moveOldPos1037 = var_411_7.localPosition
				var_411_7.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("1037", 7)

				local var_411_9 = var_411_7.childCount

				for iter_411_1 = 0, var_411_9 - 1 do
					local var_411_10 = var_411_7:GetChild(iter_411_1)

					if var_411_10.name == "" or not string.find(var_411_10.name, "split") then
						var_411_10.gameObject:SetActive(true)
					else
						var_411_10.gameObject:SetActive(false)
					end
				end
			end

			local var_411_11 = 0.001

			if var_411_8 <= arg_408_1.time_ and arg_408_1.time_ < var_411_8 + var_411_11 then
				local var_411_12 = (arg_408_1.time_ - var_411_8) / var_411_11
				local var_411_13 = Vector3.New(1500, -2000, 0)

				var_411_7.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1037, var_411_13, var_411_12)
			end

			if arg_408_1.time_ >= var_411_8 + var_411_11 and arg_408_1.time_ < var_411_8 + var_411_11 + arg_411_0 then
				var_411_7.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_411_14 = 0
			local var_411_15 = 0.775

			if var_411_14 < arg_408_1.time_ and arg_408_1.time_ <= var_411_14 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_16 = arg_408_1:GetWordFromCfg(425081099)
				local var_411_17 = arg_408_1:FormatText(var_411_16.content)

				arg_408_1.text_.text = var_411_17

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_18 = 31
				local var_411_19 = utf8.len(var_411_17)
				local var_411_20 = var_411_18 <= 0 and var_411_15 or var_411_15 * (var_411_19 / var_411_18)

				if var_411_20 > 0 and var_411_15 < var_411_20 then
					arg_408_1.talkMaxDuration = var_411_20

					if var_411_20 + var_411_14 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_20 + var_411_14
					end
				end

				arg_408_1.text_.text = var_411_17
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_21 = math.max(var_411_15, arg_408_1.talkMaxDuration)

			if var_411_14 <= arg_408_1.time_ and arg_408_1.time_ < var_411_14 + var_411_21 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_14) / var_411_21

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_14 + var_411_21 and arg_408_1.time_ < var_411_14 + var_411_21 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080",
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

		arg_408_1:InitPlayNodeList()
	end,
	Play425081100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 425081100
		arg_412_1.duration_ = 2.03

		local var_412_0 = {
			zh = 1.533,
			ja = 2.033
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play425081101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = arg_412_1.actors_["1037"]
			local var_415_1 = 0

			if var_415_1 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps1037 == nil then
				arg_412_1.var_.actorSpriteComps1037 = var_415_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_2 = 0.2

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_2 and not isNil(var_415_0) then
				local var_415_3 = (arg_412_1.time_ - var_415_1) / var_415_2

				if arg_412_1.var_.actorSpriteComps1037 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								local var_415_4 = Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor1.r, var_415_3)
								local var_415_5 = Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor1.g, var_415_3)
								local var_415_6 = Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor1.b, var_415_3)

								iter_415_1.color = Color.New(var_415_4, var_415_5, var_415_6)
							else
								local var_415_7 = Mathf.Lerp(iter_415_1.color.r, 1, var_415_3)

								iter_415_1.color = Color.New(var_415_7, var_415_7, var_415_7)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= var_415_1 + var_415_2 and arg_412_1.time_ < var_415_1 + var_415_2 + arg_415_0 and not isNil(var_415_0) and arg_412_1.var_.actorSpriteComps1037 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_415_3 then
						if arg_412_1.isInRecall_ then
							iter_415_3.color = arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_415_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_412_1.var_.actorSpriteComps1037 = nil
			end

			local var_415_8 = arg_412_1.actors_["1037"].transform
			local var_415_9 = 0

			if var_415_9 < arg_412_1.time_ and arg_412_1.time_ <= var_415_9 + arg_415_0 then
				arg_412_1.var_.moveOldPos1037 = var_415_8.localPosition
				var_415_8.localScale = Vector3.New(1, 1, 1)

				arg_412_1:CheckSpriteTmpPos("1037", 3)

				local var_415_10 = var_415_8.childCount

				for iter_415_4 = 0, var_415_10 - 1 do
					local var_415_11 = var_415_8:GetChild(iter_415_4)

					if var_415_11.name == "split_4" or not string.find(var_415_11.name, "split") then
						var_415_11.gameObject:SetActive(true)
					else
						var_415_11.gameObject:SetActive(false)
					end
				end
			end

			local var_415_12 = 0.001

			if var_415_9 <= arg_412_1.time_ and arg_412_1.time_ < var_415_9 + var_415_12 then
				local var_415_13 = (arg_412_1.time_ - var_415_9) / var_415_12
				local var_415_14 = Vector3.New(0, -430, -55)

				var_415_8.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1037, var_415_14, var_415_13)
			end

			if arg_412_1.time_ >= var_415_9 + var_415_12 and arg_412_1.time_ < var_415_9 + var_415_12 + arg_415_0 then
				var_415_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_415_15 = 0
			local var_415_16 = 0.125

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_17 = arg_412_1:FormatText(StoryNameCfg[15].name)

				arg_412_1.leftNameTxt_.text = var_415_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_18 = arg_412_1:GetWordFromCfg(425081100)
				local var_415_19 = arg_412_1:FormatText(var_415_18.content)

				arg_412_1.text_.text = var_415_19

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_20 = 5
				local var_415_21 = utf8.len(var_415_19)
				local var_415_22 = var_415_20 <= 0 and var_415_16 or var_415_16 * (var_415_21 / var_415_20)

				if var_415_22 > 0 and var_415_16 < var_415_22 then
					arg_412_1.talkMaxDuration = var_415_22

					if var_415_22 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_22 + var_415_15
					end
				end

				arg_412_1.text_.text = var_415_19
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081100", "story_v_out_425081.awb") ~= 0 then
					local var_415_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081100", "story_v_out_425081.awb") / 1000

					if var_415_23 + var_415_15 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_23 + var_415_15
					end

					if var_415_18.prefab_name ~= "" and arg_412_1.actors_[var_415_18.prefab_name] ~= nil then
						local var_415_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_18.prefab_name].transform, "story_v_out_425081", "425081100", "story_v_out_425081.awb")

						arg_412_1:RecordAudio("425081100", var_415_24)
						arg_412_1:RecordAudio("425081100", var_415_24)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_425081", "425081100", "story_v_out_425081.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_425081", "425081100", "story_v_out_425081.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_25 = math.max(var_415_16, arg_412_1.talkMaxDuration)

			if var_415_15 <= arg_412_1.time_ and arg_412_1.time_ < var_415_15 + var_415_25 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_15) / var_415_25

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_15 + var_415_25 and arg_412_1.time_ < var_415_15 + var_415_25 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
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

		arg_412_1:InitPlayNodeList()
	end,
	Play425081101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 425081101
		arg_416_1.duration_ = 10.6

		local var_416_0 = {
			zh = 8.6,
			ja = 10.6
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play425081102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1037"]
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps1037 == nil then
				arg_416_1.var_.actorSpriteComps1037 = var_419_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_2 = 0.2

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 and not isNil(var_419_0) then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2

				if arg_416_1.var_.actorSpriteComps1037 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 and not isNil(var_419_0) and arg_416_1.var_.actorSpriteComps1037 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_419_3 then
						if arg_416_1.isInRecall_ then
							iter_419_3.color = arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_419_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_416_1.var_.actorSpriteComps1037 = nil
			end

			local var_419_8 = 0
			local var_419_9 = 0.8

			if var_419_8 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_10 = arg_416_1:FormatText(StoryNameCfg[56].name)

				arg_416_1.leftNameTxt_.text = var_419_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_11 = arg_416_1:GetWordFromCfg(425081101)
				local var_419_12 = arg_416_1:FormatText(var_419_11.content)

				arg_416_1.text_.text = var_419_12

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_13 = 32
				local var_419_14 = utf8.len(var_419_12)
				local var_419_15 = var_419_13 <= 0 and var_419_9 or var_419_9 * (var_419_14 / var_419_13)

				if var_419_15 > 0 and var_419_9 < var_419_15 then
					arg_416_1.talkMaxDuration = var_419_15

					if var_419_15 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_15 + var_419_8
					end
				end

				arg_416_1.text_.text = var_419_12
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081101", "story_v_out_425081.awb") ~= 0 then
					local var_419_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081101", "story_v_out_425081.awb") / 1000

					if var_419_16 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_16 + var_419_8
					end

					if var_419_11.prefab_name ~= "" and arg_416_1.actors_[var_419_11.prefab_name] ~= nil then
						local var_419_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_11.prefab_name].transform, "story_v_out_425081", "425081101", "story_v_out_425081.awb")

						arg_416_1:RecordAudio("425081101", var_419_17)
						arg_416_1:RecordAudio("425081101", var_419_17)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_425081", "425081101", "story_v_out_425081.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_425081", "425081101", "story_v_out_425081.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_18 = math.max(var_419_9, arg_416_1.talkMaxDuration)

			if var_419_8 <= arg_416_1.time_ and arg_416_1.time_ < var_419_8 + var_419_18 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_8) / var_419_18

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_8 + var_419_18 and arg_416_1.time_ < var_419_8 + var_419_18 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play425081102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 425081102
		arg_420_1.duration_ = 17.27

		local var_420_0 = {
			zh = 9.7,
			ja = 17.266
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
				arg_420_0:Play425081103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0
			local var_423_1 = 0.775

			if var_423_0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_2 = arg_420_1:FormatText(StoryNameCfg[56].name)

				arg_420_1.leftNameTxt_.text = var_423_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_3 = arg_420_1:GetWordFromCfg(425081102)
				local var_423_4 = arg_420_1:FormatText(var_423_3.content)

				arg_420_1.text_.text = var_423_4

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_5 = 31
				local var_423_6 = utf8.len(var_423_4)
				local var_423_7 = var_423_5 <= 0 and var_423_1 or var_423_1 * (var_423_6 / var_423_5)

				if var_423_7 > 0 and var_423_1 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_0
					end
				end

				arg_420_1.text_.text = var_423_4
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081102", "story_v_out_425081.awb") ~= 0 then
					local var_423_8 = manager.audio:GetVoiceLength("story_v_out_425081", "425081102", "story_v_out_425081.awb") / 1000

					if var_423_8 + var_423_0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_0
					end

					if var_423_3.prefab_name ~= "" and arg_420_1.actors_[var_423_3.prefab_name] ~= nil then
						local var_423_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_3.prefab_name].transform, "story_v_out_425081", "425081102", "story_v_out_425081.awb")

						arg_420_1:RecordAudio("425081102", var_423_9)
						arg_420_1:RecordAudio("425081102", var_423_9)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_425081", "425081102", "story_v_out_425081.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_425081", "425081102", "story_v_out_425081.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_10 = math.max(var_423_1, arg_420_1.talkMaxDuration)

			if var_423_0 <= arg_420_1.time_ and arg_420_1.time_ < var_423_0 + var_423_10 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_0) / var_423_10

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_0 + var_423_10 and arg_420_1.time_ < var_423_0 + var_423_10 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play425081103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 425081103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play425081104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1037"].transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.moveOldPos1037 = var_427_0.localPosition
				var_427_0.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("1037", 7)

				local var_427_2 = var_427_0.childCount

				for iter_427_0 = 0, var_427_2 - 1 do
					local var_427_3 = var_427_0:GetChild(iter_427_0)

					if var_427_3.name == "" or not string.find(var_427_3.name, "split") then
						var_427_3.gameObject:SetActive(true)
					else
						var_427_3.gameObject:SetActive(false)
					end
				end
			end

			local var_427_4 = 0.001

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_4 then
				local var_427_5 = (arg_424_1.time_ - var_427_1) / var_427_4
				local var_427_6 = Vector3.New(1500, -2000, 0)

				var_427_0.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1037, var_427_6, var_427_5)
			end

			if arg_424_1.time_ >= var_427_1 + var_427_4 and arg_424_1.time_ < var_427_1 + var_427_4 + arg_427_0 then
				var_427_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_427_7 = 0
			local var_427_8 = 0.975

			if var_427_7 < arg_424_1.time_ and arg_424_1.time_ <= var_427_7 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_9 = arg_424_1:GetWordFromCfg(425081103)
				local var_427_10 = arg_424_1:FormatText(var_427_9.content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 39
				local var_427_12 = utf8.len(var_427_10)
				local var_427_13 = var_427_11 <= 0 and var_427_8 or var_427_8 * (var_427_12 / var_427_11)

				if var_427_13 > 0 and var_427_8 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_7 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_7
					end
				end

				arg_424_1.text_.text = var_427_10
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_8, arg_424_1.talkMaxDuration)

			if var_427_7 <= arg_424_1.time_ and arg_424_1.time_ < var_427_7 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_7) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_7 + var_427_14 and arg_424_1.time_ < var_427_7 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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

		arg_424_1:InitPlayNodeList()
	end,
	Play425081104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 425081104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play425081105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 1.025

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_2 = arg_428_1:GetWordFromCfg(425081104)
				local var_431_3 = arg_428_1:FormatText(var_431_2.content)

				arg_428_1.text_.text = var_431_3

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_4 = 41
				local var_431_5 = utf8.len(var_431_3)
				local var_431_6 = var_431_4 <= 0 and var_431_1 or var_431_1 * (var_431_5 / var_431_4)

				if var_431_6 > 0 and var_431_1 < var_431_6 then
					arg_428_1.talkMaxDuration = var_431_6

					if var_431_6 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_6 + var_431_0
					end
				end

				arg_428_1.text_.text = var_431_3
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_7 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_7 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_7

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_7 and arg_428_1.time_ < var_431_0 + var_431_7 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play425081105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 425081105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play425081106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.65

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_2 = arg_432_1:FormatText(StoryNameCfg[7].name)

				arg_432_1.leftNameTxt_.text = var_435_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:GetWordFromCfg(425081105)
				local var_435_4 = arg_432_1:FormatText(var_435_3.content)

				arg_432_1.text_.text = var_435_4

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 26
				local var_435_6 = utf8.len(var_435_4)
				local var_435_7 = var_435_5 <= 0 and var_435_1 or var_435_1 * (var_435_6 / var_435_5)

				if var_435_7 > 0 and var_435_1 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_4
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_8 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_8 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_8

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_8 and arg_432_1.time_ < var_435_0 + var_435_8 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play425081106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 425081106
		arg_436_1.duration_ = 9

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play425081107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 2

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				local var_439_1 = manager.ui.mainCamera.transform.localPosition
				local var_439_2 = Vector3.New(0, 0, 10) + Vector3.New(var_439_1.x, var_439_1.y, 0)
				local var_439_3 = arg_436_1.bgs_.ST01a

				var_439_3.transform.localPosition = var_439_2
				var_439_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_439_4 = var_439_3:GetComponent("SpriteRenderer")

				if var_439_4 and var_439_4.sprite then
					local var_439_5 = (var_439_3.transform.localPosition - var_439_1).z
					local var_439_6 = manager.ui.mainCameraCom_
					local var_439_7 = 2 * var_439_5 * Mathf.Tan(var_439_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_439_8 = var_439_7 * var_439_6.aspect
					local var_439_9 = var_439_4.sprite.bounds.size.x
					local var_439_10 = var_439_4.sprite.bounds.size.y
					local var_439_11 = var_439_8 / var_439_9
					local var_439_12 = var_439_7 / var_439_10
					local var_439_13 = var_439_12 < var_439_11 and var_439_11 or var_439_12

					var_439_3.transform.localScale = Vector3.New(var_439_13, var_439_13, 0)
				end

				for iter_439_0, iter_439_1 in pairs(arg_436_1.bgs_) do
					if iter_439_0 ~= "ST01a" then
						iter_439_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_439_14 = 4

			if var_439_14 < arg_436_1.time_ and arg_436_1.time_ <= var_439_14 + arg_439_0 then
				arg_436_1.allBtn_.enabled = false
			end

			local var_439_15 = 0.3

			if arg_436_1.time_ >= var_439_14 + var_439_15 and arg_436_1.time_ < var_439_14 + var_439_15 + arg_439_0 then
				arg_436_1.allBtn_.enabled = true
			end

			local var_439_16 = 0

			if var_439_16 < arg_436_1.time_ and arg_436_1.time_ <= var_439_16 + arg_439_0 then
				arg_436_1.mask_.enabled = true
				arg_436_1.mask_.raycastTarget = true

				arg_436_1:SetGaussion(false)
			end

			local var_439_17 = 2

			if var_439_16 <= arg_436_1.time_ and arg_436_1.time_ < var_439_16 + var_439_17 then
				local var_439_18 = (arg_436_1.time_ - var_439_16) / var_439_17
				local var_439_19 = Color.New(0, 0, 0)

				var_439_19.a = Mathf.Lerp(0, 1, var_439_18)
				arg_436_1.mask_.color = var_439_19
			end

			if arg_436_1.time_ >= var_439_16 + var_439_17 and arg_436_1.time_ < var_439_16 + var_439_17 + arg_439_0 then
				local var_439_20 = Color.New(0, 0, 0)

				var_439_20.a = 1
				arg_436_1.mask_.color = var_439_20
			end

			local var_439_21 = 2

			if var_439_21 < arg_436_1.time_ and arg_436_1.time_ <= var_439_21 + arg_439_0 then
				arg_436_1.mask_.enabled = true
				arg_436_1.mask_.raycastTarget = true

				arg_436_1:SetGaussion(false)
			end

			local var_439_22 = 2

			if var_439_21 <= arg_436_1.time_ and arg_436_1.time_ < var_439_21 + var_439_22 then
				local var_439_23 = (arg_436_1.time_ - var_439_21) / var_439_22
				local var_439_24 = Color.New(0, 0, 0)

				var_439_24.a = Mathf.Lerp(1, 0, var_439_23)
				arg_436_1.mask_.color = var_439_24
			end

			if arg_436_1.time_ >= var_439_21 + var_439_22 and arg_436_1.time_ < var_439_21 + var_439_22 + arg_439_0 then
				local var_439_25 = Color.New(0, 0, 0)
				local var_439_26 = 0

				arg_436_1.mask_.enabled = false
				var_439_25.a = var_439_26
				arg_436_1.mask_.color = var_439_25
			end

			local var_439_27 = 0.133333333333333
			local var_439_28 = 1

			if var_439_27 < arg_436_1.time_ and arg_436_1.time_ <= var_439_27 + arg_439_0 then
				local var_439_29 = "stop"
				local var_439_30 = "effect"

				arg_436_1:AudioAction(var_439_29, var_439_30, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_439_31 = 1.63333333333333
			local var_439_32 = 1

			if var_439_31 < arg_436_1.time_ and arg_436_1.time_ <= var_439_31 + arg_439_0 then
				local var_439_33 = "play"
				local var_439_34 = "effect"

				arg_436_1:AudioAction(var_439_33, var_439_34, "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_436_1.frameCnt_ <= 1 then
				arg_436_1.dialog_:SetActive(false)
			end

			local var_439_35 = 4
			local var_439_36 = 0.6

			if var_439_35 < arg_436_1.time_ and arg_436_1.time_ <= var_439_35 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0

				arg_436_1.dialog_:SetActive(true)

				arg_436_1.dialogCg_.alpha = 0

				local var_439_37 = LeanTween.value(arg_436_1.dialog_, 0, 1, 0.3)

				var_439_37:setOnUpdate(LuaHelper.FloatAction(function(arg_440_0)
					arg_436_1.dialogCg_.alpha = arg_440_0
				end))
				var_439_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_436_1.dialog_)
					var_439_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_436_1.duration_ = arg_436_1.duration_ + 0.3

				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_38 = arg_436_1:GetWordFromCfg(425081106)
				local var_439_39 = arg_436_1:FormatText(var_439_38.content)

				arg_436_1.text_.text = var_439_39

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_40 = 24
				local var_439_41 = utf8.len(var_439_39)
				local var_439_42 = var_439_40 <= 0 and var_439_36 or var_439_36 * (var_439_41 / var_439_40)

				if var_439_42 > 0 and var_439_36 < var_439_42 then
					arg_436_1.talkMaxDuration = var_439_42
					var_439_35 = var_439_35 + 0.3

					if var_439_42 + var_439_35 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_42 + var_439_35
					end
				end

				arg_436_1.text_.text = var_439_39
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_43 = var_439_35 + 0.3
			local var_439_44 = math.max(var_439_36, arg_436_1.talkMaxDuration)

			if var_439_43 <= arg_436_1.time_ and arg_436_1.time_ < var_439_43 + var_439_44 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_43) / var_439_44

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_43 + var_439_44 and arg_436_1.time_ < var_439_43 + var_439_44 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play425081107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 425081107
		arg_442_1.duration_ = 11.2

		local var_442_0 = {
			zh = 6.766,
			ja = 11.2
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play425081108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1037"]
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1037 == nil then
				arg_442_1.var_.actorSpriteComps1037 = var_445_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_2 = 0.2

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 and not isNil(var_445_0) then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2

				if arg_442_1.var_.actorSpriteComps1037 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								local var_445_4 = Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor1.r, var_445_3)
								local var_445_5 = Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor1.g, var_445_3)
								local var_445_6 = Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor1.b, var_445_3)

								iter_445_1.color = Color.New(var_445_4, var_445_5, var_445_6)
							else
								local var_445_7 = Mathf.Lerp(iter_445_1.color.r, 1, var_445_3)

								iter_445_1.color = Color.New(var_445_7, var_445_7, var_445_7)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 and not isNil(var_445_0) and arg_442_1.var_.actorSpriteComps1037 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_445_3 then
						if arg_442_1.isInRecall_ then
							iter_445_3.color = arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_445_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_442_1.var_.actorSpriteComps1037 = nil
			end

			local var_445_8 = arg_442_1.actors_["1037"].transform
			local var_445_9 = 0

			if var_445_9 < arg_442_1.time_ and arg_442_1.time_ <= var_445_9 + arg_445_0 then
				arg_442_1.var_.moveOldPos1037 = var_445_8.localPosition
				var_445_8.localScale = Vector3.New(1, 1, 1)

				arg_442_1:CheckSpriteTmpPos("1037", 3)

				local var_445_10 = var_445_8.childCount

				for iter_445_4 = 0, var_445_10 - 1 do
					local var_445_11 = var_445_8:GetChild(iter_445_4)

					if var_445_11.name == "split_4" or not string.find(var_445_11.name, "split") then
						var_445_11.gameObject:SetActive(true)
					else
						var_445_11.gameObject:SetActive(false)
					end
				end
			end

			local var_445_12 = 0.001

			if var_445_9 <= arg_442_1.time_ and arg_442_1.time_ < var_445_9 + var_445_12 then
				local var_445_13 = (arg_442_1.time_ - var_445_9) / var_445_12
				local var_445_14 = Vector3.New(0, -430, -55)

				var_445_8.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1037, var_445_14, var_445_13)
			end

			if arg_442_1.time_ >= var_445_9 + var_445_12 and arg_442_1.time_ < var_445_9 + var_445_12 + arg_445_0 then
				var_445_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_445_15 = 0
			local var_445_16 = 0.65

			if var_445_15 < arg_442_1.time_ and arg_442_1.time_ <= var_445_15 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_17 = arg_442_1:FormatText(StoryNameCfg[15].name)

				arg_442_1.leftNameTxt_.text = var_445_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_18 = arg_442_1:GetWordFromCfg(425081107)
				local var_445_19 = arg_442_1:FormatText(var_445_18.content)

				arg_442_1.text_.text = var_445_19

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_20 = 26
				local var_445_21 = utf8.len(var_445_19)
				local var_445_22 = var_445_20 <= 0 and var_445_16 or var_445_16 * (var_445_21 / var_445_20)

				if var_445_22 > 0 and var_445_16 < var_445_22 then
					arg_442_1.talkMaxDuration = var_445_22

					if var_445_22 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_22 + var_445_15
					end
				end

				arg_442_1.text_.text = var_445_19
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081107", "story_v_out_425081.awb") ~= 0 then
					local var_445_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081107", "story_v_out_425081.awb") / 1000

					if var_445_23 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_23 + var_445_15
					end

					if var_445_18.prefab_name ~= "" and arg_442_1.actors_[var_445_18.prefab_name] ~= nil then
						local var_445_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_18.prefab_name].transform, "story_v_out_425081", "425081107", "story_v_out_425081.awb")

						arg_442_1:RecordAudio("425081107", var_445_24)
						arg_442_1:RecordAudio("425081107", var_445_24)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_425081", "425081107", "story_v_out_425081.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_425081", "425081107", "story_v_out_425081.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_25 = math.max(var_445_16, arg_442_1.talkMaxDuration)

			if var_445_15 <= arg_442_1.time_ and arg_442_1.time_ < var_445_15 + var_445_25 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_15) / var_445_25

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_15 + var_445_25 and arg_442_1.time_ < var_445_15 + var_445_25 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
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

		arg_442_1:InitPlayNodeList()
	end,
	Play425081108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 425081108
		arg_446_1.duration_ = 5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play425081109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = arg_446_1.actors_["1037"]
			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps1037 == nil then
				arg_446_1.var_.actorSpriteComps1037 = var_449_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_2 = 0.2

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_2 and not isNil(var_449_0) then
				local var_449_3 = (arg_446_1.time_ - var_449_1) / var_449_2

				if arg_446_1.var_.actorSpriteComps1037 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								local var_449_4 = Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor2.r, var_449_3)
								local var_449_5 = Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor2.g, var_449_3)
								local var_449_6 = Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor2.b, var_449_3)

								iter_449_1.color = Color.New(var_449_4, var_449_5, var_449_6)
							else
								local var_449_7 = Mathf.Lerp(iter_449_1.color.r, 0.5, var_449_3)

								iter_449_1.color = Color.New(var_449_7, var_449_7, var_449_7)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= var_449_1 + var_449_2 and arg_446_1.time_ < var_449_1 + var_449_2 + arg_449_0 and not isNil(var_449_0) and arg_446_1.var_.actorSpriteComps1037 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_449_3 then
						if arg_446_1.isInRecall_ then
							iter_449_3.color = arg_446_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_449_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_446_1.var_.actorSpriteComps1037 = nil
			end

			local var_449_8 = 0
			local var_449_9 = 0.35

			if var_449_8 < arg_446_1.time_ and arg_446_1.time_ <= var_449_8 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_10 = arg_446_1:FormatText(StoryNameCfg[7].name)

				arg_446_1.leftNameTxt_.text = var_449_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_11 = arg_446_1:GetWordFromCfg(425081108)
				local var_449_12 = arg_446_1:FormatText(var_449_11.content)

				arg_446_1.text_.text = var_449_12

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_13 = 14
				local var_449_14 = utf8.len(var_449_12)
				local var_449_15 = var_449_13 <= 0 and var_449_9 or var_449_9 * (var_449_14 / var_449_13)

				if var_449_15 > 0 and var_449_9 < var_449_15 then
					arg_446_1.talkMaxDuration = var_449_15

					if var_449_15 + var_449_8 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_15 + var_449_8
					end
				end

				arg_446_1.text_.text = var_449_12
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_16 = math.max(var_449_9, arg_446_1.talkMaxDuration)

			if var_449_8 <= arg_446_1.time_ and arg_446_1.time_ < var_449_8 + var_449_16 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_8) / var_449_16

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_8 + var_449_16 and arg_446_1.time_ < var_449_8 + var_449_16 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play425081109 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 425081109
		arg_450_1.duration_ = 8.6

		local var_450_0 = {
			zh = 6.633,
			ja = 8.6
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play425081110(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1037"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps1037 == nil then
				arg_450_1.var_.actorSpriteComps1037 = var_453_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_2 = 0.2

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.actorSpriteComps1037 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								local var_453_4 = Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor1.r, var_453_3)
								local var_453_5 = Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor1.g, var_453_3)
								local var_453_6 = Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor1.b, var_453_3)

								iter_453_1.color = Color.New(var_453_4, var_453_5, var_453_6)
							else
								local var_453_7 = Mathf.Lerp(iter_453_1.color.r, 1, var_453_3)

								iter_453_1.color = Color.New(var_453_7, var_453_7, var_453_7)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.actorSpriteComps1037 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_453_3 then
						if arg_450_1.isInRecall_ then
							iter_453_3.color = arg_450_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_453_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_450_1.var_.actorSpriteComps1037 = nil
			end

			local var_453_8 = 0
			local var_453_9 = 0.7

			if var_453_8 < arg_450_1.time_ and arg_450_1.time_ <= var_453_8 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_10 = arg_450_1:FormatText(StoryNameCfg[15].name)

				arg_450_1.leftNameTxt_.text = var_453_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_11 = arg_450_1:GetWordFromCfg(425081109)
				local var_453_12 = arg_450_1:FormatText(var_453_11.content)

				arg_450_1.text_.text = var_453_12

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_13 = 28
				local var_453_14 = utf8.len(var_453_12)
				local var_453_15 = var_453_13 <= 0 and var_453_9 or var_453_9 * (var_453_14 / var_453_13)

				if var_453_15 > 0 and var_453_9 < var_453_15 then
					arg_450_1.talkMaxDuration = var_453_15

					if var_453_15 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_15 + var_453_8
					end
				end

				arg_450_1.text_.text = var_453_12
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081109", "story_v_out_425081.awb") ~= 0 then
					local var_453_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081109", "story_v_out_425081.awb") / 1000

					if var_453_16 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_16 + var_453_8
					end

					if var_453_11.prefab_name ~= "" and arg_450_1.actors_[var_453_11.prefab_name] ~= nil then
						local var_453_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_11.prefab_name].transform, "story_v_out_425081", "425081109", "story_v_out_425081.awb")

						arg_450_1:RecordAudio("425081109", var_453_17)
						arg_450_1:RecordAudio("425081109", var_453_17)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_425081", "425081109", "story_v_out_425081.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_425081", "425081109", "story_v_out_425081.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_18 = math.max(var_453_9, arg_450_1.talkMaxDuration)

			if var_453_8 <= arg_450_1.time_ and arg_450_1.time_ < var_453_8 + var_453_18 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_8) / var_453_18

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_8 + var_453_18 and arg_450_1.time_ < var_453_8 + var_453_18 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play425081110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 425081110
		arg_454_1.duration_ = 3.37

		local var_454_0 = {
			zh = 3.366,
			ja = 3.333
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play425081111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1037"].transform
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 then
				arg_454_1.var_.moveOldPos1037 = var_457_0.localPosition
				var_457_0.localScale = Vector3.New(1, 1, 1)

				arg_454_1:CheckSpriteTmpPos("1037", 3)

				local var_457_2 = var_457_0.childCount

				for iter_457_0 = 0, var_457_2 - 1 do
					local var_457_3 = var_457_0:GetChild(iter_457_0)

					if var_457_3.name == "split_3" then
						var_457_3:SetAsLastSibling()
						var_457_3.gameObject:SetActive(true)

						arg_454_1.var_.actorSpriteSplit1037 = var_457_3.gameObject:GetComponent(typeof(Image))

						arg_454_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_457_4 = 0.333333333333333

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_4 then
				local var_457_5 = (arg_454_1.time_ - var_457_1) / var_457_4
				local var_457_6 = Vector3.New(0, -430, -55)

				var_457_0.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1037, var_457_6, var_457_5)

				if arg_454_1.var_.actorSpriteSplit1037 ~= nil then
					arg_454_1.var_.actorSpriteSplit1037:SetAlpha(var_457_5)
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_4 and arg_454_1.time_ < var_457_1 + var_457_4 + arg_457_0 then
				var_457_0.localPosition = Vector3.New(0, -430, -55)

				if arg_454_1.var_.actorSpriteSplit1037 ~= nil then
					arg_454_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_457_7 = 0
			local var_457_8 = 0.425

			if var_457_7 < arg_454_1.time_ and arg_454_1.time_ <= var_457_7 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_9 = arg_454_1:FormatText(StoryNameCfg[15].name)

				arg_454_1.leftNameTxt_.text = var_457_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_10 = arg_454_1:GetWordFromCfg(425081110)
				local var_457_11 = arg_454_1:FormatText(var_457_10.content)

				arg_454_1.text_.text = var_457_11

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_12 = 17
				local var_457_13 = utf8.len(var_457_11)
				local var_457_14 = var_457_12 <= 0 and var_457_8 or var_457_8 * (var_457_13 / var_457_12)

				if var_457_14 > 0 and var_457_8 < var_457_14 then
					arg_454_1.talkMaxDuration = var_457_14

					if var_457_14 + var_457_7 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_14 + var_457_7
					end
				end

				arg_454_1.text_.text = var_457_11
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081110", "story_v_out_425081.awb") ~= 0 then
					local var_457_15 = manager.audio:GetVoiceLength("story_v_out_425081", "425081110", "story_v_out_425081.awb") / 1000

					if var_457_15 + var_457_7 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_15 + var_457_7
					end

					if var_457_10.prefab_name ~= "" and arg_454_1.actors_[var_457_10.prefab_name] ~= nil then
						local var_457_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_10.prefab_name].transform, "story_v_out_425081", "425081110", "story_v_out_425081.awb")

						arg_454_1:RecordAudio("425081110", var_457_16)
						arg_454_1:RecordAudio("425081110", var_457_16)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_425081", "425081110", "story_v_out_425081.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_425081", "425081110", "story_v_out_425081.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_17 = math.max(var_457_8, arg_454_1.talkMaxDuration)

			if var_457_7 <= arg_454_1.time_ and arg_454_1.time_ < var_457_7 + var_457_17 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_7) / var_457_17

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_7 + var_457_17 and arg_454_1.time_ < var_457_7 + var_457_17 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_454_1:InitPlayNodeList()
	end,
	Play425081111 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 425081111
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play425081112(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1037"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.actorSpriteComps1037 == nil then
				arg_458_1.var_.actorSpriteComps1037 = var_461_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_461_2 = 0.2

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.actorSpriteComps1037 then
					for iter_461_0, iter_461_1 in pairs(arg_458_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_461_1 then
							if arg_458_1.isInRecall_ then
								local var_461_4 = Mathf.Lerp(iter_461_1.color.r, arg_458_1.hightColor2.r, var_461_3)
								local var_461_5 = Mathf.Lerp(iter_461_1.color.g, arg_458_1.hightColor2.g, var_461_3)
								local var_461_6 = Mathf.Lerp(iter_461_1.color.b, arg_458_1.hightColor2.b, var_461_3)

								iter_461_1.color = Color.New(var_461_4, var_461_5, var_461_6)
							else
								local var_461_7 = Mathf.Lerp(iter_461_1.color.r, 0.5, var_461_3)

								iter_461_1.color = Color.New(var_461_7, var_461_7, var_461_7)
							end
						end
					end
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.actorSpriteComps1037 then
				for iter_461_2, iter_461_3 in pairs(arg_458_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_461_3 then
						if arg_458_1.isInRecall_ then
							iter_461_3.color = arg_458_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_461_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_458_1.var_.actorSpriteComps1037 = nil
			end

			local var_461_8 = arg_458_1.actors_["1037"].transform
			local var_461_9 = 0

			if var_461_9 < arg_458_1.time_ and arg_458_1.time_ <= var_461_9 + arg_461_0 then
				arg_458_1.var_.moveOldPos1037 = var_461_8.localPosition
				var_461_8.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("1037", 3)

				local var_461_10 = var_461_8.childCount

				for iter_461_4 = 0, var_461_10 - 1 do
					local var_461_11 = var_461_8:GetChild(iter_461_4)

					if var_461_11.name == "split_4" then
						var_461_11:SetAsLastSibling()
						var_461_11.gameObject:SetActive(true)

						arg_458_1.var_.actorSpriteSplit1037 = var_461_11.gameObject:GetComponent(typeof(Image))

						arg_458_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_461_12 = 0.2

			if var_461_9 <= arg_458_1.time_ and arg_458_1.time_ < var_461_9 + var_461_12 then
				local var_461_13 = (arg_458_1.time_ - var_461_9) / var_461_12
				local var_461_14 = Vector3.New(0, -430, -55)

				var_461_8.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1037, var_461_14, var_461_13)

				if arg_458_1.var_.actorSpriteSplit1037 ~= nil then
					arg_458_1.var_.actorSpriteSplit1037:SetAlpha(var_461_13)
				end
			end

			if arg_458_1.time_ >= var_461_9 + var_461_12 and arg_458_1.time_ < var_461_9 + var_461_12 + arg_461_0 then
				var_461_8.localPosition = Vector3.New(0, -430, -55)

				if arg_458_1.var_.actorSpriteSplit1037 ~= nil then
					arg_458_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_461_15 = 0
			local var_461_16 = 0.725

			if var_461_15 < arg_458_1.time_ and arg_458_1.time_ <= var_461_15 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				local var_461_17 = arg_458_1:FormatText(StoryNameCfg[7].name)

				arg_458_1.leftNameTxt_.text = var_461_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_18 = arg_458_1:GetWordFromCfg(425081111)
				local var_461_19 = arg_458_1:FormatText(var_461_18.content)

				arg_458_1.text_.text = var_461_19

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_20 = 29
				local var_461_21 = utf8.len(var_461_19)
				local var_461_22 = var_461_20 <= 0 and var_461_16 or var_461_16 * (var_461_21 / var_461_20)

				if var_461_22 > 0 and var_461_16 < var_461_22 then
					arg_458_1.talkMaxDuration = var_461_22

					if var_461_22 + var_461_15 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_22 + var_461_15
					end
				end

				arg_458_1.text_.text = var_461_19
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_23 = math.max(var_461_16, arg_458_1.talkMaxDuration)

			if var_461_15 <= arg_458_1.time_ and arg_458_1.time_ < var_461_15 + var_461_23 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_15) / var_461_23

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_15 + var_461_23 and arg_458_1.time_ < var_461_15 + var_461_23 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
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

		arg_458_1:InitPlayNodeList()
	end,
	Play425081112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 425081112
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play425081113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0
			local var_465_1 = 1.225

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_2 = arg_462_1:FormatText(StoryNameCfg[7].name)

				arg_462_1.leftNameTxt_.text = var_465_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_3 = arg_462_1:GetWordFromCfg(425081112)
				local var_465_4 = arg_462_1:FormatText(var_465_3.content)

				arg_462_1.text_.text = var_465_4

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_5 = 49
				local var_465_6 = utf8.len(var_465_4)
				local var_465_7 = var_465_5 <= 0 and var_465_1 or var_465_1 * (var_465_6 / var_465_5)

				if var_465_7 > 0 and var_465_1 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_4
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_8 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_8 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_8

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_8 and arg_462_1.time_ < var_465_0 + var_465_8 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play425081113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 425081113
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play425081114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0
			local var_469_1 = 0.7

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_2 = arg_466_1:FormatText(StoryNameCfg[7].name)

				arg_466_1.leftNameTxt_.text = var_469_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:GetWordFromCfg(425081113)
				local var_469_4 = arg_466_1:FormatText(var_469_3.content)

				arg_466_1.text_.text = var_469_4

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 28
				local var_469_6 = utf8.len(var_469_4)
				local var_469_7 = var_469_5 <= 0 and var_469_1 or var_469_1 * (var_469_6 / var_469_5)

				if var_469_7 > 0 and var_469_1 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_0
					end
				end

				arg_466_1.text_.text = var_469_4
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_8 = math.max(var_469_1, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_8 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_0) / var_469_8

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_8 and arg_466_1.time_ < var_469_0 + var_469_8 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play425081114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 425081114
		arg_470_1.duration_ = 8

		local var_470_0 = {
			zh = 8,
			ja = 7.433
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play425081115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1037"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.actorSpriteComps1037 == nil then
				arg_470_1.var_.actorSpriteComps1037 = var_473_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_473_2 = 0.2

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.actorSpriteComps1037 then
					for iter_473_0, iter_473_1 in pairs(arg_470_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_473_1 then
							if arg_470_1.isInRecall_ then
								local var_473_4 = Mathf.Lerp(iter_473_1.color.r, arg_470_1.hightColor1.r, var_473_3)
								local var_473_5 = Mathf.Lerp(iter_473_1.color.g, arg_470_1.hightColor1.g, var_473_3)
								local var_473_6 = Mathf.Lerp(iter_473_1.color.b, arg_470_1.hightColor1.b, var_473_3)

								iter_473_1.color = Color.New(var_473_4, var_473_5, var_473_6)
							else
								local var_473_7 = Mathf.Lerp(iter_473_1.color.r, 1, var_473_3)

								iter_473_1.color = Color.New(var_473_7, var_473_7, var_473_7)
							end
						end
					end
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.actorSpriteComps1037 then
				for iter_473_2, iter_473_3 in pairs(arg_470_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_473_3 then
						if arg_470_1.isInRecall_ then
							iter_473_3.color = arg_470_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_473_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_470_1.var_.actorSpriteComps1037 = nil
			end

			local var_473_8 = 0
			local var_473_9 = 0.825

			if var_473_8 < arg_470_1.time_ and arg_470_1.time_ <= var_473_8 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_10 = arg_470_1:FormatText(StoryNameCfg[15].name)

				arg_470_1.leftNameTxt_.text = var_473_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_11 = arg_470_1:GetWordFromCfg(425081114)
				local var_473_12 = arg_470_1:FormatText(var_473_11.content)

				arg_470_1.text_.text = var_473_12

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_13 = 33
				local var_473_14 = utf8.len(var_473_12)
				local var_473_15 = var_473_13 <= 0 and var_473_9 or var_473_9 * (var_473_14 / var_473_13)

				if var_473_15 > 0 and var_473_9 < var_473_15 then
					arg_470_1.talkMaxDuration = var_473_15

					if var_473_15 + var_473_8 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_15 + var_473_8
					end
				end

				arg_470_1.text_.text = var_473_12
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081114", "story_v_out_425081.awb") ~= 0 then
					local var_473_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081114", "story_v_out_425081.awb") / 1000

					if var_473_16 + var_473_8 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_16 + var_473_8
					end

					if var_473_11.prefab_name ~= "" and arg_470_1.actors_[var_473_11.prefab_name] ~= nil then
						local var_473_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_11.prefab_name].transform, "story_v_out_425081", "425081114", "story_v_out_425081.awb")

						arg_470_1:RecordAudio("425081114", var_473_17)
						arg_470_1:RecordAudio("425081114", var_473_17)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_425081", "425081114", "story_v_out_425081.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_425081", "425081114", "story_v_out_425081.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_18 = math.max(var_473_9, arg_470_1.talkMaxDuration)

			if var_473_8 <= arg_470_1.time_ and arg_470_1.time_ < var_473_8 + var_473_18 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_8) / var_473_18

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_8 + var_473_18 and arg_470_1.time_ < var_473_8 + var_473_18 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play425081115 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 425081115
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play425081116(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["1037"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.actorSpriteComps1037 == nil then
				arg_474_1.var_.actorSpriteComps1037 = var_477_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_477_2 = 0.2

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.actorSpriteComps1037 then
					for iter_477_0, iter_477_1 in pairs(arg_474_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_477_1 then
							if arg_474_1.isInRecall_ then
								local var_477_4 = Mathf.Lerp(iter_477_1.color.r, arg_474_1.hightColor2.r, var_477_3)
								local var_477_5 = Mathf.Lerp(iter_477_1.color.g, arg_474_1.hightColor2.g, var_477_3)
								local var_477_6 = Mathf.Lerp(iter_477_1.color.b, arg_474_1.hightColor2.b, var_477_3)

								iter_477_1.color = Color.New(var_477_4, var_477_5, var_477_6)
							else
								local var_477_7 = Mathf.Lerp(iter_477_1.color.r, 0.5, var_477_3)

								iter_477_1.color = Color.New(var_477_7, var_477_7, var_477_7)
							end
						end
					end
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.actorSpriteComps1037 then
				for iter_477_2, iter_477_3 in pairs(arg_474_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_477_3 then
						if arg_474_1.isInRecall_ then
							iter_477_3.color = arg_474_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_477_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_474_1.var_.actorSpriteComps1037 = nil
			end

			local var_477_8 = 0
			local var_477_9 = 1

			if var_477_8 < arg_474_1.time_ and arg_474_1.time_ <= var_477_8 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_10 = arg_474_1:FormatText(StoryNameCfg[7].name)

				arg_474_1.leftNameTxt_.text = var_477_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_11 = arg_474_1:GetWordFromCfg(425081115)
				local var_477_12 = arg_474_1:FormatText(var_477_11.content)

				arg_474_1.text_.text = var_477_12

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_13 = 40
				local var_477_14 = utf8.len(var_477_12)
				local var_477_15 = var_477_13 <= 0 and var_477_9 or var_477_9 * (var_477_14 / var_477_13)

				if var_477_15 > 0 and var_477_9 < var_477_15 then
					arg_474_1.talkMaxDuration = var_477_15

					if var_477_15 + var_477_8 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_15 + var_477_8
					end
				end

				arg_474_1.text_.text = var_477_12
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_16 = math.max(var_477_9, arg_474_1.talkMaxDuration)

			if var_477_8 <= arg_474_1.time_ and arg_474_1.time_ < var_477_8 + var_477_16 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_8) / var_477_16

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_8 + var_477_16 and arg_474_1.time_ < var_477_8 + var_477_16 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play425081116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 425081116
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play425081117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 0.975

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[7].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, true)
				arg_478_1.iconController_:SetSelectedState("hero")

				arg_478_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_478_1.callingController_:SetSelectedState("normal")

				arg_478_1.keyicon_.color = Color.New(1, 1, 1)
				arg_478_1.icon_.color = Color.New(1, 1, 1)

				local var_481_3 = arg_478_1:GetWordFromCfg(425081116)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 39
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_8 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_8 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_8

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_8 and arg_478_1.time_ < var_481_0 + var_481_8 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play425081117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 425081117
		arg_482_1.duration_ = 6.13

		local var_482_0 = {
			zh = 4.133,
			ja = 6.133
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play425081118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["1037"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.actorSpriteComps1037 == nil then
				arg_482_1.var_.actorSpriteComps1037 = var_485_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_2 = 0.2

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.actorSpriteComps1037 then
					for iter_485_0, iter_485_1 in pairs(arg_482_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_485_1 then
							if arg_482_1.isInRecall_ then
								local var_485_4 = Mathf.Lerp(iter_485_1.color.r, arg_482_1.hightColor1.r, var_485_3)
								local var_485_5 = Mathf.Lerp(iter_485_1.color.g, arg_482_1.hightColor1.g, var_485_3)
								local var_485_6 = Mathf.Lerp(iter_485_1.color.b, arg_482_1.hightColor1.b, var_485_3)

								iter_485_1.color = Color.New(var_485_4, var_485_5, var_485_6)
							else
								local var_485_7 = Mathf.Lerp(iter_485_1.color.r, 1, var_485_3)

								iter_485_1.color = Color.New(var_485_7, var_485_7, var_485_7)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.actorSpriteComps1037 then
				for iter_485_2, iter_485_3 in pairs(arg_482_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_485_3 then
						if arg_482_1.isInRecall_ then
							iter_485_3.color = arg_482_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_485_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_482_1.var_.actorSpriteComps1037 = nil
			end

			local var_485_8 = 0
			local var_485_9 = 0.5

			if var_485_8 < arg_482_1.time_ and arg_482_1.time_ <= var_485_8 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_10 = arg_482_1:FormatText(StoryNameCfg[15].name)

				arg_482_1.leftNameTxt_.text = var_485_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_11 = arg_482_1:GetWordFromCfg(425081117)
				local var_485_12 = arg_482_1:FormatText(var_485_11.content)

				arg_482_1.text_.text = var_485_12

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_13 = 20
				local var_485_14 = utf8.len(var_485_12)
				local var_485_15 = var_485_13 <= 0 and var_485_9 or var_485_9 * (var_485_14 / var_485_13)

				if var_485_15 > 0 and var_485_9 < var_485_15 then
					arg_482_1.talkMaxDuration = var_485_15

					if var_485_15 + var_485_8 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_15 + var_485_8
					end
				end

				arg_482_1.text_.text = var_485_12
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081117", "story_v_out_425081.awb") ~= 0 then
					local var_485_16 = manager.audio:GetVoiceLength("story_v_out_425081", "425081117", "story_v_out_425081.awb") / 1000

					if var_485_16 + var_485_8 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_16 + var_485_8
					end

					if var_485_11.prefab_name ~= "" and arg_482_1.actors_[var_485_11.prefab_name] ~= nil then
						local var_485_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_11.prefab_name].transform, "story_v_out_425081", "425081117", "story_v_out_425081.awb")

						arg_482_1:RecordAudio("425081117", var_485_17)
						arg_482_1:RecordAudio("425081117", var_485_17)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_425081", "425081117", "story_v_out_425081.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_425081", "425081117", "story_v_out_425081.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_18 = math.max(var_485_9, arg_482_1.talkMaxDuration)

			if var_485_8 <= arg_482_1.time_ and arg_482_1.time_ < var_485_8 + var_485_18 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_8) / var_485_18

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_8 + var_485_18 and arg_482_1.time_ < var_485_8 + var_485_18 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play425081118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 425081118
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play425081119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["1037"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.actorSpriteComps1037 == nil then
				arg_486_1.var_.actorSpriteComps1037 = var_489_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_489_2 = 0.2

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.actorSpriteComps1037 then
					for iter_489_0, iter_489_1 in pairs(arg_486_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_489_1 then
							if arg_486_1.isInRecall_ then
								local var_489_4 = Mathf.Lerp(iter_489_1.color.r, arg_486_1.hightColor2.r, var_489_3)
								local var_489_5 = Mathf.Lerp(iter_489_1.color.g, arg_486_1.hightColor2.g, var_489_3)
								local var_489_6 = Mathf.Lerp(iter_489_1.color.b, arg_486_1.hightColor2.b, var_489_3)

								iter_489_1.color = Color.New(var_489_4, var_489_5, var_489_6)
							else
								local var_489_7 = Mathf.Lerp(iter_489_1.color.r, 0.5, var_489_3)

								iter_489_1.color = Color.New(var_489_7, var_489_7, var_489_7)
							end
						end
					end
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.actorSpriteComps1037 then
				for iter_489_2, iter_489_3 in pairs(arg_486_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_489_3 then
						if arg_486_1.isInRecall_ then
							iter_489_3.color = arg_486_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_489_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_486_1.var_.actorSpriteComps1037 = nil
			end

			local var_489_8 = 0
			local var_489_9 = 0.325

			if var_489_8 < arg_486_1.time_ and arg_486_1.time_ <= var_489_8 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_10 = arg_486_1:FormatText(StoryNameCfg[7].name)

				arg_486_1.leftNameTxt_.text = var_489_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_11 = arg_486_1:GetWordFromCfg(425081118)
				local var_489_12 = arg_486_1:FormatText(var_489_11.content)

				arg_486_1.text_.text = var_489_12

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_13 = 13
				local var_489_14 = utf8.len(var_489_12)
				local var_489_15 = var_489_13 <= 0 and var_489_9 or var_489_9 * (var_489_14 / var_489_13)

				if var_489_15 > 0 and var_489_9 < var_489_15 then
					arg_486_1.talkMaxDuration = var_489_15

					if var_489_15 + var_489_8 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_15 + var_489_8
					end
				end

				arg_486_1.text_.text = var_489_12
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_16 = math.max(var_489_9, arg_486_1.talkMaxDuration)

			if var_489_8 <= arg_486_1.time_ and arg_486_1.time_ < var_489_8 + var_489_16 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_8) / var_489_16

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_8 + var_489_16 and arg_486_1.time_ < var_489_8 + var_489_16 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play425081119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 425081119
		arg_490_1.duration_ = 1.23

		local var_490_0 = {
			zh = 0.999999999999,
			ja = 1.233
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play425081120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["1037"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.actorSpriteComps1037 == nil then
				arg_490_1.var_.actorSpriteComps1037 = var_493_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_493_2 = 0.2

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.actorSpriteComps1037 then
					for iter_493_0, iter_493_1 in pairs(arg_490_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_493_1 then
							if arg_490_1.isInRecall_ then
								local var_493_4 = Mathf.Lerp(iter_493_1.color.r, arg_490_1.hightColor1.r, var_493_3)
								local var_493_5 = Mathf.Lerp(iter_493_1.color.g, arg_490_1.hightColor1.g, var_493_3)
								local var_493_6 = Mathf.Lerp(iter_493_1.color.b, arg_490_1.hightColor1.b, var_493_3)

								iter_493_1.color = Color.New(var_493_4, var_493_5, var_493_6)
							else
								local var_493_7 = Mathf.Lerp(iter_493_1.color.r, 1, var_493_3)

								iter_493_1.color = Color.New(var_493_7, var_493_7, var_493_7)
							end
						end
					end
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.actorSpriteComps1037 then
				for iter_493_2, iter_493_3 in pairs(arg_490_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_493_3 then
						if arg_490_1.isInRecall_ then
							iter_493_3.color = arg_490_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_493_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_490_1.var_.actorSpriteComps1037 = nil
			end

			local var_493_8 = arg_490_1.actors_["1037"].transform
			local var_493_9 = 0

			if var_493_9 < arg_490_1.time_ and arg_490_1.time_ <= var_493_9 + arg_493_0 then
				arg_490_1.var_.moveOldPos1037 = var_493_8.localPosition
				var_493_8.localScale = Vector3.New(1, 1, 1)

				arg_490_1:CheckSpriteTmpPos("1037", 3)

				local var_493_10 = var_493_8.childCount

				for iter_493_4 = 0, var_493_10 - 1 do
					local var_493_11 = var_493_8:GetChild(iter_493_4)

					if var_493_11.name == "split_5" then
						var_493_11:SetAsLastSibling()
						var_493_11.gameObject:SetActive(true)

						arg_490_1.var_.actorSpriteSplit1037 = var_493_11.gameObject:GetComponent(typeof(Image))

						arg_490_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_493_12 = 0.2

			if var_493_9 <= arg_490_1.time_ and arg_490_1.time_ < var_493_9 + var_493_12 then
				local var_493_13 = (arg_490_1.time_ - var_493_9) / var_493_12
				local var_493_14 = Vector3.New(0, -430, -55)

				var_493_8.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos1037, var_493_14, var_493_13)

				if arg_490_1.var_.actorSpriteSplit1037 ~= nil then
					arg_490_1.var_.actorSpriteSplit1037:SetAlpha(var_493_13)
				end
			end

			if arg_490_1.time_ >= var_493_9 + var_493_12 and arg_490_1.time_ < var_493_9 + var_493_12 + arg_493_0 then
				var_493_8.localPosition = Vector3.New(0, -430, -55)

				if arg_490_1.var_.actorSpriteSplit1037 ~= nil then
					arg_490_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_493_15 = 0

			if var_493_15 < arg_490_1.time_ and arg_490_1.time_ <= var_493_15 + arg_493_0 then
				arg_490_1.allBtn_.enabled = false
			end

			local var_493_16 = 0.2

			if arg_490_1.time_ >= var_493_15 + var_493_16 and arg_490_1.time_ < var_493_15 + var_493_16 + arg_493_0 then
				arg_490_1.allBtn_.enabled = true
			end

			local var_493_17 = 0
			local var_493_18 = 0.05

			if var_493_17 < arg_490_1.time_ and arg_490_1.time_ <= var_493_17 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_19 = arg_490_1:FormatText(StoryNameCfg[15].name)

				arg_490_1.leftNameTxt_.text = var_493_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_20 = arg_490_1:GetWordFromCfg(425081119)
				local var_493_21 = arg_490_1:FormatText(var_493_20.content)

				arg_490_1.text_.text = var_493_21

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_22 = 2
				local var_493_23 = utf8.len(var_493_21)
				local var_493_24 = var_493_22 <= 0 and var_493_18 or var_493_18 * (var_493_23 / var_493_22)

				if var_493_24 > 0 and var_493_18 < var_493_24 then
					arg_490_1.talkMaxDuration = var_493_24

					if var_493_24 + var_493_17 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_24 + var_493_17
					end
				end

				arg_490_1.text_.text = var_493_21
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081119", "story_v_out_425081.awb") ~= 0 then
					local var_493_25 = manager.audio:GetVoiceLength("story_v_out_425081", "425081119", "story_v_out_425081.awb") / 1000

					if var_493_25 + var_493_17 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_25 + var_493_17
					end

					if var_493_20.prefab_name ~= "" and arg_490_1.actors_[var_493_20.prefab_name] ~= nil then
						local var_493_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_20.prefab_name].transform, "story_v_out_425081", "425081119", "story_v_out_425081.awb")

						arg_490_1:RecordAudio("425081119", var_493_26)
						arg_490_1:RecordAudio("425081119", var_493_26)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_425081", "425081119", "story_v_out_425081.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_425081", "425081119", "story_v_out_425081.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_27 = math.max(var_493_18, arg_490_1.talkMaxDuration)

			if var_493_17 <= arg_490_1.time_ and arg_490_1.time_ < var_493_17 + var_493_27 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_17) / var_493_27

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_17 + var_493_27 and arg_490_1.time_ < var_493_17 + var_493_27 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
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

		arg_490_1:InitPlayNodeList()
	end,
	Play425081120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 425081120
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play425081121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1037"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.actorSpriteComps1037 == nil then
				arg_494_1.var_.actorSpriteComps1037 = var_497_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_497_2 = 0.2

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.actorSpriteComps1037 then
					for iter_497_0, iter_497_1 in pairs(arg_494_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_497_1 then
							if arg_494_1.isInRecall_ then
								local var_497_4 = Mathf.Lerp(iter_497_1.color.r, arg_494_1.hightColor2.r, var_497_3)
								local var_497_5 = Mathf.Lerp(iter_497_1.color.g, arg_494_1.hightColor2.g, var_497_3)
								local var_497_6 = Mathf.Lerp(iter_497_1.color.b, arg_494_1.hightColor2.b, var_497_3)

								iter_497_1.color = Color.New(var_497_4, var_497_5, var_497_6)
							else
								local var_497_7 = Mathf.Lerp(iter_497_1.color.r, 0.5, var_497_3)

								iter_497_1.color = Color.New(var_497_7, var_497_7, var_497_7)
							end
						end
					end
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.actorSpriteComps1037 then
				for iter_497_2, iter_497_3 in pairs(arg_494_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_497_3 then
						if arg_494_1.isInRecall_ then
							iter_497_3.color = arg_494_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_497_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_494_1.var_.actorSpriteComps1037 = nil
			end

			local var_497_8 = 0
			local var_497_9 = 0.35

			if var_497_8 < arg_494_1.time_ and arg_494_1.time_ <= var_497_8 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_10 = arg_494_1:FormatText(StoryNameCfg[7].name)

				arg_494_1.leftNameTxt_.text = var_497_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_11 = arg_494_1:GetWordFromCfg(425081120)
				local var_497_12 = arg_494_1:FormatText(var_497_11.content)

				arg_494_1.text_.text = var_497_12

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_13 = 14
				local var_497_14 = utf8.len(var_497_12)
				local var_497_15 = var_497_13 <= 0 and var_497_9 or var_497_9 * (var_497_14 / var_497_13)

				if var_497_15 > 0 and var_497_9 < var_497_15 then
					arg_494_1.talkMaxDuration = var_497_15

					if var_497_15 + var_497_8 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_15 + var_497_8
					end
				end

				arg_494_1.text_.text = var_497_12
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_16 = math.max(var_497_9, arg_494_1.talkMaxDuration)

			if var_497_8 <= arg_494_1.time_ and arg_494_1.time_ < var_497_8 + var_497_16 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_8) / var_497_16

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_8 + var_497_16 and arg_494_1.time_ < var_497_8 + var_497_16 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play425081121 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 425081121
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play425081122(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0
			local var_501_1 = 0.9

			if var_501_0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_2 = arg_498_1:FormatText(StoryNameCfg[7].name)

				arg_498_1.leftNameTxt_.text = var_501_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, true)
				arg_498_1.iconController_:SetSelectedState("hero")

				arg_498_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_498_1.callingController_:SetSelectedState("normal")

				arg_498_1.keyicon_.color = Color.New(1, 1, 1)
				arg_498_1.icon_.color = Color.New(1, 1, 1)

				local var_501_3 = arg_498_1:GetWordFromCfg(425081121)
				local var_501_4 = arg_498_1:FormatText(var_501_3.content)

				arg_498_1.text_.text = var_501_4

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_5 = 36
				local var_501_6 = utf8.len(var_501_4)
				local var_501_7 = var_501_5 <= 0 and var_501_1 or var_501_1 * (var_501_6 / var_501_5)

				if var_501_7 > 0 and var_501_1 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_0
					end
				end

				arg_498_1.text_.text = var_501_4
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_8 = math.max(var_501_1, arg_498_1.talkMaxDuration)

			if var_501_0 <= arg_498_1.time_ and arg_498_1.time_ < var_501_0 + var_501_8 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_0) / var_501_8

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_0 + var_501_8 and arg_498_1.time_ < var_501_0 + var_501_8 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play425081122 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 425081122
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play425081123(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 0.725

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_2 = arg_502_1:FormatText(StoryNameCfg[7].name)

				arg_502_1.leftNameTxt_.text = var_505_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, true)
				arg_502_1.iconController_:SetSelectedState("hero")

				arg_502_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_502_1.callingController_:SetSelectedState("normal")

				arg_502_1.keyicon_.color = Color.New(1, 1, 1)
				arg_502_1.icon_.color = Color.New(1, 1, 1)

				local var_505_3 = arg_502_1:GetWordFromCfg(425081122)
				local var_505_4 = arg_502_1:FormatText(var_505_3.content)

				arg_502_1.text_.text = var_505_4

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 29
				local var_505_6 = utf8.len(var_505_4)
				local var_505_7 = var_505_5 <= 0 and var_505_1 or var_505_1 * (var_505_6 / var_505_5)

				if var_505_7 > 0 and var_505_1 < var_505_7 then
					arg_502_1.talkMaxDuration = var_505_7

					if var_505_7 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_7 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_4
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_8 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_8 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_8

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_8 and arg_502_1.time_ < var_505_0 + var_505_8 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play425081123 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 425081123
		arg_506_1.duration_ = 4.93

		local var_506_0 = {
			zh = 3.333,
			ja = 4.933
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play425081124(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["1037"]
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.actorSpriteComps1037 == nil then
				arg_506_1.var_.actorSpriteComps1037 = var_509_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_509_2 = 0.2

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 and not isNil(var_509_0) then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2

				if arg_506_1.var_.actorSpriteComps1037 then
					for iter_509_0, iter_509_1 in pairs(arg_506_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_509_1 then
							if arg_506_1.isInRecall_ then
								local var_509_4 = Mathf.Lerp(iter_509_1.color.r, arg_506_1.hightColor1.r, var_509_3)
								local var_509_5 = Mathf.Lerp(iter_509_1.color.g, arg_506_1.hightColor1.g, var_509_3)
								local var_509_6 = Mathf.Lerp(iter_509_1.color.b, arg_506_1.hightColor1.b, var_509_3)

								iter_509_1.color = Color.New(var_509_4, var_509_5, var_509_6)
							else
								local var_509_7 = Mathf.Lerp(iter_509_1.color.r, 1, var_509_3)

								iter_509_1.color = Color.New(var_509_7, var_509_7, var_509_7)
							end
						end
					end
				end
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.actorSpriteComps1037 then
				for iter_509_2, iter_509_3 in pairs(arg_506_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_509_3 then
						if arg_506_1.isInRecall_ then
							iter_509_3.color = arg_506_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_509_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_506_1.var_.actorSpriteComps1037 = nil
			end

			local var_509_8 = arg_506_1.actors_["1037"].transform
			local var_509_9 = 0

			if var_509_9 < arg_506_1.time_ and arg_506_1.time_ <= var_509_9 + arg_509_0 then
				arg_506_1.var_.moveOldPos1037 = var_509_8.localPosition
				var_509_8.localScale = Vector3.New(1, 1, 1)

				arg_506_1:CheckSpriteTmpPos("1037", 3)

				local var_509_10 = var_509_8.childCount

				for iter_509_4 = 0, var_509_10 - 1 do
					local var_509_11 = var_509_8:GetChild(iter_509_4)

					if var_509_11.name == "split_5" or not string.find(var_509_11.name, "split") then
						var_509_11.gameObject:SetActive(true)
					else
						var_509_11.gameObject:SetActive(false)
					end
				end
			end

			local var_509_12 = 0.001

			if var_509_9 <= arg_506_1.time_ and arg_506_1.time_ < var_509_9 + var_509_12 then
				local var_509_13 = (arg_506_1.time_ - var_509_9) / var_509_12
				local var_509_14 = Vector3.New(0, -430, -55)

				var_509_8.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1037, var_509_14, var_509_13)
			end

			if arg_506_1.time_ >= var_509_9 + var_509_12 and arg_506_1.time_ < var_509_9 + var_509_12 + arg_509_0 then
				var_509_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_509_15 = 0
			local var_509_16 = 0.325

			if var_509_15 < arg_506_1.time_ and arg_506_1.time_ <= var_509_15 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_17 = arg_506_1:FormatText(StoryNameCfg[15].name)

				arg_506_1.leftNameTxt_.text = var_509_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_18 = arg_506_1:GetWordFromCfg(425081123)
				local var_509_19 = arg_506_1:FormatText(var_509_18.content)

				arg_506_1.text_.text = var_509_19

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_20 = 13
				local var_509_21 = utf8.len(var_509_19)
				local var_509_22 = var_509_20 <= 0 and var_509_16 or var_509_16 * (var_509_21 / var_509_20)

				if var_509_22 > 0 and var_509_16 < var_509_22 then
					arg_506_1.talkMaxDuration = var_509_22

					if var_509_22 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_22 + var_509_15
					end
				end

				arg_506_1.text_.text = var_509_19
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081123", "story_v_out_425081.awb") ~= 0 then
					local var_509_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081123", "story_v_out_425081.awb") / 1000

					if var_509_23 + var_509_15 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_23 + var_509_15
					end

					if var_509_18.prefab_name ~= "" and arg_506_1.actors_[var_509_18.prefab_name] ~= nil then
						local var_509_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_18.prefab_name].transform, "story_v_out_425081", "425081123", "story_v_out_425081.awb")

						arg_506_1:RecordAudio("425081123", var_509_24)
						arg_506_1:RecordAudio("425081123", var_509_24)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_425081", "425081123", "story_v_out_425081.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_425081", "425081123", "story_v_out_425081.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_25 = math.max(var_509_16, arg_506_1.talkMaxDuration)

			if var_509_15 <= arg_506_1.time_ and arg_506_1.time_ < var_509_15 + var_509_25 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_15) / var_509_25

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_15 + var_509_25 and arg_506_1.time_ < var_509_15 + var_509_25 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
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

		arg_506_1:InitPlayNodeList()
	end,
	Play425081124 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 425081124
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play425081125(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1037"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.actorSpriteComps1037 == nil then
				arg_510_1.var_.actorSpriteComps1037 = var_513_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_513_2 = 0.2

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.actorSpriteComps1037 then
					for iter_513_0, iter_513_1 in pairs(arg_510_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_513_1 then
							if arg_510_1.isInRecall_ then
								local var_513_4 = Mathf.Lerp(iter_513_1.color.r, arg_510_1.hightColor2.r, var_513_3)
								local var_513_5 = Mathf.Lerp(iter_513_1.color.g, arg_510_1.hightColor2.g, var_513_3)
								local var_513_6 = Mathf.Lerp(iter_513_1.color.b, arg_510_1.hightColor2.b, var_513_3)

								iter_513_1.color = Color.New(var_513_4, var_513_5, var_513_6)
							else
								local var_513_7 = Mathf.Lerp(iter_513_1.color.r, 0.5, var_513_3)

								iter_513_1.color = Color.New(var_513_7, var_513_7, var_513_7)
							end
						end
					end
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.actorSpriteComps1037 then
				for iter_513_2, iter_513_3 in pairs(arg_510_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_513_3 then
						if arg_510_1.isInRecall_ then
							iter_513_3.color = arg_510_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_513_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_510_1.var_.actorSpriteComps1037 = nil
			end

			local var_513_8 = 0
			local var_513_9 = 1.3

			if var_513_8 < arg_510_1.time_ and arg_510_1.time_ <= var_513_8 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_10 = arg_510_1:FormatText(StoryNameCfg[7].name)

				arg_510_1.leftNameTxt_.text = var_513_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_11 = arg_510_1:GetWordFromCfg(425081124)
				local var_513_12 = arg_510_1:FormatText(var_513_11.content)

				arg_510_1.text_.text = var_513_12

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_13 = 52
				local var_513_14 = utf8.len(var_513_12)
				local var_513_15 = var_513_13 <= 0 and var_513_9 or var_513_9 * (var_513_14 / var_513_13)

				if var_513_15 > 0 and var_513_9 < var_513_15 then
					arg_510_1.talkMaxDuration = var_513_15

					if var_513_15 + var_513_8 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_15 + var_513_8
					end
				end

				arg_510_1.text_.text = var_513_12
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_16 = math.max(var_513_9, arg_510_1.talkMaxDuration)

			if var_513_8 <= arg_510_1.time_ and arg_510_1.time_ < var_513_8 + var_513_16 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_8) / var_513_16

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_8 + var_513_16 and arg_510_1.time_ < var_513_8 + var_513_16 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play425081125 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 425081125
		arg_514_1.duration_ = 7

		local var_514_0 = {
			zh = 3.5,
			ja = 7
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play425081126(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1037"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.actorSpriteComps1037 == nil then
				arg_514_1.var_.actorSpriteComps1037 = var_517_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_517_2 = 0.2

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.actorSpriteComps1037 then
					for iter_517_0, iter_517_1 in pairs(arg_514_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_517_1 then
							if arg_514_1.isInRecall_ then
								local var_517_4 = Mathf.Lerp(iter_517_1.color.r, arg_514_1.hightColor1.r, var_517_3)
								local var_517_5 = Mathf.Lerp(iter_517_1.color.g, arg_514_1.hightColor1.g, var_517_3)
								local var_517_6 = Mathf.Lerp(iter_517_1.color.b, arg_514_1.hightColor1.b, var_517_3)

								iter_517_1.color = Color.New(var_517_4, var_517_5, var_517_6)
							else
								local var_517_7 = Mathf.Lerp(iter_517_1.color.r, 1, var_517_3)

								iter_517_1.color = Color.New(var_517_7, var_517_7, var_517_7)
							end
						end
					end
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.actorSpriteComps1037 then
				for iter_517_2, iter_517_3 in pairs(arg_514_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_517_3 then
						if arg_514_1.isInRecall_ then
							iter_517_3.color = arg_514_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_517_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_514_1.var_.actorSpriteComps1037 = nil
			end

			local var_517_8 = arg_514_1.actors_["1037"].transform
			local var_517_9 = 0

			if var_517_9 < arg_514_1.time_ and arg_514_1.time_ <= var_517_9 + arg_517_0 then
				arg_514_1.var_.moveOldPos1037 = var_517_8.localPosition
				var_517_8.localScale = Vector3.New(1, 1, 1)

				arg_514_1:CheckSpriteTmpPos("1037", 3)

				local var_517_10 = var_517_8.childCount

				for iter_517_4 = 0, var_517_10 - 1 do
					local var_517_11 = var_517_8:GetChild(iter_517_4)

					if var_517_11.name == "split_1" then
						var_517_11:SetAsLastSibling()
						var_517_11.gameObject:SetActive(true)

						arg_514_1.var_.actorSpriteSplit1037 = var_517_11.gameObject:GetComponent(typeof(Image))

						arg_514_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_517_12 = 0.5

			if var_517_9 <= arg_514_1.time_ and arg_514_1.time_ < var_517_9 + var_517_12 then
				local var_517_13 = (arg_514_1.time_ - var_517_9) / var_517_12
				local var_517_14 = Vector3.New(0, -430, -55)

				var_517_8.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1037, var_517_14, var_517_13)

				if arg_514_1.var_.actorSpriteSplit1037 ~= nil then
					arg_514_1.var_.actorSpriteSplit1037:SetAlpha(var_517_13)
				end
			end

			if arg_514_1.time_ >= var_517_9 + var_517_12 and arg_514_1.time_ < var_517_9 + var_517_12 + arg_517_0 then
				var_517_8.localPosition = Vector3.New(0, -430, -55)

				if arg_514_1.var_.actorSpriteSplit1037 ~= nil then
					arg_514_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_517_15 = 0

			if var_517_15 < arg_514_1.time_ and arg_514_1.time_ <= var_517_15 + arg_517_0 then
				arg_514_1.allBtn_.enabled = false
			end

			local var_517_16 = 0.47968719759956

			if arg_514_1.time_ >= var_517_15 + var_517_16 and arg_514_1.time_ < var_517_15 + var_517_16 + arg_517_0 then
				arg_514_1.allBtn_.enabled = true
			end

			local var_517_17 = 0
			local var_517_18 = 0.2

			if var_517_17 < arg_514_1.time_ and arg_514_1.time_ <= var_517_17 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_19 = arg_514_1:FormatText(StoryNameCfg[15].name)

				arg_514_1.leftNameTxt_.text = var_517_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_20 = arg_514_1:GetWordFromCfg(425081125)
				local var_517_21 = arg_514_1:FormatText(var_517_20.content)

				arg_514_1.text_.text = var_517_21

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_22 = 8
				local var_517_23 = utf8.len(var_517_21)
				local var_517_24 = var_517_22 <= 0 and var_517_18 or var_517_18 * (var_517_23 / var_517_22)

				if var_517_24 > 0 and var_517_18 < var_517_24 then
					arg_514_1.talkMaxDuration = var_517_24

					if var_517_24 + var_517_17 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_24 + var_517_17
					end
				end

				arg_514_1.text_.text = var_517_21
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081125", "story_v_out_425081.awb") ~= 0 then
					local var_517_25 = manager.audio:GetVoiceLength("story_v_out_425081", "425081125", "story_v_out_425081.awb") / 1000

					if var_517_25 + var_517_17 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_25 + var_517_17
					end

					if var_517_20.prefab_name ~= "" and arg_514_1.actors_[var_517_20.prefab_name] ~= nil then
						local var_517_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_20.prefab_name].transform, "story_v_out_425081", "425081125", "story_v_out_425081.awb")

						arg_514_1:RecordAudio("425081125", var_517_26)
						arg_514_1:RecordAudio("425081125", var_517_26)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_425081", "425081125", "story_v_out_425081.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_425081", "425081125", "story_v_out_425081.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_27 = math.max(var_517_18, arg_514_1.talkMaxDuration)

			if var_517_17 <= arg_514_1.time_ and arg_514_1.time_ < var_517_17 + var_517_27 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_17) / var_517_27

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_17 + var_517_27 and arg_514_1.time_ < var_517_17 + var_517_27 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
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

		arg_514_1:InitPlayNodeList()
	end,
	Play425081126 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 425081126
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play425081127(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["1037"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.actorSpriteComps1037 == nil then
				arg_518_1.var_.actorSpriteComps1037 = var_521_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_2 = 0.2

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.actorSpriteComps1037 then
					for iter_521_0, iter_521_1 in pairs(arg_518_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_521_1 then
							if arg_518_1.isInRecall_ then
								local var_521_4 = Mathf.Lerp(iter_521_1.color.r, arg_518_1.hightColor2.r, var_521_3)
								local var_521_5 = Mathf.Lerp(iter_521_1.color.g, arg_518_1.hightColor2.g, var_521_3)
								local var_521_6 = Mathf.Lerp(iter_521_1.color.b, arg_518_1.hightColor2.b, var_521_3)

								iter_521_1.color = Color.New(var_521_4, var_521_5, var_521_6)
							else
								local var_521_7 = Mathf.Lerp(iter_521_1.color.r, 0.5, var_521_3)

								iter_521_1.color = Color.New(var_521_7, var_521_7, var_521_7)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.actorSpriteComps1037 then
				for iter_521_2, iter_521_3 in pairs(arg_518_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_521_3 then
						if arg_518_1.isInRecall_ then
							iter_521_3.color = arg_518_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_521_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_518_1.var_.actorSpriteComps1037 = nil
			end

			local var_521_8 = 0
			local var_521_9 = 0.625

			if var_521_8 < arg_518_1.time_ and arg_518_1.time_ <= var_521_8 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_10 = arg_518_1:FormatText(StoryNameCfg[7].name)

				arg_518_1.leftNameTxt_.text = var_521_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_11 = arg_518_1:GetWordFromCfg(425081126)
				local var_521_12 = arg_518_1:FormatText(var_521_11.content)

				arg_518_1.text_.text = var_521_12

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_13 = 25
				local var_521_14 = utf8.len(var_521_12)
				local var_521_15 = var_521_13 <= 0 and var_521_9 or var_521_9 * (var_521_14 / var_521_13)

				if var_521_15 > 0 and var_521_9 < var_521_15 then
					arg_518_1.talkMaxDuration = var_521_15

					if var_521_15 + var_521_8 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_15 + var_521_8
					end
				end

				arg_518_1.text_.text = var_521_12
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_16 = math.max(var_521_9, arg_518_1.talkMaxDuration)

			if var_521_8 <= arg_518_1.time_ and arg_518_1.time_ < var_521_8 + var_521_16 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_8) / var_521_16

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_8 + var_521_16 and arg_518_1.time_ < var_521_8 + var_521_16 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play425081127 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 425081127
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play425081128(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["1037"].transform
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 then
				arg_522_1.var_.moveOldPos1037 = var_525_0.localPosition
				var_525_0.localScale = Vector3.New(1, 1, 1)

				arg_522_1:CheckSpriteTmpPos("1037", 7)

				local var_525_2 = var_525_0.childCount

				for iter_525_0 = 0, var_525_2 - 1 do
					local var_525_3 = var_525_0:GetChild(iter_525_0)

					if var_525_3.name == "" or not string.find(var_525_3.name, "split") then
						var_525_3.gameObject:SetActive(true)
					else
						var_525_3.gameObject:SetActive(false)
					end
				end
			end

			local var_525_4 = 0.001

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_4 then
				local var_525_5 = (arg_522_1.time_ - var_525_1) / var_525_4
				local var_525_6 = Vector3.New(1500, -2000, 0)

				var_525_0.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1037, var_525_6, var_525_5)
			end

			if arg_522_1.time_ >= var_525_1 + var_525_4 and arg_522_1.time_ < var_525_1 + var_525_4 + arg_525_0 then
				var_525_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_525_7 = 0.133333333333333
			local var_525_8 = 1

			if var_525_7 < arg_522_1.time_ and arg_522_1.time_ <= var_525_7 + arg_525_0 then
				local var_525_9 = "play"
				local var_525_10 = "effect"

				arg_522_1:AudioAction(var_525_9, var_525_10, "se_story_147", "se_story_147_foley_cloth", "")
			end

			local var_525_11 = 0
			local var_525_12 = 1

			if var_525_11 < arg_522_1.time_ and arg_522_1.time_ <= var_525_11 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_13 = arg_522_1:GetWordFromCfg(425081127)
				local var_525_14 = arg_522_1:FormatText(var_525_13.content)

				arg_522_1.text_.text = var_525_14

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_15 = 40
				local var_525_16 = utf8.len(var_525_14)
				local var_525_17 = var_525_15 <= 0 and var_525_12 or var_525_12 * (var_525_16 / var_525_15)

				if var_525_17 > 0 and var_525_12 < var_525_17 then
					arg_522_1.talkMaxDuration = var_525_17

					if var_525_17 + var_525_11 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_17 + var_525_11
					end
				end

				arg_522_1.text_.text = var_525_14
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_18 = math.max(var_525_12, arg_522_1.talkMaxDuration)

			if var_525_11 <= arg_522_1.time_ and arg_522_1.time_ < var_525_11 + var_525_18 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_11) / var_525_18

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_11 + var_525_18 and arg_522_1.time_ < var_525_11 + var_525_18 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
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

		arg_522_1:InitPlayNodeList()
	end,
	Play425081128 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 425081128
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play425081129(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 0
			local var_529_1 = 0.25

			if var_529_0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_2 = arg_526_1:FormatText(StoryNameCfg[7].name)

				arg_526_1.leftNameTxt_.text = var_529_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_3 = arg_526_1:GetWordFromCfg(425081128)
				local var_529_4 = arg_526_1:FormatText(var_529_3.content)

				arg_526_1.text_.text = var_529_4

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_5 = 10
				local var_529_6 = utf8.len(var_529_4)
				local var_529_7 = var_529_5 <= 0 and var_529_1 or var_529_1 * (var_529_6 / var_529_5)

				if var_529_7 > 0 and var_529_1 < var_529_7 then
					arg_526_1.talkMaxDuration = var_529_7

					if var_529_7 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_7 + var_529_0
					end
				end

				arg_526_1.text_.text = var_529_4
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_8 = math.max(var_529_1, arg_526_1.talkMaxDuration)

			if var_529_0 <= arg_526_1.time_ and arg_526_1.time_ < var_529_0 + var_529_8 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_0) / var_529_8

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_0 + var_529_8 and arg_526_1.time_ < var_529_0 + var_529_8 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play425081129 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 425081129
		arg_530_1.duration_ = 10.73

		local var_530_0 = {
			zh = 7.3,
			ja = 10.733
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play425081130(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1037"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.actorSpriteComps1037 == nil then
				arg_530_1.var_.actorSpriteComps1037 = var_533_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_533_2 = 0.2

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.actorSpriteComps1037 then
					for iter_533_0, iter_533_1 in pairs(arg_530_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_533_1 then
							if arg_530_1.isInRecall_ then
								local var_533_4 = Mathf.Lerp(iter_533_1.color.r, arg_530_1.hightColor1.r, var_533_3)
								local var_533_5 = Mathf.Lerp(iter_533_1.color.g, arg_530_1.hightColor1.g, var_533_3)
								local var_533_6 = Mathf.Lerp(iter_533_1.color.b, arg_530_1.hightColor1.b, var_533_3)

								iter_533_1.color = Color.New(var_533_4, var_533_5, var_533_6)
							else
								local var_533_7 = Mathf.Lerp(iter_533_1.color.r, 1, var_533_3)

								iter_533_1.color = Color.New(var_533_7, var_533_7, var_533_7)
							end
						end
					end
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.actorSpriteComps1037 then
				for iter_533_2, iter_533_3 in pairs(arg_530_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_533_3 then
						if arg_530_1.isInRecall_ then
							iter_533_3.color = arg_530_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_533_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_530_1.var_.actorSpriteComps1037 = nil
			end

			local var_533_8 = arg_530_1.actors_["1037"].transform
			local var_533_9 = 0

			if var_533_9 < arg_530_1.time_ and arg_530_1.time_ <= var_533_9 + arg_533_0 then
				arg_530_1.var_.moveOldPos1037 = var_533_8.localPosition
				var_533_8.localScale = Vector3.New(1, 1, 1)

				arg_530_1:CheckSpriteTmpPos("1037", 3)

				local var_533_10 = var_533_8.childCount

				for iter_533_4 = 0, var_533_10 - 1 do
					local var_533_11 = var_533_8:GetChild(iter_533_4)

					if var_533_11.name == "" or not string.find(var_533_11.name, "split") then
						var_533_11.gameObject:SetActive(true)
					else
						var_533_11.gameObject:SetActive(false)
					end
				end
			end

			local var_533_12 = 0.001

			if var_533_9 <= arg_530_1.time_ and arg_530_1.time_ < var_533_9 + var_533_12 then
				local var_533_13 = (arg_530_1.time_ - var_533_9) / var_533_12
				local var_533_14 = Vector3.New(0, -430, -55)

				var_533_8.localPosition = Vector3.Lerp(arg_530_1.var_.moveOldPos1037, var_533_14, var_533_13)
			end

			if arg_530_1.time_ >= var_533_9 + var_533_12 and arg_530_1.time_ < var_533_9 + var_533_12 + arg_533_0 then
				var_533_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_533_15 = 0
			local var_533_16 = 0.675

			if var_533_15 < arg_530_1.time_ and arg_530_1.time_ <= var_533_15 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_17 = arg_530_1:FormatText(StoryNameCfg[15].name)

				arg_530_1.leftNameTxt_.text = var_533_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_18 = arg_530_1:GetWordFromCfg(425081129)
				local var_533_19 = arg_530_1:FormatText(var_533_18.content)

				arg_530_1.text_.text = var_533_19

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_20 = 27
				local var_533_21 = utf8.len(var_533_19)
				local var_533_22 = var_533_20 <= 0 and var_533_16 or var_533_16 * (var_533_21 / var_533_20)

				if var_533_22 > 0 and var_533_16 < var_533_22 then
					arg_530_1.talkMaxDuration = var_533_22

					if var_533_22 + var_533_15 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_22 + var_533_15
					end
				end

				arg_530_1.text_.text = var_533_19
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081129", "story_v_out_425081.awb") ~= 0 then
					local var_533_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081129", "story_v_out_425081.awb") / 1000

					if var_533_23 + var_533_15 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_23 + var_533_15
					end

					if var_533_18.prefab_name ~= "" and arg_530_1.actors_[var_533_18.prefab_name] ~= nil then
						local var_533_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_18.prefab_name].transform, "story_v_out_425081", "425081129", "story_v_out_425081.awb")

						arg_530_1:RecordAudio("425081129", var_533_24)
						arg_530_1:RecordAudio("425081129", var_533_24)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_425081", "425081129", "story_v_out_425081.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_425081", "425081129", "story_v_out_425081.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_25 = math.max(var_533_16, arg_530_1.talkMaxDuration)

			if var_533_15 <= arg_530_1.time_ and arg_530_1.time_ < var_533_15 + var_533_25 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_15) / var_533_25

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_15 + var_533_25 and arg_530_1.time_ < var_533_15 + var_533_25 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {
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

		arg_530_1:InitPlayNodeList()
	end,
	Play425081130 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 425081130
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play425081131(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = arg_534_1.actors_["1037"]
			local var_537_1 = 0

			if var_537_1 < arg_534_1.time_ and arg_534_1.time_ <= var_537_1 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.actorSpriteComps1037 == nil then
				arg_534_1.var_.actorSpriteComps1037 = var_537_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_537_2 = 0.2

			if var_537_1 <= arg_534_1.time_ and arg_534_1.time_ < var_537_1 + var_537_2 and not isNil(var_537_0) then
				local var_537_3 = (arg_534_1.time_ - var_537_1) / var_537_2

				if arg_534_1.var_.actorSpriteComps1037 then
					for iter_537_0, iter_537_1 in pairs(arg_534_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_537_1 then
							if arg_534_1.isInRecall_ then
								local var_537_4 = Mathf.Lerp(iter_537_1.color.r, arg_534_1.hightColor2.r, var_537_3)
								local var_537_5 = Mathf.Lerp(iter_537_1.color.g, arg_534_1.hightColor2.g, var_537_3)
								local var_537_6 = Mathf.Lerp(iter_537_1.color.b, arg_534_1.hightColor2.b, var_537_3)

								iter_537_1.color = Color.New(var_537_4, var_537_5, var_537_6)
							else
								local var_537_7 = Mathf.Lerp(iter_537_1.color.r, 0.5, var_537_3)

								iter_537_1.color = Color.New(var_537_7, var_537_7, var_537_7)
							end
						end
					end
				end
			end

			if arg_534_1.time_ >= var_537_1 + var_537_2 and arg_534_1.time_ < var_537_1 + var_537_2 + arg_537_0 and not isNil(var_537_0) and arg_534_1.var_.actorSpriteComps1037 then
				for iter_537_2, iter_537_3 in pairs(arg_534_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_537_3 then
						if arg_534_1.isInRecall_ then
							iter_537_3.color = arg_534_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_537_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_534_1.var_.actorSpriteComps1037 = nil
			end

			local var_537_8 = 0
			local var_537_9 = 0.425

			if var_537_8 < arg_534_1.time_ and arg_534_1.time_ <= var_537_8 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_10 = arg_534_1:FormatText(StoryNameCfg[7].name)

				arg_534_1.leftNameTxt_.text = var_537_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_11 = arg_534_1:GetWordFromCfg(425081130)
				local var_537_12 = arg_534_1:FormatText(var_537_11.content)

				arg_534_1.text_.text = var_537_12

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_13 = 17
				local var_537_14 = utf8.len(var_537_12)
				local var_537_15 = var_537_13 <= 0 and var_537_9 or var_537_9 * (var_537_14 / var_537_13)

				if var_537_15 > 0 and var_537_9 < var_537_15 then
					arg_534_1.talkMaxDuration = var_537_15

					if var_537_15 + var_537_8 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_15 + var_537_8
					end
				end

				arg_534_1.text_.text = var_537_12
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_16 = math.max(var_537_9, arg_534_1.talkMaxDuration)

			if var_537_8 <= arg_534_1.time_ and arg_534_1.time_ < var_537_8 + var_537_16 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_8) / var_537_16

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_8 + var_537_16 and arg_534_1.time_ < var_537_8 + var_537_16 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play425081131 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 425081131
		arg_538_1.duration_ = 4.77

		local var_538_0 = {
			zh = 4.466,
			ja = 4.766
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
			arg_538_1.auto_ = false
		end

		function arg_538_1.playNext_(arg_540_0)
			arg_538_1.onStoryFinished_()
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["1037"]
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.actorSpriteComps1037 == nil then
				arg_538_1.var_.actorSpriteComps1037 = var_541_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_541_2 = 0.2

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 and not isNil(var_541_0) then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2

				if arg_538_1.var_.actorSpriteComps1037 then
					for iter_541_0, iter_541_1 in pairs(arg_538_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_541_1 then
							if arg_538_1.isInRecall_ then
								local var_541_4 = Mathf.Lerp(iter_541_1.color.r, arg_538_1.hightColor1.r, var_541_3)
								local var_541_5 = Mathf.Lerp(iter_541_1.color.g, arg_538_1.hightColor1.g, var_541_3)
								local var_541_6 = Mathf.Lerp(iter_541_1.color.b, arg_538_1.hightColor1.b, var_541_3)

								iter_541_1.color = Color.New(var_541_4, var_541_5, var_541_6)
							else
								local var_541_7 = Mathf.Lerp(iter_541_1.color.r, 1, var_541_3)

								iter_541_1.color = Color.New(var_541_7, var_541_7, var_541_7)
							end
						end
					end
				end
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.actorSpriteComps1037 then
				for iter_541_2, iter_541_3 in pairs(arg_538_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_541_3 then
						if arg_538_1.isInRecall_ then
							iter_541_3.color = arg_538_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_541_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_538_1.var_.actorSpriteComps1037 = nil
			end

			local var_541_8 = arg_538_1.actors_["1037"].transform
			local var_541_9 = 0

			if var_541_9 < arg_538_1.time_ and arg_538_1.time_ <= var_541_9 + arg_541_0 then
				arg_538_1.var_.moveOldPos1037 = var_541_8.localPosition
				var_541_8.localScale = Vector3.New(1, 1, 1)

				arg_538_1:CheckSpriteTmpPos("1037", 3)

				local var_541_10 = var_541_8.childCount

				for iter_541_4 = 0, var_541_10 - 1 do
					local var_541_11 = var_541_8:GetChild(iter_541_4)

					if var_541_11.name == "" or not string.find(var_541_11.name, "split") then
						var_541_11.gameObject:SetActive(true)
					else
						var_541_11.gameObject:SetActive(false)
					end
				end
			end

			local var_541_12 = 0.001

			if var_541_9 <= arg_538_1.time_ and arg_538_1.time_ < var_541_9 + var_541_12 then
				local var_541_13 = (arg_538_1.time_ - var_541_9) / var_541_12
				local var_541_14 = Vector3.New(0, -430, -55)

				var_541_8.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1037, var_541_14, var_541_13)
			end

			if arg_538_1.time_ >= var_541_9 + var_541_12 and arg_538_1.time_ < var_541_9 + var_541_12 + arg_541_0 then
				var_541_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_541_15 = 0
			local var_541_16 = 0.4

			if var_541_15 < arg_538_1.time_ and arg_538_1.time_ <= var_541_15 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_17 = arg_538_1:FormatText(StoryNameCfg[15].name)

				arg_538_1.leftNameTxt_.text = var_541_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_18 = arg_538_1:GetWordFromCfg(425081131)
				local var_541_19 = arg_538_1:FormatText(var_541_18.content)

				arg_538_1.text_.text = var_541_19

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_20 = 16
				local var_541_21 = utf8.len(var_541_19)
				local var_541_22 = var_541_20 <= 0 and var_541_16 or var_541_16 * (var_541_21 / var_541_20)

				if var_541_22 > 0 and var_541_16 < var_541_22 then
					arg_538_1.talkMaxDuration = var_541_22

					if var_541_22 + var_541_15 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_22 + var_541_15
					end
				end

				arg_538_1.text_.text = var_541_19
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425081", "425081131", "story_v_out_425081.awb") ~= 0 then
					local var_541_23 = manager.audio:GetVoiceLength("story_v_out_425081", "425081131", "story_v_out_425081.awb") / 1000

					if var_541_23 + var_541_15 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_23 + var_541_15
					end

					if var_541_18.prefab_name ~= "" and arg_538_1.actors_[var_541_18.prefab_name] ~= nil then
						local var_541_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_18.prefab_name].transform, "story_v_out_425081", "425081131", "story_v_out_425081.awb")

						arg_538_1:RecordAudio("425081131", var_541_24)
						arg_538_1:RecordAudio("425081131", var_541_24)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_425081", "425081131", "story_v_out_425081.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_425081", "425081131", "story_v_out_425081.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_25 = math.max(var_541_16, arg_538_1.talkMaxDuration)

			if var_541_15 <= arg_538_1.time_ and arg_538_1.time_ < var_541_15 + var_541_25 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_15) / var_541_25

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_15 + var_541_25 and arg_538_1.time_ < var_541_15 + var_541_25 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
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

		arg_538_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0404",
		"TextureConfig/Background/M01h",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/D02b",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_425081.awb"
	}
}
