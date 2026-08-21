return {
	Play423111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423111001
		arg_1_1.duration_ = 6.64

		local var_1_0 = {
			zh = 5.474999999998,
			ja = 6.640999999998
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
				arg_1_0:Play423111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0112a"

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
				local var_4_5 = arg_1_1.bgs_.ST0112a

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
					if iter_4_0 ~= "ST0112a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			local var_4_24 = "3054"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "3054")

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

			local var_4_28 = arg_1_1.actors_["3054"]
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps3054 == nil then
				arg_1_1.var_.actorSpriteComps3054 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps3054 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps3054 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps3054 = nil
			end

			local var_4_36 = arg_1_1.actors_["3054"].transform
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos3054 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("3054", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_1" or not string.find(var_4_39.name, "split") then
						var_4_39.gameObject:SetActive(true)
					else
						var_4_39.gameObject:SetActive(false)
					end
				end
			end

			local var_4_40 = 0.1

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_37) / var_4_40
				local var_4_42 = Vector3.New(0, -275, -280)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3054, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -275, -280)
			end

			local var_4_43 = arg_1_1.actors_["3054"]
			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue3054 = var_4_45.alpha
					arg_1_1.var_.characterEffect3054 = var_4_45
				end

				arg_1_1.var_.alphaOldValue3054 = 0
			end

			local var_4_46 = 0.5

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue3054, 1, var_4_47)

				if arg_1_1.var_.characterEffect3054 then
					arg_1_1.var_.characterEffect3054.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect3054 then
				arg_1_1.var_.characterEffect3054.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.3

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

			local var_4_55 = 0.500666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			local var_4_61 = 0.166666666666667
			local var_4_62 = 1

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				local var_4_63 = "play"
				local var_4_64 = "effect"

				arg_1_1:AudioAction(var_4_63, var_4_64, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_65 = 1.974999999998
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

				local var_4_68 = arg_1_1:FormatText(StoryNameCfg[1339].name)

				arg_1_1.leftNameTxt_.text = var_4_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_69 = arg_1_1:GetWordFromCfg(423111001)
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111001", "story_v_out_423111.awb") ~= 0 then
					local var_4_74 = manager.audio:GetVoiceLength("story_v_out_423111", "423111001", "story_v_out_423111.awb") / 1000

					if var_4_74 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_65
					end

					if var_4_69.prefab_name ~= "" and arg_1_1.actors_[var_4_69.prefab_name] ~= nil then
						local var_4_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_69.prefab_name].transform, "story_v_out_423111", "423111001", "story_v_out_423111.awb")

						arg_1_1:RecordAudio("423111001", var_4_75)
						arg_1_1:RecordAudio("423111001", var_4_75)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423111", "423111001", "story_v_out_423111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423111", "423111001", "story_v_out_423111.awb")
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
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play423111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423111002
		arg_9_1.duration_ = 8.2

		local var_9_0 = {
			zh = 4.933,
			ja = 8.2
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
				arg_9_0:Play423111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.55

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[1339].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(423111002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111002", "story_v_out_423111.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111002", "story_v_out_423111.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_423111", "423111002", "story_v_out_423111.awb")

						arg_9_1:RecordAudio("423111002", var_12_9)
						arg_9_1:RecordAudio("423111002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423111", "423111002", "story_v_out_423111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423111", "423111002", "story_v_out_423111.awb")
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
	Play423111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423111003
		arg_13_1.duration_ = 7.1

		local var_13_0 = {
			zh = 7.1,
			ja = 6.433
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
				arg_13_0:Play423111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["3054"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps3054 == nil then
				arg_13_1.var_.actorSpriteComps3054 = var_16_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.actorSpriteComps3054 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								local var_16_4 = Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, var_16_3)
								local var_16_5 = Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, var_16_3)
								local var_16_6 = Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, var_16_3)

								iter_16_1.color = Color.New(var_16_4, var_16_5, var_16_6)
							else
								local var_16_7 = Mathf.Lerp(iter_16_1.color.r, 0.5, var_16_3)

								iter_16_1.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.actorSpriteComps3054 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_16_3 then
						if arg_13_1.isInRecall_ then
							iter_16_3.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps3054 = nil
			end

			local var_16_8 = 0
			local var_16_9 = 0.825

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_10 = arg_13_1:FormatText(StoryNameCfg[1336].name)

				arg_13_1.leftNameTxt_.text = var_16_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_11 = arg_13_1:GetWordFromCfg(423111003)
				local var_16_12 = arg_13_1:FormatText(var_16_11.content)

				arg_13_1.text_.text = var_16_12

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 33
				local var_16_14 = utf8.len(var_16_12)
				local var_16_15 = var_16_13 <= 0 and var_16_9 or var_16_9 * (var_16_14 / var_16_13)

				if var_16_15 > 0 and var_16_9 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_12
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111003", "story_v_out_423111.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111003", "story_v_out_423111.awb") / 1000

					if var_16_16 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_8
					end

					if var_16_11.prefab_name ~= "" and arg_13_1.actors_[var_16_11.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_11.prefab_name].transform, "story_v_out_423111", "423111003", "story_v_out_423111.awb")

						arg_13_1:RecordAudio("423111003", var_16_17)
						arg_13_1:RecordAudio("423111003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423111", "423111003", "story_v_out_423111.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423111", "423111003", "story_v_out_423111.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_18 and arg_13_1.time_ < var_16_8 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play423111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423111004
		arg_17_1.duration_ = 11.87

		local var_17_0 = {
			zh = 11.866,
			ja = 6.666
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
				arg_17_0:Play423111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["3054"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps3054 == nil then
				arg_17_1.var_.actorSpriteComps3054 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps3054 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps3054 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps3054 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 1.4

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[1339].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_11 = arg_17_1:GetWordFromCfg(423111004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 56
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111004", "story_v_out_423111.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111004", "story_v_out_423111.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_423111", "423111004", "story_v_out_423111.awb")

						arg_17_1:RecordAudio("423111004", var_20_17)
						arg_17_1:RecordAudio("423111004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_423111", "423111004", "story_v_out_423111.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_423111", "423111004", "story_v_out_423111.awb")
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
	Play423111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423111005
		arg_21_1.duration_ = 7.8

		local var_21_0 = {
			zh = 7.8,
			ja = 6.533
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
				arg_21_0:Play423111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.8

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[1339].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:GetWordFromCfg(423111005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 32
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111005", "story_v_out_423111.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111005", "story_v_out_423111.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_423111", "423111005", "story_v_out_423111.awb")

						arg_21_1:RecordAudio("423111005", var_24_9)
						arg_21_1:RecordAudio("423111005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423111", "423111005", "story_v_out_423111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423111", "423111005", "story_v_out_423111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play423111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423111006
		arg_25_1.duration_ = 5.2

		local var_25_0 = {
			zh = 4.666,
			ja = 5.2
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
				arg_25_0:Play423111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["3054"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps3054 == nil then
				arg_25_1.var_.actorSpriteComps3054 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps3054 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 0.5, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps3054 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps3054 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 0.55

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[1335].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_11 = arg_25_1:GetWordFromCfg(423111006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 22
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_9 or var_28_9 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_9 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111006", "story_v_out_423111.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111006", "story_v_out_423111.awb") / 1000

					if var_28_16 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_8
					end

					if var_28_11.prefab_name ~= "" and arg_25_1.actors_[var_28_11.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_11.prefab_name].transform, "story_v_out_423111", "423111006", "story_v_out_423111.awb")

						arg_25_1:RecordAudio("423111006", var_28_17)
						arg_25_1:RecordAudio("423111006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423111", "423111006", "story_v_out_423111.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423111", "423111006", "story_v_out_423111.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_18 and arg_25_1.time_ < var_28_8 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play423111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423111007
		arg_29_1.duration_ = 12.33

		local var_29_0 = {
			zh = 12.333,
			ja = 9.4
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
				arg_29_0:Play423111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["3054"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps3054 == nil then
				arg_29_1.var_.actorSpriteComps3054 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps3054 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps3054 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps3054 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 1.225

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_10 = arg_29_1:FormatText(StoryNameCfg[1339].name)

				arg_29_1.leftNameTxt_.text = var_32_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_11 = arg_29_1:GetWordFromCfg(423111007)
				local var_32_12 = arg_29_1:FormatText(var_32_11.content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111007", "story_v_out_423111.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111007", "story_v_out_423111.awb") / 1000

					if var_32_16 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_8
					end

					if var_32_11.prefab_name ~= "" and arg_29_1.actors_[var_32_11.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_11.prefab_name].transform, "story_v_out_423111", "423111007", "story_v_out_423111.awb")

						arg_29_1:RecordAudio("423111007", var_32_17)
						arg_29_1:RecordAudio("423111007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_423111", "423111007", "story_v_out_423111.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_423111", "423111007", "story_v_out_423111.awb")
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
	Play423111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423111008
		arg_33_1.duration_ = 13.2

		local var_33_0 = {
			zh = 9.766,
			ja = 13.2
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
				arg_33_0:Play423111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.15

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[1339].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(423111008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 46
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111008", "story_v_out_423111.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111008", "story_v_out_423111.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_423111", "423111008", "story_v_out_423111.awb")

						arg_33_1:RecordAudio("423111008", var_36_9)
						arg_33_1:RecordAudio("423111008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423111", "423111008", "story_v_out_423111.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423111", "423111008", "story_v_out_423111.awb")
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
	Play423111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423111009
		arg_37_1.duration_ = 5.23

		local var_37_0 = {
			zh = 3.2,
			ja = 5.233
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
				arg_37_0:Play423111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["3054"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps3054 == nil then
				arg_37_1.var_.actorSpriteComps3054 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps3054 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 0.5, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps3054 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps3054 = nil
			end

			local var_40_8 = 0
			local var_40_9 = 0.3

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_10 = arg_37_1:FormatText(StoryNameCfg[1336].name)

				arg_37_1.leftNameTxt_.text = var_40_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_11 = arg_37_1:GetWordFromCfg(423111009)
				local var_40_12 = arg_37_1:FormatText(var_40_11.content)

				arg_37_1.text_.text = var_40_12

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 12
				local var_40_14 = utf8.len(var_40_12)
				local var_40_15 = var_40_13 <= 0 and var_40_9 or var_40_9 * (var_40_14 / var_40_13)

				if var_40_15 > 0 and var_40_9 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15

					if var_40_15 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_12
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111009", "story_v_out_423111.awb") ~= 0 then
					local var_40_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111009", "story_v_out_423111.awb") / 1000

					if var_40_16 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_8
					end

					if var_40_11.prefab_name ~= "" and arg_37_1.actors_[var_40_11.prefab_name] ~= nil then
						local var_40_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_11.prefab_name].transform, "story_v_out_423111", "423111009", "story_v_out_423111.awb")

						arg_37_1:RecordAudio("423111009", var_40_17)
						arg_37_1:RecordAudio("423111009", var_40_17)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423111", "423111009", "story_v_out_423111.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423111", "423111009", "story_v_out_423111.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_18 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_18

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_18 and arg_37_1.time_ < var_40_8 + var_40_18 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423111010
		arg_41_1.duration_ = 13.37

		local var_41_0 = {
			zh = 10.2,
			ja = 13.366
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
				arg_41_0:Play423111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 1.05

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1336].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(423111010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111010", "story_v_out_423111.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111010", "story_v_out_423111.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_423111", "423111010", "story_v_out_423111.awb")

						arg_41_1:RecordAudio("423111010", var_44_9)
						arg_41_1:RecordAudio("423111010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423111", "423111010", "story_v_out_423111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423111", "423111010", "story_v_out_423111.awb")
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
	Play423111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423111011
		arg_45_1.duration_ = 5.5

		local var_45_0 = {
			zh = 3.6,
			ja = 5.5
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
				arg_45_0:Play423111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["3054"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps3054 == nil then
				arg_45_1.var_.actorSpriteComps3054 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps3054 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 1, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps3054 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps3054 = nil
			end

			local var_48_8 = 0
			local var_48_9 = 0.35

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_10 = arg_45_1:FormatText(StoryNameCfg[1339].name)

				arg_45_1.leftNameTxt_.text = var_48_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_11 = arg_45_1:GetWordFromCfg(423111011)
				local var_48_12 = arg_45_1:FormatText(var_48_11.content)

				arg_45_1.text_.text = var_48_12

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 14
				local var_48_14 = utf8.len(var_48_12)
				local var_48_15 = var_48_13 <= 0 and var_48_9 or var_48_9 * (var_48_14 / var_48_13)

				if var_48_15 > 0 and var_48_9 < var_48_15 then
					arg_45_1.talkMaxDuration = var_48_15

					if var_48_15 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_12
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111011", "story_v_out_423111.awb") ~= 0 then
					local var_48_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111011", "story_v_out_423111.awb") / 1000

					if var_48_16 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_8
					end

					if var_48_11.prefab_name ~= "" and arg_45_1.actors_[var_48_11.prefab_name] ~= nil then
						local var_48_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_11.prefab_name].transform, "story_v_out_423111", "423111011", "story_v_out_423111.awb")

						arg_45_1:RecordAudio("423111011", var_48_17)
						arg_45_1:RecordAudio("423111011", var_48_17)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423111", "423111011", "story_v_out_423111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423111", "423111011", "story_v_out_423111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_18 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_18 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_18

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_18 and arg_45_1.time_ < var_48_8 + var_48_18 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play423111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423111012
		arg_49_1.duration_ = 10.53

		local var_49_0 = {
			zh = 6.333,
			ja = 10.533
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
				arg_49_0:Play423111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["3054"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps3054 == nil then
				arg_49_1.var_.actorSpriteComps3054 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps3054 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor2.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor2.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor2.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 0.5, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps3054 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps3054 = nil
			end

			local var_52_8 = 0
			local var_52_9 = 0.825

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_10 = arg_49_1:FormatText(StoryNameCfg[1336].name)

				arg_49_1.leftNameTxt_.text = var_52_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_11 = arg_49_1:GetWordFromCfg(423111012)
				local var_52_12 = arg_49_1:FormatText(var_52_11.content)

				arg_49_1.text_.text = var_52_12

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 33
				local var_52_14 = utf8.len(var_52_12)
				local var_52_15 = var_52_13 <= 0 and var_52_9 or var_52_9 * (var_52_14 / var_52_13)

				if var_52_15 > 0 and var_52_9 < var_52_15 then
					arg_49_1.talkMaxDuration = var_52_15

					if var_52_15 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_15 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_12
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111012", "story_v_out_423111.awb") ~= 0 then
					local var_52_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111012", "story_v_out_423111.awb") / 1000

					if var_52_16 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_8
					end

					if var_52_11.prefab_name ~= "" and arg_49_1.actors_[var_52_11.prefab_name] ~= nil then
						local var_52_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_11.prefab_name].transform, "story_v_out_423111", "423111012", "story_v_out_423111.awb")

						arg_49_1:RecordAudio("423111012", var_52_17)
						arg_49_1:RecordAudio("423111012", var_52_17)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423111", "423111012", "story_v_out_423111.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423111", "423111012", "story_v_out_423111.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_18 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_18 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_18

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_18 and arg_49_1.time_ < var_52_8 + var_52_18 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play423111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423111013
		arg_53_1.duration_ = 11.17

		local var_53_0 = {
			zh = 6.233,
			ja = 11.166
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
				arg_53_0:Play423111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.75

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1336].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(423111013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111013", "story_v_out_423111.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111013", "story_v_out_423111.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_423111", "423111013", "story_v_out_423111.awb")

						arg_53_1:RecordAudio("423111013", var_56_9)
						arg_53_1:RecordAudio("423111013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423111", "423111013", "story_v_out_423111.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423111", "423111013", "story_v_out_423111.awb")
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
	Play423111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423111014
		arg_57_1.duration_ = 6.53

		local var_57_0 = {
			zh = 6.066,
			ja = 6.533
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
				arg_57_0:Play423111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["3054"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps3054 == nil then
				arg_57_1.var_.actorSpriteComps3054 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps3054 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps3054 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps3054 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 0.525

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[1339].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_11 = arg_57_1:GetWordFromCfg(423111014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 21
				local var_60_14 = utf8.len(var_60_12)
				local var_60_15 = var_60_13 <= 0 and var_60_9 or var_60_9 * (var_60_14 / var_60_13)

				if var_60_15 > 0 and var_60_9 < var_60_15 then
					arg_57_1.talkMaxDuration = var_60_15

					if var_60_15 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_15 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_12
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111014", "story_v_out_423111.awb") ~= 0 then
					local var_60_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111014", "story_v_out_423111.awb") / 1000

					if var_60_16 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_8
					end

					if var_60_11.prefab_name ~= "" and arg_57_1.actors_[var_60_11.prefab_name] ~= nil then
						local var_60_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_11.prefab_name].transform, "story_v_out_423111", "423111014", "story_v_out_423111.awb")

						arg_57_1:RecordAudio("423111014", var_60_17)
						arg_57_1:RecordAudio("423111014", var_60_17)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_423111", "423111014", "story_v_out_423111.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_423111", "423111014", "story_v_out_423111.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_18 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_18

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_18 and arg_57_1.time_ < var_60_8 + var_60_18 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play423111015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423111015
		arg_61_1.duration_ = 15

		local var_61_0 = {
			zh = 13.333,
			ja = 15
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
				arg_61_0:Play423111016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 2

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				local var_64_1 = manager.ui.mainCamera.transform.localPosition
				local var_64_2 = Vector3.New(0, 0, 10) + Vector3.New(var_64_1.x, var_64_1.y, 0)
				local var_64_3 = arg_61_1.bgs_.ST0112a

				var_64_3.transform.localPosition = var_64_2
				var_64_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_4 = var_64_3:GetComponent("SpriteRenderer")

				if var_64_4 and var_64_4.sprite then
					local var_64_5 = (var_64_3.transform.localPosition - var_64_1).z
					local var_64_6 = manager.ui.mainCameraCom_
					local var_64_7 = 2 * var_64_5 * Mathf.Tan(var_64_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_64_8 = var_64_7 * var_64_6.aspect
					local var_64_9 = var_64_4.sprite.bounds.size.x
					local var_64_10 = var_64_4.sprite.bounds.size.y
					local var_64_11 = var_64_8 / var_64_9
					local var_64_12 = var_64_7 / var_64_10
					local var_64_13 = var_64_12 < var_64_11 and var_64_11 or var_64_12

					var_64_3.transform.localScale = Vector3.New(var_64_13, var_64_13, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "ST0112a" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_64_14 = 4

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			local var_64_15 = 0.3

			if arg_61_1.time_ >= var_64_14 + var_64_15 and arg_61_1.time_ < var_64_14 + var_64_15 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_17 = 2

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Color.New(0, 0, 0)

				var_64_19.a = Mathf.Lerp(0, 1, var_64_18)
				arg_61_1.mask_.color = var_64_19
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				local var_64_20 = Color.New(0, 0, 0)

				var_64_20.a = 1
				arg_61_1.mask_.color = var_64_20
			end

			local var_64_21 = 2

			if var_64_21 < arg_61_1.time_ and arg_61_1.time_ <= var_64_21 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_22 = 2

			if var_64_21 <= arg_61_1.time_ and arg_61_1.time_ < var_64_21 + var_64_22 then
				local var_64_23 = (arg_61_1.time_ - var_64_21) / var_64_22
				local var_64_24 = Color.New(0, 0, 0)

				var_64_24.a = Mathf.Lerp(1, 0, var_64_23)
				arg_61_1.mask_.color = var_64_24
			end

			if arg_61_1.time_ >= var_64_21 + var_64_22 and arg_61_1.time_ < var_64_21 + var_64_22 + arg_64_0 then
				local var_64_25 = Color.New(0, 0, 0)
				local var_64_26 = 0

				arg_61_1.mask_.enabled = false
				var_64_25.a = var_64_26
				arg_61_1.mask_.color = var_64_25
			end

			local var_64_27 = "1029"

			if arg_61_1.actors_[var_64_27] == nil then
				local var_64_28 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1029")

				if not isNil(var_64_28) then
					local var_64_29 = Object.Instantiate(var_64_28, arg_61_1.canvasGo_.transform)

					var_64_29.transform:SetSiblingIndex(1)

					var_64_29.name = var_64_27
					var_64_29.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_61_1.actors_[var_64_27] = var_64_29

					local var_64_30 = var_64_29:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_61_1.isInRecall_ then
						for iter_64_2, iter_64_3 in ipairs(var_64_30) do
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_64_31 = arg_61_1.actors_["1029"]
			local var_64_32 = 1.96666666666667

			if var_64_32 < arg_61_1.time_ and arg_61_1.time_ <= var_64_32 + arg_64_0 and not isNil(var_64_31) and arg_61_1.var_.actorSpriteComps1029 == nil then
				arg_61_1.var_.actorSpriteComps1029 = var_64_31:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_33 = 0.0333333333333335

			if var_64_32 <= arg_61_1.time_ and arg_61_1.time_ < var_64_32 + var_64_33 and not isNil(var_64_31) then
				local var_64_34 = (arg_61_1.time_ - var_64_32) / var_64_33

				if arg_61_1.var_.actorSpriteComps1029 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_35 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor1.r, var_64_34)
								local var_64_36 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor1.g, var_64_34)
								local var_64_37 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor1.b, var_64_34)

								iter_64_5.color = Color.New(var_64_35, var_64_36, var_64_37)
							else
								local var_64_38 = Mathf.Lerp(iter_64_5.color.r, 1, var_64_34)

								iter_64_5.color = Color.New(var_64_38, var_64_38, var_64_38)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_32 + var_64_33 and arg_61_1.time_ < var_64_32 + var_64_33 + arg_64_0 and not isNil(var_64_31) and arg_61_1.var_.actorSpriteComps1029 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1029 = nil
			end

			local var_64_39 = arg_61_1.actors_["3054"]
			local var_64_40 = 1.96666666666667

			if var_64_40 < arg_61_1.time_ and arg_61_1.time_ <= var_64_40 + arg_64_0 and not isNil(var_64_39) and arg_61_1.var_.actorSpriteComps3054 == nil then
				arg_61_1.var_.actorSpriteComps3054 = var_64_39:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_41 = 0.0333333333333335

			if var_64_40 <= arg_61_1.time_ and arg_61_1.time_ < var_64_40 + var_64_41 and not isNil(var_64_39) then
				local var_64_42 = (arg_61_1.time_ - var_64_40) / var_64_41

				if arg_61_1.var_.actorSpriteComps3054 then
					for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_64_9 then
							if arg_61_1.isInRecall_ then
								local var_64_43 = Mathf.Lerp(iter_64_9.color.r, arg_61_1.hightColor2.r, var_64_42)
								local var_64_44 = Mathf.Lerp(iter_64_9.color.g, arg_61_1.hightColor2.g, var_64_42)
								local var_64_45 = Mathf.Lerp(iter_64_9.color.b, arg_61_1.hightColor2.b, var_64_42)

								iter_64_9.color = Color.New(var_64_43, var_64_44, var_64_45)
							else
								local var_64_46 = Mathf.Lerp(iter_64_9.color.r, 0.5, var_64_42)

								iter_64_9.color = Color.New(var_64_46, var_64_46, var_64_46)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_40 + var_64_41 and arg_61_1.time_ < var_64_40 + var_64_41 + arg_64_0 and not isNil(var_64_39) and arg_61_1.var_.actorSpriteComps3054 then
				for iter_64_10, iter_64_11 in pairs(arg_61_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_64_11 then
						if arg_61_1.isInRecall_ then
							iter_64_11.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps3054 = nil
			end

			local var_64_47 = arg_61_1.actors_["3054"].transform
			local var_64_48 = 1.96666666666667

			if var_64_48 < arg_61_1.time_ and arg_61_1.time_ <= var_64_48 + arg_64_0 then
				arg_61_1.var_.moveOldPos3054 = var_64_47.localPosition
				var_64_47.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("3054", 7)

				local var_64_49 = var_64_47.childCount

				for iter_64_12 = 0, var_64_49 - 1 do
					local var_64_50 = var_64_47:GetChild(iter_64_12)

					if var_64_50.name == "" or not string.find(var_64_50.name, "split") then
						var_64_50.gameObject:SetActive(true)
					else
						var_64_50.gameObject:SetActive(false)
					end
				end
			end

			local var_64_51 = 0.1

			if var_64_48 <= arg_61_1.time_ and arg_61_1.time_ < var_64_48 + var_64_51 then
				local var_64_52 = (arg_61_1.time_ - var_64_48) / var_64_51
				local var_64_53 = Vector3.New(0, -2000, 0)

				var_64_47.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos3054, var_64_53, var_64_52)
			end

			if arg_61_1.time_ >= var_64_48 + var_64_51 and arg_61_1.time_ < var_64_48 + var_64_51 + arg_64_0 then
				var_64_47.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_54 = 0
			local var_64_55 = 0.3

			if var_64_54 < arg_61_1.time_ and arg_61_1.time_ <= var_64_54 + arg_64_0 then
				local var_64_56 = "play"
				local var_64_57 = "music"

				arg_61_1:AudioAction(var_64_56, var_64_57, "ui_battle", "ui_battle_stopbgm", "")

				local var_64_58 = ""
				local var_64_59 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_64_59 ~= "" then
					if arg_61_1.bgmTxt_.text ~= var_64_59 and arg_61_1.bgmTxt_.text ~= "" then
						if arg_61_1.bgmTxt2_.text ~= "" then
							arg_61_1.bgmTxt_.text = arg_61_1.bgmTxt2_.text
						end

						arg_61_1.bgmTxt2_.text = var_64_59

						arg_61_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_61_1.bgmTxt_.text = var_64_59
						arg_61_1.bgmTxt2_.text = var_64_59
					end

					if arg_61_1.bgmTimer then
						arg_61_1.bgmTimer:Stop()

						arg_61_1.bgmTimer = nil
					end

					if arg_61_1.settingData.show_music_name == 1 then
						arg_61_1.musicController:SetSelectedState("show")
						arg_61_1.musicAnimator_:Play("open", 0, 0)

						if arg_61_1.settingData.music_time ~= 0 then
							arg_61_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_61_1.settingData.music_time), function()
								if arg_61_1 == nil or isNil(arg_61_1.bgmTxt_) then
									return
								end

								arg_61_1.musicController:SetSelectedState("hide")
								arg_61_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_64_60 = 0.500666666666667
			local var_64_61 = 1

			if var_64_60 < arg_61_1.time_ and arg_61_1.time_ <= var_64_60 + arg_64_0 then
				local var_64_62 = "play"
				local var_64_63 = "music"

				arg_61_1:AudioAction(var_64_62, var_64_63, "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel.awb")

				local var_64_64 = ""
				local var_64_65 = manager.audio:GetAudioName("bgm_activity_4_4_story_hotel", "bgm_activity_4_4_story_hotel")

				if var_64_65 ~= "" then
					if arg_61_1.bgmTxt_.text ~= var_64_65 and arg_61_1.bgmTxt_.text ~= "" then
						if arg_61_1.bgmTxt2_.text ~= "" then
							arg_61_1.bgmTxt_.text = arg_61_1.bgmTxt2_.text
						end

						arg_61_1.bgmTxt2_.text = var_64_65

						arg_61_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_61_1.bgmTxt_.text = var_64_65
						arg_61_1.bgmTxt2_.text = var_64_65
					end

					if arg_61_1.bgmTimer then
						arg_61_1.bgmTimer:Stop()

						arg_61_1.bgmTimer = nil
					end

					if arg_61_1.settingData.show_music_name == 1 then
						arg_61_1.musicController:SetSelectedState("show")
						arg_61_1.musicAnimator_:Play("open", 0, 0)

						if arg_61_1.settingData.music_time ~= 0 then
							arg_61_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_61_1.settingData.music_time), function()
								if arg_61_1 == nil or isNil(arg_61_1.bgmTxt_) then
									return
								end

								arg_61_1.musicController:SetSelectedState("hide")
								arg_61_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_66 = 4
			local var_64_67 = 0.575

			if var_64_66 < arg_61_1.time_ and arg_61_1.time_ <= var_64_66 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_68 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_68:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_61_1.dialogCg_.alpha = arg_67_0
				end))
				var_64_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_69 = arg_61_1:FormatText(StoryNameCfg[1332].name)

				arg_61_1.leftNameTxt_.text = var_64_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_2")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_70 = arg_61_1:GetWordFromCfg(423111015)
				local var_64_71 = arg_61_1:FormatText(var_64_70.content)

				arg_61_1.text_.text = var_64_71

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_72 = 23
				local var_64_73 = utf8.len(var_64_71)
				local var_64_74 = var_64_72 <= 0 and var_64_67 or var_64_67 * (var_64_73 / var_64_72)

				if var_64_74 > 0 and var_64_67 < var_64_74 then
					arg_61_1.talkMaxDuration = var_64_74
					var_64_66 = var_64_66 + 0.3

					if var_64_74 + var_64_66 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_74 + var_64_66
					end
				end

				arg_61_1.text_.text = var_64_71
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111015", "story_v_out_423111.awb") ~= 0 then
					local var_64_75 = manager.audio:GetVoiceLength("story_v_out_423111", "423111015", "story_v_out_423111.awb") / 1000

					if var_64_75 + var_64_66 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_75 + var_64_66
					end

					if var_64_70.prefab_name ~= "" and arg_61_1.actors_[var_64_70.prefab_name] ~= nil then
						local var_64_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_70.prefab_name].transform, "story_v_out_423111", "423111015", "story_v_out_423111.awb")

						arg_61_1:RecordAudio("423111015", var_64_76)
						arg_61_1:RecordAudio("423111015", var_64_76)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_423111", "423111015", "story_v_out_423111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_423111", "423111015", "story_v_out_423111.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_77 = var_64_66 + 0.3
			local var_64_78 = math.max(var_64_67, arg_61_1.talkMaxDuration)

			if var_64_77 <= arg_61_1.time_ and arg_61_1.time_ < var_64_77 + var_64_78 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_77) / var_64_78

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_77 + var_64_78 and arg_61_1.time_ < var_64_77 + var_64_78 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play423111016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423111016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play423111017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1029"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1029 == nil then
				arg_69_1.var_.actorSpriteComps1029 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps1029 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 0.5, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1029 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1029 = nil
			end

			local var_72_8 = 0
			local var_72_9 = 1.775

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(423111016)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 71
				local var_72_13 = utf8.len(var_72_11)
				local var_72_14 = var_72_12 <= 0 and var_72_9 or var_72_9 * (var_72_13 / var_72_12)

				if var_72_14 > 0 and var_72_9 < var_72_14 then
					arg_69_1.talkMaxDuration = var_72_14

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_15 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_15 and arg_69_1.time_ < var_72_8 + var_72_15 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play423111017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 423111017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play423111018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.375

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(423111017)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 15
				local var_76_6 = utf8.len(var_76_4)
				local var_76_7 = var_76_5 <= 0 and var_76_1 or var_76_1 * (var_76_6 / var_76_5)

				if var_76_7 > 0 and var_76_1 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play423111018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 423111018
		arg_77_1.duration_ = 8.07

		local var_77_0 = {
			zh = 8.066,
			ja = 6
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play423111019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1029"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1029 == nil then
				arg_77_1.var_.actorSpriteComps1029 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps1029 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 1, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps1029 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps1029 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.525

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_10 = arg_77_1:FormatText(StoryNameCfg[1332].name)

				arg_77_1.leftNameTxt_.text = var_80_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_3")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_11 = arg_77_1:GetWordFromCfg(423111018)
				local var_80_12 = arg_77_1:FormatText(var_80_11.content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 21
				local var_80_14 = utf8.len(var_80_12)
				local var_80_15 = var_80_13 <= 0 and var_80_9 or var_80_9 * (var_80_14 / var_80_13)

				if var_80_15 > 0 and var_80_9 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_12
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111018", "story_v_out_423111.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111018", "story_v_out_423111.awb") / 1000

					if var_80_16 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_8
					end

					if var_80_11.prefab_name ~= "" and arg_77_1.actors_[var_80_11.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_11.prefab_name].transform, "story_v_out_423111", "423111018", "story_v_out_423111.awb")

						arg_77_1:RecordAudio("423111018", var_80_17)
						arg_77_1:RecordAudio("423111018", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_423111", "423111018", "story_v_out_423111.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_423111", "423111018", "story_v_out_423111.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_18 and arg_77_1.time_ < var_80_8 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play423111019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 423111019
		arg_81_1.duration_ = 9.87

		local var_81_0 = {
			zh = 9.866,
			ja = 9.1
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
				arg_81_0:Play423111020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.9

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1332].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_2")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(423111019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 36
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111019", "story_v_out_423111.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111019", "story_v_out_423111.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_423111", "423111019", "story_v_out_423111.awb")

						arg_81_1:RecordAudio("423111019", var_84_9)
						arg_81_1:RecordAudio("423111019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_423111", "423111019", "story_v_out_423111.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_423111", "423111019", "story_v_out_423111.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play423111020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423111020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play423111021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1029"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1029 == nil then
				arg_85_1.var_.actorSpriteComps1029 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps1029 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1029:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 0.5, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps1029 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1029:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps1029 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.4

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_10 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_11 = arg_85_1:GetWordFromCfg(423111020)
				local var_88_12 = arg_85_1:FormatText(var_88_11.content)

				arg_85_1.text_.text = var_88_12

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 16
				local var_88_14 = utf8.len(var_88_12)
				local var_88_15 = var_88_13 <= 0 and var_88_9 or var_88_9 * (var_88_14 / var_88_13)

				if var_88_15 > 0 and var_88_9 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15

					if var_88_15 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_12
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play423111021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 423111021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play423111022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.7

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(423111021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 28
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
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play423111022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 423111022
		arg_93_1.duration_ = 8.83

		local var_93_0 = {
			zh = 5.9,
			ja = 8.833
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
				arg_93_0:Play423111023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.625

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[1334].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(423111022)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 25
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111022", "story_v_out_423111.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111022", "story_v_out_423111.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_423111", "423111022", "story_v_out_423111.awb")

						arg_93_1:RecordAudio("423111022", var_96_9)
						arg_93_1:RecordAudio("423111022", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_423111", "423111022", "story_v_out_423111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_423111", "423111022", "story_v_out_423111.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play423111023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 423111023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play423111024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.625

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(423111023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 25
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play423111024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 423111024
		arg_101_1.duration_ = 16

		local var_101_0 = {
			zh = 11.7,
			ja = 16
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
				arg_101_0:Play423111025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.175

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[1334].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(423111024)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 47
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111024", "story_v_out_423111.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111024", "story_v_out_423111.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_423111", "423111024", "story_v_out_423111.awb")

						arg_101_1:RecordAudio("423111024", var_104_9)
						arg_101_1:RecordAudio("423111024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_423111", "423111024", "story_v_out_423111.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_423111", "423111024", "story_v_out_423111.awb")
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
	Play423111025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423111025
		arg_105_1.duration_ = 11.1

		local var_105_0 = {
			zh = 6.366,
			ja = 11.1
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
				arg_105_0:Play423111026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.75

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_2 = arg_105_1:FormatText(StoryNameCfg[1334].name)

				arg_105_1.leftNameTxt_.text = var_108_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(423111025)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111025", "story_v_out_423111.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111025", "story_v_out_423111.awb") / 1000

					if var_108_8 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_0
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_423111", "423111025", "story_v_out_423111.awb")

						arg_105_1:RecordAudio("423111025", var_108_9)
						arg_105_1:RecordAudio("423111025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_423111", "423111025", "story_v_out_423111.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_423111", "423111025", "story_v_out_423111.awb")
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
	Play423111026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 423111026
		arg_109_1.duration_ = 11.67

		local var_109_0 = {
			zh = 8.366,
			ja = 11.666
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
				arg_109_0:Play423111027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = "10148"

			if arg_109_1.actors_[var_112_0] == nil then
				local var_112_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_112_1) then
					local var_112_2 = Object.Instantiate(var_112_1, arg_109_1.canvasGo_.transform)

					var_112_2.transform:SetSiblingIndex(1)

					var_112_2.name = var_112_0
					var_112_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_109_1.actors_[var_112_0] = var_112_2

					local var_112_3 = var_112_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_109_1.isInRecall_ then
						for iter_112_0, iter_112_1 in ipairs(var_112_3) do
							iter_112_1.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_112_4 = arg_109_1.actors_["10148"]
			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.actorSpriteComps10148 == nil then
				arg_109_1.var_.actorSpriteComps10148 = var_112_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_6 = 0.2

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_6 and not isNil(var_112_4) then
				local var_112_7 = (arg_109_1.time_ - var_112_5) / var_112_6

				if arg_109_1.var_.actorSpriteComps10148 then
					for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_112_3 then
							if arg_109_1.isInRecall_ then
								local var_112_8 = Mathf.Lerp(iter_112_3.color.r, arg_109_1.hightColor1.r, var_112_7)
								local var_112_9 = Mathf.Lerp(iter_112_3.color.g, arg_109_1.hightColor1.g, var_112_7)
								local var_112_10 = Mathf.Lerp(iter_112_3.color.b, arg_109_1.hightColor1.b, var_112_7)

								iter_112_3.color = Color.New(var_112_8, var_112_9, var_112_10)
							else
								local var_112_11 = Mathf.Lerp(iter_112_3.color.r, 1, var_112_7)

								iter_112_3.color = Color.New(var_112_11, var_112_11, var_112_11)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_5 + var_112_6 and arg_109_1.time_ < var_112_5 + var_112_6 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.actorSpriteComps10148 then
				for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_112_5 then
						if arg_109_1.isInRecall_ then
							iter_112_5.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10148 = nil
			end

			local var_112_12 = arg_109_1.actors_["10148"].transform
			local var_112_13 = 0

			if var_112_13 < arg_109_1.time_ and arg_109_1.time_ <= var_112_13 + arg_112_0 then
				arg_109_1.var_.moveOldPos10148 = var_112_12.localPosition
				var_112_12.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10148", 3)

				local var_112_14 = var_112_12.childCount

				for iter_112_6 = 0, var_112_14 - 1 do
					local var_112_15 = var_112_12:GetChild(iter_112_6)

					if var_112_15.name == "split_4" or not string.find(var_112_15.name, "split") then
						var_112_15.gameObject:SetActive(true)
					else
						var_112_15.gameObject:SetActive(false)
					end
				end
			end

			local var_112_16 = 0.001

			if var_112_13 <= arg_109_1.time_ and arg_109_1.time_ < var_112_13 + var_112_16 then
				local var_112_17 = (arg_109_1.time_ - var_112_13) / var_112_16
				local var_112_18 = Vector3.New(0, -350, -270)

				var_112_12.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10148, var_112_18, var_112_17)
			end

			if arg_109_1.time_ >= var_112_13 + var_112_16 and arg_109_1.time_ < var_112_13 + var_112_16 + arg_112_0 then
				var_112_12.localPosition = Vector3.New(0, -350, -270)
			end

			local var_112_19 = 0
			local var_112_20 = 1.125

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_21 = arg_109_1:FormatText(StoryNameCfg[1331].name)

				arg_109_1.leftNameTxt_.text = var_112_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_22 = arg_109_1:GetWordFromCfg(423111026)
				local var_112_23 = arg_109_1:FormatText(var_112_22.content)

				arg_109_1.text_.text = var_112_23

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_24 = 45
				local var_112_25 = utf8.len(var_112_23)
				local var_112_26 = var_112_24 <= 0 and var_112_20 or var_112_20 * (var_112_25 / var_112_24)

				if var_112_26 > 0 and var_112_20 < var_112_26 then
					arg_109_1.talkMaxDuration = var_112_26

					if var_112_26 + var_112_19 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_26 + var_112_19
					end
				end

				arg_109_1.text_.text = var_112_23
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111026", "story_v_out_423111.awb") ~= 0 then
					local var_112_27 = manager.audio:GetVoiceLength("story_v_out_423111", "423111026", "story_v_out_423111.awb") / 1000

					if var_112_27 + var_112_19 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_27 + var_112_19
					end

					if var_112_22.prefab_name ~= "" and arg_109_1.actors_[var_112_22.prefab_name] ~= nil then
						local var_112_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_22.prefab_name].transform, "story_v_out_423111", "423111026", "story_v_out_423111.awb")

						arg_109_1:RecordAudio("423111026", var_112_28)
						arg_109_1:RecordAudio("423111026", var_112_28)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_423111", "423111026", "story_v_out_423111.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_423111", "423111026", "story_v_out_423111.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_29 = math.max(var_112_20, arg_109_1.talkMaxDuration)

			if var_112_19 <= arg_109_1.time_ and arg_109_1.time_ < var_112_19 + var_112_29 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_19) / var_112_29

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_19 + var_112_29 and arg_109_1.time_ < var_112_19 + var_112_29 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play423111027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 423111027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play423111028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10148"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10148 == nil then
				arg_113_1.var_.actorSpriteComps10148 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps10148 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 0.5, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10148 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10148 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 0.475

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_10 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_11 = arg_113_1:GetWordFromCfg(423111027)
				local var_116_12 = arg_113_1:FormatText(var_116_11.content)

				arg_113_1.text_.text = var_116_12

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 19
				local var_116_14 = utf8.len(var_116_12)
				local var_116_15 = var_116_13 <= 0 and var_116_9 or var_116_9 * (var_116_14 / var_116_13)

				if var_116_15 > 0 and var_116_9 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15

					if var_116_15 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_12
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play423111028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 423111028
		arg_117_1.duration_ = 14.17

		local var_117_0 = {
			zh = 8.633,
			ja = 14.166
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play423111029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10148"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10148 == nil then
				arg_117_1.var_.actorSpriteComps10148 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 0.2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10148 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 1, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10148 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10148 = nil
			end

			local var_120_8 = arg_117_1.actors_["10148"].transform
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.var_.moveOldPos10148 = var_120_8.localPosition
				var_120_8.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10148", 3)

				local var_120_10 = var_120_8.childCount

				for iter_120_4 = 0, var_120_10 - 1 do
					local var_120_11 = var_120_8:GetChild(iter_120_4)

					if var_120_11.name == "" or not string.find(var_120_11.name, "split") then
						var_120_11.gameObject:SetActive(true)
					else
						var_120_11.gameObject:SetActive(false)
					end
				end
			end

			local var_120_12 = 0.001

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_12 then
				local var_120_13 = (arg_117_1.time_ - var_120_9) / var_120_12
				local var_120_14 = Vector3.New(0, -350, -270)

				var_120_8.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10148, var_120_14, var_120_13)
			end

			if arg_117_1.time_ >= var_120_9 + var_120_12 and arg_117_1.time_ < var_120_9 + var_120_12 + arg_120_0 then
				var_120_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_120_15 = 0
			local var_120_16 = 1.05

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[1331].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(423111028)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 42
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111028", "story_v_out_423111.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111028", "story_v_out_423111.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_423111", "423111028", "story_v_out_423111.awb")

						arg_117_1:RecordAudio("423111028", var_120_24)
						arg_117_1:RecordAudio("423111028", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_423111", "423111028", "story_v_out_423111.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_423111", "423111028", "story_v_out_423111.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423111029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 423111029
		arg_121_1.duration_ = 6.53

		local var_121_0 = {
			zh = 3.1,
			ja = 6.533
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
				arg_121_0:Play423111030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10148"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10148 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10148", 3)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(0, -350, -270)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10148, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -350, -270)
			end

			local var_124_7 = 0
			local var_124_8 = 0.4

			if var_124_7 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_9 = arg_121_1:FormatText(StoryNameCfg[1331].name)

				arg_121_1.leftNameTxt_.text = var_124_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(423111029)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_12 = 16
				local var_124_13 = utf8.len(var_124_11)
				local var_124_14 = var_124_12 <= 0 and var_124_8 or var_124_8 * (var_124_13 / var_124_12)

				if var_124_14 > 0 and var_124_8 < var_124_14 then
					arg_121_1.talkMaxDuration = var_124_14

					if var_124_14 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_7
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111029", "story_v_out_423111.awb") ~= 0 then
					local var_124_15 = manager.audio:GetVoiceLength("story_v_out_423111", "423111029", "story_v_out_423111.awb") / 1000

					if var_124_15 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_7
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_423111", "423111029", "story_v_out_423111.awb")

						arg_121_1:RecordAudio("423111029", var_124_16)
						arg_121_1:RecordAudio("423111029", var_124_16)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_423111", "423111029", "story_v_out_423111.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_423111", "423111029", "story_v_out_423111.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_17 = math.max(var_124_8, arg_121_1.talkMaxDuration)

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_17 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_7) / var_124_17

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_7 + var_124_17 and arg_121_1.time_ < var_124_7 + var_124_17 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423111030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 423111030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play423111031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10148"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10148 == nil then
				arg_125_1.var_.actorSpriteComps10148 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10148 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 0.5, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10148 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10148 = nil
			end

			local var_128_8 = arg_125_1.actors_["10148"].transform
			local var_128_9 = 0

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.var_.moveOldPos10148 = var_128_8.localPosition
				var_128_8.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10148", 7)

				local var_128_10 = var_128_8.childCount

				for iter_128_4 = 0, var_128_10 - 1 do
					local var_128_11 = var_128_8:GetChild(iter_128_4)

					if var_128_11.name == "" or not string.find(var_128_11.name, "split") then
						var_128_11.gameObject:SetActive(true)
					else
						var_128_11.gameObject:SetActive(false)
					end
				end
			end

			local var_128_12 = 0.001

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_12 then
				local var_128_13 = (arg_125_1.time_ - var_128_9) / var_128_12
				local var_128_14 = Vector3.New(0, -2000, 0)

				var_128_8.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10148, var_128_14, var_128_13)
			end

			if arg_125_1.time_ >= var_128_9 + var_128_12 and arg_125_1.time_ < var_128_9 + var_128_12 + arg_128_0 then
				var_128_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_128_15 = 0.766666666666667
			local var_128_16 = 1

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				local var_128_17 = "play"
				local var_128_18 = "effect"

				arg_125_1:AudioAction(var_128_17, var_128_18, "se_story_144", "se_story_144_gun02", "")
			end

			local var_128_19 = 0
			local var_128_20 = 1.975

			if var_128_19 < arg_125_1.time_ and arg_125_1.time_ <= var_128_19 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_21 = arg_125_1:GetWordFromCfg(423111030)
				local var_128_22 = arg_125_1:FormatText(var_128_21.content)

				arg_125_1.text_.text = var_128_22

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_23 = 79
				local var_128_24 = utf8.len(var_128_22)
				local var_128_25 = var_128_23 <= 0 and var_128_20 or var_128_20 * (var_128_24 / var_128_23)

				if var_128_25 > 0 and var_128_20 < var_128_25 then
					arg_125_1.talkMaxDuration = var_128_25

					if var_128_25 + var_128_19 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_25 + var_128_19
					end
				end

				arg_125_1.text_.text = var_128_22
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_26 = math.max(var_128_20, arg_125_1.talkMaxDuration)

			if var_128_19 <= arg_125_1.time_ and arg_125_1.time_ < var_128_19 + var_128_26 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_19) / var_128_26

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_19 + var_128_26 and arg_125_1.time_ < var_128_19 + var_128_26 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play423111031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 423111031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play423111032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 1.225

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(423111031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 49
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play423111032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 423111032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play423111033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.225

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[7].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(423111032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 9
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
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play423111033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 423111033
		arg_137_1.duration_ = 7.07

		local var_137_0 = {
			zh = 4,
			ja = 7.066
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
				arg_137_0:Play423111034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = "1083"

			if arg_137_1.actors_[var_140_0] == nil then
				local var_140_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_140_1) then
					local var_140_2 = Object.Instantiate(var_140_1, arg_137_1.canvasGo_.transform)

					var_140_2.transform:SetSiblingIndex(1)

					var_140_2.name = var_140_0
					var_140_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_137_1.actors_[var_140_0] = var_140_2

					local var_140_3 = var_140_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_137_1.isInRecall_ then
						for iter_140_0, iter_140_1 in ipairs(var_140_3) do
							iter_140_1.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_140_4 = arg_137_1.actors_["1083"]
			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.actorSpriteComps1083 == nil then
				arg_137_1.var_.actorSpriteComps1083 = var_140_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_6 = 0.2

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_6 and not isNil(var_140_4) then
				local var_140_7 = (arg_137_1.time_ - var_140_5) / var_140_6

				if arg_137_1.var_.actorSpriteComps1083 then
					for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_140_3 then
							if arg_137_1.isInRecall_ then
								local var_140_8 = Mathf.Lerp(iter_140_3.color.r, arg_137_1.hightColor1.r, var_140_7)
								local var_140_9 = Mathf.Lerp(iter_140_3.color.g, arg_137_1.hightColor1.g, var_140_7)
								local var_140_10 = Mathf.Lerp(iter_140_3.color.b, arg_137_1.hightColor1.b, var_140_7)

								iter_140_3.color = Color.New(var_140_8, var_140_9, var_140_10)
							else
								local var_140_11 = Mathf.Lerp(iter_140_3.color.r, 1, var_140_7)

								iter_140_3.color = Color.New(var_140_11, var_140_11, var_140_11)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_5 + var_140_6 and arg_137_1.time_ < var_140_5 + var_140_6 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.actorSpriteComps1083 then
				for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_140_5 then
						if arg_137_1.isInRecall_ then
							iter_140_5.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1083 = nil
			end

			local var_140_12 = arg_137_1.actors_["1083"].transform
			local var_140_13 = 0

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1.var_.moveOldPos1083 = var_140_12.localPosition
				var_140_12.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("1083", 3)

				local var_140_14 = var_140_12.childCount

				for iter_140_6 = 0, var_140_14 - 1 do
					local var_140_15 = var_140_12:GetChild(iter_140_6)

					if var_140_15.name == "" or not string.find(var_140_15.name, "split") then
						var_140_15.gameObject:SetActive(true)
					else
						var_140_15.gameObject:SetActive(false)
					end
				end
			end

			local var_140_16 = 0.001

			if var_140_13 <= arg_137_1.time_ and arg_137_1.time_ < var_140_13 + var_140_16 then
				local var_140_17 = (arg_137_1.time_ - var_140_13) / var_140_16
				local var_140_18 = Vector3.New(-50, -345, -345)

				var_140_12.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1083, var_140_18, var_140_17)
			end

			if arg_137_1.time_ >= var_140_13 + var_140_16 and arg_137_1.time_ < var_140_13 + var_140_16 + arg_140_0 then
				var_140_12.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_140_19 = arg_137_1.actors_["1083"]
			local var_140_20 = 0

			if var_140_20 < arg_137_1.time_ and arg_137_1.time_ <= var_140_20 + arg_140_0 then
				local var_140_21 = var_140_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_140_21 then
					arg_137_1.var_.alphaOldValue1083 = var_140_21.alpha
					arg_137_1.var_.characterEffect1083 = var_140_21
				end

				arg_137_1.var_.alphaOldValue1083 = 0
			end

			local var_140_22 = 0.5

			if var_140_20 <= arg_137_1.time_ and arg_137_1.time_ < var_140_20 + var_140_22 then
				local var_140_23 = (arg_137_1.time_ - var_140_20) / var_140_22
				local var_140_24 = Mathf.Lerp(arg_137_1.var_.alphaOldValue1083, 1, var_140_23)

				if arg_137_1.var_.characterEffect1083 then
					arg_137_1.var_.characterEffect1083.alpha = var_140_24
				end
			end

			if arg_137_1.time_ >= var_140_20 + var_140_22 and arg_137_1.time_ < var_140_20 + var_140_22 + arg_140_0 and arg_137_1.var_.characterEffect1083 then
				arg_137_1.var_.characterEffect1083.alpha = 1
			end

			local var_140_25 = 0
			local var_140_26 = 0.375

			if var_140_25 < arg_137_1.time_ and arg_137_1.time_ <= var_140_25 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_27 = arg_137_1:FormatText(StoryNameCfg[1332].name)

				arg_137_1.leftNameTxt_.text = var_140_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_28 = arg_137_1:GetWordFromCfg(423111033)
				local var_140_29 = arg_137_1:FormatText(var_140_28.content)

				arg_137_1.text_.text = var_140_29

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_30 = 15
				local var_140_31 = utf8.len(var_140_29)
				local var_140_32 = var_140_30 <= 0 and var_140_26 or var_140_26 * (var_140_31 / var_140_30)

				if var_140_32 > 0 and var_140_26 < var_140_32 then
					arg_137_1.talkMaxDuration = var_140_32

					if var_140_32 + var_140_25 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_32 + var_140_25
					end
				end

				arg_137_1.text_.text = var_140_29
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111033", "story_v_out_423111.awb") ~= 0 then
					local var_140_33 = manager.audio:GetVoiceLength("story_v_out_423111", "423111033", "story_v_out_423111.awb") / 1000

					if var_140_33 + var_140_25 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_33 + var_140_25
					end

					if var_140_28.prefab_name ~= "" and arg_137_1.actors_[var_140_28.prefab_name] ~= nil then
						local var_140_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_28.prefab_name].transform, "story_v_out_423111", "423111033", "story_v_out_423111.awb")

						arg_137_1:RecordAudio("423111033", var_140_34)
						arg_137_1:RecordAudio("423111033", var_140_34)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_423111", "423111033", "story_v_out_423111.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_423111", "423111033", "story_v_out_423111.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_35 = math.max(var_140_26, arg_137_1.talkMaxDuration)

			if var_140_25 <= arg_137_1.time_ and arg_137_1.time_ < var_140_25 + var_140_35 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_25) / var_140_35

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_25 + var_140_35 and arg_137_1.time_ < var_140_25 + var_140_35 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play423111034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 423111034
		arg_141_1.duration_ = 1

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"

			SetActive(arg_141_1.choicesGo_, true)

			for iter_142_0, iter_142_1 in ipairs(arg_141_1.choices_) do
				local var_142_0 = iter_142_0 <= 2

				SetActive(iter_142_1.go, var_142_0)
			end

			arg_141_1.choices_[1].txt.text = arg_141_1:FormatText(StoryChoiceCfg[1371].name)
			arg_141_1.choices_[2].txt.text = arg_141_1:FormatText(StoryChoiceCfg[1372].name)
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play423111035(arg_141_1)
			end

			if arg_143_0 == 2 then
				arg_141_0:Play423111035(arg_141_1)
			end

			arg_141_1:RecordChoiceLog(423111034, 1371, 1372)
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1083"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps1083 == nil then
				arg_141_1.var_.actorSpriteComps1083 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps1083 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 0.5, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps1083 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1083 = nil
			end

			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_9 = 0.5

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play423111035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 423111035
		arg_145_1.duration_ = 9.73

		local var_145_0 = {
			zh = 7.633,
			ja = 9.733
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play423111036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1083"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1083 == nil then
				arg_145_1.var_.actorSpriteComps1083 = var_148_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.actorSpriteComps1083 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								local var_148_4 = Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, var_148_3)
								local var_148_5 = Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, var_148_3)
								local var_148_6 = Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, var_148_3)

								iter_148_1.color = Color.New(var_148_4, var_148_5, var_148_6)
							else
								local var_148_7 = Mathf.Lerp(iter_148_1.color.r, 1, var_148_3)

								iter_148_1.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.actorSpriteComps1083 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_148_3 then
						if arg_145_1.isInRecall_ then
							iter_148_3.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1083 = nil
			end

			local var_148_8 = arg_145_1.actors_["1083"].transform
			local var_148_9 = 0

			if var_148_9 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.var_.moveOldPos1083 = var_148_8.localPosition
				var_148_8.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("1083", 3)

				local var_148_10 = var_148_8.childCount

				for iter_148_4 = 0, var_148_10 - 1 do
					local var_148_11 = var_148_8:GetChild(iter_148_4)

					if var_148_11.name == "split_2" or not string.find(var_148_11.name, "split") then
						var_148_11.gameObject:SetActive(true)
					else
						var_148_11.gameObject:SetActive(false)
					end
				end
			end

			local var_148_12 = 0.001

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_12 then
				local var_148_13 = (arg_145_1.time_ - var_148_9) / var_148_12
				local var_148_14 = Vector3.New(-50, -345, -345)

				var_148_8.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1083, var_148_14, var_148_13)
			end

			if arg_145_1.time_ >= var_148_9 + var_148_12 and arg_145_1.time_ < var_148_9 + var_148_12 + arg_148_0 then
				var_148_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_148_15 = 0
			local var_148_16 = 0.7

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[1332].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(423111035)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 28
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111035", "story_v_out_423111.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111035", "story_v_out_423111.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_423111", "423111035", "story_v_out_423111.awb")

						arg_145_1:RecordAudio("423111035", var_148_24)
						arg_145_1:RecordAudio("423111035", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_423111", "423111035", "story_v_out_423111.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_423111", "423111035", "story_v_out_423111.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_25 and arg_145_1.time_ < var_148_15 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play423111036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 423111036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play423111037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1083"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1083 == nil then
				arg_149_1.var_.actorSpriteComps1083 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps1083 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 0.5, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps1083 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1083 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.5

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_10 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_11 = arg_149_1:GetWordFromCfg(423111036)
				local var_152_12 = arg_149_1:FormatText(var_152_11.content)

				arg_149_1.text_.text = var_152_12

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 20
				local var_152_14 = utf8.len(var_152_12)
				local var_152_15 = var_152_13 <= 0 and var_152_9 or var_152_9 * (var_152_14 / var_152_13)

				if var_152_15 > 0 and var_152_9 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_12
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play423111037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 423111037
		arg_153_1.duration_ = 10.4

		local var_153_0 = {
			zh = 7.7,
			ja = 10.4
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
				arg_153_0:Play423111038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1083"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1083 == nil then
				arg_153_1.var_.actorSpriteComps1083 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps1083 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								local var_156_4 = Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, var_156_3)
								local var_156_5 = Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, var_156_3)
								local var_156_6 = Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, var_156_3)

								iter_156_1.color = Color.New(var_156_4, var_156_5, var_156_6)
							else
								local var_156_7 = Mathf.Lerp(iter_156_1.color.r, 1, var_156_3)

								iter_156_1.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps1083 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps1083 = nil
			end

			local var_156_8 = arg_153_1.actors_["1083"].transform
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.var_.moveOldPos1083 = var_156_8.localPosition
				var_156_8.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("1083", 3)

				local var_156_10 = var_156_8.childCount

				for iter_156_4 = 0, var_156_10 - 1 do
					local var_156_11 = var_156_8:GetChild(iter_156_4)

					if var_156_11.name == "" or not string.find(var_156_11.name, "split") then
						var_156_11.gameObject:SetActive(true)
					else
						var_156_11.gameObject:SetActive(false)
					end
				end
			end

			local var_156_12 = 0.001

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_12 then
				local var_156_13 = (arg_153_1.time_ - var_156_9) / var_156_12
				local var_156_14 = Vector3.New(-50, -345, -345)

				var_156_8.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1083, var_156_14, var_156_13)
			end

			if arg_153_1.time_ >= var_156_9 + var_156_12 and arg_153_1.time_ < var_156_9 + var_156_12 + arg_156_0 then
				var_156_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_156_15 = 0
			local var_156_16 = 0.75

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[1332].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(423111037)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 30
				local var_156_21 = utf8.len(var_156_19)
				local var_156_22 = var_156_20 <= 0 and var_156_16 or var_156_16 * (var_156_21 / var_156_20)

				if var_156_22 > 0 and var_156_16 < var_156_22 then
					arg_153_1.talkMaxDuration = var_156_22

					if var_156_22 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_22 + var_156_15
					end
				end

				arg_153_1.text_.text = var_156_19
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111037", "story_v_out_423111.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111037", "story_v_out_423111.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_out_423111", "423111037", "story_v_out_423111.awb")

						arg_153_1:RecordAudio("423111037", var_156_24)
						arg_153_1:RecordAudio("423111037", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_423111", "423111037", "story_v_out_423111.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_423111", "423111037", "story_v_out_423111.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_25 = math.max(var_156_16, arg_153_1.talkMaxDuration)

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_25 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_15) / var_156_25

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_15 + var_156_25 and arg_153_1.time_ < var_156_15 + var_156_25 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423111038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 423111038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play423111039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1083"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1083 == nil then
				arg_157_1.var_.actorSpriteComps1083 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps1083 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								local var_160_4 = Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, var_160_3)
								local var_160_5 = Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, var_160_3)
								local var_160_6 = Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, var_160_3)

								iter_160_1.color = Color.New(var_160_4, var_160_5, var_160_6)
							else
								local var_160_7 = Mathf.Lerp(iter_160_1.color.r, 0.5, var_160_3)

								iter_160_1.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps1083 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps1083 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.7

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_10 = arg_157_1:FormatText(StoryNameCfg[7].name)

				arg_157_1.leftNameTxt_.text = var_160_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_11 = arg_157_1:GetWordFromCfg(423111038)
				local var_160_12 = arg_157_1:FormatText(var_160_11.content)

				arg_157_1.text_.text = var_160_12

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 28
				local var_160_14 = utf8.len(var_160_12)
				local var_160_15 = var_160_13 <= 0 and var_160_9 or var_160_9 * (var_160_14 / var_160_13)

				if var_160_15 > 0 and var_160_9 < var_160_15 then
					arg_157_1.talkMaxDuration = var_160_15

					if var_160_15 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_15 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_12
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play423111039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 423111039
		arg_161_1.duration_ = 5.53

		local var_161_0 = {
			zh = 5.533,
			ja = 5.5
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
				arg_161_0:Play423111040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1083"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1083 == nil then
				arg_161_1.var_.actorSpriteComps1083 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps1083 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_4 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, var_164_3)
								local var_164_5 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, var_164_3)
								local var_164_6 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, var_164_3)

								iter_164_1.color = Color.New(var_164_4, var_164_5, var_164_6)
							else
								local var_164_7 = Mathf.Lerp(iter_164_1.color.r, 1, var_164_3)

								iter_164_1.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps1083 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps1083 = nil
			end

			local var_164_8 = arg_161_1.actors_["1083"].transform
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.var_.moveOldPos1083 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1083", 3)

				local var_164_10 = var_164_8.childCount

				for iter_164_4 = 0, var_164_10 - 1 do
					local var_164_11 = var_164_8:GetChild(iter_164_4)

					if var_164_11.name == "split_2" or not string.find(var_164_11.name, "split") then
						var_164_11.gameObject:SetActive(true)
					else
						var_164_11.gameObject:SetActive(false)
					end
				end
			end

			local var_164_12 = 0.001

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_12 then
				local var_164_13 = (arg_161_1.time_ - var_164_9) / var_164_12
				local var_164_14 = Vector3.New(-50, -345, -345)

				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1083, var_164_14, var_164_13)
			end

			if arg_161_1.time_ >= var_164_9 + var_164_12 and arg_161_1.time_ < var_164_9 + var_164_12 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_164_15 = 0
			local var_164_16 = 0.625

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[1332].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(423111039)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 25
				local var_164_21 = utf8.len(var_164_19)
				local var_164_22 = var_164_20 <= 0 and var_164_16 or var_164_16 * (var_164_21 / var_164_20)

				if var_164_22 > 0 and var_164_16 < var_164_22 then
					arg_161_1.talkMaxDuration = var_164_22

					if var_164_22 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111039", "story_v_out_423111.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111039", "story_v_out_423111.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_out_423111", "423111039", "story_v_out_423111.awb")

						arg_161_1:RecordAudio("423111039", var_164_24)
						arg_161_1:RecordAudio("423111039", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_423111", "423111039", "story_v_out_423111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_423111", "423111039", "story_v_out_423111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_25 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_25 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_25

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_25 and arg_161_1.time_ < var_164_15 + var_164_25 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play423111040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 423111040
		arg_165_1.duration_ = 9.77

		local var_165_0 = {
			zh = 9.766,
			ja = 8.966
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
				arg_165_0:Play423111041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.825

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[1332].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(423111040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111040", "story_v_out_423111.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111040", "story_v_out_423111.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_423111", "423111040", "story_v_out_423111.awb")

						arg_165_1:RecordAudio("423111040", var_168_9)
						arg_165_1:RecordAudio("423111040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_423111", "423111040", "story_v_out_423111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_423111", "423111040", "story_v_out_423111.awb")
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
	Play423111041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 423111041
		arg_169_1.duration_ = 8.9

		local var_169_0 = {
			zh = 5.533,
			ja = 8.9
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
				arg_169_0:Play423111042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1083"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1083 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("1083", 3)

				local var_172_2 = var_172_0.childCount

				for iter_172_0 = 0, var_172_2 - 1 do
					local var_172_3 = var_172_0:GetChild(iter_172_0)

					if var_172_3.name == "" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_4 then
				local var_172_5 = (arg_169_1.time_ - var_172_1) / var_172_4
				local var_172_6 = Vector3.New(-50, -345, -345)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1083, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_172_7 = 0
			local var_172_8 = 0.575

			if var_172_7 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_9 = arg_169_1:FormatText(StoryNameCfg[1332].name)

				arg_169_1.leftNameTxt_.text = var_172_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_10 = arg_169_1:GetWordFromCfg(423111041)
				local var_172_11 = arg_169_1:FormatText(var_172_10.content)

				arg_169_1.text_.text = var_172_11

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_12 = 23
				local var_172_13 = utf8.len(var_172_11)
				local var_172_14 = var_172_12 <= 0 and var_172_8 or var_172_8 * (var_172_13 / var_172_12)

				if var_172_14 > 0 and var_172_8 < var_172_14 then
					arg_169_1.talkMaxDuration = var_172_14

					if var_172_14 + var_172_7 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_7
					end
				end

				arg_169_1.text_.text = var_172_11
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111041", "story_v_out_423111.awb") ~= 0 then
					local var_172_15 = manager.audio:GetVoiceLength("story_v_out_423111", "423111041", "story_v_out_423111.awb") / 1000

					if var_172_15 + var_172_7 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_7
					end

					if var_172_10.prefab_name ~= "" and arg_169_1.actors_[var_172_10.prefab_name] ~= nil then
						local var_172_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_10.prefab_name].transform, "story_v_out_423111", "423111041", "story_v_out_423111.awb")

						arg_169_1:RecordAudio("423111041", var_172_16)
						arg_169_1:RecordAudio("423111041", var_172_16)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_423111", "423111041", "story_v_out_423111.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_423111", "423111041", "story_v_out_423111.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_17 = math.max(var_172_8, arg_169_1.talkMaxDuration)

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_17 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_7) / var_172_17

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_7 + var_172_17 and arg_169_1.time_ < var_172_7 + var_172_17 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play423111042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 423111042
		arg_173_1.duration_ = 1

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"

			SetActive(arg_173_1.choicesGo_, true)

			for iter_174_0, iter_174_1 in ipairs(arg_173_1.choices_) do
				local var_174_0 = iter_174_0 <= 2

				SetActive(iter_174_1.go, var_174_0)
			end

			arg_173_1.choices_[1].txt.text = arg_173_1:FormatText(StoryChoiceCfg[1373].name)
			arg_173_1.choices_[2].txt.text = arg_173_1:FormatText(StoryChoiceCfg[1374].name)
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play423111043(arg_173_1)
			end

			if arg_175_0 == 2 then
				arg_173_0:Play423111047(arg_173_1)
			end

			arg_173_1:RecordChoiceLog(423111042, 1373, 1374)
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1083"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1083 == nil then
				arg_173_1.var_.actorSpriteComps1083 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps1083 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor2.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor2.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor2.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 0.5, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps1083 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps1083 = nil
			end

			local var_176_8 = arg_173_1.actors_["1083"].transform
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.var_.moveOldPos1083 = var_176_8.localPosition
				var_176_8.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1083", 3)

				local var_176_10 = var_176_8.childCount

				for iter_176_4 = 0, var_176_10 - 1 do
					local var_176_11 = var_176_8:GetChild(iter_176_4)

					if var_176_11.name == "" or not string.find(var_176_11.name, "split") then
						var_176_11.gameObject:SetActive(true)
					else
						var_176_11.gameObject:SetActive(false)
					end
				end
			end

			local var_176_12 = 0.001

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_12 then
				local var_176_13 = (arg_173_1.time_ - var_176_9) / var_176_12
				local var_176_14 = Vector3.New(-50, -345, -345)

				var_176_8.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1083, var_176_14, var_176_13)
			end

			if arg_173_1.time_ >= var_176_9 + var_176_12 and arg_173_1.time_ < var_176_9 + var_176_12 + arg_176_0 then
				var_176_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_176_15 = 0

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			local var_176_16 = 0.5

			if arg_173_1.time_ >= var_176_15 + var_176_16 and arg_173_1.time_ < var_176_15 + var_176_16 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423111043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 423111043
		arg_177_1.duration_ = 10

		local var_177_0 = {
			zh = 8.6,
			ja = 10
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
				arg_177_0:Play423111044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1083"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1083 == nil then
				arg_177_1.var_.actorSpriteComps1083 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps1083 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps1083 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps1083 = nil
			end

			local var_180_8 = arg_177_1.actors_["1083"].transform
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.var_.moveOldPos1083 = var_180_8.localPosition
				var_180_8.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("1083", 3)

				local var_180_10 = var_180_8.childCount

				for iter_180_4 = 0, var_180_10 - 1 do
					local var_180_11 = var_180_8:GetChild(iter_180_4)

					if var_180_11.name == "" or not string.find(var_180_11.name, "split") then
						var_180_11.gameObject:SetActive(true)
					else
						var_180_11.gameObject:SetActive(false)
					end
				end
			end

			local var_180_12 = 0.001

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_12 then
				local var_180_13 = (arg_177_1.time_ - var_180_9) / var_180_12
				local var_180_14 = Vector3.New(-50, -345, -345)

				var_180_8.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1083, var_180_14, var_180_13)
			end

			if arg_177_1.time_ >= var_180_9 + var_180_12 and arg_177_1.time_ < var_180_9 + var_180_12 + arg_180_0 then
				var_180_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_180_15 = 0
			local var_180_16 = 0.675

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[1332].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(423111043)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 27
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111043", "story_v_out_423111.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111043", "story_v_out_423111.awb") / 1000

					if var_180_23 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_15
					end

					if var_180_18.prefab_name ~= "" and arg_177_1.actors_[var_180_18.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_18.prefab_name].transform, "story_v_out_423111", "423111043", "story_v_out_423111.awb")

						arg_177_1:RecordAudio("423111043", var_180_24)
						arg_177_1:RecordAudio("423111043", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_423111", "423111043", "story_v_out_423111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_423111", "423111043", "story_v_out_423111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_25 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_25 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_25

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_25 and arg_177_1.time_ < var_180_15 + var_180_25 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play423111044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 423111044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play423111045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1083"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1083 == nil then
				arg_181_1.var_.actorSpriteComps1083 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps1083 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 0.5, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps1083 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps1083 = nil
			end

			local var_184_8 = 0
			local var_184_9 = 0.65

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_10 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_11 = arg_181_1:GetWordFromCfg(423111044)
				local var_184_12 = arg_181_1:FormatText(var_184_11.content)

				arg_181_1.text_.text = var_184_12

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 26
				local var_184_14 = utf8.len(var_184_12)
				local var_184_15 = var_184_13 <= 0 and var_184_9 or var_184_9 * (var_184_14 / var_184_13)

				if var_184_15 > 0 and var_184_9 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_12
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play423111045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 423111045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play423111046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.8

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(423111045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 32
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play423111046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 423111046
		arg_189_1.duration_ = 8.73

		local var_189_0 = {
			zh = 6.266,
			ja = 8.733
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
				arg_189_0:Play423111050(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1083"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps1083 == nil then
				arg_189_1.var_.actorSpriteComps1083 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps1083 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps1083 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_192_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps1083 = nil
			end

			local var_192_8 = arg_189_1.actors_["1083"].transform
			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.var_.moveOldPos1083 = var_192_8.localPosition
				var_192_8.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("1083", 3)

				local var_192_10 = var_192_8.childCount

				for iter_192_4 = 0, var_192_10 - 1 do
					local var_192_11 = var_192_8:GetChild(iter_192_4)

					if var_192_11.name == "" or not string.find(var_192_11.name, "split") then
						var_192_11.gameObject:SetActive(true)
					else
						var_192_11.gameObject:SetActive(false)
					end
				end
			end

			local var_192_12 = 0.001

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_12 then
				local var_192_13 = (arg_189_1.time_ - var_192_9) / var_192_12
				local var_192_14 = Vector3.New(-50, -345, -345)

				var_192_8.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1083, var_192_14, var_192_13)
			end

			if arg_189_1.time_ >= var_192_9 + var_192_12 and arg_189_1.time_ < var_192_9 + var_192_12 + arg_192_0 then
				var_192_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_192_15 = 0
			local var_192_16 = 0.575

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[1332].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(423111046)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 23
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111046", "story_v_out_423111.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111046", "story_v_out_423111.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_423111", "423111046", "story_v_out_423111.awb")

						arg_189_1:RecordAudio("423111046", var_192_24)
						arg_189_1:RecordAudio("423111046", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_423111", "423111046", "story_v_out_423111.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_423111", "423111046", "story_v_out_423111.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play423111050 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 423111050
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play423111051(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1083"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1083 == nil then
				arg_193_1.var_.actorSpriteComps1083 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps1083 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor2.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor2.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor2.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 0.5, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps1083 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps1083 = nil
			end

			local var_196_8 = 0
			local var_196_9 = 0.275

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_10 = arg_193_1:FormatText(StoryNameCfg[7].name)

				arg_193_1.leftNameTxt_.text = var_196_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_11 = arg_193_1:GetWordFromCfg(423111050)
				local var_196_12 = arg_193_1:FormatText(var_196_11.content)

				arg_193_1.text_.text = var_196_12

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 11
				local var_196_14 = utf8.len(var_196_12)
				local var_196_15 = var_196_13 <= 0 and var_196_9 or var_196_9 * (var_196_14 / var_196_13)

				if var_196_15 > 0 and var_196_9 < var_196_15 then
					arg_193_1.talkMaxDuration = var_196_15

					if var_196_15 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_15 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_12
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_16 and arg_193_1.time_ < var_196_8 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play423111051 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 423111051
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play423111052(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 1.05

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(423111051)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 42
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play423111052 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 423111052
		arg_201_1.duration_ = 5.43

		local var_201_0 = {
			zh = 3.133,
			ja = 5.433
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
				arg_201_0:Play423111053(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1083"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1083 == nil then
				arg_201_1.var_.actorSpriteComps1083 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps1083 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps1083 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps1083 = nil
			end

			local var_204_8 = arg_201_1.actors_["1083"].transform
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.var_.moveOldPos1083 = var_204_8.localPosition
				var_204_8.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1083", 3)

				local var_204_10 = var_204_8.childCount

				for iter_204_4 = 0, var_204_10 - 1 do
					local var_204_11 = var_204_8:GetChild(iter_204_4)

					if var_204_11.name == "" or not string.find(var_204_11.name, "split") then
						var_204_11.gameObject:SetActive(true)
					else
						var_204_11.gameObject:SetActive(false)
					end
				end
			end

			local var_204_12 = 0.001

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_12 then
				local var_204_13 = (arg_201_1.time_ - var_204_9) / var_204_12
				local var_204_14 = Vector3.New(-50, -345, -345)

				var_204_8.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1083, var_204_14, var_204_13)
			end

			if arg_201_1.time_ >= var_204_9 + var_204_12 and arg_201_1.time_ < var_204_9 + var_204_12 + arg_204_0 then
				var_204_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_204_15 = 0
			local var_204_16 = 0.4

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_17 = arg_201_1:FormatText(StoryNameCfg[1332].name)

				arg_201_1.leftNameTxt_.text = var_204_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_18 = arg_201_1:GetWordFromCfg(423111052)
				local var_204_19 = arg_201_1:FormatText(var_204_18.content)

				arg_201_1.text_.text = var_204_19

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_20 = 16
				local var_204_21 = utf8.len(var_204_19)
				local var_204_22 = var_204_20 <= 0 and var_204_16 or var_204_16 * (var_204_21 / var_204_20)

				if var_204_22 > 0 and var_204_16 < var_204_22 then
					arg_201_1.talkMaxDuration = var_204_22

					if var_204_22 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_22 + var_204_15
					end
				end

				arg_201_1.text_.text = var_204_19
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111052", "story_v_out_423111.awb") ~= 0 then
					local var_204_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111052", "story_v_out_423111.awb") / 1000

					if var_204_23 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_15
					end

					if var_204_18.prefab_name ~= "" and arg_201_1.actors_[var_204_18.prefab_name] ~= nil then
						local var_204_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_18.prefab_name].transform, "story_v_out_423111", "423111052", "story_v_out_423111.awb")

						arg_201_1:RecordAudio("423111052", var_204_24)
						arg_201_1:RecordAudio("423111052", var_204_24)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_423111", "423111052", "story_v_out_423111.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_423111", "423111052", "story_v_out_423111.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_25 = math.max(var_204_16, arg_201_1.talkMaxDuration)

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_25 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_15) / var_204_25

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_15 + var_204_25 and arg_201_1.time_ < var_204_15 + var_204_25 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423111053 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 423111053
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play423111054(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1083"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1083 == nil then
				arg_205_1.var_.actorSpriteComps1083 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps1083 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps1083 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps1083 = nil
			end

			local var_208_8 = 0
			local var_208_9 = 0.9

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

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_11 = arg_205_1:GetWordFromCfg(423111053)
				local var_208_12 = arg_205_1:FormatText(var_208_11.content)

				arg_205_1.text_.text = var_208_12

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 36
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
	Play423111054 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 423111054
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play423111055(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 1.025

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(423111054)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 41
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_8 and arg_209_1.time_ < var_212_0 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play423111055 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 423111055
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play423111056(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 1.225

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(423111055)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 49
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play423111056 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 423111056
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play423111057(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1.175

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(423111056)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 47
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play423111057 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 423111057
		arg_221_1.duration_ = 8.17

		local var_221_0 = {
			zh = 8.166,
			ja = 8.033
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
				arg_221_0:Play423111058(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1083"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1083 == nil then
				arg_221_1.var_.actorSpriteComps1083 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps1083 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps1083 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps1083 = nil
			end

			local var_224_8 = arg_221_1.actors_["1083"].transform
			local var_224_9 = 0

			if var_224_9 < arg_221_1.time_ and arg_221_1.time_ <= var_224_9 + arg_224_0 then
				arg_221_1.var_.moveOldPos1083 = var_224_8.localPosition
				var_224_8.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("1083", 3)

				local var_224_10 = var_224_8.childCount

				for iter_224_4 = 0, var_224_10 - 1 do
					local var_224_11 = var_224_8:GetChild(iter_224_4)

					if var_224_11.name == "split_1" or not string.find(var_224_11.name, "split") then
						var_224_11.gameObject:SetActive(true)
					else
						var_224_11.gameObject:SetActive(false)
					end
				end
			end

			local var_224_12 = 0.001

			if var_224_9 <= arg_221_1.time_ and arg_221_1.time_ < var_224_9 + var_224_12 then
				local var_224_13 = (arg_221_1.time_ - var_224_9) / var_224_12
				local var_224_14 = Vector3.New(-50, -345, -345)

				var_224_8.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1083, var_224_14, var_224_13)
			end

			if arg_221_1.time_ >= var_224_9 + var_224_12 and arg_221_1.time_ < var_224_9 + var_224_12 + arg_224_0 then
				var_224_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_224_15 = 0
			local var_224_16 = 0.825

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[1332].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(423111057)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111057", "story_v_out_423111.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111057", "story_v_out_423111.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_423111", "423111057", "story_v_out_423111.awb")

						arg_221_1:RecordAudio("423111057", var_224_24)
						arg_221_1:RecordAudio("423111057", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_423111", "423111057", "story_v_out_423111.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_423111", "423111057", "story_v_out_423111.awb")
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
				actorName = "1083",
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
	Play423111058 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 423111058
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play423111059(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1083"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps1083 == nil then
				arg_225_1.var_.actorSpriteComps1083 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps1083 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps1083 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1083 = nil
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

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_11 = arg_225_1:GetWordFromCfg(423111058)
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
	Play423111059 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 423111059
		arg_229_1.duration_ = 3.73

		local var_229_0 = {
			zh = 3.733,
			ja = 3.166
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
				arg_229_0:Play423111060(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1083"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1083 == nil then
				arg_229_1.var_.actorSpriteComps1083 = var_232_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_2 = 0.2

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.actorSpriteComps1083 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.actorSpriteComps1083 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_232_3 then
						if arg_229_1.isInRecall_ then
							iter_232_3.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_232_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_229_1.var_.actorSpriteComps1083 = nil
			end

			local var_232_8 = arg_229_1.actors_["1083"].transform
			local var_232_9 = 0

			if var_232_9 < arg_229_1.time_ and arg_229_1.time_ <= var_232_9 + arg_232_0 then
				arg_229_1.var_.moveOldPos1083 = var_232_8.localPosition
				var_232_8.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("1083", 3)

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
				local var_232_14 = Vector3.New(-50, -345, -345)

				var_232_8.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1083, var_232_14, var_232_13)
			end

			if arg_229_1.time_ >= var_232_9 + var_232_12 and arg_229_1.time_ < var_232_9 + var_232_12 + arg_232_0 then
				var_232_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_232_15 = 0
			local var_232_16 = 0.45

			if var_232_15 < arg_229_1.time_ and arg_229_1.time_ <= var_232_15 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_17 = arg_229_1:FormatText(StoryNameCfg[1332].name)

				arg_229_1.leftNameTxt_.text = var_232_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_18 = arg_229_1:GetWordFromCfg(423111059)
				local var_232_19 = arg_229_1:FormatText(var_232_18.content)

				arg_229_1.text_.text = var_232_19

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_20 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111059", "story_v_out_423111.awb") ~= 0 then
					local var_232_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111059", "story_v_out_423111.awb") / 1000

					if var_232_23 + var_232_15 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_23 + var_232_15
					end

					if var_232_18.prefab_name ~= "" and arg_229_1.actors_[var_232_18.prefab_name] ~= nil then
						local var_232_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_18.prefab_name].transform, "story_v_out_423111", "423111059", "story_v_out_423111.awb")

						arg_229_1:RecordAudio("423111059", var_232_24)
						arg_229_1:RecordAudio("423111059", var_232_24)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_423111", "423111059", "story_v_out_423111.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_423111", "423111059", "story_v_out_423111.awb")
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
				actorName = "1083",
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
	Play423111060 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 423111060
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play423111061(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["1083"]
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps1083 == nil then
				arg_233_1.var_.actorSpriteComps1083 = var_236_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_2 = 0.2

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 and not isNil(var_236_0) then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2

				if arg_233_1.var_.actorSpriteComps1083 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								local var_236_4 = Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor2.r, var_236_3)
								local var_236_5 = Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor2.g, var_236_3)
								local var_236_6 = Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor2.b, var_236_3)

								iter_236_1.color = Color.New(var_236_4, var_236_5, var_236_6)
							else
								local var_236_7 = Mathf.Lerp(iter_236_1.color.r, 0.5, var_236_3)

								iter_236_1.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 and not isNil(var_236_0) and arg_233_1.var_.actorSpriteComps1083 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_236_3 then
						if arg_233_1.isInRecall_ then
							iter_236_3.color = arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_236_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_233_1.var_.actorSpriteComps1083 = nil
			end

			local var_236_8 = 0
			local var_236_9 = 0.825

			if var_236_8 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_10 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_11 = arg_233_1:GetWordFromCfg(423111060)
				local var_236_12 = arg_233_1:FormatText(var_236_11.content)

				arg_233_1.text_.text = var_236_12

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 33
				local var_236_14 = utf8.len(var_236_12)
				local var_236_15 = var_236_13 <= 0 and var_236_9 or var_236_9 * (var_236_14 / var_236_13)

				if var_236_15 > 0 and var_236_9 < var_236_15 then
					arg_233_1.talkMaxDuration = var_236_15

					if var_236_15 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_12
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play423111061 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 423111061
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play423111062(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 1.075

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[7].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(423111061)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 43
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_8 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_8 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_8

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_8 and arg_237_1.time_ < var_240_0 + var_240_8 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play423111062 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 423111062
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play423111063(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.925

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(423111062)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 37
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_8 and arg_241_1.time_ < var_244_0 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play423111063 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 423111063
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play423111064(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 1.175

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_2 = arg_245_1:FormatText(StoryNameCfg[7].name)

				arg_245_1.leftNameTxt_.text = var_248_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(423111063)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 47
				local var_248_6 = utf8.len(var_248_4)
				local var_248_7 = var_248_5 <= 0 and var_248_1 or var_248_1 * (var_248_6 / var_248_5)

				if var_248_7 > 0 and var_248_1 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play423111064 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 423111064
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play423111065(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 1.1

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(423111064)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 44
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_8 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_8 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_8

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_8 and arg_249_1.time_ < var_252_0 + var_252_8 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play423111065 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 423111065
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play423111066(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1083"].transform
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.var_.moveOldPos1083 = var_256_0.localPosition
				var_256_0.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("1083", 7)

				local var_256_2 = var_256_0.childCount

				for iter_256_0 = 0, var_256_2 - 1 do
					local var_256_3 = var_256_0:GetChild(iter_256_0)

					if var_256_3.name == "" or not string.find(var_256_3.name, "split") then
						var_256_3.gameObject:SetActive(true)
					else
						var_256_3.gameObject:SetActive(false)
					end
				end
			end

			local var_256_4 = 0.001

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_4 then
				local var_256_5 = (arg_253_1.time_ - var_256_1) / var_256_4
				local var_256_6 = Vector3.New(0, -2000, 0)

				var_256_0.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1083, var_256_6, var_256_5)
			end

			if arg_253_1.time_ >= var_256_1 + var_256_4 and arg_253_1.time_ < var_256_1 + var_256_4 + arg_256_0 then
				var_256_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_256_7 = 0
			local var_256_8 = 1.7

			if var_256_7 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_9 = arg_253_1:GetWordFromCfg(423111065)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 68
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_8 or var_256_8 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_8 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_7 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_7
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_8, arg_253_1.talkMaxDuration)

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_7) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_7 + var_256_14 and arg_253_1.time_ < var_256_7 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play423111066 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 423111066
		arg_257_1.duration_ = 12.83

		local var_257_0 = {
			zh = 8.4,
			ja = 12.833
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
				arg_257_0:Play423111067(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1083"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps1083 == nil then
				arg_257_1.var_.actorSpriteComps1083 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps1083 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps1083 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1083 = nil
			end

			local var_260_8 = arg_257_1.actors_["1083"].transform
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 then
				arg_257_1.var_.moveOldPos1083 = var_260_8.localPosition
				var_260_8.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1083", 3)

				local var_260_10 = var_260_8.childCount

				for iter_260_4 = 0, var_260_10 - 1 do
					local var_260_11 = var_260_8:GetChild(iter_260_4)

					if var_260_11.name == "" or not string.find(var_260_11.name, "split") then
						var_260_11.gameObject:SetActive(true)
					else
						var_260_11.gameObject:SetActive(false)
					end
				end
			end

			local var_260_12 = 0.001

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_12 then
				local var_260_13 = (arg_257_1.time_ - var_260_9) / var_260_12
				local var_260_14 = Vector3.New(-50, -345, -345)

				var_260_8.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1083, var_260_14, var_260_13)
			end

			if arg_257_1.time_ >= var_260_9 + var_260_12 and arg_257_1.time_ < var_260_9 + var_260_12 + arg_260_0 then
				var_260_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_260_15 = 0
			local var_260_16 = 0.95

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_17 = arg_257_1:FormatText(StoryNameCfg[1332].name)

				arg_257_1.leftNameTxt_.text = var_260_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:GetWordFromCfg(423111066)
				local var_260_19 = arg_257_1:FormatText(var_260_18.content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 38
				local var_260_21 = utf8.len(var_260_19)
				local var_260_22 = var_260_20 <= 0 and var_260_16 or var_260_16 * (var_260_21 / var_260_20)

				if var_260_22 > 0 and var_260_16 < var_260_22 then
					arg_257_1.talkMaxDuration = var_260_22

					if var_260_22 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_22 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111066", "story_v_out_423111.awb") ~= 0 then
					local var_260_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111066", "story_v_out_423111.awb") / 1000

					if var_260_23 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_15
					end

					if var_260_18.prefab_name ~= "" and arg_257_1.actors_[var_260_18.prefab_name] ~= nil then
						local var_260_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_18.prefab_name].transform, "story_v_out_423111", "423111066", "story_v_out_423111.awb")

						arg_257_1:RecordAudio("423111066", var_260_24)
						arg_257_1:RecordAudio("423111066", var_260_24)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_423111", "423111066", "story_v_out_423111.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_423111", "423111066", "story_v_out_423111.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_25 and arg_257_1.time_ < var_260_15 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423111067 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 423111067
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play423111068(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1083"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps1083 == nil then
				arg_261_1.var_.actorSpriteComps1083 = var_264_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_2 = 0.2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.actorSpriteComps1083 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								local var_264_4 = Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor2.r, var_264_3)
								local var_264_5 = Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor2.g, var_264_3)
								local var_264_6 = Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor2.b, var_264_3)

								iter_264_1.color = Color.New(var_264_4, var_264_5, var_264_6)
							else
								local var_264_7 = Mathf.Lerp(iter_264_1.color.r, 0.5, var_264_3)

								iter_264_1.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps1083 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_264_3 then
						if arg_261_1.isInRecall_ then
							iter_264_3.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1083 = nil
			end

			local var_264_8 = 0
			local var_264_9 = 0.625

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_10 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_11 = arg_261_1:GetWordFromCfg(423111067)
				local var_264_12 = arg_261_1:FormatText(var_264_11.content)

				arg_261_1.text_.text = var_264_12

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 25
				local var_264_14 = utf8.len(var_264_12)
				local var_264_15 = var_264_13 <= 0 and var_264_9 or var_264_9 * (var_264_14 / var_264_13)

				if var_264_15 > 0 and var_264_9 < var_264_15 then
					arg_261_1.talkMaxDuration = var_264_15

					if var_264_15 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_15 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_12
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_16 and arg_261_1.time_ < var_264_8 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play423111068 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 423111068
		arg_265_1.duration_ = 6.7

		local var_265_0 = {
			zh = 4.733,
			ja = 6.7
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
				arg_265_0:Play423111069(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1083"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps1083 == nil then
				arg_265_1.var_.actorSpriteComps1083 = var_268_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_2 = 0.2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.actorSpriteComps1083 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								local var_268_4 = Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor1.r, var_268_3)
								local var_268_5 = Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor1.g, var_268_3)
								local var_268_6 = Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor1.b, var_268_3)

								iter_268_1.color = Color.New(var_268_4, var_268_5, var_268_6)
							else
								local var_268_7 = Mathf.Lerp(iter_268_1.color.r, 1, var_268_3)

								iter_268_1.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps1083 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_268_3 then
						if arg_265_1.isInRecall_ then
							iter_268_3.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1083 = nil
			end

			local var_268_8 = arg_265_1.actors_["1083"].transform
			local var_268_9 = 0

			if var_268_9 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 then
				arg_265_1.var_.moveOldPos1083 = var_268_8.localPosition
				var_268_8.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1083", 3)

				local var_268_10 = var_268_8.childCount

				for iter_268_4 = 0, var_268_10 - 1 do
					local var_268_11 = var_268_8:GetChild(iter_268_4)

					if var_268_11.name == "split_4" or not string.find(var_268_11.name, "split") then
						var_268_11.gameObject:SetActive(true)
					else
						var_268_11.gameObject:SetActive(false)
					end
				end
			end

			local var_268_12 = 0.001

			if var_268_9 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_12 then
				local var_268_13 = (arg_265_1.time_ - var_268_9) / var_268_12
				local var_268_14 = Vector3.New(-50, -345, -345)

				var_268_8.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1083, var_268_14, var_268_13)
			end

			if arg_265_1.time_ >= var_268_9 + var_268_12 and arg_265_1.time_ < var_268_9 + var_268_12 + arg_268_0 then
				var_268_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_268_15 = 0
			local var_268_16 = 0.425

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_17 = arg_265_1:FormatText(StoryNameCfg[1332].name)

				arg_265_1.leftNameTxt_.text = var_268_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_18 = arg_265_1:GetWordFromCfg(423111068)
				local var_268_19 = arg_265_1:FormatText(var_268_18.content)

				arg_265_1.text_.text = var_268_19

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_20 = 17
				local var_268_21 = utf8.len(var_268_19)
				local var_268_22 = var_268_20 <= 0 and var_268_16 or var_268_16 * (var_268_21 / var_268_20)

				if var_268_22 > 0 and var_268_16 < var_268_22 then
					arg_265_1.talkMaxDuration = var_268_22

					if var_268_22 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_22 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_19
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111068", "story_v_out_423111.awb") ~= 0 then
					local var_268_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111068", "story_v_out_423111.awb") / 1000

					if var_268_23 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_15
					end

					if var_268_18.prefab_name ~= "" and arg_265_1.actors_[var_268_18.prefab_name] ~= nil then
						local var_268_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_18.prefab_name].transform, "story_v_out_423111", "423111068", "story_v_out_423111.awb")

						arg_265_1:RecordAudio("423111068", var_268_24)
						arg_265_1:RecordAudio("423111068", var_268_24)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_423111", "423111068", "story_v_out_423111.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_423111", "423111068", "story_v_out_423111.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_25 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_25 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_25

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_25 and arg_265_1.time_ < var_268_15 + var_268_25 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play423111069 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 423111069
		arg_269_1.duration_ = 4.57

		local var_269_0 = {
			zh = 4.566,
			ja = 3.433
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play423111070(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1083"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1083 = var_272_0.localPosition
				var_272_0.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1083", 3)

				local var_272_2 = var_272_0.childCount

				for iter_272_0 = 0, var_272_2 - 1 do
					local var_272_3 = var_272_0:GetChild(iter_272_0)

					if var_272_3.name == "" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_4 then
				local var_272_5 = (arg_269_1.time_ - var_272_1) / var_272_4
				local var_272_6 = Vector3.New(-50, -345, -345)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1083, var_272_6, var_272_5)
			end

			if arg_269_1.time_ >= var_272_1 + var_272_4 and arg_269_1.time_ < var_272_1 + var_272_4 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_272_7 = 0
			local var_272_8 = 0.45

			if var_272_7 < arg_269_1.time_ and arg_269_1.time_ <= var_272_7 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_9 = arg_269_1:FormatText(StoryNameCfg[1332].name)

				arg_269_1.leftNameTxt_.text = var_272_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_10 = arg_269_1:GetWordFromCfg(423111069)
				local var_272_11 = arg_269_1:FormatText(var_272_10.content)

				arg_269_1.text_.text = var_272_11

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_12 = 18
				local var_272_13 = utf8.len(var_272_11)
				local var_272_14 = var_272_12 <= 0 and var_272_8 or var_272_8 * (var_272_13 / var_272_12)

				if var_272_14 > 0 and var_272_8 < var_272_14 then
					arg_269_1.talkMaxDuration = var_272_14

					if var_272_14 + var_272_7 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_14 + var_272_7
					end
				end

				arg_269_1.text_.text = var_272_11
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111069", "story_v_out_423111.awb") ~= 0 then
					local var_272_15 = manager.audio:GetVoiceLength("story_v_out_423111", "423111069", "story_v_out_423111.awb") / 1000

					if var_272_15 + var_272_7 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_15 + var_272_7
					end

					if var_272_10.prefab_name ~= "" and arg_269_1.actors_[var_272_10.prefab_name] ~= nil then
						local var_272_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_10.prefab_name].transform, "story_v_out_423111", "423111069", "story_v_out_423111.awb")

						arg_269_1:RecordAudio("423111069", var_272_16)
						arg_269_1:RecordAudio("423111069", var_272_16)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_423111", "423111069", "story_v_out_423111.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_423111", "423111069", "story_v_out_423111.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_17 = math.max(var_272_8, arg_269_1.talkMaxDuration)

			if var_272_7 <= arg_269_1.time_ and arg_269_1.time_ < var_272_7 + var_272_17 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_7) / var_272_17

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_7 + var_272_17 and arg_269_1.time_ < var_272_7 + var_272_17 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play423111070 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 423111070
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play423111071(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1083"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps1083 == nil then
				arg_273_1.var_.actorSpriteComps1083 = var_276_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.actorSpriteComps1083 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								local var_276_4 = Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor2.r, var_276_3)
								local var_276_5 = Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor2.g, var_276_3)
								local var_276_6 = Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor2.b, var_276_3)

								iter_276_1.color = Color.New(var_276_4, var_276_5, var_276_6)
							else
								local var_276_7 = Mathf.Lerp(iter_276_1.color.r, 0.5, var_276_3)

								iter_276_1.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps1083 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_276_3 then
						if arg_273_1.isInRecall_ then
							iter_276_3.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps1083 = nil
			end

			local var_276_8 = 0
			local var_276_9 = 0.725

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_10 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_11 = arg_273_1:GetWordFromCfg(423111070)
				local var_276_12 = arg_273_1:FormatText(var_276_11.content)

				arg_273_1.text_.text = var_276_12

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 29
				local var_276_14 = utf8.len(var_276_12)
				local var_276_15 = var_276_13 <= 0 and var_276_9 or var_276_9 * (var_276_14 / var_276_13)

				if var_276_15 > 0 and var_276_9 < var_276_15 then
					arg_273_1.talkMaxDuration = var_276_15

					if var_276_15 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_15 + var_276_8
					end
				end

				arg_273_1.text_.text = var_276_12
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_9, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_8) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_16 and arg_273_1.time_ < var_276_8 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play423111071 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 423111071
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play423111072(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.4

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[7].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(423111071)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 16
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play423111072 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 423111072
		arg_281_1.duration_ = 4.6

		local var_281_0 = {
			zh = 4.3,
			ja = 4.6
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play423111073(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["1083"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps1083 == nil then
				arg_281_1.var_.actorSpriteComps1083 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.2

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps1083 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								local var_284_4 = Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor1.r, var_284_3)
								local var_284_5 = Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor1.g, var_284_3)
								local var_284_6 = Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor1.b, var_284_3)

								iter_284_1.color = Color.New(var_284_4, var_284_5, var_284_6)
							else
								local var_284_7 = Mathf.Lerp(iter_284_1.color.r, 1, var_284_3)

								iter_284_1.color = Color.New(var_284_7, var_284_7, var_284_7)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps1083 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps1083 = nil
			end

			local var_284_8 = arg_281_1.actors_["1083"].transform
			local var_284_9 = 0

			if var_284_9 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 then
				arg_281_1.var_.moveOldPos1083 = var_284_8.localPosition
				var_284_8.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("1083", 3)

				local var_284_10 = var_284_8.childCount

				for iter_284_4 = 0, var_284_10 - 1 do
					local var_284_11 = var_284_8:GetChild(iter_284_4)

					if var_284_11.name == "split_2" or not string.find(var_284_11.name, "split") then
						var_284_11.gameObject:SetActive(true)
					else
						var_284_11.gameObject:SetActive(false)
					end
				end
			end

			local var_284_12 = 0.001

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_12 then
				local var_284_13 = (arg_281_1.time_ - var_284_9) / var_284_12
				local var_284_14 = Vector3.New(-50, -345, -345)

				var_284_8.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1083, var_284_14, var_284_13)
			end

			if arg_281_1.time_ >= var_284_9 + var_284_12 and arg_281_1.time_ < var_284_9 + var_284_12 + arg_284_0 then
				var_284_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_284_15 = 0
			local var_284_16 = 0.375

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[1332].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(423111072)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 15
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111072", "story_v_out_423111.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111072", "story_v_out_423111.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_423111", "423111072", "story_v_out_423111.awb")

						arg_281_1:RecordAudio("423111072", var_284_24)
						arg_281_1:RecordAudio("423111072", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_423111", "423111072", "story_v_out_423111.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_423111", "423111072", "story_v_out_423111.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play423111073 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 423111073
		arg_285_1.duration_ = 5.33

		local var_285_0 = {
			zh = 4.266,
			ja = 5.333
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play423111074(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1083"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos1083 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1083", 3)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "split_7" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(-50, -345, -345)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1083, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_288_7 = 0
			local var_288_8 = 0.525

			if var_288_7 < arg_285_1.time_ and arg_285_1.time_ <= var_288_7 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_9 = arg_285_1:FormatText(StoryNameCfg[1332].name)

				arg_285_1.leftNameTxt_.text = var_288_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(423111073)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_12 = 21
				local var_288_13 = utf8.len(var_288_11)
				local var_288_14 = var_288_12 <= 0 and var_288_8 or var_288_8 * (var_288_13 / var_288_12)

				if var_288_14 > 0 and var_288_8 < var_288_14 then
					arg_285_1.talkMaxDuration = var_288_14

					if var_288_14 + var_288_7 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_7
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111073", "story_v_out_423111.awb") ~= 0 then
					local var_288_15 = manager.audio:GetVoiceLength("story_v_out_423111", "423111073", "story_v_out_423111.awb") / 1000

					if var_288_15 + var_288_7 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_15 + var_288_7
					end

					if var_288_10.prefab_name ~= "" and arg_285_1.actors_[var_288_10.prefab_name] ~= nil then
						local var_288_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_10.prefab_name].transform, "story_v_out_423111", "423111073", "story_v_out_423111.awb")

						arg_285_1:RecordAudio("423111073", var_288_16)
						arg_285_1:RecordAudio("423111073", var_288_16)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_423111", "423111073", "story_v_out_423111.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_423111", "423111073", "story_v_out_423111.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_17 = math.max(var_288_8, arg_285_1.talkMaxDuration)

			if var_288_7 <= arg_285_1.time_ and arg_285_1.time_ < var_288_7 + var_288_17 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_7) / var_288_17

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_7 + var_288_17 and arg_285_1.time_ < var_288_7 + var_288_17 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play423111074 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 423111074
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play423111075(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1083"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1083 == nil then
				arg_289_1.var_.actorSpriteComps1083 = var_292_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_2 = 0.2

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.actorSpriteComps1083 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								local var_292_4 = Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor2.r, var_292_3)
								local var_292_5 = Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor2.g, var_292_3)
								local var_292_6 = Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor2.b, var_292_3)

								iter_292_1.color = Color.New(var_292_4, var_292_5, var_292_6)
							else
								local var_292_7 = Mathf.Lerp(iter_292_1.color.r, 0.5, var_292_3)

								iter_292_1.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1083 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_292_3 then
						if arg_289_1.isInRecall_ then
							iter_292_3.color = arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_292_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1083 = nil
			end

			local var_292_8 = arg_289_1.actors_["1083"].transform
			local var_292_9 = 0

			if var_292_9 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 then
				arg_289_1.var_.moveOldPos1083 = var_292_8.localPosition
				var_292_8.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1083", 7)

				local var_292_10 = var_292_8.childCount

				for iter_292_4 = 0, var_292_10 - 1 do
					local var_292_11 = var_292_8:GetChild(iter_292_4)

					if var_292_11.name == "" or not string.find(var_292_11.name, "split") then
						var_292_11.gameObject:SetActive(true)
					else
						var_292_11.gameObject:SetActive(false)
					end
				end
			end

			local var_292_12 = 0.001

			if var_292_9 <= arg_289_1.time_ and arg_289_1.time_ < var_292_9 + var_292_12 then
				local var_292_13 = (arg_289_1.time_ - var_292_9) / var_292_12
				local var_292_14 = Vector3.New(0, -2000, 0)

				var_292_8.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1083, var_292_14, var_292_13)
			end

			if arg_289_1.time_ >= var_292_9 + var_292_12 and arg_289_1.time_ < var_292_9 + var_292_12 + arg_292_0 then
				var_292_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_292_15 = 0
			local var_292_16 = 1.425

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_17 = arg_289_1:GetWordFromCfg(423111074)
				local var_292_18 = arg_289_1:FormatText(var_292_17.content)

				arg_289_1.text_.text = var_292_18

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_19 = 57
				local var_292_20 = utf8.len(var_292_18)
				local var_292_21 = var_292_19 <= 0 and var_292_16 or var_292_16 * (var_292_20 / var_292_19)

				if var_292_21 > 0 and var_292_16 < var_292_21 then
					arg_289_1.talkMaxDuration = var_292_21

					if var_292_21 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_21 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_18
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_22 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_22 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_22

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_22 and arg_289_1.time_ < var_292_15 + var_292_22 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play423111075 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 423111075
		arg_293_1.duration_ = 10.2

		local var_293_0 = {
			zh = 10.2,
			ja = 8.933
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play423111076(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1083"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1083 == nil then
				arg_293_1.var_.actorSpriteComps1083 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps1083 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								local var_296_4 = Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, var_296_3)
								local var_296_5 = Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, var_296_3)
								local var_296_6 = Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, var_296_3)

								iter_296_1.color = Color.New(var_296_4, var_296_5, var_296_6)
							else
								local var_296_7 = Mathf.Lerp(iter_296_1.color.r, 1, var_296_3)

								iter_296_1.color = Color.New(var_296_7, var_296_7, var_296_7)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps1083 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps1083 = nil
			end

			local var_296_8 = arg_293_1.actors_["1083"].transform
			local var_296_9 = 0

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.var_.moveOldPos1083 = var_296_8.localPosition
				var_296_8.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1083", 3)

				local var_296_10 = var_296_8.childCount

				for iter_296_4 = 0, var_296_10 - 1 do
					local var_296_11 = var_296_8:GetChild(iter_296_4)

					if var_296_11.name == "" or not string.find(var_296_11.name, "split") then
						var_296_11.gameObject:SetActive(true)
					else
						var_296_11.gameObject:SetActive(false)
					end
				end
			end

			local var_296_12 = 0.001

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_12 then
				local var_296_13 = (arg_293_1.time_ - var_296_9) / var_296_12
				local var_296_14 = Vector3.New(-50, -345, -345)

				var_296_8.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1083, var_296_14, var_296_13)
			end

			if arg_293_1.time_ >= var_296_9 + var_296_12 and arg_293_1.time_ < var_296_9 + var_296_12 + arg_296_0 then
				var_296_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_296_15 = 0
			local var_296_16 = 1.125

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[1332].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(423111075)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 45
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111075", "story_v_out_423111.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111075", "story_v_out_423111.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_out_423111", "423111075", "story_v_out_423111.awb")

						arg_293_1:RecordAudio("423111075", var_296_24)
						arg_293_1:RecordAudio("423111075", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_423111", "423111075", "story_v_out_423111.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_423111", "423111075", "story_v_out_423111.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play423111076 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 423111076
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play423111077(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1083"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1083 == nil then
				arg_297_1.var_.actorSpriteComps1083 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.2

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps1083 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								local var_300_4 = Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor2.r, var_300_3)
								local var_300_5 = Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor2.g, var_300_3)
								local var_300_6 = Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor2.b, var_300_3)

								iter_300_1.color = Color.New(var_300_4, var_300_5, var_300_6)
							else
								local var_300_7 = Mathf.Lerp(iter_300_1.color.r, 0.5, var_300_3)

								iter_300_1.color = Color.New(var_300_7, var_300_7, var_300_7)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps1083 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps1083 = nil
			end

			local var_300_8 = 0
			local var_300_9 = 0.9

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_10 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_11 = arg_297_1:GetWordFromCfg(423111076)
				local var_300_12 = arg_297_1:FormatText(var_300_11.content)

				arg_297_1.text_.text = var_300_12

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_13 = 36
				local var_300_14 = utf8.len(var_300_12)
				local var_300_15 = var_300_13 <= 0 and var_300_9 or var_300_9 * (var_300_14 / var_300_13)

				if var_300_15 > 0 and var_300_9 < var_300_15 then
					arg_297_1.talkMaxDuration = var_300_15

					if var_300_15 + var_300_8 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_15 + var_300_8
					end
				end

				arg_297_1.text_.text = var_300_12
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_16 = math.max(var_300_9, arg_297_1.talkMaxDuration)

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_16 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_8) / var_300_16

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_8 + var_300_16 and arg_297_1.time_ < var_300_8 + var_300_16 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play423111077 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 423111077
		arg_301_1.duration_ = 6.47

		local var_301_0 = {
			zh = 5.366,
			ja = 6.466
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
				arg_301_0:Play423111078(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1083"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1083 == nil then
				arg_301_1.var_.actorSpriteComps1083 = var_304_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_2 = 0.2

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.actorSpriteComps1083 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								local var_304_4 = Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor1.r, var_304_3)
								local var_304_5 = Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor1.g, var_304_3)
								local var_304_6 = Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor1.b, var_304_3)

								iter_304_1.color = Color.New(var_304_4, var_304_5, var_304_6)
							else
								local var_304_7 = Mathf.Lerp(iter_304_1.color.r, 1, var_304_3)

								iter_304_1.color = Color.New(var_304_7, var_304_7, var_304_7)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.actorSpriteComps1083 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_304_3 then
						if arg_301_1.isInRecall_ then
							iter_304_3.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps1083 = nil
			end

			local var_304_8 = arg_301_1.actors_["1083"].transform
			local var_304_9 = 0

			if var_304_9 < arg_301_1.time_ and arg_301_1.time_ <= var_304_9 + arg_304_0 then
				arg_301_1.var_.moveOldPos1083 = var_304_8.localPosition
				var_304_8.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1083", 3)

				local var_304_10 = var_304_8.childCount

				for iter_304_4 = 0, var_304_10 - 1 do
					local var_304_11 = var_304_8:GetChild(iter_304_4)

					if var_304_11.name == "" or not string.find(var_304_11.name, "split") then
						var_304_11.gameObject:SetActive(true)
					else
						var_304_11.gameObject:SetActive(false)
					end
				end
			end

			local var_304_12 = 0.001

			if var_304_9 <= arg_301_1.time_ and arg_301_1.time_ < var_304_9 + var_304_12 then
				local var_304_13 = (arg_301_1.time_ - var_304_9) / var_304_12
				local var_304_14 = Vector3.New(-50, -345, -345)

				var_304_8.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1083, var_304_14, var_304_13)
			end

			if arg_301_1.time_ >= var_304_9 + var_304_12 and arg_301_1.time_ < var_304_9 + var_304_12 + arg_304_0 then
				var_304_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_304_15 = 0
			local var_304_16 = 0.75

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[1332].name)

				arg_301_1.leftNameTxt_.text = var_304_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_18 = arg_301_1:GetWordFromCfg(423111077)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 30
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111077", "story_v_out_423111.awb") ~= 0 then
					local var_304_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111077", "story_v_out_423111.awb") / 1000

					if var_304_23 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_15
					end

					if var_304_18.prefab_name ~= "" and arg_301_1.actors_[var_304_18.prefab_name] ~= nil then
						local var_304_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_18.prefab_name].transform, "story_v_out_423111", "423111077", "story_v_out_423111.awb")

						arg_301_1:RecordAudio("423111077", var_304_24)
						arg_301_1:RecordAudio("423111077", var_304_24)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_423111", "423111077", "story_v_out_423111.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_423111", "423111077", "story_v_out_423111.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_25 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_25 and arg_301_1.time_ < var_304_15 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423111078 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 423111078
		arg_305_1.duration_ = 9

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play423111079(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 2

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				local var_308_1 = manager.ui.mainCamera.transform.localPosition
				local var_308_2 = Vector3.New(0, 0, 10) + Vector3.New(var_308_1.x, var_308_1.y, 0)
				local var_308_3 = arg_305_1.bgs_.ST0112a

				var_308_3.transform.localPosition = var_308_2
				var_308_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_4 = var_308_3:GetComponent("SpriteRenderer")

				if var_308_4 and var_308_4.sprite then
					local var_308_5 = (var_308_3.transform.localPosition - var_308_1).z
					local var_308_6 = manager.ui.mainCameraCom_
					local var_308_7 = 2 * var_308_5 * Mathf.Tan(var_308_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_308_8 = var_308_7 * var_308_6.aspect
					local var_308_9 = var_308_4.sprite.bounds.size.x
					local var_308_10 = var_308_4.sprite.bounds.size.y
					local var_308_11 = var_308_8 / var_308_9
					local var_308_12 = var_308_7 / var_308_10
					local var_308_13 = var_308_12 < var_308_11 and var_308_11 or var_308_12

					var_308_3.transform.localScale = Vector3.New(var_308_13, var_308_13, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "ST0112a" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_14 = 4

			if var_308_14 < arg_305_1.time_ and arg_305_1.time_ <= var_308_14 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			local var_308_15 = 0.3

			if arg_305_1.time_ >= var_308_14 + var_308_15 and arg_305_1.time_ < var_308_14 + var_308_15 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end

			local var_308_16 = 0

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_17 = 2

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_17 then
				local var_308_18 = (arg_305_1.time_ - var_308_16) / var_308_17
				local var_308_19 = Color.New(0, 0, 0)

				var_308_19.a = Mathf.Lerp(0, 1, var_308_18)
				arg_305_1.mask_.color = var_308_19
			end

			if arg_305_1.time_ >= var_308_16 + var_308_17 and arg_305_1.time_ < var_308_16 + var_308_17 + arg_308_0 then
				local var_308_20 = Color.New(0, 0, 0)

				var_308_20.a = 1
				arg_305_1.mask_.color = var_308_20
			end

			local var_308_21 = 2

			if var_308_21 < arg_305_1.time_ and arg_305_1.time_ <= var_308_21 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_22 = 2

			if var_308_21 <= arg_305_1.time_ and arg_305_1.time_ < var_308_21 + var_308_22 then
				local var_308_23 = (arg_305_1.time_ - var_308_21) / var_308_22
				local var_308_24 = Color.New(0, 0, 0)

				var_308_24.a = Mathf.Lerp(1, 0, var_308_23)
				arg_305_1.mask_.color = var_308_24
			end

			if arg_305_1.time_ >= var_308_21 + var_308_22 and arg_305_1.time_ < var_308_21 + var_308_22 + arg_308_0 then
				local var_308_25 = Color.New(0, 0, 0)
				local var_308_26 = 0

				arg_305_1.mask_.enabled = false
				var_308_25.a = var_308_26
				arg_305_1.mask_.color = var_308_25
			end

			local var_308_27 = arg_305_1.actors_["1083"]
			local var_308_28 = 1.966

			if var_308_28 < arg_305_1.time_ and arg_305_1.time_ <= var_308_28 + arg_308_0 and not isNil(var_308_27) and arg_305_1.var_.actorSpriteComps1083 == nil then
				arg_305_1.var_.actorSpriteComps1083 = var_308_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_29 = 0.0166666666666667

			if var_308_28 <= arg_305_1.time_ and arg_305_1.time_ < var_308_28 + var_308_29 and not isNil(var_308_27) then
				local var_308_30 = (arg_305_1.time_ - var_308_28) / var_308_29

				if arg_305_1.var_.actorSpriteComps1083 then
					for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_308_3 then
							if arg_305_1.isInRecall_ then
								local var_308_31 = Mathf.Lerp(iter_308_3.color.r, arg_305_1.hightColor2.r, var_308_30)
								local var_308_32 = Mathf.Lerp(iter_308_3.color.g, arg_305_1.hightColor2.g, var_308_30)
								local var_308_33 = Mathf.Lerp(iter_308_3.color.b, arg_305_1.hightColor2.b, var_308_30)

								iter_308_3.color = Color.New(var_308_31, var_308_32, var_308_33)
							else
								local var_308_34 = Mathf.Lerp(iter_308_3.color.r, 0.5, var_308_30)

								iter_308_3.color = Color.New(var_308_34, var_308_34, var_308_34)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_28 + var_308_29 and arg_305_1.time_ < var_308_28 + var_308_29 + arg_308_0 and not isNil(var_308_27) and arg_305_1.var_.actorSpriteComps1083 then
				for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_308_5 then
						if arg_305_1.isInRecall_ then
							iter_308_5.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps1083 = nil
			end

			local var_308_35 = arg_305_1.actors_["1083"].transform
			local var_308_36 = 1.966

			if var_308_36 < arg_305_1.time_ and arg_305_1.time_ <= var_308_36 + arg_308_0 then
				arg_305_1.var_.moveOldPos1083 = var_308_35.localPosition
				var_308_35.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1083", 7)

				local var_308_37 = var_308_35.childCount

				for iter_308_6 = 0, var_308_37 - 1 do
					local var_308_38 = var_308_35:GetChild(iter_308_6)

					if var_308_38.name == "" or not string.find(var_308_38.name, "split") then
						var_308_38.gameObject:SetActive(true)
					else
						var_308_38.gameObject:SetActive(false)
					end
				end
			end

			local var_308_39 = 0.001

			if var_308_36 <= arg_305_1.time_ and arg_305_1.time_ < var_308_36 + var_308_39 then
				local var_308_40 = (arg_305_1.time_ - var_308_36) / var_308_39
				local var_308_41 = Vector3.New(0, -2000, 0)

				var_308_35.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1083, var_308_41, var_308_40)
			end

			if arg_305_1.time_ >= var_308_36 + var_308_39 and arg_305_1.time_ < var_308_36 + var_308_39 + arg_308_0 then
				var_308_35.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_308_42 = manager.ui.mainCamera.transform
			local var_308_43 = 2

			if var_308_43 < arg_305_1.time_ and arg_305_1.time_ <= var_308_43 + arg_308_0 then
				local var_308_44 = arg_305_1.var_.effectlageqieting
				local var_308_45
				local var_308_46 = var_308_42

				if not var_308_44 then
					var_308_44 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_308_46)
					var_308_44.name = "lageqieting"
					arg_305_1.var_.effectlageqieting = var_308_44
				else
					var_308_44.transform:SetParent(var_308_46)
				end

				var_308_44.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_44.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_308_47 = manager.ui.mainCameraCom_
				local var_308_48 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_308_47.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_308_49 = var_308_44.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_308_50 = 15
				local var_308_51 = 2 * var_308_50 * Mathf.Tan(var_308_47.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_308_47.aspect
				local var_308_52 = 1
				local var_308_53 = 1.7777777777777777

				if var_308_53 < var_308_47.aspect then
					var_308_52 = var_308_51 / (2 * var_308_50 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_308_53)
				end

				for iter_308_7, iter_308_8 in ipairs(var_308_49) do
					local var_308_54 = iter_308_8.transform.localScale

					iter_308_8.transform.localScale = Vector3.New(var_308_54.x / var_308_48 * var_308_52, var_308_54.y / var_308_48, var_308_54.z)
				end
			end

			local var_308_55 = manager.ui.mainCamera.transform
			local var_308_56 = 2

			if var_308_56 < arg_305_1.time_ and arg_305_1.time_ <= var_308_56 + arg_308_0 then
				local var_308_57 = arg_305_1.var_.effectlageqieting2
				local var_308_58
				local var_308_59 = var_308_55

				if not var_308_57 then
					var_308_57 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), var_308_59)
					var_308_57.name = "lageqieting2"
					arg_305_1.var_.effectlageqieting2 = var_308_57
				else
					var_308_57.transform:SetParent(var_308_59)
				end

				var_308_57.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_57.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_308_60 = manager.ui.mainCameraCom_
				local var_308_61 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_308_60.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_308_62 = var_308_57.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_308_63 = 15
				local var_308_64 = 2 * var_308_63 * Mathf.Tan(var_308_60.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_308_60.aspect
				local var_308_65 = 1
				local var_308_66 = 1.7777777777777777

				if var_308_66 < var_308_60.aspect then
					var_308_65 = var_308_64 / (2 * var_308_63 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_308_66)
				end

				for iter_308_9, iter_308_10 in ipairs(var_308_62) do
					local var_308_67 = iter_308_10.transform.localScale

					iter_308_10.transform.localScale = Vector3.New(var_308_67.x / var_308_61 * var_308_65, var_308_67.y / var_308_61, var_308_67.z)
				end
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_68 = 4
			local var_308_69 = 0.85

			if var_308_68 < arg_305_1.time_ and arg_305_1.time_ <= var_308_68 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_70 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_70:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_71 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_72 = arg_305_1:GetWordFromCfg(423111078)
				local var_308_73 = arg_305_1:FormatText(var_308_72.content)

				arg_305_1.text_.text = var_308_73

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_74 = 34
				local var_308_75 = utf8.len(var_308_73)
				local var_308_76 = var_308_74 <= 0 and var_308_69 or var_308_69 * (var_308_75 / var_308_74)

				if var_308_76 > 0 and var_308_69 < var_308_76 then
					arg_305_1.talkMaxDuration = var_308_76
					var_308_68 = var_308_68 + 0.3

					if var_308_76 + var_308_68 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_76 + var_308_68
					end
				end

				arg_305_1.text_.text = var_308_73
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_77 = var_308_68 + 0.3
			local var_308_78 = math.max(var_308_69, arg_305_1.talkMaxDuration)

			if var_308_77 <= arg_305_1.time_ and arg_305_1.time_ < var_308_77 + var_308_78 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_77) / var_308_78

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_77 + var_308_78 and arg_305_1.time_ < var_308_77 + var_308_78 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play423111079 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 423111079
		arg_311_1.duration_ = 7.73

		local var_311_0 = {
			zh = 4,
			ja = 7.733
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
				arg_311_0:Play423111080(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.475

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[1332].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_8")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:GetWordFromCfg(423111079)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 19
				local var_314_6 = utf8.len(var_314_4)
				local var_314_7 = var_314_5 <= 0 and var_314_1 or var_314_1 * (var_314_6 / var_314_5)

				if var_314_7 > 0 and var_314_1 < var_314_7 then
					arg_311_1.talkMaxDuration = var_314_7

					if var_314_7 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_7 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111079", "story_v_out_423111.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111079", "story_v_out_423111.awb") / 1000

					if var_314_8 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_0
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_out_423111", "423111079", "story_v_out_423111.awb")

						arg_311_1:RecordAudio("423111079", var_314_9)
						arg_311_1:RecordAudio("423111079", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_423111", "423111079", "story_v_out_423111.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_423111", "423111079", "story_v_out_423111.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_10 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_10

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_10 and arg_311_1.time_ < var_314_0 + var_314_10 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play423111080 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 423111080
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play423111081(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["1083"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1083 == nil then
				arg_315_1.var_.actorSpriteComps1083 = var_318_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_2 = 0.2

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.actorSpriteComps1083 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								local var_318_4 = Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor2.r, var_318_3)
								local var_318_5 = Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor2.g, var_318_3)
								local var_318_6 = Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor2.b, var_318_3)

								iter_318_1.color = Color.New(var_318_4, var_318_5, var_318_6)
							else
								local var_318_7 = Mathf.Lerp(iter_318_1.color.r, 0.5, var_318_3)

								iter_318_1.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.actorSpriteComps1083 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_318_3 then
						if arg_315_1.isInRecall_ then
							iter_318_3.color = arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_318_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_315_1.var_.actorSpriteComps1083 = nil
			end

			local var_318_8 = arg_315_1.actors_["1083"].transform
			local var_318_9 = 0

			if var_318_9 < arg_315_1.time_ and arg_315_1.time_ <= var_318_9 + arg_318_0 then
				arg_315_1.var_.moveOldPos1083 = var_318_8.localPosition
				var_318_8.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1083", 7)

				local var_318_10 = var_318_8.childCount

				for iter_318_4 = 0, var_318_10 - 1 do
					local var_318_11 = var_318_8:GetChild(iter_318_4)

					if var_318_11.name == "" or not string.find(var_318_11.name, "split") then
						var_318_11.gameObject:SetActive(true)
					else
						var_318_11.gameObject:SetActive(false)
					end
				end
			end

			local var_318_12 = 0.001

			if var_318_9 <= arg_315_1.time_ and arg_315_1.time_ < var_318_9 + var_318_12 then
				local var_318_13 = (arg_315_1.time_ - var_318_9) / var_318_12
				local var_318_14 = Vector3.New(0, -2000, 0)

				var_318_8.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1083, var_318_14, var_318_13)
			end

			if arg_315_1.time_ >= var_318_9 + var_318_12 and arg_315_1.time_ < var_318_9 + var_318_12 + arg_318_0 then
				var_318_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_318_15 = 0
			local var_318_16 = 0.3

			if var_318_15 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				local var_318_17 = "play"
				local var_318_18 = "music"

				arg_315_1:AudioAction(var_318_17, var_318_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_318_19 = ""
				local var_318_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_318_20 ~= "" then
					if arg_315_1.bgmTxt_.text ~= var_318_20 and arg_315_1.bgmTxt_.text ~= "" then
						if arg_315_1.bgmTxt2_.text ~= "" then
							arg_315_1.bgmTxt_.text = arg_315_1.bgmTxt2_.text
						end

						arg_315_1.bgmTxt2_.text = var_318_20

						arg_315_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_315_1.bgmTxt_.text = var_318_20
						arg_315_1.bgmTxt2_.text = var_318_20
					end

					if arg_315_1.bgmTimer then
						arg_315_1.bgmTimer:Stop()

						arg_315_1.bgmTimer = nil
					end

					if arg_315_1.settingData.show_music_name == 1 then
						arg_315_1.musicController:SetSelectedState("show")
						arg_315_1.musicAnimator_:Play("open", 0, 0)

						if arg_315_1.settingData.music_time ~= 0 then
							arg_315_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_315_1.settingData.music_time), function()
								if arg_315_1 == nil or isNil(arg_315_1.bgmTxt_) then
									return
								end

								arg_315_1.musicController:SetSelectedState("hide")
								arg_315_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_318_21 = 0.500666666666667
			local var_318_22 = 1

			if var_318_21 < arg_315_1.time_ and arg_315_1.time_ <= var_318_21 + arg_318_0 then
				local var_318_23 = "play"
				local var_318_24 = "music"

				arg_315_1:AudioAction(var_318_23, var_318_24, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_318_25 = ""
				local var_318_26 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_318_26 ~= "" then
					if arg_315_1.bgmTxt_.text ~= var_318_26 and arg_315_1.bgmTxt_.text ~= "" then
						if arg_315_1.bgmTxt2_.text ~= "" then
							arg_315_1.bgmTxt_.text = arg_315_1.bgmTxt2_.text
						end

						arg_315_1.bgmTxt2_.text = var_318_26

						arg_315_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_315_1.bgmTxt_.text = var_318_26
						arg_315_1.bgmTxt2_.text = var_318_26
					end

					if arg_315_1.bgmTimer then
						arg_315_1.bgmTimer:Stop()

						arg_315_1.bgmTimer = nil
					end

					if arg_315_1.settingData.show_music_name == 1 then
						arg_315_1.musicController:SetSelectedState("show")
						arg_315_1.musicAnimator_:Play("open", 0, 0)

						if arg_315_1.settingData.music_time ~= 0 then
							arg_315_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_315_1.settingData.music_time), function()
								if arg_315_1 == nil or isNil(arg_315_1.bgmTxt_) then
									return
								end

								arg_315_1.musicController:SetSelectedState("hide")
								arg_315_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_318_27 = 0
			local var_318_28 = 1.475

			if var_318_27 < arg_315_1.time_ and arg_315_1.time_ <= var_318_27 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_29 = arg_315_1:GetWordFromCfg(423111080)
				local var_318_30 = arg_315_1:FormatText(var_318_29.content)

				arg_315_1.text_.text = var_318_30

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_31 = 66
				local var_318_32 = utf8.len(var_318_30)
				local var_318_33 = var_318_31 <= 0 and var_318_28 or var_318_28 * (var_318_32 / var_318_31)

				if var_318_33 > 0 and var_318_28 < var_318_33 then
					arg_315_1.talkMaxDuration = var_318_33

					if var_318_33 + var_318_27 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_33 + var_318_27
					end
				end

				arg_315_1.text_.text = var_318_30
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_34 = math.max(var_318_28, arg_315_1.talkMaxDuration)

			if var_318_27 <= arg_315_1.time_ and arg_315_1.time_ < var_318_27 + var_318_34 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_27) / var_318_34

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_27 + var_318_34 and arg_315_1.time_ < var_318_27 + var_318_34 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play423111081 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 423111081
		arg_321_1.duration_ = 11.27

		local var_321_0 = {
			zh = 6.533,
			ja = 11.266
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
				arg_321_0:Play423111082(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = "10146"

			if arg_321_1.actors_[var_324_0] == nil then
				local var_324_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_324_1) then
					local var_324_2 = Object.Instantiate(var_324_1, arg_321_1.canvasGo_.transform)

					var_324_2.transform:SetSiblingIndex(1)

					var_324_2.name = var_324_0
					var_324_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_321_1.actors_[var_324_0] = var_324_2

					local var_324_3 = var_324_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_321_1.isInRecall_ then
						for iter_324_0, iter_324_1 in ipairs(var_324_3) do
							iter_324_1.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_324_4 = arg_321_1.actors_["10146"]
			local var_324_5 = 0

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.actorSpriteComps10146 == nil then
				arg_321_1.var_.actorSpriteComps10146 = var_324_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_6 = 0.2

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_6 and not isNil(var_324_4) then
				local var_324_7 = (arg_321_1.time_ - var_324_5) / var_324_6

				if arg_321_1.var_.actorSpriteComps10146 then
					for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_324_3 then
							if arg_321_1.isInRecall_ then
								local var_324_8 = Mathf.Lerp(iter_324_3.color.r, arg_321_1.hightColor1.r, var_324_7)
								local var_324_9 = Mathf.Lerp(iter_324_3.color.g, arg_321_1.hightColor1.g, var_324_7)
								local var_324_10 = Mathf.Lerp(iter_324_3.color.b, arg_321_1.hightColor1.b, var_324_7)

								iter_324_3.color = Color.New(var_324_8, var_324_9, var_324_10)
							else
								local var_324_11 = Mathf.Lerp(iter_324_3.color.r, 1, var_324_7)

								iter_324_3.color = Color.New(var_324_11, var_324_11, var_324_11)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_5 + var_324_6 and arg_321_1.time_ < var_324_5 + var_324_6 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.actorSpriteComps10146 then
				for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_324_5 then
						if arg_321_1.isInRecall_ then
							iter_324_5.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps10146 = nil
			end

			local var_324_12 = arg_321_1.actors_["10146"].transform
			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1.var_.moveOldPos10146 = var_324_12.localPosition
				var_324_12.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10146", 3)

				local var_324_14 = var_324_12.childCount

				for iter_324_6 = 0, var_324_14 - 1 do
					local var_324_15 = var_324_12:GetChild(iter_324_6)

					if var_324_15.name == "split_4" or not string.find(var_324_15.name, "split") then
						var_324_15.gameObject:SetActive(true)
					else
						var_324_15.gameObject:SetActive(false)
					end
				end
			end

			local var_324_16 = 0.001

			if var_324_13 <= arg_321_1.time_ and arg_321_1.time_ < var_324_13 + var_324_16 then
				local var_324_17 = (arg_321_1.time_ - var_324_13) / var_324_16
				local var_324_18 = Vector3.New(0, -350, -320)

				var_324_12.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10146, var_324_18, var_324_17)
			end

			if arg_321_1.time_ >= var_324_13 + var_324_16 and arg_321_1.time_ < var_324_13 + var_324_16 + arg_324_0 then
				var_324_12.localPosition = Vector3.New(0, -350, -320)
			end

			local var_324_19 = arg_321_1.actors_["10146"]
			local var_324_20 = 0

			if var_324_20 < arg_321_1.time_ and arg_321_1.time_ <= var_324_20 + arg_324_0 then
				local var_324_21 = var_324_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_324_21 then
					arg_321_1.var_.alphaOldValue10146 = var_324_21.alpha
					arg_321_1.var_.characterEffect10146 = var_324_21
				end

				arg_321_1.var_.alphaOldValue10146 = 0
			end

			local var_324_22 = 0.5

			if var_324_20 <= arg_321_1.time_ and arg_321_1.time_ < var_324_20 + var_324_22 then
				local var_324_23 = (arg_321_1.time_ - var_324_20) / var_324_22
				local var_324_24 = Mathf.Lerp(arg_321_1.var_.alphaOldValue10146, 1, var_324_23)

				if arg_321_1.var_.characterEffect10146 then
					arg_321_1.var_.characterEffect10146.alpha = var_324_24
				end
			end

			if arg_321_1.time_ >= var_324_20 + var_324_22 and arg_321_1.time_ < var_324_20 + var_324_22 + arg_324_0 and arg_321_1.var_.characterEffect10146 then
				arg_321_1.var_.characterEffect10146.alpha = 1
			end

			local var_324_25 = 0

			if var_324_25 < arg_321_1.time_ and arg_321_1.time_ <= var_324_25 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			local var_324_26 = 0.5

			if arg_321_1.time_ >= var_324_25 + var_324_26 and arg_321_1.time_ < var_324_25 + var_324_26 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_27 = 0.5
			local var_324_28 = 0.725

			if var_324_27 < arg_321_1.time_ and arg_321_1.time_ <= var_324_27 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_29 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_29:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_30 = arg_321_1:FormatText(StoryNameCfg[1338].name)

				arg_321_1.leftNameTxt_.text = var_324_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_31 = arg_321_1:GetWordFromCfg(423111081)
				local var_324_32 = arg_321_1:FormatText(var_324_31.content)

				arg_321_1.text_.text = var_324_32

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_33 = 29
				local var_324_34 = utf8.len(var_324_32)
				local var_324_35 = var_324_33 <= 0 and var_324_28 or var_324_28 * (var_324_34 / var_324_33)

				if var_324_35 > 0 and var_324_28 < var_324_35 then
					arg_321_1.talkMaxDuration = var_324_35
					var_324_27 = var_324_27 + 0.3

					if var_324_35 + var_324_27 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_35 + var_324_27
					end
				end

				arg_321_1.text_.text = var_324_32
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111081", "story_v_out_423111.awb") ~= 0 then
					local var_324_36 = manager.audio:GetVoiceLength("story_v_out_423111", "423111081", "story_v_out_423111.awb") / 1000

					if var_324_36 + var_324_27 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_36 + var_324_27
					end

					if var_324_31.prefab_name ~= "" and arg_321_1.actors_[var_324_31.prefab_name] ~= nil then
						local var_324_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_31.prefab_name].transform, "story_v_out_423111", "423111081", "story_v_out_423111.awb")

						arg_321_1:RecordAudio("423111081", var_324_37)
						arg_321_1:RecordAudio("423111081", var_324_37)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_423111", "423111081", "story_v_out_423111.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_423111", "423111081", "story_v_out_423111.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_38 = var_324_27 + 0.3
			local var_324_39 = math.max(var_324_28, arg_321_1.talkMaxDuration)

			if var_324_38 <= arg_321_1.time_ and arg_321_1.time_ < var_324_38 + var_324_39 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_38) / var_324_39

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_38 + var_324_39 and arg_321_1.time_ < var_324_38 + var_324_39 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play423111082 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 423111082
		arg_327_1.duration_ = 8.6

		local var_327_0 = {
			zh = 7.766,
			ja = 8.6
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
				arg_327_0:Play423111083(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10146"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos10146 = var_330_0.localPosition
				var_330_0.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("10146", 3)

				local var_330_2 = var_330_0.childCount

				for iter_330_0 = 0, var_330_2 - 1 do
					local var_330_3 = var_330_0:GetChild(iter_330_0)

					if var_330_3.name == "split_1" or not string.find(var_330_3.name, "split") then
						var_330_3.gameObject:SetActive(true)
					else
						var_330_3.gameObject:SetActive(false)
					end
				end
			end

			local var_330_4 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_4 then
				local var_330_5 = (arg_327_1.time_ - var_330_1) / var_330_4
				local var_330_6 = Vector3.New(0, -350, -320)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10146, var_330_6, var_330_5)
			end

			if arg_327_1.time_ >= var_330_1 + var_330_4 and arg_327_1.time_ < var_330_1 + var_330_4 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_330_7 = 0
			local var_330_8 = 0.825

			if var_330_7 < arg_327_1.time_ and arg_327_1.time_ <= var_330_7 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_9 = arg_327_1:FormatText(StoryNameCfg[1338].name)

				arg_327_1.leftNameTxt_.text = var_330_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_10 = arg_327_1:GetWordFromCfg(423111082)
				local var_330_11 = arg_327_1:FormatText(var_330_10.content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_12 = 33
				local var_330_13 = utf8.len(var_330_11)
				local var_330_14 = var_330_12 <= 0 and var_330_8 or var_330_8 * (var_330_13 / var_330_12)

				if var_330_14 > 0 and var_330_8 < var_330_14 then
					arg_327_1.talkMaxDuration = var_330_14

					if var_330_14 + var_330_7 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_7
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111082", "story_v_out_423111.awb") ~= 0 then
					local var_330_15 = manager.audio:GetVoiceLength("story_v_out_423111", "423111082", "story_v_out_423111.awb") / 1000

					if var_330_15 + var_330_7 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_15 + var_330_7
					end

					if var_330_10.prefab_name ~= "" and arg_327_1.actors_[var_330_10.prefab_name] ~= nil then
						local var_330_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_10.prefab_name].transform, "story_v_out_423111", "423111082", "story_v_out_423111.awb")

						arg_327_1:RecordAudio("423111082", var_330_16)
						arg_327_1:RecordAudio("423111082", var_330_16)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_423111", "423111082", "story_v_out_423111.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_423111", "423111082", "story_v_out_423111.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_17 = math.max(var_330_8, arg_327_1.talkMaxDuration)

			if var_330_7 <= arg_327_1.time_ and arg_327_1.time_ < var_330_7 + var_330_17 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_7) / var_330_17

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_7 + var_330_17 and arg_327_1.time_ < var_330_7 + var_330_17 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423111083 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 423111083
		arg_331_1.duration_ = 7.87

		local var_331_0 = {
			zh = 5.766,
			ja = 7.866
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
				arg_331_0:Play423111084(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["10146"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos10146 = var_334_0.localPosition
				var_334_0.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10146", 3)

				local var_334_2 = var_334_0.childCount

				for iter_334_0 = 0, var_334_2 - 1 do
					local var_334_3 = var_334_0:GetChild(iter_334_0)

					if var_334_3.name == "" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_4 then
				local var_334_5 = (arg_331_1.time_ - var_334_1) / var_334_4
				local var_334_6 = Vector3.New(0, -350, -320)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10146, var_334_6, var_334_5)
			end

			if arg_331_1.time_ >= var_334_1 + var_334_4 and arg_331_1.time_ < var_334_1 + var_334_4 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_334_7 = 0
			local var_334_8 = 0.425

			if var_334_7 < arg_331_1.time_ and arg_331_1.time_ <= var_334_7 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_9 = arg_331_1:FormatText(StoryNameCfg[1338].name)

				arg_331_1.leftNameTxt_.text = var_334_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:GetWordFromCfg(423111083)
				local var_334_11 = arg_331_1:FormatText(var_334_10.content)

				arg_331_1.text_.text = var_334_11

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_12 = 17
				local var_334_13 = utf8.len(var_334_11)
				local var_334_14 = var_334_12 <= 0 and var_334_8 or var_334_8 * (var_334_13 / var_334_12)

				if var_334_14 > 0 and var_334_8 < var_334_14 then
					arg_331_1.talkMaxDuration = var_334_14

					if var_334_14 + var_334_7 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_7
					end
				end

				arg_331_1.text_.text = var_334_11
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111083", "story_v_out_423111.awb") ~= 0 then
					local var_334_15 = manager.audio:GetVoiceLength("story_v_out_423111", "423111083", "story_v_out_423111.awb") / 1000

					if var_334_15 + var_334_7 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_15 + var_334_7
					end

					if var_334_10.prefab_name ~= "" and arg_331_1.actors_[var_334_10.prefab_name] ~= nil then
						local var_334_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_10.prefab_name].transform, "story_v_out_423111", "423111083", "story_v_out_423111.awb")

						arg_331_1:RecordAudio("423111083", var_334_16)
						arg_331_1:RecordAudio("423111083", var_334_16)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_423111", "423111083", "story_v_out_423111.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_423111", "423111083", "story_v_out_423111.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_17 = math.max(var_334_8, arg_331_1.talkMaxDuration)

			if var_334_7 <= arg_331_1.time_ and arg_331_1.time_ < var_334_7 + var_334_17 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_7) / var_334_17

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_7 + var_334_17 and arg_331_1.time_ < var_334_7 + var_334_17 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423111084 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 423111084
		arg_335_1.duration_ = 6.37

		local var_335_0 = {
			zh = 3.533,
			ja = 6.366
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
				arg_335_0:Play423111085(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["10146"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps10146 == nil then
				arg_335_1.var_.actorSpriteComps10146 = var_338_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_2 = 0.2

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 and not isNil(var_338_0) then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.actorSpriteComps10146 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								local var_338_4 = Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor2.r, var_338_3)
								local var_338_5 = Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor2.g, var_338_3)
								local var_338_6 = Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor2.b, var_338_3)

								iter_338_1.color = Color.New(var_338_4, var_338_5, var_338_6)
							else
								local var_338_7 = Mathf.Lerp(iter_338_1.color.r, 0.5, var_338_3)

								iter_338_1.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and not isNil(var_338_0) and arg_335_1.var_.actorSpriteComps10146 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_338_3 then
						if arg_335_1.isInRecall_ then
							iter_338_3.color = arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_338_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_335_1.var_.actorSpriteComps10146 = nil
			end

			local var_338_8 = arg_335_1.actors_["10146"].transform
			local var_338_9 = 0

			if var_338_9 < arg_335_1.time_ and arg_335_1.time_ <= var_338_9 + arg_338_0 then
				arg_335_1.var_.moveOldPos10146 = var_338_8.localPosition
				var_338_8.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10146", 7)

				local var_338_10 = var_338_8.childCount

				for iter_338_4 = 0, var_338_10 - 1 do
					local var_338_11 = var_338_8:GetChild(iter_338_4)

					if var_338_11.name == "" or not string.find(var_338_11.name, "split") then
						var_338_11.gameObject:SetActive(true)
					else
						var_338_11.gameObject:SetActive(false)
					end
				end
			end

			local var_338_12 = 0.001

			if var_338_9 <= arg_335_1.time_ and arg_335_1.time_ < var_338_9 + var_338_12 then
				local var_338_13 = (arg_335_1.time_ - var_338_9) / var_338_12
				local var_338_14 = Vector3.New(0, -2000, 0)

				var_338_8.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10146, var_338_14, var_338_13)
			end

			if arg_335_1.time_ >= var_338_9 + var_338_12 and arg_335_1.time_ < var_338_9 + var_338_12 + arg_338_0 then
				var_338_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_338_15 = 0
			local var_338_16 = 0.275

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_17 = arg_335_1:FormatText(StoryNameCfg[1336].name)

				arg_335_1.leftNameTxt_.text = var_338_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_18 = arg_335_1:GetWordFromCfg(423111084)
				local var_338_19 = arg_335_1:FormatText(var_338_18.content)

				arg_335_1.text_.text = var_338_19

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_20 = 11
				local var_338_21 = utf8.len(var_338_19)
				local var_338_22 = var_338_20 <= 0 and var_338_16 or var_338_16 * (var_338_21 / var_338_20)

				if var_338_22 > 0 and var_338_16 < var_338_22 then
					arg_335_1.talkMaxDuration = var_338_22

					if var_338_22 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_22 + var_338_15
					end
				end

				arg_335_1.text_.text = var_338_19
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111084", "story_v_out_423111.awb") ~= 0 then
					local var_338_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111084", "story_v_out_423111.awb") / 1000

					if var_338_23 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_23 + var_338_15
					end

					if var_338_18.prefab_name ~= "" and arg_335_1.actors_[var_338_18.prefab_name] ~= nil then
						local var_338_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_18.prefab_name].transform, "story_v_out_423111", "423111084", "story_v_out_423111.awb")

						arg_335_1:RecordAudio("423111084", var_338_24)
						arg_335_1:RecordAudio("423111084", var_338_24)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_423111", "423111084", "story_v_out_423111.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_423111", "423111084", "story_v_out_423111.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_25 = math.max(var_338_16, arg_335_1.talkMaxDuration)

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_25 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_15) / var_338_25

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_15 + var_338_25 and arg_335_1.time_ < var_338_15 + var_338_25 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play423111085 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 423111085
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play423111086(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.666666666666667
			local var_342_1 = 1

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				local var_342_2 = "play"
				local var_342_3 = "effect"

				arg_339_1:AudioAction(var_342_2, var_342_3, "se_story_144", "se_story_144_foley_gun02", "")
			end

			local var_342_4 = 0
			local var_342_5 = 1.575

			if var_342_4 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(423111085)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_8 = 64
				local var_342_9 = utf8.len(var_342_7)
				local var_342_10 = var_342_8 <= 0 and var_342_5 or var_342_5 * (var_342_9 / var_342_8)

				if var_342_10 > 0 and var_342_5 < var_342_10 then
					arg_339_1.talkMaxDuration = var_342_10

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_11 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_11 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_11

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_11 and arg_339_1.time_ < var_342_4 + var_342_11 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play423111086 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 423111086
		arg_343_1.duration_ = 11.87

		local var_343_0 = {
			zh = 6.9,
			ja = 11.866
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
				arg_343_0:Play423111087(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.625

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[1336].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(423111086)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 25
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111086", "story_v_out_423111.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111086", "story_v_out_423111.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_423111", "423111086", "story_v_out_423111.awb")

						arg_343_1:RecordAudio("423111086", var_346_9)
						arg_343_1:RecordAudio("423111086", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_423111", "423111086", "story_v_out_423111.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_423111", "423111086", "story_v_out_423111.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play423111087 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 423111087
		arg_347_1.duration_ = 5.6

		local var_347_0 = {
			zh = 2.133,
			ja = 5.6
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
				arg_347_0:Play423111088(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10146"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10146 == nil then
				arg_347_1.var_.actorSpriteComps10146 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 0.2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps10146 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10146:ToTable()) do
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

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10146 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10146 = nil
			end

			local var_350_8 = arg_347_1.actors_["10146"].transform
			local var_350_9 = 0

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 then
				arg_347_1.var_.moveOldPos10146 = var_350_8.localPosition
				var_350_8.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10146", 3)

				local var_350_10 = var_350_8.childCount

				for iter_350_4 = 0, var_350_10 - 1 do
					local var_350_11 = var_350_8:GetChild(iter_350_4)

					if var_350_11.name == "split_3" or not string.find(var_350_11.name, "split") then
						var_350_11.gameObject:SetActive(true)
					else
						var_350_11.gameObject:SetActive(false)
					end
				end
			end

			local var_350_12 = 0.001

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_12 then
				local var_350_13 = (arg_347_1.time_ - var_350_9) / var_350_12
				local var_350_14 = Vector3.New(0, -350, -320)

				var_350_8.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10146, var_350_14, var_350_13)
			end

			if arg_347_1.time_ >= var_350_9 + var_350_12 and arg_347_1.time_ < var_350_9 + var_350_12 + arg_350_0 then
				var_350_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_350_15 = 0
			local var_350_16 = 0.3

			if var_350_15 < arg_347_1.time_ and arg_347_1.time_ <= var_350_15 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_17 = arg_347_1:FormatText(StoryNameCfg[1338].name)

				arg_347_1.leftNameTxt_.text = var_350_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_18 = arg_347_1:GetWordFromCfg(423111087)
				local var_350_19 = arg_347_1:FormatText(var_350_18.content)

				arg_347_1.text_.text = var_350_19

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_20 = 12
				local var_350_21 = utf8.len(var_350_19)
				local var_350_22 = var_350_20 <= 0 and var_350_16 or var_350_16 * (var_350_21 / var_350_20)

				if var_350_22 > 0 and var_350_16 < var_350_22 then
					arg_347_1.talkMaxDuration = var_350_22

					if var_350_22 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_22 + var_350_15
					end
				end

				arg_347_1.text_.text = var_350_19
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111087", "story_v_out_423111.awb") ~= 0 then
					local var_350_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111087", "story_v_out_423111.awb") / 1000

					if var_350_23 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_15
					end

					if var_350_18.prefab_name ~= "" and arg_347_1.actors_[var_350_18.prefab_name] ~= nil then
						local var_350_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_18.prefab_name].transform, "story_v_out_423111", "423111087", "story_v_out_423111.awb")

						arg_347_1:RecordAudio("423111087", var_350_24)
						arg_347_1:RecordAudio("423111087", var_350_24)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_423111", "423111087", "story_v_out_423111.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_423111", "423111087", "story_v_out_423111.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_25 = math.max(var_350_16, arg_347_1.talkMaxDuration)

			if var_350_15 <= arg_347_1.time_ and arg_347_1.time_ < var_350_15 + var_350_25 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_15) / var_350_25

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_15 + var_350_25 and arg_347_1.time_ < var_350_15 + var_350_25 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play423111088 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 423111088
		arg_351_1.duration_ = 7

		local var_351_0 = {
			zh = 7,
			ja = 5.4
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
				arg_351_0:Play423111089(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["10146"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10146 == nil then
				arg_351_1.var_.actorSpriteComps10146 = var_354_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_2 = 0.2

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.actorSpriteComps10146 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								local var_354_4 = Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor2.r, var_354_3)
								local var_354_5 = Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor2.g, var_354_3)
								local var_354_6 = Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor2.b, var_354_3)

								iter_354_1.color = Color.New(var_354_4, var_354_5, var_354_6)
							else
								local var_354_7 = Mathf.Lerp(iter_354_1.color.r, 0.5, var_354_3)

								iter_354_1.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.actorSpriteComps10146 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_354_3 then
						if arg_351_1.isInRecall_ then
							iter_354_3.color = arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_354_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_351_1.var_.actorSpriteComps10146 = nil
			end

			local var_354_8 = arg_351_1.actors_["10146"].transform
			local var_354_9 = 0

			if var_354_9 < arg_351_1.time_ and arg_351_1.time_ <= var_354_9 + arg_354_0 then
				arg_351_1.var_.moveOldPos10146 = var_354_8.localPosition
				var_354_8.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("10146", 7)

				local var_354_10 = var_354_8.childCount

				for iter_354_4 = 0, var_354_10 - 1 do
					local var_354_11 = var_354_8:GetChild(iter_354_4)

					if var_354_11.name == "" or not string.find(var_354_11.name, "split") then
						var_354_11.gameObject:SetActive(true)
					else
						var_354_11.gameObject:SetActive(false)
					end
				end
			end

			local var_354_12 = 0.001

			if var_354_9 <= arg_351_1.time_ and arg_351_1.time_ < var_354_9 + var_354_12 then
				local var_354_13 = (arg_351_1.time_ - var_354_9) / var_354_12
				local var_354_14 = Vector3.New(0, -2000, 0)

				var_354_8.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10146, var_354_14, var_354_13)
			end

			if arg_351_1.time_ >= var_354_9 + var_354_12 and arg_351_1.time_ < var_354_9 + var_354_12 + arg_354_0 then
				var_354_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_354_15 = 0
			local var_354_16 = 0.55

			if var_354_15 < arg_351_1.time_ and arg_351_1.time_ <= var_354_15 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_17 = arg_351_1:FormatText(StoryNameCfg[1336].name)

				arg_351_1.leftNameTxt_.text = var_354_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_18 = arg_351_1:GetWordFromCfg(423111088)
				local var_354_19 = arg_351_1:FormatText(var_354_18.content)

				arg_351_1.text_.text = var_354_19

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_20 = 22
				local var_354_21 = utf8.len(var_354_19)
				local var_354_22 = var_354_20 <= 0 and var_354_16 or var_354_16 * (var_354_21 / var_354_20)

				if var_354_22 > 0 and var_354_16 < var_354_22 then
					arg_351_1.talkMaxDuration = var_354_22

					if var_354_22 + var_354_15 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_22 + var_354_15
					end
				end

				arg_351_1.text_.text = var_354_19
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111088", "story_v_out_423111.awb") ~= 0 then
					local var_354_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111088", "story_v_out_423111.awb") / 1000

					if var_354_23 + var_354_15 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_23 + var_354_15
					end

					if var_354_18.prefab_name ~= "" and arg_351_1.actors_[var_354_18.prefab_name] ~= nil then
						local var_354_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_18.prefab_name].transform, "story_v_out_423111", "423111088", "story_v_out_423111.awb")

						arg_351_1:RecordAudio("423111088", var_354_24)
						arg_351_1:RecordAudio("423111088", var_354_24)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_423111", "423111088", "story_v_out_423111.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_423111", "423111088", "story_v_out_423111.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_25 = math.max(var_354_16, arg_351_1.talkMaxDuration)

			if var_354_15 <= arg_351_1.time_ and arg_351_1.time_ < var_354_15 + var_354_25 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_15) / var_354_25

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_15 + var_354_25 and arg_351_1.time_ < var_354_15 + var_354_25 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play423111089 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 423111089
		arg_355_1.duration_ = 13.13

		local var_355_0 = {
			zh = 7.166,
			ja = 13.133
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play423111090(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 0.825

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_2 = arg_355_1:FormatText(StoryNameCfg[1335].name)

				arg_355_1.leftNameTxt_.text = var_358_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:GetWordFromCfg(423111089)
				local var_358_4 = arg_355_1:FormatText(var_358_3.content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 33
				local var_358_6 = utf8.len(var_358_4)
				local var_358_7 = var_358_5 <= 0 and var_358_1 or var_358_1 * (var_358_6 / var_358_5)

				if var_358_7 > 0 and var_358_1 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111089", "story_v_out_423111.awb") ~= 0 then
					local var_358_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111089", "story_v_out_423111.awb") / 1000

					if var_358_8 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_0
					end

					if var_358_3.prefab_name ~= "" and arg_355_1.actors_[var_358_3.prefab_name] ~= nil then
						local var_358_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_3.prefab_name].transform, "story_v_out_423111", "423111089", "story_v_out_423111.awb")

						arg_355_1:RecordAudio("423111089", var_358_9)
						arg_355_1:RecordAudio("423111089", var_358_9)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_423111", "423111089", "story_v_out_423111.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_423111", "423111089", "story_v_out_423111.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_10 and arg_355_1.time_ < var_358_0 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play423111090 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 423111090
		arg_359_1.duration_ = 10.97

		local var_359_0 = {
			zh = 10.966,
			ja = 8.4
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
				arg_359_0:Play423111091(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 1

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[1336].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_3 = arg_359_1:GetWordFromCfg(423111090)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 40
				local var_362_6 = utf8.len(var_362_4)
				local var_362_7 = var_362_5 <= 0 and var_362_1 or var_362_1 * (var_362_6 / var_362_5)

				if var_362_7 > 0 and var_362_1 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111090", "story_v_out_423111.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111090", "story_v_out_423111.awb") / 1000

					if var_362_8 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_0
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_out_423111", "423111090", "story_v_out_423111.awb")

						arg_359_1:RecordAudio("423111090", var_362_9)
						arg_359_1:RecordAudio("423111090", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_423111", "423111090", "story_v_out_423111.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_423111", "423111090", "story_v_out_423111.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_10 and arg_359_1.time_ < var_362_0 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play423111091 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 423111091
		arg_363_1.duration_ = 10.77

		local var_363_0 = {
			zh = 5.866,
			ja = 10.766
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play423111092(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["10146"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10146 == nil then
				arg_363_1.var_.actorSpriteComps10146 = var_366_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_2 = 0.2

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.actorSpriteComps10146 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								local var_366_4 = Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor1.r, var_366_3)
								local var_366_5 = Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor1.g, var_366_3)
								local var_366_6 = Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor1.b, var_366_3)

								iter_366_1.color = Color.New(var_366_4, var_366_5, var_366_6)
							else
								local var_366_7 = Mathf.Lerp(iter_366_1.color.r, 1, var_366_3)

								iter_366_1.color = Color.New(var_366_7, var_366_7, var_366_7)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.actorSpriteComps10146 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_366_3 then
						if arg_363_1.isInRecall_ then
							iter_366_3.color = arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_366_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps10146 = nil
			end

			local var_366_8 = arg_363_1.actors_["10146"].transform
			local var_366_9 = 0

			if var_366_9 < arg_363_1.time_ and arg_363_1.time_ <= var_366_9 + arg_366_0 then
				arg_363_1.var_.moveOldPos10146 = var_366_8.localPosition
				var_366_8.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10146", 3)

				local var_366_10 = var_366_8.childCount

				for iter_366_4 = 0, var_366_10 - 1 do
					local var_366_11 = var_366_8:GetChild(iter_366_4)

					if var_366_11.name == "split_4" or not string.find(var_366_11.name, "split") then
						var_366_11.gameObject:SetActive(true)
					else
						var_366_11.gameObject:SetActive(false)
					end
				end
			end

			local var_366_12 = 0.001

			if var_366_9 <= arg_363_1.time_ and arg_363_1.time_ < var_366_9 + var_366_12 then
				local var_366_13 = (arg_363_1.time_ - var_366_9) / var_366_12
				local var_366_14 = Vector3.New(0, -350, -320)

				var_366_8.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10146, var_366_14, var_366_13)
			end

			if arg_363_1.time_ >= var_366_9 + var_366_12 and arg_363_1.time_ < var_366_9 + var_366_12 + arg_366_0 then
				var_366_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_366_15 = 0
			local var_366_16 = 0.575

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_17 = arg_363_1:FormatText(StoryNameCfg[1338].name)

				arg_363_1.leftNameTxt_.text = var_366_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_18 = arg_363_1:GetWordFromCfg(423111091)
				local var_366_19 = arg_363_1:FormatText(var_366_18.content)

				arg_363_1.text_.text = var_366_19

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_20 = 23
				local var_366_21 = utf8.len(var_366_19)
				local var_366_22 = var_366_20 <= 0 and var_366_16 or var_366_16 * (var_366_21 / var_366_20)

				if var_366_22 > 0 and var_366_16 < var_366_22 then
					arg_363_1.talkMaxDuration = var_366_22

					if var_366_22 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_22 + var_366_15
					end
				end

				arg_363_1.text_.text = var_366_19
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111091", "story_v_out_423111.awb") ~= 0 then
					local var_366_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111091", "story_v_out_423111.awb") / 1000

					if var_366_23 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_23 + var_366_15
					end

					if var_366_18.prefab_name ~= "" and arg_363_1.actors_[var_366_18.prefab_name] ~= nil then
						local var_366_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_18.prefab_name].transform, "story_v_out_423111", "423111091", "story_v_out_423111.awb")

						arg_363_1:RecordAudio("423111091", var_366_24)
						arg_363_1:RecordAudio("423111091", var_366_24)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_423111", "423111091", "story_v_out_423111.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_423111", "423111091", "story_v_out_423111.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_25 = math.max(var_366_16, arg_363_1.talkMaxDuration)

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_25 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_15) / var_366_25

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_15 + var_366_25 and arg_363_1.time_ < var_366_15 + var_366_25 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play423111092 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 423111092
		arg_367_1.duration_ = 8.3

		local var_367_0 = {
			zh = 7.433,
			ja = 8.3
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play423111093(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10146"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps10146 == nil then
				arg_367_1.var_.actorSpriteComps10146 = var_370_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_2 = 0.2

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.actorSpriteComps10146 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								local var_370_4 = Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor2.r, var_370_3)
								local var_370_5 = Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor2.g, var_370_3)
								local var_370_6 = Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor2.b, var_370_3)

								iter_370_1.color = Color.New(var_370_4, var_370_5, var_370_6)
							else
								local var_370_7 = Mathf.Lerp(iter_370_1.color.r, 0.5, var_370_3)

								iter_370_1.color = Color.New(var_370_7, var_370_7, var_370_7)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.actorSpriteComps10146 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_370_3 then
						if arg_367_1.isInRecall_ then
							iter_370_3.color = arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_370_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps10146 = nil
			end

			local var_370_8 = 0
			local var_370_9 = 0.825

			if var_370_8 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_10 = arg_367_1:FormatText(StoryNameCfg[1336].name)

				arg_367_1.leftNameTxt_.text = var_370_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_11 = arg_367_1:GetWordFromCfg(423111092)
				local var_370_12 = arg_367_1:FormatText(var_370_11.content)

				arg_367_1.text_.text = var_370_12

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 33
				local var_370_14 = utf8.len(var_370_12)
				local var_370_15 = var_370_13 <= 0 and var_370_9 or var_370_9 * (var_370_14 / var_370_13)

				if var_370_15 > 0 and var_370_9 < var_370_15 then
					arg_367_1.talkMaxDuration = var_370_15

					if var_370_15 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_15 + var_370_8
					end
				end

				arg_367_1.text_.text = var_370_12
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111092", "story_v_out_423111.awb") ~= 0 then
					local var_370_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111092", "story_v_out_423111.awb") / 1000

					if var_370_16 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_16 + var_370_8
					end

					if var_370_11.prefab_name ~= "" and arg_367_1.actors_[var_370_11.prefab_name] ~= nil then
						local var_370_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_11.prefab_name].transform, "story_v_out_423111", "423111092", "story_v_out_423111.awb")

						arg_367_1:RecordAudio("423111092", var_370_17)
						arg_367_1:RecordAudio("423111092", var_370_17)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_423111", "423111092", "story_v_out_423111.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_423111", "423111092", "story_v_out_423111.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_18 = math.max(var_370_9, arg_367_1.talkMaxDuration)

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_18 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_8) / var_370_18

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_8 + var_370_18 and arg_367_1.time_ < var_370_8 + var_370_18 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play423111093 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 423111093
		arg_371_1.duration_ = 9.47

		local var_371_0 = {
			zh = 6.8,
			ja = 9.466
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play423111094(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 0.825

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_2 = arg_371_1:FormatText(StoryNameCfg[1336].name)

				arg_371_1.leftNameTxt_.text = var_374_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:GetWordFromCfg(423111093)
				local var_374_4 = arg_371_1:FormatText(var_374_3.content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 33
				local var_374_6 = utf8.len(var_374_4)
				local var_374_7 = var_374_5 <= 0 and var_374_1 or var_374_1 * (var_374_6 / var_374_5)

				if var_374_7 > 0 and var_374_1 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_0
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111093", "story_v_out_423111.awb") ~= 0 then
					local var_374_8 = manager.audio:GetVoiceLength("story_v_out_423111", "423111093", "story_v_out_423111.awb") / 1000

					if var_374_8 + var_374_0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_0
					end

					if var_374_3.prefab_name ~= "" and arg_371_1.actors_[var_374_3.prefab_name] ~= nil then
						local var_374_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_3.prefab_name].transform, "story_v_out_423111", "423111093", "story_v_out_423111.awb")

						arg_371_1:RecordAudio("423111093", var_374_9)
						arg_371_1:RecordAudio("423111093", var_374_9)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_423111", "423111093", "story_v_out_423111.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_423111", "423111093", "story_v_out_423111.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_10 = math.max(var_374_1, arg_371_1.talkMaxDuration)

			if var_374_0 <= arg_371_1.time_ and arg_371_1.time_ < var_374_0 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_0) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_0 + var_374_10 and arg_371_1.time_ < var_374_0 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play423111094 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 423111094
		arg_375_1.duration_ = 4.8

		local var_375_0 = {
			zh = 3.366,
			ja = 4.8
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play423111095(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10146"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps10146 == nil then
				arg_375_1.var_.actorSpriteComps10146 = var_378_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_2 = 0.2

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.actorSpriteComps10146 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								local var_378_4 = Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, var_378_3)
								local var_378_5 = Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, var_378_3)
								local var_378_6 = Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, var_378_3)

								iter_378_1.color = Color.New(var_378_4, var_378_5, var_378_6)
							else
								local var_378_7 = Mathf.Lerp(iter_378_1.color.r, 1, var_378_3)

								iter_378_1.color = Color.New(var_378_7, var_378_7, var_378_7)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.actorSpriteComps10146 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_378_3 then
						if arg_375_1.isInRecall_ then
							iter_378_3.color = arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_378_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps10146 = nil
			end

			local var_378_8 = arg_375_1.actors_["10146"].transform
			local var_378_9 = 0

			if var_378_9 < arg_375_1.time_ and arg_375_1.time_ <= var_378_9 + arg_378_0 then
				arg_375_1.var_.moveOldPos10146 = var_378_8.localPosition
				var_378_8.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10146", 3)

				local var_378_10 = var_378_8.childCount

				for iter_378_4 = 0, var_378_10 - 1 do
					local var_378_11 = var_378_8:GetChild(iter_378_4)

					if var_378_11.name == "split_3" or not string.find(var_378_11.name, "split") then
						var_378_11.gameObject:SetActive(true)
					else
						var_378_11.gameObject:SetActive(false)
					end
				end
			end

			local var_378_12 = 0.001

			if var_378_9 <= arg_375_1.time_ and arg_375_1.time_ < var_378_9 + var_378_12 then
				local var_378_13 = (arg_375_1.time_ - var_378_9) / var_378_12
				local var_378_14 = Vector3.New(0, -350, -320)

				var_378_8.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10146, var_378_14, var_378_13)
			end

			if arg_375_1.time_ >= var_378_9 + var_378_12 and arg_375_1.time_ < var_378_9 + var_378_12 + arg_378_0 then
				var_378_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_378_15 = 0
			local var_378_16 = 0.4

			if var_378_15 < arg_375_1.time_ and arg_375_1.time_ <= var_378_15 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_17 = arg_375_1:FormatText(StoryNameCfg[1338].name)

				arg_375_1.leftNameTxt_.text = var_378_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_18 = arg_375_1:GetWordFromCfg(423111094)
				local var_378_19 = arg_375_1:FormatText(var_378_18.content)

				arg_375_1.text_.text = var_378_19

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_20 = 16
				local var_378_21 = utf8.len(var_378_19)
				local var_378_22 = var_378_20 <= 0 and var_378_16 or var_378_16 * (var_378_21 / var_378_20)

				if var_378_22 > 0 and var_378_16 < var_378_22 then
					arg_375_1.talkMaxDuration = var_378_22

					if var_378_22 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_22 + var_378_15
					end
				end

				arg_375_1.text_.text = var_378_19
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111094", "story_v_out_423111.awb") ~= 0 then
					local var_378_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111094", "story_v_out_423111.awb") / 1000

					if var_378_23 + var_378_15 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_23 + var_378_15
					end

					if var_378_18.prefab_name ~= "" and arg_375_1.actors_[var_378_18.prefab_name] ~= nil then
						local var_378_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_18.prefab_name].transform, "story_v_out_423111", "423111094", "story_v_out_423111.awb")

						arg_375_1:RecordAudio("423111094", var_378_24)
						arg_375_1:RecordAudio("423111094", var_378_24)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_423111", "423111094", "story_v_out_423111.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_423111", "423111094", "story_v_out_423111.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_25 = math.max(var_378_16, arg_375_1.talkMaxDuration)

			if var_378_15 <= arg_375_1.time_ and arg_375_1.time_ < var_378_15 + var_378_25 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_15) / var_378_25

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_15 + var_378_25 and arg_375_1.time_ < var_378_15 + var_378_25 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play423111095 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 423111095
		arg_379_1.duration_ = 2.63

		local var_379_0 = {
			zh = 2.066,
			ja = 2.633
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play423111096(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["10146"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps10146 == nil then
				arg_379_1.var_.actorSpriteComps10146 = var_382_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_2 = 0.2

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.actorSpriteComps10146 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								local var_382_4 = Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor2.r, var_382_3)
								local var_382_5 = Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor2.g, var_382_3)
								local var_382_6 = Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor2.b, var_382_3)

								iter_382_1.color = Color.New(var_382_4, var_382_5, var_382_6)
							else
								local var_382_7 = Mathf.Lerp(iter_382_1.color.r, 0.5, var_382_3)

								iter_382_1.color = Color.New(var_382_7, var_382_7, var_382_7)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.actorSpriteComps10146 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_382_3 then
						if arg_379_1.isInRecall_ then
							iter_382_3.color = arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_382_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_379_1.var_.actorSpriteComps10146 = nil
			end

			local var_382_8 = 0
			local var_382_9 = 0.175

			if var_382_8 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_10 = arg_379_1:FormatText(StoryNameCfg[1336].name)

				arg_379_1.leftNameTxt_.text = var_382_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_11 = arg_379_1:GetWordFromCfg(423111095)
				local var_382_12 = arg_379_1:FormatText(var_382_11.content)

				arg_379_1.text_.text = var_382_12

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_13 = 7
				local var_382_14 = utf8.len(var_382_12)
				local var_382_15 = var_382_13 <= 0 and var_382_9 or var_382_9 * (var_382_14 / var_382_13)

				if var_382_15 > 0 and var_382_9 < var_382_15 then
					arg_379_1.talkMaxDuration = var_382_15

					if var_382_15 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_15 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_12
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111095", "story_v_out_423111.awb") ~= 0 then
					local var_382_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111095", "story_v_out_423111.awb") / 1000

					if var_382_16 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_16 + var_382_8
					end

					if var_382_11.prefab_name ~= "" and arg_379_1.actors_[var_382_11.prefab_name] ~= nil then
						local var_382_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_11.prefab_name].transform, "story_v_out_423111", "423111095", "story_v_out_423111.awb")

						arg_379_1:RecordAudio("423111095", var_382_17)
						arg_379_1:RecordAudio("423111095", var_382_17)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_423111", "423111095", "story_v_out_423111.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_423111", "423111095", "story_v_out_423111.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_18 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_18 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_18

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_18 and arg_379_1.time_ < var_382_8 + var_382_18 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play423111096 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 423111096
		arg_383_1.duration_ = 3.93

		local var_383_0 = {
			zh = 2.3,
			ja = 3.933
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play423111097(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["10146"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps10146 == nil then
				arg_383_1.var_.actorSpriteComps10146 = var_386_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.actorSpriteComps10146 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								local var_386_4 = Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor1.r, var_386_3)
								local var_386_5 = Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor1.g, var_386_3)
								local var_386_6 = Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor1.b, var_386_3)

								iter_386_1.color = Color.New(var_386_4, var_386_5, var_386_6)
							else
								local var_386_7 = Mathf.Lerp(iter_386_1.color.r, 1, var_386_3)

								iter_386_1.color = Color.New(var_386_7, var_386_7, var_386_7)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.actorSpriteComps10146 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_386_3 then
						if arg_383_1.isInRecall_ then
							iter_386_3.color = arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_386_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps10146 = nil
			end

			local var_386_8 = arg_383_1.actors_["10146"].transform
			local var_386_9 = 0

			if var_386_9 < arg_383_1.time_ and arg_383_1.time_ <= var_386_9 + arg_386_0 then
				arg_383_1.var_.moveOldPos10146 = var_386_8.localPosition
				var_386_8.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10146", 3)

				local var_386_10 = var_386_8.childCount

				for iter_386_4 = 0, var_386_10 - 1 do
					local var_386_11 = var_386_8:GetChild(iter_386_4)

					if var_386_11.name == "split_3" or not string.find(var_386_11.name, "split") then
						var_386_11.gameObject:SetActive(true)
					else
						var_386_11.gameObject:SetActive(false)
					end
				end
			end

			local var_386_12 = 0.001

			if var_386_9 <= arg_383_1.time_ and arg_383_1.time_ < var_386_9 + var_386_12 then
				local var_386_13 = (arg_383_1.time_ - var_386_9) / var_386_12
				local var_386_14 = Vector3.New(0, -350, -320)

				var_386_8.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10146, var_386_14, var_386_13)
			end

			if arg_383_1.time_ >= var_386_9 + var_386_12 and arg_383_1.time_ < var_386_9 + var_386_12 + arg_386_0 then
				var_386_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_386_15 = 0
			local var_386_16 = 0.25

			if var_386_15 < arg_383_1.time_ and arg_383_1.time_ <= var_386_15 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_17 = arg_383_1:FormatText(StoryNameCfg[1338].name)

				arg_383_1.leftNameTxt_.text = var_386_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_18 = arg_383_1:GetWordFromCfg(423111096)
				local var_386_19 = arg_383_1:FormatText(var_386_18.content)

				arg_383_1.text_.text = var_386_19

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_20 = 10
				local var_386_21 = utf8.len(var_386_19)
				local var_386_22 = var_386_20 <= 0 and var_386_16 or var_386_16 * (var_386_21 / var_386_20)

				if var_386_22 > 0 and var_386_16 < var_386_22 then
					arg_383_1.talkMaxDuration = var_386_22

					if var_386_22 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_22 + var_386_15
					end
				end

				arg_383_1.text_.text = var_386_19
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111096", "story_v_out_423111.awb") ~= 0 then
					local var_386_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111096", "story_v_out_423111.awb") / 1000

					if var_386_23 + var_386_15 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_23 + var_386_15
					end

					if var_386_18.prefab_name ~= "" and arg_383_1.actors_[var_386_18.prefab_name] ~= nil then
						local var_386_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_18.prefab_name].transform, "story_v_out_423111", "423111096", "story_v_out_423111.awb")

						arg_383_1:RecordAudio("423111096", var_386_24)
						arg_383_1:RecordAudio("423111096", var_386_24)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_423111", "423111096", "story_v_out_423111.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_423111", "423111096", "story_v_out_423111.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_25 = math.max(var_386_16, arg_383_1.talkMaxDuration)

			if var_386_15 <= arg_383_1.time_ and arg_383_1.time_ < var_386_15 + var_386_25 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_15) / var_386_25

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_15 + var_386_25 and arg_383_1.time_ < var_386_15 + var_386_25 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play423111097 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 423111097
		arg_387_1.duration_ = 7.57

		local var_387_0 = {
			zh = 7.2,
			ja = 7.566
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play423111098(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["10146"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.actorSpriteComps10146 == nil then
				arg_387_1.var_.actorSpriteComps10146 = var_390_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_2 = 0.2

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 and not isNil(var_390_0) then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.actorSpriteComps10146 then
					for iter_390_0, iter_390_1 in pairs(arg_387_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_390_1 then
							if arg_387_1.isInRecall_ then
								local var_390_4 = Mathf.Lerp(iter_390_1.color.r, arg_387_1.hightColor2.r, var_390_3)
								local var_390_5 = Mathf.Lerp(iter_390_1.color.g, arg_387_1.hightColor2.g, var_390_3)
								local var_390_6 = Mathf.Lerp(iter_390_1.color.b, arg_387_1.hightColor2.b, var_390_3)

								iter_390_1.color = Color.New(var_390_4, var_390_5, var_390_6)
							else
								local var_390_7 = Mathf.Lerp(iter_390_1.color.r, 0.5, var_390_3)

								iter_390_1.color = Color.New(var_390_7, var_390_7, var_390_7)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and not isNil(var_390_0) and arg_387_1.var_.actorSpriteComps10146 then
				for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_390_3 then
						if arg_387_1.isInRecall_ then
							iter_390_3.color = arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_390_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps10146 = nil
			end

			local var_390_8 = 0
			local var_390_9 = 0.5

			if var_390_8 < arg_387_1.time_ and arg_387_1.time_ <= var_390_8 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_10 = arg_387_1:FormatText(StoryNameCfg[1336].name)

				arg_387_1.leftNameTxt_.text = var_390_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_11 = arg_387_1:GetWordFromCfg(423111097)
				local var_390_12 = arg_387_1:FormatText(var_390_11.content)

				arg_387_1.text_.text = var_390_12

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_13 = 20
				local var_390_14 = utf8.len(var_390_12)
				local var_390_15 = var_390_13 <= 0 and var_390_9 or var_390_9 * (var_390_14 / var_390_13)

				if var_390_15 > 0 and var_390_9 < var_390_15 then
					arg_387_1.talkMaxDuration = var_390_15

					if var_390_15 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_15 + var_390_8
					end
				end

				arg_387_1.text_.text = var_390_12
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111097", "story_v_out_423111.awb") ~= 0 then
					local var_390_16 = manager.audio:GetVoiceLength("story_v_out_423111", "423111097", "story_v_out_423111.awb") / 1000

					if var_390_16 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_16 + var_390_8
					end

					if var_390_11.prefab_name ~= "" and arg_387_1.actors_[var_390_11.prefab_name] ~= nil then
						local var_390_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_11.prefab_name].transform, "story_v_out_423111", "423111097", "story_v_out_423111.awb")

						arg_387_1:RecordAudio("423111097", var_390_17)
						arg_387_1:RecordAudio("423111097", var_390_17)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_423111", "423111097", "story_v_out_423111.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_423111", "423111097", "story_v_out_423111.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_18 = math.max(var_390_9, arg_387_1.talkMaxDuration)

			if var_390_8 <= arg_387_1.time_ and arg_387_1.time_ < var_390_8 + var_390_18 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_8) / var_390_18

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_8 + var_390_18 and arg_387_1.time_ < var_390_8 + var_390_18 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play423111098 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 423111098
		arg_391_1.duration_ = 5.79

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play423111099(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["10146"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos10146 = var_394_0.localPosition
				var_394_0.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("10146", 7)

				local var_394_2 = var_394_0.childCount

				for iter_394_0 = 0, var_394_2 - 1 do
					local var_394_3 = var_394_0:GetChild(iter_394_0)

					if var_394_3.name == "" or not string.find(var_394_3.name, "split") then
						var_394_3.gameObject:SetActive(true)
					else
						var_394_3.gameObject:SetActive(false)
					end
				end
			end

			local var_394_4 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_4 then
				local var_394_5 = (arg_391_1.time_ - var_394_1) / var_394_4
				local var_394_6 = Vector3.New(0, -2000, 0)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10146, var_394_6, var_394_5)
			end

			if arg_391_1.time_ >= var_394_1 + var_394_4 and arg_391_1.time_ < var_394_1 + var_394_4 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_394_7 = manager.ui.mainCamera.transform
			local var_394_8 = 0

			if var_394_8 < arg_391_1.time_ and arg_391_1.time_ <= var_394_8 + arg_394_0 then
				arg_391_1.var_.shakeOldPos = var_394_7.localPosition
			end

			local var_394_9 = 0.6

			if var_394_8 <= arg_391_1.time_ and arg_391_1.time_ < var_394_8 + var_394_9 then
				local var_394_10 = (arg_391_1.time_ - var_394_8) / 0.066
				local var_394_11, var_394_12 = math.modf(var_394_10)

				var_394_7.localPosition = Vector3.New(var_394_12 * 0.13, var_394_12 * 0.13, var_394_12 * 0.13) + arg_391_1.var_.shakeOldPos
			end

			if arg_391_1.time_ >= var_394_8 + var_394_9 and arg_391_1.time_ < var_394_8 + var_394_9 + arg_394_0 then
				var_394_7.localPosition = arg_391_1.var_.shakeOldPos
			end

			local var_394_13 = arg_391_1.bgs_.ST0112a.transform
			local var_394_14 = 0

			if var_394_14 < arg_391_1.time_ and arg_391_1.time_ <= var_394_14 + arg_394_0 then
				arg_391_1.var_.moveOldPosST0112a = var_394_13.localPosition
			end

			local var_394_15 = 1.03333333333333

			if var_394_14 <= arg_391_1.time_ and arg_391_1.time_ < var_394_14 + var_394_15 then
				local var_394_16 = (arg_391_1.time_ - var_394_14) / var_394_15
				local var_394_17 = Vector3.New(0, 1, 9)

				var_394_13.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPosST0112a, var_394_17, var_394_16)
			end

			if arg_391_1.time_ >= var_394_14 + var_394_15 and arg_391_1.time_ < var_394_14 + var_394_15 + arg_394_0 then
				var_394_13.localPosition = Vector3.New(0, 1, 9)
			end

			local var_394_18 = 0

			if var_394_18 < arg_391_1.time_ and arg_391_1.time_ <= var_394_18 + arg_394_0 then
				arg_391_1.allBtn_.enabled = false
			end

			local var_394_19 = 0.792061896296218

			if arg_391_1.time_ >= var_394_18 + var_394_19 and arg_391_1.time_ < var_394_18 + var_394_19 + arg_394_0 then
				arg_391_1.allBtn_.enabled = true
			end

			local var_394_20 = 0.858728562962885
			local var_394_21 = 1

			if var_394_20 < arg_391_1.time_ and arg_391_1.time_ <= var_394_20 + arg_394_0 then
				local var_394_22 = "play"
				local var_394_23 = "effect"

				arg_391_1:AudioAction(var_394_22, var_394_23, "se_story_141", "se_story_141_boxing_fight01", "")
			end

			local var_394_24 = 1.49206189629622
			local var_394_25 = 1

			if var_394_24 < arg_391_1.time_ and arg_391_1.time_ <= var_394_24 + arg_394_0 then
				local var_394_26 = "play"
				local var_394_27 = "effect"

				arg_391_1:AudioAction(var_394_26, var_394_27, "se_story_1311", "se_story_1311_drop", "")
			end

			if arg_391_1.frameCnt_ <= 1 then
				arg_391_1.dialog_:SetActive(false)
			end

			local var_394_28 = 0.792061896296218
			local var_394_29 = 1.7

			if var_394_28 < arg_391_1.time_ and arg_391_1.time_ <= var_394_28 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_30 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_30:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_391_1.dialogCg_.alpha = arg_395_0
				end))
				var_394_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_31 = arg_391_1:GetWordFromCfg(423111098)
				local var_394_32 = arg_391_1:FormatText(var_394_31.content)

				arg_391_1.text_.text = var_394_32

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_33 = 68
				local var_394_34 = utf8.len(var_394_32)
				local var_394_35 = var_394_33 <= 0 and var_394_29 or var_394_29 * (var_394_34 / var_394_33)

				if var_394_35 > 0 and var_394_29 < var_394_35 then
					arg_391_1.talkMaxDuration = var_394_35
					var_394_28 = var_394_28 + 0.3

					if var_394_35 + var_394_28 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_35 + var_394_28
					end
				end

				arg_391_1.text_.text = var_394_32
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_36 = var_394_28 + 0.3
			local var_394_37 = math.max(var_394_29, arg_391_1.talkMaxDuration)

			if var_394_36 <= arg_391_1.time_ and arg_391_1.time_ < var_394_36 + var_394_37 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_36) / var_394_37

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_36 + var_394_37 and arg_391_1.time_ < var_394_36 + var_394_37 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "ST0112a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.03333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeOutCirc
				}
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play423111099 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 423111099
		arg_397_1.duration_ = 9

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play423111100(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 2

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				local var_400_1 = manager.ui.mainCamera.transform.localPosition
				local var_400_2 = Vector3.New(0, 0, 10) + Vector3.New(var_400_1.x, var_400_1.y, 0)
				local var_400_3 = arg_397_1.bgs_.ST0112a

				var_400_3.transform.localPosition = var_400_2
				var_400_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_400_4 = var_400_3:GetComponent("SpriteRenderer")

				if var_400_4 and var_400_4.sprite then
					local var_400_5 = (var_400_3.transform.localPosition - var_400_1).z
					local var_400_6 = manager.ui.mainCameraCom_
					local var_400_7 = 2 * var_400_5 * Mathf.Tan(var_400_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_400_8 = var_400_7 * var_400_6.aspect
					local var_400_9 = var_400_4.sprite.bounds.size.x
					local var_400_10 = var_400_4.sprite.bounds.size.y
					local var_400_11 = var_400_8 / var_400_9
					local var_400_12 = var_400_7 / var_400_10
					local var_400_13 = var_400_12 < var_400_11 and var_400_11 or var_400_12

					var_400_3.transform.localScale = Vector3.New(var_400_13, var_400_13, 0)
				end

				for iter_400_0, iter_400_1 in pairs(arg_397_1.bgs_) do
					if iter_400_0 ~= "ST0112a" then
						iter_400_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_400_14 = 4

			if var_400_14 < arg_397_1.time_ and arg_397_1.time_ <= var_400_14 + arg_400_0 then
				arg_397_1.allBtn_.enabled = false
			end

			local var_400_15 = 0.3

			if arg_397_1.time_ >= var_400_14 + var_400_15 and arg_397_1.time_ < var_400_14 + var_400_15 + arg_400_0 then
				arg_397_1.allBtn_.enabled = true
			end

			local var_400_16 = 0

			if var_400_16 < arg_397_1.time_ and arg_397_1.time_ <= var_400_16 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_17 = 2

			if var_400_16 <= arg_397_1.time_ and arg_397_1.time_ < var_400_16 + var_400_17 then
				local var_400_18 = (arg_397_1.time_ - var_400_16) / var_400_17
				local var_400_19 = Color.New(0, 0, 0)

				var_400_19.a = Mathf.Lerp(0, 1, var_400_18)
				arg_397_1.mask_.color = var_400_19
			end

			if arg_397_1.time_ >= var_400_16 + var_400_17 and arg_397_1.time_ < var_400_16 + var_400_17 + arg_400_0 then
				local var_400_20 = Color.New(0, 0, 0)

				var_400_20.a = 1
				arg_397_1.mask_.color = var_400_20
			end

			local var_400_21 = 2

			if var_400_21 < arg_397_1.time_ and arg_397_1.time_ <= var_400_21 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_22 = 2

			if var_400_21 <= arg_397_1.time_ and arg_397_1.time_ < var_400_21 + var_400_22 then
				local var_400_23 = (arg_397_1.time_ - var_400_21) / var_400_22
				local var_400_24 = Color.New(0, 0, 0)

				var_400_24.a = Mathf.Lerp(1, 0, var_400_23)
				arg_397_1.mask_.color = var_400_24
			end

			if arg_397_1.time_ >= var_400_21 + var_400_22 and arg_397_1.time_ < var_400_21 + var_400_22 + arg_400_0 then
				local var_400_25 = Color.New(0, 0, 0)
				local var_400_26 = 0

				arg_397_1.mask_.enabled = false
				var_400_25.a = var_400_26
				arg_397_1.mask_.color = var_400_25
			end

			local var_400_27 = 4.3
			local var_400_28 = 1

			if var_400_27 < arg_397_1.time_ and arg_397_1.time_ <= var_400_27 + arg_400_0 then
				local var_400_29 = "play"
				local var_400_30 = "effect"

				arg_397_1:AudioAction(var_400_29, var_400_30, "se_story_144", "se_story_144_gun02", "")
			end

			local var_400_31 = manager.ui.mainCamera.transform
			local var_400_32 = 2

			if var_400_32 < arg_397_1.time_ and arg_397_1.time_ <= var_400_32 + arg_400_0 then
				local var_400_33 = arg_397_1.var_.effectlageqieting2

				if var_400_33 then
					Object.Destroy(var_400_33)

					arg_397_1.var_.effectlageqieting2 = nil
				end
			end

			local var_400_34 = manager.ui.mainCamera.transform
			local var_400_35 = 2

			if var_400_35 < arg_397_1.time_ and arg_397_1.time_ <= var_400_35 + arg_400_0 then
				local var_400_36 = arg_397_1.var_.effectlageqieting

				if var_400_36 then
					Object.Destroy(var_400_36)

					arg_397_1.var_.effectlageqieting = nil
				end
			end

			if arg_397_1.frameCnt_ <= 1 then
				arg_397_1.dialog_:SetActive(false)
			end

			local var_400_37 = 4
			local var_400_38 = 0.525

			if var_400_37 < arg_397_1.time_ and arg_397_1.time_ <= var_400_37 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_39 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_39:setOnUpdate(LuaHelper.FloatAction(function(arg_401_0)
					arg_397_1.dialogCg_.alpha = arg_401_0
				end))
				var_400_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_40 = arg_397_1:FormatText(StoryNameCfg[7].name)

				arg_397_1.leftNameTxt_.text = var_400_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_41 = arg_397_1:GetWordFromCfg(423111099)
				local var_400_42 = arg_397_1:FormatText(var_400_41.content)

				arg_397_1.text_.text = var_400_42

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_43 = 21
				local var_400_44 = utf8.len(var_400_42)
				local var_400_45 = var_400_43 <= 0 and var_400_38 or var_400_38 * (var_400_44 / var_400_43)

				if var_400_45 > 0 and var_400_38 < var_400_45 then
					arg_397_1.talkMaxDuration = var_400_45
					var_400_37 = var_400_37 + 0.3

					if var_400_45 + var_400_37 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_45 + var_400_37
					end
				end

				arg_397_1.text_.text = var_400_42
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_46 = var_400_37 + 0.3
			local var_400_47 = math.max(var_400_38, arg_397_1.talkMaxDuration)

			if var_400_46 <= arg_397_1.time_ and arg_397_1.time_ < var_400_46 + var_400_47 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_46) / var_400_47

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_46 + var_400_47 and arg_397_1.time_ < var_400_46 + var_400_47 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play423111100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 423111100
		arg_403_1.duration_ = 2.03

		local var_403_0 = {
			zh = 2.033,
			ja = 1.433
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play423111101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1.3

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_2 = arg_403_1:GetWordFromCfg(423111100)
				local var_406_3 = arg_403_1:FormatText(var_406_2.content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_4 = 52
				local var_406_5 = utf8.len(var_406_3)
				local var_406_6 = var_406_4 <= 0 and var_406_1 or var_406_1 * (var_406_5 / var_406_4)

				if var_406_6 > 0 and var_406_1 < var_406_6 then
					arg_403_1.talkMaxDuration = var_406_6

					if var_406_6 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_6 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111100", "story_v_out_423111.awb") ~= 0 then
					local var_406_7 = manager.audio:GetVoiceLength("story_v_out_423111", "423111100", "story_v_out_423111.awb") / 1000

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end

					if var_406_2.prefab_name ~= "" and arg_403_1.actors_[var_406_2.prefab_name] ~= nil then
						local var_406_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_2.prefab_name].transform, "story_v_out_423111", "423111100", "story_v_out_423111.awb")

						arg_403_1:RecordAudio("423111100", var_406_8)
						arg_403_1:RecordAudio("423111100", var_406_8)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_423111", "423111100", "story_v_out_423111.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_423111", "423111100", "story_v_out_423111.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_9 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_9 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_9

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_9 and arg_403_1.time_ < var_406_0 + var_406_9 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play423111101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 423111101
		arg_407_1.duration_ = 7.73

		local var_407_0 = {
			zh = 7.7,
			ja = 7.733
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play423111102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1083"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.actorSpriteComps1083 == nil then
				arg_407_1.var_.actorSpriteComps1083 = var_410_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_2 = 0.2

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.actorSpriteComps1083 then
					for iter_410_0, iter_410_1 in pairs(arg_407_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_410_1 then
							if arg_407_1.isInRecall_ then
								local var_410_4 = Mathf.Lerp(iter_410_1.color.r, arg_407_1.hightColor1.r, var_410_3)
								local var_410_5 = Mathf.Lerp(iter_410_1.color.g, arg_407_1.hightColor1.g, var_410_3)
								local var_410_6 = Mathf.Lerp(iter_410_1.color.b, arg_407_1.hightColor1.b, var_410_3)

								iter_410_1.color = Color.New(var_410_4, var_410_5, var_410_6)
							else
								local var_410_7 = Mathf.Lerp(iter_410_1.color.r, 1, var_410_3)

								iter_410_1.color = Color.New(var_410_7, var_410_7, var_410_7)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.actorSpriteComps1083 then
				for iter_410_2, iter_410_3 in pairs(arg_407_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_410_3 then
						if arg_407_1.isInRecall_ then
							iter_410_3.color = arg_407_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_410_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_407_1.var_.actorSpriteComps1083 = nil
			end

			local var_410_8 = arg_407_1.actors_["1083"].transform
			local var_410_9 = 0

			if var_410_9 < arg_407_1.time_ and arg_407_1.time_ <= var_410_9 + arg_410_0 then
				arg_407_1.var_.moveOldPos1083 = var_410_8.localPosition
				var_410_8.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("1083", 3)

				local var_410_10 = var_410_8.childCount

				for iter_410_4 = 0, var_410_10 - 1 do
					local var_410_11 = var_410_8:GetChild(iter_410_4)

					if var_410_11.name == "" or not string.find(var_410_11.name, "split") then
						var_410_11.gameObject:SetActive(true)
					else
						var_410_11.gameObject:SetActive(false)
					end
				end
			end

			local var_410_12 = 0.001

			if var_410_9 <= arg_407_1.time_ and arg_407_1.time_ < var_410_9 + var_410_12 then
				local var_410_13 = (arg_407_1.time_ - var_410_9) / var_410_12
				local var_410_14 = Vector3.New(-50, -345, -345)

				var_410_8.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1083, var_410_14, var_410_13)
			end

			if arg_407_1.time_ >= var_410_9 + var_410_12 and arg_407_1.time_ < var_410_9 + var_410_12 + arg_410_0 then
				var_410_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_410_15 = 0
			local var_410_16 = 0.875

			if var_410_15 < arg_407_1.time_ and arg_407_1.time_ <= var_410_15 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_17 = arg_407_1:FormatText(StoryNameCfg[1332].name)

				arg_407_1.leftNameTxt_.text = var_410_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_18 = arg_407_1:GetWordFromCfg(423111101)
				local var_410_19 = arg_407_1:FormatText(var_410_18.content)

				arg_407_1.text_.text = var_410_19

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_20 = 35
				local var_410_21 = utf8.len(var_410_19)
				local var_410_22 = var_410_20 <= 0 and var_410_16 or var_410_16 * (var_410_21 / var_410_20)

				if var_410_22 > 0 and var_410_16 < var_410_22 then
					arg_407_1.talkMaxDuration = var_410_22

					if var_410_22 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_22 + var_410_15
					end
				end

				arg_407_1.text_.text = var_410_19
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111101", "story_v_out_423111.awb") ~= 0 then
					local var_410_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111101", "story_v_out_423111.awb") / 1000

					if var_410_23 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_23 + var_410_15
					end

					if var_410_18.prefab_name ~= "" and arg_407_1.actors_[var_410_18.prefab_name] ~= nil then
						local var_410_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_18.prefab_name].transform, "story_v_out_423111", "423111101", "story_v_out_423111.awb")

						arg_407_1:RecordAudio("423111101", var_410_24)
						arg_407_1:RecordAudio("423111101", var_410_24)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_423111", "423111101", "story_v_out_423111.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_423111", "423111101", "story_v_out_423111.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_25 = math.max(var_410_16, arg_407_1.talkMaxDuration)

			if var_410_15 <= arg_407_1.time_ and arg_407_1.time_ < var_410_15 + var_410_25 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_15) / var_410_25

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_15 + var_410_25 and arg_407_1.time_ < var_410_15 + var_410_25 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play423111102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 423111102
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play423111103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1083"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.actorSpriteComps1083 == nil then
				arg_411_1.var_.actorSpriteComps1083 = var_414_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_2 = 0.2

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.actorSpriteComps1083 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_414_1 then
							if arg_411_1.isInRecall_ then
								local var_414_4 = Mathf.Lerp(iter_414_1.color.r, arg_411_1.hightColor2.r, var_414_3)
								local var_414_5 = Mathf.Lerp(iter_414_1.color.g, arg_411_1.hightColor2.g, var_414_3)
								local var_414_6 = Mathf.Lerp(iter_414_1.color.b, arg_411_1.hightColor2.b, var_414_3)

								iter_414_1.color = Color.New(var_414_4, var_414_5, var_414_6)
							else
								local var_414_7 = Mathf.Lerp(iter_414_1.color.r, 0.5, var_414_3)

								iter_414_1.color = Color.New(var_414_7, var_414_7, var_414_7)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.actorSpriteComps1083 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_414_3 then
						if arg_411_1.isInRecall_ then
							iter_414_3.color = arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_414_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps1083 = nil
			end

			local var_414_8 = 0
			local var_414_9 = 0.425

			if var_414_8 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_10 = arg_411_1:FormatText(StoryNameCfg[7].name)

				arg_411_1.leftNameTxt_.text = var_414_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_11 = arg_411_1:GetWordFromCfg(423111102)
				local var_414_12 = arg_411_1:FormatText(var_414_11.content)

				arg_411_1.text_.text = var_414_12

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 17
				local var_414_14 = utf8.len(var_414_12)
				local var_414_15 = var_414_13 <= 0 and var_414_9 or var_414_9 * (var_414_14 / var_414_13)

				if var_414_15 > 0 and var_414_9 < var_414_15 then
					arg_411_1.talkMaxDuration = var_414_15

					if var_414_15 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_15 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_12
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_9, arg_411_1.talkMaxDuration)

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_8) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_8 + var_414_16 and arg_411_1.time_ < var_414_8 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play423111103 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 423111103
		arg_415_1.duration_ = 4.17

		local var_415_0 = {
			zh = 4.166,
			ja = 3.933
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play423111104(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1083"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.actorSpriteComps1083 == nil then
				arg_415_1.var_.actorSpriteComps1083 = var_418_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_2 = 0.2

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.actorSpriteComps1083 then
					for iter_418_0, iter_418_1 in pairs(arg_415_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_418_1 then
							if arg_415_1.isInRecall_ then
								local var_418_4 = Mathf.Lerp(iter_418_1.color.r, arg_415_1.hightColor1.r, var_418_3)
								local var_418_5 = Mathf.Lerp(iter_418_1.color.g, arg_415_1.hightColor1.g, var_418_3)
								local var_418_6 = Mathf.Lerp(iter_418_1.color.b, arg_415_1.hightColor1.b, var_418_3)

								iter_418_1.color = Color.New(var_418_4, var_418_5, var_418_6)
							else
								local var_418_7 = Mathf.Lerp(iter_418_1.color.r, 1, var_418_3)

								iter_418_1.color = Color.New(var_418_7, var_418_7, var_418_7)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.actorSpriteComps1083 then
				for iter_418_2, iter_418_3 in pairs(arg_415_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_418_3 then
						if arg_415_1.isInRecall_ then
							iter_418_3.color = arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_418_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps1083 = nil
			end

			local var_418_8 = arg_415_1.actors_["1083"].transform
			local var_418_9 = 0

			if var_418_9 < arg_415_1.time_ and arg_415_1.time_ <= var_418_9 + arg_418_0 then
				arg_415_1.var_.moveOldPos1083 = var_418_8.localPosition
				var_418_8.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("1083", 3)

				local var_418_10 = var_418_8.childCount

				for iter_418_4 = 0, var_418_10 - 1 do
					local var_418_11 = var_418_8:GetChild(iter_418_4)

					if var_418_11.name == "" or not string.find(var_418_11.name, "split") then
						var_418_11.gameObject:SetActive(true)
					else
						var_418_11.gameObject:SetActive(false)
					end
				end
			end

			local var_418_12 = 0.001

			if var_418_9 <= arg_415_1.time_ and arg_415_1.time_ < var_418_9 + var_418_12 then
				local var_418_13 = (arg_415_1.time_ - var_418_9) / var_418_12
				local var_418_14 = Vector3.New(-50, -345, -345)

				var_418_8.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1083, var_418_14, var_418_13)
			end

			if arg_415_1.time_ >= var_418_9 + var_418_12 and arg_415_1.time_ < var_418_9 + var_418_12 + arg_418_0 then
				var_418_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_418_15 = 0
			local var_418_16 = 0.525

			if var_418_15 < arg_415_1.time_ and arg_415_1.time_ <= var_418_15 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_17 = arg_415_1:FormatText(StoryNameCfg[1332].name)

				arg_415_1.leftNameTxt_.text = var_418_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_18 = arg_415_1:GetWordFromCfg(423111103)
				local var_418_19 = arg_415_1:FormatText(var_418_18.content)

				arg_415_1.text_.text = var_418_19

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_20 = 21
				local var_418_21 = utf8.len(var_418_19)
				local var_418_22 = var_418_20 <= 0 and var_418_16 or var_418_16 * (var_418_21 / var_418_20)

				if var_418_22 > 0 and var_418_16 < var_418_22 then
					arg_415_1.talkMaxDuration = var_418_22

					if var_418_22 + var_418_15 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_22 + var_418_15
					end
				end

				arg_415_1.text_.text = var_418_19
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111103", "story_v_out_423111.awb") ~= 0 then
					local var_418_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111103", "story_v_out_423111.awb") / 1000

					if var_418_23 + var_418_15 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_23 + var_418_15
					end

					if var_418_18.prefab_name ~= "" and arg_415_1.actors_[var_418_18.prefab_name] ~= nil then
						local var_418_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_18.prefab_name].transform, "story_v_out_423111", "423111103", "story_v_out_423111.awb")

						arg_415_1:RecordAudio("423111103", var_418_24)
						arg_415_1:RecordAudio("423111103", var_418_24)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_423111", "423111103", "story_v_out_423111.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_423111", "423111103", "story_v_out_423111.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_25 = math.max(var_418_16, arg_415_1.talkMaxDuration)

			if var_418_15 <= arg_415_1.time_ and arg_415_1.time_ < var_418_15 + var_418_25 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_15) / var_418_25

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_15 + var_418_25 and arg_415_1.time_ < var_418_15 + var_418_25 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play423111104 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 423111104
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play423111105(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1083"]
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.actorSpriteComps1083 == nil then
				arg_419_1.var_.actorSpriteComps1083 = var_422_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_422_2 = 0.2

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 and not isNil(var_422_0) then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2

				if arg_419_1.var_.actorSpriteComps1083 then
					for iter_422_0, iter_422_1 in pairs(arg_419_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_422_1 then
							if arg_419_1.isInRecall_ then
								local var_422_4 = Mathf.Lerp(iter_422_1.color.r, arg_419_1.hightColor2.r, var_422_3)
								local var_422_5 = Mathf.Lerp(iter_422_1.color.g, arg_419_1.hightColor2.g, var_422_3)
								local var_422_6 = Mathf.Lerp(iter_422_1.color.b, arg_419_1.hightColor2.b, var_422_3)

								iter_422_1.color = Color.New(var_422_4, var_422_5, var_422_6)
							else
								local var_422_7 = Mathf.Lerp(iter_422_1.color.r, 0.5, var_422_3)

								iter_422_1.color = Color.New(var_422_7, var_422_7, var_422_7)
							end
						end
					end
				end
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.actorSpriteComps1083 then
				for iter_422_2, iter_422_3 in pairs(arg_419_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_422_3 then
						if arg_419_1.isInRecall_ then
							iter_422_3.color = arg_419_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_422_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_419_1.var_.actorSpriteComps1083 = nil
			end

			local var_422_8 = 0
			local var_422_9 = 0.725

			if var_422_8 < arg_419_1.time_ and arg_419_1.time_ <= var_422_8 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_10 = arg_419_1:FormatText(StoryNameCfg[7].name)

				arg_419_1.leftNameTxt_.text = var_422_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_11 = arg_419_1:GetWordFromCfg(423111104)
				local var_422_12 = arg_419_1:FormatText(var_422_11.content)

				arg_419_1.text_.text = var_422_12

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_13 = 29
				local var_422_14 = utf8.len(var_422_12)
				local var_422_15 = var_422_13 <= 0 and var_422_9 or var_422_9 * (var_422_14 / var_422_13)

				if var_422_15 > 0 and var_422_9 < var_422_15 then
					arg_419_1.talkMaxDuration = var_422_15

					if var_422_15 + var_422_8 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_15 + var_422_8
					end
				end

				arg_419_1.text_.text = var_422_12
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_16 = math.max(var_422_9, arg_419_1.talkMaxDuration)

			if var_422_8 <= arg_419_1.time_ and arg_419_1.time_ < var_422_8 + var_422_16 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_8) / var_422_16

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_8 + var_422_16 and arg_419_1.time_ < var_422_8 + var_422_16 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play423111105 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 423111105
		arg_423_1.duration_ = 7.07

		local var_423_0 = {
			zh = 5.166,
			ja = 7.066
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play423111106(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1083"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.actorSpriteComps1083 == nil then
				arg_423_1.var_.actorSpriteComps1083 = var_426_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_2 = 0.2

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.actorSpriteComps1083 then
					for iter_426_0, iter_426_1 in pairs(arg_423_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_426_1 then
							if arg_423_1.isInRecall_ then
								local var_426_4 = Mathf.Lerp(iter_426_1.color.r, arg_423_1.hightColor1.r, var_426_3)
								local var_426_5 = Mathf.Lerp(iter_426_1.color.g, arg_423_1.hightColor1.g, var_426_3)
								local var_426_6 = Mathf.Lerp(iter_426_1.color.b, arg_423_1.hightColor1.b, var_426_3)

								iter_426_1.color = Color.New(var_426_4, var_426_5, var_426_6)
							else
								local var_426_7 = Mathf.Lerp(iter_426_1.color.r, 1, var_426_3)

								iter_426_1.color = Color.New(var_426_7, var_426_7, var_426_7)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.actorSpriteComps1083 then
				for iter_426_2, iter_426_3 in pairs(arg_423_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_426_3 then
						if arg_423_1.isInRecall_ then
							iter_426_3.color = arg_423_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_426_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_423_1.var_.actorSpriteComps1083 = nil
			end

			local var_426_8 = arg_423_1.actors_["1083"].transform
			local var_426_9 = 0

			if var_426_9 < arg_423_1.time_ and arg_423_1.time_ <= var_426_9 + arg_426_0 then
				arg_423_1.var_.moveOldPos1083 = var_426_8.localPosition
				var_426_8.localScale = Vector3.New(1, 1, 1)

				arg_423_1:CheckSpriteTmpPos("1083", 3)

				local var_426_10 = var_426_8.childCount

				for iter_426_4 = 0, var_426_10 - 1 do
					local var_426_11 = var_426_8:GetChild(iter_426_4)

					if var_426_11.name == "" or not string.find(var_426_11.name, "split") then
						var_426_11.gameObject:SetActive(true)
					else
						var_426_11.gameObject:SetActive(false)
					end
				end
			end

			local var_426_12 = 0.001

			if var_426_9 <= arg_423_1.time_ and arg_423_1.time_ < var_426_9 + var_426_12 then
				local var_426_13 = (arg_423_1.time_ - var_426_9) / var_426_12
				local var_426_14 = Vector3.New(-50, -345, -345)

				var_426_8.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1083, var_426_14, var_426_13)
			end

			if arg_423_1.time_ >= var_426_9 + var_426_12 and arg_423_1.time_ < var_426_9 + var_426_12 + arg_426_0 then
				var_426_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_426_15 = 0
			local var_426_16 = 0.625

			if var_426_15 < arg_423_1.time_ and arg_423_1.time_ <= var_426_15 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_17 = arg_423_1:FormatText(StoryNameCfg[1332].name)

				arg_423_1.leftNameTxt_.text = var_426_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_18 = arg_423_1:GetWordFromCfg(423111105)
				local var_426_19 = arg_423_1:FormatText(var_426_18.content)

				arg_423_1.text_.text = var_426_19

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_20 = 25
				local var_426_21 = utf8.len(var_426_19)
				local var_426_22 = var_426_20 <= 0 and var_426_16 or var_426_16 * (var_426_21 / var_426_20)

				if var_426_22 > 0 and var_426_16 < var_426_22 then
					arg_423_1.talkMaxDuration = var_426_22

					if var_426_22 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_22 + var_426_15
					end
				end

				arg_423_1.text_.text = var_426_19
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111105", "story_v_out_423111.awb") ~= 0 then
					local var_426_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111105", "story_v_out_423111.awb") / 1000

					if var_426_23 + var_426_15 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_23 + var_426_15
					end

					if var_426_18.prefab_name ~= "" and arg_423_1.actors_[var_426_18.prefab_name] ~= nil then
						local var_426_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_18.prefab_name].transform, "story_v_out_423111", "423111105", "story_v_out_423111.awb")

						arg_423_1:RecordAudio("423111105", var_426_24)
						arg_423_1:RecordAudio("423111105", var_426_24)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_423111", "423111105", "story_v_out_423111.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_423111", "423111105", "story_v_out_423111.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_25 = math.max(var_426_16, arg_423_1.talkMaxDuration)

			if var_426_15 <= arg_423_1.time_ and arg_423_1.time_ < var_426_15 + var_426_25 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_15) / var_426_25

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_15 + var_426_25 and arg_423_1.time_ < var_426_15 + var_426_25 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play423111106 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 423111106
		arg_427_1.duration_ = 5.7

		local var_427_0 = {
			zh = 4.6,
			ja = 5.7
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play423111107(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1083"].transform
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 then
				arg_427_1.var_.moveOldPos1083 = var_430_0.localPosition
				var_430_0.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("1083", 3)

				local var_430_2 = var_430_0.childCount

				for iter_430_0 = 0, var_430_2 - 1 do
					local var_430_3 = var_430_0:GetChild(iter_430_0)

					if var_430_3.name == "" or not string.find(var_430_3.name, "split") then
						var_430_3.gameObject:SetActive(true)
					else
						var_430_3.gameObject:SetActive(false)
					end
				end
			end

			local var_430_4 = 0.001

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_4 then
				local var_430_5 = (arg_427_1.time_ - var_430_1) / var_430_4
				local var_430_6 = Vector3.New(-50, -345, -345)

				var_430_0.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1083, var_430_6, var_430_5)
			end

			if arg_427_1.time_ >= var_430_1 + var_430_4 and arg_427_1.time_ < var_430_1 + var_430_4 + arg_430_0 then
				var_430_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_430_7 = 0
			local var_430_8 = 0.65

			if var_430_7 < arg_427_1.time_ and arg_427_1.time_ <= var_430_7 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_9 = arg_427_1:FormatText(StoryNameCfg[1332].name)

				arg_427_1.leftNameTxt_.text = var_430_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_10 = arg_427_1:GetWordFromCfg(423111106)
				local var_430_11 = arg_427_1:FormatText(var_430_10.content)

				arg_427_1.text_.text = var_430_11

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_12 = 26
				local var_430_13 = utf8.len(var_430_11)
				local var_430_14 = var_430_12 <= 0 and var_430_8 or var_430_8 * (var_430_13 / var_430_12)

				if var_430_14 > 0 and var_430_8 < var_430_14 then
					arg_427_1.talkMaxDuration = var_430_14

					if var_430_14 + var_430_7 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_14 + var_430_7
					end
				end

				arg_427_1.text_.text = var_430_11
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111106", "story_v_out_423111.awb") ~= 0 then
					local var_430_15 = manager.audio:GetVoiceLength("story_v_out_423111", "423111106", "story_v_out_423111.awb") / 1000

					if var_430_15 + var_430_7 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_15 + var_430_7
					end

					if var_430_10.prefab_name ~= "" and arg_427_1.actors_[var_430_10.prefab_name] ~= nil then
						local var_430_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_10.prefab_name].transform, "story_v_out_423111", "423111106", "story_v_out_423111.awb")

						arg_427_1:RecordAudio("423111106", var_430_16)
						arg_427_1:RecordAudio("423111106", var_430_16)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_423111", "423111106", "story_v_out_423111.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_423111", "423111106", "story_v_out_423111.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_17 = math.max(var_430_8, arg_427_1.talkMaxDuration)

			if var_430_7 <= arg_427_1.time_ and arg_427_1.time_ < var_430_7 + var_430_17 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_7) / var_430_17

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_7 + var_430_17 and arg_427_1.time_ < var_430_7 + var_430_17 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play423111107 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 423111107
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play423111108(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1083"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.actorSpriteComps1083 == nil then
				arg_431_1.var_.actorSpriteComps1083 = var_434_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_2 = 0.2

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 and not isNil(var_434_0) then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.actorSpriteComps1083 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_434_1 then
							if arg_431_1.isInRecall_ then
								local var_434_4 = Mathf.Lerp(iter_434_1.color.r, arg_431_1.hightColor2.r, var_434_3)
								local var_434_5 = Mathf.Lerp(iter_434_1.color.g, arg_431_1.hightColor2.g, var_434_3)
								local var_434_6 = Mathf.Lerp(iter_434_1.color.b, arg_431_1.hightColor2.b, var_434_3)

								iter_434_1.color = Color.New(var_434_4, var_434_5, var_434_6)
							else
								local var_434_7 = Mathf.Lerp(iter_434_1.color.r, 0.5, var_434_3)

								iter_434_1.color = Color.New(var_434_7, var_434_7, var_434_7)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and not isNil(var_434_0) and arg_431_1.var_.actorSpriteComps1083 then
				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_434_3 then
						if arg_431_1.isInRecall_ then
							iter_434_3.color = arg_431_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_434_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_431_1.var_.actorSpriteComps1083 = nil
			end

			local var_434_8 = 0
			local var_434_9 = 0.6

			if var_434_8 < arg_431_1.time_ and arg_431_1.time_ <= var_434_8 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_10 = arg_431_1:FormatText(StoryNameCfg[7].name)

				arg_431_1.leftNameTxt_.text = var_434_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_11 = arg_431_1:GetWordFromCfg(423111107)
				local var_434_12 = arg_431_1:FormatText(var_434_11.content)

				arg_431_1.text_.text = var_434_12

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_13 = 24
				local var_434_14 = utf8.len(var_434_12)
				local var_434_15 = var_434_13 <= 0 and var_434_9 or var_434_9 * (var_434_14 / var_434_13)

				if var_434_15 > 0 and var_434_9 < var_434_15 then
					arg_431_1.talkMaxDuration = var_434_15

					if var_434_15 + var_434_8 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_15 + var_434_8
					end
				end

				arg_431_1.text_.text = var_434_12
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_16 = math.max(var_434_9, arg_431_1.talkMaxDuration)

			if var_434_8 <= arg_431_1.time_ and arg_431_1.time_ < var_434_8 + var_434_16 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_8) / var_434_16

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_8 + var_434_16 and arg_431_1.time_ < var_434_8 + var_434_16 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play423111108 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 423111108
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play423111109(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1083"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos1083 = var_438_0.localPosition
				var_438_0.localScale = Vector3.New(1, 1, 1)

				arg_435_1:CheckSpriteTmpPos("1083", 7)

				local var_438_2 = var_438_0.childCount

				for iter_438_0 = 0, var_438_2 - 1 do
					local var_438_3 = var_438_0:GetChild(iter_438_0)

					if var_438_3.name == "" or not string.find(var_438_3.name, "split") then
						var_438_3.gameObject:SetActive(true)
					else
						var_438_3.gameObject:SetActive(false)
					end
				end
			end

			local var_438_4 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_4 then
				local var_438_5 = (arg_435_1.time_ - var_438_1) / var_438_4
				local var_438_6 = Vector3.New(0, -2000, 0)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1083, var_438_6, var_438_5)
			end

			if arg_435_1.time_ >= var_438_1 + var_438_4 and arg_435_1.time_ < var_438_1 + var_438_4 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_438_7 = 0.375
			local var_438_8 = 1

			if var_438_7 < arg_435_1.time_ and arg_435_1.time_ <= var_438_7 + arg_438_0 then
				local var_438_9 = "play"
				local var_438_10 = "effect"

				arg_435_1:AudioAction(var_438_9, var_438_10, "se_story_144", "se_story_144_door_open", "")
			end

			local var_438_11 = 0
			local var_438_12 = 1.375

			if var_438_11 < arg_435_1.time_ and arg_435_1.time_ <= var_438_11 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_13 = arg_435_1:GetWordFromCfg(423111108)
				local var_438_14 = arg_435_1:FormatText(var_438_13.content)

				arg_435_1.text_.text = var_438_14

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_15 = 55
				local var_438_16 = utf8.len(var_438_14)
				local var_438_17 = var_438_15 <= 0 and var_438_12 or var_438_12 * (var_438_16 / var_438_15)

				if var_438_17 > 0 and var_438_12 < var_438_17 then
					arg_435_1.talkMaxDuration = var_438_17

					if var_438_17 + var_438_11 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_17 + var_438_11
					end
				end

				arg_435_1.text_.text = var_438_14
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_18 = math.max(var_438_12, arg_435_1.talkMaxDuration)

			if var_438_11 <= arg_435_1.time_ and arg_435_1.time_ < var_438_11 + var_438_18 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_11) / var_438_18

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_11 + var_438_18 and arg_435_1.time_ < var_438_11 + var_438_18 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play423111109 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 423111109
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play423111110(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 1.725

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_2 = arg_439_1:GetWordFromCfg(423111109)
				local var_442_3 = arg_439_1:FormatText(var_442_2.content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 69
				local var_442_5 = utf8.len(var_442_3)
				local var_442_6 = var_442_4 <= 0 and var_442_1 or var_442_1 * (var_442_5 / var_442_4)

				if var_442_6 > 0 and var_442_1 < var_442_6 then
					arg_439_1.talkMaxDuration = var_442_6

					if var_442_6 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_6 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_7 and arg_439_1.time_ < var_442_0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play423111110 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 423111110
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
			arg_443_1.auto_ = false
		end

		function arg_443_1.playNext_(arg_445_0)
			arg_443_1.onStoryFinished_()
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 0.4

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[7].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_3 = arg_443_1:GetWordFromCfg(423111110)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 16
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_8 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_8 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_8

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_8 and arg_443_1.time_ < var_446_0 + var_446_8 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play423111047 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 423111047
		arg_447_1.duration_ = 3.2

		local var_447_0 = {
			zh = 3.2,
			ja = 2.4
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
				arg_447_0:Play423111048(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1083"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos1083 = var_450_0.localPosition
				var_450_0.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("1083", 3)

				local var_450_2 = var_450_0.childCount

				for iter_450_0 = 0, var_450_2 - 1 do
					local var_450_3 = var_450_0:GetChild(iter_450_0)

					if var_450_3.name == "" or not string.find(var_450_3.name, "split") then
						var_450_3.gameObject:SetActive(true)
					else
						var_450_3.gameObject:SetActive(false)
					end
				end
			end

			local var_450_4 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_4 then
				local var_450_5 = (arg_447_1.time_ - var_450_1) / var_450_4
				local var_450_6 = Vector3.New(-50, -345, -345)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1083, var_450_6, var_450_5)
			end

			if arg_447_1.time_ >= var_450_1 + var_450_4 and arg_447_1.time_ < var_450_1 + var_450_4 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_450_7 = arg_447_1.actors_["1083"]
			local var_450_8 = 0

			if var_450_8 < arg_447_1.time_ and arg_447_1.time_ <= var_450_8 + arg_450_0 and not isNil(var_450_7) and arg_447_1.var_.actorSpriteComps1083 == nil then
				arg_447_1.var_.actorSpriteComps1083 = var_450_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_9 = 0.2

			if var_450_8 <= arg_447_1.time_ and arg_447_1.time_ < var_450_8 + var_450_9 and not isNil(var_450_7) then
				local var_450_10 = (arg_447_1.time_ - var_450_8) / var_450_9

				if arg_447_1.var_.actorSpriteComps1083 then
					for iter_450_1, iter_450_2 in pairs(arg_447_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_450_2 then
							if arg_447_1.isInRecall_ then
								local var_450_11 = Mathf.Lerp(iter_450_2.color.r, arg_447_1.hightColor1.r, var_450_10)
								local var_450_12 = Mathf.Lerp(iter_450_2.color.g, arg_447_1.hightColor1.g, var_450_10)
								local var_450_13 = Mathf.Lerp(iter_450_2.color.b, arg_447_1.hightColor1.b, var_450_10)

								iter_450_2.color = Color.New(var_450_11, var_450_12, var_450_13)
							else
								local var_450_14 = Mathf.Lerp(iter_450_2.color.r, 1, var_450_10)

								iter_450_2.color = Color.New(var_450_14, var_450_14, var_450_14)
							end
						end
					end
				end
			end

			if arg_447_1.time_ >= var_450_8 + var_450_9 and arg_447_1.time_ < var_450_8 + var_450_9 + arg_450_0 and not isNil(var_450_7) and arg_447_1.var_.actorSpriteComps1083 then
				for iter_450_3, iter_450_4 in pairs(arg_447_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_450_4 then
						if arg_447_1.isInRecall_ then
							iter_450_4.color = arg_447_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_450_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_447_1.var_.actorSpriteComps1083 = nil
			end

			local var_450_15 = 0
			local var_450_16 = 0.3

			if var_450_15 < arg_447_1.time_ and arg_447_1.time_ <= var_450_15 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_17 = arg_447_1:FormatText(StoryNameCfg[1332].name)

				arg_447_1.leftNameTxt_.text = var_450_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_18 = arg_447_1:GetWordFromCfg(423111047)
				local var_450_19 = arg_447_1:FormatText(var_450_18.content)

				arg_447_1.text_.text = var_450_19

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_20 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111047", "story_v_out_423111.awb") ~= 0 then
					local var_450_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111047", "story_v_out_423111.awb") / 1000

					if var_450_23 + var_450_15 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_23 + var_450_15
					end

					if var_450_18.prefab_name ~= "" and arg_447_1.actors_[var_450_18.prefab_name] ~= nil then
						local var_450_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_18.prefab_name].transform, "story_v_out_423111", "423111047", "story_v_out_423111.awb")

						arg_447_1:RecordAudio("423111047", var_450_24)
						arg_447_1:RecordAudio("423111047", var_450_24)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_423111", "423111047", "story_v_out_423111.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_423111", "423111047", "story_v_out_423111.awb")
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
				actorName = "1083",
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
	Play423111048 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 423111048
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play423111049(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1083"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.actorSpriteComps1083 == nil then
				arg_451_1.var_.actorSpriteComps1083 = var_454_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_454_2 = 0.2

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 and not isNil(var_454_0) then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.actorSpriteComps1083 then
					for iter_454_0, iter_454_1 in pairs(arg_451_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and not isNil(var_454_0) and arg_451_1.var_.actorSpriteComps1083 then
				for iter_454_2, iter_454_3 in pairs(arg_451_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_454_3 then
						if arg_451_1.isInRecall_ then
							iter_454_3.color = arg_451_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_454_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_451_1.var_.actorSpriteComps1083 = nil
			end

			local var_454_8 = 0
			local var_454_9 = 0.5

			if var_454_8 < arg_451_1.time_ and arg_451_1.time_ <= var_454_8 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_10 = arg_451_1:FormatText(StoryNameCfg[7].name)

				arg_451_1.leftNameTxt_.text = var_454_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_11 = arg_451_1:GetWordFromCfg(423111048)
				local var_454_12 = arg_451_1:FormatText(var_454_11.content)

				arg_451_1.text_.text = var_454_12

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_13 = 20
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
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_16 = math.max(var_454_9, arg_451_1.talkMaxDuration)

			if var_454_8 <= arg_451_1.time_ and arg_451_1.time_ < var_454_8 + var_454_16 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_8) / var_454_16

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_8 + var_454_16 and arg_451_1.time_ < var_454_8 + var_454_16 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play423111049 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 423111049
		arg_455_1.duration_ = 6.83

		local var_455_0 = {
			zh = 5.6,
			ja = 6.833
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
				arg_455_0:Play423111050(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1083"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.actorSpriteComps1083 == nil then
				arg_455_1.var_.actorSpriteComps1083 = var_458_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_2 = 0.2

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 and not isNil(var_458_0) then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.actorSpriteComps1083 then
					for iter_458_0, iter_458_1 in pairs(arg_455_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and not isNil(var_458_0) and arg_455_1.var_.actorSpriteComps1083 then
				for iter_458_2, iter_458_3 in pairs(arg_455_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_458_3 then
						if arg_455_1.isInRecall_ then
							iter_458_3.color = arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_458_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_455_1.var_.actorSpriteComps1083 = nil
			end

			local var_458_8 = arg_455_1.actors_["1083"].transform
			local var_458_9 = 0

			if var_458_9 < arg_455_1.time_ and arg_455_1.time_ <= var_458_9 + arg_458_0 then
				arg_455_1.var_.moveOldPos1083 = var_458_8.localPosition
				var_458_8.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("1083", 3)

				local var_458_10 = var_458_8.childCount

				for iter_458_4 = 0, var_458_10 - 1 do
					local var_458_11 = var_458_8:GetChild(iter_458_4)

					if var_458_11.name == "split_7" or not string.find(var_458_11.name, "split") then
						var_458_11.gameObject:SetActive(true)
					else
						var_458_11.gameObject:SetActive(false)
					end
				end
			end

			local var_458_12 = 0.001

			if var_458_9 <= arg_455_1.time_ and arg_455_1.time_ < var_458_9 + var_458_12 then
				local var_458_13 = (arg_455_1.time_ - var_458_9) / var_458_12
				local var_458_14 = Vector3.New(-50, -345, -345)

				var_458_8.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos1083, var_458_14, var_458_13)
			end

			if arg_455_1.time_ >= var_458_9 + var_458_12 and arg_455_1.time_ < var_458_9 + var_458_12 + arg_458_0 then
				var_458_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_458_15 = 0
			local var_458_16 = 0.475

			if var_458_15 < arg_455_1.time_ and arg_455_1.time_ <= var_458_15 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_17 = arg_455_1:FormatText(StoryNameCfg[1332].name)

				arg_455_1.leftNameTxt_.text = var_458_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_18 = arg_455_1:GetWordFromCfg(423111049)
				local var_458_19 = arg_455_1:FormatText(var_458_18.content)

				arg_455_1.text_.text = var_458_19

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_20 = 19
				local var_458_21 = utf8.len(var_458_19)
				local var_458_22 = var_458_20 <= 0 and var_458_16 or var_458_16 * (var_458_21 / var_458_20)

				if var_458_22 > 0 and var_458_16 < var_458_22 then
					arg_455_1.talkMaxDuration = var_458_22

					if var_458_22 + var_458_15 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_22 + var_458_15
					end
				end

				arg_455_1.text_.text = var_458_19
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423111", "423111049", "story_v_out_423111.awb") ~= 0 then
					local var_458_23 = manager.audio:GetVoiceLength("story_v_out_423111", "423111049", "story_v_out_423111.awb") / 1000

					if var_458_23 + var_458_15 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_23 + var_458_15
					end

					if var_458_18.prefab_name ~= "" and arg_455_1.actors_[var_458_18.prefab_name] ~= nil then
						local var_458_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_18.prefab_name].transform, "story_v_out_423111", "423111049", "story_v_out_423111.awb")

						arg_455_1:RecordAudio("423111049", var_458_24)
						arg_455_1:RecordAudio("423111049", var_458_24)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_423111", "423111049", "story_v_out_423111.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_423111", "423111049", "story_v_out_423111.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_25 = math.max(var_458_16, arg_455_1.talkMaxDuration)

			if var_458_15 <= arg_455_1.time_ and arg_455_1.time_ < var_458_15 + var_458_25 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_15) / var_458_25

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_15 + var_458_25 and arg_455_1.time_ < var_458_15 + var_458_25 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0112a"
	},
	voices = {
		"story_v_out_423111.awb"
	}
}
