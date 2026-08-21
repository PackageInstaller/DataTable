return {
	Play926041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926041001
		arg_1_1.duration_ = 9.33

		local var_1_0 = {
			zh = 6.733,
			ja = 9.333
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
				arg_1_0:Play926041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I22f"

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
				local var_4_5 = arg_1_1.bgs_.I22f

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
					if iter_4_0 ~= "I22f" then
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

			local var_4_24 = "128404"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

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

			local var_4_28 = arg_1_1.actors_["128404"]
			local var_4_29 = 1.46666666666667

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps128404 == nil then
				arg_1_1.var_.actorSpriteComps128404 = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps128404 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps128404 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps128404 = nil
			end

			local var_4_36 = arg_1_1.actors_["128404"].transform
			local var_4_37 = 1.46666666666667

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos128404 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("128404", 3)

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
				local var_4_42 = Vector3.New(-16.1, -362, -375)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos128404, var_4_42, var_4_41)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_40 and arg_1_1.time_ < var_4_37 + var_4_40 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_4_43 = arg_1_1.actors_["128404"]
			local var_4_44 = 1.46666666666667

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue128404 = var_4_45.alpha
					arg_1_1.var_.characterEffect128404 = var_4_45
				end

				arg_1_1.var_.alphaOldValue128404 = 0
			end

			local var_4_46 = 0.366666666666667

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue128404, 1, var_4_47)

				if arg_1_1.var_.characterEffect128404 then
					arg_1_1.var_.characterEffect128404.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect128404 then
				arg_1_1.var_.characterEffect128404.alpha = 1
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

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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

				arg_1_1:AudioAction(var_4_63, var_4_64, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_65 = 2
			local var_4_66 = 0.6

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

				local var_4_68 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_68

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_69 = arg_1_1:GetWordFromCfg(926041001)
				local var_4_70 = arg_1_1:FormatText(var_4_69.content)

				arg_1_1.text_.text = var_4_70

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_71 = 24
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

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041001", "story_v_out_926041.awb") ~= 0 then
					local var_4_74 = manager.audio:GetVoiceLength("story_v_out_926041", "926041001", "story_v_out_926041.awb") / 1000

					if var_4_74 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_65
					end

					if var_4_69.prefab_name ~= "" and arg_1_1.actors_[var_4_69.prefab_name] ~= nil then
						local var_4_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_69.prefab_name].transform, "story_v_out_926041", "926041001", "story_v_out_926041.awb")

						arg_1_1:RecordAudio("926041001", var_4_75)
						arg_1_1:RecordAudio("926041001", var_4_75)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926041", "926041001", "story_v_out_926041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926041", "926041001", "story_v_out_926041.awb")
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926041002
		arg_9_1.duration_ = 6.17

		local var_9_0 = {
			zh = 4.533,
			ja = 6.166
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
				arg_9_0:Play926041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10144"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(var_12_1, arg_9_1.canvasGo_.transform)

					var_12_2.transform:SetSiblingIndex(1)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs(var_12_3) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_4 = arg_9_1.actors_["10144"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps10144 == nil then
				arg_9_1.var_.actorSpriteComps10144 = var_12_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 and not isNil(var_12_4) then
				local var_12_7 = (arg_9_1.time_ - var_12_5) / var_12_6

				if arg_9_1.var_.actorSpriteComps10144 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								local var_12_8 = Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, var_12_7)
								local var_12_9 = Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, var_12_7)
								local var_12_10 = Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, var_12_7)

								iter_12_3.color = Color.New(var_12_8, var_12_9, var_12_10)
							else
								local var_12_11 = Mathf.Lerp(iter_12_3.color.r, 1, var_12_7)

								iter_12_3.color = Color.New(var_12_11, var_12_11, var_12_11)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps10144 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_12_5 then
						if arg_9_1.isInRecall_ then
							iter_12_5.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10144 = nil
			end

			local var_12_12 = arg_9_1.actors_["128404"]
			local var_12_13 = 0

			if var_12_13 < arg_9_1.time_ and arg_9_1.time_ <= var_12_13 + arg_12_0 and not isNil(var_12_12) and arg_9_1.var_.actorSpriteComps128404 == nil then
				arg_9_1.var_.actorSpriteComps128404 = var_12_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_14 = 0.2

			if var_12_13 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_14 and not isNil(var_12_12) then
				local var_12_15 = (arg_9_1.time_ - var_12_13) / var_12_14

				if arg_9_1.var_.actorSpriteComps128404 then
					for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_12_7 then
							if arg_9_1.isInRecall_ then
								local var_12_16 = Mathf.Lerp(iter_12_7.color.r, arg_9_1.hightColor2.r, var_12_15)
								local var_12_17 = Mathf.Lerp(iter_12_7.color.g, arg_9_1.hightColor2.g, var_12_15)
								local var_12_18 = Mathf.Lerp(iter_12_7.color.b, arg_9_1.hightColor2.b, var_12_15)

								iter_12_7.color = Color.New(var_12_16, var_12_17, var_12_18)
							else
								local var_12_19 = Mathf.Lerp(iter_12_7.color.r, 0.5, var_12_15)

								iter_12_7.color = Color.New(var_12_19, var_12_19, var_12_19)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_13 + var_12_14 and arg_9_1.time_ < var_12_13 + var_12_14 + arg_12_0 and not isNil(var_12_12) and arg_9_1.var_.actorSpriteComps128404 then
				for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_12_9 then
						if arg_9_1.isInRecall_ then
							iter_12_9.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps128404 = nil
			end

			local var_12_20 = arg_9_1.actors_["128404"].transform
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.var_.moveOldPos128404 = var_12_20.localPosition
				var_12_20.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("128404", 7)

				local var_12_22 = var_12_20.childCount

				for iter_12_10 = 0, var_12_22 - 1 do
					local var_12_23 = var_12_20:GetChild(iter_12_10)

					if var_12_23.name == "" or not string.find(var_12_23.name, "split") then
						var_12_23.gameObject:SetActive(true)
					else
						var_12_23.gameObject:SetActive(false)
					end
				end
			end

			local var_12_24 = 0.001

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_24 then
				local var_12_25 = (arg_9_1.time_ - var_12_21) / var_12_24
				local var_12_26 = Vector3.New(0, -2000, 0)

				var_12_20.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos128404, var_12_26, var_12_25)
			end

			if arg_9_1.time_ >= var_12_21 + var_12_24 and arg_9_1.time_ < var_12_21 + var_12_24 + arg_12_0 then
				var_12_20.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_27 = arg_9_1.actors_["10144"].transform
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				arg_9_1.var_.moveOldPos10144 = var_12_27.localPosition
				var_12_27.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10144", 3)

				local var_12_29 = var_12_27.childCount

				for iter_12_11 = 0, var_12_29 - 1 do
					local var_12_30 = var_12_27:GetChild(iter_12_11)

					if var_12_30.name == "" or not string.find(var_12_30.name, "split") then
						var_12_30.gameObject:SetActive(true)
					else
						var_12_30.gameObject:SetActive(false)
					end
				end
			end

			local var_12_31 = 0.001

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_31 then
				local var_12_32 = (arg_9_1.time_ - var_12_28) / var_12_31
				local var_12_33 = Vector3.New(-31.5, -381.1, -285.9)

				var_12_27.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10144, var_12_33, var_12_32)
			end

			if arg_9_1.time_ >= var_12_28 + var_12_31 and arg_9_1.time_ < var_12_28 + var_12_31 + arg_12_0 then
				var_12_27.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_12_34 = 0
			local var_12_35 = 0.625

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_36 = arg_9_1:FormatText(StoryNameCfg[1297].name)

				arg_9_1.leftNameTxt_.text = var_12_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_37 = arg_9_1:GetWordFromCfg(926041002)
				local var_12_38 = arg_9_1:FormatText(var_12_37.content)

				arg_9_1.text_.text = var_12_38

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_39 = 25
				local var_12_40 = utf8.len(var_12_38)
				local var_12_41 = var_12_39 <= 0 and var_12_35 or var_12_35 * (var_12_40 / var_12_39)

				if var_12_41 > 0 and var_12_35 < var_12_41 then
					arg_9_1.talkMaxDuration = var_12_41

					if var_12_41 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_41 + var_12_34
					end
				end

				arg_9_1.text_.text = var_12_38
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041002", "story_v_out_926041.awb") ~= 0 then
					local var_12_42 = manager.audio:GetVoiceLength("story_v_out_926041", "926041002", "story_v_out_926041.awb") / 1000

					if var_12_42 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_42 + var_12_34
					end

					if var_12_37.prefab_name ~= "" and arg_9_1.actors_[var_12_37.prefab_name] ~= nil then
						local var_12_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_37.prefab_name].transform, "story_v_out_926041", "926041002", "story_v_out_926041.awb")

						arg_9_1:RecordAudio("926041002", var_12_43)
						arg_9_1:RecordAudio("926041002", var_12_43)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926041", "926041002", "story_v_out_926041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926041", "926041002", "story_v_out_926041.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_44 = math.max(var_12_35, arg_9_1.talkMaxDuration)

			if var_12_34 <= arg_9_1.time_ and arg_9_1.time_ < var_12_34 + var_12_44 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_34) / var_12_44

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_34 + var_12_44 and arg_9_1.time_ < var_12_34 + var_12_44 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play926041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926041003
		arg_13_1.duration_ = 4.83

		local var_13_0 = {
			zh = 3.333,
			ja = 4.833
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
				arg_13_0:Play926041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.5

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[1297].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(926041003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041003", "story_v_out_926041.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041003", "story_v_out_926041.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_926041", "926041003", "story_v_out_926041.awb")

						arg_13_1:RecordAudio("926041003", var_16_9)
						arg_13_1:RecordAudio("926041003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926041", "926041003", "story_v_out_926041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926041", "926041003", "story_v_out_926041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play926041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926041004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play926041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10144"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10144 == nil then
				arg_17_1.var_.actorSpriteComps10144 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10144 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								local var_20_4 = Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, var_20_3)
								local var_20_5 = Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, var_20_3)
								local var_20_6 = Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, var_20_3)

								iter_20_1.color = Color.New(var_20_4, var_20_5, var_20_6)
							else
								local var_20_7 = Mathf.Lerp(iter_20_1.color.r, 0.5, var_20_3)

								iter_20_1.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10144 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10144 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.275

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[7].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_11 = arg_17_1:GetWordFromCfg(926041004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 11
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
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play926041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926041005
		arg_21_1.duration_ = 4.95

		local var_21_0 = {
			zh = 4.582999999999,
			ja = 4.949999999999
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
				arg_21_0:Play926041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["128404"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps128404 == nil then
				arg_21_1.var_.actorSpriteComps128404 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps128404 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps128404 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps128404 = nil
			end

			local var_24_8 = arg_21_1.actors_["10144"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos10144 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10144", 7)

				local var_24_10 = var_24_8.childCount

				for iter_24_4 = 0, var_24_10 - 1 do
					local var_24_11 = var_24_8:GetChild(iter_24_4)

					if var_24_11.name == "" or not string.find(var_24_11.name, "split") then
						var_24_11.gameObject:SetActive(true)
					else
						var_24_11.gameObject:SetActive(false)
					end
				end
			end

			local var_24_12 = 0.001

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_9) / var_24_12
				local var_24_14 = Vector3.New(0, -2000, 0)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10144, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_15 = arg_21_1.actors_["128404"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos128404 = var_24_15.localPosition
				var_24_15.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("128404", 3)

				local var_24_17 = var_24_15.childCount

				for iter_24_5 = 0, var_24_17 - 1 do
					local var_24_18 = var_24_15:GetChild(iter_24_5)

					if var_24_18.name == "split_5" or not string.find(var_24_18.name, "split") then
						var_24_18.gameObject:SetActive(true)
					else
						var_24_18.gameObject:SetActive(false)
					end
				end
			end

			local var_24_19 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_19 then
				local var_24_20 = (arg_21_1.time_ - var_24_16) / var_24_19
				local var_24_21 = Vector3.New(-16.1, -362, -375)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos128404, var_24_21, var_24_20)
			end

			if arg_21_1.time_ >= var_24_16 + var_24_19 and arg_21_1.time_ < var_24_16 + var_24_19 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_24_22 = arg_21_1.story_ui_effectTrs_.transform
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 then
				local var_24_24 = arg_21_1.var_.effect74575
				local var_24_25
				local var_24_26 = var_24_22

				if not var_24_24 then
					var_24_24 = Object.Instantiate(Asset.Load("Widget/System/Story/ui_uistory_loading1_keep"), var_24_26)
					var_24_24.name = "74575"
					arg_21_1.var_.effect74575 = var_24_24
				else
					var_24_24.transform:SetParent(var_24_26)
				end

				var_24_24.transform.localPosition = Vector3.New(36.27, -64.1, -264.9)
				var_24_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_24_27 = 0

			if var_24_27 < arg_21_1.time_ and arg_21_1.time_ <= var_24_27 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			local var_24_28 = 2

			if arg_21_1.time_ >= var_24_27 + var_24_28 and arg_21_1.time_ < var_24_27 + var_24_28 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			local var_24_29 = arg_21_1.actors_["128404"]
			local var_24_30 = 0

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				local var_24_31 = var_24_29:GetComponentInChildren(typeof(CanvasGroup))

				if var_24_31 then
					arg_21_1.var_.alphaOldValue128404 = var_24_31.alpha
					arg_21_1.var_.characterEffect128404 = var_24_31
				end

				arg_21_1.var_.alphaOldValue128404 = 0
			end

			local var_24_32 = 0.2

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_32 then
				local var_24_33 = (arg_21_1.time_ - var_24_30) / var_24_32
				local var_24_34 = Mathf.Lerp(arg_21_1.var_.alphaOldValue128404, 1, var_24_33)

				if arg_21_1.var_.characterEffect128404 then
					arg_21_1.var_.characterEffect128404.alpha = var_24_34
				end
			end

			if arg_21_1.time_ >= var_24_30 + var_24_32 and arg_21_1.time_ < var_24_30 + var_24_32 + arg_24_0 and arg_21_1.var_.characterEffect128404 then
				arg_21_1.var_.characterEffect128404.alpha = 1
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_35 = 1.749999999999
			local var_24_36 = 0.25

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_37 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_37:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_38 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_39 = arg_21_1:GetWordFromCfg(926041005)
				local var_24_40 = arg_21_1:FormatText(var_24_39.content)

				arg_21_1.text_.text = var_24_40

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_41 = 10
				local var_24_42 = utf8.len(var_24_40)
				local var_24_43 = var_24_41 <= 0 and var_24_36 or var_24_36 * (var_24_42 / var_24_41)

				if var_24_43 > 0 and var_24_36 < var_24_43 then
					arg_21_1.talkMaxDuration = var_24_43
					var_24_35 = var_24_35 + 0.3

					if var_24_43 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_43 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_40
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041005", "story_v_out_926041.awb") ~= 0 then
					local var_24_44 = manager.audio:GetVoiceLength("story_v_out_926041", "926041005", "story_v_out_926041.awb") / 1000

					if var_24_44 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_44 + var_24_35
					end

					if var_24_39.prefab_name ~= "" and arg_21_1.actors_[var_24_39.prefab_name] ~= nil then
						local var_24_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_39.prefab_name].transform, "story_v_out_926041", "926041005", "story_v_out_926041.awb")

						arg_21_1:RecordAudio("926041005", var_24_45)
						arg_21_1:RecordAudio("926041005", var_24_45)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_926041", "926041005", "story_v_out_926041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_926041", "926041005", "story_v_out_926041.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_46 = var_24_35 + 0.3
			local var_24_47 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_46 <= arg_21_1.time_ and arg_21_1.time_ < var_24_46 + var_24_47 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_46) / var_24_47

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_46 + var_24_47 and arg_21_1.time_ < var_24_46 + var_24_47 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play926041006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 926041006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play926041007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["128404"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps128404 == nil then
				arg_27_1.var_.actorSpriteComps128404 = var_30_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.actorSpriteComps128404 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								local var_30_4 = Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, var_30_3)
								local var_30_5 = Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, var_30_3)
								local var_30_6 = Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, var_30_3)

								iter_30_1.color = Color.New(var_30_4, var_30_5, var_30_6)
							else
								local var_30_7 = Mathf.Lerp(iter_30_1.color.r, 0.5, var_30_3)

								iter_30_1.color = Color.New(var_30_7, var_30_7, var_30_7)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps128404 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_30_3 then
						if arg_27_1.isInRecall_ then
							iter_30_3.color = arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_30_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps128404 = nil
			end

			local var_30_8 = 0
			local var_30_9 = 0.625

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_10 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_11 = arg_27_1:GetWordFromCfg(926041006)
				local var_30_12 = arg_27_1:FormatText(var_30_11.content)

				arg_27_1.text_.text = var_30_12

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 25
				local var_30_14 = utf8.len(var_30_12)
				local var_30_15 = var_30_13 <= 0 and var_30_9 or var_30_9 * (var_30_14 / var_30_13)

				if var_30_15 > 0 and var_30_9 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_12
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_16 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_16 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_16

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_16 and arg_27_1.time_ < var_30_8 + var_30_16 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play926041007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 926041007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play926041008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0
			local var_34_1 = 0.325

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_2 = arg_31_1:FormatText(StoryNameCfg[7].name)

				arg_31_1.leftNameTxt_.text = var_34_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_3 = arg_31_1:GetWordFromCfg(926041007)
				local var_34_4 = arg_31_1:FormatText(var_34_3.content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 13
				local var_34_6 = utf8.len(var_34_4)
				local var_34_7 = var_34_5 <= 0 and var_34_1 or var_34_1 * (var_34_6 / var_34_5)

				if var_34_7 > 0 and var_34_1 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_1, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_0) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_8 and arg_31_1.time_ < var_34_0 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play926041008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 926041008
		arg_35_1.duration_ = 5.03

		local var_35_0 = {
			zh = 4,
			ja = 5.033
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play926041009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["128404"]
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps128404 == nil then
				arg_35_1.var_.actorSpriteComps128404 = var_38_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_2 = 0.2

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 and not isNil(var_38_0) then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2

				if arg_35_1.var_.actorSpriteComps128404 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								local var_38_4 = Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor1.r, var_38_3)
								local var_38_5 = Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor1.g, var_38_3)
								local var_38_6 = Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor1.b, var_38_3)

								iter_38_1.color = Color.New(var_38_4, var_38_5, var_38_6)
							else
								local var_38_7 = Mathf.Lerp(iter_38_1.color.r, 1, var_38_3)

								iter_38_1.color = Color.New(var_38_7, var_38_7, var_38_7)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 and not isNil(var_38_0) and arg_35_1.var_.actorSpriteComps128404 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_38_3 then
						if arg_35_1.isInRecall_ then
							iter_38_3.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_38_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps128404 = nil
			end

			local var_38_8 = arg_35_1.actors_["128404"].transform
			local var_38_9 = 0

			if var_38_9 < arg_35_1.time_ and arg_35_1.time_ <= var_38_9 + arg_38_0 then
				arg_35_1.var_.moveOldPos128404 = var_38_8.localPosition
				var_38_8.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("128404", 3)

				local var_38_10 = var_38_8.childCount

				for iter_38_4 = 0, var_38_10 - 1 do
					local var_38_11 = var_38_8:GetChild(iter_38_4)

					if var_38_11.name == "" or not string.find(var_38_11.name, "split") then
						var_38_11.gameObject:SetActive(true)
					else
						var_38_11.gameObject:SetActive(false)
					end
				end
			end

			local var_38_12 = 0.001

			if var_38_9 <= arg_35_1.time_ and arg_35_1.time_ < var_38_9 + var_38_12 then
				local var_38_13 = (arg_35_1.time_ - var_38_9) / var_38_12
				local var_38_14 = Vector3.New(-16.1, -362, -375)

				var_38_8.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos128404, var_38_14, var_38_13)
			end

			if arg_35_1.time_ >= var_38_9 + var_38_12 and arg_35_1.time_ < var_38_9 + var_38_12 + arg_38_0 then
				var_38_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_38_15 = arg_35_1.story_ui_effectTrs_.transform
			local var_38_16 = 0

			if var_38_16 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 then
				local var_38_17 = arg_35_1.var_.effect74575

				if var_38_17 then
					Object.Destroy(var_38_17)

					arg_35_1.var_.effect74575 = nil
				end
			end

			local var_38_18 = 0
			local var_38_19 = 0.35

			if var_38_18 < arg_35_1.time_ and arg_35_1.time_ <= var_38_18 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_20 = arg_35_1:FormatText(StoryNameCfg[6].name)

				arg_35_1.leftNameTxt_.text = var_38_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_21 = arg_35_1:GetWordFromCfg(926041008)
				local var_38_22 = arg_35_1:FormatText(var_38_21.content)

				arg_35_1.text_.text = var_38_22

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_23 = 14
				local var_38_24 = utf8.len(var_38_22)
				local var_38_25 = var_38_23 <= 0 and var_38_19 or var_38_19 * (var_38_24 / var_38_23)

				if var_38_25 > 0 and var_38_19 < var_38_25 then
					arg_35_1.talkMaxDuration = var_38_25

					if var_38_25 + var_38_18 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_25 + var_38_18
					end
				end

				arg_35_1.text_.text = var_38_22
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041008", "story_v_out_926041.awb") ~= 0 then
					local var_38_26 = manager.audio:GetVoiceLength("story_v_out_926041", "926041008", "story_v_out_926041.awb") / 1000

					if var_38_26 + var_38_18 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_26 + var_38_18
					end

					if var_38_21.prefab_name ~= "" and arg_35_1.actors_[var_38_21.prefab_name] ~= nil then
						local var_38_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_21.prefab_name].transform, "story_v_out_926041", "926041008", "story_v_out_926041.awb")

						arg_35_1:RecordAudio("926041008", var_38_27)
						arg_35_1:RecordAudio("926041008", var_38_27)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_926041", "926041008", "story_v_out_926041.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_926041", "926041008", "story_v_out_926041.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_28 = math.max(var_38_19, arg_35_1.talkMaxDuration)

			if var_38_18 <= arg_35_1.time_ and arg_35_1.time_ < var_38_18 + var_38_28 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_18) / var_38_28

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_18 + var_38_28 and arg_35_1.time_ < var_38_18 + var_38_28 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play926041009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 926041009
		arg_39_1.duration_ = 2.83

		local var_39_0 = {
			zh = 2.3,
			ja = 2.833
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play926041010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = "106103"

			if arg_39_1.actors_[var_42_0] == nil then
				local var_42_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_42_1) then
					local var_42_2 = Object.Instantiate(var_42_1, arg_39_1.canvasGo_.transform)

					var_42_2.transform:SetSiblingIndex(1)

					var_42_2.name = var_42_0
					var_42_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_39_1.actors_[var_42_0] = var_42_2

					local var_42_3 = var_42_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_39_1.isInRecall_ then
						for iter_42_0, iter_42_1 in ipairs(var_42_3) do
							iter_42_1.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_42_4 = arg_39_1.actors_["106103"]
			local var_42_5 = 0

			if var_42_5 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.actorSpriteComps106103 == nil then
				arg_39_1.var_.actorSpriteComps106103 = var_42_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_6 = 0.2

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 and not isNil(var_42_4) then
				local var_42_7 = (arg_39_1.time_ - var_42_5) / var_42_6

				if arg_39_1.var_.actorSpriteComps106103 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								local var_42_8 = Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor1.r, var_42_7)
								local var_42_9 = Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor1.g, var_42_7)
								local var_42_10 = Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor1.b, var_42_7)

								iter_42_3.color = Color.New(var_42_8, var_42_9, var_42_10)
							else
								local var_42_11 = Mathf.Lerp(iter_42_3.color.r, 1, var_42_7)

								iter_42_3.color = Color.New(var_42_11, var_42_11, var_42_11)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.actorSpriteComps106103 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_42_5 then
						if arg_39_1.isInRecall_ then
							iter_42_5.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps106103 = nil
			end

			local var_42_12 = arg_39_1.actors_["128404"]
			local var_42_13 = 0

			if var_42_13 < arg_39_1.time_ and arg_39_1.time_ <= var_42_13 + arg_42_0 and not isNil(var_42_12) and arg_39_1.var_.actorSpriteComps128404 == nil then
				arg_39_1.var_.actorSpriteComps128404 = var_42_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_14 = 0.2

			if var_42_13 <= arg_39_1.time_ and arg_39_1.time_ < var_42_13 + var_42_14 and not isNil(var_42_12) then
				local var_42_15 = (arg_39_1.time_ - var_42_13) / var_42_14

				if arg_39_1.var_.actorSpriteComps128404 then
					for iter_42_6, iter_42_7 in pairs(arg_39_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_42_7 then
							if arg_39_1.isInRecall_ then
								local var_42_16 = Mathf.Lerp(iter_42_7.color.r, arg_39_1.hightColor2.r, var_42_15)
								local var_42_17 = Mathf.Lerp(iter_42_7.color.g, arg_39_1.hightColor2.g, var_42_15)
								local var_42_18 = Mathf.Lerp(iter_42_7.color.b, arg_39_1.hightColor2.b, var_42_15)

								iter_42_7.color = Color.New(var_42_16, var_42_17, var_42_18)
							else
								local var_42_19 = Mathf.Lerp(iter_42_7.color.r, 0.5, var_42_15)

								iter_42_7.color = Color.New(var_42_19, var_42_19, var_42_19)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_13 + var_42_14 and arg_39_1.time_ < var_42_13 + var_42_14 + arg_42_0 and not isNil(var_42_12) and arg_39_1.var_.actorSpriteComps128404 then
				for iter_42_8, iter_42_9 in pairs(arg_39_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_42_9 then
						if arg_39_1.isInRecall_ then
							iter_42_9.color = arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_42_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps128404 = nil
			end

			local var_42_20 = 0
			local var_42_21 = 0.2

			if var_42_20 < arg_39_1.time_ and arg_39_1.time_ <= var_42_20 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_22 = arg_39_1:FormatText(StoryNameCfg[612].name)

				arg_39_1.leftNameTxt_.text = var_42_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_23 = arg_39_1:GetWordFromCfg(926041009)
				local var_42_24 = arg_39_1:FormatText(var_42_23.content)

				arg_39_1.text_.text = var_42_24

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_25 = 8
				local var_42_26 = utf8.len(var_42_24)
				local var_42_27 = var_42_25 <= 0 and var_42_21 or var_42_21 * (var_42_26 / var_42_25)

				if var_42_27 > 0 and var_42_21 < var_42_27 then
					arg_39_1.talkMaxDuration = var_42_27

					if var_42_27 + var_42_20 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_27 + var_42_20
					end
				end

				arg_39_1.text_.text = var_42_24
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041009", "story_v_out_926041.awb") ~= 0 then
					local var_42_28 = manager.audio:GetVoiceLength("story_v_out_926041", "926041009", "story_v_out_926041.awb") / 1000

					if var_42_28 + var_42_20 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_28 + var_42_20
					end

					if var_42_23.prefab_name ~= "" and arg_39_1.actors_[var_42_23.prefab_name] ~= nil then
						local var_42_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_23.prefab_name].transform, "story_v_out_926041", "926041009", "story_v_out_926041.awb")

						arg_39_1:RecordAudio("926041009", var_42_29)
						arg_39_1:RecordAudio("926041009", var_42_29)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_926041", "926041009", "story_v_out_926041.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_926041", "926041009", "story_v_out_926041.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_30 = math.max(var_42_21, arg_39_1.talkMaxDuration)

			if var_42_20 <= arg_39_1.time_ and arg_39_1.time_ < var_42_20 + var_42_30 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_20) / var_42_30

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_20 + var_42_30 and arg_39_1.time_ < var_42_20 + var_42_30 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play926041010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 926041010
		arg_43_1.duration_ = 8.77

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play926041011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 2

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				local var_46_1 = manager.ui.mainCamera.transform.localPosition
				local var_46_2 = Vector3.New(0, 0, 10) + Vector3.New(var_46_1.x, var_46_1.y, 0)
				local var_46_3 = arg_43_1.bgs_.I22f

				var_46_3.transform.localPosition = var_46_2
				var_46_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_4 = var_46_3:GetComponent("SpriteRenderer")

				if var_46_4 and var_46_4.sprite then
					local var_46_5 = (var_46_3.transform.localPosition - var_46_1).z
					local var_46_6 = manager.ui.mainCameraCom_
					local var_46_7 = 2 * var_46_5 * Mathf.Tan(var_46_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_8 = var_46_7 * var_46_6.aspect
					local var_46_9 = var_46_4.sprite.bounds.size.x
					local var_46_10 = var_46_4.sprite.bounds.size.y
					local var_46_11 = var_46_8 / var_46_9
					local var_46_12 = var_46_7 / var_46_10
					local var_46_13 = var_46_12 < var_46_11 and var_46_11 or var_46_12

					var_46_3.transform.localScale = Vector3.New(var_46_13, var_46_13, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "I22f" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_14 = 2

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			local var_46_15 = 0.3

			if arg_43_1.time_ >= var_46_14 + var_46_15 and arg_43_1.time_ < var_46_14 + var_46_15 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_16 = 0

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_17 = 2

			if var_46_16 <= arg_43_1.time_ and arg_43_1.time_ < var_46_16 + var_46_17 then
				local var_46_18 = (arg_43_1.time_ - var_46_16) / var_46_17
				local var_46_19 = Color.New(0, 0, 0)

				var_46_19.a = Mathf.Lerp(0, 1, var_46_18)
				arg_43_1.mask_.color = var_46_19
			end

			if arg_43_1.time_ >= var_46_16 + var_46_17 and arg_43_1.time_ < var_46_16 + var_46_17 + arg_46_0 then
				local var_46_20 = Color.New(0, 0, 0)

				var_46_20.a = 1
				arg_43_1.mask_.color = var_46_20
			end

			local var_46_21 = 2

			if var_46_21 < arg_43_1.time_ and arg_43_1.time_ <= var_46_21 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_22 = 2

			if var_46_21 <= arg_43_1.time_ and arg_43_1.time_ < var_46_21 + var_46_22 then
				local var_46_23 = (arg_43_1.time_ - var_46_21) / var_46_22
				local var_46_24 = Color.New(0, 0, 0)

				var_46_24.a = Mathf.Lerp(1, 0, var_46_23)
				arg_43_1.mask_.color = var_46_24
			end

			if arg_43_1.time_ >= var_46_21 + var_46_22 and arg_43_1.time_ < var_46_21 + var_46_22 + arg_46_0 then
				local var_46_25 = Color.New(0, 0, 0)
				local var_46_26 = 0

				arg_43_1.mask_.enabled = false
				var_46_25.a = var_46_26
				arg_43_1.mask_.color = var_46_25
			end

			local var_46_27 = arg_43_1.actors_["106103"]
			local var_46_28 = 2

			if var_46_28 < arg_43_1.time_ and arg_43_1.time_ <= var_46_28 + arg_46_0 and not isNil(var_46_27) and arg_43_1.var_.actorSpriteComps106103 == nil then
				arg_43_1.var_.actorSpriteComps106103 = var_46_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_29 = 0.2

			if var_46_28 <= arg_43_1.time_ and arg_43_1.time_ < var_46_28 + var_46_29 and not isNil(var_46_27) then
				local var_46_30 = (arg_43_1.time_ - var_46_28) / var_46_29

				if arg_43_1.var_.actorSpriteComps106103 then
					for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_46_3 then
							if arg_43_1.isInRecall_ then
								local var_46_31 = Mathf.Lerp(iter_46_3.color.r, arg_43_1.hightColor2.r, var_46_30)
								local var_46_32 = Mathf.Lerp(iter_46_3.color.g, arg_43_1.hightColor2.g, var_46_30)
								local var_46_33 = Mathf.Lerp(iter_46_3.color.b, arg_43_1.hightColor2.b, var_46_30)

								iter_46_3.color = Color.New(var_46_31, var_46_32, var_46_33)
							else
								local var_46_34 = Mathf.Lerp(iter_46_3.color.r, 0.5, var_46_30)

								iter_46_3.color = Color.New(var_46_34, var_46_34, var_46_34)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_28 + var_46_29 and arg_43_1.time_ < var_46_28 + var_46_29 + arg_46_0 and not isNil(var_46_27) and arg_43_1.var_.actorSpriteComps106103 then
				for iter_46_4, iter_46_5 in pairs(arg_43_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_46_5 then
						if arg_43_1.isInRecall_ then
							iter_46_5.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps106103 = nil
			end

			local var_46_35 = arg_43_1.actors_["128404"].transform
			local var_46_36 = 2

			if var_46_36 < arg_43_1.time_ and arg_43_1.time_ <= var_46_36 + arg_46_0 then
				arg_43_1.var_.moveOldPos128404 = var_46_35.localPosition
				var_46_35.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("128404", 7)

				local var_46_37 = var_46_35.childCount

				for iter_46_6 = 0, var_46_37 - 1 do
					local var_46_38 = var_46_35:GetChild(iter_46_6)

					if var_46_38.name == "" or not string.find(var_46_38.name, "split") then
						var_46_38.gameObject:SetActive(true)
					else
						var_46_38.gameObject:SetActive(false)
					end
				end
			end

			local var_46_39 = 0.001

			if var_46_36 <= arg_43_1.time_ and arg_43_1.time_ < var_46_36 + var_46_39 then
				local var_46_40 = (arg_43_1.time_ - var_46_36) / var_46_39
				local var_46_41 = Vector3.New(0, -2000, 0)

				var_46_35.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos128404, var_46_41, var_46_40)
			end

			if arg_43_1.time_ >= var_46_36 + var_46_39 and arg_43_1.time_ < var_46_36 + var_46_39 + arg_46_0 then
				var_46_35.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_42 = 3.76666666666667
			local var_46_43 = 0.9

			if var_46_42 < arg_43_1.time_ and arg_43_1.time_ <= var_46_42 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_44 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_44:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_45 = arg_43_1:GetWordFromCfg(926041010)
				local var_46_46 = arg_43_1:FormatText(var_46_45.content)

				arg_43_1.text_.text = var_46_46

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_47 = 36
				local var_46_48 = utf8.len(var_46_46)
				local var_46_49 = var_46_47 <= 0 and var_46_43 or var_46_43 * (var_46_48 / var_46_47)

				if var_46_49 > 0 and var_46_43 < var_46_49 then
					arg_43_1.talkMaxDuration = var_46_49
					var_46_42 = var_46_42 + 0.3

					if var_46_49 + var_46_42 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_49 + var_46_42
					end
				end

				arg_43_1.text_.text = var_46_46
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_50 = var_46_42 + 0.3
			local var_46_51 = math.max(var_46_43, arg_43_1.talkMaxDuration)

			if var_46_50 <= arg_43_1.time_ and arg_43_1.time_ < var_46_50 + var_46_51 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_50) / var_46_51

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_50 + var_46_51 and arg_43_1.time_ < var_46_50 + var_46_51 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play926041011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926041011
		arg_49_1.duration_ = 7.37

		local var_49_0 = {
			zh = 7.366,
			ja = 7.166
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
				arg_49_0:Play926041012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "106603"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_52_1) then
					local var_52_2 = Object.Instantiate(var_52_1, arg_49_1.canvasGo_.transform)

					var_52_2.transform:SetSiblingIndex(1)

					var_52_2.name = var_52_0
					var_52_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_49_1.actors_[var_52_0] = var_52_2

					local var_52_3 = var_52_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_49_1.isInRecall_ then
						for iter_52_0, iter_52_1 in ipairs(var_52_3) do
							iter_52_1.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_52_4 = arg_49_1.actors_["106603"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.actorSpriteComps106603 == nil then
				arg_49_1.var_.actorSpriteComps106603 = var_52_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_6 = 0.2

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.actorSpriteComps106603 then
					for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_52_3 then
							if arg_49_1.isInRecall_ then
								local var_52_8 = Mathf.Lerp(iter_52_3.color.r, arg_49_1.hightColor1.r, var_52_7)
								local var_52_9 = Mathf.Lerp(iter_52_3.color.g, arg_49_1.hightColor1.g, var_52_7)
								local var_52_10 = Mathf.Lerp(iter_52_3.color.b, arg_49_1.hightColor1.b, var_52_7)

								iter_52_3.color = Color.New(var_52_8, var_52_9, var_52_10)
							else
								local var_52_11 = Mathf.Lerp(iter_52_3.color.r, 1, var_52_7)

								iter_52_3.color = Color.New(var_52_11, var_52_11, var_52_11)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.actorSpriteComps106603 then
				for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_52_5 then
						if arg_49_1.isInRecall_ then
							iter_52_5.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps106603 = nil
			end

			local var_52_12 = 0
			local var_52_13 = 0.45

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[32].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106603_split_1")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_15 = arg_49_1:GetWordFromCfg(926041011)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 18
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041011", "story_v_out_926041.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_926041", "926041011", "story_v_out_926041.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_926041", "926041011", "story_v_out_926041.awb")

						arg_49_1:RecordAudio("926041011", var_52_21)
						arg_49_1:RecordAudio("926041011", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926041", "926041011", "story_v_out_926041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926041", "926041011", "story_v_out_926041.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play926041012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926041012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play926041013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["106603"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps106603 == nil then
				arg_53_1.var_.actorSpriteComps106603 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 0.2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps106603 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 0.5, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps106603 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps106603 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.825

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(926041012)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_12 = 33
				local var_56_13 = utf8.len(var_56_11)
				local var_56_14 = var_56_12 <= 0 and var_56_9 or var_56_9 * (var_56_13 / var_56_12)

				if var_56_14 > 0 and var_56_9 < var_56_14 then
					arg_53_1.talkMaxDuration = var_56_14

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_15 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_15 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_15

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_15 and arg_53_1.time_ < var_56_8 + var_56_15 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play926041013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926041013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926041014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.8

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(926041013)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 32
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play926041014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926041014
		arg_61_1.duration_ = 4.3

		local var_61_0 = {
			zh = 2.7,
			ja = 4.3
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
				arg_61_0:Play926041015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["128404"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps128404 == nil then
				arg_61_1.var_.actorSpriteComps128404 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps128404 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps128404 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps128404 = nil
			end

			local var_64_8 = arg_61_1.actors_["128404"].transform
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.var_.moveOldPos128404 = var_64_8.localPosition
				var_64_8.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("128404", 3)

				local var_64_10 = var_64_8.childCount

				for iter_64_4 = 0, var_64_10 - 1 do
					local var_64_11 = var_64_8:GetChild(iter_64_4)

					if var_64_11.name == "split_5" or not string.find(var_64_11.name, "split") then
						var_64_11.gameObject:SetActive(true)
					else
						var_64_11.gameObject:SetActive(false)
					end
				end
			end

			local var_64_12 = 0.001

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_12 then
				local var_64_13 = (arg_61_1.time_ - var_64_9) / var_64_12
				local var_64_14 = Vector3.New(-16.1, -362, -375)

				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos128404, var_64_14, var_64_13)
			end

			if arg_61_1.time_ >= var_64_9 + var_64_12 and arg_61_1.time_ < var_64_9 + var_64_12 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_64_15 = 0
			local var_64_16 = 0.35

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_17 = arg_61_1:FormatText(StoryNameCfg[6].name)

				arg_61_1.leftNameTxt_.text = var_64_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:GetWordFromCfg(926041014)
				local var_64_19 = arg_61_1:FormatText(var_64_18.content)

				arg_61_1.text_.text = var_64_19

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 14
				local var_64_21 = utf8.len(var_64_19)
				local var_64_22 = var_64_20 <= 0 and var_64_16 or var_64_16 * (var_64_21 / var_64_20)

				if var_64_22 > 0 and var_64_16 < var_64_22 then
					arg_61_1.talkMaxDuration = var_64_22

					if var_64_22 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_22 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_19
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041014", "story_v_out_926041.awb") ~= 0 then
					local var_64_23 = manager.audio:GetVoiceLength("story_v_out_926041", "926041014", "story_v_out_926041.awb") / 1000

					if var_64_23 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_23 + var_64_15
					end

					if var_64_18.prefab_name ~= "" and arg_61_1.actors_[var_64_18.prefab_name] ~= nil then
						local var_64_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_18.prefab_name].transform, "story_v_out_926041", "926041014", "story_v_out_926041.awb")

						arg_61_1:RecordAudio("926041014", var_64_24)
						arg_61_1:RecordAudio("926041014", var_64_24)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_926041", "926041014", "story_v_out_926041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_926041", "926041014", "story_v_out_926041.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_25 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_25 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_25

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_25 and arg_61_1.time_ < var_64_15 + var_64_25 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play926041015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926041015
		arg_65_1.duration_ = 4.43

		local var_65_0 = {
			zh = 3.166,
			ja = 4.433
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play926041016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10144"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10144 == nil then
				arg_65_1.var_.actorSpriteComps10144 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10144 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 1, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10144 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10144 = nil
			end

			local var_68_8 = arg_65_1.actors_["128404"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps128404 == nil then
				arg_65_1.var_.actorSpriteComps128404 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps128404 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 0.5, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps128404 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps128404 = nil
			end

			local var_68_16 = arg_65_1.actors_["128404"].transform
			local var_68_17 = 0

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				arg_65_1.var_.moveOldPos128404 = var_68_16.localPosition
				var_68_16.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("128404", 7)

				local var_68_18 = var_68_16.childCount

				for iter_68_8 = 0, var_68_18 - 1 do
					local var_68_19 = var_68_16:GetChild(iter_68_8)

					if var_68_19.name == "" or not string.find(var_68_19.name, "split") then
						var_68_19.gameObject:SetActive(true)
					else
						var_68_19.gameObject:SetActive(false)
					end
				end
			end

			local var_68_20 = 0.001

			if var_68_17 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_20 then
				local var_68_21 = (arg_65_1.time_ - var_68_17) / var_68_20
				local var_68_22 = Vector3.New(0, -2000, 0)

				var_68_16.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos128404, var_68_22, var_68_21)
			end

			if arg_65_1.time_ >= var_68_17 + var_68_20 and arg_65_1.time_ < var_68_17 + var_68_20 + arg_68_0 then
				var_68_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_23 = arg_65_1.actors_["10144"].transform
			local var_68_24 = 0

			if var_68_24 < arg_65_1.time_ and arg_65_1.time_ <= var_68_24 + arg_68_0 then
				arg_65_1.var_.moveOldPos10144 = var_68_23.localPosition
				var_68_23.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10144", 3)

				local var_68_25 = var_68_23.childCount

				for iter_68_9 = 0, var_68_25 - 1 do
					local var_68_26 = var_68_23:GetChild(iter_68_9)

					if var_68_26.name == "" or not string.find(var_68_26.name, "split") then
						var_68_26.gameObject:SetActive(true)
					else
						var_68_26.gameObject:SetActive(false)
					end
				end
			end

			local var_68_27 = 0.001

			if var_68_24 <= arg_65_1.time_ and arg_65_1.time_ < var_68_24 + var_68_27 then
				local var_68_28 = (arg_65_1.time_ - var_68_24) / var_68_27
				local var_68_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_68_23.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10144, var_68_29, var_68_28)
			end

			if arg_65_1.time_ >= var_68_24 + var_68_27 and arg_65_1.time_ < var_68_24 + var_68_27 + arg_68_0 then
				var_68_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_68_30 = 0
			local var_68_31 = 0.425

			if var_68_30 < arg_65_1.time_ and arg_65_1.time_ <= var_68_30 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_32 = arg_65_1:FormatText(StoryNameCfg[1297].name)

				arg_65_1.leftNameTxt_.text = var_68_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_33 = arg_65_1:GetWordFromCfg(926041015)
				local var_68_34 = arg_65_1:FormatText(var_68_33.content)

				arg_65_1.text_.text = var_68_34

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_35 = 17
				local var_68_36 = utf8.len(var_68_34)
				local var_68_37 = var_68_35 <= 0 and var_68_31 or var_68_31 * (var_68_36 / var_68_35)

				if var_68_37 > 0 and var_68_31 < var_68_37 then
					arg_65_1.talkMaxDuration = var_68_37

					if var_68_37 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_37 + var_68_30
					end
				end

				arg_65_1.text_.text = var_68_34
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041015", "story_v_out_926041.awb") ~= 0 then
					local var_68_38 = manager.audio:GetVoiceLength("story_v_out_926041", "926041015", "story_v_out_926041.awb") / 1000

					if var_68_38 + var_68_30 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_38 + var_68_30
					end

					if var_68_33.prefab_name ~= "" and arg_65_1.actors_[var_68_33.prefab_name] ~= nil then
						local var_68_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_33.prefab_name].transform, "story_v_out_926041", "926041015", "story_v_out_926041.awb")

						arg_65_1:RecordAudio("926041015", var_68_39)
						arg_65_1:RecordAudio("926041015", var_68_39)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_926041", "926041015", "story_v_out_926041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_926041", "926041015", "story_v_out_926041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_40 = math.max(var_68_31, arg_65_1.talkMaxDuration)

			if var_68_30 <= arg_65_1.time_ and arg_65_1.time_ < var_68_30 + var_68_40 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_30) / var_68_40

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_30 + var_68_40 and arg_65_1.time_ < var_68_30 + var_68_40 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926041016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926041016
		arg_69_1.duration_ = 10.4

		local var_69_0 = {
			zh = 10.4,
			ja = 8.466
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
				arg_69_0:Play926041017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["106103"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps106103 == nil then
				arg_69_1.var_.actorSpriteComps106103 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps106103 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor1.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor1.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor1.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 1, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps106103 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps106103 = nil
			end

			local var_72_8 = arg_69_1.actors_["10144"]
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10144 == nil then
				arg_69_1.var_.actorSpriteComps10144 = var_72_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_10 = 0.2

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 and not isNil(var_72_8) then
				local var_72_11 = (arg_69_1.time_ - var_72_9) / var_72_10

				if arg_69_1.var_.actorSpriteComps10144 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								local var_72_12 = Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, var_72_11)
								local var_72_13 = Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, var_72_11)
								local var_72_14 = Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, var_72_11)

								iter_72_5.color = Color.New(var_72_12, var_72_13, var_72_14)
							else
								local var_72_15 = Mathf.Lerp(iter_72_5.color.r, 0.5, var_72_11)

								iter_72_5.color = Color.New(var_72_15, var_72_15, var_72_15)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.actorSpriteComps10144 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_72_7 then
						if arg_69_1.isInRecall_ then
							iter_72_7.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10144 = nil
			end

			local var_72_16 = arg_69_1.actors_["10144"].transform
			local var_72_17 = 0

			if var_72_17 < arg_69_1.time_ and arg_69_1.time_ <= var_72_17 + arg_72_0 then
				arg_69_1.var_.moveOldPos10144 = var_72_16.localPosition
				var_72_16.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10144", 7)

				local var_72_18 = var_72_16.childCount

				for iter_72_8 = 0, var_72_18 - 1 do
					local var_72_19 = var_72_16:GetChild(iter_72_8)

					if var_72_19.name == "" or not string.find(var_72_19.name, "split") then
						var_72_19.gameObject:SetActive(true)
					else
						var_72_19.gameObject:SetActive(false)
					end
				end
			end

			local var_72_20 = 0.001

			if var_72_17 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_20 then
				local var_72_21 = (arg_69_1.time_ - var_72_17) / var_72_20
				local var_72_22 = Vector3.New(0, -2000, 0)

				var_72_16.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10144, var_72_22, var_72_21)
			end

			if arg_69_1.time_ >= var_72_17 + var_72_20 and arg_69_1.time_ < var_72_17 + var_72_20 + arg_72_0 then
				var_72_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_23 = arg_69_1.actors_["106103"].transform
			local var_72_24 = 0

			if var_72_24 < arg_69_1.time_ and arg_69_1.time_ <= var_72_24 + arg_72_0 then
				arg_69_1.var_.moveOldPos106103 = var_72_23.localPosition
				var_72_23.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("106103", 3)

				local var_72_25 = var_72_23.childCount

				for iter_72_9 = 0, var_72_25 - 1 do
					local var_72_26 = var_72_23:GetChild(iter_72_9)

					if var_72_26.name == "split_2" or not string.find(var_72_26.name, "split") then
						var_72_26.gameObject:SetActive(true)
					else
						var_72_26.gameObject:SetActive(false)
					end
				end
			end

			local var_72_27 = 0.001

			if var_72_24 <= arg_69_1.time_ and arg_69_1.time_ < var_72_24 + var_72_27 then
				local var_72_28 = (arg_69_1.time_ - var_72_24) / var_72_27
				local var_72_29 = Vector3.New(-36.6, -398.2, -333.7)

				var_72_23.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos106103, var_72_29, var_72_28)
			end

			if arg_69_1.time_ >= var_72_24 + var_72_27 and arg_69_1.time_ < var_72_24 + var_72_27 + arg_72_0 then
				var_72_23.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_72_30 = 0
			local var_72_31 = 1.2

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_32 = arg_69_1:FormatText(StoryNameCfg[612].name)

				arg_69_1.leftNameTxt_.text = var_72_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_33 = arg_69_1:GetWordFromCfg(926041016)
				local var_72_34 = arg_69_1:FormatText(var_72_33.content)

				arg_69_1.text_.text = var_72_34

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_35 = 48
				local var_72_36 = utf8.len(var_72_34)
				local var_72_37 = var_72_35 <= 0 and var_72_31 or var_72_31 * (var_72_36 / var_72_35)

				if var_72_37 > 0 and var_72_31 < var_72_37 then
					arg_69_1.talkMaxDuration = var_72_37

					if var_72_37 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_37 + var_72_30
					end
				end

				arg_69_1.text_.text = var_72_34
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041016", "story_v_out_926041.awb") ~= 0 then
					local var_72_38 = manager.audio:GetVoiceLength("story_v_out_926041", "926041016", "story_v_out_926041.awb") / 1000

					if var_72_38 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_38 + var_72_30
					end

					if var_72_33.prefab_name ~= "" and arg_69_1.actors_[var_72_33.prefab_name] ~= nil then
						local var_72_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_33.prefab_name].transform, "story_v_out_926041", "926041016", "story_v_out_926041.awb")

						arg_69_1:RecordAudio("926041016", var_72_39)
						arg_69_1:RecordAudio("926041016", var_72_39)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_926041", "926041016", "story_v_out_926041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_926041", "926041016", "story_v_out_926041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_40 = math.max(var_72_31, arg_69_1.talkMaxDuration)

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_40 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_30) / var_72_40

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_30 + var_72_40 and arg_69_1.time_ < var_72_30 + var_72_40 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play926041017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926041017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play926041018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["106103"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps106103 == nil then
				arg_73_1.var_.actorSpriteComps106103 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps106103 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor2.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor2.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor2.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 0.5, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps106103 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps106103 = nil
			end

			local var_76_8 = 0
			local var_76_9 = 0.2

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_10 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_10

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

				local var_76_11 = arg_73_1:GetWordFromCfg(926041017)
				local var_76_12 = arg_73_1:FormatText(var_76_11.content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 8
				local var_76_14 = utf8.len(var_76_12)
				local var_76_15 = var_76_13 <= 0 and var_76_9 or var_76_9 * (var_76_14 / var_76_13)

				if var_76_15 > 0 and var_76_9 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_12
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play926041018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926041018
		arg_77_1.duration_ = 5.53

		local var_77_0 = {
			zh = 5.533,
			ja = 5.466
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
				arg_77_0:Play926041019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = "104701"

			if arg_77_1.actors_[var_80_0] == nil then
				local var_80_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_80_1) then
					local var_80_2 = Object.Instantiate(var_80_1, arg_77_1.canvasGo_.transform)

					var_80_2.transform:SetSiblingIndex(1)

					var_80_2.name = var_80_0
					var_80_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_77_1.actors_[var_80_0] = var_80_2

					local var_80_3 = var_80_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_77_1.isInRecall_ then
						for iter_80_0, iter_80_1 in ipairs(var_80_3) do
							iter_80_1.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_80_4 = arg_77_1.actors_["104701"]
			local var_80_5 = 0

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.actorSpriteComps104701 == nil then
				arg_77_1.var_.actorSpriteComps104701 = var_80_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 0.2

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_6 and not isNil(var_80_4) then
				local var_80_7 = (arg_77_1.time_ - var_80_5) / var_80_6

				if arg_77_1.var_.actorSpriteComps104701 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								local var_80_8 = Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor1.r, var_80_7)
								local var_80_9 = Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor1.g, var_80_7)
								local var_80_10 = Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor1.b, var_80_7)

								iter_80_3.color = Color.New(var_80_8, var_80_9, var_80_10)
							else
								local var_80_11 = Mathf.Lerp(iter_80_3.color.r, 1, var_80_7)

								iter_80_3.color = Color.New(var_80_11, var_80_11, var_80_11)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_5 + var_80_6 and arg_77_1.time_ < var_80_5 + var_80_6 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.actorSpriteComps104701 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_80_5 then
						if arg_77_1.isInRecall_ then
							iter_80_5.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps104701 = nil
			end

			local var_80_12 = arg_77_1.actors_["106103"].transform
			local var_80_13 = 0

			if var_80_13 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1.var_.moveOldPos106103 = var_80_12.localPosition
				var_80_12.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("106103", 7)

				local var_80_14 = var_80_12.childCount

				for iter_80_6 = 0, var_80_14 - 1 do
					local var_80_15 = var_80_12:GetChild(iter_80_6)

					if var_80_15.name == "" or not string.find(var_80_15.name, "split") then
						var_80_15.gameObject:SetActive(true)
					else
						var_80_15.gameObject:SetActive(false)
					end
				end
			end

			local var_80_16 = 0.001

			if var_80_13 <= arg_77_1.time_ and arg_77_1.time_ < var_80_13 + var_80_16 then
				local var_80_17 = (arg_77_1.time_ - var_80_13) / var_80_16
				local var_80_18 = Vector3.New(0, -2000, 0)

				var_80_12.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos106103, var_80_18, var_80_17)
			end

			if arg_77_1.time_ >= var_80_13 + var_80_16 and arg_77_1.time_ < var_80_13 + var_80_16 + arg_80_0 then
				var_80_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_19 = arg_77_1.actors_["104701"].transform
			local var_80_20 = 0

			if var_80_20 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				arg_77_1.var_.moveOldPos104701 = var_80_19.localPosition
				var_80_19.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("104701", 3)

				local var_80_21 = var_80_19.childCount

				for iter_80_7 = 0, var_80_21 - 1 do
					local var_80_22 = var_80_19:GetChild(iter_80_7)

					if var_80_22.name == "" or not string.find(var_80_22.name, "split") then
						var_80_22.gameObject:SetActive(true)
					else
						var_80_22.gameObject:SetActive(false)
					end
				end
			end

			local var_80_23 = 0.001

			if var_80_20 <= arg_77_1.time_ and arg_77_1.time_ < var_80_20 + var_80_23 then
				local var_80_24 = (arg_77_1.time_ - var_80_20) / var_80_23
				local var_80_25 = Vector3.New(-67.4, -386.8, -295)

				var_80_19.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos104701, var_80_25, var_80_24)
			end

			if arg_77_1.time_ >= var_80_20 + var_80_23 and arg_77_1.time_ < var_80_20 + var_80_23 + arg_80_0 then
				var_80_19.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_80_26 = 0
			local var_80_27 = 0.575

			if var_80_26 < arg_77_1.time_ and arg_77_1.time_ <= var_80_26 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_28 = arg_77_1:FormatText(StoryNameCfg[1296].name)

				arg_77_1.leftNameTxt_.text = var_80_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_29 = arg_77_1:GetWordFromCfg(926041018)
				local var_80_30 = arg_77_1:FormatText(var_80_29.content)

				arg_77_1.text_.text = var_80_30

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_31 = 25
				local var_80_32 = utf8.len(var_80_30)
				local var_80_33 = var_80_31 <= 0 and var_80_27 or var_80_27 * (var_80_32 / var_80_31)

				if var_80_33 > 0 and var_80_27 < var_80_33 then
					arg_77_1.talkMaxDuration = var_80_33

					if var_80_33 + var_80_26 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_33 + var_80_26
					end
				end

				arg_77_1.text_.text = var_80_30
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041018", "story_v_out_926041.awb") ~= 0 then
					local var_80_34 = manager.audio:GetVoiceLength("story_v_out_926041", "926041018", "story_v_out_926041.awb") / 1000

					if var_80_34 + var_80_26 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_34 + var_80_26
					end

					if var_80_29.prefab_name ~= "" and arg_77_1.actors_[var_80_29.prefab_name] ~= nil then
						local var_80_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_29.prefab_name].transform, "story_v_out_926041", "926041018", "story_v_out_926041.awb")

						arg_77_1:RecordAudio("926041018", var_80_35)
						arg_77_1:RecordAudio("926041018", var_80_35)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926041", "926041018", "story_v_out_926041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926041", "926041018", "story_v_out_926041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_36 = math.max(var_80_27, arg_77_1.talkMaxDuration)

			if var_80_26 <= arg_77_1.time_ and arg_77_1.time_ < var_80_26 + var_80_36 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_26) / var_80_36

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_26 + var_80_36 and arg_77_1.time_ < var_80_26 + var_80_36 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play926041019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926041019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play926041020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["104701"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps104701 == nil then
				arg_81_1.var_.actorSpriteComps104701 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps104701 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 0.5, var_84_3)

								iter_84_1.color = Color.New(var_84_7, var_84_7, var_84_7)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps104701 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps104701 = nil
			end

			local var_84_8 = 0
			local var_84_9 = 0.35

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_10 = arg_81_1:FormatText(StoryNameCfg[7].name)

				arg_81_1.leftNameTxt_.text = var_84_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_11 = arg_81_1:GetWordFromCfg(926041019)
				local var_84_12 = arg_81_1:FormatText(var_84_11.content)

				arg_81_1.text_.text = var_84_12

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 14
				local var_84_14 = utf8.len(var_84_12)
				local var_84_15 = var_84_13 <= 0 and var_84_9 or var_84_9 * (var_84_14 / var_84_13)

				if var_84_15 > 0 and var_84_9 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_12
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play926041020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 926041020
		arg_85_1.duration_ = 8.6

		local var_85_0 = {
			zh = 7.266,
			ja = 8.6
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play926041021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10144"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10144 == nil then
				arg_85_1.var_.actorSpriteComps10144 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10144 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 1, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10144 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10144 = nil
			end

			local var_88_8 = arg_85_1.actors_["10144"].transform
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1.var_.moveOldPos10144 = var_88_8.localPosition
				var_88_8.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10144", 3)

				local var_88_10 = var_88_8.childCount

				for iter_88_4 = 0, var_88_10 - 1 do
					local var_88_11 = var_88_8:GetChild(iter_88_4)

					if var_88_11.name == "" or not string.find(var_88_11.name, "split") then
						var_88_11.gameObject:SetActive(true)
					else
						var_88_11.gameObject:SetActive(false)
					end
				end
			end

			local var_88_12 = 0.001

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_12 then
				local var_88_13 = (arg_85_1.time_ - var_88_9) / var_88_12
				local var_88_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_88_8.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10144, var_88_14, var_88_13)
			end

			if arg_85_1.time_ >= var_88_9 + var_88_12 and arg_85_1.time_ < var_88_9 + var_88_12 + arg_88_0 then
				var_88_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_88_15 = 0
			local var_88_16 = 1.025

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[1297].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(926041020)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 41
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041020", "story_v_out_926041.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_926041", "926041020", "story_v_out_926041.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_926041", "926041020", "story_v_out_926041.awb")

						arg_85_1:RecordAudio("926041020", var_88_24)
						arg_85_1:RecordAudio("926041020", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_926041", "926041020", "story_v_out_926041.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_926041", "926041020", "story_v_out_926041.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play926041021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 926041021
		arg_89_1.duration_ = 7.27

		local var_89_0 = {
			zh = 4,
			ja = 7.266
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
				arg_89_0:Play926041022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["128404"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps128404 == nil then
				arg_89_1.var_.actorSpriteComps128404 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps128404 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps128404 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps128404 = nil
			end

			local var_92_8 = arg_89_1.actors_["10144"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10144 == nil then
				arg_89_1.var_.actorSpriteComps10144 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps10144 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								local var_92_12 = Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, var_92_11)
								local var_92_13 = Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, var_92_11)
								local var_92_14 = Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, var_92_11)

								iter_92_5.color = Color.New(var_92_12, var_92_13, var_92_14)
							else
								local var_92_15 = Mathf.Lerp(iter_92_5.color.r, 0.5, var_92_11)

								iter_92_5.color = Color.New(var_92_15, var_92_15, var_92_15)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10144 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10144 = nil
			end

			local var_92_16 = arg_89_1.actors_["10144"].transform
			local var_92_17 = 0

			if var_92_17 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 then
				arg_89_1.var_.moveOldPos10144 = var_92_16.localPosition
				var_92_16.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10144", 7)

				local var_92_18 = var_92_16.childCount

				for iter_92_8 = 0, var_92_18 - 1 do
					local var_92_19 = var_92_16:GetChild(iter_92_8)

					if var_92_19.name == "" or not string.find(var_92_19.name, "split") then
						var_92_19.gameObject:SetActive(true)
					else
						var_92_19.gameObject:SetActive(false)
					end
				end
			end

			local var_92_20 = 0.001

			if var_92_17 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_20 then
				local var_92_21 = (arg_89_1.time_ - var_92_17) / var_92_20
				local var_92_22 = Vector3.New(0, -2000, 0)

				var_92_16.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10144, var_92_22, var_92_21)
			end

			if arg_89_1.time_ >= var_92_17 + var_92_20 and arg_89_1.time_ < var_92_17 + var_92_20 + arg_92_0 then
				var_92_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_92_23 = arg_89_1.actors_["128404"].transform
			local var_92_24 = 0

			if var_92_24 < arg_89_1.time_ and arg_89_1.time_ <= var_92_24 + arg_92_0 then
				arg_89_1.var_.moveOldPos128404 = var_92_23.localPosition
				var_92_23.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("128404", 3)

				local var_92_25 = var_92_23.childCount

				for iter_92_9 = 0, var_92_25 - 1 do
					local var_92_26 = var_92_23:GetChild(iter_92_9)

					if var_92_26.name == "" or not string.find(var_92_26.name, "split") then
						var_92_26.gameObject:SetActive(true)
					else
						var_92_26.gameObject:SetActive(false)
					end
				end
			end

			local var_92_27 = 0.001

			if var_92_24 <= arg_89_1.time_ and arg_89_1.time_ < var_92_24 + var_92_27 then
				local var_92_28 = (arg_89_1.time_ - var_92_24) / var_92_27
				local var_92_29 = Vector3.New(-16.1, -362, -375)

				var_92_23.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos128404, var_92_29, var_92_28)
			end

			if arg_89_1.time_ >= var_92_24 + var_92_27 and arg_89_1.time_ < var_92_24 + var_92_27 + arg_92_0 then
				var_92_23.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_92_30 = 0
			local var_92_31 = 0.5

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_32 = arg_89_1:FormatText(StoryNameCfg[6].name)

				arg_89_1.leftNameTxt_.text = var_92_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_33 = arg_89_1:GetWordFromCfg(926041021)
				local var_92_34 = arg_89_1:FormatText(var_92_33.content)

				arg_89_1.text_.text = var_92_34

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_35 = 20
				local var_92_36 = utf8.len(var_92_34)
				local var_92_37 = var_92_35 <= 0 and var_92_31 or var_92_31 * (var_92_36 / var_92_35)

				if var_92_37 > 0 and var_92_31 < var_92_37 then
					arg_89_1.talkMaxDuration = var_92_37

					if var_92_37 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_37 + var_92_30
					end
				end

				arg_89_1.text_.text = var_92_34
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041021", "story_v_out_926041.awb") ~= 0 then
					local var_92_38 = manager.audio:GetVoiceLength("story_v_out_926041", "926041021", "story_v_out_926041.awb") / 1000

					if var_92_38 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_38 + var_92_30
					end

					if var_92_33.prefab_name ~= "" and arg_89_1.actors_[var_92_33.prefab_name] ~= nil then
						local var_92_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_33.prefab_name].transform, "story_v_out_926041", "926041021", "story_v_out_926041.awb")

						arg_89_1:RecordAudio("926041021", var_92_39)
						arg_89_1:RecordAudio("926041021", var_92_39)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_926041", "926041021", "story_v_out_926041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_926041", "926041021", "story_v_out_926041.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_40 = math.max(var_92_31, arg_89_1.talkMaxDuration)

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_40 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_30) / var_92_40

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_30 + var_92_40 and arg_89_1.time_ < var_92_30 + var_92_40 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
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
	Play926041022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926041022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play926041023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["128404"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps128404 == nil then
				arg_93_1.var_.actorSpriteComps128404 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps128404 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps128404 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps128404 = nil
			end

			local var_96_8 = arg_93_1.actors_["128404"].transform
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 then
				arg_93_1.var_.moveOldPos128404 = var_96_8.localPosition
				var_96_8.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("128404", 7)

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

				var_96_8.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos128404, var_96_14, var_96_13)
			end

			if arg_93_1.time_ >= var_96_9 + var_96_12 and arg_93_1.time_ < var_96_9 + var_96_12 + arg_96_0 then
				var_96_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_96_15 = 0.034
			local var_96_16 = 1

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				local var_96_17 = "play"
				local var_96_18 = "effect"

				arg_93_1:AudioAction(var_96_17, var_96_18, "se_story_122_03", "se_story_122_03_swordlightbroken", "")
			end

			local var_96_19 = 0
			local var_96_20 = 1.525

			if var_96_19 < arg_93_1.time_ and arg_93_1.time_ <= var_96_19 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_21 = arg_93_1:GetWordFromCfg(926041022)
				local var_96_22 = arg_93_1:FormatText(var_96_21.content)

				arg_93_1.text_.text = var_96_22

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_23 = 61
				local var_96_24 = utf8.len(var_96_22)
				local var_96_25 = var_96_23 <= 0 and var_96_20 or var_96_20 * (var_96_24 / var_96_23)

				if var_96_25 > 0 and var_96_20 < var_96_25 then
					arg_93_1.talkMaxDuration = var_96_25

					if var_96_25 + var_96_19 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_25 + var_96_19
					end
				end

				arg_93_1.text_.text = var_96_22
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_26 = math.max(var_96_20, arg_93_1.talkMaxDuration)

			if var_96_19 <= arg_93_1.time_ and arg_93_1.time_ < var_96_19 + var_96_26 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_19) / var_96_26

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_19 + var_96_26 and arg_93_1.time_ < var_96_19 + var_96_26 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926041023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926041023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play926041024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.8
			local var_100_1 = 1

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				local var_100_2 = "play"
				local var_100_3 = "effect"

				arg_97_1:AudioAction(var_100_2, var_100_3, "se_story_16", "se_story_16_fall02", "")
			end

			local var_100_4 = manager.ui.mainCamera.transform
			local var_100_5 = 0.8

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.var_.shakeOldPos = var_100_4.localPosition
			end

			local var_100_6 = 1

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_6 then
				local var_100_7 = (arg_97_1.time_ - var_100_5) / 0.066
				local var_100_8, var_100_9 = math.modf(var_100_7)

				var_100_4.localPosition = Vector3.New(var_100_9 * 0.13, var_100_9 * 0.13, var_100_9 * 0.13) + arg_97_1.var_.shakeOldPos
			end

			if arg_97_1.time_ >= var_100_5 + var_100_6 and arg_97_1.time_ < var_100_5 + var_100_6 + arg_100_0 then
				var_100_4.localPosition = arg_97_1.var_.shakeOldPos
			end

			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			local var_100_11 = 1.8

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_12 = 0
			local var_100_13 = 1.625

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_14 = arg_97_1:GetWordFromCfg(926041023)
				local var_100_15 = arg_97_1:FormatText(var_100_14.content)

				arg_97_1.text_.text = var_100_15

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 65
				local var_100_17 = utf8.len(var_100_15)
				local var_100_18 = var_100_16 <= 0 and var_100_13 or var_100_13 * (var_100_17 / var_100_16)

				if var_100_18 > 0 and var_100_13 < var_100_18 then
					arg_97_1.talkMaxDuration = var_100_18

					if var_100_18 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_12
					end
				end

				arg_97_1.text_.text = var_100_15
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_19 = math.max(var_100_13, arg_97_1.talkMaxDuration)

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_19 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_12) / var_100_19

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_12 + var_100_19 and arg_97_1.time_ < var_100_12 + var_100_19 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play926041024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926041024
		arg_101_1.duration_ = 7.8

		local var_101_0 = {
			zh = 5.56666666666667,
			ja = 7.79966666666667
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
				arg_101_0:Play926041025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["128404"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps128404 == nil then
				arg_101_1.var_.actorSpriteComps128404 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps128404 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 1, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps128404 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps128404 = nil
			end

			local var_104_8 = arg_101_1.actors_["128404"].transform
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.var_.moveOldPos128404 = var_104_8.localPosition
				var_104_8.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("128404", 3)

				local var_104_10 = var_104_8.childCount

				for iter_104_4 = 0, var_104_10 - 1 do
					local var_104_11 = var_104_8:GetChild(iter_104_4)

					if var_104_11.name == "split_4" or not string.find(var_104_11.name, "split") then
						var_104_11.gameObject:SetActive(true)
					else
						var_104_11.gameObject:SetActive(false)
					end
				end
			end

			local var_104_12 = 0.466666666666667

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_12 then
				local var_104_13 = (arg_101_1.time_ - var_104_9) / var_104_12
				local var_104_14 = Vector3.New(-37, -369.1, -352.4)

				var_104_8.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos128404, var_104_14, var_104_13)
			end

			if arg_101_1.time_ >= var_104_9 + var_104_12 and arg_101_1.time_ < var_104_9 + var_104_12 + arg_104_0 then
				var_104_8.localPosition = Vector3.New(-37, -369.1, -352.4)
			end

			local var_104_15 = 0

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			local var_104_16 = 0.866666666666667

			if arg_101_1.time_ >= var_104_15 + var_104_16 and arg_101_1.time_ < var_104_15 + var_104_16 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_17 = arg_101_1.actors_["128404"].transform
			local var_104_18 = 0.466666666666667

			if var_104_18 < arg_101_1.time_ and arg_101_1.time_ <= var_104_18 + arg_104_0 then
				arg_101_1.var_.moveOldPos128404 = var_104_17.localPosition
				var_104_17.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("128404", 3)

				local var_104_19 = var_104_17.childCount

				for iter_104_5 = 0, var_104_19 - 1 do
					local var_104_20 = var_104_17:GetChild(iter_104_5)

					if var_104_20.name == "split_4" or not string.find(var_104_20.name, "split") then
						var_104_20.gameObject:SetActive(true)
					else
						var_104_20.gameObject:SetActive(false)
					end
				end
			end

			local var_104_21 = 0.1

			if var_104_18 <= arg_101_1.time_ and arg_101_1.time_ < var_104_18 + var_104_21 then
				local var_104_22 = (arg_101_1.time_ - var_104_18) / var_104_21
				local var_104_23 = Vector3.New(-37, -361, -352.4)

				var_104_17.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos128404, var_104_23, var_104_22)
			end

			if arg_101_1.time_ >= var_104_18 + var_104_21 and arg_101_1.time_ < var_104_18 + var_104_21 + arg_104_0 then
				var_104_17.localPosition = Vector3.New(-37, -361, -352.4)
			end

			local var_104_24 = arg_101_1.actors_["128404"].transform
			local var_104_25 = 0.566666666666667

			if var_104_25 < arg_101_1.time_ and arg_101_1.time_ <= var_104_25 + arg_104_0 then
				arg_101_1.var_.moveOldPos128404 = var_104_24.localPosition
				var_104_24.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("128404", 3)

				local var_104_26 = var_104_24.childCount

				for iter_104_6 = 0, var_104_26 - 1 do
					local var_104_27 = var_104_24:GetChild(iter_104_6)

					if var_104_27.name == "split_4" or not string.find(var_104_27.name, "split") then
						var_104_27.gameObject:SetActive(true)
					else
						var_104_27.gameObject:SetActive(false)
					end
				end
			end

			local var_104_28 = 0.133333333333333

			if var_104_25 <= arg_101_1.time_ and arg_101_1.time_ < var_104_25 + var_104_28 then
				local var_104_29 = (arg_101_1.time_ - var_104_25) / var_104_28
				local var_104_30 = Vector3.New(-37, -369.1, -352.4)

				var_104_24.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos128404, var_104_30, var_104_29)
			end

			if arg_101_1.time_ >= var_104_25 + var_104_28 and arg_101_1.time_ < var_104_25 + var_104_28 + arg_104_0 then
				var_104_24.localPosition = Vector3.New(-37, -369.1, -352.4)
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_31 = 0.766666666666667
			local var_104_32 = 0.625

			if var_104_31 < arg_101_1.time_ and arg_101_1.time_ <= var_104_31 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_33 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_33:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_34 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_35 = arg_101_1:GetWordFromCfg(926041024)
				local var_104_36 = arg_101_1:FormatText(var_104_35.content)

				arg_101_1.text_.text = var_104_36

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_37 = 25
				local var_104_38 = utf8.len(var_104_36)
				local var_104_39 = var_104_37 <= 0 and var_104_32 or var_104_32 * (var_104_38 / var_104_37)

				if var_104_39 > 0 and var_104_32 < var_104_39 then
					arg_101_1.talkMaxDuration = var_104_39
					var_104_31 = var_104_31 + 0.3

					if var_104_39 + var_104_31 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_39 + var_104_31
					end
				end

				arg_101_1.text_.text = var_104_36
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041024", "story_v_out_926041.awb") ~= 0 then
					local var_104_40 = manager.audio:GetVoiceLength("story_v_out_926041", "926041024", "story_v_out_926041.awb") / 1000

					if var_104_40 + var_104_31 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_40 + var_104_31
					end

					if var_104_35.prefab_name ~= "" and arg_101_1.actors_[var_104_35.prefab_name] ~= nil then
						local var_104_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_35.prefab_name].transform, "story_v_out_926041", "926041024", "story_v_out_926041.awb")

						arg_101_1:RecordAudio("926041024", var_104_41)
						arg_101_1:RecordAudio("926041024", var_104_41)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_926041", "926041024", "story_v_out_926041.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_926041", "926041024", "story_v_out_926041.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_42 = var_104_31 + 0.3
			local var_104_43 = math.max(var_104_32, arg_101_1.talkMaxDuration)

			if var_104_42 <= arg_101_1.time_ and arg_101_1.time_ < var_104_42 + var_104_43 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_42) / var_104_43

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_42 + var_104_43 and arg_101_1.time_ < var_104_42 + var_104_43 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.466666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.562,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-28.04, -1698.3, -265.92),
					endPos = Vector3.New(-37, -369.1, -352.4),
					easeType = LeanTweenType.easeInQuad
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.1,
				startTime = 0.466666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-37, -369.1, -352.4),
					endPos = Vector3.New(-37, -361, -352.4),
					easeType = LeanTweenType.easeInQuad
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.133333333333333,
				startTime = 0.566666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-37, -361, -352.4),
					endPos = Vector3.New(-37, -369.1, -352.4),
					easeType = LeanTweenType.easeInQuad
				}
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play926041025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 926041025
		arg_107_1.duration_ = 4.2

		local var_107_0 = {
			zh = 3.833,
			ja = 4.2
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play926041026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["106603"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps106603 == nil then
				arg_107_1.var_.actorSpriteComps106603 = var_110_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_2 = 0.2

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.actorSpriteComps106603 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								local var_110_4 = Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor1.r, var_110_3)
								local var_110_5 = Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor1.g, var_110_3)
								local var_110_6 = Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor1.b, var_110_3)

								iter_110_1.color = Color.New(var_110_4, var_110_5, var_110_6)
							else
								local var_110_7 = Mathf.Lerp(iter_110_1.color.r, 1, var_110_3)

								iter_110_1.color = Color.New(var_110_7, var_110_7, var_110_7)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.actorSpriteComps106603 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_110_3 then
						if arg_107_1.isInRecall_ then
							iter_110_3.color = arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_110_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps106603 = nil
			end

			local var_110_8 = arg_107_1.actors_["128404"]
			local var_110_9 = 0

			if var_110_9 < arg_107_1.time_ and arg_107_1.time_ <= var_110_9 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps128404 == nil then
				arg_107_1.var_.actorSpriteComps128404 = var_110_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_10 = 0.2

			if var_110_9 <= arg_107_1.time_ and arg_107_1.time_ < var_110_9 + var_110_10 and not isNil(var_110_8) then
				local var_110_11 = (arg_107_1.time_ - var_110_9) / var_110_10

				if arg_107_1.var_.actorSpriteComps128404 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_110_5 then
							if arg_107_1.isInRecall_ then
								local var_110_12 = Mathf.Lerp(iter_110_5.color.r, arg_107_1.hightColor2.r, var_110_11)
								local var_110_13 = Mathf.Lerp(iter_110_5.color.g, arg_107_1.hightColor2.g, var_110_11)
								local var_110_14 = Mathf.Lerp(iter_110_5.color.b, arg_107_1.hightColor2.b, var_110_11)

								iter_110_5.color = Color.New(var_110_12, var_110_13, var_110_14)
							else
								local var_110_15 = Mathf.Lerp(iter_110_5.color.r, 0.5, var_110_11)

								iter_110_5.color = Color.New(var_110_15, var_110_15, var_110_15)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= var_110_9 + var_110_10 and arg_107_1.time_ < var_110_9 + var_110_10 + arg_110_0 and not isNil(var_110_8) and arg_107_1.var_.actorSpriteComps128404 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_110_7 then
						if arg_107_1.isInRecall_ then
							iter_110_7.color = arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_110_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_107_1.var_.actorSpriteComps128404 = nil
			end

			local var_110_16 = arg_107_1.actors_["128404"].transform
			local var_110_17 = 0

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 then
				arg_107_1.var_.moveOldPos128404 = var_110_16.localPosition
				var_110_16.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("128404", 7)

				local var_110_18 = var_110_16.childCount

				for iter_110_8 = 0, var_110_18 - 1 do
					local var_110_19 = var_110_16:GetChild(iter_110_8)

					if var_110_19.name == "" or not string.find(var_110_19.name, "split") then
						var_110_19.gameObject:SetActive(true)
					else
						var_110_19.gameObject:SetActive(false)
					end
				end
			end

			local var_110_20 = 0.001

			if var_110_17 <= arg_107_1.time_ and arg_107_1.time_ < var_110_17 + var_110_20 then
				local var_110_21 = (arg_107_1.time_ - var_110_17) / var_110_20
				local var_110_22 = Vector3.New(0, -2000, 0)

				var_110_16.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos128404, var_110_22, var_110_21)
			end

			if arg_107_1.time_ >= var_110_17 + var_110_20 and arg_107_1.time_ < var_110_17 + var_110_20 + arg_110_0 then
				var_110_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_110_23 = arg_107_1.actors_["106603"].transform
			local var_110_24 = 0

			if var_110_24 < arg_107_1.time_ and arg_107_1.time_ <= var_110_24 + arg_110_0 then
				arg_107_1.var_.moveOldPos106603 = var_110_23.localPosition
				var_110_23.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("106603", 3)

				local var_110_25 = var_110_23.childCount

				for iter_110_9 = 0, var_110_25 - 1 do
					local var_110_26 = var_110_23:GetChild(iter_110_9)

					if var_110_26.name == "split_1" or not string.find(var_110_26.name, "split") then
						var_110_26.gameObject:SetActive(true)
					else
						var_110_26.gameObject:SetActive(false)
					end
				end
			end

			local var_110_27 = 0.001

			if var_110_24 <= arg_107_1.time_ and arg_107_1.time_ < var_110_24 + var_110_27 then
				local var_110_28 = (arg_107_1.time_ - var_110_24) / var_110_27
				local var_110_29 = Vector3.New(-77.5, -399.1, -303.3)

				var_110_23.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos106603, var_110_29, var_110_28)
			end

			if arg_107_1.time_ >= var_110_24 + var_110_27 and arg_107_1.time_ < var_110_24 + var_110_27 + arg_110_0 then
				var_110_23.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_110_30 = 0
			local var_110_31 = 0.4

			if var_110_30 < arg_107_1.time_ and arg_107_1.time_ <= var_110_30 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_32 = arg_107_1:FormatText(StoryNameCfg[32].name)

				arg_107_1.leftNameTxt_.text = var_110_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_33 = arg_107_1:GetWordFromCfg(926041025)
				local var_110_34 = arg_107_1:FormatText(var_110_33.content)

				arg_107_1.text_.text = var_110_34

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_35 = 16
				local var_110_36 = utf8.len(var_110_34)
				local var_110_37 = var_110_35 <= 0 and var_110_31 or var_110_31 * (var_110_36 / var_110_35)

				if var_110_37 > 0 and var_110_31 < var_110_37 then
					arg_107_1.talkMaxDuration = var_110_37

					if var_110_37 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_37 + var_110_30
					end
				end

				arg_107_1.text_.text = var_110_34
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041025", "story_v_out_926041.awb") ~= 0 then
					local var_110_38 = manager.audio:GetVoiceLength("story_v_out_926041", "926041025", "story_v_out_926041.awb") / 1000

					if var_110_38 + var_110_30 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_38 + var_110_30
					end

					if var_110_33.prefab_name ~= "" and arg_107_1.actors_[var_110_33.prefab_name] ~= nil then
						local var_110_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_33.prefab_name].transform, "story_v_out_926041", "926041025", "story_v_out_926041.awb")

						arg_107_1:RecordAudio("926041025", var_110_39)
						arg_107_1:RecordAudio("926041025", var_110_39)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_926041", "926041025", "story_v_out_926041.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_926041", "926041025", "story_v_out_926041.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_40 = math.max(var_110_31, arg_107_1.talkMaxDuration)

			if var_110_30 <= arg_107_1.time_ and arg_107_1.time_ < var_110_30 + var_110_40 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_30) / var_110_40

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_30 + var_110_40 and arg_107_1.time_ < var_110_30 + var_110_40 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play926041026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 926041026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play926041027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["106603"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps106603 == nil then
				arg_111_1.var_.actorSpriteComps106603 = var_114_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_2 = 0.2

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.actorSpriteComps106603 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								local var_114_4 = Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor2.r, var_114_3)
								local var_114_5 = Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor2.g, var_114_3)
								local var_114_6 = Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor2.b, var_114_3)

								iter_114_1.color = Color.New(var_114_4, var_114_5, var_114_6)
							else
								local var_114_7 = Mathf.Lerp(iter_114_1.color.r, 0.5, var_114_3)

								iter_114_1.color = Color.New(var_114_7, var_114_7, var_114_7)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.actorSpriteComps106603 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_114_3 then
						if arg_111_1.isInRecall_ then
							iter_114_3.color = arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_114_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps106603 = nil
			end

			local var_114_8 = 0
			local var_114_9 = 0.275

			if var_114_8 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_10 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_11 = arg_111_1:GetWordFromCfg(926041026)
				local var_114_12 = arg_111_1:FormatText(var_114_11.content)

				arg_111_1.text_.text = var_114_12

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 11
				local var_114_14 = utf8.len(var_114_12)
				local var_114_15 = var_114_13 <= 0 and var_114_9 or var_114_9 * (var_114_14 / var_114_13)

				if var_114_15 > 0 and var_114_9 < var_114_15 then
					arg_111_1.talkMaxDuration = var_114_15

					if var_114_15 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_12
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_16 and arg_111_1.time_ < var_114_8 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play926041027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 926041027
		arg_115_1.duration_ = 9.17

		local var_115_0 = {
			zh = 7.266,
			ja = 9.166
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
				arg_115_0:Play926041028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["106103"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps106103 == nil then
				arg_115_1.var_.actorSpriteComps106103 = var_118_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_2 = 0.2

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.actorSpriteComps106103 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_118_1 then
							if arg_115_1.isInRecall_ then
								local var_118_4 = Mathf.Lerp(iter_118_1.color.r, arg_115_1.hightColor1.r, var_118_3)
								local var_118_5 = Mathf.Lerp(iter_118_1.color.g, arg_115_1.hightColor1.g, var_118_3)
								local var_118_6 = Mathf.Lerp(iter_118_1.color.b, arg_115_1.hightColor1.b, var_118_3)

								iter_118_1.color = Color.New(var_118_4, var_118_5, var_118_6)
							else
								local var_118_7 = Mathf.Lerp(iter_118_1.color.r, 1, var_118_3)

								iter_118_1.color = Color.New(var_118_7, var_118_7, var_118_7)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.actorSpriteComps106103 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_118_3 then
						if arg_115_1.isInRecall_ then
							iter_118_3.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps106103 = nil
			end

			local var_118_8 = arg_115_1.actors_["106603"].transform
			local var_118_9 = 0

			if var_118_9 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.var_.moveOldPos106603 = var_118_8.localPosition
				var_118_8.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("106603", 4)

				local var_118_10 = var_118_8.childCount

				for iter_118_4 = 0, var_118_10 - 1 do
					local var_118_11 = var_118_8:GetChild(iter_118_4)

					if var_118_11.name == "" or not string.find(var_118_11.name, "split") then
						var_118_11.gameObject:SetActive(true)
					else
						var_118_11.gameObject:SetActive(false)
					end
				end
			end

			local var_118_12 = 0.001

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_12 then
				local var_118_13 = (arg_115_1.time_ - var_118_9) / var_118_12
				local var_118_14 = Vector3.New(453.9, -399.1, -303.3)

				var_118_8.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos106603, var_118_14, var_118_13)
			end

			if arg_115_1.time_ >= var_118_9 + var_118_12 and arg_115_1.time_ < var_118_9 + var_118_12 + arg_118_0 then
				var_118_8.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_118_15 = arg_115_1.actors_["106103"].transform
			local var_118_16 = 0

			if var_118_16 < arg_115_1.time_ and arg_115_1.time_ <= var_118_16 + arg_118_0 then
				arg_115_1.var_.moveOldPos106103 = var_118_15.localPosition
				var_118_15.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("106103", 2)

				local var_118_17 = var_118_15.childCount

				for iter_118_5 = 0, var_118_17 - 1 do
					local var_118_18 = var_118_15:GetChild(iter_118_5)

					if var_118_18.name == "" or not string.find(var_118_18.name, "split") then
						var_118_18.gameObject:SetActive(true)
					else
						var_118_18.gameObject:SetActive(false)
					end
				end
			end

			local var_118_19 = 0.001

			if var_118_16 <= arg_115_1.time_ and arg_115_1.time_ < var_118_16 + var_118_19 then
				local var_118_20 = (arg_115_1.time_ - var_118_16) / var_118_19
				local var_118_21 = Vector3.New(-428.4, -398.2, -333.7)

				var_118_15.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos106103, var_118_21, var_118_20)
			end

			if arg_115_1.time_ >= var_118_16 + var_118_19 and arg_115_1.time_ < var_118_16 + var_118_19 + arg_118_0 then
				var_118_15.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_118_22 = 0
			local var_118_23 = 0.825

			if var_118_22 < arg_115_1.time_ and arg_115_1.time_ <= var_118_22 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_24 = arg_115_1:FormatText(StoryNameCfg[612].name)

				arg_115_1.leftNameTxt_.text = var_118_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_25 = arg_115_1:GetWordFromCfg(926041027)
				local var_118_26 = arg_115_1:FormatText(var_118_25.content)

				arg_115_1.text_.text = var_118_26

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_27 = 33
				local var_118_28 = utf8.len(var_118_26)
				local var_118_29 = var_118_27 <= 0 and var_118_23 or var_118_23 * (var_118_28 / var_118_27)

				if var_118_29 > 0 and var_118_23 < var_118_29 then
					arg_115_1.talkMaxDuration = var_118_29

					if var_118_29 + var_118_22 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_29 + var_118_22
					end
				end

				arg_115_1.text_.text = var_118_26
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041027", "story_v_out_926041.awb") ~= 0 then
					local var_118_30 = manager.audio:GetVoiceLength("story_v_out_926041", "926041027", "story_v_out_926041.awb") / 1000

					if var_118_30 + var_118_22 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_30 + var_118_22
					end

					if var_118_25.prefab_name ~= "" and arg_115_1.actors_[var_118_25.prefab_name] ~= nil then
						local var_118_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_25.prefab_name].transform, "story_v_out_926041", "926041027", "story_v_out_926041.awb")

						arg_115_1:RecordAudio("926041027", var_118_31)
						arg_115_1:RecordAudio("926041027", var_118_31)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_926041", "926041027", "story_v_out_926041.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_926041", "926041027", "story_v_out_926041.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_32 = math.max(var_118_23, arg_115_1.talkMaxDuration)

			if var_118_22 <= arg_115_1.time_ and arg_115_1.time_ < var_118_22 + var_118_32 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_22) / var_118_32

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_22 + var_118_32 and arg_115_1.time_ < var_118_22 + var_118_32 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
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
	Play926041028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 926041028
		arg_119_1.duration_ = 9.7

		local var_119_0 = {
			zh = 6.466,
			ja = 9.7
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
				arg_119_0:Play926041029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["106603"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps106603 == nil then
				arg_119_1.var_.actorSpriteComps106603 = var_122_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_2 = 0.2

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.actorSpriteComps106603 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								local var_122_4 = Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, var_122_3)
								local var_122_5 = Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, var_122_3)
								local var_122_6 = Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, var_122_3)

								iter_122_1.color = Color.New(var_122_4, var_122_5, var_122_6)
							else
								local var_122_7 = Mathf.Lerp(iter_122_1.color.r, 1, var_122_3)

								iter_122_1.color = Color.New(var_122_7, var_122_7, var_122_7)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.actorSpriteComps106603 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_122_3 then
						if arg_119_1.isInRecall_ then
							iter_122_3.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps106603 = nil
			end

			local var_122_8 = arg_119_1.actors_["106103"]
			local var_122_9 = 0

			if var_122_9 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps106103 == nil then
				arg_119_1.var_.actorSpriteComps106103 = var_122_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_10 = 0.2

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_10 and not isNil(var_122_8) then
				local var_122_11 = (arg_119_1.time_ - var_122_9) / var_122_10

				if arg_119_1.var_.actorSpriteComps106103 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								local var_122_12 = Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, var_122_11)
								local var_122_13 = Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, var_122_11)
								local var_122_14 = Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, var_122_11)

								iter_122_5.color = Color.New(var_122_12, var_122_13, var_122_14)
							else
								local var_122_15 = Mathf.Lerp(iter_122_5.color.r, 0.5, var_122_11)

								iter_122_5.color = Color.New(var_122_15, var_122_15, var_122_15)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_9 + var_122_10 and arg_119_1.time_ < var_122_9 + var_122_10 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps106103 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_122_7 then
						if arg_119_1.isInRecall_ then
							iter_122_7.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps106103 = nil
			end

			local var_122_16 = 0
			local var_122_17 = 0.775

			if var_122_16 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_18 = arg_119_1:FormatText(StoryNameCfg[32].name)

				arg_119_1.leftNameTxt_.text = var_122_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_19 = arg_119_1:GetWordFromCfg(926041028)
				local var_122_20 = arg_119_1:FormatText(var_122_19.content)

				arg_119_1.text_.text = var_122_20

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_21 = 31
				local var_122_22 = utf8.len(var_122_20)
				local var_122_23 = var_122_21 <= 0 and var_122_17 or var_122_17 * (var_122_22 / var_122_21)

				if var_122_23 > 0 and var_122_17 < var_122_23 then
					arg_119_1.talkMaxDuration = var_122_23

					if var_122_23 + var_122_16 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_16
					end
				end

				arg_119_1.text_.text = var_122_20
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041028", "story_v_out_926041.awb") ~= 0 then
					local var_122_24 = manager.audio:GetVoiceLength("story_v_out_926041", "926041028", "story_v_out_926041.awb") / 1000

					if var_122_24 + var_122_16 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_24 + var_122_16
					end

					if var_122_19.prefab_name ~= "" and arg_119_1.actors_[var_122_19.prefab_name] ~= nil then
						local var_122_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_19.prefab_name].transform, "story_v_out_926041", "926041028", "story_v_out_926041.awb")

						arg_119_1:RecordAudio("926041028", var_122_25)
						arg_119_1:RecordAudio("926041028", var_122_25)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_926041", "926041028", "story_v_out_926041.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_926041", "926041028", "story_v_out_926041.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_26 = math.max(var_122_17, arg_119_1.talkMaxDuration)

			if var_122_16 <= arg_119_1.time_ and arg_119_1.time_ < var_122_16 + var_122_26 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_16) / var_122_26

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_16 + var_122_26 and arg_119_1.time_ < var_122_16 + var_122_26 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play926041029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 926041029
		arg_123_1.duration_ = 12.2

		local var_123_0 = {
			zh = 6.033,
			ja = 12.2
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
				arg_123_0:Play926041030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["106603"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos106603 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("106603", 4)

				local var_126_2 = var_126_0.childCount

				for iter_126_0 = 0, var_126_2 - 1 do
					local var_126_3 = var_126_0:GetChild(iter_126_0)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_4 then
				local var_126_5 = (arg_123_1.time_ - var_126_1) / var_126_4
				local var_126_6 = Vector3.New(453.9, -399.1, -303.3)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos106603, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(453.9, -399.1, -303.3)
			end

			local var_126_7 = 0
			local var_126_8 = 0.725

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_9 = arg_123_1:FormatText(StoryNameCfg[32].name)

				arg_123_1.leftNameTxt_.text = var_126_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(926041029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 29
				local var_126_13 = utf8.len(var_126_11)
				local var_126_14 = var_126_12 <= 0 and var_126_8 or var_126_8 * (var_126_13 / var_126_12)

				if var_126_14 > 0 and var_126_8 < var_126_14 then
					arg_123_1.talkMaxDuration = var_126_14

					if var_126_14 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_7
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041029", "story_v_out_926041.awb") ~= 0 then
					local var_126_15 = manager.audio:GetVoiceLength("story_v_out_926041", "926041029", "story_v_out_926041.awb") / 1000

					if var_126_15 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_7
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_926041", "926041029", "story_v_out_926041.awb")

						arg_123_1:RecordAudio("926041029", var_126_16)
						arg_123_1:RecordAudio("926041029", var_126_16)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_926041", "926041029", "story_v_out_926041.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_926041", "926041029", "story_v_out_926041.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_17 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_17 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_7) / var_126_17

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_7 + var_126_17 and arg_123_1.time_ < var_126_7 + var_126_17 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play926041030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 926041030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play926041031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["106603"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps106603 == nil then
				arg_127_1.var_.actorSpriteComps106603 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 0.2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps106603 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor2.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor2.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor2.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 0.5, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps106603 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps106603 = nil
			end

			local var_130_8 = arg_127_1.actors_["106603"].transform
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.var_.moveOldPos106603 = var_130_8.localPosition
				var_130_8.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("106603", 7)

				local var_130_10 = var_130_8.childCount

				for iter_130_4 = 0, var_130_10 - 1 do
					local var_130_11 = var_130_8:GetChild(iter_130_4)

					if var_130_11.name == "" or not string.find(var_130_11.name, "split") then
						var_130_11.gameObject:SetActive(true)
					else
						var_130_11.gameObject:SetActive(false)
					end
				end
			end

			local var_130_12 = 0.001

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_12 then
				local var_130_13 = (arg_127_1.time_ - var_130_9) / var_130_12
				local var_130_14 = Vector3.New(0, -2000, 0)

				var_130_8.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos106603, var_130_14, var_130_13)
			end

			if arg_127_1.time_ >= var_130_9 + var_130_12 and arg_127_1.time_ < var_130_9 + var_130_12 + arg_130_0 then
				var_130_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_15 = arg_127_1.actors_["106103"].transform
			local var_130_16 = 0

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.var_.moveOldPos106103 = var_130_15.localPosition
				var_130_15.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("106103", 7)

				local var_130_17 = var_130_15.childCount

				for iter_130_5 = 0, var_130_17 - 1 do
					local var_130_18 = var_130_15:GetChild(iter_130_5)

					if var_130_18.name == "" or not string.find(var_130_18.name, "split") then
						var_130_18.gameObject:SetActive(true)
					else
						var_130_18.gameObject:SetActive(false)
					end
				end
			end

			local var_130_19 = 0.001

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_19 then
				local var_130_20 = (arg_127_1.time_ - var_130_16) / var_130_19
				local var_130_21 = Vector3.New(0, -2000, 0)

				var_130_15.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos106103, var_130_21, var_130_20)
			end

			if arg_127_1.time_ >= var_130_16 + var_130_19 and arg_127_1.time_ < var_130_16 + var_130_19 + arg_130_0 then
				var_130_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_22 = 0
			local var_130_23 = 0.725

			if var_130_22 < arg_127_1.time_ and arg_127_1.time_ <= var_130_22 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_24 = arg_127_1:GetWordFromCfg(926041030)
				local var_130_25 = arg_127_1:FormatText(var_130_24.content)

				arg_127_1.text_.text = var_130_25

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_26 = 29
				local var_130_27 = utf8.len(var_130_25)
				local var_130_28 = var_130_26 <= 0 and var_130_23 or var_130_23 * (var_130_27 / var_130_26)

				if var_130_28 > 0 and var_130_23 < var_130_28 then
					arg_127_1.talkMaxDuration = var_130_28

					if var_130_28 + var_130_22 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_28 + var_130_22
					end
				end

				arg_127_1.text_.text = var_130_25
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_29 = math.max(var_130_23, arg_127_1.talkMaxDuration)

			if var_130_22 <= arg_127_1.time_ and arg_127_1.time_ < var_130_22 + var_130_29 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_22) / var_130_29

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_22 + var_130_29 and arg_127_1.time_ < var_130_22 + var_130_29 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play926041031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 926041031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play926041032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.25

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(926041031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 10
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play926041032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 926041032
		arg_135_1.duration_ = 7.4

		local var_135_0 = {
			zh = 4.666,
			ja = 7.4
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
				arg_135_0:Play926041033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["104701"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps104701 == nil then
				arg_135_1.var_.actorSpriteComps104701 = var_138_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_2 = 0.2

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.actorSpriteComps104701 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								local var_138_4 = Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, var_138_3)
								local var_138_5 = Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, var_138_3)
								local var_138_6 = Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, var_138_3)

								iter_138_1.color = Color.New(var_138_4, var_138_5, var_138_6)
							else
								local var_138_7 = Mathf.Lerp(iter_138_1.color.r, 1, var_138_3)

								iter_138_1.color = Color.New(var_138_7, var_138_7, var_138_7)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.actorSpriteComps104701 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_138_3 then
						if arg_135_1.isInRecall_ then
							iter_138_3.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps104701 = nil
			end

			local var_138_8 = arg_135_1.actors_["104701"].transform
			local var_138_9 = 0

			if var_138_9 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.var_.moveOldPos104701 = var_138_8.localPosition
				var_138_8.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("104701", 3)

				local var_138_10 = var_138_8.childCount

				for iter_138_4 = 0, var_138_10 - 1 do
					local var_138_11 = var_138_8:GetChild(iter_138_4)

					if var_138_11.name == "" or not string.find(var_138_11.name, "split") then
						var_138_11.gameObject:SetActive(true)
					else
						var_138_11.gameObject:SetActive(false)
					end
				end
			end

			local var_138_12 = 0.001

			if var_138_9 <= arg_135_1.time_ and arg_135_1.time_ < var_138_9 + var_138_12 then
				local var_138_13 = (arg_135_1.time_ - var_138_9) / var_138_12
				local var_138_14 = Vector3.New(-67.4, -386.8, -295)

				var_138_8.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos104701, var_138_14, var_138_13)
			end

			if arg_135_1.time_ >= var_138_9 + var_138_12 and arg_135_1.time_ < var_138_9 + var_138_12 + arg_138_0 then
				var_138_8.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_138_15 = 0
			local var_138_16 = 0.65

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_17 = arg_135_1:FormatText(StoryNameCfg[1296].name)

				arg_135_1.leftNameTxt_.text = var_138_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_18 = arg_135_1:GetWordFromCfg(926041032)
				local var_138_19 = arg_135_1:FormatText(var_138_18.content)

				arg_135_1.text_.text = var_138_19

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 26
				local var_138_21 = utf8.len(var_138_19)
				local var_138_22 = var_138_20 <= 0 and var_138_16 or var_138_16 * (var_138_21 / var_138_20)

				if var_138_22 > 0 and var_138_16 < var_138_22 then
					arg_135_1.talkMaxDuration = var_138_22

					if var_138_22 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_22 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_19
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041032", "story_v_out_926041.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_926041", "926041032", "story_v_out_926041.awb") / 1000

					if var_138_23 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_15
					end

					if var_138_18.prefab_name ~= "" and arg_135_1.actors_[var_138_18.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_18.prefab_name].transform, "story_v_out_926041", "926041032", "story_v_out_926041.awb")

						arg_135_1:RecordAudio("926041032", var_138_24)
						arg_135_1:RecordAudio("926041032", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_926041", "926041032", "story_v_out_926041.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_926041", "926041032", "story_v_out_926041.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_25 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_25

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_25 and arg_135_1.time_ < var_138_15 + var_138_25 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play926041033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 926041033
		arg_139_1.duration_ = 6.67

		local var_139_0 = {
			zh = 4.733,
			ja = 6.666
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
				arg_139_0:Play926041034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["106603"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps106603 == nil then
				arg_139_1.var_.actorSpriteComps106603 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 0.2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps106603 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 1, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps106603 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps106603 = nil
			end

			local var_142_8 = arg_139_1.actors_["104701"]
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps104701 == nil then
				arg_139_1.var_.actorSpriteComps104701 = var_142_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_10 = 0.2

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_10 and not isNil(var_142_8) then
				local var_142_11 = (arg_139_1.time_ - var_142_9) / var_142_10

				if arg_139_1.var_.actorSpriteComps104701 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								local var_142_12 = Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, var_142_11)
								local var_142_13 = Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, var_142_11)
								local var_142_14 = Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, var_142_11)

								iter_142_5.color = Color.New(var_142_12, var_142_13, var_142_14)
							else
								local var_142_15 = Mathf.Lerp(iter_142_5.color.r, 0.5, var_142_11)

								iter_142_5.color = Color.New(var_142_15, var_142_15, var_142_15)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_9 + var_142_10 and arg_139_1.time_ < var_142_9 + var_142_10 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps104701 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_142_7 then
						if arg_139_1.isInRecall_ then
							iter_142_7.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps104701 = nil
			end

			local var_142_16 = arg_139_1.actors_["104701"].transform
			local var_142_17 = 0

			if var_142_17 < arg_139_1.time_ and arg_139_1.time_ <= var_142_17 + arg_142_0 then
				arg_139_1.var_.moveOldPos104701 = var_142_16.localPosition
				var_142_16.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("104701", 7)

				local var_142_18 = var_142_16.childCount

				for iter_142_8 = 0, var_142_18 - 1 do
					local var_142_19 = var_142_16:GetChild(iter_142_8)

					if var_142_19.name == "" or not string.find(var_142_19.name, "split") then
						var_142_19.gameObject:SetActive(true)
					else
						var_142_19.gameObject:SetActive(false)
					end
				end
			end

			local var_142_20 = 0.001

			if var_142_17 <= arg_139_1.time_ and arg_139_1.time_ < var_142_17 + var_142_20 then
				local var_142_21 = (arg_139_1.time_ - var_142_17) / var_142_20
				local var_142_22 = Vector3.New(0, -2000, 0)

				var_142_16.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos104701, var_142_22, var_142_21)
			end

			if arg_139_1.time_ >= var_142_17 + var_142_20 and arg_139_1.time_ < var_142_17 + var_142_20 + arg_142_0 then
				var_142_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_23 = arg_139_1.actors_["106603"].transform
			local var_142_24 = 0

			if var_142_24 < arg_139_1.time_ and arg_139_1.time_ <= var_142_24 + arg_142_0 then
				arg_139_1.var_.moveOldPos106603 = var_142_23.localPosition
				var_142_23.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("106603", 3)

				local var_142_25 = var_142_23.childCount

				for iter_142_9 = 0, var_142_25 - 1 do
					local var_142_26 = var_142_23:GetChild(iter_142_9)

					if var_142_26.name == "" or not string.find(var_142_26.name, "split") then
						var_142_26.gameObject:SetActive(true)
					else
						var_142_26.gameObject:SetActive(false)
					end
				end
			end

			local var_142_27 = 0.001

			if var_142_24 <= arg_139_1.time_ and arg_139_1.time_ < var_142_24 + var_142_27 then
				local var_142_28 = (arg_139_1.time_ - var_142_24) / var_142_27
				local var_142_29 = Vector3.New(-77.5, -399.1, -303.3)

				var_142_23.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos106603, var_142_29, var_142_28)
			end

			if arg_139_1.time_ >= var_142_24 + var_142_27 and arg_139_1.time_ < var_142_24 + var_142_27 + arg_142_0 then
				var_142_23.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_142_30 = 0
			local var_142_31 = 0.575

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_32 = arg_139_1:FormatText(StoryNameCfg[32].name)

				arg_139_1.leftNameTxt_.text = var_142_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_33 = arg_139_1:GetWordFromCfg(926041033)
				local var_142_34 = arg_139_1:FormatText(var_142_33.content)

				arg_139_1.text_.text = var_142_34

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_35 = 23
				local var_142_36 = utf8.len(var_142_34)
				local var_142_37 = var_142_35 <= 0 and var_142_31 or var_142_31 * (var_142_36 / var_142_35)

				if var_142_37 > 0 and var_142_31 < var_142_37 then
					arg_139_1.talkMaxDuration = var_142_37

					if var_142_37 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_37 + var_142_30
					end
				end

				arg_139_1.text_.text = var_142_34
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041033", "story_v_out_926041.awb") ~= 0 then
					local var_142_38 = manager.audio:GetVoiceLength("story_v_out_926041", "926041033", "story_v_out_926041.awb") / 1000

					if var_142_38 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_38 + var_142_30
					end

					if var_142_33.prefab_name ~= "" and arg_139_1.actors_[var_142_33.prefab_name] ~= nil then
						local var_142_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_33.prefab_name].transform, "story_v_out_926041", "926041033", "story_v_out_926041.awb")

						arg_139_1:RecordAudio("926041033", var_142_39)
						arg_139_1:RecordAudio("926041033", var_142_39)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_926041", "926041033", "story_v_out_926041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_926041", "926041033", "story_v_out_926041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_40 = math.max(var_142_31, arg_139_1.talkMaxDuration)

			if var_142_30 <= arg_139_1.time_ and arg_139_1.time_ < var_142_30 + var_142_40 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_30) / var_142_40

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_30 + var_142_40 and arg_139_1.time_ < var_142_30 + var_142_40 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
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
	Play926041034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 926041034
		arg_143_1.duration_ = 9.7

		local var_143_0 = {
			zh = 8.166,
			ja = 9.7
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
				arg_143_0:Play926041035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 1.075

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[32].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(926041034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041034", "story_v_out_926041.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041034", "story_v_out_926041.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_926041", "926041034", "story_v_out_926041.awb")

						arg_143_1:RecordAudio("926041034", var_146_9)
						arg_143_1:RecordAudio("926041034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_926041", "926041034", "story_v_out_926041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_926041", "926041034", "story_v_out_926041.awb")
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
	Play926041035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 926041035
		arg_147_1.duration_ = 4.43

		local var_147_0 = {
			zh = 3.3,
			ja = 4.433
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
				arg_147_0:Play926041036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["128404"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps128404 == nil then
				arg_147_1.var_.actorSpriteComps128404 = var_150_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_2 = 0.2

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.actorSpriteComps128404 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								local var_150_4 = Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, var_150_3)
								local var_150_5 = Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, var_150_3)
								local var_150_6 = Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, var_150_3)

								iter_150_1.color = Color.New(var_150_4, var_150_5, var_150_6)
							else
								local var_150_7 = Mathf.Lerp(iter_150_1.color.r, 1, var_150_3)

								iter_150_1.color = Color.New(var_150_7, var_150_7, var_150_7)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.actorSpriteComps128404 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_150_3 then
						if arg_147_1.isInRecall_ then
							iter_150_3.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps128404 = nil
			end

			local var_150_8 = arg_147_1.actors_["106603"]
			local var_150_9 = 0

			if var_150_9 < arg_147_1.time_ and arg_147_1.time_ <= var_150_9 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps106603 == nil then
				arg_147_1.var_.actorSpriteComps106603 = var_150_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_10 = 0.2

			if var_150_9 <= arg_147_1.time_ and arg_147_1.time_ < var_150_9 + var_150_10 and not isNil(var_150_8) then
				local var_150_11 = (arg_147_1.time_ - var_150_9) / var_150_10

				if arg_147_1.var_.actorSpriteComps106603 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								local var_150_12 = Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, var_150_11)
								local var_150_13 = Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, var_150_11)
								local var_150_14 = Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, var_150_11)

								iter_150_5.color = Color.New(var_150_12, var_150_13, var_150_14)
							else
								local var_150_15 = Mathf.Lerp(iter_150_5.color.r, 0.5, var_150_11)

								iter_150_5.color = Color.New(var_150_15, var_150_15, var_150_15)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_9 + var_150_10 and arg_147_1.time_ < var_150_9 + var_150_10 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps106603 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_150_7 then
						if arg_147_1.isInRecall_ then
							iter_150_7.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps106603 = nil
			end

			local var_150_16 = 0
			local var_150_17 = 0.45

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_18 = arg_147_1:FormatText(StoryNameCfg[6].name)

				arg_147_1.leftNameTxt_.text = var_150_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_19 = arg_147_1:GetWordFromCfg(926041035)
				local var_150_20 = arg_147_1:FormatText(var_150_19.content)

				arg_147_1.text_.text = var_150_20

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_21 = 18
				local var_150_22 = utf8.len(var_150_20)
				local var_150_23 = var_150_21 <= 0 and var_150_17 or var_150_17 * (var_150_22 / var_150_21)

				if var_150_23 > 0 and var_150_17 < var_150_23 then
					arg_147_1.talkMaxDuration = var_150_23

					if var_150_23 + var_150_16 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_16
					end
				end

				arg_147_1.text_.text = var_150_20
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041035", "story_v_out_926041.awb") ~= 0 then
					local var_150_24 = manager.audio:GetVoiceLength("story_v_out_926041", "926041035", "story_v_out_926041.awb") / 1000

					if var_150_24 + var_150_16 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_24 + var_150_16
					end

					if var_150_19.prefab_name ~= "" and arg_147_1.actors_[var_150_19.prefab_name] ~= nil then
						local var_150_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_19.prefab_name].transform, "story_v_out_926041", "926041035", "story_v_out_926041.awb")

						arg_147_1:RecordAudio("926041035", var_150_25)
						arg_147_1:RecordAudio("926041035", var_150_25)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_926041", "926041035", "story_v_out_926041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_926041", "926041035", "story_v_out_926041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_26 = math.max(var_150_17, arg_147_1.talkMaxDuration)

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_26 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_16) / var_150_26

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_16 + var_150_26 and arg_147_1.time_ < var_150_16 + var_150_26 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play926041036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 926041036
		arg_151_1.duration_ = 10.53

		local var_151_0 = {
			zh = 7.033,
			ja = 10.533
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
				arg_151_0:Play926041037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["106603"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps106603 == nil then
				arg_151_1.var_.actorSpriteComps106603 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 0.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps106603 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 1, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps106603 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_154_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps106603 = nil
			end

			local var_154_8 = arg_151_1.actors_["128404"]
			local var_154_9 = 0

			if var_154_9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps128404 == nil then
				arg_151_1.var_.actorSpriteComps128404 = var_154_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_10 = 0.2

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 and not isNil(var_154_8) then
				local var_154_11 = (arg_151_1.time_ - var_154_9) / var_154_10

				if arg_151_1.var_.actorSpriteComps128404 then
					for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_154_5 then
							if arg_151_1.isInRecall_ then
								local var_154_12 = Mathf.Lerp(iter_154_5.color.r, arg_151_1.hightColor2.r, var_154_11)
								local var_154_13 = Mathf.Lerp(iter_154_5.color.g, arg_151_1.hightColor2.g, var_154_11)
								local var_154_14 = Mathf.Lerp(iter_154_5.color.b, arg_151_1.hightColor2.b, var_154_11)

								iter_154_5.color = Color.New(var_154_12, var_154_13, var_154_14)
							else
								local var_154_15 = Mathf.Lerp(iter_154_5.color.r, 0.5, var_154_11)

								iter_154_5.color = Color.New(var_154_15, var_154_15, var_154_15)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 and not isNil(var_154_8) and arg_151_1.var_.actorSpriteComps128404 then
				for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_154_7 then
						if arg_151_1.isInRecall_ then
							iter_154_7.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps128404 = nil
			end

			local var_154_16 = arg_151_1.actors_["106603"].transform
			local var_154_17 = 0

			if var_154_17 < arg_151_1.time_ and arg_151_1.time_ <= var_154_17 + arg_154_0 then
				arg_151_1.var_.moveOldPos106603 = var_154_16.localPosition
				var_154_16.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("106603", 3)

				local var_154_18 = var_154_16.childCount

				for iter_154_8 = 0, var_154_18 - 1 do
					local var_154_19 = var_154_16:GetChild(iter_154_8)

					if var_154_19.name == "split_6" or not string.find(var_154_19.name, "split") then
						var_154_19.gameObject:SetActive(true)
					else
						var_154_19.gameObject:SetActive(false)
					end
				end
			end

			local var_154_20 = 0.001

			if var_154_17 <= arg_151_1.time_ and arg_151_1.time_ < var_154_17 + var_154_20 then
				local var_154_21 = (arg_151_1.time_ - var_154_17) / var_154_20
				local var_154_22 = Vector3.New(-77.5, -399.1, -303.3)

				var_154_16.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos106603, var_154_22, var_154_21)
			end

			if arg_151_1.time_ >= var_154_17 + var_154_20 and arg_151_1.time_ < var_154_17 + var_154_20 + arg_154_0 then
				var_154_16.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_154_23 = 0
			local var_154_24 = 0.775

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_25 = arg_151_1:FormatText(StoryNameCfg[32].name)

				arg_151_1.leftNameTxt_.text = var_154_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_26 = arg_151_1:GetWordFromCfg(926041036)
				local var_154_27 = arg_151_1:FormatText(var_154_26.content)

				arg_151_1.text_.text = var_154_27

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_28 = 31
				local var_154_29 = utf8.len(var_154_27)
				local var_154_30 = var_154_28 <= 0 and var_154_24 or var_154_24 * (var_154_29 / var_154_28)

				if var_154_30 > 0 and var_154_24 < var_154_30 then
					arg_151_1.talkMaxDuration = var_154_30

					if var_154_30 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_30 + var_154_23
					end
				end

				arg_151_1.text_.text = var_154_27
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041036", "story_v_out_926041.awb") ~= 0 then
					local var_154_31 = manager.audio:GetVoiceLength("story_v_out_926041", "926041036", "story_v_out_926041.awb") / 1000

					if var_154_31 + var_154_23 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_31 + var_154_23
					end

					if var_154_26.prefab_name ~= "" and arg_151_1.actors_[var_154_26.prefab_name] ~= nil then
						local var_154_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_26.prefab_name].transform, "story_v_out_926041", "926041036", "story_v_out_926041.awb")

						arg_151_1:RecordAudio("926041036", var_154_32)
						arg_151_1:RecordAudio("926041036", var_154_32)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_926041", "926041036", "story_v_out_926041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_926041", "926041036", "story_v_out_926041.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_33 = math.max(var_154_24, arg_151_1.talkMaxDuration)

			if var_154_23 <= arg_151_1.time_ and arg_151_1.time_ < var_154_23 + var_154_33 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_23) / var_154_33

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_23 + var_154_33 and arg_151_1.time_ < var_154_23 + var_154_33 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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
	Play926041037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 926041037
		arg_155_1.duration_ = 8.63

		local var_155_0 = {
			zh = 6.866,
			ja = 8.633
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
				arg_155_0:Play926041038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.875

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[32].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(926041037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041037", "story_v_out_926041.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041037", "story_v_out_926041.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_926041", "926041037", "story_v_out_926041.awb")

						arg_155_1:RecordAudio("926041037", var_158_9)
						arg_155_1:RecordAudio("926041037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_926041", "926041037", "story_v_out_926041.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_926041", "926041037", "story_v_out_926041.awb")
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
	Play926041038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 926041038
		arg_159_1.duration_ = 8.2

		local var_159_0 = {
			zh = 5.966,
			ja = 8.2
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
				arg_159_0:Play926041039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["106603"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos106603 = var_162_0.localPosition
				var_162_0.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("106603", 3)

				local var_162_2 = var_162_0.childCount

				for iter_162_0 = 0, var_162_2 - 1 do
					local var_162_3 = var_162_0:GetChild(iter_162_0)

					if var_162_3.name == "split_4" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_4 then
				local var_162_5 = (arg_159_1.time_ - var_162_1) / var_162_4
				local var_162_6 = Vector3.New(-77.5, -399.1, -303.3)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos106603, var_162_6, var_162_5)
			end

			if arg_159_1.time_ >= var_162_1 + var_162_4 and arg_159_1.time_ < var_162_1 + var_162_4 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_162_7 = 0
			local var_162_8 = 0.65

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_9 = arg_159_1:FormatText(StoryNameCfg[32].name)

				arg_159_1.leftNameTxt_.text = var_162_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(926041038)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 26
				local var_162_13 = utf8.len(var_162_11)
				local var_162_14 = var_162_12 <= 0 and var_162_8 or var_162_8 * (var_162_13 / var_162_12)

				if var_162_14 > 0 and var_162_8 < var_162_14 then
					arg_159_1.talkMaxDuration = var_162_14

					if var_162_14 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_7
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041038", "story_v_out_926041.awb") ~= 0 then
					local var_162_15 = manager.audio:GetVoiceLength("story_v_out_926041", "926041038", "story_v_out_926041.awb") / 1000

					if var_162_15 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_7
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_926041", "926041038", "story_v_out_926041.awb")

						arg_159_1:RecordAudio("926041038", var_162_16)
						arg_159_1:RecordAudio("926041038", var_162_16)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_926041", "926041038", "story_v_out_926041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_926041", "926041038", "story_v_out_926041.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_17 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_17 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_7) / var_162_17

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_7 + var_162_17 and arg_159_1.time_ < var_162_7 + var_162_17 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play926041039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 926041039
		arg_163_1.duration_ = 1

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"

			SetActive(arg_163_1.choicesGo_, true)

			for iter_164_0, iter_164_1 in ipairs(arg_163_1.choices_) do
				local var_164_0 = iter_164_0 <= 1

				SetActive(iter_164_1.go, var_164_0)
			end

			arg_163_1.choices_[1].txt.text = arg_163_1:FormatText(StoryChoiceCfg[1323].name)
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play926041040(arg_163_1)
			end

			arg_163_1:RecordChoiceLog(926041039, 1323)
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["106603"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps106603 == nil then
				arg_163_1.var_.actorSpriteComps106603 = var_166_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_2 = 0.2

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.actorSpriteComps106603 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								local var_166_4 = Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, var_166_3)
								local var_166_5 = Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, var_166_3)
								local var_166_6 = Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, var_166_3)

								iter_166_1.color = Color.New(var_166_4, var_166_5, var_166_6)
							else
								local var_166_7 = Mathf.Lerp(iter_166_1.color.r, 0.5, var_166_3)

								iter_166_1.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.actorSpriteComps106603 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_166_3 then
						if arg_163_1.isInRecall_ then
							iter_166_3.color = arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_166_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps106603 = nil
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play926041040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 926041040
		arg_167_1.duration_ = 7.6

		local var_167_0 = {
			zh = 3.366,
			ja = 7.6
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
				arg_167_0:Play926041041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["104701"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps104701 == nil then
				arg_167_1.var_.actorSpriteComps104701 = var_170_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_2 = 0.2

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.actorSpriteComps104701 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								local var_170_4 = Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor1.r, var_170_3)
								local var_170_5 = Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor1.g, var_170_3)
								local var_170_6 = Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor1.b, var_170_3)

								iter_170_1.color = Color.New(var_170_4, var_170_5, var_170_6)
							else
								local var_170_7 = Mathf.Lerp(iter_170_1.color.r, 1, var_170_3)

								iter_170_1.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.actorSpriteComps104701 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_170_3 then
						if arg_167_1.isInRecall_ then
							iter_170_3.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps104701 = nil
			end

			local var_170_8 = arg_167_1.actors_["106603"].transform
			local var_170_9 = 0

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.var_.moveOldPos106603 = var_170_8.localPosition
				var_170_8.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("106603", 7)

				local var_170_10 = var_170_8.childCount

				for iter_170_4 = 0, var_170_10 - 1 do
					local var_170_11 = var_170_8:GetChild(iter_170_4)

					if var_170_11.name == "" or not string.find(var_170_11.name, "split") then
						var_170_11.gameObject:SetActive(true)
					else
						var_170_11.gameObject:SetActive(false)
					end
				end
			end

			local var_170_12 = 0.001

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_12 then
				local var_170_13 = (arg_167_1.time_ - var_170_9) / var_170_12
				local var_170_14 = Vector3.New(0, -2000, 0)

				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos106603, var_170_14, var_170_13)
			end

			if arg_167_1.time_ >= var_170_9 + var_170_12 and arg_167_1.time_ < var_170_9 + var_170_12 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_170_15 = arg_167_1.actors_["104701"].transform
			local var_170_16 = 0

			if var_170_16 < arg_167_1.time_ and arg_167_1.time_ <= var_170_16 + arg_170_0 then
				arg_167_1.var_.moveOldPos104701 = var_170_15.localPosition
				var_170_15.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("104701", 3)

				local var_170_17 = var_170_15.childCount

				for iter_170_5 = 0, var_170_17 - 1 do
					local var_170_18 = var_170_15:GetChild(iter_170_5)

					if var_170_18.name == "" or not string.find(var_170_18.name, "split") then
						var_170_18.gameObject:SetActive(true)
					else
						var_170_18.gameObject:SetActive(false)
					end
				end
			end

			local var_170_19 = 0.001

			if var_170_16 <= arg_167_1.time_ and arg_167_1.time_ < var_170_16 + var_170_19 then
				local var_170_20 = (arg_167_1.time_ - var_170_16) / var_170_19
				local var_170_21 = Vector3.New(-67.4, -386.8, -295)

				var_170_15.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos104701, var_170_21, var_170_20)
			end

			if arg_167_1.time_ >= var_170_16 + var_170_19 and arg_167_1.time_ < var_170_16 + var_170_19 + arg_170_0 then
				var_170_15.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_170_22 = 0
			local var_170_23 = 0.425

			if var_170_22 < arg_167_1.time_ and arg_167_1.time_ <= var_170_22 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_24 = arg_167_1:FormatText(StoryNameCfg[1296].name)

				arg_167_1.leftNameTxt_.text = var_170_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_25 = arg_167_1:GetWordFromCfg(926041040)
				local var_170_26 = arg_167_1:FormatText(var_170_25.content)

				arg_167_1.text_.text = var_170_26

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_27 = 17
				local var_170_28 = utf8.len(var_170_26)
				local var_170_29 = var_170_27 <= 0 and var_170_23 or var_170_23 * (var_170_28 / var_170_27)

				if var_170_29 > 0 and var_170_23 < var_170_29 then
					arg_167_1.talkMaxDuration = var_170_29

					if var_170_29 + var_170_22 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_29 + var_170_22
					end
				end

				arg_167_1.text_.text = var_170_26
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041040", "story_v_out_926041.awb") ~= 0 then
					local var_170_30 = manager.audio:GetVoiceLength("story_v_out_926041", "926041040", "story_v_out_926041.awb") / 1000

					if var_170_30 + var_170_22 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_30 + var_170_22
					end

					if var_170_25.prefab_name ~= "" and arg_167_1.actors_[var_170_25.prefab_name] ~= nil then
						local var_170_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_25.prefab_name].transform, "story_v_out_926041", "926041040", "story_v_out_926041.awb")

						arg_167_1:RecordAudio("926041040", var_170_31)
						arg_167_1:RecordAudio("926041040", var_170_31)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_926041", "926041040", "story_v_out_926041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_926041", "926041040", "story_v_out_926041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_32 = math.max(var_170_23, arg_167_1.talkMaxDuration)

			if var_170_22 <= arg_167_1.time_ and arg_167_1.time_ < var_170_22 + var_170_32 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_22) / var_170_32

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_22 + var_170_32 and arg_167_1.time_ < var_170_22 + var_170_32 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play926041041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 926041041
		arg_171_1.duration_ = 8.3

		local var_171_0 = {
			zh = 5.566,
			ja = 8.3
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play926041042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.65

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[1296].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(926041041)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 26
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041041", "story_v_out_926041.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041041", "story_v_out_926041.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_926041", "926041041", "story_v_out_926041.awb")

						arg_171_1:RecordAudio("926041041", var_174_9)
						arg_171_1:RecordAudio("926041041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_926041", "926041041", "story_v_out_926041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_926041", "926041041", "story_v_out_926041.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play926041042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 926041042
		arg_175_1.duration_ = 4.6

		local var_175_0 = {
			zh = 2.833,
			ja = 4.6
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
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play926041043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.325

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[1296].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(926041042)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041042", "story_v_out_926041.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041042", "story_v_out_926041.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_926041", "926041042", "story_v_out_926041.awb")

						arg_175_1:RecordAudio("926041042", var_178_9)
						arg_175_1:RecordAudio("926041042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_926041", "926041042", "story_v_out_926041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_926041", "926041042", "story_v_out_926041.awb")
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
	Play926041043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 926041043
		arg_179_1.duration_ = 2.37

		local var_179_0 = {
			zh = 2.366,
			ja = 2.066
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play926041044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["106603"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps106603 == nil then
				arg_179_1.var_.actorSpriteComps106603 = var_182_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.actorSpriteComps106603 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								local var_182_4 = Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, var_182_3)
								local var_182_5 = Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, var_182_3)
								local var_182_6 = Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, var_182_3)

								iter_182_1.color = Color.New(var_182_4, var_182_5, var_182_6)
							else
								local var_182_7 = Mathf.Lerp(iter_182_1.color.r, 1, var_182_3)

								iter_182_1.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.actorSpriteComps106603 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_182_3 then
						if arg_179_1.isInRecall_ then
							iter_182_3.color = arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_182_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps106603 = nil
			end

			local var_182_8 = arg_179_1.actors_["104701"]
			local var_182_9 = 0

			if var_182_9 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps104701 == nil then
				arg_179_1.var_.actorSpriteComps104701 = var_182_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_10 = 0.2

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_10 and not isNil(var_182_8) then
				local var_182_11 = (arg_179_1.time_ - var_182_9) / var_182_10

				if arg_179_1.var_.actorSpriteComps104701 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								local var_182_12 = Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor2.r, var_182_11)
								local var_182_13 = Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor2.g, var_182_11)
								local var_182_14 = Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor2.b, var_182_11)

								iter_182_5.color = Color.New(var_182_12, var_182_13, var_182_14)
							else
								local var_182_15 = Mathf.Lerp(iter_182_5.color.r, 0.5, var_182_11)

								iter_182_5.color = Color.New(var_182_15, var_182_15, var_182_15)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= var_182_9 + var_182_10 and arg_179_1.time_ < var_182_9 + var_182_10 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps104701 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_182_7 then
						if arg_179_1.isInRecall_ then
							iter_182_7.color = arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_182_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_179_1.var_.actorSpriteComps104701 = nil
			end

			local var_182_16 = arg_179_1.actors_["104701"].transform
			local var_182_17 = 0

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.var_.moveOldPos104701 = var_182_16.localPosition
				var_182_16.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("104701", 7)

				local var_182_18 = var_182_16.childCount

				for iter_182_8 = 0, var_182_18 - 1 do
					local var_182_19 = var_182_16:GetChild(iter_182_8)

					if var_182_19.name == "" or not string.find(var_182_19.name, "split") then
						var_182_19.gameObject:SetActive(true)
					else
						var_182_19.gameObject:SetActive(false)
					end
				end
			end

			local var_182_20 = 0.001

			if var_182_17 <= arg_179_1.time_ and arg_179_1.time_ < var_182_17 + var_182_20 then
				local var_182_21 = (arg_179_1.time_ - var_182_17) / var_182_20
				local var_182_22 = Vector3.New(0, -2000, 0)

				var_182_16.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos104701, var_182_22, var_182_21)
			end

			if arg_179_1.time_ >= var_182_17 + var_182_20 and arg_179_1.time_ < var_182_17 + var_182_20 + arg_182_0 then
				var_182_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_182_23 = arg_179_1.actors_["106603"].transform
			local var_182_24 = 0

			if var_182_24 < arg_179_1.time_ and arg_179_1.time_ <= var_182_24 + arg_182_0 then
				arg_179_1.var_.moveOldPos106603 = var_182_23.localPosition
				var_182_23.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("106603", 3)

				local var_182_25 = var_182_23.childCount

				for iter_182_9 = 0, var_182_25 - 1 do
					local var_182_26 = var_182_23:GetChild(iter_182_9)

					if var_182_26.name == "" or not string.find(var_182_26.name, "split") then
						var_182_26.gameObject:SetActive(true)
					else
						var_182_26.gameObject:SetActive(false)
					end
				end
			end

			local var_182_27 = 0.001

			if var_182_24 <= arg_179_1.time_ and arg_179_1.time_ < var_182_24 + var_182_27 then
				local var_182_28 = (arg_179_1.time_ - var_182_24) / var_182_27
				local var_182_29 = Vector3.New(-77.5, -399.1, -303.3)

				var_182_23.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos106603, var_182_29, var_182_28)
			end

			if arg_179_1.time_ >= var_182_24 + var_182_27 and arg_179_1.time_ < var_182_24 + var_182_27 + arg_182_0 then
				var_182_23.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_182_30 = 0
			local var_182_31 = 0.175

			if var_182_30 < arg_179_1.time_ and arg_179_1.time_ <= var_182_30 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_32 = arg_179_1:FormatText(StoryNameCfg[32].name)

				arg_179_1.leftNameTxt_.text = var_182_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_33 = arg_179_1:GetWordFromCfg(926041043)
				local var_182_34 = arg_179_1:FormatText(var_182_33.content)

				arg_179_1.text_.text = var_182_34

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_35 = 7
				local var_182_36 = utf8.len(var_182_34)
				local var_182_37 = var_182_35 <= 0 and var_182_31 or var_182_31 * (var_182_36 / var_182_35)

				if var_182_37 > 0 and var_182_31 < var_182_37 then
					arg_179_1.talkMaxDuration = var_182_37

					if var_182_37 + var_182_30 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_37 + var_182_30
					end
				end

				arg_179_1.text_.text = var_182_34
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041043", "story_v_out_926041.awb") ~= 0 then
					local var_182_38 = manager.audio:GetVoiceLength("story_v_out_926041", "926041043", "story_v_out_926041.awb") / 1000

					if var_182_38 + var_182_30 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_38 + var_182_30
					end

					if var_182_33.prefab_name ~= "" and arg_179_1.actors_[var_182_33.prefab_name] ~= nil then
						local var_182_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_33.prefab_name].transform, "story_v_out_926041", "926041043", "story_v_out_926041.awb")

						arg_179_1:RecordAudio("926041043", var_182_39)
						arg_179_1:RecordAudio("926041043", var_182_39)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_926041", "926041043", "story_v_out_926041.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_926041", "926041043", "story_v_out_926041.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_40 = math.max(var_182_31, arg_179_1.talkMaxDuration)

			if var_182_30 <= arg_179_1.time_ and arg_179_1.time_ < var_182_30 + var_182_40 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_30) / var_182_40

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_30 + var_182_40 and arg_179_1.time_ < var_182_30 + var_182_40 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play926041044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 926041044
		arg_183_1.duration_ = 12.87

		local var_183_0 = {
			zh = 10.5326666666667,
			ja = 12.8666666666667
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play926041045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = "SP92601"

			if arg_183_1.bgs_[var_186_0] == nil then
				local var_186_1 = Object.Instantiate(arg_183_1.paintGo_)

				var_186_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_186_0)
				var_186_1.name = var_186_0
				var_186_1.transform.parent = arg_183_1.stage_.transform
				var_186_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.bgs_[var_186_0] = var_186_1
			end

			local var_186_2 = 1.96666666666667

			if var_186_2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				local var_186_3 = manager.ui.mainCamera.transform.localPosition
				local var_186_4 = Vector3.New(0, 0, 10) + Vector3.New(var_186_3.x, var_186_3.y, 0)
				local var_186_5 = arg_183_1.bgs_.SP92601

				var_186_5.transform.localPosition = var_186_4
				var_186_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_6 = var_186_5:GetComponent("SpriteRenderer")

				if var_186_6 and var_186_6.sprite then
					local var_186_7 = (var_186_5.transform.localPosition - var_186_3).z
					local var_186_8 = manager.ui.mainCameraCom_
					local var_186_9 = 2 * var_186_7 * Mathf.Tan(var_186_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_186_10 = var_186_9 * var_186_8.aspect
					local var_186_11 = var_186_6.sprite.bounds.size.x
					local var_186_12 = var_186_6.sprite.bounds.size.y
					local var_186_13 = var_186_10 / var_186_11
					local var_186_14 = var_186_9 / var_186_12
					local var_186_15 = var_186_14 < var_186_13 and var_186_13 or var_186_14

					var_186_5.transform.localScale = Vector3.New(var_186_15, var_186_15, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "SP92601" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_16 = 2

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			local var_186_17 = 0.3

			if arg_183_1.time_ >= var_186_16 + var_186_17 and arg_183_1.time_ < var_186_16 + var_186_17 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			local var_186_18 = 0

			if var_186_18 < arg_183_1.time_ and arg_183_1.time_ <= var_186_18 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_19 = 2

			if var_186_18 <= arg_183_1.time_ and arg_183_1.time_ < var_186_18 + var_186_19 then
				local var_186_20 = (arg_183_1.time_ - var_186_18) / var_186_19
				local var_186_21 = Color.New(0, 0, 0)

				var_186_21.a = Mathf.Lerp(0, 1, var_186_20)
				arg_183_1.mask_.color = var_186_21
			end

			if arg_183_1.time_ >= var_186_18 + var_186_19 and arg_183_1.time_ < var_186_18 + var_186_19 + arg_186_0 then
				local var_186_22 = Color.New(0, 0, 0)

				var_186_22.a = 1
				arg_183_1.mask_.color = var_186_22
			end

			local var_186_23 = 2

			if var_186_23 < arg_183_1.time_ and arg_183_1.time_ <= var_186_23 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_24 = 2

			if var_186_23 <= arg_183_1.time_ and arg_183_1.time_ < var_186_23 + var_186_24 then
				local var_186_25 = (arg_183_1.time_ - var_186_23) / var_186_24
				local var_186_26 = Color.New(0, 0, 0)

				var_186_26.a = Mathf.Lerp(1, 0, var_186_25)
				arg_183_1.mask_.color = var_186_26
			end

			if arg_183_1.time_ >= var_186_23 + var_186_24 and arg_183_1.time_ < var_186_23 + var_186_24 + arg_186_0 then
				local var_186_27 = Color.New(0, 0, 0)
				local var_186_28 = 0

				arg_183_1.mask_.enabled = false
				var_186_27.a = var_186_28
				arg_183_1.mask_.color = var_186_27
			end

			local var_186_29 = arg_183_1.actors_["104701"]
			local var_186_30 = 2

			if var_186_30 < arg_183_1.time_ and arg_183_1.time_ <= var_186_30 + arg_186_0 and not isNil(var_186_29) and arg_183_1.var_.actorSpriteComps104701 == nil then
				arg_183_1.var_.actorSpriteComps104701 = var_186_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_31 = 0.2

			if var_186_30 <= arg_183_1.time_ and arg_183_1.time_ < var_186_30 + var_186_31 and not isNil(var_186_29) then
				local var_186_32 = (arg_183_1.time_ - var_186_30) / var_186_31

				if arg_183_1.var_.actorSpriteComps104701 then
					for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_186_3 then
							if arg_183_1.isInRecall_ then
								local var_186_33 = Mathf.Lerp(iter_186_3.color.r, arg_183_1.hightColor1.r, var_186_32)
								local var_186_34 = Mathf.Lerp(iter_186_3.color.g, arg_183_1.hightColor1.g, var_186_32)
								local var_186_35 = Mathf.Lerp(iter_186_3.color.b, arg_183_1.hightColor1.b, var_186_32)

								iter_186_3.color = Color.New(var_186_33, var_186_34, var_186_35)
							else
								local var_186_36 = Mathf.Lerp(iter_186_3.color.r, 1, var_186_32)

								iter_186_3.color = Color.New(var_186_36, var_186_36, var_186_36)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_30 + var_186_31 and arg_183_1.time_ < var_186_30 + var_186_31 + arg_186_0 and not isNil(var_186_29) and arg_183_1.var_.actorSpriteComps104701 then
				for iter_186_4, iter_186_5 in pairs(arg_183_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_186_5 then
						if arg_183_1.isInRecall_ then
							iter_186_5.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps104701 = nil
			end

			local var_186_37 = arg_183_1.actors_["106603"]
			local var_186_38 = 2

			if var_186_38 < arg_183_1.time_ and arg_183_1.time_ <= var_186_38 + arg_186_0 and not isNil(var_186_37) and arg_183_1.var_.actorSpriteComps106603 == nil then
				arg_183_1.var_.actorSpriteComps106603 = var_186_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_39 = 0.2

			if var_186_38 <= arg_183_1.time_ and arg_183_1.time_ < var_186_38 + var_186_39 and not isNil(var_186_37) then
				local var_186_40 = (arg_183_1.time_ - var_186_38) / var_186_39

				if arg_183_1.var_.actorSpriteComps106603 then
					for iter_186_6, iter_186_7 in pairs(arg_183_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_186_7 then
							if arg_183_1.isInRecall_ then
								local var_186_41 = Mathf.Lerp(iter_186_7.color.r, arg_183_1.hightColor2.r, var_186_40)
								local var_186_42 = Mathf.Lerp(iter_186_7.color.g, arg_183_1.hightColor2.g, var_186_40)
								local var_186_43 = Mathf.Lerp(iter_186_7.color.b, arg_183_1.hightColor2.b, var_186_40)

								iter_186_7.color = Color.New(var_186_41, var_186_42, var_186_43)
							else
								local var_186_44 = Mathf.Lerp(iter_186_7.color.r, 0.5, var_186_40)

								iter_186_7.color = Color.New(var_186_44, var_186_44, var_186_44)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_38 + var_186_39 and arg_183_1.time_ < var_186_38 + var_186_39 + arg_186_0 and not isNil(var_186_37) and arg_183_1.var_.actorSpriteComps106603 then
				for iter_186_8, iter_186_9 in pairs(arg_183_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_186_9 then
						if arg_183_1.isInRecall_ then
							iter_186_9.color = arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_186_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps106603 = nil
			end

			local var_186_45 = arg_183_1.actors_["104701"].transform
			local var_186_46 = 2

			if var_186_46 < arg_183_1.time_ and arg_183_1.time_ <= var_186_46 + arg_186_0 then
				arg_183_1.var_.moveOldPos104701 = var_186_45.localPosition
				var_186_45.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("104701", 7)

				local var_186_47 = var_186_45.childCount

				for iter_186_10 = 0, var_186_47 - 1 do
					local var_186_48 = var_186_45:GetChild(iter_186_10)

					if var_186_48.name == "" or not string.find(var_186_48.name, "split") then
						var_186_48.gameObject:SetActive(true)
					else
						var_186_48.gameObject:SetActive(false)
					end
				end
			end

			local var_186_49 = 0.001

			if var_186_46 <= arg_183_1.time_ and arg_183_1.time_ < var_186_46 + var_186_49 then
				local var_186_50 = (arg_183_1.time_ - var_186_46) / var_186_49
				local var_186_51 = Vector3.New(0, -2000, 0)

				var_186_45.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos104701, var_186_51, var_186_50)
			end

			if arg_183_1.time_ >= var_186_46 + var_186_49 and arg_183_1.time_ < var_186_46 + var_186_49 + arg_186_0 then
				var_186_45.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_52 = arg_183_1.actors_["106603"].transform
			local var_186_53 = 2

			if var_186_53 < arg_183_1.time_ and arg_183_1.time_ <= var_186_53 + arg_186_0 then
				arg_183_1.var_.moveOldPos106603 = var_186_52.localPosition
				var_186_52.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("106603", 7)

				local var_186_54 = var_186_52.childCount

				for iter_186_11 = 0, var_186_54 - 1 do
					local var_186_55 = var_186_52:GetChild(iter_186_11)

					if var_186_55.name == "" or not string.find(var_186_55.name, "split") then
						var_186_55.gameObject:SetActive(true)
					else
						var_186_55.gameObject:SetActive(false)
					end
				end
			end

			local var_186_56 = 0.001

			if var_186_53 <= arg_183_1.time_ and arg_183_1.time_ < var_186_53 + var_186_56 then
				local var_186_57 = (arg_183_1.time_ - var_186_53) / var_186_56
				local var_186_58 = Vector3.New(0, -2000, 0)

				var_186_52.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos106603, var_186_58, var_186_57)
			end

			if arg_183_1.time_ >= var_186_53 + var_186_56 and arg_183_1.time_ < var_186_53 + var_186_56 + arg_186_0 then
				var_186_52.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_59 = 1.53333333333333
			local var_186_60 = 1

			if var_186_59 < arg_183_1.time_ and arg_183_1.time_ <= var_186_59 + arg_186_0 then
				local var_186_61 = "play"
				local var_186_62 = "effect"

				arg_183_1:AudioAction(var_186_61, var_186_62, "se_story_1210", "se_story_1210_morning_loop", "")
			end

			local var_186_63 = 0
			local var_186_64 = 0.3

			if var_186_63 < arg_183_1.time_ and arg_183_1.time_ <= var_186_63 + arg_186_0 then
				local var_186_65 = "play"
				local var_186_66 = "music"

				arg_183_1:AudioAction(var_186_65, var_186_66, "ui_battle", "ui_battle_stopbgm", "")

				local var_186_67 = ""
				local var_186_68 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_186_68 ~= "" then
					if arg_183_1.bgmTxt_.text ~= var_186_68 and arg_183_1.bgmTxt_.text ~= "" then
						if arg_183_1.bgmTxt2_.text ~= "" then
							arg_183_1.bgmTxt_.text = arg_183_1.bgmTxt2_.text
						end

						arg_183_1.bgmTxt2_.text = var_186_68

						arg_183_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_183_1.bgmTxt_.text = var_186_68
						arg_183_1.bgmTxt2_.text = var_186_68
					end

					if arg_183_1.bgmTimer then
						arg_183_1.bgmTimer:Stop()

						arg_183_1.bgmTimer = nil
					end

					if arg_183_1.settingData.show_music_name == 1 then
						arg_183_1.musicController:SetSelectedState("show")
						arg_183_1.musicAnimator_:Play("open", 0, 0)

						if arg_183_1.settingData.music_time ~= 0 then
							arg_183_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_183_1.settingData.music_time), function()
								if arg_183_1 == nil or isNil(arg_183_1.bgmTxt_) then
									return
								end

								arg_183_1.musicController:SetSelectedState("hide")
								arg_183_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_186_69 = 1.53333333333333
			local var_186_70 = 1

			if var_186_69 < arg_183_1.time_ and arg_183_1.time_ <= var_186_69 + arg_186_0 then
				local var_186_71 = "play"
				local var_186_72 = "music"

				arg_183_1:AudioAction(var_186_71, var_186_72, "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_186_73 = ""
				local var_186_74 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if var_186_74 ~= "" then
					if arg_183_1.bgmTxt_.text ~= var_186_74 and arg_183_1.bgmTxt_.text ~= "" then
						if arg_183_1.bgmTxt2_.text ~= "" then
							arg_183_1.bgmTxt_.text = arg_183_1.bgmTxt2_.text
						end

						arg_183_1.bgmTxt2_.text = var_186_74

						arg_183_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_183_1.bgmTxt_.text = var_186_74
						arg_183_1.bgmTxt2_.text = var_186_74
					end

					if arg_183_1.bgmTimer then
						arg_183_1.bgmTimer:Stop()

						arg_183_1.bgmTimer = nil
					end

					if arg_183_1.settingData.show_music_name == 1 then
						arg_183_1.musicController:SetSelectedState("show")
						arg_183_1.musicAnimator_:Play("open", 0, 0)

						if arg_183_1.settingData.music_time ~= 0 then
							arg_183_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_183_1.settingData.music_time), function()
								if arg_183_1 == nil or isNil(arg_183_1.bgmTxt_) then
									return
								end

								arg_183_1.musicController:SetSelectedState("hide")
								arg_183_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_186_75 = 0.466666666666667
			local var_186_76 = 1

			if var_186_75 < arg_183_1.time_ and arg_183_1.time_ <= var_186_75 + arg_186_0 then
				local var_186_77 = "stop"
				local var_186_78 = "effect"

				arg_183_1:AudioAction(var_186_77, var_186_78, "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			local var_186_79 = arg_183_1.bgs_.SP92601.transform
			local var_186_80 = 2

			if var_186_80 < arg_183_1.time_ and arg_183_1.time_ <= var_186_80 + arg_186_0 then
				arg_183_1.var_.moveOldPosSP92601 = var_186_79.localPosition
			end

			local var_186_81 = 0.001

			if var_186_80 <= arg_183_1.time_ and arg_183_1.time_ < var_186_80 + var_186_81 then
				local var_186_82 = (arg_183_1.time_ - var_186_80) / var_186_81
				local var_186_83 = Vector3.New(0, 1, 7)

				var_186_79.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPosSP92601, var_186_83, var_186_82)
			end

			if arg_183_1.time_ >= var_186_80 + var_186_81 and arg_183_1.time_ < var_186_80 + var_186_81 + arg_186_0 then
				var_186_79.localPosition = Vector3.New(0, 1, 7)
			end

			local var_186_84 = arg_183_1.bgs_.SP92601.transform
			local var_186_85 = 2.034

			if var_186_85 < arg_183_1.time_ and arg_183_1.time_ <= var_186_85 + arg_186_0 then
				arg_183_1.var_.moveOldPosSP92601 = var_186_84.localPosition
			end

			local var_186_86 = 1.89933333333333

			if var_186_85 <= arg_183_1.time_ and arg_183_1.time_ < var_186_85 + var_186_86 then
				local var_186_87 = (arg_183_1.time_ - var_186_85) / var_186_86
				local var_186_88 = Vector3.New(0, 1, 9)

				var_186_84.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPosSP92601, var_186_88, var_186_87)
			end

			if arg_183_1.time_ >= var_186_85 + var_186_86 and arg_183_1.time_ < var_186_85 + var_186_86 + arg_186_0 then
				var_186_84.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_89 = 3.76666666666667
			local var_186_90 = 0.825

			if var_186_89 < arg_183_1.time_ and arg_183_1.time_ <= var_186_89 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_91 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_91:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_183_1.dialogCg_.alpha = arg_189_0
				end))
				var_186_91:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_91:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_92 = arg_183_1:FormatText(StoryNameCfg[1296].name)

				arg_183_1.leftNameTxt_.text = var_186_92

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_93 = arg_183_1:GetWordFromCfg(926041044)
				local var_186_94 = arg_183_1:FormatText(var_186_93.content)

				arg_183_1.text_.text = var_186_94

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_95 = 33
				local var_186_96 = utf8.len(var_186_94)
				local var_186_97 = var_186_95 <= 0 and var_186_90 or var_186_90 * (var_186_96 / var_186_95)

				if var_186_97 > 0 and var_186_90 < var_186_97 then
					arg_183_1.talkMaxDuration = var_186_97
					var_186_89 = var_186_89 + 0.3

					if var_186_97 + var_186_89 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_97 + var_186_89
					end
				end

				arg_183_1.text_.text = var_186_94
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041044", "story_v_out_926041.awb") ~= 0 then
					local var_186_98 = manager.audio:GetVoiceLength("story_v_out_926041", "926041044", "story_v_out_926041.awb") / 1000

					if var_186_98 + var_186_89 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_98 + var_186_89
					end

					if var_186_93.prefab_name ~= "" and arg_183_1.actors_[var_186_93.prefab_name] ~= nil then
						local var_186_99 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_93.prefab_name].transform, "story_v_out_926041", "926041044", "story_v_out_926041.awb")

						arg_183_1:RecordAudio("926041044", var_186_99)
						arg_183_1:RecordAudio("926041044", var_186_99)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_926041", "926041044", "story_v_out_926041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_926041", "926041044", "story_v_out_926041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_100 = var_186_89 + 0.3
			local var_186_101 = math.max(var_186_90, arg_183_1.talkMaxDuration)

			if var_186_100 <= arg_183_1.time_ and arg_183_1.time_ < var_186_100 + var_186_101 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_100) / var_186_101

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_100 + var_186_101 and arg_183_1.time_ < var_186_100 + var_186_101 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SP92601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SP92601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.89933333333333,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play926041045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 926041045
		arg_191_1.duration_ = 4.4

		local var_191_0 = {
			zh = 3.2,
			ja = 4.4
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play926041046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["106603"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps106603 == nil then
				arg_191_1.var_.actorSpriteComps106603 = var_194_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_2 = 0.2

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.actorSpriteComps106603 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								local var_194_4 = Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor1.r, var_194_3)
								local var_194_5 = Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor1.g, var_194_3)
								local var_194_6 = Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor1.b, var_194_3)

								iter_194_1.color = Color.New(var_194_4, var_194_5, var_194_6)
							else
								local var_194_7 = Mathf.Lerp(iter_194_1.color.r, 1, var_194_3)

								iter_194_1.color = Color.New(var_194_7, var_194_7, var_194_7)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.actorSpriteComps106603 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_194_3 then
						if arg_191_1.isInRecall_ then
							iter_194_3.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps106603 = nil
			end

			local var_194_8 = arg_191_1.actors_["104701"]
			local var_194_9 = 0

			if var_194_9 < arg_191_1.time_ and arg_191_1.time_ <= var_194_9 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps104701 == nil then
				arg_191_1.var_.actorSpriteComps104701 = var_194_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_10 = 0.2

			if var_194_9 <= arg_191_1.time_ and arg_191_1.time_ < var_194_9 + var_194_10 and not isNil(var_194_8) then
				local var_194_11 = (arg_191_1.time_ - var_194_9) / var_194_10

				if arg_191_1.var_.actorSpriteComps104701 then
					for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_194_5 then
							if arg_191_1.isInRecall_ then
								local var_194_12 = Mathf.Lerp(iter_194_5.color.r, arg_191_1.hightColor2.r, var_194_11)
								local var_194_13 = Mathf.Lerp(iter_194_5.color.g, arg_191_1.hightColor2.g, var_194_11)
								local var_194_14 = Mathf.Lerp(iter_194_5.color.b, arg_191_1.hightColor2.b, var_194_11)

								iter_194_5.color = Color.New(var_194_12, var_194_13, var_194_14)
							else
								local var_194_15 = Mathf.Lerp(iter_194_5.color.r, 0.5, var_194_11)

								iter_194_5.color = Color.New(var_194_15, var_194_15, var_194_15)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_9 + var_194_10 and arg_191_1.time_ < var_194_9 + var_194_10 + arg_194_0 and not isNil(var_194_8) and arg_191_1.var_.actorSpriteComps104701 then
				for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_194_7 then
						if arg_191_1.isInRecall_ then
							iter_194_7.color = arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_194_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps104701 = nil
			end

			local var_194_16 = arg_191_1.actors_["104701"].transform
			local var_194_17 = 0

			if var_194_17 < arg_191_1.time_ and arg_191_1.time_ <= var_194_17 + arg_194_0 then
				arg_191_1.var_.moveOldPos104701 = var_194_16.localPosition
				var_194_16.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("104701", 7)

				local var_194_18 = var_194_16.childCount

				for iter_194_8 = 0, var_194_18 - 1 do
					local var_194_19 = var_194_16:GetChild(iter_194_8)

					if var_194_19.name == "" or not string.find(var_194_19.name, "split") then
						var_194_19.gameObject:SetActive(true)
					else
						var_194_19.gameObject:SetActive(false)
					end
				end
			end

			local var_194_20 = 0.001

			if var_194_17 <= arg_191_1.time_ and arg_191_1.time_ < var_194_17 + var_194_20 then
				local var_194_21 = (arg_191_1.time_ - var_194_17) / var_194_20
				local var_194_22 = Vector3.New(0, -2000, 0)

				var_194_16.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos104701, var_194_22, var_194_21)
			end

			if arg_191_1.time_ >= var_194_17 + var_194_20 and arg_191_1.time_ < var_194_17 + var_194_20 + arg_194_0 then
				var_194_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_194_23 = 0
			local var_194_24 = 0.3

			if var_194_23 < arg_191_1.time_ and arg_191_1.time_ <= var_194_23 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_25 = arg_191_1:FormatText(StoryNameCfg[32].name)

				arg_191_1.leftNameTxt_.text = var_194_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106603_split_1")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_26 = arg_191_1:GetWordFromCfg(926041045)
				local var_194_27 = arg_191_1:FormatText(var_194_26.content)

				arg_191_1.text_.text = var_194_27

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_28 = 12
				local var_194_29 = utf8.len(var_194_27)
				local var_194_30 = var_194_28 <= 0 and var_194_24 or var_194_24 * (var_194_29 / var_194_28)

				if var_194_30 > 0 and var_194_24 < var_194_30 then
					arg_191_1.talkMaxDuration = var_194_30

					if var_194_30 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_30 + var_194_23
					end
				end

				arg_191_1.text_.text = var_194_27
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041045", "story_v_out_926041.awb") ~= 0 then
					local var_194_31 = manager.audio:GetVoiceLength("story_v_out_926041", "926041045", "story_v_out_926041.awb") / 1000

					if var_194_31 + var_194_23 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_31 + var_194_23
					end

					if var_194_26.prefab_name ~= "" and arg_191_1.actors_[var_194_26.prefab_name] ~= nil then
						local var_194_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_26.prefab_name].transform, "story_v_out_926041", "926041045", "story_v_out_926041.awb")

						arg_191_1:RecordAudio("926041045", var_194_32)
						arg_191_1:RecordAudio("926041045", var_194_32)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_926041", "926041045", "story_v_out_926041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_926041", "926041045", "story_v_out_926041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_33 = math.max(var_194_24, arg_191_1.talkMaxDuration)

			if var_194_23 <= arg_191_1.time_ and arg_191_1.time_ < var_194_23 + var_194_33 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_23) / var_194_33

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_23 + var_194_33 and arg_191_1.time_ < var_194_23 + var_194_33 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play926041046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 926041046
		arg_195_1.duration_ = 7.9

		local var_195_0 = {
			zh = 6.033,
			ja = 7.9
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play926041047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10144"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10144 == nil then
				arg_195_1.var_.actorSpriteComps10144 = var_198_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_2 = 0.2

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.actorSpriteComps10144 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								local var_198_4 = Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, var_198_3)
								local var_198_5 = Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, var_198_3)
								local var_198_6 = Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, var_198_3)

								iter_198_1.color = Color.New(var_198_4, var_198_5, var_198_6)
							else
								local var_198_7 = Mathf.Lerp(iter_198_1.color.r, 1, var_198_3)

								iter_198_1.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.actorSpriteComps10144 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_198_3 then
						if arg_195_1.isInRecall_ then
							iter_198_3.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10144 = nil
			end

			local var_198_8 = arg_195_1.actors_["106603"]
			local var_198_9 = 0

			if var_198_9 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps106603 == nil then
				arg_195_1.var_.actorSpriteComps106603 = var_198_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_10 = 0.2

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_10 and not isNil(var_198_8) then
				local var_198_11 = (arg_195_1.time_ - var_198_9) / var_198_10

				if arg_195_1.var_.actorSpriteComps106603 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								local var_198_12 = Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, var_198_11)
								local var_198_13 = Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, var_198_11)
								local var_198_14 = Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, var_198_11)

								iter_198_5.color = Color.New(var_198_12, var_198_13, var_198_14)
							else
								local var_198_15 = Mathf.Lerp(iter_198_5.color.r, 0.5, var_198_11)

								iter_198_5.color = Color.New(var_198_15, var_198_15, var_198_15)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_9 + var_198_10 and arg_195_1.time_ < var_198_9 + var_198_10 + arg_198_0 and not isNil(var_198_8) and arg_195_1.var_.actorSpriteComps106603 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_198_7 then
						if arg_195_1.isInRecall_ then
							iter_198_7.color = arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_198_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps106603 = nil
			end

			local var_198_16 = 0.1
			local var_198_17 = 1

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 then
				local var_198_18 = "play"
				local var_198_19 = "effect"

				arg_195_1:AudioAction(var_198_18, var_198_19, "se_story_143", "se_story_143_heart_damage_funny", "")
			end

			local var_198_20 = 0
			local var_198_21 = 0.7

			if var_198_20 < arg_195_1.time_ and arg_195_1.time_ <= var_198_20 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_22 = arg_195_1:FormatText(StoryNameCfg[1297].name)

				arg_195_1.leftNameTxt_.text = var_198_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_23 = arg_195_1:GetWordFromCfg(926041046)
				local var_198_24 = arg_195_1:FormatText(var_198_23.content)

				arg_195_1.text_.text = var_198_24

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_25 = 28
				local var_198_26 = utf8.len(var_198_24)
				local var_198_27 = var_198_25 <= 0 and var_198_21 or var_198_21 * (var_198_26 / var_198_25)

				if var_198_27 > 0 and var_198_21 < var_198_27 then
					arg_195_1.talkMaxDuration = var_198_27

					if var_198_27 + var_198_20 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_27 + var_198_20
					end
				end

				arg_195_1.text_.text = var_198_24
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041046", "story_v_out_926041.awb") ~= 0 then
					local var_198_28 = manager.audio:GetVoiceLength("story_v_out_926041", "926041046", "story_v_out_926041.awb") / 1000

					if var_198_28 + var_198_20 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_28 + var_198_20
					end

					if var_198_23.prefab_name ~= "" and arg_195_1.actors_[var_198_23.prefab_name] ~= nil then
						local var_198_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_23.prefab_name].transform, "story_v_out_926041", "926041046", "story_v_out_926041.awb")

						arg_195_1:RecordAudio("926041046", var_198_29)
						arg_195_1:RecordAudio("926041046", var_198_29)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_926041", "926041046", "story_v_out_926041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_926041", "926041046", "story_v_out_926041.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_30 = math.max(var_198_21, arg_195_1.talkMaxDuration)

			if var_198_20 <= arg_195_1.time_ and arg_195_1.time_ < var_198_20 + var_198_30 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_20) / var_198_30

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_20 + var_198_30 and arg_195_1.time_ < var_198_20 + var_198_30 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play926041047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 926041047
		arg_199_1.duration_ = 7.83

		local var_199_0 = {
			zh = 5.2,
			ja = 7.833
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play926041048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.625

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[1297].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(926041047)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 25
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041047", "story_v_out_926041.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041047", "story_v_out_926041.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_926041", "926041047", "story_v_out_926041.awb")

						arg_199_1:RecordAudio("926041047", var_202_9)
						arg_199_1:RecordAudio("926041047", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_926041", "926041047", "story_v_out_926041.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_926041", "926041047", "story_v_out_926041.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play926041048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 926041048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play926041049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["10144"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10144 == nil then
				arg_203_1.var_.actorSpriteComps10144 = var_206_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_2 = 0.2

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.actorSpriteComps10144 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								local var_206_4 = Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, var_206_3)
								local var_206_5 = Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, var_206_3)
								local var_206_6 = Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, var_206_3)

								iter_206_1.color = Color.New(var_206_4, var_206_5, var_206_6)
							else
								local var_206_7 = Mathf.Lerp(iter_206_1.color.r, 0.5, var_206_3)

								iter_206_1.color = Color.New(var_206_7, var_206_7, var_206_7)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.actorSpriteComps10144 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_206_3 then
						if arg_203_1.isInRecall_ then
							iter_206_3.color = arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_206_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_203_1.var_.actorSpriteComps10144 = nil
			end

			local var_206_8 = 0
			local var_206_9 = 0.175

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_10 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_11 = arg_203_1:GetWordFromCfg(926041048)
				local var_206_12 = arg_203_1:FormatText(var_206_11.content)

				arg_203_1.text_.text = var_206_12

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_13 = 7
				local var_206_14 = utf8.len(var_206_12)
				local var_206_15 = var_206_13 <= 0 and var_206_9 or var_206_9 * (var_206_14 / var_206_13)

				if var_206_15 > 0 and var_206_9 < var_206_15 then
					arg_203_1.talkMaxDuration = var_206_15

					if var_206_15 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_15 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_12
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_16 and arg_203_1.time_ < var_206_8 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play926041049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 926041049
		arg_207_1.duration_ = 7.9

		local var_207_0 = {
			zh = 7.6,
			ja = 7.9
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play926041050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["104701"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps104701 == nil then
				arg_207_1.var_.actorSpriteComps104701 = var_210_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_2 = 0.2

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.actorSpriteComps104701 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								local var_210_4 = Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, var_210_3)
								local var_210_5 = Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, var_210_3)
								local var_210_6 = Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, var_210_3)

								iter_210_1.color = Color.New(var_210_4, var_210_5, var_210_6)
							else
								local var_210_7 = Mathf.Lerp(iter_210_1.color.r, 1, var_210_3)

								iter_210_1.color = Color.New(var_210_7, var_210_7, var_210_7)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.actorSpriteComps104701 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_210_3 then
						if arg_207_1.isInRecall_ then
							iter_210_3.color = arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_210_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps104701 = nil
			end

			local var_210_8 = arg_207_1.actors_["106603"].transform
			local var_210_9 = 0

			if var_210_9 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 then
				arg_207_1.var_.moveOldPos106603 = var_210_8.localPosition
				var_210_8.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("106603", 7)

				local var_210_10 = var_210_8.childCount

				for iter_210_4 = 0, var_210_10 - 1 do
					local var_210_11 = var_210_8:GetChild(iter_210_4)

					if var_210_11.name == "" or not string.find(var_210_11.name, "split") then
						var_210_11.gameObject:SetActive(true)
					else
						var_210_11.gameObject:SetActive(false)
					end
				end
			end

			local var_210_12 = 0.001

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_12 then
				local var_210_13 = (arg_207_1.time_ - var_210_9) / var_210_12
				local var_210_14 = Vector3.New(0, -2000, 0)

				var_210_8.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos106603, var_210_14, var_210_13)
			end

			if arg_207_1.time_ >= var_210_9 + var_210_12 and arg_207_1.time_ < var_210_9 + var_210_12 + arg_210_0 then
				var_210_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_15 = arg_207_1.actors_["10144"].transform
			local var_210_16 = 0

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				arg_207_1.var_.moveOldPos10144 = var_210_15.localPosition
				var_210_15.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10144", 7)

				local var_210_17 = var_210_15.childCount

				for iter_210_5 = 0, var_210_17 - 1 do
					local var_210_18 = var_210_15:GetChild(iter_210_5)

					if var_210_18.name == "" or not string.find(var_210_18.name, "split") then
						var_210_18.gameObject:SetActive(true)
					else
						var_210_18.gameObject:SetActive(false)
					end
				end
			end

			local var_210_19 = 0.001

			if var_210_16 <= arg_207_1.time_ and arg_207_1.time_ < var_210_16 + var_210_19 then
				local var_210_20 = (arg_207_1.time_ - var_210_16) / var_210_19
				local var_210_21 = Vector3.New(0, -2000, 0)

				var_210_15.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10144, var_210_21, var_210_20)
			end

			if arg_207_1.time_ >= var_210_16 + var_210_19 and arg_207_1.time_ < var_210_16 + var_210_19 + arg_210_0 then
				var_210_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_22 = arg_207_1.actors_["104701"].transform
			local var_210_23 = 0

			if var_210_23 < arg_207_1.time_ and arg_207_1.time_ <= var_210_23 + arg_210_0 then
				arg_207_1.var_.moveOldPos104701 = var_210_22.localPosition
				var_210_22.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("104701", 7)

				local var_210_24 = var_210_22.childCount

				for iter_210_6 = 0, var_210_24 - 1 do
					local var_210_25 = var_210_22:GetChild(iter_210_6)

					if var_210_25.name == "" or not string.find(var_210_25.name, "split") then
						var_210_25.gameObject:SetActive(true)
					else
						var_210_25.gameObject:SetActive(false)
					end
				end
			end

			local var_210_26 = 0.001

			if var_210_23 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_26 then
				local var_210_27 = (arg_207_1.time_ - var_210_23) / var_210_26
				local var_210_28 = Vector3.New(0, -2000, 0)

				var_210_22.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos104701, var_210_28, var_210_27)
			end

			if arg_207_1.time_ >= var_210_23 + var_210_26 and arg_207_1.time_ < var_210_23 + var_210_26 + arg_210_0 then
				var_210_22.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_29 = 0
			local var_210_30 = 0.85

			if var_210_29 < arg_207_1.time_ and arg_207_1.time_ <= var_210_29 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_31 = arg_207_1:FormatText(StoryNameCfg[1296].name)

				arg_207_1.leftNameTxt_.text = var_210_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_32 = arg_207_1:GetWordFromCfg(926041049)
				local var_210_33 = arg_207_1:FormatText(var_210_32.content)

				arg_207_1.text_.text = var_210_33

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_34 = 34
				local var_210_35 = utf8.len(var_210_33)
				local var_210_36 = var_210_34 <= 0 and var_210_30 or var_210_30 * (var_210_35 / var_210_34)

				if var_210_36 > 0 and var_210_30 < var_210_36 then
					arg_207_1.talkMaxDuration = var_210_36

					if var_210_36 + var_210_29 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_36 + var_210_29
					end
				end

				arg_207_1.text_.text = var_210_33
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041049", "story_v_out_926041.awb") ~= 0 then
					local var_210_37 = manager.audio:GetVoiceLength("story_v_out_926041", "926041049", "story_v_out_926041.awb") / 1000

					if var_210_37 + var_210_29 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_37 + var_210_29
					end

					if var_210_32.prefab_name ~= "" and arg_207_1.actors_[var_210_32.prefab_name] ~= nil then
						local var_210_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_32.prefab_name].transform, "story_v_out_926041", "926041049", "story_v_out_926041.awb")

						arg_207_1:RecordAudio("926041049", var_210_38)
						arg_207_1:RecordAudio("926041049", var_210_38)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_926041", "926041049", "story_v_out_926041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_926041", "926041049", "story_v_out_926041.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_39 = math.max(var_210_30, arg_207_1.talkMaxDuration)

			if var_210_29 <= arg_207_1.time_ and arg_207_1.time_ < var_210_29 + var_210_39 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_29) / var_210_39

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_29 + var_210_39 and arg_207_1.time_ < var_210_29 + var_210_39 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play926041050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 926041050
		arg_211_1.duration_ = 3.9

		local var_211_0 = {
			zh = 2.933,
			ja = 3.9
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play926041051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.325

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[1297].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:GetWordFromCfg(926041050)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 13
				local var_214_6 = utf8.len(var_214_4)
				local var_214_7 = var_214_5 <= 0 and var_214_1 or var_214_1 * (var_214_6 / var_214_5)

				if var_214_7 > 0 and var_214_1 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_4
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041050", "story_v_out_926041.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041050", "story_v_out_926041.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_926041", "926041050", "story_v_out_926041.awb")

						arg_211_1:RecordAudio("926041050", var_214_9)
						arg_211_1:RecordAudio("926041050", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_926041", "926041050", "story_v_out_926041.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_926041", "926041050", "story_v_out_926041.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_10 and arg_211_1.time_ < var_214_0 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play926041051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 926041051
		arg_215_1.duration_ = 6.47

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play926041052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10144"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps10144 == nil then
				arg_215_1.var_.actorSpriteComps10144 = var_218_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_2 = 0.2

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.actorSpriteComps10144 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								local var_218_4 = Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor2.r, var_218_3)
								local var_218_5 = Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor2.g, var_218_3)
								local var_218_6 = Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor2.b, var_218_3)

								iter_218_1.color = Color.New(var_218_4, var_218_5, var_218_6)
							else
								local var_218_7 = Mathf.Lerp(iter_218_1.color.r, 0.5, var_218_3)

								iter_218_1.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.actorSpriteComps10144 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_218_3 then
						if arg_215_1.isInRecall_ then
							iter_218_3.color = arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_218_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_215_1.var_.actorSpriteComps10144 = nil
			end

			local var_218_8 = arg_215_1.bgs_.SP92601.transform
			local var_218_9 = 0

			if var_218_9 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.var_.moveOldPosSP92601 = var_218_8.localPosition
			end

			local var_218_10 = 0.001

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_10 then
				local var_218_11 = (arg_215_1.time_ - var_218_9) / var_218_10
				local var_218_12 = Vector3.New(0, 1, 6)

				var_218_8.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPosSP92601, var_218_12, var_218_11)
			end

			if arg_215_1.time_ >= var_218_9 + var_218_10 and arg_215_1.time_ < var_218_9 + var_218_10 + arg_218_0 then
				var_218_8.localPosition = Vector3.New(0, 1, 6)
			end

			local var_218_13 = arg_215_1.bgs_.SP92601.transform
			local var_218_14 = 0.0339999999999998

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.var_.moveOldPosSP92601 = var_218_13.localPosition
			end

			local var_218_15 = 1.966

			if var_218_14 <= arg_215_1.time_ and arg_215_1.time_ < var_218_14 + var_218_15 then
				local var_218_16 = (arg_215_1.time_ - var_218_14) / var_218_15
				local var_218_17 = Vector3.New(0, 0.73, 4.06)

				var_218_13.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPosSP92601, var_218_17, var_218_16)
			end

			if arg_215_1.time_ >= var_218_14 + var_218_15 and arg_215_1.time_ < var_218_14 + var_218_15 + arg_218_0 then
				var_218_13.localPosition = Vector3.New(0, 0.73, 4.06)
			end

			local var_218_18 = 0

			if var_218_18 < arg_215_1.time_ and arg_215_1.time_ <= var_218_18 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_19 = 1.26666666666667

			if var_218_18 <= arg_215_1.time_ and arg_215_1.time_ < var_218_18 + var_218_19 then
				local var_218_20 = (arg_215_1.time_ - var_218_18) / var_218_19
				local var_218_21 = Color.New(1, 1, 1)

				var_218_21.a = Mathf.Lerp(1, 0, var_218_20)
				arg_215_1.mask_.color = var_218_21
			end

			if arg_215_1.time_ >= var_218_18 + var_218_19 and arg_215_1.time_ < var_218_18 + var_218_19 + arg_218_0 then
				local var_218_22 = Color.New(1, 1, 1)
				local var_218_23 = 0

				arg_215_1.mask_.enabled = false
				var_218_22.a = var_218_23
				arg_215_1.mask_.color = var_218_22
			end

			local var_218_24 = 0

			if var_218_24 < arg_215_1.time_ and arg_215_1.time_ <= var_218_24 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			local var_218_25 = 2.5

			if arg_215_1.time_ >= var_218_24 + var_218_25 and arg_215_1.time_ < var_218_24 + var_218_25 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_26 = 0.0339999999999998
			local var_218_27 = 1

			if var_218_26 < arg_215_1.time_ and arg_215_1.time_ <= var_218_26 + arg_218_0 then
				local var_218_28 = "play"
				local var_218_29 = "effect"

				arg_215_1:AudioAction(var_218_28, var_218_29, "se_story_143", "se_story_143_door", "")
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_30 = 1.46666666666667
			local var_218_31 = 0.925

			if var_218_30 < arg_215_1.time_ and arg_215_1.time_ <= var_218_30 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_32 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_32:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_33 = arg_215_1:GetWordFromCfg(926041051)
				local var_218_34 = arg_215_1:FormatText(var_218_33.content)

				arg_215_1.text_.text = var_218_34

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_35 = 37
				local var_218_36 = utf8.len(var_218_34)
				local var_218_37 = var_218_35 <= 0 and var_218_31 or var_218_31 * (var_218_36 / var_218_35)

				if var_218_37 > 0 and var_218_31 < var_218_37 then
					arg_215_1.talkMaxDuration = var_218_37
					var_218_30 = var_218_30 + 0.3

					if var_218_37 + var_218_30 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_37 + var_218_30
					end
				end

				arg_215_1.text_.text = var_218_34
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_38 = var_218_30 + 0.3
			local var_218_39 = math.max(var_218_31, arg_215_1.talkMaxDuration)

			if var_218_38 <= arg_215_1.time_ and arg_215_1.time_ < var_218_38 + var_218_39 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_38) / var_218_39

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_38 + var_218_39 and arg_215_1.time_ < var_218_38 + var_218_39 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SP92601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0339999999999998,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SP92601",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966,
				className = "StoryMoveNode",
				startTime = 0.0339999999999998,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play926041052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 926041052
		arg_221_1.duration_ = 1.57

		local var_221_0 = {
			zh = 1.433,
			ja = 1.566
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
			arg_221_1.auto_ = false
		end

		function arg_221_1.playNext_(arg_223_0)
			arg_221_1.onStoryFinished_()
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.125

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[1297].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:GetWordFromCfg(926041052)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 5
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926041", "926041052", "story_v_out_926041.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_926041", "926041052", "story_v_out_926041.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_926041", "926041052", "story_v_out_926041.awb")

						arg_221_1:RecordAudio("926041052", var_224_9)
						arg_221_1:RecordAudio("926041052", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_926041", "926041052", "story_v_out_926041.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_926041", "926041052", "story_v_out_926041.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I22f",
		"TextureConfig/Background/SP92601"
	},
	voices = {
		"story_v_out_926041.awb"
	}
}
