return {
	Play425071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425071001
		arg_1_1.duration_ = 13.9

		local var_1_0 = {
			zh = 13.9,
			ja = 13.3
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
				arg_1_0:Play425071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 4.4

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.833333333333335

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "1066"

			if arg_1_1.actors_[var_4_2] == nil then
				local var_4_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1066")

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

			local var_4_6 = arg_1_1.actors_["1066"]
			local var_4_7 = 4.2

			if var_4_7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 and not isNil(var_4_6) and arg_1_1.var_.actorSpriteComps1066 == nil then
				arg_1_1.var_.actorSpriteComps1066 = var_4_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_8 = 0.2

			if var_4_7 <= arg_1_1.time_ and arg_1_1.time_ < var_4_7 + var_4_8 and not isNil(var_4_6) then
				local var_4_9 = (arg_1_1.time_ - var_4_7) / var_4_8

				if arg_1_1.var_.actorSpriteComps1066 then
					for iter_4_2, iter_4_3 in pairs(arg_1_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_1_1.time_ >= var_4_7 + var_4_8 and arg_1_1.time_ < var_4_7 + var_4_8 + arg_4_0 and not isNil(var_4_6) and arg_1_1.var_.actorSpriteComps1066 then
				for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_4_5 then
						if arg_1_1.isInRecall_ then
							iter_4_5.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps1066 = nil
			end

			local var_4_14 = arg_1_1.actors_["1066"].transform
			local var_4_15 = 4.2

			if var_4_15 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.var_.moveOldPos1066 = var_4_14.localPosition
				var_4_14.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1066", 3)

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
				local var_4_20 = Vector3.New(-77.5, -399.1, -303.3)

				var_4_14.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1066, var_4_20, var_4_19)
			end

			if arg_1_1.time_ >= var_4_15 + var_4_18 and arg_1_1.time_ < var_4_15 + var_4_18 + arg_4_0 then
				var_4_14.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_4_21 = 0
			local var_4_22 = 1.999999999999
			local var_4_23 = "ST10"

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_23)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_24 = arg_1_1:GetWordFromCfg(501112)
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

			local var_4_39 = "ST10"

			if arg_1_1.bgs_[var_4_39] == nil then
				local var_4_40 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_40:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_39)
				var_4_40.name = var_4_39
				var_4_40.transform.parent = arg_1_1.stage_.transform
				var_4_40.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_39] = var_4_40
			end

			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_42 = manager.ui.mainCamera.transform.localPosition
				local var_4_43 = Vector3.New(0, 0, 10) + Vector3.New(var_4_42.x, var_4_42.y, 0)
				local var_4_44 = arg_1_1.bgs_.ST10

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
					if iter_4_7 ~= "ST10" then
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

			local var_4_61 = 2.83333333333333
			local var_4_62 = 1

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				local var_4_63 = "play"
				local var_4_64 = "music"

				arg_1_1:AudioAction(var_4_63, var_4_64, "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_65 = ""
				local var_4_66 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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

			local var_4_67 = 2.83333333333333
			local var_4_68 = 1

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				local var_4_69 = "play"
				local var_4_70 = "effect"

				arg_1_1:AudioAction(var_4_69, var_4_70, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_71 = 4.4
			local var_4_72 = 1.05

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

				local var_4_74 = arg_1_1:FormatText(StoryNameCfg[32].name)

				arg_1_1.leftNameTxt_.text = var_4_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_75 = arg_1_1:GetWordFromCfg(425071001)
				local var_4_76 = arg_1_1:FormatText(var_4_75.content)

				arg_1_1.text_.text = var_4_76

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_77 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071001", "story_v_out_425071.awb") ~= 0 then
					local var_4_80 = manager.audio:GetVoiceLength("story_v_out_425071", "425071001", "story_v_out_425071.awb") / 1000

					if var_4_80 + var_4_71 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_80 + var_4_71
					end

					if var_4_75.prefab_name ~= "" and arg_1_1.actors_[var_4_75.prefab_name] ~= nil then
						local var_4_81 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_75.prefab_name].transform, "story_v_out_425071", "425071001", "story_v_out_425071.awb")

						arg_1_1:RecordAudio("425071001", var_4_81)
						arg_1_1:RecordAudio("425071001", var_4_81)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425071", "425071001", "story_v_out_425071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425071", "425071001", "story_v_out_425071.awb")
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
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play425071002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 425071002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play425071003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["1066"].transform
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.moveOldPos1066 = var_13_0.localPosition
				var_13_0.localScale = Vector3.New(1, 1, 1)

				arg_10_1:CheckSpriteTmpPos("1066", 7)

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
				local var_13_6 = Vector3.New(0, -2000, 0)

				var_13_0.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1066, var_13_6, var_13_5)
			end

			if arg_10_1.time_ >= var_13_1 + var_13_4 and arg_10_1.time_ < var_13_1 + var_13_4 + arg_13_0 then
				var_13_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_13_7 = 0
			local var_13_8 = 0.725

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

				local var_13_9 = arg_10_1:GetWordFromCfg(425071002)
				local var_13_10 = arg_10_1:FormatText(var_13_9.content)

				arg_10_1.text_.text = var_13_10

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_11 = 29
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
				actorName = "1066",
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
	Play425071003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 425071003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play425071004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 0.375

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

				local var_17_3 = arg_14_1:GetWordFromCfg(425071003)
				local var_17_4 = arg_14_1:FormatText(var_17_3.content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 15
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
	Play425071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 425071004
		arg_18_1.duration_ = 9.3

		local var_18_0 = {
			zh = 9.3,
			ja = 8.633
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
				arg_18_0:Play425071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1066"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1066 == nil then
				arg_18_1.var_.actorSpriteComps1066 = var_21_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_2 = 0.2

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.actorSpriteComps1066 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.actorSpriteComps1066 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_21_3 then
						if arg_18_1.isInRecall_ then
							iter_21_3.color = arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_21_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_18_1.var_.actorSpriteComps1066 = nil
			end

			local var_21_8 = arg_18_1.actors_["1066"].transform
			local var_21_9 = 0

			if var_21_9 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1.var_.moveOldPos1066 = var_21_8.localPosition
				var_21_8.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("1066", 3)

				local var_21_10 = var_21_8.childCount

				for iter_21_4 = 0, var_21_10 - 1 do
					local var_21_11 = var_21_8:GetChild(iter_21_4)

					if var_21_11.name == "" or not string.find(var_21_11.name, "split") then
						var_21_11.gameObject:SetActive(true)
					else
						var_21_11.gameObject:SetActive(false)
					end
				end
			end

			local var_21_12 = 0.001

			if var_21_9 <= arg_18_1.time_ and arg_18_1.time_ < var_21_9 + var_21_12 then
				local var_21_13 = (arg_18_1.time_ - var_21_9) / var_21_12
				local var_21_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_21_8.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1066, var_21_14, var_21_13)
			end

			if arg_18_1.time_ >= var_21_9 + var_21_12 and arg_18_1.time_ < var_21_9 + var_21_12 + arg_21_0 then
				var_21_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_21_15 = 0
			local var_21_16 = 1.125

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_17 = arg_18_1:FormatText(StoryNameCfg[32].name)

				arg_18_1.leftNameTxt_.text = var_21_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_18 = arg_18_1:GetWordFromCfg(425071004)
				local var_21_19 = arg_18_1:FormatText(var_21_18.content)

				arg_18_1.text_.text = var_21_19

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_20 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071004", "story_v_out_425071.awb") ~= 0 then
					local var_21_23 = manager.audio:GetVoiceLength("story_v_out_425071", "425071004", "story_v_out_425071.awb") / 1000

					if var_21_23 + var_21_15 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_23 + var_21_15
					end

					if var_21_18.prefab_name ~= "" and arg_18_1.actors_[var_21_18.prefab_name] ~= nil then
						local var_21_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_18.prefab_name].transform, "story_v_out_425071", "425071004", "story_v_out_425071.awb")

						arg_18_1:RecordAudio("425071004", var_21_24)
						arg_18_1:RecordAudio("425071004", var_21_24)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_425071", "425071004", "story_v_out_425071.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_425071", "425071004", "story_v_out_425071.awb")
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
				actorName = "1066",
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
	Play425071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 425071005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play425071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1066"].transform
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.moveOldPos1066 = var_25_0.localPosition
				var_25_0.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1066", 7)

				local var_25_2 = var_25_0.childCount

				for iter_25_0 = 0, var_25_2 - 1 do
					local var_25_3 = var_25_0:GetChild(iter_25_0)

					if var_25_3.name == "" or not string.find(var_25_3.name, "split") then
						var_25_3.gameObject:SetActive(true)
					else
						var_25_3.gameObject:SetActive(false)
					end
				end
			end

			local var_25_4 = 0.001

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_4 then
				local var_25_5 = (arg_22_1.time_ - var_25_1) / var_25_4
				local var_25_6 = Vector3.New(0, -2000, 0)

				var_25_0.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1066, var_25_6, var_25_5)
			end

			if arg_22_1.time_ >= var_25_1 + var_25_4 and arg_22_1.time_ < var_25_1 + var_25_4 + arg_25_0 then
				var_25_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_25_7 = 0
			local var_25_8 = 0.85

			if var_25_7 < arg_22_1.time_ and arg_22_1.time_ <= var_25_7 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_9 = arg_22_1:GetWordFromCfg(425071005)
				local var_25_10 = arg_22_1:FormatText(var_25_9.content)

				arg_22_1.text_.text = var_25_10

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_11 = 34
				local var_25_12 = utf8.len(var_25_10)
				local var_25_13 = var_25_11 <= 0 and var_25_8 or var_25_8 * (var_25_12 / var_25_11)

				if var_25_13 > 0 and var_25_8 < var_25_13 then
					arg_22_1.talkMaxDuration = var_25_13

					if var_25_13 + var_25_7 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_13 + var_25_7
					end
				end

				arg_22_1.text_.text = var_25_10
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_14 = math.max(var_25_8, arg_22_1.talkMaxDuration)

			if var_25_7 <= arg_22_1.time_ and arg_22_1.time_ < var_25_7 + var_25_14 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_7) / var_25_14

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_7 + var_25_14 and arg_22_1.time_ < var_25_7 + var_25_14 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
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

		arg_22_1:InitPlayNodeList()
	end,
	Play425071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 425071006
		arg_26_1.duration_ = 6.73

		local var_26_0 = {
			zh = 4.666,
			ja = 6.733
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
				arg_26_0:Play425071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = "1037"

			if arg_26_1.actors_[var_29_0] == nil then
				local var_29_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_29_1) then
					local var_29_2 = Object.Instantiate(var_29_1, arg_26_1.canvasGo_.transform)

					var_29_2.transform:SetSiblingIndex(1)

					var_29_2.name = var_29_0
					var_29_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_26_1.actors_[var_29_0] = var_29_2

					local var_29_3 = var_29_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_26_1.isInRecall_ then
						for iter_29_0, iter_29_1 in ipairs(var_29_3) do
							iter_29_1.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_29_4 = arg_26_1.actors_["1037"]
			local var_29_5 = 0

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.actorSpriteComps1037 == nil then
				arg_26_1.var_.actorSpriteComps1037 = var_29_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_6 = 0.2

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_6 and not isNil(var_29_4) then
				local var_29_7 = (arg_26_1.time_ - var_29_5) / var_29_6

				if arg_26_1.var_.actorSpriteComps1037 then
					for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_29_3 then
							if arg_26_1.isInRecall_ then
								local var_29_8 = Mathf.Lerp(iter_29_3.color.r, arg_26_1.hightColor1.r, var_29_7)
								local var_29_9 = Mathf.Lerp(iter_29_3.color.g, arg_26_1.hightColor1.g, var_29_7)
								local var_29_10 = Mathf.Lerp(iter_29_3.color.b, arg_26_1.hightColor1.b, var_29_7)

								iter_29_3.color = Color.New(var_29_8, var_29_9, var_29_10)
							else
								local var_29_11 = Mathf.Lerp(iter_29_3.color.r, 1, var_29_7)

								iter_29_3.color = Color.New(var_29_11, var_29_11, var_29_11)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= var_29_5 + var_29_6 and arg_26_1.time_ < var_29_5 + var_29_6 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.actorSpriteComps1037 then
				for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_29_5 then
						if arg_26_1.isInRecall_ then
							iter_29_5.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_29_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_26_1.var_.actorSpriteComps1037 = nil
			end

			local var_29_12 = arg_26_1.actors_["1037"].transform
			local var_29_13 = 0

			if var_29_13 < arg_26_1.time_ and arg_26_1.time_ <= var_29_13 + arg_29_0 then
				arg_26_1.var_.moveOldPos1037 = var_29_12.localPosition
				var_29_12.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("1037", 2)

				local var_29_14 = var_29_12.childCount

				for iter_29_6 = 0, var_29_14 - 1 do
					local var_29_15 = var_29_12:GetChild(iter_29_6)

					if var_29_15.name == "" or not string.find(var_29_15.name, "split") then
						var_29_15.gameObject:SetActive(true)
					else
						var_29_15.gameObject:SetActive(false)
					end
				end
			end

			local var_29_16 = 0.001

			if var_29_13 <= arg_26_1.time_ and arg_26_1.time_ < var_29_13 + var_29_16 then
				local var_29_17 = (arg_26_1.time_ - var_29_13) / var_29_16
				local var_29_18 = Vector3.New(-390, -430, -55)

				var_29_12.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos1037, var_29_18, var_29_17)
			end

			if arg_26_1.time_ >= var_29_13 + var_29_16 and arg_26_1.time_ < var_29_13 + var_29_16 + arg_29_0 then
				var_29_12.localPosition = Vector3.New(-390, -430, -55)
			end

			local var_29_19 = 0
			local var_29_20 = 0.6

			if var_29_19 < arg_26_1.time_ and arg_26_1.time_ <= var_29_19 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_21 = arg_26_1:FormatText(StoryNameCfg[15].name)

				arg_26_1.leftNameTxt_.text = var_29_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_22 = arg_26_1:GetWordFromCfg(425071006)
				local var_29_23 = arg_26_1:FormatText(var_29_22.content)

				arg_26_1.text_.text = var_29_23

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_24 = 24
				local var_29_25 = utf8.len(var_29_23)
				local var_29_26 = var_29_24 <= 0 and var_29_20 or var_29_20 * (var_29_25 / var_29_24)

				if var_29_26 > 0 and var_29_20 < var_29_26 then
					arg_26_1.talkMaxDuration = var_29_26

					if var_29_26 + var_29_19 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_26 + var_29_19
					end
				end

				arg_26_1.text_.text = var_29_23
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071006", "story_v_out_425071.awb") ~= 0 then
					local var_29_27 = manager.audio:GetVoiceLength("story_v_out_425071", "425071006", "story_v_out_425071.awb") / 1000

					if var_29_27 + var_29_19 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_27 + var_29_19
					end

					if var_29_22.prefab_name ~= "" and arg_26_1.actors_[var_29_22.prefab_name] ~= nil then
						local var_29_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_22.prefab_name].transform, "story_v_out_425071", "425071006", "story_v_out_425071.awb")

						arg_26_1:RecordAudio("425071006", var_29_28)
						arg_26_1:RecordAudio("425071006", var_29_28)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_425071", "425071006", "story_v_out_425071.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_425071", "425071006", "story_v_out_425071.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_29 = math.max(var_29_20, arg_26_1.talkMaxDuration)

			if var_29_19 <= arg_26_1.time_ and arg_26_1.time_ < var_29_19 + var_29_29 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_19) / var_29_29

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_19 + var_29_29 and arg_26_1.time_ < var_29_19 + var_29_29 + arg_29_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play425071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 425071007
		arg_30_1.duration_ = 9.4

		local var_30_0 = {
			zh = 9.4,
			ja = 8.833
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
				arg_30_0:Play425071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1066"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1066 == nil then
				arg_30_1.var_.actorSpriteComps1066 = var_33_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_2 = 0.2

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.actorSpriteComps1066 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.actorSpriteComps1066 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_33_3 then
						if arg_30_1.isInRecall_ then
							iter_33_3.color = arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_33_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1066 = nil
			end

			local var_33_8 = arg_30_1.actors_["1037"]
			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 and not isNil(var_33_8) and arg_30_1.var_.actorSpriteComps1037 == nil then
				arg_30_1.var_.actorSpriteComps1037 = var_33_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_10 = 0.2

			if var_33_9 <= arg_30_1.time_ and arg_30_1.time_ < var_33_9 + var_33_10 and not isNil(var_33_8) then
				local var_33_11 = (arg_30_1.time_ - var_33_9) / var_33_10

				if arg_30_1.var_.actorSpriteComps1037 then
					for iter_33_4, iter_33_5 in pairs(arg_30_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_33_5 then
							if arg_30_1.isInRecall_ then
								local var_33_12 = Mathf.Lerp(iter_33_5.color.r, arg_30_1.hightColor2.r, var_33_11)
								local var_33_13 = Mathf.Lerp(iter_33_5.color.g, arg_30_1.hightColor2.g, var_33_11)
								local var_33_14 = Mathf.Lerp(iter_33_5.color.b, arg_30_1.hightColor2.b, var_33_11)

								iter_33_5.color = Color.New(var_33_12, var_33_13, var_33_14)
							else
								local var_33_15 = Mathf.Lerp(iter_33_5.color.r, 0.5, var_33_11)

								iter_33_5.color = Color.New(var_33_15, var_33_15, var_33_15)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= var_33_9 + var_33_10 and arg_30_1.time_ < var_33_9 + var_33_10 + arg_33_0 and not isNil(var_33_8) and arg_30_1.var_.actorSpriteComps1037 then
				for iter_33_6, iter_33_7 in pairs(arg_30_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_33_7 then
						if arg_30_1.isInRecall_ then
							iter_33_7.color = arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_33_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_30_1.var_.actorSpriteComps1037 = nil
			end

			local var_33_16 = arg_30_1.actors_["1066"].transform
			local var_33_17 = 0

			if var_33_17 < arg_30_1.time_ and arg_30_1.time_ <= var_33_17 + arg_33_0 then
				arg_30_1.var_.moveOldPos1066 = var_33_16.localPosition
				var_33_16.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("1066", 4)

				local var_33_18 = var_33_16.childCount

				for iter_33_8 = 0, var_33_18 - 1 do
					local var_33_19 = var_33_16:GetChild(iter_33_8)

					if var_33_19.name == "" or not string.find(var_33_19.name, "split") then
						var_33_19.gameObject:SetActive(true)
					else
						var_33_19.gameObject:SetActive(false)
					end
				end
			end

			local var_33_20 = 0.001

			if var_33_17 <= arg_30_1.time_ and arg_30_1.time_ < var_33_17 + var_33_20 then
				local var_33_21 = (arg_30_1.time_ - var_33_17) / var_33_20
				local var_33_22 = Vector3.New(453.9, -399.1, -303.3)

				var_33_16.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1066, var_33_22, var_33_21)
			end

			if arg_30_1.time_ >= var_33_17 + var_33_20 and arg_30_1.time_ < var_33_17 + var_33_20 + arg_33_0 then
				var_33_16.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_33_23 = 0
			local var_33_24 = 1.1

			if var_33_23 < arg_30_1.time_ and arg_30_1.time_ <= var_33_23 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_25 = arg_30_1:FormatText(StoryNameCfg[32].name)

				arg_30_1.leftNameTxt_.text = var_33_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_26 = arg_30_1:GetWordFromCfg(425071007)
				local var_33_27 = arg_30_1:FormatText(var_33_26.content)

				arg_30_1.text_.text = var_33_27

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_28 = 44
				local var_33_29 = utf8.len(var_33_27)
				local var_33_30 = var_33_28 <= 0 and var_33_24 or var_33_24 * (var_33_29 / var_33_28)

				if var_33_30 > 0 and var_33_24 < var_33_30 then
					arg_30_1.talkMaxDuration = var_33_30

					if var_33_30 + var_33_23 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_30 + var_33_23
					end
				end

				arg_30_1.text_.text = var_33_27
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071007", "story_v_out_425071.awb") ~= 0 then
					local var_33_31 = manager.audio:GetVoiceLength("story_v_out_425071", "425071007", "story_v_out_425071.awb") / 1000

					if var_33_31 + var_33_23 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_31 + var_33_23
					end

					if var_33_26.prefab_name ~= "" and arg_30_1.actors_[var_33_26.prefab_name] ~= nil then
						local var_33_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_26.prefab_name].transform, "story_v_out_425071", "425071007", "story_v_out_425071.awb")

						arg_30_1:RecordAudio("425071007", var_33_32)
						arg_30_1:RecordAudio("425071007", var_33_32)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_425071", "425071007", "story_v_out_425071.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_425071", "425071007", "story_v_out_425071.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_33 = math.max(var_33_24, arg_30_1.talkMaxDuration)

			if var_33_23 <= arg_30_1.time_ and arg_30_1.time_ < var_33_23 + var_33_33 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_23) / var_33_33

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_23 + var_33_33 and arg_30_1.time_ < var_33_23 + var_33_33 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
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

		arg_30_1:InitPlayNodeList()
	end,
	Play425071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 425071008
		arg_34_1.duration_ = 7.03

		local var_34_0 = {
			zh = 7.033,
			ja = 6.4
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
				arg_34_0:Play425071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 0.85

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_2 = arg_34_1:FormatText(StoryNameCfg[32].name)

				arg_34_1.leftNameTxt_.text = var_37_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_3 = arg_34_1:GetWordFromCfg(425071008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 34
				local var_37_6 = utf8.len(var_37_4)
				local var_37_7 = var_37_5 <= 0 and var_37_1 or var_37_1 * (var_37_6 / var_37_5)

				if var_37_7 > 0 and var_37_1 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071008", "story_v_out_425071.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071008", "story_v_out_425071.awb") / 1000

					if var_37_8 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_0
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_out_425071", "425071008", "story_v_out_425071.awb")

						arg_34_1:RecordAudio("425071008", var_37_9)
						arg_34_1:RecordAudio("425071008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_425071", "425071008", "story_v_out_425071.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_425071", "425071008", "story_v_out_425071.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_10 and arg_34_1.time_ < var_37_0 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play425071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 425071009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play425071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1066"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1066 == nil then
				arg_38_1.var_.actorSpriteComps1066 = var_41_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.actorSpriteComps1066 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								local var_41_4 = Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor2.r, var_41_3)
								local var_41_5 = Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor2.g, var_41_3)
								local var_41_6 = Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor2.b, var_41_3)

								iter_41_1.color = Color.New(var_41_4, var_41_5, var_41_6)
							else
								local var_41_7 = Mathf.Lerp(iter_41_1.color.r, 0.5, var_41_3)

								iter_41_1.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.actorSpriteComps1066 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_41_3 then
						if arg_38_1.isInRecall_ then
							iter_41_3.color = arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_41_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_38_1.var_.actorSpriteComps1066 = nil
			end

			local var_41_8 = 0
			local var_41_9 = 0.625

			if var_41_8 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_10 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_11 = arg_38_1:GetWordFromCfg(425071009)
				local var_41_12 = arg_38_1:FormatText(var_41_11.content)

				arg_38_1.text_.text = var_41_12

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_13 = 25
				local var_41_14 = utf8.len(var_41_12)
				local var_41_15 = var_41_13 <= 0 and var_41_9 or var_41_9 * (var_41_14 / var_41_13)

				if var_41_15 > 0 and var_41_9 < var_41_15 then
					arg_38_1.talkMaxDuration = var_41_15

					if var_41_15 + var_41_8 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_8
					end
				end

				arg_38_1.text_.text = var_41_12
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_16 = math.max(var_41_9, arg_38_1.talkMaxDuration)

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_16 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_8) / var_41_16

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_8 + var_41_16 and arg_38_1.time_ < var_41_8 + var_41_16 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play425071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 425071010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play425071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0
			local var_45_1 = 1.175

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_2

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

				local var_45_3 = arg_42_1:GetWordFromCfg(425071010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 47
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_8 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_8 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_8

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_8 and arg_42_1.time_ < var_45_0 + var_45_8 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play425071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 425071011
		arg_46_1.duration_ = 5

		local var_46_0 = {
			zh = 2.833,
			ja = 5
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
				arg_46_0:Play425071012(arg_46_1)
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

				arg_46_1:CheckSpriteTmpPos("1037", 2)

				local var_49_10 = var_49_8.childCount

				for iter_49_4 = 0, var_49_10 - 1 do
					local var_49_11 = var_49_8:GetChild(iter_49_4)

					if var_49_11.name == "split_6" then
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
				local var_49_14 = Vector3.New(-390, -430, -55)

				var_49_8.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1037, var_49_14, var_49_13)

				if arg_46_1.var_.actorSpriteSplit1037 ~= nil then
					arg_46_1.var_.actorSpriteSplit1037:SetAlpha(var_49_13)
				end
			end

			if arg_46_1.time_ >= var_49_9 + var_49_12 and arg_46_1.time_ < var_49_9 + var_49_12 + arg_49_0 then
				var_49_8.localPosition = Vector3.New(-390, -430, -55)

				if arg_46_1.var_.actorSpriteSplit1037 ~= nil then
					arg_46_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_49_15 = 0
			local var_49_16 = 0.375

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

				local var_49_18 = arg_46_1:GetWordFromCfg(425071011)
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071011", "story_v_out_425071.awb") ~= 0 then
					local var_49_23 = manager.audio:GetVoiceLength("story_v_out_425071", "425071011", "story_v_out_425071.awb") / 1000

					if var_49_23 + var_49_15 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_15
					end

					if var_49_18.prefab_name ~= "" and arg_46_1.actors_[var_49_18.prefab_name] ~= nil then
						local var_49_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_18.prefab_name].transform, "story_v_out_425071", "425071011", "story_v_out_425071.awb")

						arg_46_1:RecordAudio("425071011", var_49_24)
						arg_46_1:RecordAudio("425071011", var_49_24)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_425071", "425071011", "story_v_out_425071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_425071", "425071011", "story_v_out_425071.awb")
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
	Play425071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 425071012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play425071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1037"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1037 = var_53_0.localPosition
				var_53_0.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1037", 7)

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
				local var_53_6 = Vector3.New(1500, -2000, 0)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1037, var_53_6, var_53_5)
			end

			if arg_50_1.time_ >= var_53_1 + var_53_4 and arg_50_1.time_ < var_53_1 + var_53_4 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_53_7 = arg_50_1.actors_["1066"].transform
			local var_53_8 = 0

			if var_53_8 < arg_50_1.time_ and arg_50_1.time_ <= var_53_8 + arg_53_0 then
				arg_50_1.var_.moveOldPos1066 = var_53_7.localPosition
				var_53_7.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1066", 7)

				local var_53_9 = var_53_7.childCount

				for iter_53_1 = 0, var_53_9 - 1 do
					local var_53_10 = var_53_7:GetChild(iter_53_1)

					if var_53_10.name == "" or not string.find(var_53_10.name, "split") then
						var_53_10.gameObject:SetActive(true)
					else
						var_53_10.gameObject:SetActive(false)
					end
				end
			end

			local var_53_11 = 0.001

			if var_53_8 <= arg_50_1.time_ and arg_50_1.time_ < var_53_8 + var_53_11 then
				local var_53_12 = (arg_50_1.time_ - var_53_8) / var_53_11
				local var_53_13 = Vector3.New(0, -2000, 0)

				var_53_7.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1066, var_53_13, var_53_12)
			end

			if arg_50_1.time_ >= var_53_8 + var_53_11 and arg_50_1.time_ < var_53_8 + var_53_11 + arg_53_0 then
				var_53_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_53_14 = 0
			local var_53_15 = 0.65

			if var_53_14 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_16 = arg_50_1:GetWordFromCfg(425071012)
				local var_53_17 = arg_50_1:FormatText(var_53_16.content)

				arg_50_1.text_.text = var_53_17

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_18 = 26
				local var_53_19 = utf8.len(var_53_17)
				local var_53_20 = var_53_18 <= 0 and var_53_15 or var_53_15 * (var_53_19 / var_53_18)

				if var_53_20 > 0 and var_53_15 < var_53_20 then
					arg_50_1.talkMaxDuration = var_53_20

					if var_53_20 + var_53_14 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_20 + var_53_14
					end
				end

				arg_50_1.text_.text = var_53_17
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_21 = math.max(var_53_15, arg_50_1.talkMaxDuration)

			if var_53_14 <= arg_50_1.time_ and arg_50_1.time_ < var_53_14 + var_53_21 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_14) / var_53_21

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_14 + var_53_21 and arg_50_1.time_ < var_53_14 + var_53_21 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play425071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 425071013
		arg_54_1.duration_ = 7.97

		local var_54_0 = {
			zh = 7.966,
			ja = 7.4
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
				arg_54_0:Play425071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1066"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1066 == nil then
				arg_54_1.var_.actorSpriteComps1066 = var_57_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.actorSpriteComps1066 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.actorSpriteComps1066 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_57_3 then
						if arg_54_1.isInRecall_ then
							iter_57_3.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps1066 = nil
			end

			local var_57_8 = arg_54_1.actors_["1066"].transform
			local var_57_9 = 0

			if var_57_9 < arg_54_1.time_ and arg_54_1.time_ <= var_57_9 + arg_57_0 then
				arg_54_1.var_.moveOldPos1066 = var_57_8.localPosition
				var_57_8.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("1066", 3)

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
				local var_57_14 = Vector3.New(-77.5, -399.1, -303.3)

				var_57_8.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1066, var_57_14, var_57_13)
			end

			if arg_54_1.time_ >= var_57_9 + var_57_12 and arg_54_1.time_ < var_57_9 + var_57_12 + arg_57_0 then
				var_57_8.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_57_15 = 0
			local var_57_16 = 0.875

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_17 = arg_54_1:FormatText(StoryNameCfg[32].name)

				arg_54_1.leftNameTxt_.text = var_57_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_18 = arg_54_1:GetWordFromCfg(425071013)
				local var_57_19 = arg_54_1:FormatText(var_57_18.content)

				arg_54_1.text_.text = var_57_19

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071013", "story_v_out_425071.awb") ~= 0 then
					local var_57_23 = manager.audio:GetVoiceLength("story_v_out_425071", "425071013", "story_v_out_425071.awb") / 1000

					if var_57_23 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_15
					end

					if var_57_18.prefab_name ~= "" and arg_54_1.actors_[var_57_18.prefab_name] ~= nil then
						local var_57_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_18.prefab_name].transform, "story_v_out_425071", "425071013", "story_v_out_425071.awb")

						arg_54_1:RecordAudio("425071013", var_57_24)
						arg_54_1:RecordAudio("425071013", var_57_24)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_425071", "425071013", "story_v_out_425071.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_425071", "425071013", "story_v_out_425071.awb")
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
				actorName = "1066",
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
	Play425071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 425071014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play425071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1066"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1066 == nil then
				arg_58_1.var_.actorSpriteComps1066 = var_61_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_2 = 0.2

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.actorSpriteComps1066 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps1066:ToTable()) do
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

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.actorSpriteComps1066 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_61_3 then
						if arg_58_1.isInRecall_ then
							iter_61_3.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps1066 = nil
			end

			local var_61_8 = 0
			local var_61_9 = 0.75

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

				local var_61_11 = arg_58_1:GetWordFromCfg(425071014)
				local var_61_12 = arg_58_1:FormatText(var_61_11.content)

				arg_58_1.text_.text = var_61_12

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 30
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
	Play425071015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 425071015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play425071016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1066"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos1066 = var_65_0.localPosition
				var_65_0.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1066", 7)

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

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1066, var_65_6, var_65_5)
			end

			if arg_62_1.time_ >= var_65_1 + var_65_4 and arg_62_1.time_ < var_65_1 + var_65_4 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_65_7 = 0
			local var_65_8 = 1.325

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

				local var_65_9 = arg_62_1:GetWordFromCfg(425071015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 53
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
				actorName = "1066",
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
	Play425071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 425071016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play425071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 0.1

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_2 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_2

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

				local var_69_3 = arg_66_1:GetWordFromCfg(425071016)
				local var_69_4 = arg_66_1:FormatText(var_69_3.content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 4
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
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_8 and arg_66_1.time_ < var_69_0 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play425071017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 425071017
		arg_70_1.duration_ = 4.67

		local var_70_0 = {
			zh = 1.9,
			ja = 4.666
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
				arg_70_0:Play425071018(arg_70_1)
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

					if var_73_11.name == "split_6" or not string.find(var_73_11.name, "split") then
						var_73_11.gameObject:SetActive(true)
					else
						var_73_11.gameObject:SetActive(false)
					end
				end
			end

			local var_73_12 = 0.001

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_12 then
				local var_73_13 = (arg_70_1.time_ - var_73_9) / var_73_12
				local var_73_14 = Vector3.New(0, -430, -55)

				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1037, var_73_14, var_73_13)
			end

			if arg_70_1.time_ >= var_73_9 + var_73_12 and arg_70_1.time_ < var_73_9 + var_73_12 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_73_15 = 0
			local var_73_16 = 0.2

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

				local var_73_18 = arg_70_1:GetWordFromCfg(425071017)
				local var_73_19 = arg_70_1:FormatText(var_73_18.content)

				arg_70_1.text_.text = var_73_19

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071017", "story_v_out_425071.awb") ~= 0 then
					local var_73_23 = manager.audio:GetVoiceLength("story_v_out_425071", "425071017", "story_v_out_425071.awb") / 1000

					if var_73_23 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_23 + var_73_15
					end

					if var_73_18.prefab_name ~= "" and arg_70_1.actors_[var_73_18.prefab_name] ~= nil then
						local var_73_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_18.prefab_name].transform, "story_v_out_425071", "425071017", "story_v_out_425071.awb")

						arg_70_1:RecordAudio("425071017", var_73_24)
						arg_70_1:RecordAudio("425071017", var_73_24)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_425071", "425071017", "story_v_out_425071.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_425071", "425071017", "story_v_out_425071.awb")
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play425071018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 425071018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play425071019(arg_74_1)
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
			local var_77_9 = 0.25

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

				local var_77_11 = arg_74_1:GetWordFromCfg(425071018)
				local var_77_12 = arg_74_1:FormatText(var_77_11.content)

				arg_74_1.text_.text = var_77_12

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 10
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
	Play425071019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 425071019
		arg_78_1.duration_ = 7.83

		local var_78_0 = {
			zh = 5.8,
			ja = 7.833
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
				arg_78_0:Play425071020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1037"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps1037 == nil then
				arg_78_1.var_.actorSpriteComps1037 = var_81_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_81_2 = 0.2

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.actorSpriteComps1037 then
					for iter_81_0, iter_81_1 in pairs(arg_78_1.var_.actorSpriteComps1037:ToTable()) do
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

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.actorSpriteComps1037 then
				for iter_81_2, iter_81_3 in pairs(arg_78_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_81_3 then
						if arg_78_1.isInRecall_ then
							iter_81_3.color = arg_78_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_81_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_78_1.var_.actorSpriteComps1037 = nil
			end

			local var_81_8 = arg_78_1.actors_["1037"].transform
			local var_81_9 = 0

			if var_81_9 < arg_78_1.time_ and arg_78_1.time_ <= var_81_9 + arg_81_0 then
				arg_78_1.var_.moveOldPos1037 = var_81_8.localPosition
				var_81_8.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("1037", 3)

				local var_81_10 = var_81_8.childCount

				for iter_81_4 = 0, var_81_10 - 1 do
					local var_81_11 = var_81_8:GetChild(iter_81_4)

					if var_81_11.name == "split_4" then
						var_81_11:SetAsLastSibling()
						var_81_11.gameObject:SetActive(true)

						arg_78_1.var_.actorSpriteSplit1037 = var_81_11.gameObject:GetComponent(typeof(Image))

						arg_78_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_81_12 = 0.5

			if var_81_9 <= arg_78_1.time_ and arg_78_1.time_ < var_81_9 + var_81_12 then
				local var_81_13 = (arg_78_1.time_ - var_81_9) / var_81_12
				local var_81_14 = Vector3.New(0, -430, -55)

				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1037, var_81_14, var_81_13)

				if arg_78_1.var_.actorSpriteSplit1037 ~= nil then
					arg_78_1.var_.actorSpriteSplit1037:SetAlpha(var_81_13)
				end
			end

			if arg_78_1.time_ >= var_81_9 + var_81_12 and arg_78_1.time_ < var_81_9 + var_81_12 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(0, -430, -55)

				if arg_78_1.var_.actorSpriteSplit1037 ~= nil then
					arg_78_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_81_15 = 0
			local var_81_16 = 0.575

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_17 = arg_78_1:FormatText(StoryNameCfg[15].name)

				arg_78_1.leftNameTxt_.text = var_81_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(425071019)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071019", "story_v_out_425071.awb") ~= 0 then
					local var_81_23 = manager.audio:GetVoiceLength("story_v_out_425071", "425071019", "story_v_out_425071.awb") / 1000

					if var_81_23 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_15
					end

					if var_81_18.prefab_name ~= "" and arg_78_1.actors_[var_81_18.prefab_name] ~= nil then
						local var_81_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_18.prefab_name].transform, "story_v_out_425071", "425071019", "story_v_out_425071.awb")

						arg_78_1:RecordAudio("425071019", var_81_24)
						arg_78_1:RecordAudio("425071019", var_81_24)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_425071", "425071019", "story_v_out_425071.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_425071", "425071019", "story_v_out_425071.awb")
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
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play425071020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 425071020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play425071021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1037"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1037 = var_85_0.localPosition
				var_85_0.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("1037", 7)

				local var_85_2 = var_85_0.childCount

				for iter_85_0 = 0, var_85_2 - 1 do
					local var_85_3 = var_85_0:GetChild(iter_85_0)

					if var_85_3.name == "" or not string.find(var_85_3.name, "split") then
						var_85_3.gameObject:SetActive(true)
					else
						var_85_3.gameObject:SetActive(false)
					end
				end
			end

			local var_85_4 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_4 then
				local var_85_5 = (arg_82_1.time_ - var_85_1) / var_85_4
				local var_85_6 = Vector3.New(1500, -2000, 0)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1037, var_85_6, var_85_5)
			end

			if arg_82_1.time_ >= var_85_1 + var_85_4 and arg_82_1.time_ < var_85_1 + var_85_4 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_85_7 = 0.1
			local var_85_8 = 1

			if var_85_7 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 then
				local var_85_9 = "play"
				local var_85_10 = "effect"

				arg_82_1:AudioAction(var_85_9, var_85_10, "se_story_10", "se_story_10_energy_loop", "")
			end

			local var_85_11 = 0
			local var_85_12 = 1.125

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_13 = arg_82_1:GetWordFromCfg(425071020)
				local var_85_14 = arg_82_1:FormatText(var_85_13.content)

				arg_82_1.text_.text = var_85_14

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_15 = 45
				local var_85_16 = utf8.len(var_85_14)
				local var_85_17 = var_85_15 <= 0 and var_85_12 or var_85_12 * (var_85_16 / var_85_15)

				if var_85_17 > 0 and var_85_12 < var_85_17 then
					arg_82_1.talkMaxDuration = var_85_17

					if var_85_17 + var_85_11 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_17 + var_85_11
					end
				end

				arg_82_1.text_.text = var_85_14
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_18 = math.max(var_85_12, arg_82_1.talkMaxDuration)

			if var_85_11 <= arg_82_1.time_ and arg_82_1.time_ < var_85_11 + var_85_18 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_11) / var_85_18

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_11 + var_85_18 and arg_82_1.time_ < var_85_11 + var_85_18 + arg_85_0 then
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
	Play425071021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 425071021
		arg_86_1.duration_ = 2.83

		local var_86_0 = {
			zh = 2.833,
			ja = 2.133
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
				arg_86_0:Play425071022(arg_86_1)
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

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps1037 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_89_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps1037 = nil
			end

			local var_89_8 = arg_86_1.actors_["1037"].transform
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.var_.moveOldPos1037 = var_89_8.localPosition
				var_89_8.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("1037", 3)

				local var_89_10 = var_89_8.childCount

				for iter_89_4 = 0, var_89_10 - 1 do
					local var_89_11 = var_89_8:GetChild(iter_89_4)

					if var_89_11.name == "split_5" or not string.find(var_89_11.name, "split") then
						var_89_11.gameObject:SetActive(true)
					else
						var_89_11.gameObject:SetActive(false)
					end
				end
			end

			local var_89_12 = 0.001

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_9) / var_89_12
				local var_89_14 = Vector3.New(0, -430, -55)

				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1037, var_89_14, var_89_13)
			end

			if arg_86_1.time_ >= var_89_9 + var_89_12 and arg_86_1.time_ < var_89_9 + var_89_12 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(0, -430, -55)
			end

			local var_89_15 = 0
			local var_89_16 = 0.2

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_17 = arg_86_1:FormatText(StoryNameCfg[15].name)

				arg_86_1.leftNameTxt_.text = var_89_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_18 = arg_86_1:GetWordFromCfg(425071021)
				local var_89_19 = arg_86_1:FormatText(var_89_18.content)

				arg_86_1.text_.text = var_89_19

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_20 = 8
				local var_89_21 = utf8.len(var_89_19)
				local var_89_22 = var_89_20 <= 0 and var_89_16 or var_89_16 * (var_89_21 / var_89_20)

				if var_89_22 > 0 and var_89_16 < var_89_22 then
					arg_86_1.talkMaxDuration = var_89_22

					if var_89_22 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_22 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_19
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071021", "story_v_out_425071.awb") ~= 0 then
					local var_89_23 = manager.audio:GetVoiceLength("story_v_out_425071", "425071021", "story_v_out_425071.awb") / 1000

					if var_89_23 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_23 + var_89_15
					end

					if var_89_18.prefab_name ~= "" and arg_86_1.actors_[var_89_18.prefab_name] ~= nil then
						local var_89_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_18.prefab_name].transform, "story_v_out_425071", "425071021", "story_v_out_425071.awb")

						arg_86_1:RecordAudio("425071021", var_89_24)
						arg_86_1:RecordAudio("425071021", var_89_24)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_425071", "425071021", "story_v_out_425071.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_425071", "425071021", "story_v_out_425071.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_25 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_25 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_25

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_25 and arg_86_1.time_ < var_89_15 + var_89_25 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play425071022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 425071022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play425071023(arg_90_1)
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

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps1037 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_93_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps1037 = nil
			end

			local var_93_8 = 0
			local var_93_9 = 0.1

			if var_93_8 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_10 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_11 = arg_90_1:GetWordFromCfg(425071022)
				local var_93_12 = arg_90_1:FormatText(var_93_11.content)

				arg_90_1.text_.text = var_93_12

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 4
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
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_16 and arg_90_1.time_ < var_93_8 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play425071023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 425071023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play425071024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1037"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos1037 = var_97_0.localPosition
				var_97_0.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("1037", 7)

				local var_97_2 = var_97_0.childCount

				for iter_97_0 = 0, var_97_2 - 1 do
					local var_97_3 = var_97_0:GetChild(iter_97_0)

					if var_97_3.name == "" or not string.find(var_97_3.name, "split") then
						var_97_3.gameObject:SetActive(true)
					else
						var_97_3.gameObject:SetActive(false)
					end
				end
			end

			local var_97_4 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_4 then
				local var_97_5 = (arg_94_1.time_ - var_97_1) / var_97_4
				local var_97_6 = Vector3.New(1500, -2000, 0)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1037, var_97_6, var_97_5)
			end

			if arg_94_1.time_ >= var_97_1 + var_97_4 and arg_94_1.time_ < var_97_1 + var_97_4 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_97_7 = 0
			local var_97_8 = 1

			if var_97_7 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 then
				local var_97_9 = "stop"
				local var_97_10 = "effect"

				arg_94_1:AudioAction(var_97_9, var_97_10, "se_story_10", "se_story_10_energy_loop", "")
			end

			local var_97_11 = 0.233333333333333
			local var_97_12 = 1

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				local var_97_13 = "play"
				local var_97_14 = "effect"

				arg_94_1:AudioAction(var_97_13, var_97_14, "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_97_15 = manager.ui.mainCamera.transform
			local var_97_16 = 0.034

			if var_97_16 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.var_.shakeOldPos = var_97_15.localPosition
			end

			local var_97_17 = 0.3

			if var_97_16 <= arg_94_1.time_ and arg_94_1.time_ < var_97_16 + var_97_17 then
				local var_97_18 = (arg_94_1.time_ - var_97_16) / 0.132
				local var_97_19, var_97_20 = math.modf(var_97_18)

				var_97_15.localPosition = Vector3.New(var_97_20 * 0.1, var_97_20 * 0.1, var_97_20 * 0.1) + arg_94_1.var_.shakeOldPos
			end

			if arg_94_1.time_ >= var_97_16 + var_97_17 and arg_94_1.time_ < var_97_16 + var_97_17 + arg_97_0 then
				var_97_15.localPosition = arg_94_1.var_.shakeOldPos
			end

			local var_97_21 = 0
			local var_97_22 = 1.525

			if var_97_21 < arg_94_1.time_ and arg_94_1.time_ <= var_97_21 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_23 = arg_94_1:GetWordFromCfg(425071023)
				local var_97_24 = arg_94_1:FormatText(var_97_23.content)

				arg_94_1.text_.text = var_97_24

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_25 = 61
				local var_97_26 = utf8.len(var_97_24)
				local var_97_27 = var_97_25 <= 0 and var_97_22 or var_97_22 * (var_97_26 / var_97_25)

				if var_97_27 > 0 and var_97_22 < var_97_27 then
					arg_94_1.talkMaxDuration = var_97_27

					if var_97_27 + var_97_21 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_27 + var_97_21
					end
				end

				arg_94_1.text_.text = var_97_24
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_28 = math.max(var_97_22, arg_94_1.talkMaxDuration)

			if var_97_21 <= arg_94_1.time_ and arg_94_1.time_ < var_97_21 + var_97_28 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_21) / var_97_28

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_21 + var_97_28 and arg_94_1.time_ < var_97_21 + var_97_28 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play425071024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 425071024
		arg_98_1.duration_ = 9.9

		local var_98_0 = {
			zh = 8.06600033333333,
			ja = 9.90000033333333
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
				arg_98_0:Play425071025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 5.60000033333333

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			local var_101_1 = 0.275

			if arg_98_1.time_ >= var_101_0 + var_101_1 and arg_98_1.time_ < var_101_0 + var_101_1 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_2 = 0

			if var_101_2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_3 = 1.2

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_3 then
				local var_101_4 = (arg_98_1.time_ - var_101_2) / var_101_3
				local var_101_5 = Color.New(0, 0, 0)

				var_101_5.a = Mathf.Lerp(0, 1, var_101_4)
				arg_98_1.mask_.color = var_101_5
			end

			if arg_98_1.time_ >= var_101_2 + var_101_3 and arg_98_1.time_ < var_101_2 + var_101_3 + arg_101_0 then
				local var_101_6 = Color.New(0, 0, 0)

				var_101_6.a = 1
				arg_98_1.mask_.color = var_101_6
			end

			local var_101_7 = 1.2

			if var_101_7 < arg_98_1.time_ and arg_98_1.time_ <= var_101_7 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_8 = 1.2

			if var_101_7 <= arg_98_1.time_ and arg_98_1.time_ < var_101_7 + var_101_8 then
				local var_101_9 = (arg_98_1.time_ - var_101_7) / var_101_8
				local var_101_10 = Color.New(0, 0, 0)

				var_101_10.a = Mathf.Lerp(1, 0, var_101_9)
				arg_98_1.mask_.color = var_101_10
			end

			if arg_98_1.time_ >= var_101_7 + var_101_8 and arg_98_1.time_ < var_101_7 + var_101_8 + arg_101_0 then
				local var_101_11 = Color.New(0, 0, 0)
				local var_101_12 = 0

				arg_98_1.mask_.enabled = false
				var_101_11.a = var_101_12
				arg_98_1.mask_.color = var_101_11
			end

			local var_101_13 = 1.2
			local var_101_14 = 1.999999999999
			local var_101_15 = "H04"

			if var_101_13 < arg_98_1.time_ and arg_98_1.time_ <= var_101_13 + arg_101_0 then
				arg_98_1.timestampController_:SetSelectedState("show")
				arg_98_1.timestampAni_:Play("in")

				arg_98_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_15)

				arg_98_1.timestampColorController_:SetSelectedState("hot")
				arg_98_1.timeColdImg_:SetAlpha(0.031)

				local var_101_16 = arg_98_1:GetWordFromCfg(501108)
				local var_101_17 = arg_98_1:FormatText(var_101_16.content)

				arg_98_1.text_timeText_.text = var_101_17

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_timeText_)

				local var_101_18 = arg_98_1:GetWordFromCfg(501109)
				local var_101_19 = arg_98_1:FormatText(var_101_18.content)

				arg_98_1.text_siteText_.text = var_101_19

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_siteText_)
			end

			if arg_98_1.time_ >= var_101_13 + var_101_14 and arg_98_1.time_ < var_101_13 + var_101_14 + arg_101_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_98_1.timestampAni_, "out", function()
					arg_98_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_101_20 = 3.20000033333333

			if var_101_20 < arg_98_1.time_ and arg_98_1.time_ <= var_101_20 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_21 = 1.2

			if var_101_20 <= arg_98_1.time_ and arg_98_1.time_ < var_101_20 + var_101_21 then
				local var_101_22 = (arg_98_1.time_ - var_101_20) / var_101_21
				local var_101_23 = Color.New(0, 0, 0)

				var_101_23.a = Mathf.Lerp(0, 1, var_101_22)
				arg_98_1.mask_.color = var_101_23
			end

			if arg_98_1.time_ >= var_101_20 + var_101_21 and arg_98_1.time_ < var_101_20 + var_101_21 + arg_101_0 then
				local var_101_24 = Color.New(0, 0, 0)

				var_101_24.a = 1
				arg_98_1.mask_.color = var_101_24
			end

			local var_101_25 = 4.40000033333333

			if var_101_25 < arg_98_1.time_ and arg_98_1.time_ <= var_101_25 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_26 = 1.2

			if var_101_25 <= arg_98_1.time_ and arg_98_1.time_ < var_101_25 + var_101_26 then
				local var_101_27 = (arg_98_1.time_ - var_101_25) / var_101_26
				local var_101_28 = Color.New(0, 0, 0)

				var_101_28.a = Mathf.Lerp(1, 0, var_101_27)
				arg_98_1.mask_.color = var_101_28
			end

			if arg_98_1.time_ >= var_101_25 + var_101_26 and arg_98_1.time_ < var_101_25 + var_101_26 + arg_101_0 then
				local var_101_29 = Color.New(0, 0, 0)
				local var_101_30 = 0

				arg_98_1.mask_.enabled = false
				var_101_29.a = var_101_30
				arg_98_1.mask_.color = var_101_29
			end

			local var_101_31 = "H04"

			if arg_98_1.bgs_[var_101_31] == nil then
				local var_101_32 = Object.Instantiate(arg_98_1.paintGo_)

				var_101_32:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_101_31)
				var_101_32.name = var_101_31
				var_101_32.transform.parent = arg_98_1.stage_.transform
				var_101_32.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.bgs_[var_101_31] = var_101_32
			end

			local var_101_33 = 1.2

			if var_101_33 < arg_98_1.time_ and arg_98_1.time_ <= var_101_33 + arg_101_0 then
				local var_101_34 = manager.ui.mainCamera.transform.localPosition
				local var_101_35 = Vector3.New(0, 0, 10) + Vector3.New(var_101_34.x, var_101_34.y, 0)
				local var_101_36 = arg_98_1.bgs_.H04

				var_101_36.transform.localPosition = var_101_35
				var_101_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_37 = var_101_36:GetComponent("SpriteRenderer")

				if var_101_37 and var_101_37.sprite then
					local var_101_38 = (var_101_36.transform.localPosition - var_101_34).z
					local var_101_39 = manager.ui.mainCameraCom_
					local var_101_40 = 2 * var_101_38 * Mathf.Tan(var_101_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_41 = var_101_40 * var_101_39.aspect
					local var_101_42 = var_101_37.sprite.bounds.size.x
					local var_101_43 = var_101_37.sprite.bounds.size.y
					local var_101_44 = var_101_41 / var_101_42
					local var_101_45 = var_101_40 / var_101_43
					local var_101_46 = var_101_45 < var_101_44 and var_101_44 or var_101_45

					var_101_36.transform.localScale = Vector3.New(var_101_46, var_101_46, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "H04" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_47 = 3.96666666666667
			local var_101_48 = 1

			if var_101_47 < arg_98_1.time_ and arg_98_1.time_ <= var_101_47 + arg_101_0 then
				local var_101_49 = "play"
				local var_101_50 = "effect"

				arg_98_1:AudioAction(var_101_49, var_101_50, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_101_51 = 0.133333333333333
			local var_101_52 = 1

			if var_101_51 < arg_98_1.time_ and arg_98_1.time_ <= var_101_51 + arg_101_0 then
				local var_101_53 = "stop"
				local var_101_54 = "effect"

				arg_98_1:AudioAction(var_101_53, var_101_54, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_55 = 5.60000033333333
			local var_101_56 = 0.275

			if var_101_55 < arg_98_1.time_ and arg_98_1.time_ <= var_101_55 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_57 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_57:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_98_1.dialogCg_.alpha = arg_103_0
				end))
				var_101_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_58 = arg_98_1:FormatText(StoryNameCfg[56].name)

				arg_98_1.leftNameTxt_.text = var_101_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_59 = arg_98_1:GetWordFromCfg(425071024)
				local var_101_60 = arg_98_1:FormatText(var_101_59.content)

				arg_98_1.text_.text = var_101_60

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_61 = 11
				local var_101_62 = utf8.len(var_101_60)
				local var_101_63 = var_101_61 <= 0 and var_101_56 or var_101_56 * (var_101_62 / var_101_61)

				if var_101_63 > 0 and var_101_56 < var_101_63 then
					arg_98_1.talkMaxDuration = var_101_63
					var_101_55 = var_101_55 + 0.3

					if var_101_63 + var_101_55 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_63 + var_101_55
					end
				end

				arg_98_1.text_.text = var_101_60
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071024", "story_v_out_425071.awb") ~= 0 then
					local var_101_64 = manager.audio:GetVoiceLength("story_v_out_425071", "425071024", "story_v_out_425071.awb") / 1000

					if var_101_64 + var_101_55 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_64 + var_101_55
					end

					if var_101_59.prefab_name ~= "" and arg_98_1.actors_[var_101_59.prefab_name] ~= nil then
						local var_101_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_59.prefab_name].transform, "story_v_out_425071", "425071024", "story_v_out_425071.awb")

						arg_98_1:RecordAudio("425071024", var_101_65)
						arg_98_1:RecordAudio("425071024", var_101_65)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_425071", "425071024", "story_v_out_425071.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_425071", "425071024", "story_v_out_425071.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_66 = var_101_55 + 0.3
			local var_101_67 = math.max(var_101_56, arg_98_1.talkMaxDuration)

			if var_101_66 <= arg_98_1.time_ and arg_98_1.time_ < var_101_66 + var_101_67 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_66) / var_101_67

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_66 + var_101_67 and arg_98_1.time_ < var_101_66 + var_101_67 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.2,
				startTime = 5.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.ACTOR_SPRITE,
				offset = Vector3.New(10, 10, 0)
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play425071025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 425071025
		arg_105_1.duration_ = 13.4

		local var_105_0 = {
			zh = 8.69933333333333,
			ja = 13.3993333333333
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
				arg_105_0:Play425071026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				local var_108_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_2 then
					var_108_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_2.radialBlurScale = 0
					var_108_2.radialBlurGradient = 1
					var_108_2.radialBlurIntensity = 0

					if var_108_0 then
						var_108_2.radialBlurTarget = var_108_0.transform
					end
				end
			end

			local var_108_3 = 1

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_3 then
				local var_108_4 = (arg_105_1.time_ - var_108_1) / var_108_3
				local var_108_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_5 then
					var_108_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_5.radialBlurScale = Mathf.Lerp(0, 0.8, var_108_4)
					var_108_5.radialBlurGradient = Mathf.Lerp(1, 1, var_108_4)
					var_108_5.radialBlurIntensity = Mathf.Lerp(0, 0.8, var_108_4)
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_3 and arg_105_1.time_ < var_108_1 + var_108_3 + arg_108_0 then
				local var_108_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_108_6 then
					var_108_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_108_6.radialBlurScale = 0.8
					var_108_6.radialBlurGradient = 1
					var_108_6.radialBlurIntensity = 0.8
				end
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_7 = 0.733333333333333
			local var_108_8 = 0.5

			if var_108_7 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_9 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_9:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_10 = arg_105_1:FormatText(StoryNameCfg[15].name)

				arg_105_1.leftNameTxt_.text = var_108_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_11 = arg_105_1:GetWordFromCfg(425071025)
				local var_108_12 = arg_105_1:FormatText(var_108_11.content)

				arg_105_1.text_.text = var_108_12

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 20
				local var_108_14 = utf8.len(var_108_12)
				local var_108_15 = var_108_13 <= 0 and var_108_8 or var_108_8 * (var_108_14 / var_108_13)

				if var_108_15 > 0 and var_108_8 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15
					var_108_7 = var_108_7 + 0.3

					if var_108_15 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_7
					end
				end

				arg_105_1.text_.text = var_108_12
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071025", "story_v_out_425071.awb") ~= 0 then
					local var_108_16 = manager.audio:GetVoiceLength("story_v_out_425071", "425071025", "story_v_out_425071.awb") / 1000

					if var_108_16 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_7
					end

					if var_108_11.prefab_name ~= "" and arg_105_1.actors_[var_108_11.prefab_name] ~= nil then
						local var_108_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_11.prefab_name].transform, "story_v_out_425071", "425071025", "story_v_out_425071.awb")

						arg_105_1:RecordAudio("425071025", var_108_17)
						arg_105_1:RecordAudio("425071025", var_108_17)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_425071", "425071025", "story_v_out_425071.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_425071", "425071025", "story_v_out_425071.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_18 = var_108_7 + 0.3
			local var_108_19 = math.max(var_108_8, arg_105_1.talkMaxDuration)

			if var_108_18 <= arg_105_1.time_ and arg_105_1.time_ < var_108_18 + var_108_19 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_18) / var_108_19

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_18 + var_108_19 and arg_105_1.time_ < var_108_18 + var_108_19 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play425071026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 425071026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play425071027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				local var_114_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_2 then
					var_114_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_2.radialBlurScale = 0.8
					var_114_2.radialBlurGradient = 1
					var_114_2.radialBlurIntensity = 0.8

					if var_114_0 then
						var_114_2.radialBlurTarget = var_114_0.transform
					end
				end
			end

			local var_114_3 = 1

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_3 then
				local var_114_4 = (arg_111_1.time_ - var_114_1) / var_114_3
				local var_114_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_5 then
					var_114_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_5.radialBlurScale = Mathf.Lerp(0.8, 0, var_114_4)
					var_114_5.radialBlurGradient = Mathf.Lerp(1, 1, var_114_4)
					var_114_5.radialBlurIntensity = Mathf.Lerp(0.8, 0, var_114_4)
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_3 and arg_111_1.time_ < var_114_1 + var_114_3 + arg_114_0 then
				local var_114_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_6 then
					var_114_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_6.radialBlurScale = 0
					var_114_6.radialBlurGradient = 1
					var_114_6.radialBlurIntensity = 0
				end
			end

			local var_114_7 = 0
			local var_114_8 = 1.5

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:GetWordFromCfg(425071026)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 60
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_8 or var_114_8 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_8 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_7 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_7
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_8, arg_111_1.talkMaxDuration)

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_7) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_7 + var_114_14 and arg_111_1.time_ < var_114_7 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play425071027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 425071027
		arg_115_1.duration_ = 5.03

		local var_115_0 = {
			zh = 3.9,
			ja = 5.033
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
				arg_115_0:Play425071028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "10127"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_118_1) then
					local var_118_2 = Object.Instantiate(var_118_1, arg_115_1.canvasGo_.transform)

					var_118_2.transform:SetSiblingIndex(1)

					var_118_2.name = var_118_0
					var_118_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_115_1.actors_[var_118_0] = var_118_2

					local var_118_3 = var_118_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_115_1.isInRecall_ then
						for iter_118_0, iter_118_1 in ipairs(var_118_3) do
							iter_118_1.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_118_4 = arg_115_1.actors_["10127"]
			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.actorSpriteComps10127 == nil then
				arg_115_1.var_.actorSpriteComps10127 = var_118_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_6 = 0.2

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_6 and not isNil(var_118_4) then
				local var_118_7 = (arg_115_1.time_ - var_118_5) / var_118_6

				if arg_115_1.var_.actorSpriteComps10127 then
					for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_118_3 then
							if arg_115_1.isInRecall_ then
								local var_118_8 = Mathf.Lerp(iter_118_3.color.r, arg_115_1.hightColor1.r, var_118_7)
								local var_118_9 = Mathf.Lerp(iter_118_3.color.g, arg_115_1.hightColor1.g, var_118_7)
								local var_118_10 = Mathf.Lerp(iter_118_3.color.b, arg_115_1.hightColor1.b, var_118_7)

								iter_118_3.color = Color.New(var_118_8, var_118_9, var_118_10)
							else
								local var_118_11 = Mathf.Lerp(iter_118_3.color.r, 1, var_118_7)

								iter_118_3.color = Color.New(var_118_11, var_118_11, var_118_11)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_5 + var_118_6 and arg_115_1.time_ < var_118_5 + var_118_6 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.actorSpriteComps10127 then
				for iter_118_4, iter_118_5 in pairs(arg_115_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_118_5 then
						if arg_115_1.isInRecall_ then
							iter_118_5.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10127 = nil
			end

			local var_118_12 = arg_115_1.actors_["10127"].transform
			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1.var_.moveOldPos10127 = var_118_12.localPosition
				var_118_12.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10127", 3)

				local var_118_14 = var_118_12.childCount

				for iter_118_6 = 0, var_118_14 - 1 do
					local var_118_15 = var_118_12:GetChild(iter_118_6)

					if var_118_15.name == "split_6" or not string.find(var_118_15.name, "split") then
						var_118_15.gameObject:SetActive(true)
					else
						var_118_15.gameObject:SetActive(false)
					end
				end
			end

			local var_118_16 = 0.001

			if var_118_13 <= arg_115_1.time_ and arg_115_1.time_ < var_118_13 + var_118_16 then
				local var_118_17 = (arg_115_1.time_ - var_118_13) / var_118_16
				local var_118_18 = Vector3.New(0, -387.4, -316.5)

				var_118_12.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10127, var_118_18, var_118_17)
			end

			if arg_115_1.time_ >= var_118_13 + var_118_16 and arg_115_1.time_ < var_118_13 + var_118_16 + arg_118_0 then
				var_118_12.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_118_19 = 0
			local var_118_20 = 0.425

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_21 = arg_115_1:FormatText(StoryNameCfg[236].name)

				arg_115_1.leftNameTxt_.text = var_118_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_22 = arg_115_1:GetWordFromCfg(425071027)
				local var_118_23 = arg_115_1:FormatText(var_118_22.content)

				arg_115_1.text_.text = var_118_23

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_24 = 17
				local var_118_25 = utf8.len(var_118_23)
				local var_118_26 = var_118_24 <= 0 and var_118_20 or var_118_20 * (var_118_25 / var_118_24)

				if var_118_26 > 0 and var_118_20 < var_118_26 then
					arg_115_1.talkMaxDuration = var_118_26

					if var_118_26 + var_118_19 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_26 + var_118_19
					end
				end

				arg_115_1.text_.text = var_118_23
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071027", "story_v_out_425071.awb") ~= 0 then
					local var_118_27 = manager.audio:GetVoiceLength("story_v_out_425071", "425071027", "story_v_out_425071.awb") / 1000

					if var_118_27 + var_118_19 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_27 + var_118_19
					end

					if var_118_22.prefab_name ~= "" and arg_115_1.actors_[var_118_22.prefab_name] ~= nil then
						local var_118_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_22.prefab_name].transform, "story_v_out_425071", "425071027", "story_v_out_425071.awb")

						arg_115_1:RecordAudio("425071027", var_118_28)
						arg_115_1:RecordAudio("425071027", var_118_28)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_425071", "425071027", "story_v_out_425071.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_425071", "425071027", "story_v_out_425071.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_29 = math.max(var_118_20, arg_115_1.talkMaxDuration)

			if var_118_19 <= arg_115_1.time_ and arg_115_1.time_ < var_118_19 + var_118_29 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_19) / var_118_29

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_19 + var_118_29 and arg_115_1.time_ < var_118_19 + var_118_29 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play425071028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 425071028
		arg_119_1.duration_ = 4.6

		local var_119_0 = {
			zh = 3.7,
			ja = 4.6
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
				arg_119_0:Play425071029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10127"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10127 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10127", 7)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(0, -2000, 0)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10127, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_7 = 0
			local var_122_8 = 0.35

			if var_122_7 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_9 = arg_119_1:FormatText(StoryNameCfg[15].name)

				arg_119_1.leftNameTxt_.text = var_122_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_10 = arg_119_1:GetWordFromCfg(425071028)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_12 = 14
				local var_122_13 = utf8.len(var_122_11)
				local var_122_14 = var_122_12 <= 0 and var_122_8 or var_122_8 * (var_122_13 / var_122_12)

				if var_122_14 > 0 and var_122_8 < var_122_14 then
					arg_119_1.talkMaxDuration = var_122_14

					if var_122_14 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_7
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071028", "story_v_out_425071.awb") ~= 0 then
					local var_122_15 = manager.audio:GetVoiceLength("story_v_out_425071", "425071028", "story_v_out_425071.awb") / 1000

					if var_122_15 + var_122_7 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_7
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_425071", "425071028", "story_v_out_425071.awb")

						arg_119_1:RecordAudio("425071028", var_122_16)
						arg_119_1:RecordAudio("425071028", var_122_16)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_425071", "425071028", "story_v_out_425071.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_425071", "425071028", "story_v_out_425071.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_17 = math.max(var_122_8, arg_119_1.talkMaxDuration)

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_17 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_7) / var_122_17

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_7 + var_122_17 and arg_119_1.time_ < var_122_7 + var_122_17 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play425071029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 425071029
		arg_123_1.duration_ = 5.5

		local var_123_0 = {
			zh = 4,
			ja = 5.5
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
				arg_123_0:Play425071030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.425

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[56].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(425071029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071029", "story_v_out_425071.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071029", "story_v_out_425071.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_425071", "425071029", "story_v_out_425071.awb")

						arg_123_1:RecordAudio("425071029", var_126_9)
						arg_123_1:RecordAudio("425071029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_425071", "425071029", "story_v_out_425071.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_425071", "425071029", "story_v_out_425071.awb")
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
	Play425071030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 425071030
		arg_127_1.duration_ = 6.57

		local var_127_0 = {
			zh = 4.266,
			ja = 6.566
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
				arg_127_0:Play425071031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.4

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[56].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(425071030)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 16
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071030", "story_v_out_425071.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071030", "story_v_out_425071.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_425071", "425071030", "story_v_out_425071.awb")

						arg_127_1:RecordAudio("425071030", var_130_9)
						arg_127_1:RecordAudio("425071030", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_425071", "425071030", "story_v_out_425071.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_425071", "425071030", "story_v_out_425071.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play425071031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 425071031
		arg_131_1.duration_ = 5.33

		local var_131_0 = {
			zh = 5.2,
			ja = 5.333
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
				arg_131_0:Play425071032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10127"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10127 == nil then
				arg_131_1.var_.actorSpriteComps10127 = var_134_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_2 = 0.2

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.actorSpriteComps10127 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								local var_134_4 = Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, var_134_3)
								local var_134_5 = Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, var_134_3)
								local var_134_6 = Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, var_134_3)

								iter_134_1.color = Color.New(var_134_4, var_134_5, var_134_6)
							else
								local var_134_7 = Mathf.Lerp(iter_134_1.color.r, 1, var_134_3)

								iter_134_1.color = Color.New(var_134_7, var_134_7, var_134_7)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.actorSpriteComps10127 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_134_3 then
						if arg_131_1.isInRecall_ then
							iter_134_3.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10127 = nil
			end

			local var_134_8 = arg_131_1.actors_["10127"].transform
			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 then
				arg_131_1.var_.moveOldPos10127 = var_134_8.localPosition
				var_134_8.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10127", 3)

				local var_134_10 = var_134_8.childCount

				for iter_134_4 = 0, var_134_10 - 1 do
					local var_134_11 = var_134_8:GetChild(iter_134_4)

					if var_134_11.name == "split_6" or not string.find(var_134_11.name, "split") then
						var_134_11.gameObject:SetActive(true)
					else
						var_134_11.gameObject:SetActive(false)
					end
				end
			end

			local var_134_12 = 0.001

			if var_134_9 <= arg_131_1.time_ and arg_131_1.time_ < var_134_9 + var_134_12 then
				local var_134_13 = (arg_131_1.time_ - var_134_9) / var_134_12
				local var_134_14 = Vector3.New(0, -387.4, -316.5)

				var_134_8.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10127, var_134_14, var_134_13)
			end

			if arg_131_1.time_ >= var_134_9 + var_134_12 and arg_131_1.time_ < var_134_9 + var_134_12 + arg_134_0 then
				var_134_8.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_134_15 = 0
			local var_134_16 = 0.625

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[236].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(425071031)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 25
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071031", "story_v_out_425071.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_425071", "425071031", "story_v_out_425071.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_425071", "425071031", "story_v_out_425071.awb")

						arg_131_1:RecordAudio("425071031", var_134_24)
						arg_131_1:RecordAudio("425071031", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_425071", "425071031", "story_v_out_425071.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_425071", "425071031", "story_v_out_425071.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play425071032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 425071032
		arg_135_1.duration_ = 3.83

		local var_135_0 = {
			zh = 3.2,
			ja = 3.833
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
				arg_135_0:Play425071033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10127"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10127 == nil then
				arg_135_1.var_.actorSpriteComps10127 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps10127 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								local var_138_4 = Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, var_138_3)
								local var_138_5 = Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, var_138_3)
								local var_138_6 = Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, var_138_3)

								iter_138_1.color = Color.New(var_138_4, var_138_5, var_138_6)
							else
								local var_138_7 = Mathf.Lerp(iter_138_1.color.r, 0.5, var_138_3)

								iter_138_1.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps10127 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10127 = nil
			end

			local var_138_8 = 0
			local var_138_9 = 0.35

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_10 = arg_135_1:FormatText(StoryNameCfg[15].name)

				arg_135_1.leftNameTxt_.text = var_138_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_11 = arg_135_1:GetWordFromCfg(425071032)
				local var_138_12 = arg_135_1:FormatText(var_138_11.content)

				arg_135_1.text_.text = var_138_12

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 14
				local var_138_14 = utf8.len(var_138_12)
				local var_138_15 = var_138_13 <= 0 and var_138_9 or var_138_9 * (var_138_14 / var_138_13)

				if var_138_15 > 0 and var_138_9 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_12
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071032", "story_v_out_425071.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_425071", "425071032", "story_v_out_425071.awb") / 1000

					if var_138_16 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_8
					end

					if var_138_11.prefab_name ~= "" and arg_135_1.actors_[var_138_11.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_11.prefab_name].transform, "story_v_out_425071", "425071032", "story_v_out_425071.awb")

						arg_135_1:RecordAudio("425071032", var_138_17)
						arg_135_1:RecordAudio("425071032", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_425071", "425071032", "story_v_out_425071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_425071", "425071032", "story_v_out_425071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_18 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_18 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_18

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_18 and arg_135_1.time_ < var_138_8 + var_138_18 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play425071033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 425071033
		arg_139_1.duration_ = 7.1

		local var_139_0 = {
			zh = 7.1,
			ja = 6.266
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
				arg_139_0:Play425071034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10127"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10127 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10127", 7)

				local var_142_2 = var_142_0.childCount

				for iter_142_0 = 0, var_142_2 - 1 do
					local var_142_3 = var_142_0:GetChild(iter_142_0)

					if var_142_3.name == "" or not string.find(var_142_3.name, "split") then
						var_142_3.gameObject:SetActive(true)
					else
						var_142_3.gameObject:SetActive(false)
					end
				end
			end

			local var_142_4 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_4 then
				local var_142_5 = (arg_139_1.time_ - var_142_1) / var_142_4
				local var_142_6 = Vector3.New(0, -2000, 0)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10127, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_7 = 0
			local var_142_8 = 0.425

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_9 = arg_139_1:FormatText(StoryNameCfg[56].name)

				arg_139_1.leftNameTxt_.text = var_142_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_10 = arg_139_1:GetWordFromCfg(425071033)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_12 = 17
				local var_142_13 = utf8.len(var_142_11)
				local var_142_14 = var_142_12 <= 0 and var_142_8 or var_142_8 * (var_142_13 / var_142_12)

				if var_142_14 > 0 and var_142_8 < var_142_14 then
					arg_139_1.talkMaxDuration = var_142_14

					if var_142_14 + var_142_7 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_7
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071033", "story_v_out_425071.awb") ~= 0 then
					local var_142_15 = manager.audio:GetVoiceLength("story_v_out_425071", "425071033", "story_v_out_425071.awb") / 1000

					if var_142_15 + var_142_7 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_15 + var_142_7
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_425071", "425071033", "story_v_out_425071.awb")

						arg_139_1:RecordAudio("425071033", var_142_16)
						arg_139_1:RecordAudio("425071033", var_142_16)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_425071", "425071033", "story_v_out_425071.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_425071", "425071033", "story_v_out_425071.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_17 = math.max(var_142_8, arg_139_1.talkMaxDuration)

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_17 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_7) / var_142_17

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_7 + var_142_17 and arg_139_1.time_ < var_142_7 + var_142_17 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play425071034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 425071034
		arg_143_1.duration_ = 8.87

		local var_143_0 = {
			zh = 5.766,
			ja = 8.866
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
				arg_143_0:Play425071035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.525

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[15].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(425071034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 21
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071034", "story_v_out_425071.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071034", "story_v_out_425071.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_425071", "425071034", "story_v_out_425071.awb")

						arg_143_1:RecordAudio("425071034", var_146_9)
						arg_143_1:RecordAudio("425071034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_425071", "425071034", "story_v_out_425071.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_425071", "425071034", "story_v_out_425071.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play425071035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 425071035
		arg_147_1.duration_ = 2.63

		local var_147_0 = {
			zh = 1.733,
			ja = 2.633
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
				arg_147_0:Play425071036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = "1080"

			if arg_147_1.actors_[var_150_0] == nil then
				local var_150_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1080")

				if not isNil(var_150_1) then
					local var_150_2 = Object.Instantiate(var_150_1, arg_147_1.canvasGo_.transform)

					var_150_2.transform:SetSiblingIndex(1)

					var_150_2.name = var_150_0
					var_150_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_147_1.actors_[var_150_0] = var_150_2

					local var_150_3 = var_150_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_147_1.isInRecall_ then
						for iter_150_0, iter_150_1 in ipairs(var_150_3) do
							iter_150_1.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_150_4 = arg_147_1.actors_["1080"]
			local var_150_5 = 0

			if var_150_5 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.actorSpriteComps1080 == nil then
				arg_147_1.var_.actorSpriteComps1080 = var_150_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_6 = 0.2

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_6 and not isNil(var_150_4) then
				local var_150_7 = (arg_147_1.time_ - var_150_5) / var_150_6

				if arg_147_1.var_.actorSpriteComps1080 then
					for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1080:ToTable()) do
						if iter_150_3 then
							if arg_147_1.isInRecall_ then
								local var_150_8 = Mathf.Lerp(iter_150_3.color.r, arg_147_1.hightColor1.r, var_150_7)
								local var_150_9 = Mathf.Lerp(iter_150_3.color.g, arg_147_1.hightColor1.g, var_150_7)
								local var_150_10 = Mathf.Lerp(iter_150_3.color.b, arg_147_1.hightColor1.b, var_150_7)

								iter_150_3.color = Color.New(var_150_8, var_150_9, var_150_10)
							else
								local var_150_11 = Mathf.Lerp(iter_150_3.color.r, 1, var_150_7)

								iter_150_3.color = Color.New(var_150_11, var_150_11, var_150_11)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_5 + var_150_6 and arg_147_1.time_ < var_150_5 + var_150_6 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.actorSpriteComps1080 then
				for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps1080:ToTable()) do
					if iter_150_5 then
						if arg_147_1.isInRecall_ then
							iter_150_5.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1080 = nil
			end

			local var_150_12 = arg_147_1.actors_["1037"]
			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 and not isNil(var_150_12) and arg_147_1.var_.actorSpriteComps1037 == nil then
				arg_147_1.var_.actorSpriteComps1037 = var_150_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_14 = 0.2

			if var_150_13 <= arg_147_1.time_ and arg_147_1.time_ < var_150_13 + var_150_14 and not isNil(var_150_12) then
				local var_150_15 = (arg_147_1.time_ - var_150_13) / var_150_14

				if arg_147_1.var_.actorSpriteComps1037 then
					for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_150_7 then
							if arg_147_1.isInRecall_ then
								local var_150_16 = Mathf.Lerp(iter_150_7.color.r, arg_147_1.hightColor2.r, var_150_15)
								local var_150_17 = Mathf.Lerp(iter_150_7.color.g, arg_147_1.hightColor2.g, var_150_15)
								local var_150_18 = Mathf.Lerp(iter_150_7.color.b, arg_147_1.hightColor2.b, var_150_15)

								iter_150_7.color = Color.New(var_150_16, var_150_17, var_150_18)
							else
								local var_150_19 = Mathf.Lerp(iter_150_7.color.r, 0.5, var_150_15)

								iter_150_7.color = Color.New(var_150_19, var_150_19, var_150_19)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_13 + var_150_14 and arg_147_1.time_ < var_150_13 + var_150_14 + arg_150_0 and not isNil(var_150_12) and arg_147_1.var_.actorSpriteComps1037 then
				for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_150_9 then
						if arg_147_1.isInRecall_ then
							iter_150_9.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps1037 = nil
			end

			local var_150_20 = arg_147_1.actors_["1080"].transform
			local var_150_21 = 0

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1.var_.moveOldPos1080 = var_150_20.localPosition
				var_150_20.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1080", 3)

				local var_150_22 = var_150_20.childCount

				for iter_150_10 = 0, var_150_22 - 1 do
					local var_150_23 = var_150_20:GetChild(iter_150_10)

					if var_150_23.name == "" or not string.find(var_150_23.name, "split") then
						var_150_23.gameObject:SetActive(true)
					else
						var_150_23.gameObject:SetActive(false)
					end
				end
			end

			local var_150_24 = 0.001

			if var_150_21 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_24 then
				local var_150_25 = (arg_147_1.time_ - var_150_21) / var_150_24
				local var_150_26 = Vector3.New(0, -378, -170)

				var_150_20.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1080, var_150_26, var_150_25)
			end

			if arg_147_1.time_ >= var_150_21 + var_150_24 and arg_147_1.time_ < var_150_21 + var_150_24 + arg_150_0 then
				var_150_20.localPosition = Vector3.New(0, -378, -170)
			end

			local var_150_27 = 0
			local var_150_28 = 0.175

			if var_150_27 < arg_147_1.time_ and arg_147_1.time_ <= var_150_27 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_29 = arg_147_1:FormatText(StoryNameCfg[15].name)

				arg_147_1.leftNameTxt_.text = var_150_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_30 = arg_147_1:GetWordFromCfg(425071035)
				local var_150_31 = arg_147_1:FormatText(var_150_30.content)

				arg_147_1.text_.text = var_150_31

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_32 = 7
				local var_150_33 = utf8.len(var_150_31)
				local var_150_34 = var_150_32 <= 0 and var_150_28 or var_150_28 * (var_150_33 / var_150_32)

				if var_150_34 > 0 and var_150_28 < var_150_34 then
					arg_147_1.talkMaxDuration = var_150_34

					if var_150_34 + var_150_27 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_34 + var_150_27
					end
				end

				arg_147_1.text_.text = var_150_31
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071035", "story_v_out_425071.awb") ~= 0 then
					local var_150_35 = manager.audio:GetVoiceLength("story_v_out_425071", "425071035", "story_v_out_425071.awb") / 1000

					if var_150_35 + var_150_27 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_35 + var_150_27
					end

					if var_150_30.prefab_name ~= "" and arg_147_1.actors_[var_150_30.prefab_name] ~= nil then
						local var_150_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_30.prefab_name].transform, "story_v_out_425071", "425071035", "story_v_out_425071.awb")

						arg_147_1:RecordAudio("425071035", var_150_36)
						arg_147_1:RecordAudio("425071035", var_150_36)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_425071", "425071035", "story_v_out_425071.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_425071", "425071035", "story_v_out_425071.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_37 = math.max(var_150_28, arg_147_1.talkMaxDuration)

			if var_150_27 <= arg_147_1.time_ and arg_147_1.time_ < var_150_27 + var_150_37 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_27) / var_150_37

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_27 + var_150_37 and arg_147_1.time_ < var_150_27 + var_150_37 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play425071036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 425071036
		arg_151_1.duration_ = 10.87

		local var_151_0 = {
			zh = 7.033,
			ja = 10.866
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
				arg_151_0:Play425071037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1080"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos1080 = var_154_0.localPosition
				var_154_0.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1080", 7)

				local var_154_2 = var_154_0.childCount

				for iter_154_0 = 0, var_154_2 - 1 do
					local var_154_3 = var_154_0:GetChild(iter_154_0)

					if var_154_3.name == "" or not string.find(var_154_3.name, "split") then
						var_154_3.gameObject:SetActive(true)
					else
						var_154_3.gameObject:SetActive(false)
					end
				end
			end

			local var_154_4 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_4 then
				local var_154_5 = (arg_151_1.time_ - var_154_1) / var_154_4
				local var_154_6 = Vector3.New(0, -2000, 0)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1080, var_154_6, var_154_5)
			end

			if arg_151_1.time_ >= var_154_1 + var_154_4 and arg_151_1.time_ < var_154_1 + var_154_4 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_154_7 = 0
			local var_154_8 = 0.85

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_9 = arg_151_1:FormatText(StoryNameCfg[15].name)

				arg_151_1.leftNameTxt_.text = var_154_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_10 = arg_151_1:GetWordFromCfg(425071036)
				local var_154_11 = arg_151_1:FormatText(var_154_10.content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_12 = 34
				local var_154_13 = utf8.len(var_154_11)
				local var_154_14 = var_154_12 <= 0 and var_154_8 or var_154_8 * (var_154_13 / var_154_12)

				if var_154_14 > 0 and var_154_8 < var_154_14 then
					arg_151_1.talkMaxDuration = var_154_14

					if var_154_14 + var_154_7 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_14 + var_154_7
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071036", "story_v_out_425071.awb") ~= 0 then
					local var_154_15 = manager.audio:GetVoiceLength("story_v_out_425071", "425071036", "story_v_out_425071.awb") / 1000

					if var_154_15 + var_154_7 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_15 + var_154_7
					end

					if var_154_10.prefab_name ~= "" and arg_151_1.actors_[var_154_10.prefab_name] ~= nil then
						local var_154_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_10.prefab_name].transform, "story_v_out_425071", "425071036", "story_v_out_425071.awb")

						arg_151_1:RecordAudio("425071036", var_154_16)
						arg_151_1:RecordAudio("425071036", var_154_16)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_425071", "425071036", "story_v_out_425071.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_425071", "425071036", "story_v_out_425071.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_17 = math.max(var_154_8, arg_151_1.talkMaxDuration)

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_17 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_7) / var_154_17

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_7 + var_154_17 and arg_151_1.time_ < var_154_7 + var_154_17 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play425071037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 425071037
		arg_155_1.duration_ = 1.5

		local var_155_0 = {
			zh = 1.266,
			ja = 1.5
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
				arg_155_0:Play425071038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.1

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[56].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(425071037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071037", "story_v_out_425071.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071037", "story_v_out_425071.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_425071", "425071037", "story_v_out_425071.awb")

						arg_155_1:RecordAudio("425071037", var_158_9)
						arg_155_1:RecordAudio("425071037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_425071", "425071037", "story_v_out_425071.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_425071", "425071037", "story_v_out_425071.awb")
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
	Play425071038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 425071038
		arg_159_1.duration_ = 5

		local var_159_0 = {
			zh = 2.533,
			ja = 5
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
				arg_159_0:Play425071039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.275

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[55].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:GetWordFromCfg(425071038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071038", "story_v_out_425071.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071038", "story_v_out_425071.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_425071", "425071038", "story_v_out_425071.awb")

						arg_159_1:RecordAudio("425071038", var_162_9)
						arg_159_1:RecordAudio("425071038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_425071", "425071038", "story_v_out_425071.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_425071", "425071038", "story_v_out_425071.awb")
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
	Play425071039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 425071039
		arg_163_1.duration_ = 5.07

		local var_163_0 = {
			zh = 2.866,
			ja = 5.066
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play425071040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.35

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[55].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(425071039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 14
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071039", "story_v_out_425071.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071039", "story_v_out_425071.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_425071", "425071039", "story_v_out_425071.awb")

						arg_163_1:RecordAudio("425071039", var_166_9)
						arg_163_1:RecordAudio("425071039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_425071", "425071039", "story_v_out_425071.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_425071", "425071039", "story_v_out_425071.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play425071040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 425071040
		arg_167_1.duration_ = 2.87

		local var_167_0 = {
			zh = 2.766,
			ja = 2.866
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play425071041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.2

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[56].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(425071040)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 8
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071040", "story_v_out_425071.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071040", "story_v_out_425071.awb") / 1000

					if var_170_8 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_0
					end

					if var_170_3.prefab_name ~= "" and arg_167_1.actors_[var_170_3.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_3.prefab_name].transform, "story_v_out_425071", "425071040", "story_v_out_425071.awb")

						arg_167_1:RecordAudio("425071040", var_170_9)
						arg_167_1:RecordAudio("425071040", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_425071", "425071040", "story_v_out_425071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_425071", "425071040", "story_v_out_425071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_10 and arg_167_1.time_ < var_170_0 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play425071041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 425071041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play425071042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.698548501357436
			local var_174_1 = 1

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				local var_174_2 = "play"
				local var_174_3 = "effect"

				arg_171_1:AudioAction(var_174_2, var_174_3, "se_story_140", "se_story_140_footstep_run06", "")
			end

			local var_174_4 = 0
			local var_174_5 = 1.125

			if var_174_4 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(425071041)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_8 = 45
				local var_174_9 = utf8.len(var_174_7)
				local var_174_10 = var_174_8 <= 0 and var_174_5 or var_174_5 * (var_174_9 / var_174_8)

				if var_174_10 > 0 and var_174_5 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_11 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_11 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_11

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_11 and arg_171_1.time_ < var_174_4 + var_174_11 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play425071042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 425071042
		arg_175_1.duration_ = 1.87

		local var_175_0 = {
			zh = 1.466,
			ja = 1.866
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
			arg_175_1.auto_ = false
		end

		function arg_175_1.playNext_(arg_177_0)
			arg_175_1.onStoryFinished_()
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.175

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[15].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(425071042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_425071", "425071042", "story_v_out_425071.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_425071", "425071042", "story_v_out_425071.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_425071", "425071042", "story_v_out_425071.awb")

						arg_175_1:RecordAudio("425071042", var_178_9)
						arg_175_1:RecordAudio("425071042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_425071", "425071042", "story_v_out_425071.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_425071", "425071042", "story_v_out_425071.awb")
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
	assets = {
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/H04"
	},
	voices = {
		"story_v_out_425071.awb"
	}
}
