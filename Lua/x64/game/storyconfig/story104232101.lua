return {
	Play423211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423211001
		arg_1_1.duration_ = 3.43

		local var_1_0 = {
			zh = 3.333,
			ja = 3.433
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
				arg_1_0:Play423211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I25f"

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
				local var_4_5 = arg_1_1.bgs_.I25f

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
					if iter_4_0 ~= "I25f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = "10148"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

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

			local var_4_28 = arg_1_1.actors_["10148"]
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10148 == nil then
				arg_1_1.var_.actorSpriteComps10148 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.034

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps10148 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps10148 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10148 = nil
			end

			local var_4_36 = arg_1_1.actors_["10148"].transform
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos10148 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10148", 3)

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
				local var_4_42 = Vector3.New(0, -350, -270)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10148, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, -350, -270)
			end

			local var_4_43 = arg_1_1.actors_["10148"]
			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10148 = var_4_45.alpha
					arg_1_1.var_.characterEffect10148 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10148 = 0
			end

			local var_4_46 = 0.5

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10148, 1, var_4_47)

				if arg_1_1.var_.characterEffect10148 then
					arg_1_1.var_.characterEffect10148.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10148 then
				arg_1_1.var_.characterEffect10148.alpha = 1
			end

			local var_4_49 = 0.266666666666667
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "effect"

				arg_1_1:AudioAction(var_4_51, var_4_52, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_4_53 = 0
			local var_4_54 = 0.3

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 0.500666666666667
			local var_4_60 = 1

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				local var_4_61 = "play"
				local var_4_62 = "music"

				arg_1_1:AudioAction(var_4_61, var_4_62, "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_4_63 = ""
				local var_4_64 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_65 = 2
			local var_4_66 = 0.15

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

				local var_4_68 = arg_1_1:FormatText(StoryNameCfg[1331].name)

				arg_1_1.leftNameTxt_.text = var_4_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_69 = arg_1_1:GetWordFromCfg(423211001)
				local var_4_70 = arg_1_1:FormatText(var_4_69.content)

				arg_1_1.text_.text = var_4_70

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_71 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211001", "story_v_out_423211.awb") ~= 0 then
					local var_4_74 = manager.audio:GetVoiceLength("story_v_out_423211", "423211001", "story_v_out_423211.awb") / 1000

					if var_4_74 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_65
					end

					if var_4_69.prefab_name ~= "" and arg_1_1.actors_[var_4_69.prefab_name] ~= nil then
						local var_4_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_69.prefab_name].transform, "story_v_out_423211", "423211001", "story_v_out_423211.awb")

						arg_1_1:RecordAudio("423211001", var_4_75)
						arg_1_1:RecordAudio("423211001", var_4_75)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423211", "423211001", "story_v_out_423211.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423211", "423211001", "story_v_out_423211.awb")
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
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play423211002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423211002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423211003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10148"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10148 == nil then
				arg_9_1.var_.actorSpriteComps10148 = var_12_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_2 = 0.2

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.actorSpriteComps10148 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								local var_12_4 = Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, var_12_3)
								local var_12_5 = Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, var_12_3)
								local var_12_6 = Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, var_12_3)

								iter_12_1.color = Color.New(var_12_4, var_12_5, var_12_6)
							else
								local var_12_7 = Mathf.Lerp(iter_12_1.color.r, 0.5, var_12_3)

								iter_12_1.color = Color.New(var_12_7, var_12_7, var_12_7)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.actorSpriteComps10148 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10148 = nil
			end

			local var_12_8 = arg_9_1.actors_["10148"].transform
			local var_12_9 = 0.5

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.var_.moveOldPos10148 = var_12_8.localPosition
				var_12_8.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10148", 7)

				local var_12_10 = var_12_8.childCount

				for iter_12_4 = 0, var_12_10 - 1 do
					local var_12_11 = var_12_8:GetChild(iter_12_4)

					if var_12_11.name == "" or not string.find(var_12_11.name, "split") then
						var_12_11.gameObject:SetActive(true)
					else
						var_12_11.gameObject:SetActive(false)
					end
				end
			end

			local var_12_12 = 0.001

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_12 then
				local var_12_13 = (arg_9_1.time_ - var_12_9) / var_12_12
				local var_12_14 = Vector3.New(0, -2000, 0)

				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10148, var_12_14, var_12_13)
			end

			if arg_9_1.time_ >= var_12_9 + var_12_12 and arg_9_1.time_ < var_12_9 + var_12_12 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_15 = arg_9_1.actors_["10148"]
			local var_12_16 = 0

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				local var_12_17 = var_12_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_17 then
					arg_9_1.var_.alphaOldValue10148 = var_12_17.alpha
					arg_9_1.var_.characterEffect10148 = var_12_17
				end

				arg_9_1.var_.alphaOldValue10148 = 1
			end

			local var_12_18 = 0.5

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_18 then
				local var_12_19 = (arg_9_1.time_ - var_12_16) / var_12_18
				local var_12_20 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10148, 0, var_12_19)

				if arg_9_1.var_.characterEffect10148 then
					arg_9_1.var_.characterEffect10148.alpha = var_12_20
				end
			end

			if arg_9_1.time_ >= var_12_16 + var_12_18 and arg_9_1.time_ < var_12_16 + var_12_18 + arg_12_0 and arg_9_1.var_.characterEffect10148 then
				arg_9_1.var_.characterEffect10148.alpha = 0
			end

			local var_12_21 = arg_9_1.actors_["10148"]
			local var_12_22 = 0.534

			if var_12_22 < arg_9_1.time_ and arg_9_1.time_ <= var_12_22 + arg_12_0 then
				local var_12_23 = var_12_21:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_23 then
					arg_9_1.var_.alphaOldValue10148 = var_12_23.alpha
					arg_9_1.var_.characterEffect10148 = var_12_23
				end

				arg_9_1.var_.alphaOldValue10148 = 0
			end

			local var_12_24 = 0.1

			if var_12_22 <= arg_9_1.time_ and arg_9_1.time_ < var_12_22 + var_12_24 then
				local var_12_25 = (arg_9_1.time_ - var_12_22) / var_12_24
				local var_12_26 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10148, 1, var_12_25)

				if arg_9_1.var_.characterEffect10148 then
					arg_9_1.var_.characterEffect10148.alpha = var_12_26
				end
			end

			if arg_9_1.time_ >= var_12_22 + var_12_24 and arg_9_1.time_ < var_12_22 + var_12_24 + arg_12_0 and arg_9_1.var_.characterEffect10148 then
				arg_9_1.var_.characterEffect10148.alpha = 1
			end

			local var_12_27 = 0
			local var_12_28 = 1.45

			if var_12_27 < arg_9_1.time_ and arg_9_1.time_ <= var_12_27 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_29 = arg_9_1:GetWordFromCfg(423211002)
				local var_12_30 = arg_9_1:FormatText(var_12_29.content)

				arg_9_1.text_.text = var_12_30

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_31 = 58
				local var_12_32 = utf8.len(var_12_30)
				local var_12_33 = var_12_31 <= 0 and var_12_28 or var_12_28 * (var_12_32 / var_12_31)

				if var_12_33 > 0 and var_12_28 < var_12_33 then
					arg_9_1.talkMaxDuration = var_12_33

					if var_12_33 + var_12_27 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_27
					end
				end

				arg_9_1.text_.text = var_12_30
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_34 = math.max(var_12_28, arg_9_1.talkMaxDuration)

			if var_12_27 <= arg_9_1.time_ and arg_9_1.time_ < var_12_27 + var_12_34 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_27) / var_12_34

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_27 + var_12_34 and arg_9_1.time_ < var_12_27 + var_12_34 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play423211003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423211003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play423211004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.725

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(423211003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 29
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
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play423211004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423211004
		arg_17_1.duration_ = 6.3

		local var_17_0 = {
			zh = 5.633,
			ja = 6.3
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
				arg_17_0:Play423211005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1083"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

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

			local var_20_4 = arg_17_1.actors_["1083"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps1083 == nil then
				arg_17_1.var_.actorSpriteComps1083 = var_20_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 0.2

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.actorSpriteComps1083 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.actorSpriteComps1083 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_20_5 then
						if arg_17_1.isInRecall_ then
							iter_20_5.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1083 = nil
			end

			local var_20_12 = arg_17_1.actors_["1083"].transform
			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1.var_.moveOldPos1083 = var_20_12.localPosition
				var_20_12.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1083", 2)

				local var_20_14 = var_20_12.childCount

				for iter_20_6 = 0, var_20_14 - 1 do
					local var_20_15 = var_20_12:GetChild(iter_20_6)

					if var_20_15.name == "split_7" or not string.find(var_20_15.name, "split") then
						var_20_15.gameObject:SetActive(true)
					else
						var_20_15.gameObject:SetActive(false)
					end
				end
			end

			local var_20_16 = 0.001

			if var_20_13 <= arg_17_1.time_ and arg_17_1.time_ < var_20_13 + var_20_16 then
				local var_20_17 = (arg_17_1.time_ - var_20_13) / var_20_16
				local var_20_18 = Vector3.New(-440, -345, -345)

				var_20_12.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1083, var_20_18, var_20_17)
			end

			if arg_17_1.time_ >= var_20_13 + var_20_16 and arg_17_1.time_ < var_20_13 + var_20_16 + arg_20_0 then
				var_20_12.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_20_19 = 0
			local var_20_20 = 0.575

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_21 = arg_17_1:FormatText(StoryNameCfg[1332].name)

				arg_17_1.leftNameTxt_.text = var_20_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_22 = arg_17_1:GetWordFromCfg(423211004)
				local var_20_23 = arg_17_1:FormatText(var_20_22.content)

				arg_17_1.text_.text = var_20_23

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_24 = 23
				local var_20_25 = utf8.len(var_20_23)
				local var_20_26 = var_20_24 <= 0 and var_20_20 or var_20_20 * (var_20_25 / var_20_24)

				if var_20_26 > 0 and var_20_20 < var_20_26 then
					arg_17_1.talkMaxDuration = var_20_26

					if var_20_26 + var_20_19 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_26 + var_20_19
					end
				end

				arg_17_1.text_.text = var_20_23
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211004", "story_v_out_423211.awb") ~= 0 then
					local var_20_27 = manager.audio:GetVoiceLength("story_v_out_423211", "423211004", "story_v_out_423211.awb") / 1000

					if var_20_27 + var_20_19 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_19
					end

					if var_20_22.prefab_name ~= "" and arg_17_1.actors_[var_20_22.prefab_name] ~= nil then
						local var_20_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_22.prefab_name].transform, "story_v_out_423211", "423211004", "story_v_out_423211.awb")

						arg_17_1:RecordAudio("423211004", var_20_28)
						arg_17_1:RecordAudio("423211004", var_20_28)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_423211", "423211004", "story_v_out_423211.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_423211", "423211004", "story_v_out_423211.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_29 = math.max(var_20_20, arg_17_1.talkMaxDuration)

			if var_20_19 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_29 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_19) / var_20_29

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_19 + var_20_29 and arg_17_1.time_ < var_20_19 + var_20_29 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play423211005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423211005
		arg_21_1.duration_ = 4.53

		local var_21_0 = {
			zh = 3.966,
			ja = 4.533
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
				arg_21_0:Play423211006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10148"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10148 == nil then
				arg_21_1.var_.actorSpriteComps10148 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10148 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10148 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10148 = nil
			end

			local var_24_8 = arg_21_1.actors_["1083"]
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1083 == nil then
				arg_21_1.var_.actorSpriteComps1083 = var_24_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_10 = 0.2

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_10 and not isNil(var_24_8) then
				local var_24_11 = (arg_21_1.time_ - var_24_9) / var_24_10

				if arg_21_1.var_.actorSpriteComps1083 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_21_1.time_ >= var_24_9 + var_24_10 and arg_21_1.time_ < var_24_9 + var_24_10 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.actorSpriteComps1083 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_24_7 then
						if arg_21_1.isInRecall_ then
							iter_24_7.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1083 = nil
			end

			local var_24_16 = arg_21_1.actors_["10148"].transform
			local var_24_17 = 0

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 then
				arg_21_1.var_.moveOldPos10148 = var_24_16.localPosition
				var_24_16.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10148", 4)

				local var_24_18 = var_24_16.childCount

				for iter_24_8 = 0, var_24_18 - 1 do
					local var_24_19 = var_24_16:GetChild(iter_24_8)

					if var_24_19.name == "" or not string.find(var_24_19.name, "split") then
						var_24_19.gameObject:SetActive(true)
					else
						var_24_19.gameObject:SetActive(false)
					end
				end
			end

			local var_24_20 = 0.001

			if var_24_17 <= arg_21_1.time_ and arg_21_1.time_ < var_24_17 + var_24_20 then
				local var_24_21 = (arg_21_1.time_ - var_24_17) / var_24_20
				local var_24_22 = Vector3.New(390, -350, -270)

				var_24_16.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10148, var_24_22, var_24_21)
			end

			if arg_21_1.time_ >= var_24_17 + var_24_20 and arg_21_1.time_ < var_24_17 + var_24_20 + arg_24_0 then
				var_24_16.localPosition = Vector3.New(390, -350, -270)
			end

			local var_24_23 = 0
			local var_24_24 = 0.55

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_25 = arg_21_1:FormatText(StoryNameCfg[1331].name)

				arg_21_1.leftNameTxt_.text = var_24_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_26 = arg_21_1:GetWordFromCfg(423211005)
				local var_24_27 = arg_21_1:FormatText(var_24_26.content)

				arg_21_1.text_.text = var_24_27

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_28 = 22
				local var_24_29 = utf8.len(var_24_27)
				local var_24_30 = var_24_28 <= 0 and var_24_24 or var_24_24 * (var_24_29 / var_24_28)

				if var_24_30 > 0 and var_24_24 < var_24_30 then
					arg_21_1.talkMaxDuration = var_24_30

					if var_24_30 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_30 + var_24_23
					end
				end

				arg_21_1.text_.text = var_24_27
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211005", "story_v_out_423211.awb") ~= 0 then
					local var_24_31 = manager.audio:GetVoiceLength("story_v_out_423211", "423211005", "story_v_out_423211.awb") / 1000

					if var_24_31 + var_24_23 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_31 + var_24_23
					end

					if var_24_26.prefab_name ~= "" and arg_21_1.actors_[var_24_26.prefab_name] ~= nil then
						local var_24_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_26.prefab_name].transform, "story_v_out_423211", "423211005", "story_v_out_423211.awb")

						arg_21_1:RecordAudio("423211005", var_24_32)
						arg_21_1:RecordAudio("423211005", var_24_32)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423211", "423211005", "story_v_out_423211.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423211", "423211005", "story_v_out_423211.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_33 = math.max(var_24_24, arg_21_1.talkMaxDuration)

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_33 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_23) / var_24_33

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_23 + var_24_33 and arg_21_1.time_ < var_24_23 + var_24_33 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play423211006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423211006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play423211007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10148"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10148 == nil then
				arg_25_1.var_.actorSpriteComps10148 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10148 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10148 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10148 = nil
			end

			local var_28_8 = arg_25_1.actors_["10148"].transform
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.var_.moveOldPos10148 = var_28_8.localPosition
				var_28_8.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10148", 7)

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
				local var_28_14 = Vector3.New(0, -2000, 0)

				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10148, var_28_14, var_28_13)
			end

			if arg_25_1.time_ >= var_28_9 + var_28_12 and arg_25_1.time_ < var_28_9 + var_28_12 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_15 = arg_25_1.actors_["1083"].transform
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.var_.moveOldPos1083 = var_28_15.localPosition
				var_28_15.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1083", 7)

				local var_28_17 = var_28_15.childCount

				for iter_28_5 = 0, var_28_17 - 1 do
					local var_28_18 = var_28_15:GetChild(iter_28_5)

					if var_28_18.name == "" or not string.find(var_28_18.name, "split") then
						var_28_18.gameObject:SetActive(true)
					else
						var_28_18.gameObject:SetActive(false)
					end
				end
			end

			local var_28_19 = 0.001

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_19 then
				local var_28_20 = (arg_25_1.time_ - var_28_16) / var_28_19
				local var_28_21 = Vector3.New(0, -2000, 0)

				var_28_15.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1083, var_28_21, var_28_20)
			end

			if arg_25_1.time_ >= var_28_16 + var_28_19 and arg_25_1.time_ < var_28_16 + var_28_19 + arg_28_0 then
				var_28_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_22 = 0
			local var_28_23 = 1.375

			if var_28_22 < arg_25_1.time_ and arg_25_1.time_ <= var_28_22 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(423211006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_26 = 55
				local var_28_27 = utf8.len(var_28_25)
				local var_28_28 = var_28_26 <= 0 and var_28_23 or var_28_23 * (var_28_27 / var_28_26)

				if var_28_28 > 0 and var_28_23 < var_28_28 then
					arg_25_1.talkMaxDuration = var_28_28

					if var_28_28 + var_28_22 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_22
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_29 = math.max(var_28_23, arg_25_1.talkMaxDuration)

			if var_28_22 <= arg_25_1.time_ and arg_25_1.time_ < var_28_22 + var_28_29 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_22) / var_28_29

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_22 + var_28_29 and arg_25_1.time_ < var_28_22 + var_28_29 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_25_1:InitPlayNodeList()
	end,
	Play423211007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423211007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423211008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.55

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(423211007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 22
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
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play423211008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423211008
		arg_33_1.duration_ = 9.47

		local var_33_0 = {
			zh = 6.866,
			ja = 9.466
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
				arg_33_0:Play423211009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10148"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10148 == nil then
				arg_33_1.var_.actorSpriteComps10148 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps10148 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps10148 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10148 = nil
			end

			local var_36_8 = arg_33_1.actors_["10148"].transform
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 then
				arg_33_1.var_.moveOldPos10148 = var_36_8.localPosition
				var_36_8.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10148", 4)

				local var_36_10 = var_36_8.childCount

				for iter_36_4 = 0, var_36_10 - 1 do
					local var_36_11 = var_36_8:GetChild(iter_36_4)

					if var_36_11.name == "" or not string.find(var_36_11.name, "split") then
						var_36_11.gameObject:SetActive(true)
					else
						var_36_11.gameObject:SetActive(false)
					end
				end
			end

			local var_36_12 = 0.001

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_12 then
				local var_36_13 = (arg_33_1.time_ - var_36_9) / var_36_12
				local var_36_14 = Vector3.New(390, -350, -270)

				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10148, var_36_14, var_36_13)
			end

			if arg_33_1.time_ >= var_36_9 + var_36_12 and arg_33_1.time_ < var_36_9 + var_36_12 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(390, -350, -270)
			end

			local var_36_15 = arg_33_1.actors_["1083"].transform
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.var_.moveOldPos1083 = var_36_15.localPosition
				var_36_15.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("1083", 2)

				local var_36_17 = var_36_15.childCount

				for iter_36_5 = 0, var_36_17 - 1 do
					local var_36_18 = var_36_15:GetChild(iter_36_5)

					if var_36_18.name == "" or not string.find(var_36_18.name, "split") then
						var_36_18.gameObject:SetActive(true)
					else
						var_36_18.gameObject:SetActive(false)
					end
				end
			end

			local var_36_19 = 0.001

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_19 then
				local var_36_20 = (arg_33_1.time_ - var_36_16) / var_36_19
				local var_36_21 = Vector3.New(-440, -345, -345)

				var_36_15.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1083, var_36_21, var_36_20)
			end

			if arg_33_1.time_ >= var_36_16 + var_36_19 and arg_33_1.time_ < var_36_16 + var_36_19 + arg_36_0 then
				var_36_15.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_36_22 = 0
			local var_36_23 = 0.775

			if var_36_22 < arg_33_1.time_ and arg_33_1.time_ <= var_36_22 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_24 = arg_33_1:FormatText(StoryNameCfg[1331].name)

				arg_33_1.leftNameTxt_.text = var_36_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_25 = arg_33_1:GetWordFromCfg(423211008)
				local var_36_26 = arg_33_1:FormatText(var_36_25.content)

				arg_33_1.text_.text = var_36_26

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_27 = 31
				local var_36_28 = utf8.len(var_36_26)
				local var_36_29 = var_36_27 <= 0 and var_36_23 or var_36_23 * (var_36_28 / var_36_27)

				if var_36_29 > 0 and var_36_23 < var_36_29 then
					arg_33_1.talkMaxDuration = var_36_29

					if var_36_29 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_22
					end
				end

				arg_33_1.text_.text = var_36_26
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211008", "story_v_out_423211.awb") ~= 0 then
					local var_36_30 = manager.audio:GetVoiceLength("story_v_out_423211", "423211008", "story_v_out_423211.awb") / 1000

					if var_36_30 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_22
					end

					if var_36_25.prefab_name ~= "" and arg_33_1.actors_[var_36_25.prefab_name] ~= nil then
						local var_36_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_25.prefab_name].transform, "story_v_out_423211", "423211008", "story_v_out_423211.awb")

						arg_33_1:RecordAudio("423211008", var_36_31)
						arg_33_1:RecordAudio("423211008", var_36_31)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423211", "423211008", "story_v_out_423211.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423211", "423211008", "story_v_out_423211.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_32 = math.max(var_36_23, arg_33_1.talkMaxDuration)

			if var_36_22 <= arg_33_1.time_ and arg_33_1.time_ < var_36_22 + var_36_32 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_22) / var_36_32

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_22 + var_36_32 and arg_33_1.time_ < var_36_22 + var_36_32 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_33_1:InitPlayNodeList()
	end,
	Play423211009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423211009
		arg_37_1.duration_ = 7.47

		local var_37_0 = {
			zh = 4.2,
			ja = 7.466
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
				arg_37_0:Play423211010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.525

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1331].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(423211009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211009", "story_v_out_423211.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_423211", "423211009", "story_v_out_423211.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_423211", "423211009", "story_v_out_423211.awb")

						arg_37_1:RecordAudio("423211009", var_40_9)
						arg_37_1:RecordAudio("423211009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423211", "423211009", "story_v_out_423211.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423211", "423211009", "story_v_out_423211.awb")
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
	Play423211010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423211010
		arg_41_1.duration_ = 8.8

		local var_41_0 = {
			zh = 5.866,
			ja = 8.8
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
				arg_41_0:Play423211011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1083"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1083 == nil then
				arg_41_1.var_.actorSpriteComps1083 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1083 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1083 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1083 = nil
			end

			local var_44_8 = arg_41_1.actors_["10148"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10148 == nil then
				arg_41_1.var_.actorSpriteComps10148 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10148 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10148 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10148 = nil
			end

			local var_44_16 = arg_41_1.actors_["1083"].transform
			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.var_.moveOldPos1083 = var_44_16.localPosition
				var_44_16.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1083", 2)

				local var_44_18 = var_44_16.childCount

				for iter_44_8 = 0, var_44_18 - 1 do
					local var_44_19 = var_44_16:GetChild(iter_44_8)

					if var_44_19.name == "split_2" or not string.find(var_44_19.name, "split") then
						var_44_19.gameObject:SetActive(true)
					else
						var_44_19.gameObject:SetActive(false)
					end
				end
			end

			local var_44_20 = 0.001

			if var_44_17 <= arg_41_1.time_ and arg_41_1.time_ < var_44_17 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_17) / var_44_20
				local var_44_22 = Vector3.New(-440, -345, -345)

				var_44_16.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1083, var_44_22, var_44_21)
			end

			if arg_41_1.time_ >= var_44_17 + var_44_20 and arg_41_1.time_ < var_44_17 + var_44_20 + arg_44_0 then
				var_44_16.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_44_23 = 0
			local var_44_24 = 0.625

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[1332].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(423211010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 25
				local var_44_29 = utf8.len(var_44_27)
				local var_44_30 = var_44_28 <= 0 and var_44_24 or var_44_24 * (var_44_29 / var_44_28)

				if var_44_30 > 0 and var_44_24 < var_44_30 then
					arg_41_1.talkMaxDuration = var_44_30

					if var_44_30 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_30 + var_44_23
					end
				end

				arg_41_1.text_.text = var_44_27
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211010", "story_v_out_423211.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_423211", "423211010", "story_v_out_423211.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_423211", "423211010", "story_v_out_423211.awb")

						arg_41_1:RecordAudio("423211010", var_44_32)
						arg_41_1:RecordAudio("423211010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423211", "423211010", "story_v_out_423211.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423211", "423211010", "story_v_out_423211.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_33 = math.max(var_44_24, arg_41_1.talkMaxDuration)

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_33 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_23) / var_44_33

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_23 + var_44_33 and arg_41_1.time_ < var_44_23 + var_44_33 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play423211011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423211011
		arg_45_1.duration_ = 8.57

		local var_45_0 = {
			zh = 7.2,
			ja = 8.566
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
				arg_45_0:Play423211012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1083"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1083 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1083", 2)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "split_1" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(-440, -345, -345)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1083, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_48_7 = 0
			local var_48_8 = 0.775

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_9 = arg_45_1:FormatText(StoryNameCfg[1332].name)

				arg_45_1.leftNameTxt_.text = var_48_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(423211011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211011", "story_v_out_423211.awb") ~= 0 then
					local var_48_15 = manager.audio:GetVoiceLength("story_v_out_423211", "423211011", "story_v_out_423211.awb") / 1000

					if var_48_15 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_15 + var_48_7
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_423211", "423211011", "story_v_out_423211.awb")

						arg_45_1:RecordAudio("423211011", var_48_16)
						arg_45_1:RecordAudio("423211011", var_48_16)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423211", "423211011", "story_v_out_423211.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423211", "423211011", "story_v_out_423211.awb")
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
				actorName = "1083",
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
	Play423211012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423211012
		arg_49_1.duration_ = 9.47

		local var_49_0 = {
			zh = 4.9,
			ja = 9.466
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
				arg_49_0:Play423211013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10148"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10148 == nil then
				arg_49_1.var_.actorSpriteComps10148 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10148 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 1, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10148 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10148 = nil
			end

			local var_52_8 = arg_49_1.actors_["1083"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1083 == nil then
				arg_49_1.var_.actorSpriteComps1083 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps1083 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								local var_52_12 = Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, var_52_11)
								local var_52_13 = Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, var_52_11)
								local var_52_14 = Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, var_52_11)

								iter_52_5.color = Color.New(var_52_12, var_52_13, var_52_14)
							else
								local var_52_15 = Mathf.Lerp(iter_52_5.color.r, 0.5, var_52_11)

								iter_52_5.color = Color.New(var_52_15, var_52_15, var_52_15)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1083 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1083 = nil
			end

			local var_52_16 = 0
			local var_52_17 = 0.625

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_18 = arg_49_1:FormatText(StoryNameCfg[1331].name)

				arg_49_1.leftNameTxt_.text = var_52_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_19 = arg_49_1:GetWordFromCfg(423211012)
				local var_52_20 = arg_49_1:FormatText(var_52_19.content)

				arg_49_1.text_.text = var_52_20

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_21 = 25
				local var_52_22 = utf8.len(var_52_20)
				local var_52_23 = var_52_21 <= 0 and var_52_17 or var_52_17 * (var_52_22 / var_52_21)

				if var_52_23 > 0 and var_52_17 < var_52_23 then
					arg_49_1.talkMaxDuration = var_52_23

					if var_52_23 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_20
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211012", "story_v_out_423211.awb") ~= 0 then
					local var_52_24 = manager.audio:GetVoiceLength("story_v_out_423211", "423211012", "story_v_out_423211.awb") / 1000

					if var_52_24 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_24 + var_52_16
					end

					if var_52_19.prefab_name ~= "" and arg_49_1.actors_[var_52_19.prefab_name] ~= nil then
						local var_52_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_19.prefab_name].transform, "story_v_out_423211", "423211012", "story_v_out_423211.awb")

						arg_49_1:RecordAudio("423211012", var_52_25)
						arg_49_1:RecordAudio("423211012", var_52_25)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423211", "423211012", "story_v_out_423211.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423211", "423211012", "story_v_out_423211.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_26 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_26 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_16) / var_52_26

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_16 + var_52_26 and arg_49_1.time_ < var_52_16 + var_52_26 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play423211013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423211013
		arg_53_1.duration_ = 7.17

		local var_53_0 = {
			zh = 3.2,
			ja = 7.166
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
				arg_53_0:Play423211014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.425

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1331].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(423211013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211013", "story_v_out_423211.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_423211", "423211013", "story_v_out_423211.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_423211", "423211013", "story_v_out_423211.awb")

						arg_53_1:RecordAudio("423211013", var_56_9)
						arg_53_1:RecordAudio("423211013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423211", "423211013", "story_v_out_423211.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423211", "423211013", "story_v_out_423211.awb")
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
	Play423211014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423211014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play423211015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10148"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10148 == nil then
				arg_57_1.var_.actorSpriteComps10148 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10148 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10148 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10148 = nil
			end

			local var_60_8 = 0
			local var_60_9 = 0.85

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_10 = arg_57_1:FormatText(StoryNameCfg[7].name)

				arg_57_1.leftNameTxt_.text = var_60_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_11 = arg_57_1:GetWordFromCfg(423211014)
				local var_60_12 = arg_57_1:FormatText(var_60_11.content)

				arg_57_1.text_.text = var_60_12

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 34
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
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play423211015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423211015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play423211016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.65

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[7].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(423211015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 26
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play423211016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423211016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play423211017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10148"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10148 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10148", 7)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(0, -2000, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10148, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_7 = arg_65_1.actors_["1083"].transform
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.var_.moveOldPos1083 = var_68_7.localPosition
				var_68_7.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1083", 7)

				local var_68_9 = var_68_7.childCount

				for iter_68_1 = 0, var_68_9 - 1 do
					local var_68_10 = var_68_7:GetChild(iter_68_1)

					if var_68_10.name == "" or not string.find(var_68_10.name, "split") then
						var_68_10.gameObject:SetActive(true)
					else
						var_68_10.gameObject:SetActive(false)
					end
				end
			end

			local var_68_11 = 0.001

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_11 then
				local var_68_12 = (arg_65_1.time_ - var_68_8) / var_68_11
				local var_68_13 = Vector3.New(0, -2000, 0)

				var_68_7.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1083, var_68_13, var_68_12)
			end

			if arg_65_1.time_ >= var_68_8 + var_68_11 and arg_65_1.time_ < var_68_8 + var_68_11 + arg_68_0 then
				var_68_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_14 = 0
			local var_68_15 = 1.475

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_16 = arg_65_1:GetWordFromCfg(423211016)
				local var_68_17 = arg_65_1:FormatText(var_68_16.content)

				arg_65_1.text_.text = var_68_17

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_18 = 58
				local var_68_19 = utf8.len(var_68_17)
				local var_68_20 = var_68_18 <= 0 and var_68_15 or var_68_15 * (var_68_19 / var_68_18)

				if var_68_20 > 0 and var_68_15 < var_68_20 then
					arg_65_1.talkMaxDuration = var_68_20

					if var_68_20 + var_68_14 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_20 + var_68_14
					end
				end

				arg_65_1.text_.text = var_68_17
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_21 = math.max(var_68_15, arg_65_1.talkMaxDuration)

			if var_68_14 <= arg_65_1.time_ and arg_65_1.time_ < var_68_14 + var_68_21 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_14) / var_68_21

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_14 + var_68_21 and arg_65_1.time_ < var_68_14 + var_68_21 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_65_1:InitPlayNodeList()
	end,
	Play423211017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423211017
		arg_69_1.duration_ = 13.3

		local var_69_0 = {
			zh = 10.566,
			ja = 13.3
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play423211018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.1

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[1334].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(423211017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 44
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211017", "story_v_out_423211.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_423211", "423211017", "story_v_out_423211.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_423211", "423211017", "story_v_out_423211.awb")

						arg_69_1:RecordAudio("423211017", var_72_9)
						arg_69_1:RecordAudio("423211017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_423211", "423211017", "story_v_out_423211.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_423211", "423211017", "story_v_out_423211.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play423211018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 423211018
		arg_73_1.duration_ = 15.53

		local var_73_0 = {
			zh = 9.533,
			ja = 15.533
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play423211019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 0.95

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_2 = arg_73_1:FormatText(StoryNameCfg[1334].name)

				arg_73_1.leftNameTxt_.text = var_76_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(423211018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211018", "story_v_out_423211.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_423211", "423211018", "story_v_out_423211.awb") / 1000

					if var_76_8 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_0
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_423211", "423211018", "story_v_out_423211.awb")

						arg_73_1:RecordAudio("423211018", var_76_9)
						arg_73_1:RecordAudio("423211018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_423211", "423211018", "story_v_out_423211.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_423211", "423211018", "story_v_out_423211.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_10 and arg_73_1.time_ < var_76_0 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play423211019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 423211019
		arg_77_1.duration_ = 14.8

		local var_77_0 = {
			zh = 11.3,
			ja = 14.8
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
				arg_77_0:Play423211020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.05

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1334].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(423211019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 42
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211019", "story_v_out_423211.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_423211", "423211019", "story_v_out_423211.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_423211", "423211019", "story_v_out_423211.awb")

						arg_77_1:RecordAudio("423211019", var_80_9)
						arg_77_1:RecordAudio("423211019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_423211", "423211019", "story_v_out_423211.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_423211", "423211019", "story_v_out_423211.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play423211020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 423211020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play423211021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 1.7

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(423211020)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 68
				local var_84_5 = utf8.len(var_84_3)
				local var_84_6 = var_84_4 <= 0 and var_84_1 or var_84_1 * (var_84_5 / var_84_4)

				if var_84_6 > 0 and var_84_1 < var_84_6 then
					arg_81_1.talkMaxDuration = var_84_6

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_7 and arg_81_1.time_ < var_84_0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play423211021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423211021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play423211022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.675

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_2

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

				local var_88_3 = arg_85_1:GetWordFromCfg(423211021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 27
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play423211022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 423211022
		arg_89_1.duration_ = 4.13

		local var_89_0 = {
			zh = 3.666,
			ja = 4.133
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play423211023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10148"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10148 == nil then
				arg_89_1.var_.actorSpriteComps10148 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps10148 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps10148 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10148 = nil
			end

			local var_92_8 = arg_89_1.actors_["10148"].transform
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.var_.moveOldPos10148 = var_92_8.localPosition
				var_92_8.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10148", 3)

				local var_92_10 = var_92_8.childCount

				for iter_92_4 = 0, var_92_10 - 1 do
					local var_92_11 = var_92_8:GetChild(iter_92_4)

					if var_92_11.name == "split_2" or not string.find(var_92_11.name, "split") then
						var_92_11.gameObject:SetActive(true)
					else
						var_92_11.gameObject:SetActive(false)
					end
				end
			end

			local var_92_12 = 0.001

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_12 then
				local var_92_13 = (arg_89_1.time_ - var_92_9) / var_92_12
				local var_92_14 = Vector3.New(0, -350, -270)

				var_92_8.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10148, var_92_14, var_92_13)
			end

			if arg_89_1.time_ >= var_92_9 + var_92_12 and arg_89_1.time_ < var_92_9 + var_92_12 + arg_92_0 then
				var_92_8.localPosition = Vector3.New(0, -350, -270)
			end

			local var_92_15 = 0
			local var_92_16 = 0.375

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[1331].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(423211022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 15
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211022", "story_v_out_423211.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_out_423211", "423211022", "story_v_out_423211.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_out_423211", "423211022", "story_v_out_423211.awb")

						arg_89_1:RecordAudio("423211022", var_92_24)
						arg_89_1:RecordAudio("423211022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_423211", "423211022", "story_v_out_423211.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_423211", "423211022", "story_v_out_423211.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play423211023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 423211023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play423211024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10148"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10148 == nil then
				arg_93_1.var_.actorSpriteComps10148 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10148 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor2.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor2.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor2.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 0.5, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10148 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10148 = nil
			end

			local var_96_8 = arg_93_1.actors_["10148"].transform
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.var_.moveOldPos10148 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10148", 7)

				local var_96_10 = var_96_8.childCount

				for iter_96_4 = 0, var_96_10 - 1 do
					local var_96_11 = var_96_8:GetChild(iter_96_4)

					if var_96_11.name == "" or not string.find(var_96_11.name, "split") then
						var_96_11.gameObject:SetActive(true)
					else
						var_96_11.gameObject:SetActive(false)
					end
				end
			end

			local var_96_12 = 0.001

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_12 then
				local var_96_13 = (arg_93_1.time_ - var_96_9) / var_96_12
				local var_96_14 = Vector3.New(0, -2000, 0)

				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10148, var_96_14, var_96_13)
			end

			if arg_93_1.time_ >= var_96_9 + var_96_12 and arg_93_1.time_ < var_96_9 + var_96_12 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_96_15 = 0
			local var_96_16 = 1.475

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_17 = arg_93_1:GetWordFromCfg(423211023)
				local var_96_18 = arg_93_1:FormatText(var_96_17.content)

				arg_93_1.text_.text = var_96_18

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_19 = 59
				local var_96_20 = utf8.len(var_96_18)
				local var_96_21 = var_96_19 <= 0 and var_96_16 or var_96_16 * (var_96_20 / var_96_19)

				if var_96_21 > 0 and var_96_16 < var_96_21 then
					arg_93_1.talkMaxDuration = var_96_21

					if var_96_21 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_21 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_18
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_22 and arg_93_1.time_ < var_96_15 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play423211024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 423211024
		arg_97_1.duration_ = 5.07

		local var_97_0 = {
			zh = 3.033,
			ja = 5.066
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play423211025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1083"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1083 == nil then
				arg_97_1.var_.actorSpriteComps1083 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps1083 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor1.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor1.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor1.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 1, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps1083 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1083 = nil
			end

			local var_100_8 = arg_97_1.actors_["1083"].transform
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.var_.moveOldPos1083 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1083", 3)

				local var_100_10 = var_100_8.childCount

				for iter_100_4 = 0, var_100_10 - 1 do
					local var_100_11 = var_100_8:GetChild(iter_100_4)

					if var_100_11.name == "" or not string.find(var_100_11.name, "split") then
						var_100_11.gameObject:SetActive(true)
					else
						var_100_11.gameObject:SetActive(false)
					end
				end
			end

			local var_100_12 = 0.001

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_12 then
				local var_100_13 = (arg_97_1.time_ - var_100_9) / var_100_12
				local var_100_14 = Vector3.New(-50, -345, -345)

				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1083, var_100_14, var_100_13)
			end

			if arg_97_1.time_ >= var_100_9 + var_100_12 and arg_97_1.time_ < var_100_9 + var_100_12 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_100_15 = 0
			local var_100_16 = 0.325

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[1332].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(423211024)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 13
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211024", "story_v_out_423211.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_423211", "423211024", "story_v_out_423211.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_423211", "423211024", "story_v_out_423211.awb")

						arg_97_1:RecordAudio("423211024", var_100_24)
						arg_97_1:RecordAudio("423211024", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_423211", "423211024", "story_v_out_423211.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_423211", "423211024", "story_v_out_423211.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play423211025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 423211025
		arg_101_1.duration_ = 4.6

		local var_101_0 = {
			zh = 4,
			ja = 4.6
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
				arg_101_0:Play423211026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1083"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1083 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1083", 3)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(-50, -345, -345)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1083, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_104_7 = 0
			local var_104_8 = 0.425

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_9 = arg_101_1:FormatText(StoryNameCfg[1332].name)

				arg_101_1.leftNameTxt_.text = var_104_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(423211025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_12 = 17
				local var_104_13 = utf8.len(var_104_11)
				local var_104_14 = var_104_12 <= 0 and var_104_8 or var_104_8 * (var_104_13 / var_104_12)

				if var_104_14 > 0 and var_104_8 < var_104_14 then
					arg_101_1.talkMaxDuration = var_104_14

					if var_104_14 + var_104_7 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_7
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211025", "story_v_out_423211.awb") ~= 0 then
					local var_104_15 = manager.audio:GetVoiceLength("story_v_out_423211", "423211025", "story_v_out_423211.awb") / 1000

					if var_104_15 + var_104_7 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_7
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_423211", "423211025", "story_v_out_423211.awb")

						arg_101_1:RecordAudio("423211025", var_104_16)
						arg_101_1:RecordAudio("423211025", var_104_16)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_423211", "423211025", "story_v_out_423211.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_423211", "423211025", "story_v_out_423211.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_17 = math.max(var_104_8, arg_101_1.talkMaxDuration)

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_17 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_7) / var_104_17

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_7 + var_104_17 and arg_101_1.time_ < var_104_7 + var_104_17 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play423211026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423211026
		arg_105_1.duration_ = 9.17

		local var_105_0 = {
			zh = 9.165999999999,
			ja = 8.432999999999
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
				arg_105_0:Play423211027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "ST08"

			if arg_105_1.bgs_[var_108_0] == nil then
				local var_108_1 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_0)
				var_108_1.name = var_108_0
				var_108_1.transform.parent = arg_105_1.stage_.transform
				var_108_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_0] = var_108_1
			end

			local var_108_2 = 2

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera.transform.localPosition
				local var_108_4 = Vector3.New(0, 0, 10) + Vector3.New(var_108_3.x, var_108_3.y, 0)
				local var_108_5 = arg_105_1.bgs_.ST08

				var_108_5.transform.localPosition = var_108_4
				var_108_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_6 = var_108_5:GetComponent("SpriteRenderer")

				if var_108_6 and var_108_6.sprite then
					local var_108_7 = (var_108_5.transform.localPosition - var_108_3).z
					local var_108_8 = manager.ui.mainCameraCom_
					local var_108_9 = 2 * var_108_7 * Mathf.Tan(var_108_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_10 = var_108_9 * var_108_8.aspect
					local var_108_11 = var_108_6.sprite.bounds.size.x
					local var_108_12 = var_108_6.sprite.bounds.size.y
					local var_108_13 = var_108_10 / var_108_11
					local var_108_14 = var_108_9 / var_108_12
					local var_108_15 = var_108_14 < var_108_13 and var_108_13 or var_108_14

					var_108_5.transform.localScale = Vector3.New(var_108_15, var_108_15, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "ST08" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_16 = 3.999999999999

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			local var_108_17 = 0.3

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_18 = 0

			if var_108_18 < arg_105_1.time_ and arg_105_1.time_ <= var_108_18 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_19 = 2

			if var_108_18 <= arg_105_1.time_ and arg_105_1.time_ < var_108_18 + var_108_19 then
				local var_108_20 = (arg_105_1.time_ - var_108_18) / var_108_19
				local var_108_21 = Color.New(0, 0, 0)

				var_108_21.a = Mathf.Lerp(0, 1, var_108_20)
				arg_105_1.mask_.color = var_108_21
			end

			if arg_105_1.time_ >= var_108_18 + var_108_19 and arg_105_1.time_ < var_108_18 + var_108_19 + arg_108_0 then
				local var_108_22 = Color.New(0, 0, 0)

				var_108_22.a = 1
				arg_105_1.mask_.color = var_108_22
			end

			local var_108_23 = 2

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_24 = 2

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_24 then
				local var_108_25 = (arg_105_1.time_ - var_108_23) / var_108_24
				local var_108_26 = Color.New(0, 0, 0)

				var_108_26.a = Mathf.Lerp(1, 0, var_108_25)
				arg_105_1.mask_.color = var_108_26
			end

			if arg_105_1.time_ >= var_108_23 + var_108_24 and arg_105_1.time_ < var_108_23 + var_108_24 + arg_108_0 then
				local var_108_27 = Color.New(0, 0, 0)
				local var_108_28 = 0

				arg_105_1.mask_.enabled = false
				var_108_27.a = var_108_28
				arg_105_1.mask_.color = var_108_27
			end

			local var_108_29 = arg_105_1.actors_["1083"].transform
			local var_108_30 = 1.98333333333333

			if var_108_30 < arg_105_1.time_ and arg_105_1.time_ <= var_108_30 + arg_108_0 then
				arg_105_1.var_.moveOldPos1083 = var_108_29.localPosition
				var_108_29.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1083", 7)

				local var_108_31 = var_108_29.childCount

				for iter_108_2 = 0, var_108_31 - 1 do
					local var_108_32 = var_108_29:GetChild(iter_108_2)

					if var_108_32.name == "" or not string.find(var_108_32.name, "split") then
						var_108_32.gameObject:SetActive(true)
					else
						var_108_32.gameObject:SetActive(false)
					end
				end
			end

			local var_108_33 = 0.001

			if var_108_30 <= arg_105_1.time_ and arg_105_1.time_ < var_108_30 + var_108_33 then
				local var_108_34 = (arg_105_1.time_ - var_108_30) / var_108_33
				local var_108_35 = Vector3.New(0, -2000, 0)

				var_108_29.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1083, var_108_35, var_108_34)
			end

			if arg_105_1.time_ >= var_108_30 + var_108_33 and arg_105_1.time_ < var_108_30 + var_108_33 + arg_108_0 then
				var_108_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_108_36 = arg_105_1.actors_["1083"].transform
			local var_108_37 = 3.8

			if var_108_37 < arg_105_1.time_ and arg_105_1.time_ <= var_108_37 + arg_108_0 then
				arg_105_1.var_.moveOldPos1083 = var_108_36.localPosition
				var_108_36.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1083", 3)

				local var_108_38 = var_108_36.childCount

				for iter_108_3 = 0, var_108_38 - 1 do
					local var_108_39 = var_108_36:GetChild(iter_108_3)

					if var_108_39.name == "split_4" or not string.find(var_108_39.name, "split") then
						var_108_39.gameObject:SetActive(true)
					else
						var_108_39.gameObject:SetActive(false)
					end
				end
			end

			local var_108_40 = 0.1

			if var_108_37 <= arg_105_1.time_ and arg_105_1.time_ < var_108_37 + var_108_40 then
				local var_108_41 = (arg_105_1.time_ - var_108_37) / var_108_40
				local var_108_42 = Vector3.New(-50, -345, -345)

				var_108_36.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1083, var_108_42, var_108_41)
			end

			if arg_105_1.time_ >= var_108_37 + var_108_40 and arg_105_1.time_ < var_108_37 + var_108_40 + arg_108_0 then
				var_108_36.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_108_43 = arg_105_1.actors_["1083"]
			local var_108_44 = 3.8

			if var_108_44 < arg_105_1.time_ and arg_105_1.time_ <= var_108_44 + arg_108_0 then
				local var_108_45 = var_108_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_108_45 then
					arg_105_1.var_.alphaOldValue1083 = var_108_45.alpha
					arg_105_1.var_.characterEffect1083 = var_108_45
				end

				arg_105_1.var_.alphaOldValue1083 = 0
			end

			local var_108_46 = 0.5

			if var_108_44 <= arg_105_1.time_ and arg_105_1.time_ < var_108_44 + var_108_46 then
				local var_108_47 = (arg_105_1.time_ - var_108_44) / var_108_46
				local var_108_48 = Mathf.Lerp(arg_105_1.var_.alphaOldValue1083, 1, var_108_47)

				if arg_105_1.var_.characterEffect1083 then
					arg_105_1.var_.characterEffect1083.alpha = var_108_48
				end
			end

			if arg_105_1.time_ >= var_108_44 + var_108_46 and arg_105_1.time_ < var_108_44 + var_108_46 + arg_108_0 and arg_105_1.var_.characterEffect1083 then
				arg_105_1.var_.characterEffect1083.alpha = 1
			end

			local var_108_49 = 0.3
			local var_108_50 = 0.3

			if var_108_49 < arg_105_1.time_ and arg_105_1.time_ <= var_108_49 + arg_108_0 then
				local var_108_51 = "play"
				local var_108_52 = "music"

				arg_105_1:AudioAction(var_108_51, var_108_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_108_53 = ""
				local var_108_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_108_54 ~= "" then
					if arg_105_1.bgmTxt_.text ~= var_108_54 and arg_105_1.bgmTxt_.text ~= "" then
						if arg_105_1.bgmTxt2_.text ~= "" then
							arg_105_1.bgmTxt_.text = arg_105_1.bgmTxt2_.text
						end

						arg_105_1.bgmTxt2_.text = var_108_54

						arg_105_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_105_1.bgmTxt_.text = var_108_54
						arg_105_1.bgmTxt2_.text = var_108_54
					end

					if arg_105_1.bgmTimer then
						arg_105_1.bgmTimer:Stop()

						arg_105_1.bgmTimer = nil
					end

					if arg_105_1.settingData.show_music_name == 1 then
						arg_105_1.musicController:SetSelectedState("show")
						arg_105_1.musicAnimator_:Play("open", 0, 0)

						if arg_105_1.settingData.music_time ~= 0 then
							arg_105_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_105_1.settingData.music_time), function()
								if arg_105_1 == nil or isNil(arg_105_1.bgmTxt_) then
									return
								end

								arg_105_1.musicController:SetSelectedState("hide")
								arg_105_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_108_55 = 0.3
			local var_108_56 = 1

			if var_108_55 < arg_105_1.time_ and arg_105_1.time_ <= var_108_55 + arg_108_0 then
				local var_108_57 = "stop"
				local var_108_58 = "effect"

				arg_105_1:AudioAction(var_108_57, var_108_58, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_108_59 = 1.5
			local var_108_60 = 1

			if var_108_59 < arg_105_1.time_ and arg_105_1.time_ <= var_108_59 + arg_108_0 then
				local var_108_61 = "play"
				local var_108_62 = "effect"

				arg_105_1:AudioAction(var_108_61, var_108_62, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_108_63 = 1.5
			local var_108_64 = 1

			if var_108_63 < arg_105_1.time_ and arg_105_1.time_ <= var_108_63 + arg_108_0 then
				local var_108_65 = "play"
				local var_108_66 = "effect"

				arg_105_1:AudioAction(var_108_65, var_108_66, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_67 = 3.999999999999
			local var_108_68 = 0.225

			if var_108_67 < arg_105_1.time_ and arg_105_1.time_ <= var_108_67 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_69 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_69:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_105_1.dialogCg_.alpha = arg_110_0
				end))
				var_108_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_70 = arg_105_1:FormatText(StoryNameCfg[1332].name)

				arg_105_1.leftNameTxt_.text = var_108_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_71 = arg_105_1:GetWordFromCfg(423211026)
				local var_108_72 = arg_105_1:FormatText(var_108_71.content)

				arg_105_1.text_.text = var_108_72

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_73 = 9
				local var_108_74 = utf8.len(var_108_72)
				local var_108_75 = var_108_73 <= 0 and var_108_68 or var_108_68 * (var_108_74 / var_108_73)

				if var_108_75 > 0 and var_108_68 < var_108_75 then
					arg_105_1.talkMaxDuration = var_108_75
					var_108_67 = var_108_67 + 0.3

					if var_108_75 + var_108_67 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_75 + var_108_67
					end
				end

				arg_105_1.text_.text = var_108_72
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211026", "story_v_out_423211.awb") ~= 0 then
					local var_108_76 = manager.audio:GetVoiceLength("story_v_out_423211", "423211026", "story_v_out_423211.awb") / 1000

					if var_108_76 + var_108_67 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_76 + var_108_67
					end

					if var_108_71.prefab_name ~= "" and arg_105_1.actors_[var_108_71.prefab_name] ~= nil then
						local var_108_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_71.prefab_name].transform, "story_v_out_423211", "423211026", "story_v_out_423211.awb")

						arg_105_1:RecordAudio("423211026", var_108_77)
						arg_105_1:RecordAudio("423211026", var_108_77)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_423211", "423211026", "story_v_out_423211.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_423211", "423211026", "story_v_out_423211.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_78 = var_108_67 + 0.3
			local var_108_79 = math.max(var_108_68, arg_105_1.talkMaxDuration)

			if var_108_78 <= arg_105_1.time_ and arg_105_1.time_ < var_108_78 + var_108_79 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_78) / var_108_79

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_78 + var_108_79 and arg_105_1.time_ < var_108_78 + var_108_79 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play423211027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 423211027
		arg_112_1.duration_ = 8.37

		local var_112_0 = {
			zh = 7,
			ja = 8.366
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
				arg_112_0:Play423211028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1083"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1083 = var_115_0.localPosition
				var_115_0.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1083", 3)

				local var_115_2 = var_115_0.childCount

				for iter_115_0 = 0, var_115_2 - 1 do
					local var_115_3 = var_115_0:GetChild(iter_115_0)

					if var_115_3.name == "split_7" or not string.find(var_115_3.name, "split") then
						var_115_3.gameObject:SetActive(true)
					else
						var_115_3.gameObject:SetActive(false)
					end
				end
			end

			local var_115_4 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_4 then
				local var_115_5 = (arg_112_1.time_ - var_115_1) / var_115_4
				local var_115_6 = Vector3.New(-50, -345, -345)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1083, var_115_6, var_115_5)
			end

			if arg_112_1.time_ >= var_115_1 + var_115_4 and arg_112_1.time_ < var_115_1 + var_115_4 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_115_7 = 0
			local var_115_8 = 0.725

			if var_115_7 < arg_112_1.time_ and arg_112_1.time_ <= var_115_7 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_9 = arg_112_1:FormatText(StoryNameCfg[1332].name)

				arg_112_1.leftNameTxt_.text = var_115_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(423211027)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_12 = 29
				local var_115_13 = utf8.len(var_115_11)
				local var_115_14 = var_115_12 <= 0 and var_115_8 or var_115_8 * (var_115_13 / var_115_12)

				if var_115_14 > 0 and var_115_8 < var_115_14 then
					arg_112_1.talkMaxDuration = var_115_14

					if var_115_14 + var_115_7 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_7
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211027", "story_v_out_423211.awb") ~= 0 then
					local var_115_15 = manager.audio:GetVoiceLength("story_v_out_423211", "423211027", "story_v_out_423211.awb") / 1000

					if var_115_15 + var_115_7 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_15 + var_115_7
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_423211", "423211027", "story_v_out_423211.awb")

						arg_112_1:RecordAudio("423211027", var_115_16)
						arg_112_1:RecordAudio("423211027", var_115_16)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_423211", "423211027", "story_v_out_423211.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_423211", "423211027", "story_v_out_423211.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_17 = math.max(var_115_8, arg_112_1.talkMaxDuration)

			if var_115_7 <= arg_112_1.time_ and arg_112_1.time_ < var_115_7 + var_115_17 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_7) / var_115_17

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_7 + var_115_17 and arg_112_1.time_ < var_115_7 + var_115_17 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play423211028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 423211028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play423211029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1083"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1083 == nil then
				arg_116_1.var_.actorSpriteComps1083 = var_119_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_2 = 0.2

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.actorSpriteComps1083 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								local var_119_4 = Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor2.r, var_119_3)
								local var_119_5 = Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor2.g, var_119_3)
								local var_119_6 = Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor2.b, var_119_3)

								iter_119_1.color = Color.New(var_119_4, var_119_5, var_119_6)
							else
								local var_119_7 = Mathf.Lerp(iter_119_1.color.r, 0.5, var_119_3)

								iter_119_1.color = Color.New(var_119_7, var_119_7, var_119_7)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.actorSpriteComps1083 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_119_3 then
						if arg_116_1.isInRecall_ then
							iter_119_3.color = arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_119_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_116_1.var_.actorSpriteComps1083 = nil
			end

			local var_119_8 = arg_116_1.actors_["1083"].transform
			local var_119_9 = 0

			if var_119_9 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 then
				arg_116_1.var_.moveOldPos1083 = var_119_8.localPosition
				var_119_8.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1083", 7)

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
				local var_119_14 = Vector3.New(0, -2000, 0)

				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1083, var_119_14, var_119_13)
			end

			if arg_116_1.time_ >= var_119_9 + var_119_12 and arg_116_1.time_ < var_119_9 + var_119_12 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_15 = 0
			local var_119_16 = 1.575

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_17 = arg_116_1:GetWordFromCfg(423211028)
				local var_119_18 = arg_116_1:FormatText(var_119_17.content)

				arg_116_1.text_.text = var_119_18

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_19 = 63
				local var_119_20 = utf8.len(var_119_18)
				local var_119_21 = var_119_19 <= 0 and var_119_16 or var_119_16 * (var_119_20 / var_119_19)

				if var_119_21 > 0 and var_119_16 < var_119_21 then
					arg_116_1.talkMaxDuration = var_119_21

					if var_119_21 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_21 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_18
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_22 and arg_116_1.time_ < var_119_15 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play423211029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 423211029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play423211030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.875

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(423211029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 35
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
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_8 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_8 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_8

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_8 and arg_120_1.time_ < var_123_0 + var_123_8 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play423211030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 423211030
		arg_124_1.duration_ = 12.47

		local var_124_0 = {
			zh = 9.833,
			ja = 12.466
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
				arg_124_0:Play423211031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1083"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1083 == nil then
				arg_124_1.var_.actorSpriteComps1083 = var_127_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_2 = 0.2

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.actorSpriteComps1083 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.actorSpriteComps1083 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_127_3 then
						if arg_124_1.isInRecall_ then
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_127_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_124_1.var_.actorSpriteComps1083 = nil
			end

			local var_127_8 = arg_124_1.actors_["1083"].transform
			local var_127_9 = 0

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.var_.moveOldPos1083 = var_127_8.localPosition
				var_127_8.localScale = Vector3.New(1, 1, 1)

				arg_124_1:CheckSpriteTmpPos("1083", 2)

				local var_127_10 = var_127_8.childCount

				for iter_127_4 = 0, var_127_10 - 1 do
					local var_127_11 = var_127_8:GetChild(iter_127_4)

					if var_127_11.name == "split_4" or not string.find(var_127_11.name, "split") then
						var_127_11.gameObject:SetActive(true)
					else
						var_127_11.gameObject:SetActive(false)
					end
				end
			end

			local var_127_12 = 0.001

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_12 then
				local var_127_13 = (arg_124_1.time_ - var_127_9) / var_127_12
				local var_127_14 = Vector3.New(-440, -345, -345)

				var_127_8.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1083, var_127_14, var_127_13)
			end

			if arg_124_1.time_ >= var_127_9 + var_127_12 and arg_124_1.time_ < var_127_9 + var_127_12 + arg_127_0 then
				var_127_8.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_127_15 = 0
			local var_127_16 = 1.025

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_17 = arg_124_1:FormatText(StoryNameCfg[1332].name)

				arg_124_1.leftNameTxt_.text = var_127_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(423211030)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 41
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211030", "story_v_out_423211.awb") ~= 0 then
					local var_127_23 = manager.audio:GetVoiceLength("story_v_out_423211", "423211030", "story_v_out_423211.awb") / 1000

					if var_127_23 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_15
					end

					if var_127_18.prefab_name ~= "" and arg_124_1.actors_[var_127_18.prefab_name] ~= nil then
						local var_127_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_18.prefab_name].transform, "story_v_out_423211", "423211030", "story_v_out_423211.awb")

						arg_124_1:RecordAudio("423211030", var_127_24)
						arg_124_1:RecordAudio("423211030", var_127_24)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_423211", "423211030", "story_v_out_423211.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_423211", "423211030", "story_v_out_423211.awb")
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
				actorName = "1083",
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
	Play423211031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 423211031
		arg_128_1.duration_ = 10.03

		local var_128_0 = {
			zh = 6.866,
			ja = 10.033
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
				arg_128_0:Play423211032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = "1047"

			if arg_128_1.actors_[var_131_0] == nil then
				local var_131_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

				if not isNil(var_131_1) then
					local var_131_2 = Object.Instantiate(var_131_1, arg_128_1.canvasGo_.transform)

					var_131_2.transform:SetSiblingIndex(1)

					var_131_2.name = var_131_0
					var_131_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_128_1.actors_[var_131_0] = var_131_2

					local var_131_3 = var_131_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_128_1.isInRecall_ then
						for iter_131_0, iter_131_1 in ipairs(var_131_3) do
							iter_131_1.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_131_4 = arg_128_1.actors_["1047"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.actorSpriteComps1047 == nil then
				arg_128_1.var_.actorSpriteComps1047 = var_131_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_6 = 0.2

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.actorSpriteComps1047 then
					for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_131_3 then
							if arg_128_1.isInRecall_ then
								local var_131_8 = Mathf.Lerp(iter_131_3.color.r, arg_128_1.hightColor1.r, var_131_7)
								local var_131_9 = Mathf.Lerp(iter_131_3.color.g, arg_128_1.hightColor1.g, var_131_7)
								local var_131_10 = Mathf.Lerp(iter_131_3.color.b, arg_128_1.hightColor1.b, var_131_7)

								iter_131_3.color = Color.New(var_131_8, var_131_9, var_131_10)
							else
								local var_131_11 = Mathf.Lerp(iter_131_3.color.r, 1, var_131_7)

								iter_131_3.color = Color.New(var_131_11, var_131_11, var_131_11)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.actorSpriteComps1047 then
				for iter_131_4, iter_131_5 in pairs(arg_128_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_131_5 then
						if arg_128_1.isInRecall_ then
							iter_131_5.color = arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_131_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1047 = nil
			end

			local var_131_12 = arg_128_1.actors_["1083"]
			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 and not isNil(var_131_12) and arg_128_1.var_.actorSpriteComps1083 == nil then
				arg_128_1.var_.actorSpriteComps1083 = var_131_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_14 = 0.2

			if var_131_13 <= arg_128_1.time_ and arg_128_1.time_ < var_131_13 + var_131_14 and not isNil(var_131_12) then
				local var_131_15 = (arg_128_1.time_ - var_131_13) / var_131_14

				if arg_128_1.var_.actorSpriteComps1083 then
					for iter_131_6, iter_131_7 in pairs(arg_128_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_131_7 then
							if arg_128_1.isInRecall_ then
								local var_131_16 = Mathf.Lerp(iter_131_7.color.r, arg_128_1.hightColor2.r, var_131_15)
								local var_131_17 = Mathf.Lerp(iter_131_7.color.g, arg_128_1.hightColor2.g, var_131_15)
								local var_131_18 = Mathf.Lerp(iter_131_7.color.b, arg_128_1.hightColor2.b, var_131_15)

								iter_131_7.color = Color.New(var_131_16, var_131_17, var_131_18)
							else
								local var_131_19 = Mathf.Lerp(iter_131_7.color.r, 0.5, var_131_15)

								iter_131_7.color = Color.New(var_131_19, var_131_19, var_131_19)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= var_131_13 + var_131_14 and arg_128_1.time_ < var_131_13 + var_131_14 + arg_131_0 and not isNil(var_131_12) and arg_128_1.var_.actorSpriteComps1083 then
				for iter_131_8, iter_131_9 in pairs(arg_128_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_131_9 then
						if arg_128_1.isInRecall_ then
							iter_131_9.color = arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_131_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_128_1.var_.actorSpriteComps1083 = nil
			end

			local var_131_20 = arg_128_1.actors_["1047"].transform
			local var_131_21 = 0

			if var_131_21 < arg_128_1.time_ and arg_128_1.time_ <= var_131_21 + arg_131_0 then
				arg_128_1.var_.moveOldPos1047 = var_131_20.localPosition
				var_131_20.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1047", 4)

				local var_131_22 = var_131_20.childCount

				for iter_131_10 = 0, var_131_22 - 1 do
					local var_131_23 = var_131_20:GetChild(iter_131_10)

					if var_131_23.name == "split_2" or not string.find(var_131_23.name, "split") then
						var_131_23.gameObject:SetActive(true)
					else
						var_131_23.gameObject:SetActive(false)
					end
				end
			end

			local var_131_24 = 0.001

			if var_131_21 <= arg_128_1.time_ and arg_128_1.time_ < var_131_21 + var_131_24 then
				local var_131_25 = (arg_128_1.time_ - var_131_21) / var_131_24
				local var_131_26 = Vector3.New(483.1, -360, -319.3)

				var_131_20.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1047, var_131_26, var_131_25)
			end

			if arg_128_1.time_ >= var_131_21 + var_131_24 and arg_128_1.time_ < var_131_21 + var_131_24 + arg_131_0 then
				var_131_20.localPosition = Vector3.New(483.1, -360, -319.3)
			end

			local var_131_27 = arg_128_1.actors_["1047"]
			local var_131_28 = 0

			if var_131_28 < arg_128_1.time_ and arg_128_1.time_ <= var_131_28 + arg_131_0 then
				local var_131_29 = var_131_27:GetComponentInChildren(typeof(CanvasGroup))

				if var_131_29 then
					arg_128_1.var_.alphaOldValue1047 = var_131_29.alpha
					arg_128_1.var_.characterEffect1047 = var_131_29
				end

				arg_128_1.var_.alphaOldValue1047 = 0
			end

			local var_131_30 = 0.5

			if var_131_28 <= arg_128_1.time_ and arg_128_1.time_ < var_131_28 + var_131_30 then
				local var_131_31 = (arg_128_1.time_ - var_131_28) / var_131_30
				local var_131_32 = Mathf.Lerp(arg_128_1.var_.alphaOldValue1047, 1, var_131_31)

				if arg_128_1.var_.characterEffect1047 then
					arg_128_1.var_.characterEffect1047.alpha = var_131_32
				end
			end

			if arg_128_1.time_ >= var_131_28 + var_131_30 and arg_128_1.time_ < var_131_28 + var_131_30 + arg_131_0 and arg_128_1.var_.characterEffect1047 then
				arg_128_1.var_.characterEffect1047.alpha = 1
			end

			local var_131_33 = 0
			local var_131_34 = 0.8

			if var_131_33 < arg_128_1.time_ and arg_128_1.time_ <= var_131_33 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_35 = arg_128_1:FormatText(StoryNameCfg[1296].name)

				arg_128_1.leftNameTxt_.text = var_131_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_36 = arg_128_1:GetWordFromCfg(423211031)
				local var_131_37 = arg_128_1:FormatText(var_131_36.content)

				arg_128_1.text_.text = var_131_37

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_38 = 32
				local var_131_39 = utf8.len(var_131_37)
				local var_131_40 = var_131_38 <= 0 and var_131_34 or var_131_34 * (var_131_39 / var_131_38)

				if var_131_40 > 0 and var_131_34 < var_131_40 then
					arg_128_1.talkMaxDuration = var_131_40

					if var_131_40 + var_131_33 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_40 + var_131_33
					end
				end

				arg_128_1.text_.text = var_131_37
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211031", "story_v_out_423211.awb") ~= 0 then
					local var_131_41 = manager.audio:GetVoiceLength("story_v_out_423211", "423211031", "story_v_out_423211.awb") / 1000

					if var_131_41 + var_131_33 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_41 + var_131_33
					end

					if var_131_36.prefab_name ~= "" and arg_128_1.actors_[var_131_36.prefab_name] ~= nil then
						local var_131_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_36.prefab_name].transform, "story_v_out_423211", "423211031", "story_v_out_423211.awb")

						arg_128_1:RecordAudio("423211031", var_131_42)
						arg_128_1:RecordAudio("423211031", var_131_42)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_423211", "423211031", "story_v_out_423211.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_423211", "423211031", "story_v_out_423211.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_43 = math.max(var_131_34, arg_128_1.talkMaxDuration)

			if var_131_33 <= arg_128_1.time_ and arg_128_1.time_ < var_131_33 + var_131_43 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_33) / var_131_43

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_33 + var_131_43 and arg_128_1.time_ < var_131_33 + var_131_43 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play423211032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 423211032
		arg_132_1.duration_ = 6.77

		local var_132_0 = {
			zh = 6.1,
			ja = 6.766
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
				arg_132_0:Play423211033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1083"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1083 == nil then
				arg_132_1.var_.actorSpriteComps1083 = var_135_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_2 = 0.2

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.actorSpriteComps1083 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.actorSpriteComps1083 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_135_3 then
						if arg_132_1.isInRecall_ then
							iter_135_3.color = arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_135_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1083 = nil
			end

			local var_135_8 = arg_132_1.actors_["1047"]
			local var_135_9 = 0

			if var_135_9 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1047 == nil then
				arg_132_1.var_.actorSpriteComps1047 = var_135_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_10 = 0.2

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_10 and not isNil(var_135_8) then
				local var_135_11 = (arg_132_1.time_ - var_135_9) / var_135_10

				if arg_132_1.var_.actorSpriteComps1047 then
					for iter_135_4, iter_135_5 in pairs(arg_132_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_132_1.time_ >= var_135_9 + var_135_10 and arg_132_1.time_ < var_135_9 + var_135_10 + arg_135_0 and not isNil(var_135_8) and arg_132_1.var_.actorSpriteComps1047 then
				for iter_135_6, iter_135_7 in pairs(arg_132_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_135_7 then
						if arg_132_1.isInRecall_ then
							iter_135_7.color = arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_135_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_132_1.var_.actorSpriteComps1047 = nil
			end

			local var_135_16 = arg_132_1.actors_["1083"].transform
			local var_135_17 = 0

			if var_135_17 < arg_132_1.time_ and arg_132_1.time_ <= var_135_17 + arg_135_0 then
				arg_132_1.var_.moveOldPos1083 = var_135_16.localPosition
				var_135_16.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1083", 2)

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
				local var_135_22 = Vector3.New(-440, -345, -345)

				var_135_16.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1083, var_135_22, var_135_21)
			end

			if arg_132_1.time_ >= var_135_17 + var_135_20 and arg_132_1.time_ < var_135_17 + var_135_20 + arg_135_0 then
				var_135_16.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_135_23 = 0
			local var_135_24 = 0.6

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_25 = arg_132_1:FormatText(StoryNameCfg[1332].name)

				arg_132_1.leftNameTxt_.text = var_135_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_26 = arg_132_1:GetWordFromCfg(423211032)
				local var_135_27 = arg_132_1:FormatText(var_135_26.content)

				arg_132_1.text_.text = var_135_27

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_28 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211032", "story_v_out_423211.awb") ~= 0 then
					local var_135_31 = manager.audio:GetVoiceLength("story_v_out_423211", "423211032", "story_v_out_423211.awb") / 1000

					if var_135_31 + var_135_23 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_31 + var_135_23
					end

					if var_135_26.prefab_name ~= "" and arg_132_1.actors_[var_135_26.prefab_name] ~= nil then
						local var_135_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_26.prefab_name].transform, "story_v_out_423211", "423211032", "story_v_out_423211.awb")

						arg_132_1:RecordAudio("423211032", var_135_32)
						arg_132_1:RecordAudio("423211032", var_135_32)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_423211", "423211032", "story_v_out_423211.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_423211", "423211032", "story_v_out_423211.awb")
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
				actorName = "1083",
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
	Play423211033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 423211033
		arg_136_1.duration_ = 10.17

		local var_136_0 = {
			zh = 5.266,
			ja = 10.166
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
				arg_136_0:Play423211034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1047"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1047 == nil then
				arg_136_1.var_.actorSpriteComps1047 = var_139_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_2 = 0.2

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.actorSpriteComps1047 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.actorSpriteComps1047 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_139_3 then
						if arg_136_1.isInRecall_ then
							iter_139_3.color = arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_139_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps1047 = nil
			end

			local var_139_8 = arg_136_1.actors_["1083"]
			local var_139_9 = 0

			if var_139_9 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps1083 == nil then
				arg_136_1.var_.actorSpriteComps1083 = var_139_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_10 = 0.2

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 and not isNil(var_139_8) then
				local var_139_11 = (arg_136_1.time_ - var_139_9) / var_139_10

				if arg_136_1.var_.actorSpriteComps1083 then
					for iter_139_4, iter_139_5 in pairs(arg_136_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 and not isNil(var_139_8) and arg_136_1.var_.actorSpriteComps1083 then
				for iter_139_6, iter_139_7 in pairs(arg_136_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_139_7 then
						if arg_136_1.isInRecall_ then
							iter_139_7.color = arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_139_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_136_1.var_.actorSpriteComps1083 = nil
			end

			local var_139_16 = arg_136_1.actors_["1047"].transform
			local var_139_17 = 0

			if var_139_17 < arg_136_1.time_ and arg_136_1.time_ <= var_139_17 + arg_139_0 then
				arg_136_1.var_.moveOldPos1047 = var_139_16.localPosition
				var_139_16.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1047", 4)

				local var_139_18 = var_139_16.childCount

				for iter_139_8 = 0, var_139_18 - 1 do
					local var_139_19 = var_139_16:GetChild(iter_139_8)

					if var_139_19.name == "split_7" or not string.find(var_139_19.name, "split") then
						var_139_19.gameObject:SetActive(true)
					else
						var_139_19.gameObject:SetActive(false)
					end
				end
			end

			local var_139_20 = 0.001

			if var_139_17 <= arg_136_1.time_ and arg_136_1.time_ < var_139_17 + var_139_20 then
				local var_139_21 = (arg_136_1.time_ - var_139_17) / var_139_20
				local var_139_22 = Vector3.New(483.1, -360, -319.3)

				var_139_16.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1047, var_139_22, var_139_21)
			end

			if arg_136_1.time_ >= var_139_17 + var_139_20 and arg_136_1.time_ < var_139_17 + var_139_20 + arg_139_0 then
				var_139_16.localPosition = Vector3.New(483.1, -360, -319.3)
			end

			local var_139_23 = 0
			local var_139_24 = 0.825

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_25 = arg_136_1:FormatText(StoryNameCfg[1296].name)

				arg_136_1.leftNameTxt_.text = var_139_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_26 = arg_136_1:GetWordFromCfg(423211033)
				local var_139_27 = arg_136_1:FormatText(var_139_26.content)

				arg_136_1.text_.text = var_139_27

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_28 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211033", "story_v_out_423211.awb") ~= 0 then
					local var_139_31 = manager.audio:GetVoiceLength("story_v_out_423211", "423211033", "story_v_out_423211.awb") / 1000

					if var_139_31 + var_139_23 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_31 + var_139_23
					end

					if var_139_26.prefab_name ~= "" and arg_136_1.actors_[var_139_26.prefab_name] ~= nil then
						local var_139_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_26.prefab_name].transform, "story_v_out_423211", "423211033", "story_v_out_423211.awb")

						arg_136_1:RecordAudio("423211033", var_139_32)
						arg_136_1:RecordAudio("423211033", var_139_32)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_423211", "423211033", "story_v_out_423211.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_423211", "423211033", "story_v_out_423211.awb")
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
				actorName = "1047",
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
	Play423211034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 423211034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play423211035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1047"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1047 == nil then
				arg_140_1.var_.actorSpriteComps1047 = var_143_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_2 = 0.2

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.actorSpriteComps1047 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.actorSpriteComps1047 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_143_3 then
						if arg_140_1.isInRecall_ then
							iter_143_3.color = arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_143_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_140_1.var_.actorSpriteComps1047 = nil
			end

			local var_143_8 = arg_140_1.actors_["1047"].transform
			local var_143_9 = 0

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.var_.moveOldPos1047 = var_143_8.localPosition
				var_143_8.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1047", 7)

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

				var_143_8.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1047, var_143_14, var_143_13)
			end

			if arg_140_1.time_ >= var_143_9 + var_143_12 and arg_140_1.time_ < var_143_9 + var_143_12 + arg_143_0 then
				var_143_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_15 = arg_140_1.actors_["1083"].transform
			local var_143_16 = 0

			if var_143_16 < arg_140_1.time_ and arg_140_1.time_ <= var_143_16 + arg_143_0 then
				arg_140_1.var_.moveOldPos1083 = var_143_15.localPosition
				var_143_15.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1083", 7)

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

				var_143_15.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1083, var_143_21, var_143_20)
			end

			if arg_140_1.time_ >= var_143_16 + var_143_19 and arg_140_1.time_ < var_143_16 + var_143_19 + arg_143_0 then
				var_143_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_143_22 = 0.833333333333333
			local var_143_23 = 1

			if var_143_22 < arg_140_1.time_ and arg_140_1.time_ <= var_143_22 + arg_143_0 then
				local var_143_24 = "play"
				local var_143_25 = "effect"

				arg_140_1:AudioAction(var_143_24, var_143_25, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_143_26 = 0
			local var_143_27 = 1.2

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

				local var_143_28 = arg_140_1:GetWordFromCfg(423211034)
				local var_143_29 = arg_140_1:FormatText(var_143_28.content)

				arg_140_1.text_.text = var_143_29

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_30 = 48
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
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_140_1:InitPlayNodeList()
	end,
	Play423211035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 423211035
		arg_144_1.duration_ = 9

		local var_144_0 = {
			zh = 7.433,
			ja = 9
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
				arg_144_0:Play423211036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1047"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1047 == nil then
				arg_144_1.var_.actorSpriteComps1047 = var_147_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_2 = 0.2

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.actorSpriteComps1047 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.actorSpriteComps1047 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_147_3 then
						if arg_144_1.isInRecall_ then
							iter_147_3.color = arg_144_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_147_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_144_1.var_.actorSpriteComps1047 = nil
			end

			local var_147_8 = arg_144_1.actors_["1047"].transform
			local var_147_9 = 0

			if var_147_9 < arg_144_1.time_ and arg_144_1.time_ <= var_147_9 + arg_147_0 then
				arg_144_1.var_.moveOldPos1047 = var_147_8.localPosition
				var_147_8.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1047", 3)

				local var_147_10 = var_147_8.childCount

				for iter_147_4 = 0, var_147_10 - 1 do
					local var_147_11 = var_147_8:GetChild(iter_147_4)

					if var_147_11.name == "" or not string.find(var_147_11.name, "split") then
						var_147_11.gameObject:SetActive(true)
					else
						var_147_11.gameObject:SetActive(false)
					end
				end
			end

			local var_147_12 = 0.001

			if var_147_9 <= arg_144_1.time_ and arg_144_1.time_ < var_147_9 + var_147_12 then
				local var_147_13 = (arg_144_1.time_ - var_147_9) / var_147_12
				local var_147_14 = Vector3.New(-38.9, -360, -319.3)

				var_147_8.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1047, var_147_14, var_147_13)
			end

			if arg_144_1.time_ >= var_147_9 + var_147_12 and arg_144_1.time_ < var_147_9 + var_147_12 + arg_147_0 then
				var_147_8.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_147_15 = 0
			local var_147_16 = 0.875

			if var_147_15 < arg_144_1.time_ and arg_144_1.time_ <= var_147_15 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_17 = arg_144_1:FormatText(StoryNameCfg[1296].name)

				arg_144_1.leftNameTxt_.text = var_147_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_18 = arg_144_1:GetWordFromCfg(423211035)
				local var_147_19 = arg_144_1:FormatText(var_147_18.content)

				arg_144_1.text_.text = var_147_19

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_20 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211035", "story_v_out_423211.awb") ~= 0 then
					local var_147_23 = manager.audio:GetVoiceLength("story_v_out_423211", "423211035", "story_v_out_423211.awb") / 1000

					if var_147_23 + var_147_15 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_23 + var_147_15
					end

					if var_147_18.prefab_name ~= "" and arg_144_1.actors_[var_147_18.prefab_name] ~= nil then
						local var_147_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_18.prefab_name].transform, "story_v_out_423211", "423211035", "story_v_out_423211.awb")

						arg_144_1:RecordAudio("423211035", var_147_24)
						arg_144_1:RecordAudio("423211035", var_147_24)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_423211", "423211035", "story_v_out_423211.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_423211", "423211035", "story_v_out_423211.awb")
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
				actorName = "1047",
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
	Play423211036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 423211036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play423211037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1047"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1047 == nil then
				arg_148_1.var_.actorSpriteComps1047 = var_151_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_2 = 0.2

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.actorSpriteComps1047 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.actorSpriteComps1047 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_151_3 then
						if arg_148_1.isInRecall_ then
							iter_151_3.color = arg_148_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_151_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_148_1.var_.actorSpriteComps1047 = nil
			end

			local var_151_8 = 0
			local var_151_9 = 0.825

			if var_151_8 < arg_148_1.time_ and arg_148_1.time_ <= var_151_8 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_10 = arg_148_1:FormatText(StoryNameCfg[7].name)

				arg_148_1.leftNameTxt_.text = var_151_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_11 = arg_148_1:GetWordFromCfg(423211036)
				local var_151_12 = arg_148_1:FormatText(var_151_11.content)

				arg_148_1.text_.text = var_151_12

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 33
				local var_151_14 = utf8.len(var_151_12)
				local var_151_15 = var_151_13 <= 0 and var_151_9 or var_151_9 * (var_151_14 / var_151_13)

				if var_151_15 > 0 and var_151_9 < var_151_15 then
					arg_148_1.talkMaxDuration = var_151_15

					if var_151_15 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_15 + var_151_8
					end
				end

				arg_148_1.text_.text = var_151_12
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_9, arg_148_1.talkMaxDuration)

			if var_151_8 <= arg_148_1.time_ and arg_148_1.time_ < var_151_8 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_8) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_8 + var_151_16 and arg_148_1.time_ < var_151_8 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play423211037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 423211037
		arg_152_1.duration_ = 13.6

		local var_152_0 = {
			zh = 7.066,
			ja = 13.6
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
				arg_152_0:Play423211038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1047"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1047 == nil then
				arg_152_1.var_.actorSpriteComps1047 = var_155_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_2 = 0.2

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.actorSpriteComps1047 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.actorSpriteComps1047 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_155_3 then
						if arg_152_1.isInRecall_ then
							iter_155_3.color = arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_155_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_152_1.var_.actorSpriteComps1047 = nil
			end

			local var_155_8 = arg_152_1.actors_["1047"].transform
			local var_155_9 = 0

			if var_155_9 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.var_.moveOldPos1047 = var_155_8.localPosition
				var_155_8.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1047", 3)

				local var_155_10 = var_155_8.childCount

				for iter_155_4 = 0, var_155_10 - 1 do
					local var_155_11 = var_155_8:GetChild(iter_155_4)

					if var_155_11.name == "split_2" or not string.find(var_155_11.name, "split") then
						var_155_11.gameObject:SetActive(true)
					else
						var_155_11.gameObject:SetActive(false)
					end
				end
			end

			local var_155_12 = 0.001

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_12 then
				local var_155_13 = (arg_152_1.time_ - var_155_9) / var_155_12
				local var_155_14 = Vector3.New(-38.9, -360, -319.3)

				var_155_8.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1047, var_155_14, var_155_13)
			end

			if arg_152_1.time_ >= var_155_9 + var_155_12 and arg_152_1.time_ < var_155_9 + var_155_12 + arg_155_0 then
				var_155_8.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_155_15 = 0
			local var_155_16 = 0.8

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_17 = arg_152_1:FormatText(StoryNameCfg[1296].name)

				arg_152_1.leftNameTxt_.text = var_155_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_18 = arg_152_1:GetWordFromCfg(423211037)
				local var_155_19 = arg_152_1:FormatText(var_155_18.content)

				arg_152_1.text_.text = var_155_19

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_20 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211037", "story_v_out_423211.awb") ~= 0 then
					local var_155_23 = manager.audio:GetVoiceLength("story_v_out_423211", "423211037", "story_v_out_423211.awb") / 1000

					if var_155_23 + var_155_15 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_23 + var_155_15
					end

					if var_155_18.prefab_name ~= "" and arg_152_1.actors_[var_155_18.prefab_name] ~= nil then
						local var_155_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_18.prefab_name].transform, "story_v_out_423211", "423211037", "story_v_out_423211.awb")

						arg_152_1:RecordAudio("423211037", var_155_24)
						arg_152_1:RecordAudio("423211037", var_155_24)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_423211", "423211037", "story_v_out_423211.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_423211", "423211037", "story_v_out_423211.awb")
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
				actorName = "1047",
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
	Play423211038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 423211038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play423211039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1047"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1047 == nil then
				arg_156_1.var_.actorSpriteComps1047 = var_159_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_2 = 0.2

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.actorSpriteComps1047 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								local var_159_4 = Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, var_159_3)
								local var_159_5 = Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, var_159_3)
								local var_159_6 = Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, var_159_3)

								iter_159_1.color = Color.New(var_159_4, var_159_5, var_159_6)
							else
								local var_159_7 = Mathf.Lerp(iter_159_1.color.r, 0.5, var_159_3)

								iter_159_1.color = Color.New(var_159_7, var_159_7, var_159_7)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.actorSpriteComps1047 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_159_3 then
						if arg_156_1.isInRecall_ then
							iter_159_3.color = arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_159_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_156_1.var_.actorSpriteComps1047 = nil
			end

			local var_159_8 = 0
			local var_159_9 = 0.575

			if var_159_8 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_10 = arg_156_1:FormatText(StoryNameCfg[7].name)

				arg_156_1.leftNameTxt_.text = var_159_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_11 = arg_156_1:GetWordFromCfg(423211038)
				local var_159_12 = arg_156_1:FormatText(var_159_11.content)

				arg_156_1.text_.text = var_159_12

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_13 = 23
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
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_16 = math.max(var_159_9, arg_156_1.talkMaxDuration)

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_16 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_8) / var_159_16

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_8 + var_159_16 and arg_156_1.time_ < var_159_8 + var_159_16 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play423211039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 423211039
		arg_160_1.duration_ = 18.8

		local var_160_0 = {
			zh = 10.933,
			ja = 18.8
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
				arg_160_0:Play423211040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1047"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1047 == nil then
				arg_160_1.var_.actorSpriteComps1047 = var_163_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_2 = 0.2

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.actorSpriteComps1047 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.actorSpriteComps1047 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_163_3 then
						if arg_160_1.isInRecall_ then
							iter_163_3.color = arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_163_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_160_1.var_.actorSpriteComps1047 = nil
			end

			local var_163_8 = arg_160_1.actors_["1047"].transform
			local var_163_9 = 0

			if var_163_9 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.var_.moveOldPos1047 = var_163_8.localPosition
				var_163_8.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("1047", 3)

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
				local var_163_14 = Vector3.New(-38.9, -360, -319.3)

				var_163_8.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1047, var_163_14, var_163_13)
			end

			if arg_160_1.time_ >= var_163_9 + var_163_12 and arg_160_1.time_ < var_163_9 + var_163_12 + arg_163_0 then
				var_163_8.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_163_15 = 0
			local var_163_16 = 1.275

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_17 = arg_160_1:FormatText(StoryNameCfg[1296].name)

				arg_160_1.leftNameTxt_.text = var_163_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_18 = arg_160_1:GetWordFromCfg(423211039)
				local var_163_19 = arg_160_1:FormatText(var_163_18.content)

				arg_160_1.text_.text = var_163_19

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_20 = 51
				local var_163_21 = utf8.len(var_163_19)
				local var_163_22 = var_163_20 <= 0 and var_163_16 or var_163_16 * (var_163_21 / var_163_20)

				if var_163_22 > 0 and var_163_16 < var_163_22 then
					arg_160_1.talkMaxDuration = var_163_22

					if var_163_22 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_22 + var_163_15
					end
				end

				arg_160_1.text_.text = var_163_19
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211039", "story_v_out_423211.awb") ~= 0 then
					local var_163_23 = manager.audio:GetVoiceLength("story_v_out_423211", "423211039", "story_v_out_423211.awb") / 1000

					if var_163_23 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_23 + var_163_15
					end

					if var_163_18.prefab_name ~= "" and arg_160_1.actors_[var_163_18.prefab_name] ~= nil then
						local var_163_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_18.prefab_name].transform, "story_v_out_423211", "423211039", "story_v_out_423211.awb")

						arg_160_1:RecordAudio("423211039", var_163_24)
						arg_160_1:RecordAudio("423211039", var_163_24)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_423211", "423211039", "story_v_out_423211.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_423211", "423211039", "story_v_out_423211.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_25 = math.max(var_163_16, arg_160_1.talkMaxDuration)

			if var_163_15 <= arg_160_1.time_ and arg_160_1.time_ < var_163_15 + var_163_25 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_15) / var_163_25

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_15 + var_163_25 and arg_160_1.time_ < var_163_15 + var_163_25 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play423211040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 423211040
		arg_164_1.duration_ = 7.17

		local var_164_0 = {
			zh = 5.133,
			ja = 7.166
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
				arg_164_0:Play423211041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1047"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1047 = var_167_0.localPosition
				var_167_0.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("1047", 3)

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
				local var_167_6 = Vector3.New(-38.9, -360, -319.3)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1047, var_167_6, var_167_5)
			end

			if arg_164_1.time_ >= var_167_1 + var_167_4 and arg_164_1.time_ < var_167_1 + var_167_4 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_167_7 = 0
			local var_167_8 = 0.675

			if var_167_7 < arg_164_1.time_ and arg_164_1.time_ <= var_167_7 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_9 = arg_164_1:FormatText(StoryNameCfg[1296].name)

				arg_164_1.leftNameTxt_.text = var_167_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_10 = arg_164_1:GetWordFromCfg(423211040)
				local var_167_11 = arg_164_1:FormatText(var_167_10.content)

				arg_164_1.text_.text = var_167_11

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_12 = 27
				local var_167_13 = utf8.len(var_167_11)
				local var_167_14 = var_167_12 <= 0 and var_167_8 or var_167_8 * (var_167_13 / var_167_12)

				if var_167_14 > 0 and var_167_8 < var_167_14 then
					arg_164_1.talkMaxDuration = var_167_14

					if var_167_14 + var_167_7 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_14 + var_167_7
					end
				end

				arg_164_1.text_.text = var_167_11
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211040", "story_v_out_423211.awb") ~= 0 then
					local var_167_15 = manager.audio:GetVoiceLength("story_v_out_423211", "423211040", "story_v_out_423211.awb") / 1000

					if var_167_15 + var_167_7 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_15 + var_167_7
					end

					if var_167_10.prefab_name ~= "" and arg_164_1.actors_[var_167_10.prefab_name] ~= nil then
						local var_167_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_10.prefab_name].transform, "story_v_out_423211", "423211040", "story_v_out_423211.awb")

						arg_164_1:RecordAudio("423211040", var_167_16)
						arg_164_1:RecordAudio("423211040", var_167_16)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_423211", "423211040", "story_v_out_423211.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_423211", "423211040", "story_v_out_423211.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_17 = math.max(var_167_8, arg_164_1.talkMaxDuration)

			if var_167_7 <= arg_164_1.time_ and arg_164_1.time_ < var_167_7 + var_167_17 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_7) / var_167_17

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_7 + var_167_17 and arg_164_1.time_ < var_167_7 + var_167_17 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play423211041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 423211041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play423211042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1047"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1047 == nil then
				arg_168_1.var_.actorSpriteComps1047 = var_171_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.actorSpriteComps1047 then
					for iter_171_0, iter_171_1 in pairs(arg_168_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.actorSpriteComps1047 then
				for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_171_3 then
						if arg_168_1.isInRecall_ then
							iter_171_3.color = arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_171_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps1047 = nil
			end

			local var_171_8 = 0
			local var_171_9 = 0.55

			if var_171_8 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_10 = arg_168_1:FormatText(StoryNameCfg[7].name)

				arg_168_1.leftNameTxt_.text = var_171_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_11 = arg_168_1:GetWordFromCfg(423211041)
				local var_171_12 = arg_168_1:FormatText(var_171_11.content)

				arg_168_1.text_.text = var_171_12

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_13 = 22
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
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_16 = math.max(var_171_9, arg_168_1.talkMaxDuration)

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_8) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_8 + var_171_16 and arg_168_1.time_ < var_171_8 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play423211042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 423211042
		arg_172_1.duration_ = 7.9

		local var_172_0 = {
			zh = 6.666,
			ja = 7.9
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
				arg_172_0:Play423211043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1047"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1047 == nil then
				arg_172_1.var_.actorSpriteComps1047 = var_175_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_2 = 0.2

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.actorSpriteComps1047 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.actorSpriteComps1047 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_175_3 then
						if arg_172_1.isInRecall_ then
							iter_175_3.color = arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_175_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_172_1.var_.actorSpriteComps1047 = nil
			end

			local var_175_8 = arg_172_1.actors_["1047"].transform
			local var_175_9 = 0

			if var_175_9 < arg_172_1.time_ and arg_172_1.time_ <= var_175_9 + arg_175_0 then
				arg_172_1.var_.moveOldPos1047 = var_175_8.localPosition
				var_175_8.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("1047", 3)

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
				local var_175_14 = Vector3.New(-38.9, -360, -319.3)

				var_175_8.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1047, var_175_14, var_175_13)
			end

			if arg_172_1.time_ >= var_175_9 + var_175_12 and arg_172_1.time_ < var_175_9 + var_175_12 + arg_175_0 then
				var_175_8.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_175_15 = 0
			local var_175_16 = 0.725

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_17 = arg_172_1:FormatText(StoryNameCfg[1296].name)

				arg_172_1.leftNameTxt_.text = var_175_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_18 = arg_172_1:GetWordFromCfg(423211042)
				local var_175_19 = arg_172_1:FormatText(var_175_18.content)

				arg_172_1.text_.text = var_175_19

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_20 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211042", "story_v_out_423211.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_out_423211", "423211042", "story_v_out_423211.awb") / 1000

					if var_175_23 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_15
					end

					if var_175_18.prefab_name ~= "" and arg_172_1.actors_[var_175_18.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_18.prefab_name].transform, "story_v_out_423211", "423211042", "story_v_out_423211.awb")

						arg_172_1:RecordAudio("423211042", var_175_24)
						arg_172_1:RecordAudio("423211042", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_423211", "423211042", "story_v_out_423211.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_423211", "423211042", "story_v_out_423211.awb")
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
				actorName = "1047",
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
	Play423211043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 423211043
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play423211044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1047"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1047 == nil then
				arg_176_1.var_.actorSpriteComps1047 = var_179_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_2 = 0.2

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.actorSpriteComps1047 then
					for iter_179_0, iter_179_1 in pairs(arg_176_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.actorSpriteComps1047 then
				for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_179_3 then
						if arg_176_1.isInRecall_ then
							iter_179_3.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps1047 = nil
			end

			local var_179_8 = 0
			local var_179_9 = 0.65

			if var_179_8 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_10 = arg_176_1:FormatText(StoryNameCfg[7].name)

				arg_176_1.leftNameTxt_.text = var_179_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_11 = arg_176_1:GetWordFromCfg(423211043)
				local var_179_12 = arg_176_1:FormatText(var_179_11.content)

				arg_176_1.text_.text = var_179_12

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_13 = 26
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
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_9, arg_176_1.talkMaxDuration)

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_8) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_8 + var_179_16 and arg_176_1.time_ < var_179_8 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play423211044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 423211044
		arg_180_1.duration_ = 8.17

		local var_180_0 = {
			zh = 5.4,
			ja = 8.166
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
				arg_180_0:Play423211045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1047"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1047 == nil then
				arg_180_1.var_.actorSpriteComps1047 = var_183_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_2 = 0.2

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.actorSpriteComps1047 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.actorSpriteComps1047 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_183_3 then
						if arg_180_1.isInRecall_ then
							iter_183_3.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps1047 = nil
			end

			local var_183_8 = arg_180_1.actors_["1047"].transform
			local var_183_9 = 0

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 then
				arg_180_1.var_.moveOldPos1047 = var_183_8.localPosition
				var_183_8.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1047", 3)

				local var_183_10 = var_183_8.childCount

				for iter_183_4 = 0, var_183_10 - 1 do
					local var_183_11 = var_183_8:GetChild(iter_183_4)

					if var_183_11.name == "" or not string.find(var_183_11.name, "split") then
						var_183_11.gameObject:SetActive(true)
					else
						var_183_11.gameObject:SetActive(false)
					end
				end
			end

			local var_183_12 = 0.001

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_12 then
				local var_183_13 = (arg_180_1.time_ - var_183_9) / var_183_12
				local var_183_14 = Vector3.New(-38.9, -360, -319.3)

				var_183_8.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1047, var_183_14, var_183_13)
			end

			if arg_180_1.time_ >= var_183_9 + var_183_12 and arg_180_1.time_ < var_183_9 + var_183_12 + arg_183_0 then
				var_183_8.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_183_15 = 0
			local var_183_16 = 0.6

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_17 = arg_180_1:FormatText(StoryNameCfg[1296].name)

				arg_180_1.leftNameTxt_.text = var_183_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_18 = arg_180_1:GetWordFromCfg(423211044)
				local var_183_19 = arg_180_1:FormatText(var_183_18.content)

				arg_180_1.text_.text = var_183_19

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_20 = 24
				local var_183_21 = utf8.len(var_183_19)
				local var_183_22 = var_183_20 <= 0 and var_183_16 or var_183_16 * (var_183_21 / var_183_20)

				if var_183_22 > 0 and var_183_16 < var_183_22 then
					arg_180_1.talkMaxDuration = var_183_22

					if var_183_22 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_22 + var_183_15
					end
				end

				arg_180_1.text_.text = var_183_19
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211044", "story_v_out_423211.awb") ~= 0 then
					local var_183_23 = manager.audio:GetVoiceLength("story_v_out_423211", "423211044", "story_v_out_423211.awb") / 1000

					if var_183_23 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_15
					end

					if var_183_18.prefab_name ~= "" and arg_180_1.actors_[var_183_18.prefab_name] ~= nil then
						local var_183_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_18.prefab_name].transform, "story_v_out_423211", "423211044", "story_v_out_423211.awb")

						arg_180_1:RecordAudio("423211044", var_183_24)
						arg_180_1:RecordAudio("423211044", var_183_24)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_423211", "423211044", "story_v_out_423211.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_423211", "423211044", "story_v_out_423211.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_25 = math.max(var_183_16, arg_180_1.talkMaxDuration)

			if var_183_15 <= arg_180_1.time_ and arg_180_1.time_ < var_183_15 + var_183_25 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_15) / var_183_25

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_15 + var_183_25 and arg_180_1.time_ < var_183_15 + var_183_25 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play423211045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 423211045
		arg_184_1.duration_ = 10.73

		local var_184_0 = {
			zh = 7.733,
			ja = 10.733
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
				arg_184_0:Play423211046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.975

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[1296].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_3 = arg_184_1:GetWordFromCfg(423211045)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211045", "story_v_out_423211.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_423211", "423211045", "story_v_out_423211.awb") / 1000

					if var_187_8 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_0
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_423211", "423211045", "story_v_out_423211.awb")

						arg_184_1:RecordAudio("423211045", var_187_9)
						arg_184_1:RecordAudio("423211045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_423211", "423211045", "story_v_out_423211.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_423211", "423211045", "story_v_out_423211.awb")
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
	Play423211046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 423211046
		arg_188_1.duration_ = 5.2

		local var_188_0 = {
			zh = 3.566,
			ja = 5.2
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
				arg_188_0:Play423211047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1047"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1047 = var_191_0.localPosition
				var_191_0.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1047", 3)

				local var_191_2 = var_191_0.childCount

				for iter_191_0 = 0, var_191_2 - 1 do
					local var_191_3 = var_191_0:GetChild(iter_191_0)

					if var_191_3.name == "" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_4 then
				local var_191_5 = (arg_188_1.time_ - var_191_1) / var_191_4
				local var_191_6 = Vector3.New(-38.9, -360, -319.3)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1047, var_191_6, var_191_5)
			end

			if arg_188_1.time_ >= var_191_1 + var_191_4 and arg_188_1.time_ < var_191_1 + var_191_4 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_191_7 = 0
			local var_191_8 = 0.55

			if var_191_7 < arg_188_1.time_ and arg_188_1.time_ <= var_191_7 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_9 = arg_188_1:FormatText(StoryNameCfg[1296].name)

				arg_188_1.leftNameTxt_.text = var_191_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_10 = arg_188_1:GetWordFromCfg(423211046)
				local var_191_11 = arg_188_1:FormatText(var_191_10.content)

				arg_188_1.text_.text = var_191_11

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_12 = 22
				local var_191_13 = utf8.len(var_191_11)
				local var_191_14 = var_191_12 <= 0 and var_191_8 or var_191_8 * (var_191_13 / var_191_12)

				if var_191_14 > 0 and var_191_8 < var_191_14 then
					arg_188_1.talkMaxDuration = var_191_14

					if var_191_14 + var_191_7 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_7
					end
				end

				arg_188_1.text_.text = var_191_11
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211046", "story_v_out_423211.awb") ~= 0 then
					local var_191_15 = manager.audio:GetVoiceLength("story_v_out_423211", "423211046", "story_v_out_423211.awb") / 1000

					if var_191_15 + var_191_7 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_15 + var_191_7
					end

					if var_191_10.prefab_name ~= "" and arg_188_1.actors_[var_191_10.prefab_name] ~= nil then
						local var_191_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_10.prefab_name].transform, "story_v_out_423211", "423211046", "story_v_out_423211.awb")

						arg_188_1:RecordAudio("423211046", var_191_16)
						arg_188_1:RecordAudio("423211046", var_191_16)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_423211", "423211046", "story_v_out_423211.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_423211", "423211046", "story_v_out_423211.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_17 = math.max(var_191_8, arg_188_1.talkMaxDuration)

			if var_191_7 <= arg_188_1.time_ and arg_188_1.time_ < var_191_7 + var_191_17 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_7) / var_191_17

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_7 + var_191_17 and arg_188_1.time_ < var_191_7 + var_191_17 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play423211047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 423211047
		arg_192_1.duration_ = 1.6

		local var_192_0 = {
			zh = 1.6,
			ja = 1.166
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
			arg_192_1.auto_ = false
		end

		function arg_192_1.playNext_(arg_194_0)
			arg_192_1.onStoryFinished_()
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1047"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos1047 = var_195_0.localPosition
				var_195_0.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("1047", 3)

				local var_195_2 = var_195_0.childCount

				for iter_195_0 = 0, var_195_2 - 1 do
					local var_195_3 = var_195_0:GetChild(iter_195_0)

					if var_195_3.name == "split_7" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_4 then
				local var_195_5 = (arg_192_1.time_ - var_195_1) / var_195_4
				local var_195_6 = Vector3.New(-38.9, -360, -319.3)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1047, var_195_6, var_195_5)
			end

			if arg_192_1.time_ >= var_195_1 + var_195_4 and arg_192_1.time_ < var_195_1 + var_195_4 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_195_7 = 0
			local var_195_8 = 0.125

			if var_195_7 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_9 = arg_192_1:FormatText(StoryNameCfg[1296].name)

				arg_192_1.leftNameTxt_.text = var_195_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_10 = arg_192_1:GetWordFromCfg(423211047)
				local var_195_11 = arg_192_1:FormatText(var_195_10.content)

				arg_192_1.text_.text = var_195_11

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_12 = 5
				local var_195_13 = utf8.len(var_195_11)
				local var_195_14 = var_195_12 <= 0 and var_195_8 or var_195_8 * (var_195_13 / var_195_12)

				if var_195_14 > 0 and var_195_8 < var_195_14 then
					arg_192_1.talkMaxDuration = var_195_14

					if var_195_14 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_14 + var_195_7
					end
				end

				arg_192_1.text_.text = var_195_11
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423211", "423211047", "story_v_out_423211.awb") ~= 0 then
					local var_195_15 = manager.audio:GetVoiceLength("story_v_out_423211", "423211047", "story_v_out_423211.awb") / 1000

					if var_195_15 + var_195_7 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_15 + var_195_7
					end

					if var_195_10.prefab_name ~= "" and arg_192_1.actors_[var_195_10.prefab_name] ~= nil then
						local var_195_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_10.prefab_name].transform, "story_v_out_423211", "423211047", "story_v_out_423211.awb")

						arg_192_1:RecordAudio("423211047", var_195_16)
						arg_192_1:RecordAudio("423211047", var_195_16)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_423211", "423211047", "story_v_out_423211.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_423211", "423211047", "story_v_out_423211.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_17 = math.max(var_195_8, arg_192_1.talkMaxDuration)

			if var_195_7 <= arg_192_1.time_ and arg_192_1.time_ < var_195_7 + var_195_17 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_7) / var_195_17

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_7 + var_195_17 and arg_192_1.time_ < var_195_7 + var_195_17 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	assets = {
		"TextureConfig/Background/I25f",
		"TextureConfig/Background/ST08"
	},
	voices = {
		"story_v_out_423211.awb"
	}
}
