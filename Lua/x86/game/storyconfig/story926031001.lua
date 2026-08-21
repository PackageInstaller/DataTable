return {
	Play926031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926031001
		arg_1_1.duration_ = 4.7

		local var_1_0 = {
			zh = 4.7,
			ja = 3.9
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
				arg_1_0:Play926031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0114"

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
				local var_4_5 = arg_1_1.bgs_.ST0114

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
					if iter_4_0 ~= "ST0114" then
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
			local var_4_29 = 1.675

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
			local var_4_37 = 1.675

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPos128404 = var_4_36.localPosition
				var_4_36.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("128404", 3)

				local var_4_38 = var_4_36.childCount

				for iter_4_8 = 0, var_4_38 - 1 do
					local var_4_39 = var_4_36:GetChild(iter_4_8)

					if var_4_39.name == "split_2" or not string.find(var_4_39.name, "split") then
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
			local var_4_44 = 1.675

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue128404 = var_4_45.alpha
					arg_1_1.var_.characterEffect128404 = var_4_45
				end

				arg_1_1.var_.alphaOldValue128404 = 0
			end

			local var_4_46 = 0.325

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

			local var_4_49 = 0.166666666666667
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "effect"

				arg_1_1:AudioAction(var_4_51, var_4_52, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_4_53 = 0
			local var_4_54 = 0.433333333333333

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

			local var_4_59 = 0.7
			local var_4_60 = 1

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				local var_4_61 = "play"
				local var_4_62 = "music"

				arg_1_1:AudioAction(var_4_61, var_4_62, "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_4_63 = ""
				local var_4_64 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

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
			local var_4_66 = 0.125

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

				local var_4_69 = arg_1_1:GetWordFromCfg(926031001)
				local var_4_70 = arg_1_1:FormatText(var_4_69.content)

				arg_1_1.text_.text = var_4_70

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_71 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031001", "story_v_out_926031.awb") ~= 0 then
					local var_4_74 = manager.audio:GetVoiceLength("story_v_out_926031", "926031001", "story_v_out_926031.awb") / 1000

					if var_4_74 + var_4_65 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_65
					end

					if var_4_69.prefab_name ~= "" and arg_1_1.actors_[var_4_69.prefab_name] ~= nil then
						local var_4_75 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_69.prefab_name].transform, "story_v_out_926031", "926031001", "story_v_out_926031.awb")

						arg_1_1:RecordAudio("926031001", var_4_75)
						arg_1_1:RecordAudio("926031001", var_4_75)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926031", "926031001", "story_v_out_926031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926031", "926031001", "story_v_out_926031.awb")
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
				startTime = 1.675,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926031002
		arg_9_1.duration_ = 9.43

		local var_9_0 = {
			zh = 6.766,
			ja = 9.433
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
				arg_9_0:Play926031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "104701"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

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

			local var_12_4 = arg_9_1.actors_["104701"]
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps104701 == nil then
				arg_9_1.var_.actorSpriteComps104701 = var_12_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 0.2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 and not isNil(var_12_4) then
				local var_12_7 = (arg_9_1.time_ - var_12_5) / var_12_6

				if arg_9_1.var_.actorSpriteComps104701 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.actorSpriteComps104701 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_12_5 then
						if arg_9_1.isInRecall_ then
							iter_12_5.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps104701 = nil
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

			local var_12_27 = arg_9_1.actors_["104701"].transform
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				arg_9_1.var_.moveOldPos104701 = var_12_27.localPosition
				var_12_27.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("104701", 3)

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
				local var_12_33 = Vector3.New(-67.4, -386.8, -295)

				var_12_27.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos104701, var_12_33, var_12_32)
			end

			if arg_9_1.time_ >= var_12_28 + var_12_31 and arg_9_1.time_ < var_12_28 + var_12_31 + arg_12_0 then
				var_12_27.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_12_34 = 0
			local var_12_35 = 0.675

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_36 = arg_9_1:FormatText(StoryNameCfg[1296].name)

				arg_9_1.leftNameTxt_.text = var_12_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_37 = arg_9_1:GetWordFromCfg(926031002)
				local var_12_38 = arg_9_1:FormatText(var_12_37.content)

				arg_9_1.text_.text = var_12_38

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_39 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031002", "story_v_out_926031.awb") ~= 0 then
					local var_12_42 = manager.audio:GetVoiceLength("story_v_out_926031", "926031002", "story_v_out_926031.awb") / 1000

					if var_12_42 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_42 + var_12_34
					end

					if var_12_37.prefab_name ~= "" and arg_9_1.actors_[var_12_37.prefab_name] ~= nil then
						local var_12_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_37.prefab_name].transform, "story_v_out_926031", "926031002", "story_v_out_926031.awb")

						arg_9_1:RecordAudio("926031002", var_12_43)
						arg_9_1:RecordAudio("926031002", var_12_43)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926031", "926031002", "story_v_out_926031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926031", "926031002", "story_v_out_926031.awb")
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
				actorName = "104701",
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
	Play926031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926031003
		arg_13_1.duration_ = 9.67

		local var_13_0 = {
			zh = 7.533,
			ja = 9.666
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
				arg_13_0:Play926031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.85

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[1296].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(926031003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031003", "story_v_out_926031.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031003", "story_v_out_926031.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_926031", "926031003", "story_v_out_926031.awb")

						arg_13_1:RecordAudio("926031003", var_16_9)
						arg_13_1:RecordAudio("926031003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926031", "926031003", "story_v_out_926031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926031", "926031003", "story_v_out_926031.awb")
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
	Play926031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926031004
		arg_17_1.duration_ = 7.5

		local var_17_0 = {
			zh = 4.7,
			ja = 7.5
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
				arg_17_0:Play926031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["128404"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps128404 == nil then
				arg_17_1.var_.actorSpriteComps128404 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.2

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps128404 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps128404 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps128404 = nil
			end

			local var_20_8 = arg_17_1.actors_["104701"]
			local var_20_9 = 0

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps104701 == nil then
				arg_17_1.var_.actorSpriteComps104701 = var_20_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_10 = 0.2

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_10 and not isNil(var_20_8) then
				local var_20_11 = (arg_17_1.time_ - var_20_9) / var_20_10

				if arg_17_1.var_.actorSpriteComps104701 then
					for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_20_5 then
							if arg_17_1.isInRecall_ then
								local var_20_12 = Mathf.Lerp(iter_20_5.color.r, arg_17_1.hightColor2.r, var_20_11)
								local var_20_13 = Mathf.Lerp(iter_20_5.color.g, arg_17_1.hightColor2.g, var_20_11)
								local var_20_14 = Mathf.Lerp(iter_20_5.color.b, arg_17_1.hightColor2.b, var_20_11)

								iter_20_5.color = Color.New(var_20_12, var_20_13, var_20_14)
							else
								local var_20_15 = Mathf.Lerp(iter_20_5.color.r, 0.5, var_20_11)

								iter_20_5.color = Color.New(var_20_15, var_20_15, var_20_15)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_9 + var_20_10 and arg_17_1.time_ < var_20_9 + var_20_10 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.actorSpriteComps104701 then
				for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_20_7 then
						if arg_17_1.isInRecall_ then
							iter_20_7.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps104701 = nil
			end

			local var_20_16 = arg_17_1.actors_["104701"].transform
			local var_20_17 = 0

			if var_20_17 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.var_.moveOldPos104701 = var_20_16.localPosition
				var_20_16.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("104701", 7)

				local var_20_18 = var_20_16.childCount

				for iter_20_8 = 0, var_20_18 - 1 do
					local var_20_19 = var_20_16:GetChild(iter_20_8)

					if var_20_19.name == "" or not string.find(var_20_19.name, "split") then
						var_20_19.gameObject:SetActive(true)
					else
						var_20_19.gameObject:SetActive(false)
					end
				end
			end

			local var_20_20 = 0.001

			if var_20_17 <= arg_17_1.time_ and arg_17_1.time_ < var_20_17 + var_20_20 then
				local var_20_21 = (arg_17_1.time_ - var_20_17) / var_20_20
				local var_20_22 = Vector3.New(0, -2000, 0)

				var_20_16.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos104701, var_20_22, var_20_21)
			end

			if arg_17_1.time_ >= var_20_17 + var_20_20 and arg_17_1.time_ < var_20_17 + var_20_20 + arg_20_0 then
				var_20_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_23 = arg_17_1.actors_["128404"].transform
			local var_20_24 = 0

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1.var_.moveOldPos128404 = var_20_23.localPosition
				var_20_23.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("128404", 3)

				local var_20_25 = var_20_23.childCount

				for iter_20_9 = 0, var_20_25 - 1 do
					local var_20_26 = var_20_23:GetChild(iter_20_9)

					if var_20_26.name == "" or not string.find(var_20_26.name, "split") then
						var_20_26.gameObject:SetActive(true)
					else
						var_20_26.gameObject:SetActive(false)
					end
				end
			end

			local var_20_27 = 0.001

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_27 then
				local var_20_28 = (arg_17_1.time_ - var_20_24) / var_20_27
				local var_20_29 = Vector3.New(-16.1, -362, -375)

				var_20_23.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos128404, var_20_29, var_20_28)
			end

			if arg_17_1.time_ >= var_20_24 + var_20_27 and arg_17_1.time_ < var_20_24 + var_20_27 + arg_20_0 then
				var_20_23.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_20_30 = 0
			local var_20_31 = 0.6

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_32 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_33 = arg_17_1:GetWordFromCfg(926031004)
				local var_20_34 = arg_17_1:FormatText(var_20_33.content)

				arg_17_1.text_.text = var_20_34

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_35 = 24
				local var_20_36 = utf8.len(var_20_34)
				local var_20_37 = var_20_35 <= 0 and var_20_31 or var_20_31 * (var_20_36 / var_20_35)

				if var_20_37 > 0 and var_20_31 < var_20_37 then
					arg_17_1.talkMaxDuration = var_20_37

					if var_20_37 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_37 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_34
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031004", "story_v_out_926031.awb") ~= 0 then
					local var_20_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031004", "story_v_out_926031.awb") / 1000

					if var_20_38 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_38 + var_20_30
					end

					if var_20_33.prefab_name ~= "" and arg_17_1.actors_[var_20_33.prefab_name] ~= nil then
						local var_20_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_33.prefab_name].transform, "story_v_out_926031", "926031004", "story_v_out_926031.awb")

						arg_17_1:RecordAudio("926031004", var_20_39)
						arg_17_1:RecordAudio("926031004", var_20_39)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_926031", "926031004", "story_v_out_926031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_926031", "926031004", "story_v_out_926031.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_40 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_40 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_30) / var_20_40

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_30 + var_20_40 and arg_17_1.time_ < var_20_30 + var_20_40 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
				actorName = "128404",
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
	Play926031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play926031006(arg_21_1)
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
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 0.5, var_24_3)

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
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps128404 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.575

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_10 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_11 = arg_21_1:GetWordFromCfg(926031005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 23
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_9 or var_24_9 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_9 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play926031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926031006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play926031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.425

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(926031006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 17
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play926031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926031007
		arg_29_1.duration_ = 5.37

		local var_29_0 = {
			zh = 4.266,
			ja = 5.366
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
				arg_29_0:Play926031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "106103"

			if arg_29_1.actors_[var_32_0] == nil then
				local var_32_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_32_1) then
					local var_32_2 = Object.Instantiate(var_32_1, arg_29_1.canvasGo_.transform)

					var_32_2.transform:SetSiblingIndex(1)

					var_32_2.name = var_32_0
					var_32_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_[var_32_0] = var_32_2

					local var_32_3 = var_32_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs(var_32_3) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_4 = arg_29_1.actors_["106103"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.actorSpriteComps106103 == nil then
				arg_29_1.var_.actorSpriteComps106103 = var_32_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 0.2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.actorSpriteComps106103 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								local var_32_8 = Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, var_32_7)
								local var_32_9 = Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, var_32_7)
								local var_32_10 = Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, var_32_7)

								iter_32_3.color = Color.New(var_32_8, var_32_9, var_32_10)
							else
								local var_32_11 = Mathf.Lerp(iter_32_3.color.r, 1, var_32_7)

								iter_32_3.color = Color.New(var_32_11, var_32_11, var_32_11)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.actorSpriteComps106103 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_32_5 then
						if arg_29_1.isInRecall_ then
							iter_32_5.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps106103 = nil
			end

			local var_32_12 = arg_29_1.actors_["104701"].transform
			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1.var_.moveOldPos104701 = var_32_12.localPosition
				var_32_12.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("104701", 7)

				local var_32_14 = var_32_12.childCount

				for iter_32_6 = 0, var_32_14 - 1 do
					local var_32_15 = var_32_12:GetChild(iter_32_6)

					if var_32_15.name == "" or not string.find(var_32_15.name, "split") then
						var_32_15.gameObject:SetActive(true)
					else
						var_32_15.gameObject:SetActive(false)
					end
				end
			end

			local var_32_16 = 0.001

			if var_32_13 <= arg_29_1.time_ and arg_29_1.time_ < var_32_13 + var_32_16 then
				local var_32_17 = (arg_29_1.time_ - var_32_13) / var_32_16
				local var_32_18 = Vector3.New(0, -2000, 0)

				var_32_12.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos104701, var_32_18, var_32_17)
			end

			if arg_29_1.time_ >= var_32_13 + var_32_16 and arg_29_1.time_ < var_32_13 + var_32_16 + arg_32_0 then
				var_32_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_19 = arg_29_1.actors_["128404"].transform
			local var_32_20 = 0

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 then
				arg_29_1.var_.moveOldPos128404 = var_32_19.localPosition
				var_32_19.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("128404", 7)

				local var_32_21 = var_32_19.childCount

				for iter_32_7 = 0, var_32_21 - 1 do
					local var_32_22 = var_32_19:GetChild(iter_32_7)

					if var_32_22.name == "" or not string.find(var_32_22.name, "split") then
						var_32_22.gameObject:SetActive(true)
					else
						var_32_22.gameObject:SetActive(false)
					end
				end
			end

			local var_32_23 = 0.001

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_23 then
				local var_32_24 = (arg_29_1.time_ - var_32_20) / var_32_23
				local var_32_25 = Vector3.New(0, -2000, 0)

				var_32_19.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos128404, var_32_25, var_32_24)
			end

			if arg_29_1.time_ >= var_32_20 + var_32_23 and arg_29_1.time_ < var_32_20 + var_32_23 + arg_32_0 then
				var_32_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_26 = arg_29_1.actors_["106103"].transform
			local var_32_27 = 0

			if var_32_27 < arg_29_1.time_ and arg_29_1.time_ <= var_32_27 + arg_32_0 then
				arg_29_1.var_.moveOldPos106103 = var_32_26.localPosition
				var_32_26.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("106103", 3)

				local var_32_28 = var_32_26.childCount

				for iter_32_8 = 0, var_32_28 - 1 do
					local var_32_29 = var_32_26:GetChild(iter_32_8)

					if var_32_29.name == "split_3" or not string.find(var_32_29.name, "split") then
						var_32_29.gameObject:SetActive(true)
					else
						var_32_29.gameObject:SetActive(false)
					end
				end
			end

			local var_32_30 = 0.001

			if var_32_27 <= arg_29_1.time_ and arg_29_1.time_ < var_32_27 + var_32_30 then
				local var_32_31 = (arg_29_1.time_ - var_32_27) / var_32_30
				local var_32_32 = Vector3.New(-36.6, -398.2, -333.7)

				var_32_26.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos106103, var_32_32, var_32_31)
			end

			if arg_29_1.time_ >= var_32_27 + var_32_30 and arg_29_1.time_ < var_32_27 + var_32_30 + arg_32_0 then
				var_32_26.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_32_33 = 0
			local var_32_34 = 0.425

			if var_32_33 < arg_29_1.time_ and arg_29_1.time_ <= var_32_33 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_35 = arg_29_1:FormatText(StoryNameCfg[612].name)

				arg_29_1.leftNameTxt_.text = var_32_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_36 = arg_29_1:GetWordFromCfg(926031007)
				local var_32_37 = arg_29_1:FormatText(var_32_36.content)

				arg_29_1.text_.text = var_32_37

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_38 = 17
				local var_32_39 = utf8.len(var_32_37)
				local var_32_40 = var_32_38 <= 0 and var_32_34 or var_32_34 * (var_32_39 / var_32_38)

				if var_32_40 > 0 and var_32_34 < var_32_40 then
					arg_29_1.talkMaxDuration = var_32_40

					if var_32_40 + var_32_33 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_40 + var_32_33
					end
				end

				arg_29_1.text_.text = var_32_37
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031007", "story_v_out_926031.awb") ~= 0 then
					local var_32_41 = manager.audio:GetVoiceLength("story_v_out_926031", "926031007", "story_v_out_926031.awb") / 1000

					if var_32_41 + var_32_33 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_41 + var_32_33
					end

					if var_32_36.prefab_name ~= "" and arg_29_1.actors_[var_32_36.prefab_name] ~= nil then
						local var_32_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_36.prefab_name].transform, "story_v_out_926031", "926031007", "story_v_out_926031.awb")

						arg_29_1:RecordAudio("926031007", var_32_42)
						arg_29_1:RecordAudio("926031007", var_32_42)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926031", "926031007", "story_v_out_926031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926031", "926031007", "story_v_out_926031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_43 = math.max(var_32_34, arg_29_1.talkMaxDuration)

			if var_32_33 <= arg_29_1.time_ and arg_29_1.time_ < var_32_33 + var_32_43 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_33) / var_32_43

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_33 + var_32_43 and arg_29_1.time_ < var_32_33 + var_32_43 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play926031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926031008
		arg_33_1.duration_ = 4.3

		local var_33_0 = {
			zh = 3.2,
			ja = 4.3
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
				arg_33_0:Play926031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["104701"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps104701 == nil then
				arg_33_1.var_.actorSpriteComps104701 = var_36_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_2 = 0.2

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.actorSpriteComps104701 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.actorSpriteComps104701 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_36_3 then
						if arg_33_1.isInRecall_ then
							iter_36_3.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps104701 = nil
			end

			local var_36_8 = arg_33_1.actors_["106103"]
			local var_36_9 = 0

			if var_36_9 < arg_33_1.time_ and arg_33_1.time_ <= var_36_9 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps106103 == nil then
				arg_33_1.var_.actorSpriteComps106103 = var_36_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_10 = 0.2

			if var_36_9 <= arg_33_1.time_ and arg_33_1.time_ < var_36_9 + var_36_10 and not isNil(var_36_8) then
				local var_36_11 = (arg_33_1.time_ - var_36_9) / var_36_10

				if arg_33_1.var_.actorSpriteComps106103 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								local var_36_12 = Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, var_36_11)
								local var_36_13 = Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, var_36_11)
								local var_36_14 = Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, var_36_11)

								iter_36_5.color = Color.New(var_36_12, var_36_13, var_36_14)
							else
								local var_36_15 = Mathf.Lerp(iter_36_5.color.r, 0.5, var_36_11)

								iter_36_5.color = Color.New(var_36_15, var_36_15, var_36_15)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_9 + var_36_10 and arg_33_1.time_ < var_36_9 + var_36_10 + arg_36_0 and not isNil(var_36_8) and arg_33_1.var_.actorSpriteComps106103 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_36_7 then
						if arg_33_1.isInRecall_ then
							iter_36_7.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps106103 = nil
			end

			local var_36_16 = 0
			local var_36_17 = 0.325

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_18 = arg_33_1:FormatText(StoryNameCfg[1296].name)

				arg_33_1.leftNameTxt_.text = var_36_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_19 = arg_33_1:GetWordFromCfg(926031008)
				local var_36_20 = arg_33_1:FormatText(var_36_19.content)

				arg_33_1.text_.text = var_36_20

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_21 = 13
				local var_36_22 = utf8.len(var_36_20)
				local var_36_23 = var_36_21 <= 0 and var_36_17 or var_36_17 * (var_36_22 / var_36_21)

				if var_36_23 > 0 and var_36_17 < var_36_23 then
					arg_33_1.talkMaxDuration = var_36_23

					if var_36_23 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_16
					end
				end

				arg_33_1.text_.text = var_36_20
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031008", "story_v_out_926031.awb") ~= 0 then
					local var_36_24 = manager.audio:GetVoiceLength("story_v_out_926031", "926031008", "story_v_out_926031.awb") / 1000

					if var_36_24 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_24 + var_36_16
					end

					if var_36_19.prefab_name ~= "" and arg_33_1.actors_[var_36_19.prefab_name] ~= nil then
						local var_36_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_19.prefab_name].transform, "story_v_out_926031", "926031008", "story_v_out_926031.awb")

						arg_33_1:RecordAudio("926031008", var_36_25)
						arg_33_1:RecordAudio("926031008", var_36_25)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_926031", "926031008", "story_v_out_926031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_926031", "926031008", "story_v_out_926031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_26 = math.max(var_36_17, arg_33_1.talkMaxDuration)

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_26 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_16) / var_36_26

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_16 + var_36_26 and arg_33_1.time_ < var_36_16 + var_36_26 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play926031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926031009
		arg_37_1.duration_ = 1.67

		local var_37_0 = {
			zh = 1.366,
			ja = 1.666
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
				arg_37_0:Play926031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["106103"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps106103 == nil then
				arg_37_1.var_.actorSpriteComps106103 = var_40_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.actorSpriteComps106103 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								local var_40_4 = Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, var_40_3)
								local var_40_5 = Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, var_40_3)
								local var_40_6 = Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, var_40_3)

								iter_40_1.color = Color.New(var_40_4, var_40_5, var_40_6)
							else
								local var_40_7 = Mathf.Lerp(iter_40_1.color.r, 1, var_40_3)

								iter_40_1.color = Color.New(var_40_7, var_40_7, var_40_7)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.actorSpriteComps106103 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_40_3 then
						if arg_37_1.isInRecall_ then
							iter_40_3.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps106103 = nil
			end

			local var_40_8 = arg_37_1.actors_["104701"]
			local var_40_9 = 0

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps104701 == nil then
				arg_37_1.var_.actorSpriteComps104701 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_10 = 0.2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 and not isNil(var_40_8) then
				local var_40_11 = (arg_37_1.time_ - var_40_9) / var_40_10

				if arg_37_1.var_.actorSpriteComps104701 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								local var_40_12 = Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, var_40_11)
								local var_40_13 = Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, var_40_11)
								local var_40_14 = Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, var_40_11)

								iter_40_5.color = Color.New(var_40_12, var_40_13, var_40_14)
							else
								local var_40_15 = Mathf.Lerp(iter_40_5.color.r, 0.5, var_40_11)

								iter_40_5.color = Color.New(var_40_15, var_40_15, var_40_15)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps104701 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_40_7 then
						if arg_37_1.isInRecall_ then
							iter_40_7.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps104701 = nil
			end

			local var_40_16 = arg_37_1.actors_["106103"].transform
			local var_40_17 = 0

			if var_40_17 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 then
				arg_37_1.var_.moveOldPos106103 = var_40_16.localPosition
				var_40_16.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("106103", 3)

				local var_40_18 = var_40_16.childCount

				for iter_40_8 = 0, var_40_18 - 1 do
					local var_40_19 = var_40_16:GetChild(iter_40_8)

					if var_40_19.name == "split_4" or not string.find(var_40_19.name, "split") then
						var_40_19.gameObject:SetActive(true)
					else
						var_40_19.gameObject:SetActive(false)
					end
				end
			end

			local var_40_20 = 0.001

			if var_40_17 <= arg_37_1.time_ and arg_37_1.time_ < var_40_17 + var_40_20 then
				local var_40_21 = (arg_37_1.time_ - var_40_17) / var_40_20
				local var_40_22 = Vector3.New(-36.6, -398.2, -333.7)

				var_40_16.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos106103, var_40_22, var_40_21)
			end

			if arg_37_1.time_ >= var_40_17 + var_40_20 and arg_37_1.time_ < var_40_17 + var_40_20 + arg_40_0 then
				var_40_16.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_40_23 = 0
			local var_40_24 = 0.125

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_25 = arg_37_1:FormatText(StoryNameCfg[612].name)

				arg_37_1.leftNameTxt_.text = var_40_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_26 = arg_37_1:GetWordFromCfg(926031009)
				local var_40_27 = arg_37_1:FormatText(var_40_26.content)

				arg_37_1.text_.text = var_40_27

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_28 = 5
				local var_40_29 = utf8.len(var_40_27)
				local var_40_30 = var_40_28 <= 0 and var_40_24 or var_40_24 * (var_40_29 / var_40_28)

				if var_40_30 > 0 and var_40_24 < var_40_30 then
					arg_37_1.talkMaxDuration = var_40_30

					if var_40_30 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_30 + var_40_23
					end
				end

				arg_37_1.text_.text = var_40_27
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031009", "story_v_out_926031.awb") ~= 0 then
					local var_40_31 = manager.audio:GetVoiceLength("story_v_out_926031", "926031009", "story_v_out_926031.awb") / 1000

					if var_40_31 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_23
					end

					if var_40_26.prefab_name ~= "" and arg_37_1.actors_[var_40_26.prefab_name] ~= nil then
						local var_40_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_26.prefab_name].transform, "story_v_out_926031", "926031009", "story_v_out_926031.awb")

						arg_37_1:RecordAudio("926031009", var_40_32)
						arg_37_1:RecordAudio("926031009", var_40_32)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926031", "926031009", "story_v_out_926031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926031", "926031009", "story_v_out_926031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_33 = math.max(var_40_24, arg_37_1.talkMaxDuration)

			if var_40_23 <= arg_37_1.time_ and arg_37_1.time_ < var_40_23 + var_40_33 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_23) / var_40_33

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_23 + var_40_33 and arg_37_1.time_ < var_40_23 + var_40_33 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play926031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926031010
		arg_41_1.duration_ = 6.67

		local var_41_0 = {
			zh = 4.066,
			ja = 6.666
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
				arg_41_0:Play926031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["104701"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps104701 == nil then
				arg_41_1.var_.actorSpriteComps104701 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps104701 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps104701 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps104701 = nil
			end

			local var_44_8 = arg_41_1.actors_["106103"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps106103 == nil then
				arg_41_1.var_.actorSpriteComps106103 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps106103 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps106103 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps106103 = nil
			end

			local var_44_16 = 0
			local var_44_17 = 0.45

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_18 = arg_41_1:FormatText(StoryNameCfg[1296].name)

				arg_41_1.leftNameTxt_.text = var_44_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_19 = arg_41_1:GetWordFromCfg(926031010)
				local var_44_20 = arg_41_1:FormatText(var_44_19.content)

				arg_41_1.text_.text = var_44_20

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_21 = 18
				local var_44_22 = utf8.len(var_44_20)
				local var_44_23 = var_44_21 <= 0 and var_44_17 or var_44_17 * (var_44_22 / var_44_21)

				if var_44_23 > 0 and var_44_17 < var_44_23 then
					arg_41_1.talkMaxDuration = var_44_23

					if var_44_23 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_16
					end
				end

				arg_41_1.text_.text = var_44_20
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031010", "story_v_out_926031.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_926031", "926031010", "story_v_out_926031.awb") / 1000

					if var_44_24 + var_44_16 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_16
					end

					if var_44_19.prefab_name ~= "" and arg_41_1.actors_[var_44_19.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_19.prefab_name].transform, "story_v_out_926031", "926031010", "story_v_out_926031.awb")

						arg_41_1:RecordAudio("926031010", var_44_25)
						arg_41_1:RecordAudio("926031010", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926031", "926031010", "story_v_out_926031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926031", "926031010", "story_v_out_926031.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_26 = math.max(var_44_17, arg_41_1.talkMaxDuration)

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_26 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_16) / var_44_26

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_16 + var_44_26 and arg_41_1.time_ < var_44_16 + var_44_26 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play926031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926031011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play926031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["104701"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps104701 == nil then
				arg_45_1.var_.actorSpriteComps104701 = var_48_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.actorSpriteComps104701 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								local var_48_4 = Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, var_48_3)
								local var_48_5 = Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, var_48_3)
								local var_48_6 = Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, var_48_3)

								iter_48_1.color = Color.New(var_48_4, var_48_5, var_48_6)
							else
								local var_48_7 = Mathf.Lerp(iter_48_1.color.r, 0.5, var_48_3)

								iter_48_1.color = Color.New(var_48_7, var_48_7, var_48_7)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.actorSpriteComps104701 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_48_3 then
						if arg_45_1.isInRecall_ then
							iter_48_3.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps104701 = nil
			end

			local var_48_8 = arg_45_1.actors_["106103"].transform
			local var_48_9 = 0

			if var_48_9 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.var_.moveOldPos106103 = var_48_8.localPosition
				var_48_8.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("106103", 7)

				local var_48_10 = var_48_8.childCount

				for iter_48_4 = 0, var_48_10 - 1 do
					local var_48_11 = var_48_8:GetChild(iter_48_4)

					if var_48_11.name == "" or not string.find(var_48_11.name, "split") then
						var_48_11.gameObject:SetActive(true)
					else
						var_48_11.gameObject:SetActive(false)
					end
				end
			end

			local var_48_12 = 0.001

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_12 then
				local var_48_13 = (arg_45_1.time_ - var_48_9) / var_48_12
				local var_48_14 = Vector3.New(0, -2000, 0)

				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos106103, var_48_14, var_48_13)
			end

			if arg_45_1.time_ >= var_48_9 + var_48_12 and arg_45_1.time_ < var_48_9 + var_48_12 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_15 = 0
			local var_48_16 = 1.4

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_17 = arg_45_1:GetWordFromCfg(926031011)
				local var_48_18 = arg_45_1:FormatText(var_48_17.content)

				arg_45_1.text_.text = var_48_18

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_19 = 56
				local var_48_20 = utf8.len(var_48_18)
				local var_48_21 = var_48_19 <= 0 and var_48_16 or var_48_16 * (var_48_20 / var_48_19)

				if var_48_21 > 0 and var_48_16 < var_48_21 then
					arg_45_1.talkMaxDuration = var_48_21

					if var_48_21 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_21 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_18
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_22 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_22 and arg_45_1.time_ < var_48_15 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play926031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926031012
		arg_49_1.duration_ = 7.23

		local var_49_0 = {
			zh = 7.133,
			ja = 7.233
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
				arg_49_0:Play926031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["104701"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps104701 == nil then
				arg_49_1.var_.actorSpriteComps104701 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps104701 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps104701 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps104701 = nil
			end

			local var_52_8 = arg_49_1.actors_["104701"].transform
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.var_.moveOldPos104701 = var_52_8.localPosition
				var_52_8.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("104701", 3)

				local var_52_10 = var_52_8.childCount

				for iter_52_4 = 0, var_52_10 - 1 do
					local var_52_11 = var_52_8:GetChild(iter_52_4)

					if var_52_11.name == "split_1" or not string.find(var_52_11.name, "split") then
						var_52_11.gameObject:SetActive(true)
					else
						var_52_11.gameObject:SetActive(false)
					end
				end
			end

			local var_52_12 = 0.001

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_12 then
				local var_52_13 = (arg_49_1.time_ - var_52_9) / var_52_12
				local var_52_14 = Vector3.New(-67.4, -386.8, -295)

				var_52_8.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos104701, var_52_14, var_52_13)
			end

			if arg_49_1.time_ >= var_52_9 + var_52_12 and arg_49_1.time_ < var_52_9 + var_52_12 + arg_52_0 then
				var_52_8.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_52_15 = 0
			local var_52_16 = 0.875

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_17 = arg_49_1:FormatText(StoryNameCfg[1296].name)

				arg_49_1.leftNameTxt_.text = var_52_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:GetWordFromCfg(926031012)
				local var_52_19 = arg_49_1:FormatText(var_52_18.content)

				arg_49_1.text_.text = var_52_19

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 35
				local var_52_21 = utf8.len(var_52_19)
				local var_52_22 = var_52_20 <= 0 and var_52_16 or var_52_16 * (var_52_21 / var_52_20)

				if var_52_22 > 0 and var_52_16 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22

					if var_52_22 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_19
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031012", "story_v_out_926031.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031012", "story_v_out_926031.awb") / 1000

					if var_52_23 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_15
					end

					if var_52_18.prefab_name ~= "" and arg_49_1.actors_[var_52_18.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_18.prefab_name].transform, "story_v_out_926031", "926031012", "story_v_out_926031.awb")

						arg_49_1:RecordAudio("926031012", var_52_24)
						arg_49_1:RecordAudio("926031012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926031", "926031012", "story_v_out_926031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926031", "926031012", "story_v_out_926031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_25 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_15) / var_52_25

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_15 + var_52_25 and arg_49_1.time_ < var_52_15 + var_52_25 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play926031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926031013
		arg_53_1.duration_ = 8.8

		local var_53_0 = {
			zh = 7.533,
			ja = 8.8
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
				arg_53_0:Play926031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.725

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1296].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(926031013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031013", "story_v_out_926031.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031013", "story_v_out_926031.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_926031", "926031013", "story_v_out_926031.awb")

						arg_53_1:RecordAudio("926031013", var_56_9)
						arg_53_1:RecordAudio("926031013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_926031", "926031013", "story_v_out_926031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_926031", "926031013", "story_v_out_926031.awb")
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
	Play926031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926031014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["104701"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps104701 == nil then
				arg_57_1.var_.actorSpriteComps104701 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps104701 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps104701 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps104701 = nil
			end

			local var_60_8 = arg_57_1.actors_["104701"].transform
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.var_.moveOldPos104701 = var_60_8.localPosition
				var_60_8.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("104701", 7)

				local var_60_10 = var_60_8.childCount

				for iter_60_4 = 0, var_60_10 - 1 do
					local var_60_11 = var_60_8:GetChild(iter_60_4)

					if var_60_11.name == "" or not string.find(var_60_11.name, "split") then
						var_60_11.gameObject:SetActive(true)
					else
						var_60_11.gameObject:SetActive(false)
					end
				end
			end

			local var_60_12 = 0.001

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_12 then
				local var_60_13 = (arg_57_1.time_ - var_60_9) / var_60_12
				local var_60_14 = Vector3.New(0, -2000, 0)

				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos104701, var_60_14, var_60_13)
			end

			if arg_57_1.time_ >= var_60_9 + var_60_12 and arg_57_1.time_ < var_60_9 + var_60_12 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_15 = 0
			local var_60_16 = 1.3

			if var_60_15 < arg_57_1.time_ and arg_57_1.time_ <= var_60_15 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_17 = arg_57_1:GetWordFromCfg(926031014)
				local var_60_18 = arg_57_1:FormatText(var_60_17.content)

				arg_57_1.text_.text = var_60_18

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_19 = 52
				local var_60_20 = utf8.len(var_60_18)
				local var_60_21 = var_60_19 <= 0 and var_60_16 or var_60_16 * (var_60_20 / var_60_19)

				if var_60_21 > 0 and var_60_16 < var_60_21 then
					arg_57_1.talkMaxDuration = var_60_21

					if var_60_21 + var_60_15 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_21 + var_60_15
					end
				end

				arg_57_1.text_.text = var_60_18
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = math.max(var_60_16, arg_57_1.talkMaxDuration)

			if var_60_15 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_22 and arg_57_1.time_ < var_60_15 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play926031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926031015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play926031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.55

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

				local var_64_3 = arg_61_1:GetWordFromCfg(926031015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 22
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
	Play926031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926031016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play926031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.325

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[7].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(926031016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 13
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play926031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926031017
		arg_69_1.duration_ = 3.37

		local var_69_0 = {
			zh = 2.933,
			ja = 3.366
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
				arg_69_0:Play926031018(arg_69_1)
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

			local var_72_8 = arg_69_1.actors_["106103"].transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.moveOldPos106103 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("106103", 3)

				local var_72_10 = var_72_8.childCount

				for iter_72_4 = 0, var_72_10 - 1 do
					local var_72_11 = var_72_8:GetChild(iter_72_4)

					if var_72_11.name == "split_4" or not string.find(var_72_11.name, "split") then
						var_72_11.gameObject:SetActive(true)
					else
						var_72_11.gameObject:SetActive(false)
					end
				end
			end

			local var_72_12 = 0.001

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_9) / var_72_12
				local var_72_14 = Vector3.New(-36.6, -398.2, -333.7)

				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos106103, var_72_14, var_72_13)
			end

			if arg_69_1.time_ >= var_72_9 + var_72_12 and arg_69_1.time_ < var_72_9 + var_72_12 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_72_15 = 0
			local var_72_16 = 0.25

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_17 = arg_69_1:FormatText(StoryNameCfg[612].name)

				arg_69_1.leftNameTxt_.text = var_72_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_18 = arg_69_1:GetWordFromCfg(926031017)
				local var_72_19 = arg_69_1:FormatText(var_72_18.content)

				arg_69_1.text_.text = var_72_19

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_20 = 10
				local var_72_21 = utf8.len(var_72_19)
				local var_72_22 = var_72_20 <= 0 and var_72_16 or var_72_16 * (var_72_21 / var_72_20)

				if var_72_22 > 0 and var_72_16 < var_72_22 then
					arg_69_1.talkMaxDuration = var_72_22

					if var_72_22 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_22 + var_72_15
					end
				end

				arg_69_1.text_.text = var_72_19
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031017", "story_v_out_926031.awb") ~= 0 then
					local var_72_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031017", "story_v_out_926031.awb") / 1000

					if var_72_23 + var_72_15 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_15
					end

					if var_72_18.prefab_name ~= "" and arg_69_1.actors_[var_72_18.prefab_name] ~= nil then
						local var_72_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_18.prefab_name].transform, "story_v_out_926031", "926031017", "story_v_out_926031.awb")

						arg_69_1:RecordAudio("926031017", var_72_24)
						arg_69_1:RecordAudio("926031017", var_72_24)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_926031", "926031017", "story_v_out_926031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_926031", "926031017", "story_v_out_926031.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_25 = math.max(var_72_16, arg_69_1.talkMaxDuration)

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_15) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_15 + var_72_25 and arg_69_1.time_ < var_72_15 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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
	Play926031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926031018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play926031019(arg_73_1)
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

			local var_76_8 = arg_73_1.actors_["106103"].transform
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.var_.moveOldPos106103 = var_76_8.localPosition
				var_76_8.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("106103", 7)

				local var_76_10 = var_76_8.childCount

				for iter_76_4 = 0, var_76_10 - 1 do
					local var_76_11 = var_76_8:GetChild(iter_76_4)

					if var_76_11.name == "" or not string.find(var_76_11.name, "split") then
						var_76_11.gameObject:SetActive(true)
					else
						var_76_11.gameObject:SetActive(false)
					end
				end
			end

			local var_76_12 = 0.001

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_12 then
				local var_76_13 = (arg_73_1.time_ - var_76_9) / var_76_12
				local var_76_14 = Vector3.New(0, -2000, 0)

				var_76_8.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos106103, var_76_14, var_76_13)
			end

			if arg_73_1.time_ >= var_76_9 + var_76_12 and arg_73_1.time_ < var_76_9 + var_76_12 + arg_76_0 then
				var_76_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_76_15 = 0
			local var_76_16 = 1.175

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_17 = arg_73_1:GetWordFromCfg(926031018)
				local var_76_18 = arg_73_1:FormatText(var_76_17.content)

				arg_73_1.text_.text = var_76_18

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_19 = 47
				local var_76_20 = utf8.len(var_76_18)
				local var_76_21 = var_76_19 <= 0 and var_76_16 or var_76_16 * (var_76_20 / var_76_19)

				if var_76_21 > 0 and var_76_16 < var_76_21 then
					arg_73_1.talkMaxDuration = var_76_21

					if var_76_21 + var_76_15 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_15
					end
				end

				arg_73_1.text_.text = var_76_18
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_22 = math.max(var_76_16, arg_73_1.talkMaxDuration)

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_22 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_15) / var_76_22

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_15 + var_76_22 and arg_73_1.time_ < var_76_15 + var_76_22 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play926031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926031019
		arg_77_1.duration_ = 1.7

		local var_77_0 = {
			zh = 1.7,
			ja = 1.166
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
				arg_77_0:Play926031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["106103"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps106103 == nil then
				arg_77_1.var_.actorSpriteComps106103 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps106103 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps106103 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps106103 = nil
			end

			local var_80_8 = 0
			local var_80_9 = 0.1

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_10 = arg_77_1:FormatText(StoryNameCfg[612].name)

				arg_77_1.leftNameTxt_.text = var_80_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_11 = arg_77_1:GetWordFromCfg(926031019)
				local var_80_12 = arg_77_1:FormatText(var_80_11.content)

				arg_77_1.text_.text = var_80_12

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031019", "story_v_out_926031.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_926031", "926031019", "story_v_out_926031.awb") / 1000

					if var_80_16 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_8
					end

					if var_80_11.prefab_name ~= "" and arg_77_1.actors_[var_80_11.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_11.prefab_name].transform, "story_v_out_926031", "926031019", "story_v_out_926031.awb")

						arg_77_1:RecordAudio("926031019", var_80_17)
						arg_77_1:RecordAudio("926031019", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926031", "926031019", "story_v_out_926031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926031", "926031019", "story_v_out_926031.awb")
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
	Play926031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926031020
		arg_81_1.duration_ = 3.2

		local var_81_0 = {
			zh = 2.066,
			ja = 3.2
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
				arg_81_0:Play926031021(arg_81_1)
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
								local var_84_4 = Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, var_84_3)
								local var_84_5 = Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, var_84_3)
								local var_84_6 = Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, var_84_3)

								iter_84_1.color = Color.New(var_84_4, var_84_5, var_84_6)
							else
								local var_84_7 = Mathf.Lerp(iter_84_1.color.r, 1, var_84_3)

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
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps104701 = nil
			end

			local var_84_8 = arg_81_1.actors_["106103"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps106103 == nil then
				arg_81_1.var_.actorSpriteComps106103 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps106103 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								local var_84_12 = Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, var_84_11)
								local var_84_13 = Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, var_84_11)
								local var_84_14 = Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, var_84_11)

								iter_84_5.color = Color.New(var_84_12, var_84_13, var_84_14)
							else
								local var_84_15 = Mathf.Lerp(iter_84_5.color.r, 0.5, var_84_11)

								iter_84_5.color = Color.New(var_84_15, var_84_15, var_84_15)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps106103 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps106103 = nil
			end

			local var_84_16 = arg_81_1.actors_["104701"].transform
			local var_84_17 = 0

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.var_.moveOldPos104701 = var_84_16.localPosition
				var_84_16.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("104701", 3)

				local var_84_18 = var_84_16.childCount

				for iter_84_8 = 0, var_84_18 - 1 do
					local var_84_19 = var_84_16:GetChild(iter_84_8)

					if var_84_19.name == "split_1" or not string.find(var_84_19.name, "split") then
						var_84_19.gameObject:SetActive(true)
					else
						var_84_19.gameObject:SetActive(false)
					end
				end
			end

			local var_84_20 = 0.001

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_17) / var_84_20
				local var_84_22 = Vector3.New(-67.4, -386.8, -295)

				var_84_16.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos104701, var_84_22, var_84_21)
			end

			if arg_81_1.time_ >= var_84_17 + var_84_20 and arg_81_1.time_ < var_84_17 + var_84_20 + arg_84_0 then
				var_84_16.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_84_23 = 0
			local var_84_24 = 0.175

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[1296].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(926031020)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 7
				local var_84_29 = utf8.len(var_84_27)
				local var_84_30 = var_84_28 <= 0 and var_84_24 or var_84_24 * (var_84_29 / var_84_28)

				if var_84_30 > 0 and var_84_24 < var_84_30 then
					arg_81_1.talkMaxDuration = var_84_30

					if var_84_30 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_30 + var_84_23
					end
				end

				arg_81_1.text_.text = var_84_27
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031020", "story_v_out_926031.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_926031", "926031020", "story_v_out_926031.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_926031", "926031020", "story_v_out_926031.awb")

						arg_81_1:RecordAudio("926031020", var_84_32)
						arg_81_1:RecordAudio("926031020", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_926031", "926031020", "story_v_out_926031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_926031", "926031020", "story_v_out_926031.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_33 = math.max(var_84_24, arg_81_1.talkMaxDuration)

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_33 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_23) / var_84_33

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_23 + var_84_33 and arg_81_1.time_ < var_84_23 + var_84_33 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play926031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 926031021
		arg_85_1.duration_ = 2.03

		local var_85_0 = {
			zh = 1.5,
			ja = 2.033
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
				arg_85_0:Play926031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["106103"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps106103 == nil then
				arg_85_1.var_.actorSpriteComps106103 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps106103 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps106103 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps106103 = nil
			end

			local var_88_8 = arg_85_1.actors_["104701"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps104701 == nil then
				arg_85_1.var_.actorSpriteComps104701 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps104701 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 0.5, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps104701 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps104701 = nil
			end

			local var_88_16 = 0
			local var_88_17 = 0.125

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_18 = arg_85_1:FormatText(StoryNameCfg[612].name)

				arg_85_1.leftNameTxt_.text = var_88_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_19 = arg_85_1:GetWordFromCfg(926031021)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 5
				local var_88_22 = utf8.len(var_88_20)
				local var_88_23 = var_88_21 <= 0 and var_88_17 or var_88_17 * (var_88_22 / var_88_21)

				if var_88_23 > 0 and var_88_17 < var_88_23 then
					arg_85_1.talkMaxDuration = var_88_23

					if var_88_23 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_16
					end
				end

				arg_85_1.text_.text = var_88_20
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031021", "story_v_out_926031.awb") ~= 0 then
					local var_88_24 = manager.audio:GetVoiceLength("story_v_out_926031", "926031021", "story_v_out_926031.awb") / 1000

					if var_88_24 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_926031", "926031021", "story_v_out_926031.awb")

						arg_85_1:RecordAudio("926031021", var_88_25)
						arg_85_1:RecordAudio("926031021", var_88_25)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_926031", "926031021", "story_v_out_926031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_926031", "926031021", "story_v_out_926031.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_26 = math.max(var_88_17, arg_85_1.talkMaxDuration)

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_26 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_16) / var_88_26

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_16 + var_88_26 and arg_85_1.time_ < var_88_16 + var_88_26 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play926031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 926031022
		arg_89_1.duration_ = 7.17

		local var_89_0 = {
			zh = 4.933,
			ja = 7.166
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
				arg_89_0:Play926031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["104701"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps104701 == nil then
				arg_89_1.var_.actorSpriteComps104701 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps104701 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps104701 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps104701 = nil
			end

			local var_92_8 = arg_89_1.actors_["106103"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps106103 == nil then
				arg_89_1.var_.actorSpriteComps106103 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps106103 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps106103 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps106103 = nil
			end

			local var_92_16 = arg_89_1.actors_["104701"].transform
			local var_92_17 = 0

			if var_92_17 < arg_89_1.time_ and arg_89_1.time_ <= var_92_17 + arg_92_0 then
				arg_89_1.var_.moveOldPos104701 = var_92_16.localPosition
				var_92_16.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("104701", 3)

				local var_92_18 = var_92_16.childCount

				for iter_92_8 = 0, var_92_18 - 1 do
					local var_92_19 = var_92_16:GetChild(iter_92_8)

					if var_92_19.name == "split_2" or not string.find(var_92_19.name, "split") then
						var_92_19.gameObject:SetActive(true)
					else
						var_92_19.gameObject:SetActive(false)
					end
				end
			end

			local var_92_20 = 0.001

			if var_92_17 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_20 then
				local var_92_21 = (arg_89_1.time_ - var_92_17) / var_92_20
				local var_92_22 = Vector3.New(-67.4, -386.8, -295)

				var_92_16.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos104701, var_92_22, var_92_21)
			end

			if arg_89_1.time_ >= var_92_17 + var_92_20 and arg_89_1.time_ < var_92_17 + var_92_20 + arg_92_0 then
				var_92_16.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_92_23 = 0
			local var_92_24 = 0.425

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[1296].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(926031022)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 17
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031022", "story_v_out_926031.awb") ~= 0 then
					local var_92_31 = manager.audio:GetVoiceLength("story_v_out_926031", "926031022", "story_v_out_926031.awb") / 1000

					if var_92_31 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_23
					end

					if var_92_26.prefab_name ~= "" and arg_89_1.actors_[var_92_26.prefab_name] ~= nil then
						local var_92_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_26.prefab_name].transform, "story_v_out_926031", "926031022", "story_v_out_926031.awb")

						arg_89_1:RecordAudio("926031022", var_92_32)
						arg_89_1:RecordAudio("926031022", var_92_32)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_926031", "926031022", "story_v_out_926031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_926031", "926031022", "story_v_out_926031.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_33 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_33 and arg_89_1.time_ < var_92_23 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play926031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926031023
		arg_93_1.duration_ = 3.8

		local var_93_0 = {
			zh = 3.8,
			ja = 3.4
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
				arg_93_0:Play926031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["106103"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps106103 == nil then
				arg_93_1.var_.actorSpriteComps106103 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps106103 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 1, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps106103 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps106103 = nil
			end

			local var_96_8 = arg_93_1.actors_["104701"]
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps104701 == nil then
				arg_93_1.var_.actorSpriteComps104701 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_10 = 0.2

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 and not isNil(var_96_8) then
				local var_96_11 = (arg_93_1.time_ - var_96_9) / var_96_10

				if arg_93_1.var_.actorSpriteComps104701 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								local var_96_12 = Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor2.r, var_96_11)
								local var_96_13 = Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor2.g, var_96_11)
								local var_96_14 = Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor2.b, var_96_11)

								iter_96_5.color = Color.New(var_96_12, var_96_13, var_96_14)
							else
								local var_96_15 = Mathf.Lerp(iter_96_5.color.r, 0.5, var_96_11)

								iter_96_5.color = Color.New(var_96_15, var_96_15, var_96_15)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps104701 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_96_7 then
						if arg_93_1.isInRecall_ then
							iter_96_7.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps104701 = nil
			end

			local var_96_16 = arg_93_1.actors_["106103"].transform
			local var_96_17 = 0

			if var_96_17 < arg_93_1.time_ and arg_93_1.time_ <= var_96_17 + arg_96_0 then
				arg_93_1.var_.moveOldPos106103 = var_96_16.localPosition
				var_96_16.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("106103", 3)

				local var_96_18 = var_96_16.childCount

				for iter_96_8 = 0, var_96_18 - 1 do
					local var_96_19 = var_96_16:GetChild(iter_96_8)

					if var_96_19.name == "split_4" or not string.find(var_96_19.name, "split") then
						var_96_19.gameObject:SetActive(true)
					else
						var_96_19.gameObject:SetActive(false)
					end
				end
			end

			local var_96_20 = 0.001

			if var_96_17 <= arg_93_1.time_ and arg_93_1.time_ < var_96_17 + var_96_20 then
				local var_96_21 = (arg_93_1.time_ - var_96_17) / var_96_20
				local var_96_22 = Vector3.New(-36.6, -398.2, -333.7)

				var_96_16.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos106103, var_96_22, var_96_21)
			end

			if arg_93_1.time_ >= var_96_17 + var_96_20 and arg_93_1.time_ < var_96_17 + var_96_20 + arg_96_0 then
				var_96_16.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_96_23 = arg_93_1.actors_["104701"].transform
			local var_96_24 = 0

			if var_96_24 < arg_93_1.time_ and arg_93_1.time_ <= var_96_24 + arg_96_0 then
				arg_93_1.var_.moveOldPos104701 = var_96_23.localPosition
				var_96_23.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("104701", 7)

				local var_96_25 = var_96_23.childCount

				for iter_96_9 = 0, var_96_25 - 1 do
					local var_96_26 = var_96_23:GetChild(iter_96_9)

					if var_96_26.name == "" or not string.find(var_96_26.name, "split") then
						var_96_26.gameObject:SetActive(true)
					else
						var_96_26.gameObject:SetActive(false)
					end
				end
			end

			local var_96_27 = 0.001

			if var_96_24 <= arg_93_1.time_ and arg_93_1.time_ < var_96_24 + var_96_27 then
				local var_96_28 = (arg_93_1.time_ - var_96_24) / var_96_27
				local var_96_29 = Vector3.New(0, -2000, 0)

				var_96_23.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos104701, var_96_29, var_96_28)
			end

			if arg_93_1.time_ >= var_96_24 + var_96_27 and arg_93_1.time_ < var_96_24 + var_96_27 + arg_96_0 then
				var_96_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_96_30 = 0
			local var_96_31 = 0.225

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[612].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(926031023)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 9
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031023", "story_v_out_926031.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031023", "story_v_out_926031.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_926031", "926031023", "story_v_out_926031.awb")

						arg_93_1:RecordAudio("926031023", var_96_39)
						arg_93_1:RecordAudio("926031023", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_926031", "926031023", "story_v_out_926031.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_926031", "926031023", "story_v_out_926031.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play926031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926031024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play926031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["106103"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps106103 == nil then
				arg_97_1.var_.actorSpriteComps106103 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps106103 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 0.5, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps106103 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps106103 = nil
			end

			local var_100_8 = arg_97_1.actors_["104701"].transform
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.var_.moveOldPos104701 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("104701", 7)

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
				local var_100_14 = Vector3.New(0, -2000, 0)

				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos104701, var_100_14, var_100_13)
			end

			if arg_97_1.time_ >= var_100_9 + var_100_12 and arg_97_1.time_ < var_100_9 + var_100_12 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_15 = arg_97_1.actors_["106103"].transform
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.var_.moveOldPos106103 = var_100_15.localPosition
				var_100_15.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("106103", 7)

				local var_100_17 = var_100_15.childCount

				for iter_100_5 = 0, var_100_17 - 1 do
					local var_100_18 = var_100_15:GetChild(iter_100_5)

					if var_100_18.name == "split_4" or not string.find(var_100_18.name, "split") then
						var_100_18.gameObject:SetActive(true)
					else
						var_100_18.gameObject:SetActive(false)
					end
				end
			end

			local var_100_19 = 0.001

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_19 then
				local var_100_20 = (arg_97_1.time_ - var_100_16) / var_100_19
				local var_100_21 = Vector3.New(0, -2000, 0)

				var_100_15.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos106103, var_100_21, var_100_20)
			end

			if arg_97_1.time_ >= var_100_16 + var_100_19 and arg_97_1.time_ < var_100_16 + var_100_19 + arg_100_0 then
				var_100_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_22 = 0
			local var_100_23 = 0.925

			if var_100_22 < arg_97_1.time_ and arg_97_1.time_ <= var_100_22 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_24 = arg_97_1:GetWordFromCfg(926031024)
				local var_100_25 = arg_97_1:FormatText(var_100_24.content)

				arg_97_1.text_.text = var_100_25

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_26 = 37
				local var_100_27 = utf8.len(var_100_25)
				local var_100_28 = var_100_26 <= 0 and var_100_23 or var_100_23 * (var_100_27 / var_100_26)

				if var_100_28 > 0 and var_100_23 < var_100_28 then
					arg_97_1.talkMaxDuration = var_100_28

					if var_100_28 + var_100_22 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_28 + var_100_22
					end
				end

				arg_97_1.text_.text = var_100_25
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_29 = math.max(var_100_23, arg_97_1.talkMaxDuration)

			if var_100_22 <= arg_97_1.time_ and arg_97_1.time_ < var_100_22 + var_100_29 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_22) / var_100_29

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_22 + var_100_29 and arg_97_1.time_ < var_100_22 + var_100_29 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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
				actorName = "106103",
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
	Play926031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926031025
		arg_101_1.duration_ = 13.73

		local var_101_0 = {
			zh = 9.1,
			ja = 13.733
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
				arg_101_0:Play926031026(arg_101_1)
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

					if var_104_11.name == "split_2" or not string.find(var_104_11.name, "split") then
						var_104_11.gameObject:SetActive(true)
					else
						var_104_11.gameObject:SetActive(false)
					end
				end
			end

			local var_104_12 = 0.001

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_12 then
				local var_104_13 = (arg_101_1.time_ - var_104_9) / var_104_12
				local var_104_14 = Vector3.New(-16.1, -362, -375)

				var_104_8.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos128404, var_104_14, var_104_13)
			end

			if arg_101_1.time_ >= var_104_9 + var_104_12 and arg_101_1.time_ < var_104_9 + var_104_12 + arg_104_0 then
				var_104_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_104_15 = 0
			local var_104_16 = 1.225

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(926031025)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 49
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031025", "story_v_out_926031.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031025", "story_v_out_926031.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_926031", "926031025", "story_v_out_926031.awb")

						arg_101_1:RecordAudio("926031025", var_104_24)
						arg_101_1:RecordAudio("926031025", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_926031", "926031025", "story_v_out_926031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_926031", "926031025", "story_v_out_926031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play926031026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 926031026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play926031027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["128404"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps128404 == nil then
				arg_105_1.var_.actorSpriteComps128404 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps128404 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 0.5, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps128404 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps128404 = nil
			end

			local var_108_8 = 0
			local var_108_9 = 0.425

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_10 = arg_105_1:FormatText(StoryNameCfg[7].name)

				arg_105_1.leftNameTxt_.text = var_108_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_11 = arg_105_1:GetWordFromCfg(926031026)
				local var_108_12 = arg_105_1:FormatText(var_108_11.content)

				arg_105_1.text_.text = var_108_12

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 17
				local var_108_14 = utf8.len(var_108_12)
				local var_108_15 = var_108_13 <= 0 and var_108_9 or var_108_9 * (var_108_14 / var_108_13)

				if var_108_15 > 0 and var_108_9 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_12
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play926031027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 926031027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play926031028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 1.325

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(926031027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 53
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play926031028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 926031028
		arg_113_1.duration_ = 8.87

		local var_113_0 = {
			zh = 8.866,
			ja = 8.366
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play926031029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["106103"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps106103 == nil then
				arg_113_1.var_.actorSpriteComps106103 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps106103 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor1.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor1.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor1.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 1, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps106103 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps106103 = nil
			end

			local var_116_8 = arg_113_1.actors_["106103"].transform
			local var_116_9 = 0

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.var_.moveOldPos106103 = var_116_8.localPosition
				var_116_8.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("106103", 3)

				local var_116_10 = var_116_8.childCount

				for iter_116_4 = 0, var_116_10 - 1 do
					local var_116_11 = var_116_8:GetChild(iter_116_4)

					if var_116_11.name == "split_4" or not string.find(var_116_11.name, "split") then
						var_116_11.gameObject:SetActive(true)
					else
						var_116_11.gameObject:SetActive(false)
					end
				end
			end

			local var_116_12 = 0.001

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_12 then
				local var_116_13 = (arg_113_1.time_ - var_116_9) / var_116_12
				local var_116_14 = Vector3.New(-36.6, -398.2, -333.7)

				var_116_8.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos106103, var_116_14, var_116_13)
			end

			if arg_113_1.time_ >= var_116_9 + var_116_12 and arg_113_1.time_ < var_116_9 + var_116_12 + arg_116_0 then
				var_116_8.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_116_15 = arg_113_1.actors_["128404"].transform
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.var_.moveOldPos128404 = var_116_15.localPosition
				var_116_15.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("128404", 7)

				local var_116_17 = var_116_15.childCount

				for iter_116_5 = 0, var_116_17 - 1 do
					local var_116_18 = var_116_15:GetChild(iter_116_5)

					if var_116_18.name == "split_2" or not string.find(var_116_18.name, "split") then
						var_116_18.gameObject:SetActive(true)
					else
						var_116_18.gameObject:SetActive(false)
					end
				end
			end

			local var_116_19 = 0.001

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_19 then
				local var_116_20 = (arg_113_1.time_ - var_116_16) / var_116_19
				local var_116_21 = Vector3.New(0, -2000, 0)

				var_116_15.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos128404, var_116_21, var_116_20)
			end

			if arg_113_1.time_ >= var_116_16 + var_116_19 and arg_113_1.time_ < var_116_16 + var_116_19 + arg_116_0 then
				var_116_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_116_22 = 0
			local var_116_23 = 0.775

			if var_116_22 < arg_113_1.time_ and arg_113_1.time_ <= var_116_22 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_24 = arg_113_1:FormatText(StoryNameCfg[612].name)

				arg_113_1.leftNameTxt_.text = var_116_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_25 = arg_113_1:GetWordFromCfg(926031028)
				local var_116_26 = arg_113_1:FormatText(var_116_25.content)

				arg_113_1.text_.text = var_116_26

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_27 = 31
				local var_116_28 = utf8.len(var_116_26)
				local var_116_29 = var_116_27 <= 0 and var_116_23 or var_116_23 * (var_116_28 / var_116_27)

				if var_116_29 > 0 and var_116_23 < var_116_29 then
					arg_113_1.talkMaxDuration = var_116_29

					if var_116_29 + var_116_22 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_29 + var_116_22
					end
				end

				arg_113_1.text_.text = var_116_26
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031028", "story_v_out_926031.awb") ~= 0 then
					local var_116_30 = manager.audio:GetVoiceLength("story_v_out_926031", "926031028", "story_v_out_926031.awb") / 1000

					if var_116_30 + var_116_22 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_22
					end

					if var_116_25.prefab_name ~= "" and arg_113_1.actors_[var_116_25.prefab_name] ~= nil then
						local var_116_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_25.prefab_name].transform, "story_v_out_926031", "926031028", "story_v_out_926031.awb")

						arg_113_1:RecordAudio("926031028", var_116_31)
						arg_113_1:RecordAudio("926031028", var_116_31)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_926031", "926031028", "story_v_out_926031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_926031", "926031028", "story_v_out_926031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_32 = math.max(var_116_23, arg_113_1.talkMaxDuration)

			if var_116_22 <= arg_113_1.time_ and arg_113_1.time_ < var_116_22 + var_116_32 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_22) / var_116_32

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_22 + var_116_32 and arg_113_1.time_ < var_116_22 + var_116_32 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play926031029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 926031029
		arg_117_1.duration_ = 2.93

		local var_117_0 = {
			zh = 1.6,
			ja = 2.933
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
				arg_117_0:Play926031030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = "10144"

			if arg_117_1.actors_[var_120_0] == nil then
				local var_120_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_120_1) then
					local var_120_2 = Object.Instantiate(var_120_1, arg_117_1.canvasGo_.transform)

					var_120_2.transform:SetSiblingIndex(1)

					var_120_2.name = var_120_0
					var_120_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_117_1.actors_[var_120_0] = var_120_2

					local var_120_3 = var_120_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_117_1.isInRecall_ then
						for iter_120_0, iter_120_1 in ipairs(var_120_3) do
							iter_120_1.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_120_4 = arg_117_1.actors_["10144"]
			local var_120_5 = 0

			if var_120_5 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.actorSpriteComps10144 == nil then
				arg_117_1.var_.actorSpriteComps10144 = var_120_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_6 = 0.2

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_6 and not isNil(var_120_4) then
				local var_120_7 = (arg_117_1.time_ - var_120_5) / var_120_6

				if arg_117_1.var_.actorSpriteComps10144 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								local var_120_8 = Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor1.r, var_120_7)
								local var_120_9 = Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor1.g, var_120_7)
								local var_120_10 = Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor1.b, var_120_7)

								iter_120_3.color = Color.New(var_120_8, var_120_9, var_120_10)
							else
								local var_120_11 = Mathf.Lerp(iter_120_3.color.r, 1, var_120_7)

								iter_120_3.color = Color.New(var_120_11, var_120_11, var_120_11)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_5 + var_120_6 and arg_117_1.time_ < var_120_5 + var_120_6 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.actorSpriteComps10144 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_120_5 then
						if arg_117_1.isInRecall_ then
							iter_120_5.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10144 = nil
			end

			local var_120_12 = arg_117_1.actors_["106103"]
			local var_120_13 = 0

			if var_120_13 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 and not isNil(var_120_12) and arg_117_1.var_.actorSpriteComps106103 == nil then
				arg_117_1.var_.actorSpriteComps106103 = var_120_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_14 = 0.2

			if var_120_13 <= arg_117_1.time_ and arg_117_1.time_ < var_120_13 + var_120_14 and not isNil(var_120_12) then
				local var_120_15 = (arg_117_1.time_ - var_120_13) / var_120_14

				if arg_117_1.var_.actorSpriteComps106103 then
					for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_120_7 then
							if arg_117_1.isInRecall_ then
								local var_120_16 = Mathf.Lerp(iter_120_7.color.r, arg_117_1.hightColor2.r, var_120_15)
								local var_120_17 = Mathf.Lerp(iter_120_7.color.g, arg_117_1.hightColor2.g, var_120_15)
								local var_120_18 = Mathf.Lerp(iter_120_7.color.b, arg_117_1.hightColor2.b, var_120_15)

								iter_120_7.color = Color.New(var_120_16, var_120_17, var_120_18)
							else
								local var_120_19 = Mathf.Lerp(iter_120_7.color.r, 0.5, var_120_15)

								iter_120_7.color = Color.New(var_120_19, var_120_19, var_120_19)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_13 + var_120_14 and arg_117_1.time_ < var_120_13 + var_120_14 + arg_120_0 and not isNil(var_120_12) and arg_117_1.var_.actorSpriteComps106103 then
				for iter_120_8, iter_120_9 in pairs(arg_117_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_120_9 then
						if arg_117_1.isInRecall_ then
							iter_120_9.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps106103 = nil
			end

			local var_120_20 = arg_117_1.actors_["10144"].transform
			local var_120_21 = 0

			if var_120_21 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				arg_117_1.var_.moveOldPos10144 = var_120_20.localPosition
				var_120_20.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10144", 3)

				local var_120_22 = var_120_20.childCount

				for iter_120_10 = 0, var_120_22 - 1 do
					local var_120_23 = var_120_20:GetChild(iter_120_10)

					if var_120_23.name == "split_7" or not string.find(var_120_23.name, "split") then
						var_120_23.gameObject:SetActive(true)
					else
						var_120_23.gameObject:SetActive(false)
					end
				end
			end

			local var_120_24 = 0.001

			if var_120_21 <= arg_117_1.time_ and arg_117_1.time_ < var_120_21 + var_120_24 then
				local var_120_25 = (arg_117_1.time_ - var_120_21) / var_120_24
				local var_120_26 = Vector3.New(-31.5, -381.1, -285.9)

				var_120_20.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10144, var_120_26, var_120_25)
			end

			if arg_117_1.time_ >= var_120_21 + var_120_24 and arg_117_1.time_ < var_120_21 + var_120_24 + arg_120_0 then
				var_120_20.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_120_27 = arg_117_1.actors_["106103"].transform
			local var_120_28 = 0

			if var_120_28 < arg_117_1.time_ and arg_117_1.time_ <= var_120_28 + arg_120_0 then
				arg_117_1.var_.moveOldPos106103 = var_120_27.localPosition
				var_120_27.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("106103", 7)

				local var_120_29 = var_120_27.childCount

				for iter_120_11 = 0, var_120_29 - 1 do
					local var_120_30 = var_120_27:GetChild(iter_120_11)

					if var_120_30.name == "split_4" or not string.find(var_120_30.name, "split") then
						var_120_30.gameObject:SetActive(true)
					else
						var_120_30.gameObject:SetActive(false)
					end
				end
			end

			local var_120_31 = 0.001

			if var_120_28 <= arg_117_1.time_ and arg_117_1.time_ < var_120_28 + var_120_31 then
				local var_120_32 = (arg_117_1.time_ - var_120_28) / var_120_31
				local var_120_33 = Vector3.New(0, -2000, 0)

				var_120_27.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos106103, var_120_33, var_120_32)
			end

			if arg_117_1.time_ >= var_120_28 + var_120_31 and arg_117_1.time_ < var_120_28 + var_120_31 + arg_120_0 then
				var_120_27.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_34 = 0
			local var_120_35 = 0.225

			if var_120_34 < arg_117_1.time_ and arg_117_1.time_ <= var_120_34 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_36 = arg_117_1:FormatText(StoryNameCfg[1297].name)

				arg_117_1.leftNameTxt_.text = var_120_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_37 = arg_117_1:GetWordFromCfg(926031029)
				local var_120_38 = arg_117_1:FormatText(var_120_37.content)

				arg_117_1.text_.text = var_120_38

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_39 = 9
				local var_120_40 = utf8.len(var_120_38)
				local var_120_41 = var_120_39 <= 0 and var_120_35 or var_120_35 * (var_120_40 / var_120_39)

				if var_120_41 > 0 and var_120_35 < var_120_41 then
					arg_117_1.talkMaxDuration = var_120_41

					if var_120_41 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_41 + var_120_34
					end
				end

				arg_117_1.text_.text = var_120_38
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031029", "story_v_out_926031.awb") ~= 0 then
					local var_120_42 = manager.audio:GetVoiceLength("story_v_out_926031", "926031029", "story_v_out_926031.awb") / 1000

					if var_120_42 + var_120_34 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_42 + var_120_34
					end

					if var_120_37.prefab_name ~= "" and arg_117_1.actors_[var_120_37.prefab_name] ~= nil then
						local var_120_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_37.prefab_name].transform, "story_v_out_926031", "926031029", "story_v_out_926031.awb")

						arg_117_1:RecordAudio("926031029", var_120_43)
						arg_117_1:RecordAudio("926031029", var_120_43)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_926031", "926031029", "story_v_out_926031.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_926031", "926031029", "story_v_out_926031.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_44 = math.max(var_120_35, arg_117_1.talkMaxDuration)

			if var_120_34 <= arg_117_1.time_ and arg_117_1.time_ < var_120_34 + var_120_44 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_34) / var_120_44

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_34 + var_120_44 and arg_117_1.time_ < var_120_34 + var_120_44 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play926031030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 926031030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play926031031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10144"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10144 == nil then
				arg_121_1.var_.actorSpriteComps10144 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 0.2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10144 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 0.5, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10144 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10144 = nil
			end

			local var_124_8 = arg_121_1.actors_["10144"].transform
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.var_.moveOldPos10144 = var_124_8.localPosition
				var_124_8.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10144", 7)

				local var_124_10 = var_124_8.childCount

				for iter_124_4 = 0, var_124_10 - 1 do
					local var_124_11 = var_124_8:GetChild(iter_124_4)

					if var_124_11.name == "" or not string.find(var_124_11.name, "split") then
						var_124_11.gameObject:SetActive(true)
					else
						var_124_11.gameObject:SetActive(false)
					end
				end
			end

			local var_124_12 = 0.001

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_12 then
				local var_124_13 = (arg_121_1.time_ - var_124_9) / var_124_12
				local var_124_14 = Vector3.New(0, -2000, 0)

				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10144, var_124_14, var_124_13)
			end

			if arg_121_1.time_ >= var_124_9 + var_124_12 and arg_121_1.time_ < var_124_9 + var_124_12 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_15 = arg_121_1.actors_["106103"].transform
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.var_.moveOldPos106103 = var_124_15.localPosition
				var_124_15.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("106103", 7)

				local var_124_17 = var_124_15.childCount

				for iter_124_5 = 0, var_124_17 - 1 do
					local var_124_18 = var_124_15:GetChild(iter_124_5)

					if var_124_18.name == "" or not string.find(var_124_18.name, "split") then
						var_124_18.gameObject:SetActive(true)
					else
						var_124_18.gameObject:SetActive(false)
					end
				end
			end

			local var_124_19 = 0.001

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_19 then
				local var_124_20 = (arg_121_1.time_ - var_124_16) / var_124_19
				local var_124_21 = Vector3.New(0, -2000, 0)

				var_124_15.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos106103, var_124_21, var_124_20)
			end

			if arg_121_1.time_ >= var_124_16 + var_124_19 and arg_121_1.time_ < var_124_16 + var_124_19 + arg_124_0 then
				var_124_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_124_22 = 0.034
			local var_124_23 = 1

			if var_124_22 < arg_121_1.time_ and arg_121_1.time_ <= var_124_22 + arg_124_0 then
				local var_124_24 = "play"
				local var_124_25 = "effect"

				arg_121_1:AudioAction(var_124_24, var_124_25, "se_story_1310", "se_story_1310_plate", "")
			end

			local var_124_26 = 0
			local var_124_27 = 0.7

			if var_124_26 < arg_121_1.time_ and arg_121_1.time_ <= var_124_26 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_28 = arg_121_1:GetWordFromCfg(926031030)
				local var_124_29 = arg_121_1:FormatText(var_124_28.content)

				arg_121_1.text_.text = var_124_29

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_30 = 28
				local var_124_31 = utf8.len(var_124_29)
				local var_124_32 = var_124_30 <= 0 and var_124_27 or var_124_27 * (var_124_31 / var_124_30)

				if var_124_32 > 0 and var_124_27 < var_124_32 then
					arg_121_1.talkMaxDuration = var_124_32

					if var_124_32 + var_124_26 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_32 + var_124_26
					end
				end

				arg_121_1.text_.text = var_124_29
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_33 = math.max(var_124_27, arg_121_1.talkMaxDuration)

			if var_124_26 <= arg_121_1.time_ and arg_121_1.time_ < var_124_26 + var_124_33 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_26) / var_124_33

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_26 + var_124_33 and arg_121_1.time_ < var_124_26 + var_124_33 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play926031031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 926031031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play926031032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.3

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:GetWordFromCfg(926031031)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 12
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play926031032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 926031032
		arg_129_1.duration_ = 2.9

		local var_129_0 = {
			zh = 2.233,
			ja = 2.9
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play926031033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10144"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10144 == nil then
				arg_129_1.var_.actorSpriteComps10144 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps10144 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 1, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps10144 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10144 = nil
			end

			local var_132_8 = arg_129_1.actors_["10144"].transform
			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1.var_.moveOldPos10144 = var_132_8.localPosition
				var_132_8.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10144", 3)

				local var_132_10 = var_132_8.childCount

				for iter_132_4 = 0, var_132_10 - 1 do
					local var_132_11 = var_132_8:GetChild(iter_132_4)

					if var_132_11.name == "" or not string.find(var_132_11.name, "split") then
						var_132_11.gameObject:SetActive(true)
					else
						var_132_11.gameObject:SetActive(false)
					end
				end
			end

			local var_132_12 = 0.001

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_12 then
				local var_132_13 = (arg_129_1.time_ - var_132_9) / var_132_12
				local var_132_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_132_8.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10144, var_132_14, var_132_13)
			end

			if arg_129_1.time_ >= var_132_9 + var_132_12 and arg_129_1.time_ < var_132_9 + var_132_12 + arg_132_0 then
				var_132_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_132_15 = 0
			local var_132_16 = 0.25

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[1297].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(926031032)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 10
				local var_132_21 = utf8.len(var_132_19)
				local var_132_22 = var_132_20 <= 0 and var_132_16 or var_132_16 * (var_132_21 / var_132_20)

				if var_132_22 > 0 and var_132_16 < var_132_22 then
					arg_129_1.talkMaxDuration = var_132_22

					if var_132_22 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_19
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031032", "story_v_out_926031.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031032", "story_v_out_926031.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_926031", "926031032", "story_v_out_926031.awb")

						arg_129_1:RecordAudio("926031032", var_132_24)
						arg_129_1:RecordAudio("926031032", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_926031", "926031032", "story_v_out_926031.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_926031", "926031032", "story_v_out_926031.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_25 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_25 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_25

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_25 and arg_129_1.time_ < var_132_15 + var_132_25 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play926031033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 926031033
		arg_133_1.duration_ = 6.63

		local var_133_0 = {
			zh = 4,
			ja = 6.633
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play926031034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10144"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos10144 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10144", 3)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "split_2" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10144, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_136_7 = 0
			local var_136_8 = 0.475

			if var_136_7 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_9 = arg_133_1:FormatText(StoryNameCfg[1297].name)

				arg_133_1.leftNameTxt_.text = var_136_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(926031033)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_12 = 19
				local var_136_13 = utf8.len(var_136_11)
				local var_136_14 = var_136_12 <= 0 and var_136_8 or var_136_8 * (var_136_13 / var_136_12)

				if var_136_14 > 0 and var_136_8 < var_136_14 then
					arg_133_1.talkMaxDuration = var_136_14

					if var_136_14 + var_136_7 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_7
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031033", "story_v_out_926031.awb") ~= 0 then
					local var_136_15 = manager.audio:GetVoiceLength("story_v_out_926031", "926031033", "story_v_out_926031.awb") / 1000

					if var_136_15 + var_136_7 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_15 + var_136_7
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_926031", "926031033", "story_v_out_926031.awb")

						arg_133_1:RecordAudio("926031033", var_136_16)
						arg_133_1:RecordAudio("926031033", var_136_16)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_926031", "926031033", "story_v_out_926031.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_926031", "926031033", "story_v_out_926031.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_17 = math.max(var_136_8, arg_133_1.talkMaxDuration)

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_17 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_7) / var_136_17

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_7 + var_136_17 and arg_133_1.time_ < var_136_7 + var_136_17 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play926031034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 926031034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play926031035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10144"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10144 == nil then
				arg_137_1.var_.actorSpriteComps10144 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps10144 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 0.5, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps10144 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10144 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.175

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_10 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_11 = arg_137_1:GetWordFromCfg(926031034)
				local var_140_12 = arg_137_1:FormatText(var_140_11.content)

				arg_137_1.text_.text = var_140_12

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 7
				local var_140_14 = utf8.len(var_140_12)
				local var_140_15 = var_140_13 <= 0 and var_140_9 or var_140_9 * (var_140_14 / var_140_13)

				if var_140_15 > 0 and var_140_9 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_12
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play926031035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926031035
		arg_141_1.duration_ = 8

		local var_141_0 = {
			zh = 6.4,
			ja = 8
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play926031036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10144"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10144 == nil then
				arg_141_1.var_.actorSpriteComps10144 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10144 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 1, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10144 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10144 = nil
			end

			local var_144_8 = arg_141_1.actors_["10144"].transform
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.var_.moveOldPos10144 = var_144_8.localPosition
				var_144_8.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10144", 3)

				local var_144_10 = var_144_8.childCount

				for iter_144_4 = 0, var_144_10 - 1 do
					local var_144_11 = var_144_8:GetChild(iter_144_4)

					if var_144_11.name == "split_1" or not string.find(var_144_11.name, "split") then
						var_144_11.gameObject:SetActive(true)
					else
						var_144_11.gameObject:SetActive(false)
					end
				end
			end

			local var_144_12 = 0.001

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_12 then
				local var_144_13 = (arg_141_1.time_ - var_144_9) / var_144_12
				local var_144_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10144, var_144_14, var_144_13)
			end

			if arg_141_1.time_ >= var_144_9 + var_144_12 and arg_141_1.time_ < var_144_9 + var_144_12 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_144_15 = 0
			local var_144_16 = 0.775

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[1297].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(926031035)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 31
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031035", "story_v_out_926031.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031035", "story_v_out_926031.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_926031", "926031035", "story_v_out_926031.awb")

						arg_141_1:RecordAudio("926031035", var_144_24)
						arg_141_1:RecordAudio("926031035", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_926031", "926031035", "story_v_out_926031.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_926031", "926031035", "story_v_out_926031.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play926031036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926031036
		arg_145_1.duration_ = 5.37

		local var_145_0 = {
			zh = 4.1,
			ja = 5.366
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
				arg_145_0:Play926031037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.575

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[1297].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(926031036)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 23
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031036", "story_v_out_926031.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031036", "story_v_out_926031.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_926031", "926031036", "story_v_out_926031.awb")

						arg_145_1:RecordAudio("926031036", var_148_9)
						arg_145_1:RecordAudio("926031036", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_926031", "926031036", "story_v_out_926031.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_926031", "926031036", "story_v_out_926031.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play926031037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926031037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play926031038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10144"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10144 == nil then
				arg_149_1.var_.actorSpriteComps10144 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10144 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10144 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10144 = nil
			end

			local var_152_8 = 0
			local var_152_9 = 0.45

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

				local var_152_11 = arg_149_1:GetWordFromCfg(926031037)
				local var_152_12 = arg_149_1:FormatText(var_152_11.content)

				arg_149_1.text_.text = var_152_12

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 18
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
	Play926031038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926031038
		arg_153_1.duration_ = 5.57

		local var_153_0 = {
			zh = 5.566,
			ja = 4.766
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
				arg_153_0:Play926031039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10144"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10144 == nil then
				arg_153_1.var_.actorSpriteComps10144 = var_156_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_2 = 0.2

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.actorSpriteComps10144 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.actorSpriteComps10144 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_156_3 then
						if arg_153_1.isInRecall_ then
							iter_156_3.color = arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_156_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_153_1.var_.actorSpriteComps10144 = nil
			end

			local var_156_8 = arg_153_1.actors_["10144"].transform
			local var_156_9 = 0

			if var_156_9 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.var_.moveOldPos10144 = var_156_8.localPosition
				var_156_8.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10144", 3)

				local var_156_10 = var_156_8.childCount

				for iter_156_4 = 0, var_156_10 - 1 do
					local var_156_11 = var_156_8:GetChild(iter_156_4)

					if var_156_11.name == "split_5" or not string.find(var_156_11.name, "split") then
						var_156_11.gameObject:SetActive(true)
					else
						var_156_11.gameObject:SetActive(false)
					end
				end
			end

			local var_156_12 = 0.001

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_12 then
				local var_156_13 = (arg_153_1.time_ - var_156_9) / var_156_12
				local var_156_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_156_8.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10144, var_156_14, var_156_13)
			end

			if arg_153_1.time_ >= var_156_9 + var_156_12 and arg_153_1.time_ < var_156_9 + var_156_12 + arg_156_0 then
				var_156_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_156_15 = 0
			local var_156_16 = 0.65

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_17 = arg_153_1:FormatText(StoryNameCfg[1297].name)

				arg_153_1.leftNameTxt_.text = var_156_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_18 = arg_153_1:GetWordFromCfg(926031038)
				local var_156_19 = arg_153_1:FormatText(var_156_18.content)

				arg_153_1.text_.text = var_156_19

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_20 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031038", "story_v_out_926031.awb") ~= 0 then
					local var_156_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031038", "story_v_out_926031.awb") / 1000

					if var_156_23 + var_156_15 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_23 + var_156_15
					end

					if var_156_18.prefab_name ~= "" and arg_153_1.actors_[var_156_18.prefab_name] ~= nil then
						local var_156_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_18.prefab_name].transform, "story_v_out_926031", "926031038", "story_v_out_926031.awb")

						arg_153_1:RecordAudio("926031038", var_156_24)
						arg_153_1:RecordAudio("926031038", var_156_24)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926031", "926031038", "story_v_out_926031.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926031", "926031038", "story_v_out_926031.awb")
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
				actorName = "10144",
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
	Play926031039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926031039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play926031040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10144"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10144 == nil then
				arg_157_1.var_.actorSpriteComps10144 = var_160_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_2 = 0.2

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.actorSpriteComps10144 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.actorSpriteComps10144 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_160_3 then
						if arg_157_1.isInRecall_ then
							iter_160_3.color = arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_160_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10144 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.925

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

				local var_160_11 = arg_157_1:GetWordFromCfg(926031039)
				local var_160_12 = arg_157_1:FormatText(var_160_11.content)

				arg_157_1.text_.text = var_160_12

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 37
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
	Play926031040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 926031040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play926031041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.75

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[7].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_3 = arg_161_1:GetWordFromCfg(926031040)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 30
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play926031041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 926031041
		arg_165_1.duration_ = 2.03

		local var_165_0 = {
			zh = 1.333,
			ja = 2.033
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
				arg_165_0:Play926031042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10144"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10144 == nil then
				arg_165_1.var_.actorSpriteComps10144 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 0.2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps10144 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								local var_168_4 = Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, var_168_3)
								local var_168_5 = Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, var_168_3)
								local var_168_6 = Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, var_168_3)

								iter_168_1.color = Color.New(var_168_4, var_168_5, var_168_6)
							else
								local var_168_7 = Mathf.Lerp(iter_168_1.color.r, 1, var_168_3)

								iter_168_1.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10144 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10144 = nil
			end

			local var_168_8 = arg_165_1.actors_["10144"].transform
			local var_168_9 = 0

			if var_168_9 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 then
				arg_165_1.var_.moveOldPos10144 = var_168_8.localPosition
				var_168_8.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10144", 3)

				local var_168_10 = var_168_8.childCount

				for iter_168_4 = 0, var_168_10 - 1 do
					local var_168_11 = var_168_8:GetChild(iter_168_4)

					if var_168_11.name == "split_2" or not string.find(var_168_11.name, "split") then
						var_168_11.gameObject:SetActive(true)
					else
						var_168_11.gameObject:SetActive(false)
					end
				end
			end

			local var_168_12 = 0.001

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_12 then
				local var_168_13 = (arg_165_1.time_ - var_168_9) / var_168_12
				local var_168_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_168_8.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10144, var_168_14, var_168_13)
			end

			if arg_165_1.time_ >= var_168_9 + var_168_12 and arg_165_1.time_ < var_168_9 + var_168_12 + arg_168_0 then
				var_168_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_168_15 = 0
			local var_168_16 = 0.075

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_17 = arg_165_1:FormatText(StoryNameCfg[1297].name)

				arg_165_1.leftNameTxt_.text = var_168_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_18 = arg_165_1:GetWordFromCfg(926031041)
				local var_168_19 = arg_165_1:FormatText(var_168_18.content)

				arg_165_1.text_.text = var_168_19

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_20 = 3
				local var_168_21 = utf8.len(var_168_19)
				local var_168_22 = var_168_20 <= 0 and var_168_16 or var_168_16 * (var_168_21 / var_168_20)

				if var_168_22 > 0 and var_168_16 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22

					if var_168_22 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_15
					end
				end

				arg_165_1.text_.text = var_168_19
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031041", "story_v_out_926031.awb") ~= 0 then
					local var_168_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031041", "story_v_out_926031.awb") / 1000

					if var_168_23 + var_168_15 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_15
					end

					if var_168_18.prefab_name ~= "" and arg_165_1.actors_[var_168_18.prefab_name] ~= nil then
						local var_168_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_18.prefab_name].transform, "story_v_out_926031", "926031041", "story_v_out_926031.awb")

						arg_165_1:RecordAudio("926031041", var_168_24)
						arg_165_1:RecordAudio("926031041", var_168_24)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_926031", "926031041", "story_v_out_926031.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_926031", "926031041", "story_v_out_926031.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_25 = math.max(var_168_16, arg_165_1.talkMaxDuration)

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_25 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_15) / var_168_25

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_15 + var_168_25 and arg_165_1.time_ < var_168_15 + var_168_25 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play926031042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 926031042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play926031043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10144"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps10144 == nil then
				arg_169_1.var_.actorSpriteComps10144 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps10144 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								local var_172_4 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, var_172_3)
								local var_172_5 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, var_172_3)
								local var_172_6 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, var_172_3)

								iter_172_1.color = Color.New(var_172_4, var_172_5, var_172_6)
							else
								local var_172_7 = Mathf.Lerp(iter_172_1.color.r, 0.5, var_172_3)

								iter_172_1.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps10144 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10144 = nil
			end

			local var_172_8 = 0
			local var_172_9 = 0.425

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_10 = arg_169_1:FormatText(StoryNameCfg[7].name)

				arg_169_1.leftNameTxt_.text = var_172_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_11 = arg_169_1:GetWordFromCfg(926031042)
				local var_172_12 = arg_169_1:FormatText(var_172_11.content)

				arg_169_1.text_.text = var_172_12

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_13 = 17
				local var_172_14 = utf8.len(var_172_12)
				local var_172_15 = var_172_13 <= 0 and var_172_9 or var_172_9 * (var_172_14 / var_172_13)

				if var_172_15 > 0 and var_172_9 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15

					if var_172_15 + var_172_8 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_8
					end
				end

				arg_169_1.text_.text = var_172_12
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_16 = math.max(var_172_9, arg_169_1.talkMaxDuration)

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_16 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_8) / var_172_16

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_8 + var_172_16 and arg_169_1.time_ < var_172_8 + var_172_16 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play926031043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 926031043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play926031044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0
			local var_176_1 = 0.7

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_2 = arg_173_1:FormatText(StoryNameCfg[7].name)

				arg_173_1.leftNameTxt_.text = var_176_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_3 = arg_173_1:GetWordFromCfg(926031043)
				local var_176_4 = arg_173_1:FormatText(var_176_3.content)

				arg_173_1.text_.text = var_176_4

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 28
				local var_176_6 = utf8.len(var_176_4)
				local var_176_7 = var_176_5 <= 0 and var_176_1 or var_176_1 * (var_176_6 / var_176_5)

				if var_176_7 > 0 and var_176_1 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_4
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play926031044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 926031044
		arg_177_1.duration_ = 11.9

		local var_177_0 = {
			zh = 8.066,
			ja = 11.9
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
				arg_177_0:Play926031045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10144"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10144 == nil then
				arg_177_1.var_.actorSpriteComps10144 = var_180_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.actorSpriteComps10144 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.actorSpriteComps10144 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_180_3 then
						if arg_177_1.isInRecall_ then
							iter_180_3.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10144 = nil
			end

			local var_180_8 = arg_177_1.actors_["10144"].transform
			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.var_.moveOldPos10144 = var_180_8.localPosition
				var_180_8.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10144", 3)

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
				local var_180_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_180_8.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10144, var_180_14, var_180_13)
			end

			if arg_177_1.time_ >= var_180_9 + var_180_12 and arg_177_1.time_ < var_180_9 + var_180_12 + arg_180_0 then
				var_180_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_180_15 = 0
			local var_180_16 = 0.95

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[1297].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(926031044)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031044", "story_v_out_926031.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031044", "story_v_out_926031.awb") / 1000

					if var_180_23 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_15
					end

					if var_180_18.prefab_name ~= "" and arg_177_1.actors_[var_180_18.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_18.prefab_name].transform, "story_v_out_926031", "926031044", "story_v_out_926031.awb")

						arg_177_1:RecordAudio("926031044", var_180_24)
						arg_177_1:RecordAudio("926031044", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_926031", "926031044", "story_v_out_926031.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_926031", "926031044", "story_v_out_926031.awb")
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
				actorName = "10144",
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
	Play926031045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 926031045
		arg_181_1.duration_ = 13.57

		local var_181_0 = {
			zh = 10.3,
			ja = 13.566
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play926031046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.1

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[1297].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:GetWordFromCfg(926031045)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 44
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031045", "story_v_out_926031.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031045", "story_v_out_926031.awb") / 1000

					if var_184_8 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_0
					end

					if var_184_3.prefab_name ~= "" and arg_181_1.actors_[var_184_3.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_3.prefab_name].transform, "story_v_out_926031", "926031045", "story_v_out_926031.awb")

						arg_181_1:RecordAudio("926031045", var_184_9)
						arg_181_1:RecordAudio("926031045", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_926031", "926031045", "story_v_out_926031.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_926031", "926031045", "story_v_out_926031.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_10 and arg_181_1.time_ < var_184_0 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play926031046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 926031046
		arg_185_1.duration_ = 6

		local var_185_0 = {
			zh = 5.533,
			ja = 6
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play926031047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.7

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[1297].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(926031046)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031046", "story_v_out_926031.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031046", "story_v_out_926031.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_926031", "926031046", "story_v_out_926031.awb")

						arg_185_1:RecordAudio("926031046", var_188_9)
						arg_185_1:RecordAudio("926031046", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_926031", "926031046", "story_v_out_926031.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_926031", "926031046", "story_v_out_926031.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play926031047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 926031047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play926031048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10144"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10144 == nil then
				arg_189_1.var_.actorSpriteComps10144 = var_192_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.actorSpriteComps10144 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								local var_192_4 = Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor2.r, var_192_3)
								local var_192_5 = Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor2.g, var_192_3)
								local var_192_6 = Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor2.b, var_192_3)

								iter_192_1.color = Color.New(var_192_4, var_192_5, var_192_6)
							else
								local var_192_7 = Mathf.Lerp(iter_192_1.color.r, 0.5, var_192_3)

								iter_192_1.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.actorSpriteComps10144 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_192_3 then
						if arg_189_1.isInRecall_ then
							iter_192_3.color = arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_192_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_189_1.var_.actorSpriteComps10144 = nil
			end

			local var_192_8 = 0
			local var_192_9 = 0.5

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_10 = arg_189_1:FormatText(StoryNameCfg[7].name)

				arg_189_1.leftNameTxt_.text = var_192_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_11 = arg_189_1:GetWordFromCfg(926031047)
				local var_192_12 = arg_189_1:FormatText(var_192_11.content)

				arg_189_1.text_.text = var_192_12

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 20
				local var_192_14 = utf8.len(var_192_12)
				local var_192_15 = var_192_13 <= 0 and var_192_9 or var_192_9 * (var_192_14 / var_192_13)

				if var_192_15 > 0 and var_192_9 < var_192_15 then
					arg_189_1.talkMaxDuration = var_192_15

					if var_192_15 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_12
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_16 and arg_189_1.time_ < var_192_8 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play926031048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 926031048
		arg_193_1.duration_ = 12.53

		local var_193_0 = {
			zh = 6.7,
			ja = 12.533
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play926031049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10144"]
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10144 == nil then
				arg_193_1.var_.actorSpriteComps10144 = var_196_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_2 = 0.2

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 and not isNil(var_196_0) then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2

				if arg_193_1.var_.actorSpriteComps10144 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								local var_196_4 = Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, var_196_3)
								local var_196_5 = Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, var_196_3)
								local var_196_6 = Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, var_196_3)

								iter_196_1.color = Color.New(var_196_4, var_196_5, var_196_6)
							else
								local var_196_7 = Mathf.Lerp(iter_196_1.color.r, 1, var_196_3)

								iter_196_1.color = Color.New(var_196_7, var_196_7, var_196_7)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 and not isNil(var_196_0) and arg_193_1.var_.actorSpriteComps10144 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_196_3 then
						if arg_193_1.isInRecall_ then
							iter_196_3.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10144 = nil
			end

			local var_196_8 = arg_193_1.actors_["10144"].transform
			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1.var_.moveOldPos10144 = var_196_8.localPosition
				var_196_8.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10144", 3)

				local var_196_10 = var_196_8.childCount

				for iter_196_4 = 0, var_196_10 - 1 do
					local var_196_11 = var_196_8:GetChild(iter_196_4)

					if var_196_11.name == "" or not string.find(var_196_11.name, "split") then
						var_196_11.gameObject:SetActive(true)
					else
						var_196_11.gameObject:SetActive(false)
					end
				end
			end

			local var_196_12 = 0.001

			if var_196_9 <= arg_193_1.time_ and arg_193_1.time_ < var_196_9 + var_196_12 then
				local var_196_13 = (arg_193_1.time_ - var_196_9) / var_196_12
				local var_196_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_196_8.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10144, var_196_14, var_196_13)
			end

			if arg_193_1.time_ >= var_196_9 + var_196_12 and arg_193_1.time_ < var_196_9 + var_196_12 + arg_196_0 then
				var_196_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_196_15 = 0
			local var_196_16 = 0.75

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_17 = arg_193_1:FormatText(StoryNameCfg[1297].name)

				arg_193_1.leftNameTxt_.text = var_196_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_18 = arg_193_1:GetWordFromCfg(926031048)
				local var_196_19 = arg_193_1:FormatText(var_196_18.content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_20 = 30
				local var_196_21 = utf8.len(var_196_19)
				local var_196_22 = var_196_20 <= 0 and var_196_16 or var_196_16 * (var_196_21 / var_196_20)

				if var_196_22 > 0 and var_196_16 < var_196_22 then
					arg_193_1.talkMaxDuration = var_196_22

					if var_196_22 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_22 + var_196_15
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031048", "story_v_out_926031.awb") ~= 0 then
					local var_196_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031048", "story_v_out_926031.awb") / 1000

					if var_196_23 + var_196_15 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_23 + var_196_15
					end

					if var_196_18.prefab_name ~= "" and arg_193_1.actors_[var_196_18.prefab_name] ~= nil then
						local var_196_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_18.prefab_name].transform, "story_v_out_926031", "926031048", "story_v_out_926031.awb")

						arg_193_1:RecordAudio("926031048", var_196_24)
						arg_193_1:RecordAudio("926031048", var_196_24)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_926031", "926031048", "story_v_out_926031.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_926031", "926031048", "story_v_out_926031.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_25 = math.max(var_196_16, arg_193_1.talkMaxDuration)

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_25 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_15) / var_196_25

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_15 + var_196_25 and arg_193_1.time_ < var_196_15 + var_196_25 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play926031049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 926031049
		arg_197_1.duration_ = 5.07

		local var_197_0 = {
			zh = 4.366,
			ja = 5.066
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play926031050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.625

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[1297].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(926031049)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031049", "story_v_out_926031.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031049", "story_v_out_926031.awb") / 1000

					if var_200_8 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_0
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_926031", "926031049", "story_v_out_926031.awb")

						arg_197_1:RecordAudio("926031049", var_200_9)
						arg_197_1:RecordAudio("926031049", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_926031", "926031049", "story_v_out_926031.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_926031", "926031049", "story_v_out_926031.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_10 and arg_197_1.time_ < var_200_0 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play926031050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 926031050
		arg_201_1.duration_ = 8.53

		local var_201_0 = {
			zh = 5.8,
			ja = 8.533
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
				arg_201_0:Play926031051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["128404"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps128404 == nil then
				arg_201_1.var_.actorSpriteComps128404 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps128404 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps128404 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps128404 = nil
			end

			local var_204_8 = arg_201_1.actors_["10144"]
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10144 == nil then
				arg_201_1.var_.actorSpriteComps10144 = var_204_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_10 = 0.2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 and not isNil(var_204_8) then
				local var_204_11 = (arg_201_1.time_ - var_204_9) / var_204_10

				if arg_201_1.var_.actorSpriteComps10144 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								local var_204_12 = Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor2.r, var_204_11)
								local var_204_13 = Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor2.g, var_204_11)
								local var_204_14 = Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor2.b, var_204_11)

								iter_204_5.color = Color.New(var_204_12, var_204_13, var_204_14)
							else
								local var_204_15 = Mathf.Lerp(iter_204_5.color.r, 0.5, var_204_11)

								iter_204_5.color = Color.New(var_204_15, var_204_15, var_204_15)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10144 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_204_7 then
						if arg_201_1.isInRecall_ then
							iter_204_7.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10144 = nil
			end

			local var_204_16 = arg_201_1.actors_["10144"].transform
			local var_204_17 = 0

			if var_204_17 < arg_201_1.time_ and arg_201_1.time_ <= var_204_17 + arg_204_0 then
				arg_201_1.var_.moveOldPos10144 = var_204_16.localPosition
				var_204_16.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10144", 4)

				local var_204_18 = var_204_16.childCount

				for iter_204_8 = 0, var_204_18 - 1 do
					local var_204_19 = var_204_16:GetChild(iter_204_8)

					if var_204_19.name == "" or not string.find(var_204_19.name, "split") then
						var_204_19.gameObject:SetActive(true)
					else
						var_204_19.gameObject:SetActive(false)
					end
				end
			end

			local var_204_20 = 0.001

			if var_204_17 <= arg_201_1.time_ and arg_201_1.time_ < var_204_17 + var_204_20 then
				local var_204_21 = (arg_201_1.time_ - var_204_17) / var_204_20
				local var_204_22 = Vector3.New(435.8, -381.1, -285.9)

				var_204_16.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10144, var_204_22, var_204_21)
			end

			if arg_201_1.time_ >= var_204_17 + var_204_20 and arg_201_1.time_ < var_204_17 + var_204_20 + arg_204_0 then
				var_204_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_204_23 = arg_201_1.actors_["128404"].transform
			local var_204_24 = 0

			if var_204_24 < arg_201_1.time_ and arg_201_1.time_ <= var_204_24 + arg_204_0 then
				arg_201_1.var_.moveOldPos128404 = var_204_23.localPosition
				var_204_23.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("128404", 2)

				local var_204_25 = var_204_23.childCount

				for iter_204_9 = 0, var_204_25 - 1 do
					local var_204_26 = var_204_23:GetChild(iter_204_9)

					if var_204_26.name == "" or not string.find(var_204_26.name, "split") then
						var_204_26.gameObject:SetActive(true)
					else
						var_204_26.gameObject:SetActive(false)
					end
				end
			end

			local var_204_27 = 0.001

			if var_204_24 <= arg_201_1.time_ and arg_201_1.time_ < var_204_24 + var_204_27 then
				local var_204_28 = (arg_201_1.time_ - var_204_24) / var_204_27
				local var_204_29 = Vector3.New(-428.5, -356, -362.3)

				var_204_23.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos128404, var_204_29, var_204_28)
			end

			if arg_201_1.time_ >= var_204_24 + var_204_27 and arg_201_1.time_ < var_204_24 + var_204_27 + arg_204_0 then
				var_204_23.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_204_30 = 0
			local var_204_31 = 0.775

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_32 = arg_201_1:FormatText(StoryNameCfg[6].name)

				arg_201_1.leftNameTxt_.text = var_204_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(926031050)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 31
				local var_204_36 = utf8.len(var_204_34)
				local var_204_37 = var_204_35 <= 0 and var_204_31 or var_204_31 * (var_204_36 / var_204_35)

				if var_204_37 > 0 and var_204_31 < var_204_37 then
					arg_201_1.talkMaxDuration = var_204_37

					if var_204_37 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_37 + var_204_30
					end
				end

				arg_201_1.text_.text = var_204_34
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031050", "story_v_out_926031.awb") ~= 0 then
					local var_204_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031050", "story_v_out_926031.awb") / 1000

					if var_204_38 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_38 + var_204_30
					end

					if var_204_33.prefab_name ~= "" and arg_201_1.actors_[var_204_33.prefab_name] ~= nil then
						local var_204_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_33.prefab_name].transform, "story_v_out_926031", "926031050", "story_v_out_926031.awb")

						arg_201_1:RecordAudio("926031050", var_204_39)
						arg_201_1:RecordAudio("926031050", var_204_39)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_926031", "926031050", "story_v_out_926031.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_926031", "926031050", "story_v_out_926031.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_40 = math.max(var_204_31, arg_201_1.talkMaxDuration)

			if var_204_30 <= arg_201_1.time_ and arg_201_1.time_ < var_204_30 + var_204_40 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_30) / var_204_40

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_30 + var_204_40 and arg_201_1.time_ < var_204_30 + var_204_40 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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

		arg_201_1:InitPlayNodeList()
	end,
	Play926031051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 926031051
		arg_205_1.duration_ = 9.4

		local var_205_0 = {
			zh = 7.2,
			ja = 9.4
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play926031052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10144"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10144 == nil then
				arg_205_1.var_.actorSpriteComps10144 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps10144 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								local var_208_4 = Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor1.r, var_208_3)
								local var_208_5 = Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor1.g, var_208_3)
								local var_208_6 = Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor1.b, var_208_3)

								iter_208_1.color = Color.New(var_208_4, var_208_5, var_208_6)
							else
								local var_208_7 = Mathf.Lerp(iter_208_1.color.r, 1, var_208_3)

								iter_208_1.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10144 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10144 = nil
			end

			local var_208_8 = arg_205_1.actors_["128404"]
			local var_208_9 = 0

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps128404 == nil then
				arg_205_1.var_.actorSpriteComps128404 = var_208_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_10 = 0.2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 and not isNil(var_208_8) then
				local var_208_11 = (arg_205_1.time_ - var_208_9) / var_208_10

				if arg_205_1.var_.actorSpriteComps128404 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								local var_208_12 = Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, var_208_11)
								local var_208_13 = Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, var_208_11)
								local var_208_14 = Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, var_208_11)

								iter_208_5.color = Color.New(var_208_12, var_208_13, var_208_14)
							else
								local var_208_15 = Mathf.Lerp(iter_208_5.color.r, 0.5, var_208_11)

								iter_208_5.color = Color.New(var_208_15, var_208_15, var_208_15)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps128404 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_208_7 then
						if arg_205_1.isInRecall_ then
							iter_208_7.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps128404 = nil
			end

			local var_208_16 = 0
			local var_208_17 = 0.9

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_18 = arg_205_1:FormatText(StoryNameCfg[1297].name)

				arg_205_1.leftNameTxt_.text = var_208_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_19 = arg_205_1:GetWordFromCfg(926031051)
				local var_208_20 = arg_205_1:FormatText(var_208_19.content)

				arg_205_1.text_.text = var_208_20

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_21 = 36
				local var_208_22 = utf8.len(var_208_20)
				local var_208_23 = var_208_21 <= 0 and var_208_17 or var_208_17 * (var_208_22 / var_208_21)

				if var_208_23 > 0 and var_208_17 < var_208_23 then
					arg_205_1.talkMaxDuration = var_208_23

					if var_208_23 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_16
					end
				end

				arg_205_1.text_.text = var_208_20
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031051", "story_v_out_926031.awb") ~= 0 then
					local var_208_24 = manager.audio:GetVoiceLength("story_v_out_926031", "926031051", "story_v_out_926031.awb") / 1000

					if var_208_24 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_24 + var_208_16
					end

					if var_208_19.prefab_name ~= "" and arg_205_1.actors_[var_208_19.prefab_name] ~= nil then
						local var_208_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_19.prefab_name].transform, "story_v_out_926031", "926031051", "story_v_out_926031.awb")

						arg_205_1:RecordAudio("926031051", var_208_25)
						arg_205_1:RecordAudio("926031051", var_208_25)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_926031", "926031051", "story_v_out_926031.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_926031", "926031051", "story_v_out_926031.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_26 = math.max(var_208_17, arg_205_1.talkMaxDuration)

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_26 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_16) / var_208_26

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_16 + var_208_26 and arg_205_1.time_ < var_208_16 + var_208_26 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play926031052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 926031052
		arg_209_1.duration_ = 2.67

		local var_209_0 = {
			zh = 1.9,
			ja = 2.666
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
				arg_209_0:Play926031053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["128404"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps128404 == nil then
				arg_209_1.var_.actorSpriteComps128404 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps128404 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps128404 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps128404 = nil
			end

			local var_212_8 = arg_209_1.actors_["10144"]
			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10144 == nil then
				arg_209_1.var_.actorSpriteComps10144 = var_212_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_10 = 0.2

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_10 and not isNil(var_212_8) then
				local var_212_11 = (arg_209_1.time_ - var_212_9) / var_212_10

				if arg_209_1.var_.actorSpriteComps10144 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_212_5 then
							if arg_209_1.isInRecall_ then
								local var_212_12 = Mathf.Lerp(iter_212_5.color.r, arg_209_1.hightColor2.r, var_212_11)
								local var_212_13 = Mathf.Lerp(iter_212_5.color.g, arg_209_1.hightColor2.g, var_212_11)
								local var_212_14 = Mathf.Lerp(iter_212_5.color.b, arg_209_1.hightColor2.b, var_212_11)

								iter_212_5.color = Color.New(var_212_12, var_212_13, var_212_14)
							else
								local var_212_15 = Mathf.Lerp(iter_212_5.color.r, 0.5, var_212_11)

								iter_212_5.color = Color.New(var_212_15, var_212_15, var_212_15)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_9 + var_212_10 and arg_209_1.time_ < var_212_9 + var_212_10 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10144 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_212_7 then
						if arg_209_1.isInRecall_ then
							iter_212_7.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10144 = nil
			end

			local var_212_16 = arg_209_1.actors_["128404"].transform
			local var_212_17 = 0

			if var_212_17 < arg_209_1.time_ and arg_209_1.time_ <= var_212_17 + arg_212_0 then
				arg_209_1.var_.moveOldPos128404 = var_212_16.localPosition
				var_212_16.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("128404", 2)

				local var_212_18 = var_212_16.childCount

				for iter_212_8 = 0, var_212_18 - 1 do
					local var_212_19 = var_212_16:GetChild(iter_212_8)

					if var_212_19.name == "split_4" or not string.find(var_212_19.name, "split") then
						var_212_19.gameObject:SetActive(true)
					else
						var_212_19.gameObject:SetActive(false)
					end
				end
			end

			local var_212_20 = 0.001

			if var_212_17 <= arg_209_1.time_ and arg_209_1.time_ < var_212_17 + var_212_20 then
				local var_212_21 = (arg_209_1.time_ - var_212_17) / var_212_20
				local var_212_22 = Vector3.New(-428.5, -356, -362.3)

				var_212_16.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos128404, var_212_22, var_212_21)
			end

			if arg_209_1.time_ >= var_212_17 + var_212_20 and arg_209_1.time_ < var_212_17 + var_212_20 + arg_212_0 then
				var_212_16.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_212_23 = 0
			local var_212_24 = 0.2

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_25 = arg_209_1:FormatText(StoryNameCfg[6].name)

				arg_209_1.leftNameTxt_.text = var_212_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_26 = arg_209_1:GetWordFromCfg(926031052)
				local var_212_27 = arg_209_1:FormatText(var_212_26.content)

				arg_209_1.text_.text = var_212_27

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_28 = 8
				local var_212_29 = utf8.len(var_212_27)
				local var_212_30 = var_212_28 <= 0 and var_212_24 or var_212_24 * (var_212_29 / var_212_28)

				if var_212_30 > 0 and var_212_24 < var_212_30 then
					arg_209_1.talkMaxDuration = var_212_30

					if var_212_30 + var_212_23 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_30 + var_212_23
					end
				end

				arg_209_1.text_.text = var_212_27
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031052", "story_v_out_926031.awb") ~= 0 then
					local var_212_31 = manager.audio:GetVoiceLength("story_v_out_926031", "926031052", "story_v_out_926031.awb") / 1000

					if var_212_31 + var_212_23 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_31 + var_212_23
					end

					if var_212_26.prefab_name ~= "" and arg_209_1.actors_[var_212_26.prefab_name] ~= nil then
						local var_212_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_26.prefab_name].transform, "story_v_out_926031", "926031052", "story_v_out_926031.awb")

						arg_209_1:RecordAudio("926031052", var_212_32)
						arg_209_1:RecordAudio("926031052", var_212_32)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_926031", "926031052", "story_v_out_926031.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_926031", "926031052", "story_v_out_926031.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_33 = math.max(var_212_24, arg_209_1.talkMaxDuration)

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_33 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_23) / var_212_33

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_23 + var_212_33 and arg_209_1.time_ < var_212_23 + var_212_33 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play926031053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 926031053
		arg_213_1.duration_ = 5.9

		local var_213_0 = {
			zh = 5.9,
			ja = 4.633
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
				arg_213_0:Play926031054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10144"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10144 == nil then
				arg_213_1.var_.actorSpriteComps10144 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 0.2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps10144 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								local var_216_4 = Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, var_216_3)
								local var_216_5 = Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, var_216_3)
								local var_216_6 = Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, var_216_3)

								iter_216_1.color = Color.New(var_216_4, var_216_5, var_216_6)
							else
								local var_216_7 = Mathf.Lerp(iter_216_1.color.r, 1, var_216_3)

								iter_216_1.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10144 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10144 = nil
			end

			local var_216_8 = arg_213_1.actors_["128404"]
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps128404 == nil then
				arg_213_1.var_.actorSpriteComps128404 = var_216_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_10 = 0.2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 and not isNil(var_216_8) then
				local var_216_11 = (arg_213_1.time_ - var_216_9) / var_216_10

				if arg_213_1.var_.actorSpriteComps128404 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								local var_216_12 = Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, var_216_11)
								local var_216_13 = Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, var_216_11)
								local var_216_14 = Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, var_216_11)

								iter_216_5.color = Color.New(var_216_12, var_216_13, var_216_14)
							else
								local var_216_15 = Mathf.Lerp(iter_216_5.color.r, 0.5, var_216_11)

								iter_216_5.color = Color.New(var_216_15, var_216_15, var_216_15)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps128404 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_216_7 then
						if arg_213_1.isInRecall_ then
							iter_216_7.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps128404 = nil
			end

			local var_216_16 = arg_213_1.actors_["10144"].transform
			local var_216_17 = 0

			if var_216_17 < arg_213_1.time_ and arg_213_1.time_ <= var_216_17 + arg_216_0 then
				arg_213_1.var_.moveOldPos10144 = var_216_16.localPosition
				var_216_16.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10144", 3)

				local var_216_18 = var_216_16.childCount

				for iter_216_8 = 0, var_216_18 - 1 do
					local var_216_19 = var_216_16:GetChild(iter_216_8)

					if var_216_19.name == "" or not string.find(var_216_19.name, "split") then
						var_216_19.gameObject:SetActive(true)
					else
						var_216_19.gameObject:SetActive(false)
					end
				end
			end

			local var_216_20 = 0.001

			if var_216_17 <= arg_213_1.time_ and arg_213_1.time_ < var_216_17 + var_216_20 then
				local var_216_21 = (arg_213_1.time_ - var_216_17) / var_216_20
				local var_216_22 = Vector3.New(-31.5, -381.1, -285.9)

				var_216_16.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10144, var_216_22, var_216_21)
			end

			if arg_213_1.time_ >= var_216_17 + var_216_20 and arg_213_1.time_ < var_216_17 + var_216_20 + arg_216_0 then
				var_216_16.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_216_23 = arg_213_1.actors_["128404"].transform
			local var_216_24 = 0

			if var_216_24 < arg_213_1.time_ and arg_213_1.time_ <= var_216_24 + arg_216_0 then
				arg_213_1.var_.moveOldPos128404 = var_216_23.localPosition
				var_216_23.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("128404", 7)

				local var_216_25 = var_216_23.childCount

				for iter_216_9 = 0, var_216_25 - 1 do
					local var_216_26 = var_216_23:GetChild(iter_216_9)

					if var_216_26.name == "" or not string.find(var_216_26.name, "split") then
						var_216_26.gameObject:SetActive(true)
					else
						var_216_26.gameObject:SetActive(false)
					end
				end
			end

			local var_216_27 = 0.001

			if var_216_24 <= arg_213_1.time_ and arg_213_1.time_ < var_216_24 + var_216_27 then
				local var_216_28 = (arg_213_1.time_ - var_216_24) / var_216_27
				local var_216_29 = Vector3.New(0, -2000, 0)

				var_216_23.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos128404, var_216_29, var_216_28)
			end

			if arg_213_1.time_ >= var_216_24 + var_216_27 and arg_213_1.time_ < var_216_24 + var_216_27 + arg_216_0 then
				var_216_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_216_30 = 0
			local var_216_31 = 0.775

			if var_216_30 < arg_213_1.time_ and arg_213_1.time_ <= var_216_30 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_32 = arg_213_1:FormatText(StoryNameCfg[1297].name)

				arg_213_1.leftNameTxt_.text = var_216_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_33 = arg_213_1:GetWordFromCfg(926031053)
				local var_216_34 = arg_213_1:FormatText(var_216_33.content)

				arg_213_1.text_.text = var_216_34

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_35 = 31
				local var_216_36 = utf8.len(var_216_34)
				local var_216_37 = var_216_35 <= 0 and var_216_31 or var_216_31 * (var_216_36 / var_216_35)

				if var_216_37 > 0 and var_216_31 < var_216_37 then
					arg_213_1.talkMaxDuration = var_216_37

					if var_216_37 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_37 + var_216_30
					end
				end

				arg_213_1.text_.text = var_216_34
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031053", "story_v_out_926031.awb") ~= 0 then
					local var_216_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031053", "story_v_out_926031.awb") / 1000

					if var_216_38 + var_216_30 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_38 + var_216_30
					end

					if var_216_33.prefab_name ~= "" and arg_213_1.actors_[var_216_33.prefab_name] ~= nil then
						local var_216_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_33.prefab_name].transform, "story_v_out_926031", "926031053", "story_v_out_926031.awb")

						arg_213_1:RecordAudio("926031053", var_216_39)
						arg_213_1:RecordAudio("926031053", var_216_39)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_926031", "926031053", "story_v_out_926031.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_926031", "926031053", "story_v_out_926031.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_40 = math.max(var_216_31, arg_213_1.talkMaxDuration)

			if var_216_30 <= arg_213_1.time_ and arg_213_1.time_ < var_216_30 + var_216_40 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_30) / var_216_40

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_30 + var_216_40 and arg_213_1.time_ < var_216_30 + var_216_40 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play926031054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 926031054
		arg_217_1.duration_ = 5.6

		local var_217_0 = {
			zh = 5.6,
			ja = 4.733
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play926031055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10144"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10144 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10144", 3)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "split_2" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10144, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_220_7 = 0
			local var_220_8 = 0.6

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_9 = arg_217_1:FormatText(StoryNameCfg[1297].name)

				arg_217_1.leftNameTxt_.text = var_220_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(926031054)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_12 = 24
				local var_220_13 = utf8.len(var_220_11)
				local var_220_14 = var_220_12 <= 0 and var_220_8 or var_220_8 * (var_220_13 / var_220_12)

				if var_220_14 > 0 and var_220_8 < var_220_14 then
					arg_217_1.talkMaxDuration = var_220_14

					if var_220_14 + var_220_7 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_7
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031054", "story_v_out_926031.awb") ~= 0 then
					local var_220_15 = manager.audio:GetVoiceLength("story_v_out_926031", "926031054", "story_v_out_926031.awb") / 1000

					if var_220_15 + var_220_7 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_15 + var_220_7
					end

					if var_220_10.prefab_name ~= "" and arg_217_1.actors_[var_220_10.prefab_name] ~= nil then
						local var_220_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_10.prefab_name].transform, "story_v_out_926031", "926031054", "story_v_out_926031.awb")

						arg_217_1:RecordAudio("926031054", var_220_16)
						arg_217_1:RecordAudio("926031054", var_220_16)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_926031", "926031054", "story_v_out_926031.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_926031", "926031054", "story_v_out_926031.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_17 = math.max(var_220_8, arg_217_1.talkMaxDuration)

			if var_220_7 <= arg_217_1.time_ and arg_217_1.time_ < var_220_7 + var_220_17 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_7) / var_220_17

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_7 + var_220_17 and arg_217_1.time_ < var_220_7 + var_220_17 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play926031055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 926031055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play926031056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10144"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10144 == nil then
				arg_221_1.var_.actorSpriteComps10144 = var_224_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.actorSpriteComps10144 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								local var_224_4 = Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, var_224_3)
								local var_224_5 = Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, var_224_3)
								local var_224_6 = Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, var_224_3)

								iter_224_1.color = Color.New(var_224_4, var_224_5, var_224_6)
							else
								local var_224_7 = Mathf.Lerp(iter_224_1.color.r, 0.5, var_224_3)

								iter_224_1.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.actorSpriteComps10144 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_224_3 then
						if arg_221_1.isInRecall_ then
							iter_224_3.color = arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_224_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10144 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 0.55

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_10 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_11 = arg_221_1:GetWordFromCfg(926031055)
				local var_224_12 = arg_221_1:FormatText(var_224_11.content)

				arg_221_1.text_.text = var_224_12

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 22
				local var_224_14 = utf8.len(var_224_12)
				local var_224_15 = var_224_13 <= 0 and var_224_9 or var_224_9 * (var_224_14 / var_224_13)

				if var_224_15 > 0 and var_224_9 < var_224_15 then
					arg_221_1.talkMaxDuration = var_224_15

					if var_224_15 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_15 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_12
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play926031056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 926031056
		arg_225_1.duration_ = 3.7

		local var_225_0 = {
			zh = 3,
			ja = 3.7
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play926031057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10144"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10144 == nil then
				arg_225_1.var_.actorSpriteComps10144 = var_228_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_2 = 0.2

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.actorSpriteComps10144 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								local var_228_4 = Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor1.r, var_228_3)
								local var_228_5 = Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor1.g, var_228_3)
								local var_228_6 = Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor1.b, var_228_3)

								iter_228_1.color = Color.New(var_228_4, var_228_5, var_228_6)
							else
								local var_228_7 = Mathf.Lerp(iter_228_1.color.r, 1, var_228_3)

								iter_228_1.color = Color.New(var_228_7, var_228_7, var_228_7)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.actorSpriteComps10144 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_228_3 then
						if arg_225_1.isInRecall_ then
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10144 = nil
			end

			local var_228_8 = arg_225_1.actors_["10144"].transform
			local var_228_9 = 0

			if var_228_9 < arg_225_1.time_ and arg_225_1.time_ <= var_228_9 + arg_228_0 then
				arg_225_1.var_.moveOldPos10144 = var_228_8.localPosition
				var_228_8.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10144", 3)

				local var_228_10 = var_228_8.childCount

				for iter_228_4 = 0, var_228_10 - 1 do
					local var_228_11 = var_228_8:GetChild(iter_228_4)

					if var_228_11.name == "" or not string.find(var_228_11.name, "split") then
						var_228_11.gameObject:SetActive(true)
					else
						var_228_11.gameObject:SetActive(false)
					end
				end
			end

			local var_228_12 = 0.001

			if var_228_9 <= arg_225_1.time_ and arg_225_1.time_ < var_228_9 + var_228_12 then
				local var_228_13 = (arg_225_1.time_ - var_228_9) / var_228_12
				local var_228_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_228_8.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10144, var_228_14, var_228_13)
			end

			if arg_225_1.time_ >= var_228_9 + var_228_12 and arg_225_1.time_ < var_228_9 + var_228_12 + arg_228_0 then
				var_228_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_228_15 = 0
			local var_228_16 = 0.375

			if var_228_15 < arg_225_1.time_ and arg_225_1.time_ <= var_228_15 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_17 = arg_225_1:FormatText(StoryNameCfg[1297].name)

				arg_225_1.leftNameTxt_.text = var_228_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_18 = arg_225_1:GetWordFromCfg(926031056)
				local var_228_19 = arg_225_1:FormatText(var_228_18.content)

				arg_225_1.text_.text = var_228_19

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_20 = 15
				local var_228_21 = utf8.len(var_228_19)
				local var_228_22 = var_228_20 <= 0 and var_228_16 or var_228_16 * (var_228_21 / var_228_20)

				if var_228_22 > 0 and var_228_16 < var_228_22 then
					arg_225_1.talkMaxDuration = var_228_22

					if var_228_22 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_22 + var_228_15
					end
				end

				arg_225_1.text_.text = var_228_19
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031056", "story_v_out_926031.awb") ~= 0 then
					local var_228_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031056", "story_v_out_926031.awb") / 1000

					if var_228_23 + var_228_15 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_23 + var_228_15
					end

					if var_228_18.prefab_name ~= "" and arg_225_1.actors_[var_228_18.prefab_name] ~= nil then
						local var_228_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_18.prefab_name].transform, "story_v_out_926031", "926031056", "story_v_out_926031.awb")

						arg_225_1:RecordAudio("926031056", var_228_24)
						arg_225_1:RecordAudio("926031056", var_228_24)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_926031", "926031056", "story_v_out_926031.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_926031", "926031056", "story_v_out_926031.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_25 = math.max(var_228_16, arg_225_1.talkMaxDuration)

			if var_228_15 <= arg_225_1.time_ and arg_225_1.time_ < var_228_15 + var_228_25 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_15) / var_228_25

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_15 + var_228_25 and arg_225_1.time_ < var_228_15 + var_228_25 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play926031057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 926031057
		arg_229_1.duration_ = 8.13

		local var_229_0 = {
			zh = 5.4,
			ja = 8.133
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
				arg_229_0:Play926031058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.7

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[1297].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(926031057)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 28
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031057", "story_v_out_926031.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031057", "story_v_out_926031.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_926031", "926031057", "story_v_out_926031.awb")

						arg_229_1:RecordAudio("926031057", var_232_9)
						arg_229_1:RecordAudio("926031057", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_926031", "926031057", "story_v_out_926031.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_926031", "926031057", "story_v_out_926031.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play926031058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 926031058
		arg_233_1.duration_ = 5

		local var_233_0 = {
			zh = 3.9,
			ja = 5
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
				arg_233_0:Play926031059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10144"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10144 = var_236_0.localPosition
				var_236_0.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10144", 3)

				local var_236_2 = var_236_0.childCount

				for iter_236_0 = 0, var_236_2 - 1 do
					local var_236_3 = var_236_0:GetChild(iter_236_0)

					if var_236_3.name == "split_4" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_4 then
				local var_236_5 = (arg_233_1.time_ - var_236_1) / var_236_4
				local var_236_6 = Vector3.New(-31.5, -381.1, -285.9)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10144, var_236_6, var_236_5)
			end

			if arg_233_1.time_ >= var_236_1 + var_236_4 and arg_233_1.time_ < var_236_1 + var_236_4 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_236_7 = 0
			local var_236_8 = 0.5

			if var_236_7 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_9 = arg_233_1:FormatText(StoryNameCfg[1297].name)

				arg_233_1.leftNameTxt_.text = var_236_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(926031058)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_12 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031058", "story_v_out_926031.awb") ~= 0 then
					local var_236_15 = manager.audio:GetVoiceLength("story_v_out_926031", "926031058", "story_v_out_926031.awb") / 1000

					if var_236_15 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_15 + var_236_7
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_926031", "926031058", "story_v_out_926031.awb")

						arg_233_1:RecordAudio("926031058", var_236_16)
						arg_233_1:RecordAudio("926031058", var_236_16)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_926031", "926031058", "story_v_out_926031.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_926031", "926031058", "story_v_out_926031.awb")
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
				actorName = "10144",
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
	Play926031059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 926031059
		arg_237_1.duration_ = 1.67

		local var_237_0 = {
			zh = 1.533,
			ja = 1.666
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play926031060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["106103"]
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.actorSpriteComps106103 == nil then
				arg_237_1.var_.actorSpriteComps106103 = var_240_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_2 = 0.2

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 and not isNil(var_240_0) then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2

				if arg_237_1.var_.actorSpriteComps106103 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								local var_240_4 = Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor1.r, var_240_3)
								local var_240_5 = Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor1.g, var_240_3)
								local var_240_6 = Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor1.b, var_240_3)

								iter_240_1.color = Color.New(var_240_4, var_240_5, var_240_6)
							else
								local var_240_7 = Mathf.Lerp(iter_240_1.color.r, 1, var_240_3)

								iter_240_1.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 and not isNil(var_240_0) and arg_237_1.var_.actorSpriteComps106103 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_240_3 then
						if arg_237_1.isInRecall_ then
							iter_240_3.color = arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_240_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps106103 = nil
			end

			local var_240_8 = arg_237_1.actors_["10144"]
			local var_240_9 = 0

			if var_240_9 < arg_237_1.time_ and arg_237_1.time_ <= var_240_9 + arg_240_0 and not isNil(var_240_8) and arg_237_1.var_.actorSpriteComps10144 == nil then
				arg_237_1.var_.actorSpriteComps10144 = var_240_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_10 = 0.2

			if var_240_9 <= arg_237_1.time_ and arg_237_1.time_ < var_240_9 + var_240_10 and not isNil(var_240_8) then
				local var_240_11 = (arg_237_1.time_ - var_240_9) / var_240_10

				if arg_237_1.var_.actorSpriteComps10144 then
					for iter_240_4, iter_240_5 in pairs(arg_237_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_240_5 then
							if arg_237_1.isInRecall_ then
								local var_240_12 = Mathf.Lerp(iter_240_5.color.r, arg_237_1.hightColor2.r, var_240_11)
								local var_240_13 = Mathf.Lerp(iter_240_5.color.g, arg_237_1.hightColor2.g, var_240_11)
								local var_240_14 = Mathf.Lerp(iter_240_5.color.b, arg_237_1.hightColor2.b, var_240_11)

								iter_240_5.color = Color.New(var_240_12, var_240_13, var_240_14)
							else
								local var_240_15 = Mathf.Lerp(iter_240_5.color.r, 0.5, var_240_11)

								iter_240_5.color = Color.New(var_240_15, var_240_15, var_240_15)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= var_240_9 + var_240_10 and arg_237_1.time_ < var_240_9 + var_240_10 + arg_240_0 and not isNil(var_240_8) and arg_237_1.var_.actorSpriteComps10144 then
				for iter_240_6, iter_240_7 in pairs(arg_237_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_240_7 then
						if arg_237_1.isInRecall_ then
							iter_240_7.color = arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_240_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_237_1.var_.actorSpriteComps10144 = nil
			end

			local var_240_16 = arg_237_1.actors_["106103"].transform
			local var_240_17 = 0

			if var_240_17 < arg_237_1.time_ and arg_237_1.time_ <= var_240_17 + arg_240_0 then
				arg_237_1.var_.moveOldPos106103 = var_240_16.localPosition
				var_240_16.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("106103", 3)

				local var_240_18 = var_240_16.childCount

				for iter_240_8 = 0, var_240_18 - 1 do
					local var_240_19 = var_240_16:GetChild(iter_240_8)

					if var_240_19.name == "split_2" or not string.find(var_240_19.name, "split") then
						var_240_19.gameObject:SetActive(true)
					else
						var_240_19.gameObject:SetActive(false)
					end
				end
			end

			local var_240_20 = 0.001

			if var_240_17 <= arg_237_1.time_ and arg_237_1.time_ < var_240_17 + var_240_20 then
				local var_240_21 = (arg_237_1.time_ - var_240_17) / var_240_20
				local var_240_22 = Vector3.New(-36.6, -398.2, -333.7)

				var_240_16.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos106103, var_240_22, var_240_21)
			end

			if arg_237_1.time_ >= var_240_17 + var_240_20 and arg_237_1.time_ < var_240_17 + var_240_20 + arg_240_0 then
				var_240_16.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_240_23 = arg_237_1.actors_["10144"].transform
			local var_240_24 = 0

			if var_240_24 < arg_237_1.time_ and arg_237_1.time_ <= var_240_24 + arg_240_0 then
				arg_237_1.var_.moveOldPos10144 = var_240_23.localPosition
				var_240_23.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10144", 7)

				local var_240_25 = var_240_23.childCount

				for iter_240_9 = 0, var_240_25 - 1 do
					local var_240_26 = var_240_23:GetChild(iter_240_9)

					if var_240_26.name == "" or not string.find(var_240_26.name, "split") then
						var_240_26.gameObject:SetActive(true)
					else
						var_240_26.gameObject:SetActive(false)
					end
				end
			end

			local var_240_27 = 0.001

			if var_240_24 <= arg_237_1.time_ and arg_237_1.time_ < var_240_24 + var_240_27 then
				local var_240_28 = (arg_237_1.time_ - var_240_24) / var_240_27
				local var_240_29 = Vector3.New(0, -2000, 0)

				var_240_23.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10144, var_240_29, var_240_28)
			end

			if arg_237_1.time_ >= var_240_24 + var_240_27 and arg_237_1.time_ < var_240_24 + var_240_27 + arg_240_0 then
				var_240_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_30 = 0
			local var_240_31 = 0.125

			if var_240_30 < arg_237_1.time_ and arg_237_1.time_ <= var_240_30 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_32 = arg_237_1:FormatText(StoryNameCfg[612].name)

				arg_237_1.leftNameTxt_.text = var_240_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_33 = arg_237_1:GetWordFromCfg(926031059)
				local var_240_34 = arg_237_1:FormatText(var_240_33.content)

				arg_237_1.text_.text = var_240_34

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_35 = 5
				local var_240_36 = utf8.len(var_240_34)
				local var_240_37 = var_240_35 <= 0 and var_240_31 or var_240_31 * (var_240_36 / var_240_35)

				if var_240_37 > 0 and var_240_31 < var_240_37 then
					arg_237_1.talkMaxDuration = var_240_37

					if var_240_37 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_37 + var_240_30
					end
				end

				arg_237_1.text_.text = var_240_34
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031059", "story_v_out_926031.awb") ~= 0 then
					local var_240_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031059", "story_v_out_926031.awb") / 1000

					if var_240_38 + var_240_30 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_38 + var_240_30
					end

					if var_240_33.prefab_name ~= "" and arg_237_1.actors_[var_240_33.prefab_name] ~= nil then
						local var_240_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_33.prefab_name].transform, "story_v_out_926031", "926031059", "story_v_out_926031.awb")

						arg_237_1:RecordAudio("926031059", var_240_39)
						arg_237_1:RecordAudio("926031059", var_240_39)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_926031", "926031059", "story_v_out_926031.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_926031", "926031059", "story_v_out_926031.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_40 = math.max(var_240_31, arg_237_1.talkMaxDuration)

			if var_240_30 <= arg_237_1.time_ and arg_237_1.time_ < var_240_30 + var_240_40 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_30) / var_240_40

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_30 + var_240_40 and arg_237_1.time_ < var_240_30 + var_240_40 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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
				actorName = "10144",
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
	Play926031060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 926031060
		arg_241_1.duration_ = 3.77

		local var_241_0 = {
			zh = 3.766,
			ja = 3.466
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
				arg_241_0:Play926031061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["104701"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps104701 == nil then
				arg_241_1.var_.actorSpriteComps104701 = var_244_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_2 = 0.2

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.actorSpriteComps104701 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.actorSpriteComps104701 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_244_3 then
						if arg_241_1.isInRecall_ then
							iter_244_3.color = arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_244_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps104701 = nil
			end

			local var_244_8 = arg_241_1.actors_["106103"]
			local var_244_9 = 0

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps106103 == nil then
				arg_241_1.var_.actorSpriteComps106103 = var_244_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_10 = 0.2

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_10 and not isNil(var_244_8) then
				local var_244_11 = (arg_241_1.time_ - var_244_9) / var_244_10

				if arg_241_1.var_.actorSpriteComps106103 then
					for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_244_5 then
							if arg_241_1.isInRecall_ then
								local var_244_12 = Mathf.Lerp(iter_244_5.color.r, arg_241_1.hightColor2.r, var_244_11)
								local var_244_13 = Mathf.Lerp(iter_244_5.color.g, arg_241_1.hightColor2.g, var_244_11)
								local var_244_14 = Mathf.Lerp(iter_244_5.color.b, arg_241_1.hightColor2.b, var_244_11)

								iter_244_5.color = Color.New(var_244_12, var_244_13, var_244_14)
							else
								local var_244_15 = Mathf.Lerp(iter_244_5.color.r, 0.5, var_244_11)

								iter_244_5.color = Color.New(var_244_15, var_244_15, var_244_15)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= var_244_9 + var_244_10 and arg_241_1.time_ < var_244_9 + var_244_10 + arg_244_0 and not isNil(var_244_8) and arg_241_1.var_.actorSpriteComps106103 then
				for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_244_7 then
						if arg_241_1.isInRecall_ then
							iter_244_7.color = arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_244_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_241_1.var_.actorSpriteComps106103 = nil
			end

			local var_244_16 = arg_241_1.actors_["104701"].transform
			local var_244_17 = 0

			if var_244_17 < arg_241_1.time_ and arg_241_1.time_ <= var_244_17 + arg_244_0 then
				arg_241_1.var_.moveOldPos104701 = var_244_16.localPosition
				var_244_16.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("104701", 3)

				local var_244_18 = var_244_16.childCount

				for iter_244_8 = 0, var_244_18 - 1 do
					local var_244_19 = var_244_16:GetChild(iter_244_8)

					if var_244_19.name == "" or not string.find(var_244_19.name, "split") then
						var_244_19.gameObject:SetActive(true)
					else
						var_244_19.gameObject:SetActive(false)
					end
				end
			end

			local var_244_20 = 0.001

			if var_244_17 <= arg_241_1.time_ and arg_241_1.time_ < var_244_17 + var_244_20 then
				local var_244_21 = (arg_241_1.time_ - var_244_17) / var_244_20
				local var_244_22 = Vector3.New(-67.4, -386.8, -295)

				var_244_16.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos104701, var_244_22, var_244_21)
			end

			if arg_241_1.time_ >= var_244_17 + var_244_20 and arg_241_1.time_ < var_244_17 + var_244_20 + arg_244_0 then
				var_244_16.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_244_23 = arg_241_1.actors_["106103"].transform
			local var_244_24 = 0

			if var_244_24 < arg_241_1.time_ and arg_241_1.time_ <= var_244_24 + arg_244_0 then
				arg_241_1.var_.moveOldPos106103 = var_244_23.localPosition
				var_244_23.localScale = Vector3.New(1, 1, 1)

				arg_241_1:CheckSpriteTmpPos("106103", 7)

				local var_244_25 = var_244_23.childCount

				for iter_244_9 = 0, var_244_25 - 1 do
					local var_244_26 = var_244_23:GetChild(iter_244_9)

					if var_244_26.name == "split_4" or not string.find(var_244_26.name, "split") then
						var_244_26.gameObject:SetActive(true)
					else
						var_244_26.gameObject:SetActive(false)
					end
				end
			end

			local var_244_27 = 0.001

			if var_244_24 <= arg_241_1.time_ and arg_241_1.time_ < var_244_24 + var_244_27 then
				local var_244_28 = (arg_241_1.time_ - var_244_24) / var_244_27
				local var_244_29 = Vector3.New(0, -2000, 0)

				var_244_23.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos106103, var_244_29, var_244_28)
			end

			if arg_241_1.time_ >= var_244_24 + var_244_27 and arg_241_1.time_ < var_244_24 + var_244_27 + arg_244_0 then
				var_244_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_244_30 = 0
			local var_244_31 = 0.4

			if var_244_30 < arg_241_1.time_ and arg_241_1.time_ <= var_244_30 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_32 = arg_241_1:FormatText(StoryNameCfg[1296].name)

				arg_241_1.leftNameTxt_.text = var_244_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_33 = arg_241_1:GetWordFromCfg(926031060)
				local var_244_34 = arg_241_1:FormatText(var_244_33.content)

				arg_241_1.text_.text = var_244_34

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_35 = 16
				local var_244_36 = utf8.len(var_244_34)
				local var_244_37 = var_244_35 <= 0 and var_244_31 or var_244_31 * (var_244_36 / var_244_35)

				if var_244_37 > 0 and var_244_31 < var_244_37 then
					arg_241_1.talkMaxDuration = var_244_37

					if var_244_37 + var_244_30 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_37 + var_244_30
					end
				end

				arg_241_1.text_.text = var_244_34
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031060", "story_v_out_926031.awb") ~= 0 then
					local var_244_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031060", "story_v_out_926031.awb") / 1000

					if var_244_38 + var_244_30 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_38 + var_244_30
					end

					if var_244_33.prefab_name ~= "" and arg_241_1.actors_[var_244_33.prefab_name] ~= nil then
						local var_244_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_33.prefab_name].transform, "story_v_out_926031", "926031060", "story_v_out_926031.awb")

						arg_241_1:RecordAudio("926031060", var_244_39)
						arg_241_1:RecordAudio("926031060", var_244_39)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_926031", "926031060", "story_v_out_926031.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_926031", "926031060", "story_v_out_926031.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_40 = math.max(var_244_31, arg_241_1.talkMaxDuration)

			if var_244_30 <= arg_241_1.time_ and arg_241_1.time_ < var_244_30 + var_244_40 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_30) / var_244_40

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_30 + var_244_40 and arg_241_1.time_ < var_244_30 + var_244_40 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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
				actorName = "106103",
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
	Play926031061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 926031061
		arg_245_1.duration_ = 7.93

		local var_245_0 = {
			zh = 5.266,
			ja = 7.933
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play926031062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["10144"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10144 == nil then
				arg_245_1.var_.actorSpriteComps10144 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 0.2

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps10144 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								local var_248_4 = Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor1.r, var_248_3)
								local var_248_5 = Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor1.g, var_248_3)
								local var_248_6 = Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor1.b, var_248_3)

								iter_248_1.color = Color.New(var_248_4, var_248_5, var_248_6)
							else
								local var_248_7 = Mathf.Lerp(iter_248_1.color.r, 1, var_248_3)

								iter_248_1.color = Color.New(var_248_7, var_248_7, var_248_7)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps10144 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_248_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps10144 = nil
			end

			local var_248_8 = arg_245_1.actors_["104701"]
			local var_248_9 = 0

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 and not isNil(var_248_8) and arg_245_1.var_.actorSpriteComps104701 == nil then
				arg_245_1.var_.actorSpriteComps104701 = var_248_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_10 = 0.2

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_10 and not isNil(var_248_8) then
				local var_248_11 = (arg_245_1.time_ - var_248_9) / var_248_10

				if arg_245_1.var_.actorSpriteComps104701 then
					for iter_248_4, iter_248_5 in pairs(arg_245_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_248_5 then
							if arg_245_1.isInRecall_ then
								local var_248_12 = Mathf.Lerp(iter_248_5.color.r, arg_245_1.hightColor2.r, var_248_11)
								local var_248_13 = Mathf.Lerp(iter_248_5.color.g, arg_245_1.hightColor2.g, var_248_11)
								local var_248_14 = Mathf.Lerp(iter_248_5.color.b, arg_245_1.hightColor2.b, var_248_11)

								iter_248_5.color = Color.New(var_248_12, var_248_13, var_248_14)
							else
								local var_248_15 = Mathf.Lerp(iter_248_5.color.r, 0.5, var_248_11)

								iter_248_5.color = Color.New(var_248_15, var_248_15, var_248_15)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_9 + var_248_10 and arg_245_1.time_ < var_248_9 + var_248_10 + arg_248_0 and not isNil(var_248_8) and arg_245_1.var_.actorSpriteComps104701 then
				for iter_248_6, iter_248_7 in pairs(arg_245_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_248_7 then
						if arg_245_1.isInRecall_ then
							iter_248_7.color = arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_248_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps104701 = nil
			end

			local var_248_16 = arg_245_1.actors_["106103"].transform
			local var_248_17 = 0

			if var_248_17 < arg_245_1.time_ and arg_245_1.time_ <= var_248_17 + arg_248_0 then
				arg_245_1.var_.moveOldPos106103 = var_248_16.localPosition
				var_248_16.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("106103", 7)

				local var_248_18 = var_248_16.childCount

				for iter_248_8 = 0, var_248_18 - 1 do
					local var_248_19 = var_248_16:GetChild(iter_248_8)

					if var_248_19.name == "" or not string.find(var_248_19.name, "split") then
						var_248_19.gameObject:SetActive(true)
					else
						var_248_19.gameObject:SetActive(false)
					end
				end
			end

			local var_248_20 = 0.001

			if var_248_17 <= arg_245_1.time_ and arg_245_1.time_ < var_248_17 + var_248_20 then
				local var_248_21 = (arg_245_1.time_ - var_248_17) / var_248_20
				local var_248_22 = Vector3.New(0, -2000, 0)

				var_248_16.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos106103, var_248_22, var_248_21)
			end

			if arg_245_1.time_ >= var_248_17 + var_248_20 and arg_245_1.time_ < var_248_17 + var_248_20 + arg_248_0 then
				var_248_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_248_23 = arg_245_1.actors_["10144"].transform
			local var_248_24 = 0

			if var_248_24 < arg_245_1.time_ and arg_245_1.time_ <= var_248_24 + arg_248_0 then
				arg_245_1.var_.moveOldPos10144 = var_248_23.localPosition
				var_248_23.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("10144", 2)

				local var_248_25 = var_248_23.childCount

				for iter_248_9 = 0, var_248_25 - 1 do
					local var_248_26 = var_248_23:GetChild(iter_248_9)

					if var_248_26.name == "" or not string.find(var_248_26.name, "split") then
						var_248_26.gameObject:SetActive(true)
					else
						var_248_26.gameObject:SetActive(false)
					end
				end
			end

			local var_248_27 = 0.001

			if var_248_24 <= arg_245_1.time_ and arg_245_1.time_ < var_248_24 + var_248_27 then
				local var_248_28 = (arg_245_1.time_ - var_248_24) / var_248_27
				local var_248_29 = Vector3.New(-507.9, -381.1, -285.9)

				var_248_23.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10144, var_248_29, var_248_28)
			end

			if arg_245_1.time_ >= var_248_24 + var_248_27 and arg_245_1.time_ < var_248_24 + var_248_27 + arg_248_0 then
				var_248_23.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_248_30 = arg_245_1.actors_["104701"].transform
			local var_248_31 = 0

			if var_248_31 < arg_245_1.time_ and arg_245_1.time_ <= var_248_31 + arg_248_0 then
				arg_245_1.var_.moveOldPos104701 = var_248_30.localPosition
				var_248_30.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("104701", 4)

				local var_248_32 = var_248_30.childCount

				for iter_248_10 = 0, var_248_32 - 1 do
					local var_248_33 = var_248_30:GetChild(iter_248_10)

					if var_248_33.name == "" or not string.find(var_248_33.name, "split") then
						var_248_33.gameObject:SetActive(true)
					else
						var_248_33.gameObject:SetActive(false)
					end
				end
			end

			local var_248_34 = 0.001

			if var_248_31 <= arg_245_1.time_ and arg_245_1.time_ < var_248_31 + var_248_34 then
				local var_248_35 = (arg_245_1.time_ - var_248_31) / var_248_34
				local var_248_36 = Vector3.New(372.4, -386.8, -295)

				var_248_30.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos104701, var_248_36, var_248_35)
			end

			if arg_245_1.time_ >= var_248_31 + var_248_34 and arg_245_1.time_ < var_248_31 + var_248_34 + arg_248_0 then
				var_248_30.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_248_37 = 0
			local var_248_38 = 0.65

			if var_248_37 < arg_245_1.time_ and arg_245_1.time_ <= var_248_37 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_39 = arg_245_1:FormatText(StoryNameCfg[1297].name)

				arg_245_1.leftNameTxt_.text = var_248_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_40 = arg_245_1:GetWordFromCfg(926031061)
				local var_248_41 = arg_245_1:FormatText(var_248_40.content)

				arg_245_1.text_.text = var_248_41

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_42 = 26
				local var_248_43 = utf8.len(var_248_41)
				local var_248_44 = var_248_42 <= 0 and var_248_38 or var_248_38 * (var_248_43 / var_248_42)

				if var_248_44 > 0 and var_248_38 < var_248_44 then
					arg_245_1.talkMaxDuration = var_248_44

					if var_248_44 + var_248_37 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_44 + var_248_37
					end
				end

				arg_245_1.text_.text = var_248_41
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031061", "story_v_out_926031.awb") ~= 0 then
					local var_248_45 = manager.audio:GetVoiceLength("story_v_out_926031", "926031061", "story_v_out_926031.awb") / 1000

					if var_248_45 + var_248_37 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_45 + var_248_37
					end

					if var_248_40.prefab_name ~= "" and arg_245_1.actors_[var_248_40.prefab_name] ~= nil then
						local var_248_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_40.prefab_name].transform, "story_v_out_926031", "926031061", "story_v_out_926031.awb")

						arg_245_1:RecordAudio("926031061", var_248_46)
						arg_245_1:RecordAudio("926031061", var_248_46)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_926031", "926031061", "story_v_out_926031.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_926031", "926031061", "story_v_out_926031.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_47 = math.max(var_248_38, arg_245_1.talkMaxDuration)

			if var_248_37 <= arg_245_1.time_ and arg_245_1.time_ < var_248_37 + var_248_47 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_37) / var_248_47

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_37 + var_248_47 and arg_245_1.time_ < var_248_37 + var_248_47 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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

		arg_245_1:InitPlayNodeList()
	end,
	Play926031062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 926031062
		arg_249_1.duration_ = 3.53

		local var_249_0 = {
			zh = 3.533,
			ja = 2.733
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
				arg_249_0:Play926031063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["104701"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps104701 == nil then
				arg_249_1.var_.actorSpriteComps104701 = var_252_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_2 = 0.2

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.actorSpriteComps104701 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.actorSpriteComps104701 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_252_3 then
						if arg_249_1.isInRecall_ then
							iter_252_3.color = arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_252_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps104701 = nil
			end

			local var_252_8 = arg_249_1.actors_["10144"]
			local var_252_9 = 0

			if var_252_9 < arg_249_1.time_ and arg_249_1.time_ <= var_252_9 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10144 == nil then
				arg_249_1.var_.actorSpriteComps10144 = var_252_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_10 = 0.2

			if var_252_9 <= arg_249_1.time_ and arg_249_1.time_ < var_252_9 + var_252_10 and not isNil(var_252_8) then
				local var_252_11 = (arg_249_1.time_ - var_252_9) / var_252_10

				if arg_249_1.var_.actorSpriteComps10144 then
					for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_252_5 then
							if arg_249_1.isInRecall_ then
								local var_252_12 = Mathf.Lerp(iter_252_5.color.r, arg_249_1.hightColor2.r, var_252_11)
								local var_252_13 = Mathf.Lerp(iter_252_5.color.g, arg_249_1.hightColor2.g, var_252_11)
								local var_252_14 = Mathf.Lerp(iter_252_5.color.b, arg_249_1.hightColor2.b, var_252_11)

								iter_252_5.color = Color.New(var_252_12, var_252_13, var_252_14)
							else
								local var_252_15 = Mathf.Lerp(iter_252_5.color.r, 0.5, var_252_11)

								iter_252_5.color = Color.New(var_252_15, var_252_15, var_252_15)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= var_252_9 + var_252_10 and arg_249_1.time_ < var_252_9 + var_252_10 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10144 then
				for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_252_7 then
						if arg_249_1.isInRecall_ then
							iter_252_7.color = arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_252_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_249_1.var_.actorSpriteComps10144 = nil
			end

			local var_252_16 = arg_249_1.actors_["10144"].transform
			local var_252_17 = 0

			if var_252_17 < arg_249_1.time_ and arg_249_1.time_ <= var_252_17 + arg_252_0 then
				arg_249_1.var_.moveOldPos10144 = var_252_16.localPosition
				var_252_16.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10144", 2)

				local var_252_18 = var_252_16.childCount

				for iter_252_8 = 0, var_252_18 - 1 do
					local var_252_19 = var_252_16:GetChild(iter_252_8)

					if var_252_19.name == "" or not string.find(var_252_19.name, "split") then
						var_252_19.gameObject:SetActive(true)
					else
						var_252_19.gameObject:SetActive(false)
					end
				end
			end

			local var_252_20 = 0.001

			if var_252_17 <= arg_249_1.time_ and arg_249_1.time_ < var_252_17 + var_252_20 then
				local var_252_21 = (arg_249_1.time_ - var_252_17) / var_252_20
				local var_252_22 = Vector3.New(-507.9, -381.1, -285.9)

				var_252_16.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10144, var_252_22, var_252_21)
			end

			if arg_249_1.time_ >= var_252_17 + var_252_20 and arg_249_1.time_ < var_252_17 + var_252_20 + arg_252_0 then
				var_252_16.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_252_23 = 0
			local var_252_24 = 0.45

			if var_252_23 < arg_249_1.time_ and arg_249_1.time_ <= var_252_23 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_25 = arg_249_1:FormatText(StoryNameCfg[1296].name)

				arg_249_1.leftNameTxt_.text = var_252_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_26 = arg_249_1:GetWordFromCfg(926031062)
				local var_252_27 = arg_249_1:FormatText(var_252_26.content)

				arg_249_1.text_.text = var_252_27

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_28 = 18
				local var_252_29 = utf8.len(var_252_27)
				local var_252_30 = var_252_28 <= 0 and var_252_24 or var_252_24 * (var_252_29 / var_252_28)

				if var_252_30 > 0 and var_252_24 < var_252_30 then
					arg_249_1.talkMaxDuration = var_252_30

					if var_252_30 + var_252_23 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_30 + var_252_23
					end
				end

				arg_249_1.text_.text = var_252_27
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031062", "story_v_out_926031.awb") ~= 0 then
					local var_252_31 = manager.audio:GetVoiceLength("story_v_out_926031", "926031062", "story_v_out_926031.awb") / 1000

					if var_252_31 + var_252_23 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_31 + var_252_23
					end

					if var_252_26.prefab_name ~= "" and arg_249_1.actors_[var_252_26.prefab_name] ~= nil then
						local var_252_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_26.prefab_name].transform, "story_v_out_926031", "926031062", "story_v_out_926031.awb")

						arg_249_1:RecordAudio("926031062", var_252_32)
						arg_249_1:RecordAudio("926031062", var_252_32)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_926031", "926031062", "story_v_out_926031.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_926031", "926031062", "story_v_out_926031.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_33 = math.max(var_252_24, arg_249_1.talkMaxDuration)

			if var_252_23 <= arg_249_1.time_ and arg_249_1.time_ < var_252_23 + var_252_33 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_23) / var_252_33

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_23 + var_252_33 and arg_249_1.time_ < var_252_23 + var_252_33 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play926031063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 926031063
		arg_253_1.duration_ = 4.2

		local var_253_0 = {
			zh = 3.666,
			ja = 4.2
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
				arg_253_0:Play926031064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10144"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10144 == nil then
				arg_253_1.var_.actorSpriteComps10144 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.2

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps10144 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								local var_256_4 = Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor1.r, var_256_3)
								local var_256_5 = Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor1.g, var_256_3)
								local var_256_6 = Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor1.b, var_256_3)

								iter_256_1.color = Color.New(var_256_4, var_256_5, var_256_6)
							else
								local var_256_7 = Mathf.Lerp(iter_256_1.color.r, 1, var_256_3)

								iter_256_1.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps10144 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_256_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps10144 = nil
			end

			local var_256_8 = arg_253_1.actors_["104701"]
			local var_256_9 = 0

			if var_256_9 < arg_253_1.time_ and arg_253_1.time_ <= var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps104701 == nil then
				arg_253_1.var_.actorSpriteComps104701 = var_256_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_10 = 0.2

			if var_256_9 <= arg_253_1.time_ and arg_253_1.time_ < var_256_9 + var_256_10 and not isNil(var_256_8) then
				local var_256_11 = (arg_253_1.time_ - var_256_9) / var_256_10

				if arg_253_1.var_.actorSpriteComps104701 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								local var_256_12 = Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, var_256_11)
								local var_256_13 = Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, var_256_11)
								local var_256_14 = Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, var_256_11)

								iter_256_5.color = Color.New(var_256_12, var_256_13, var_256_14)
							else
								local var_256_15 = Mathf.Lerp(iter_256_5.color.r, 0.5, var_256_11)

								iter_256_5.color = Color.New(var_256_15, var_256_15, var_256_15)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_9 + var_256_10 and arg_253_1.time_ < var_256_9 + var_256_10 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.actorSpriteComps104701 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_256_7 then
						if arg_253_1.isInRecall_ then
							iter_256_7.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps104701 = nil
			end

			local var_256_16 = 0
			local var_256_17 = 0.375

			if var_256_16 < arg_253_1.time_ and arg_253_1.time_ <= var_256_16 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_18 = arg_253_1:FormatText(StoryNameCfg[1297].name)

				arg_253_1.leftNameTxt_.text = var_256_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_19 = arg_253_1:GetWordFromCfg(926031063)
				local var_256_20 = arg_253_1:FormatText(var_256_19.content)

				arg_253_1.text_.text = var_256_20

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_21 = 15
				local var_256_22 = utf8.len(var_256_20)
				local var_256_23 = var_256_21 <= 0 and var_256_17 or var_256_17 * (var_256_22 / var_256_21)

				if var_256_23 > 0 and var_256_17 < var_256_23 then
					arg_253_1.talkMaxDuration = var_256_23

					if var_256_23 + var_256_16 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_23 + var_256_16
					end
				end

				arg_253_1.text_.text = var_256_20
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031063", "story_v_out_926031.awb") ~= 0 then
					local var_256_24 = manager.audio:GetVoiceLength("story_v_out_926031", "926031063", "story_v_out_926031.awb") / 1000

					if var_256_24 + var_256_16 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_24 + var_256_16
					end

					if var_256_19.prefab_name ~= "" and arg_253_1.actors_[var_256_19.prefab_name] ~= nil then
						local var_256_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_19.prefab_name].transform, "story_v_out_926031", "926031063", "story_v_out_926031.awb")

						arg_253_1:RecordAudio("926031063", var_256_25)
						arg_253_1:RecordAudio("926031063", var_256_25)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_926031", "926031063", "story_v_out_926031.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_926031", "926031063", "story_v_out_926031.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_26 = math.max(var_256_17, arg_253_1.talkMaxDuration)

			if var_256_16 <= arg_253_1.time_ and arg_253_1.time_ < var_256_16 + var_256_26 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_16) / var_256_26

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_16 + var_256_26 and arg_253_1.time_ < var_256_16 + var_256_26 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play926031064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 926031064
		arg_257_1.duration_ = 9.1

		local var_257_0 = {
			zh = 6.933,
			ja = 9.1
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
				arg_257_0:Play926031065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["104701"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps104701 == nil then
				arg_257_1.var_.actorSpriteComps104701 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps104701 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps104701 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps104701 = nil
			end

			local var_260_8 = arg_257_1.actors_["10144"]
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps10144 == nil then
				arg_257_1.var_.actorSpriteComps10144 = var_260_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_10 = 0.2

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_10 and not isNil(var_260_8) then
				local var_260_11 = (arg_257_1.time_ - var_260_9) / var_260_10

				if arg_257_1.var_.actorSpriteComps10144 then
					for iter_260_4, iter_260_5 in pairs(arg_257_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_257_1.time_ >= var_260_9 + var_260_10 and arg_257_1.time_ < var_260_9 + var_260_10 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.actorSpriteComps10144 then
				for iter_260_6, iter_260_7 in pairs(arg_257_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_260_7 then
						if arg_257_1.isInRecall_ then
							iter_260_7.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10144 = nil
			end

			local var_260_16 = arg_257_1.actors_["104701"].transform
			local var_260_17 = 0

			if var_260_17 < arg_257_1.time_ and arg_257_1.time_ <= var_260_17 + arg_260_0 then
				arg_257_1.var_.moveOldPos104701 = var_260_16.localPosition
				var_260_16.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("104701", 4)

				local var_260_18 = var_260_16.childCount

				for iter_260_8 = 0, var_260_18 - 1 do
					local var_260_19 = var_260_16:GetChild(iter_260_8)

					if var_260_19.name == "split_6" or not string.find(var_260_19.name, "split") then
						var_260_19.gameObject:SetActive(true)
					else
						var_260_19.gameObject:SetActive(false)
					end
				end
			end

			local var_260_20 = 0.001

			if var_260_17 <= arg_257_1.time_ and arg_257_1.time_ < var_260_17 + var_260_20 then
				local var_260_21 = (arg_257_1.time_ - var_260_17) / var_260_20
				local var_260_22 = Vector3.New(372.4, -386.8, -295)

				var_260_16.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos104701, var_260_22, var_260_21)
			end

			if arg_257_1.time_ >= var_260_17 + var_260_20 and arg_257_1.time_ < var_260_17 + var_260_20 + arg_260_0 then
				var_260_16.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_260_23 = 0
			local var_260_24 = 0.75

			if var_260_23 < arg_257_1.time_ and arg_257_1.time_ <= var_260_23 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_25 = arg_257_1:FormatText(StoryNameCfg[1296].name)

				arg_257_1.leftNameTxt_.text = var_260_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_26 = arg_257_1:GetWordFromCfg(926031064)
				local var_260_27 = arg_257_1:FormatText(var_260_26.content)

				arg_257_1.text_.text = var_260_27

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_28 = 30
				local var_260_29 = utf8.len(var_260_27)
				local var_260_30 = var_260_28 <= 0 and var_260_24 or var_260_24 * (var_260_29 / var_260_28)

				if var_260_30 > 0 and var_260_24 < var_260_30 then
					arg_257_1.talkMaxDuration = var_260_30

					if var_260_30 + var_260_23 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_30 + var_260_23
					end
				end

				arg_257_1.text_.text = var_260_27
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031064", "story_v_out_926031.awb") ~= 0 then
					local var_260_31 = manager.audio:GetVoiceLength("story_v_out_926031", "926031064", "story_v_out_926031.awb") / 1000

					if var_260_31 + var_260_23 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_31 + var_260_23
					end

					if var_260_26.prefab_name ~= "" and arg_257_1.actors_[var_260_26.prefab_name] ~= nil then
						local var_260_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_26.prefab_name].transform, "story_v_out_926031", "926031064", "story_v_out_926031.awb")

						arg_257_1:RecordAudio("926031064", var_260_32)
						arg_257_1:RecordAudio("926031064", var_260_32)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_926031", "926031064", "story_v_out_926031.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_926031", "926031064", "story_v_out_926031.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_33 = math.max(var_260_24, arg_257_1.talkMaxDuration)

			if var_260_23 <= arg_257_1.time_ and arg_257_1.time_ < var_260_23 + var_260_33 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_23) / var_260_33

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_23 + var_260_33 and arg_257_1.time_ < var_260_23 + var_260_33 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play926031065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 926031065
		arg_261_1.duration_ = 7.6

		local var_261_0 = {
			zh = 6.166,
			ja = 7.6
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
				arg_261_0:Play926031066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.85

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[1296].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(926031065)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 34
				local var_264_6 = utf8.len(var_264_4)
				local var_264_7 = var_264_5 <= 0 and var_264_1 or var_264_1 * (var_264_6 / var_264_5)

				if var_264_7 > 0 and var_264_1 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_0
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031065", "story_v_out_926031.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031065", "story_v_out_926031.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_926031", "926031065", "story_v_out_926031.awb")

						arg_261_1:RecordAudio("926031065", var_264_9)
						arg_261_1:RecordAudio("926031065", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_926031", "926031065", "story_v_out_926031.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_926031", "926031065", "story_v_out_926031.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_10 and arg_261_1.time_ < var_264_0 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play926031066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 926031066
		arg_265_1.duration_ = 20.43

		local var_265_0 = {
			zh = 14.8,
			ja = 20.433
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
				arg_265_0:Play926031067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["104701"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos104701 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("104701", 4)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(372.4, -386.8, -295)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos104701, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_268_7 = 0
			local var_268_8 = 1.7

			if var_268_7 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_9 = arg_265_1:FormatText(StoryNameCfg[1296].name)

				arg_265_1.leftNameTxt_.text = var_268_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(926031066)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_12 = 68
				local var_268_13 = utf8.len(var_268_11)
				local var_268_14 = var_268_12 <= 0 and var_268_8 or var_268_8 * (var_268_13 / var_268_12)

				if var_268_14 > 0 and var_268_8 < var_268_14 then
					arg_265_1.talkMaxDuration = var_268_14

					if var_268_14 + var_268_7 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_7
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031066", "story_v_out_926031.awb") ~= 0 then
					local var_268_15 = manager.audio:GetVoiceLength("story_v_out_926031", "926031066", "story_v_out_926031.awb") / 1000

					if var_268_15 + var_268_7 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_15 + var_268_7
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_926031", "926031066", "story_v_out_926031.awb")

						arg_265_1:RecordAudio("926031066", var_268_16)
						arg_265_1:RecordAudio("926031066", var_268_16)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_926031", "926031066", "story_v_out_926031.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_926031", "926031066", "story_v_out_926031.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_17 = math.max(var_268_8, arg_265_1.talkMaxDuration)

			if var_268_7 <= arg_265_1.time_ and arg_265_1.time_ < var_268_7 + var_268_17 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_7) / var_268_17

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_7 + var_268_17 and arg_265_1.time_ < var_268_7 + var_268_17 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play926031067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 926031067
		arg_269_1.duration_ = 1

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"

			SetActive(arg_269_1.choicesGo_, true)

			for iter_270_0, iter_270_1 in ipairs(arg_269_1.choices_) do
				local var_270_0 = iter_270_0 <= 2

				SetActive(iter_270_1.go, var_270_0)
			end

			arg_269_1.choices_[1].txt.text = arg_269_1:FormatText(StoryChoiceCfg[1318].name)
			arg_269_1.choices_[2].txt.text = arg_269_1:FormatText(StoryChoiceCfg[1319].name)
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play926031068(arg_269_1)
			end

			if arg_271_0 == 2 then
				arg_269_0:Play926031069(arg_269_1)
			end

			arg_269_1:RecordChoiceLog(926031067, 1318, 1319)
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["104701"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps104701 == nil then
				arg_269_1.var_.actorSpriteComps104701 = var_272_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_2 = 0.2

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.actorSpriteComps104701 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								local var_272_4 = Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor2.r, var_272_3)
								local var_272_5 = Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor2.g, var_272_3)
								local var_272_6 = Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor2.b, var_272_3)

								iter_272_1.color = Color.New(var_272_4, var_272_5, var_272_6)
							else
								local var_272_7 = Mathf.Lerp(iter_272_1.color.r, 0.5, var_272_3)

								iter_272_1.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.actorSpriteComps104701 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_272_3 then
						if arg_269_1.isInRecall_ then
							iter_272_3.color = arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_272_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_269_1.var_.actorSpriteComps104701 = nil
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play926031068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 926031068
		arg_273_1.duration_ = 7.83

		local var_273_0 = {
			zh = 5.033,
			ja = 7.833
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play926031069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["128404"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps128404 == nil then
				arg_273_1.var_.actorSpriteComps128404 = var_276_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_2 = 0.2

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.actorSpriteComps128404 then
					for iter_276_0, iter_276_1 in pairs(arg_273_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_276_1 then
							if arg_273_1.isInRecall_ then
								local var_276_4 = Mathf.Lerp(iter_276_1.color.r, arg_273_1.hightColor1.r, var_276_3)
								local var_276_5 = Mathf.Lerp(iter_276_1.color.g, arg_273_1.hightColor1.g, var_276_3)
								local var_276_6 = Mathf.Lerp(iter_276_1.color.b, arg_273_1.hightColor1.b, var_276_3)

								iter_276_1.color = Color.New(var_276_4, var_276_5, var_276_6)
							else
								local var_276_7 = Mathf.Lerp(iter_276_1.color.r, 1, var_276_3)

								iter_276_1.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.actorSpriteComps128404 then
				for iter_276_2, iter_276_3 in pairs(arg_273_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_276_3 then
						if arg_273_1.isInRecall_ then
							iter_276_3.color = arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_276_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps128404 = nil
			end

			local var_276_8 = arg_273_1.actors_["104701"].transform
			local var_276_9 = 0

			if var_276_9 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1.var_.moveOldPos104701 = var_276_8.localPosition
				var_276_8.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("104701", 7)

				local var_276_10 = var_276_8.childCount

				for iter_276_4 = 0, var_276_10 - 1 do
					local var_276_11 = var_276_8:GetChild(iter_276_4)

					if var_276_11.name == "" or not string.find(var_276_11.name, "split") then
						var_276_11.gameObject:SetActive(true)
					else
						var_276_11.gameObject:SetActive(false)
					end
				end
			end

			local var_276_12 = 0.001

			if var_276_9 <= arg_273_1.time_ and arg_273_1.time_ < var_276_9 + var_276_12 then
				local var_276_13 = (arg_273_1.time_ - var_276_9) / var_276_12
				local var_276_14 = Vector3.New(0, -2000, 0)

				var_276_8.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos104701, var_276_14, var_276_13)
			end

			if arg_273_1.time_ >= var_276_9 + var_276_12 and arg_273_1.time_ < var_276_9 + var_276_12 + arg_276_0 then
				var_276_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_276_15 = arg_273_1.actors_["10144"].transform
			local var_276_16 = 0

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.var_.moveOldPos10144 = var_276_15.localPosition
				var_276_15.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10144", 7)

				local var_276_17 = var_276_15.childCount

				for iter_276_5 = 0, var_276_17 - 1 do
					local var_276_18 = var_276_15:GetChild(iter_276_5)

					if var_276_18.name == "" or not string.find(var_276_18.name, "split") then
						var_276_18.gameObject:SetActive(true)
					else
						var_276_18.gameObject:SetActive(false)
					end
				end
			end

			local var_276_19 = 0.001

			if var_276_16 <= arg_273_1.time_ and arg_273_1.time_ < var_276_16 + var_276_19 then
				local var_276_20 = (arg_273_1.time_ - var_276_16) / var_276_19
				local var_276_21 = Vector3.New(0, -2000, 0)

				var_276_15.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10144, var_276_21, var_276_20)
			end

			if arg_273_1.time_ >= var_276_16 + var_276_19 and arg_273_1.time_ < var_276_16 + var_276_19 + arg_276_0 then
				var_276_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_276_22 = arg_273_1.actors_["128404"].transform
			local var_276_23 = 0

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 then
				arg_273_1.var_.moveOldPos128404 = var_276_22.localPosition
				var_276_22.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("128404", 3)

				local var_276_24 = var_276_22.childCount

				for iter_276_6 = 0, var_276_24 - 1 do
					local var_276_25 = var_276_22:GetChild(iter_276_6)

					if var_276_25.name == "split_6" or not string.find(var_276_25.name, "split") then
						var_276_25.gameObject:SetActive(true)
					else
						var_276_25.gameObject:SetActive(false)
					end
				end
			end

			local var_276_26 = 0.001

			if var_276_23 <= arg_273_1.time_ and arg_273_1.time_ < var_276_23 + var_276_26 then
				local var_276_27 = (arg_273_1.time_ - var_276_23) / var_276_26
				local var_276_28 = Vector3.New(-16.1, -362, -375)

				var_276_22.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos128404, var_276_28, var_276_27)
			end

			if arg_273_1.time_ >= var_276_23 + var_276_26 and arg_273_1.time_ < var_276_23 + var_276_26 + arg_276_0 then
				var_276_22.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_276_29 = 0
			local var_276_30 = 0.625

			if var_276_29 < arg_273_1.time_ and arg_273_1.time_ <= var_276_29 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_31 = arg_273_1:FormatText(StoryNameCfg[6].name)

				arg_273_1.leftNameTxt_.text = var_276_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_32 = arg_273_1:GetWordFromCfg(926031068)
				local var_276_33 = arg_273_1:FormatText(var_276_32.content)

				arg_273_1.text_.text = var_276_33

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_34 = 25
				local var_276_35 = utf8.len(var_276_33)
				local var_276_36 = var_276_34 <= 0 and var_276_30 or var_276_30 * (var_276_35 / var_276_34)

				if var_276_36 > 0 and var_276_30 < var_276_36 then
					arg_273_1.talkMaxDuration = var_276_36

					if var_276_36 + var_276_29 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_36 + var_276_29
					end
				end

				arg_273_1.text_.text = var_276_33
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031068", "story_v_out_926031.awb") ~= 0 then
					local var_276_37 = manager.audio:GetVoiceLength("story_v_out_926031", "926031068", "story_v_out_926031.awb") / 1000

					if var_276_37 + var_276_29 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_37 + var_276_29
					end

					if var_276_32.prefab_name ~= "" and arg_273_1.actors_[var_276_32.prefab_name] ~= nil then
						local var_276_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_32.prefab_name].transform, "story_v_out_926031", "926031068", "story_v_out_926031.awb")

						arg_273_1:RecordAudio("926031068", var_276_38)
						arg_273_1:RecordAudio("926031068", var_276_38)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_926031", "926031068", "story_v_out_926031.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_926031", "926031068", "story_v_out_926031.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_39 = math.max(var_276_30, arg_273_1.talkMaxDuration)

			if var_276_29 <= arg_273_1.time_ and arg_273_1.time_ < var_276_29 + var_276_39 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_29) / var_276_39

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_29 + var_276_39 and arg_273_1.time_ < var_276_29 + var_276_39 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play926031069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 926031069
		arg_277_1.duration_ = 7.07

		local var_277_0 = {
			zh = 4,
			ja = 7.066
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play926031070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["106103"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps106103 == nil then
				arg_277_1.var_.actorSpriteComps106103 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps106103 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								local var_280_4 = Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor1.r, var_280_3)
								local var_280_5 = Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor1.g, var_280_3)
								local var_280_6 = Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor1.b, var_280_3)

								iter_280_1.color = Color.New(var_280_4, var_280_5, var_280_6)
							else
								local var_280_7 = Mathf.Lerp(iter_280_1.color.r, 1, var_280_3)

								iter_280_1.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps106103 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_280_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps106103 = nil
			end

			local var_280_8 = arg_277_1.actors_["128404"]
			local var_280_9 = 0

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps128404 == nil then
				arg_277_1.var_.actorSpriteComps128404 = var_280_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_10 = 0.2

			if var_280_9 <= arg_277_1.time_ and arg_277_1.time_ < var_280_9 + var_280_10 and not isNil(var_280_8) then
				local var_280_11 = (arg_277_1.time_ - var_280_9) / var_280_10

				if arg_277_1.var_.actorSpriteComps128404 then
					for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_280_5 then
							if arg_277_1.isInRecall_ then
								local var_280_12 = Mathf.Lerp(iter_280_5.color.r, arg_277_1.hightColor2.r, var_280_11)
								local var_280_13 = Mathf.Lerp(iter_280_5.color.g, arg_277_1.hightColor2.g, var_280_11)
								local var_280_14 = Mathf.Lerp(iter_280_5.color.b, arg_277_1.hightColor2.b, var_280_11)

								iter_280_5.color = Color.New(var_280_12, var_280_13, var_280_14)
							else
								local var_280_15 = Mathf.Lerp(iter_280_5.color.r, 0.5, var_280_11)

								iter_280_5.color = Color.New(var_280_15, var_280_15, var_280_15)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_9 + var_280_10 and arg_277_1.time_ < var_280_9 + var_280_10 + arg_280_0 and not isNil(var_280_8) and arg_277_1.var_.actorSpriteComps128404 then
				for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_280_7 then
						if arg_277_1.isInRecall_ then
							iter_280_7.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps128404 = nil
			end

			local var_280_16 = arg_277_1.actors_["128404"].transform
			local var_280_17 = 0

			if var_280_17 < arg_277_1.time_ and arg_277_1.time_ <= var_280_17 + arg_280_0 then
				arg_277_1.var_.moveOldPos128404 = var_280_16.localPosition
				var_280_16.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("128404", 4)

				local var_280_18 = var_280_16.childCount

				for iter_280_8 = 0, var_280_18 - 1 do
					local var_280_19 = var_280_16:GetChild(iter_280_8)

					if var_280_19.name == "split_6" or not string.find(var_280_19.name, "split") then
						var_280_19.gameObject:SetActive(true)
					else
						var_280_19.gameObject:SetActive(false)
					end
				end
			end

			local var_280_20 = 0.001

			if var_280_17 <= arg_277_1.time_ and arg_277_1.time_ < var_280_17 + var_280_20 then
				local var_280_21 = (arg_277_1.time_ - var_280_17) / var_280_20
				local var_280_22 = Vector3.New(390.2, -356, -362.3)

				var_280_16.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos128404, var_280_22, var_280_21)
			end

			if arg_277_1.time_ >= var_280_17 + var_280_20 and arg_277_1.time_ < var_280_17 + var_280_20 + arg_280_0 then
				var_280_16.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_280_23 = arg_277_1.actors_["106103"].transform
			local var_280_24 = 0

			if var_280_24 < arg_277_1.time_ and arg_277_1.time_ <= var_280_24 + arg_280_0 then
				arg_277_1.var_.moveOldPos106103 = var_280_23.localPosition
				var_280_23.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("106103", 2)

				local var_280_25 = var_280_23.childCount

				for iter_280_9 = 0, var_280_25 - 1 do
					local var_280_26 = var_280_23:GetChild(iter_280_9)

					if var_280_26.name == "" or not string.find(var_280_26.name, "split") then
						var_280_26.gameObject:SetActive(true)
					else
						var_280_26.gameObject:SetActive(false)
					end
				end
			end

			local var_280_27 = 0.001

			if var_280_24 <= arg_277_1.time_ and arg_277_1.time_ < var_280_24 + var_280_27 then
				local var_280_28 = (arg_277_1.time_ - var_280_24) / var_280_27
				local var_280_29 = Vector3.New(-428.4, -398.2, -333.7)

				var_280_23.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos106103, var_280_29, var_280_28)
			end

			if arg_277_1.time_ >= var_280_24 + var_280_27 and arg_277_1.time_ < var_280_24 + var_280_27 + arg_280_0 then
				var_280_23.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_280_30 = 0
			local var_280_31 = 0.525

			if var_280_30 < arg_277_1.time_ and arg_277_1.time_ <= var_280_30 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_32 = arg_277_1:FormatText(StoryNameCfg[612].name)

				arg_277_1.leftNameTxt_.text = var_280_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_33 = arg_277_1:GetWordFromCfg(926031069)
				local var_280_34 = arg_277_1:FormatText(var_280_33.content)

				arg_277_1.text_.text = var_280_34

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_35 = 21
				local var_280_36 = utf8.len(var_280_34)
				local var_280_37 = var_280_35 <= 0 and var_280_31 or var_280_31 * (var_280_36 / var_280_35)

				if var_280_37 > 0 and var_280_31 < var_280_37 then
					arg_277_1.talkMaxDuration = var_280_37

					if var_280_37 + var_280_30 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_37 + var_280_30
					end
				end

				arg_277_1.text_.text = var_280_34
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031069", "story_v_out_926031.awb") ~= 0 then
					local var_280_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031069", "story_v_out_926031.awb") / 1000

					if var_280_38 + var_280_30 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_38 + var_280_30
					end

					if var_280_33.prefab_name ~= "" and arg_277_1.actors_[var_280_33.prefab_name] ~= nil then
						local var_280_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_33.prefab_name].transform, "story_v_out_926031", "926031069", "story_v_out_926031.awb")

						arg_277_1:RecordAudio("926031069", var_280_39)
						arg_277_1:RecordAudio("926031069", var_280_39)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_926031", "926031069", "story_v_out_926031.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_926031", "926031069", "story_v_out_926031.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_40 = math.max(var_280_31, arg_277_1.talkMaxDuration)

			if var_280_30 <= arg_277_1.time_ and arg_277_1.time_ < var_280_30 + var_280_40 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_30) / var_280_40

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_30 + var_280_40 and arg_277_1.time_ < var_280_30 + var_280_40 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play926031070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 926031070
		arg_281_1.duration_ = 4.07

		local var_281_0 = {
			zh = 2.433,
			ja = 4.066
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
				arg_281_0:Play926031071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["128404"]
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps128404 == nil then
				arg_281_1.var_.actorSpriteComps128404 = var_284_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_2 = 0.2

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 and not isNil(var_284_0) then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2

				if arg_281_1.var_.actorSpriteComps128404 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.actorSpriteComps128404 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_284_3 then
						if arg_281_1.isInRecall_ then
							iter_284_3.color = arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_284_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps128404 = nil
			end

			local var_284_8 = arg_281_1.actors_["106103"]
			local var_284_9 = 0

			if var_284_9 < arg_281_1.time_ and arg_281_1.time_ <= var_284_9 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps106103 == nil then
				arg_281_1.var_.actorSpriteComps106103 = var_284_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_10 = 0.2

			if var_284_9 <= arg_281_1.time_ and arg_281_1.time_ < var_284_9 + var_284_10 and not isNil(var_284_8) then
				local var_284_11 = (arg_281_1.time_ - var_284_9) / var_284_10

				if arg_281_1.var_.actorSpriteComps106103 then
					for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_284_5 then
							if arg_281_1.isInRecall_ then
								local var_284_12 = Mathf.Lerp(iter_284_5.color.r, arg_281_1.hightColor2.r, var_284_11)
								local var_284_13 = Mathf.Lerp(iter_284_5.color.g, arg_281_1.hightColor2.g, var_284_11)
								local var_284_14 = Mathf.Lerp(iter_284_5.color.b, arg_281_1.hightColor2.b, var_284_11)

								iter_284_5.color = Color.New(var_284_12, var_284_13, var_284_14)
							else
								local var_284_15 = Mathf.Lerp(iter_284_5.color.r, 0.5, var_284_11)

								iter_284_5.color = Color.New(var_284_15, var_284_15, var_284_15)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= var_284_9 + var_284_10 and arg_281_1.time_ < var_284_9 + var_284_10 + arg_284_0 and not isNil(var_284_8) and arg_281_1.var_.actorSpriteComps106103 then
				for iter_284_6, iter_284_7 in pairs(arg_281_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_284_7 then
						if arg_281_1.isInRecall_ then
							iter_284_7.color = arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_284_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_281_1.var_.actorSpriteComps106103 = nil
			end

			local var_284_16 = 0
			local var_284_17 = 0.325

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_18 = arg_281_1:FormatText(StoryNameCfg[6].name)

				arg_281_1.leftNameTxt_.text = var_284_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_19 = arg_281_1:GetWordFromCfg(926031070)
				local var_284_20 = arg_281_1:FormatText(var_284_19.content)

				arg_281_1.text_.text = var_284_20

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_21 = 13
				local var_284_22 = utf8.len(var_284_20)
				local var_284_23 = var_284_21 <= 0 and var_284_17 or var_284_17 * (var_284_22 / var_284_21)

				if var_284_23 > 0 and var_284_17 < var_284_23 then
					arg_281_1.talkMaxDuration = var_284_23

					if var_284_23 + var_284_16 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_16
					end
				end

				arg_281_1.text_.text = var_284_20
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031070", "story_v_out_926031.awb") ~= 0 then
					local var_284_24 = manager.audio:GetVoiceLength("story_v_out_926031", "926031070", "story_v_out_926031.awb") / 1000

					if var_284_24 + var_284_16 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_24 + var_284_16
					end

					if var_284_19.prefab_name ~= "" and arg_281_1.actors_[var_284_19.prefab_name] ~= nil then
						local var_284_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_19.prefab_name].transform, "story_v_out_926031", "926031070", "story_v_out_926031.awb")

						arg_281_1:RecordAudio("926031070", var_284_25)
						arg_281_1:RecordAudio("926031070", var_284_25)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_926031", "926031070", "story_v_out_926031.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_926031", "926031070", "story_v_out_926031.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_26 = math.max(var_284_17, arg_281_1.talkMaxDuration)

			if var_284_16 <= arg_281_1.time_ and arg_281_1.time_ < var_284_16 + var_284_26 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_16) / var_284_26

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_16 + var_284_26 and arg_281_1.time_ < var_284_16 + var_284_26 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play926031071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 926031071
		arg_285_1.duration_ = 10.6

		local var_285_0 = {
			zh = 8.466,
			ja = 10.6
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
				arg_285_0:Play926031072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["106103"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps106103 == nil then
				arg_285_1.var_.actorSpriteComps106103 = var_288_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_2 = 0.2

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.actorSpriteComps106103 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								local var_288_4 = Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor1.r, var_288_3)
								local var_288_5 = Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor1.g, var_288_3)
								local var_288_6 = Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor1.b, var_288_3)

								iter_288_1.color = Color.New(var_288_4, var_288_5, var_288_6)
							else
								local var_288_7 = Mathf.Lerp(iter_288_1.color.r, 1, var_288_3)

								iter_288_1.color = Color.New(var_288_7, var_288_7, var_288_7)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.actorSpriteComps106103 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_288_3 then
						if arg_285_1.isInRecall_ then
							iter_288_3.color = arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_288_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps106103 = nil
			end

			local var_288_8 = arg_285_1.actors_["128404"]
			local var_288_9 = 0

			if var_288_9 < arg_285_1.time_ and arg_285_1.time_ <= var_288_9 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps128404 == nil then
				arg_285_1.var_.actorSpriteComps128404 = var_288_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_10 = 0.2

			if var_288_9 <= arg_285_1.time_ and arg_285_1.time_ < var_288_9 + var_288_10 and not isNil(var_288_8) then
				local var_288_11 = (arg_285_1.time_ - var_288_9) / var_288_10

				if arg_285_1.var_.actorSpriteComps128404 then
					for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_288_5 then
							if arg_285_1.isInRecall_ then
								local var_288_12 = Mathf.Lerp(iter_288_5.color.r, arg_285_1.hightColor2.r, var_288_11)
								local var_288_13 = Mathf.Lerp(iter_288_5.color.g, arg_285_1.hightColor2.g, var_288_11)
								local var_288_14 = Mathf.Lerp(iter_288_5.color.b, arg_285_1.hightColor2.b, var_288_11)

								iter_288_5.color = Color.New(var_288_12, var_288_13, var_288_14)
							else
								local var_288_15 = Mathf.Lerp(iter_288_5.color.r, 0.5, var_288_11)

								iter_288_5.color = Color.New(var_288_15, var_288_15, var_288_15)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= var_288_9 + var_288_10 and arg_285_1.time_ < var_288_9 + var_288_10 + arg_288_0 and not isNil(var_288_8) and arg_285_1.var_.actorSpriteComps128404 then
				for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_288_7 then
						if arg_285_1.isInRecall_ then
							iter_288_7.color = arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_288_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_285_1.var_.actorSpriteComps128404 = nil
			end

			local var_288_16 = arg_285_1.actors_["106103"].transform
			local var_288_17 = 0

			if var_288_17 < arg_285_1.time_ and arg_285_1.time_ <= var_288_17 + arg_288_0 then
				arg_285_1.var_.moveOldPos106103 = var_288_16.localPosition
				var_288_16.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("106103", 2)

				local var_288_18 = var_288_16.childCount

				for iter_288_8 = 0, var_288_18 - 1 do
					local var_288_19 = var_288_16:GetChild(iter_288_8)

					if var_288_19.name == "split_4" or not string.find(var_288_19.name, "split") then
						var_288_19.gameObject:SetActive(true)
					else
						var_288_19.gameObject:SetActive(false)
					end
				end
			end

			local var_288_20 = 0.001

			if var_288_17 <= arg_285_1.time_ and arg_285_1.time_ < var_288_17 + var_288_20 then
				local var_288_21 = (arg_285_1.time_ - var_288_17) / var_288_20
				local var_288_22 = Vector3.New(-428.4, -398.2, -333.7)

				var_288_16.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos106103, var_288_22, var_288_21)
			end

			if arg_285_1.time_ >= var_288_17 + var_288_20 and arg_285_1.time_ < var_288_17 + var_288_20 + arg_288_0 then
				var_288_16.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_288_23 = 0
			local var_288_24 = 0.8

			if var_288_23 < arg_285_1.time_ and arg_285_1.time_ <= var_288_23 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_25 = arg_285_1:FormatText(StoryNameCfg[612].name)

				arg_285_1.leftNameTxt_.text = var_288_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_26 = arg_285_1:GetWordFromCfg(926031071)
				local var_288_27 = arg_285_1:FormatText(var_288_26.content)

				arg_285_1.text_.text = var_288_27

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_28 = 32
				local var_288_29 = utf8.len(var_288_27)
				local var_288_30 = var_288_28 <= 0 and var_288_24 or var_288_24 * (var_288_29 / var_288_28)

				if var_288_30 > 0 and var_288_24 < var_288_30 then
					arg_285_1.talkMaxDuration = var_288_30

					if var_288_30 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_30 + var_288_23
					end
				end

				arg_285_1.text_.text = var_288_27
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031071", "story_v_out_926031.awb") ~= 0 then
					local var_288_31 = manager.audio:GetVoiceLength("story_v_out_926031", "926031071", "story_v_out_926031.awb") / 1000

					if var_288_31 + var_288_23 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_31 + var_288_23
					end

					if var_288_26.prefab_name ~= "" and arg_285_1.actors_[var_288_26.prefab_name] ~= nil then
						local var_288_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_26.prefab_name].transform, "story_v_out_926031", "926031071", "story_v_out_926031.awb")

						arg_285_1:RecordAudio("926031071", var_288_32)
						arg_285_1:RecordAudio("926031071", var_288_32)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_926031", "926031071", "story_v_out_926031.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_926031", "926031071", "story_v_out_926031.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_33 = math.max(var_288_24, arg_285_1.talkMaxDuration)

			if var_288_23 <= arg_285_1.time_ and arg_285_1.time_ < var_288_23 + var_288_33 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_23) / var_288_33

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_23 + var_288_33 and arg_285_1.time_ < var_288_23 + var_288_33 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play926031072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 926031072
		arg_289_1.duration_ = 6.1

		local var_289_0 = {
			zh = 5.633,
			ja = 6.1
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play926031073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.6

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[612].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:GetWordFromCfg(926031072)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 24
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031072", "story_v_out_926031.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031072", "story_v_out_926031.awb") / 1000

					if var_292_8 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_0
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_out_926031", "926031072", "story_v_out_926031.awb")

						arg_289_1:RecordAudio("926031072", var_292_9)
						arg_289_1:RecordAudio("926031072", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_926031", "926031072", "story_v_out_926031.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_926031", "926031072", "story_v_out_926031.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_10 and arg_289_1.time_ < var_292_0 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play926031073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 926031073
		arg_293_1.duration_ = 2.57

		local var_293_0 = {
			zh = 2.466,
			ja = 2.566
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
				arg_293_0:Play926031074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["104701"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps104701 == nil then
				arg_293_1.var_.actorSpriteComps104701 = var_296_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_2 = 0.2

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.actorSpriteComps104701 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.actorSpriteComps104701 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_296_3 then
						if arg_293_1.isInRecall_ then
							iter_296_3.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_296_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps104701 = nil
			end

			local var_296_8 = arg_293_1.actors_["106103"]
			local var_296_9 = 0

			if var_296_9 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.actorSpriteComps106103 == nil then
				arg_293_1.var_.actorSpriteComps106103 = var_296_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_10 = 0.2

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_10 and not isNil(var_296_8) then
				local var_296_11 = (arg_293_1.time_ - var_296_9) / var_296_10

				if arg_293_1.var_.actorSpriteComps106103 then
					for iter_296_4, iter_296_5 in pairs(arg_293_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_296_5 then
							if arg_293_1.isInRecall_ then
								local var_296_12 = Mathf.Lerp(iter_296_5.color.r, arg_293_1.hightColor2.r, var_296_11)
								local var_296_13 = Mathf.Lerp(iter_296_5.color.g, arg_293_1.hightColor2.g, var_296_11)
								local var_296_14 = Mathf.Lerp(iter_296_5.color.b, arg_293_1.hightColor2.b, var_296_11)

								iter_296_5.color = Color.New(var_296_12, var_296_13, var_296_14)
							else
								local var_296_15 = Mathf.Lerp(iter_296_5.color.r, 0.5, var_296_11)

								iter_296_5.color = Color.New(var_296_15, var_296_15, var_296_15)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= var_296_9 + var_296_10 and arg_293_1.time_ < var_296_9 + var_296_10 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.actorSpriteComps106103 then
				for iter_296_6, iter_296_7 in pairs(arg_293_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_296_7 then
						if arg_293_1.isInRecall_ then
							iter_296_7.color = arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_296_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_293_1.var_.actorSpriteComps106103 = nil
			end

			local var_296_16 = arg_293_1.actors_["106103"].transform
			local var_296_17 = 0

			if var_296_17 < arg_293_1.time_ and arg_293_1.time_ <= var_296_17 + arg_296_0 then
				arg_293_1.var_.moveOldPos106103 = var_296_16.localPosition
				var_296_16.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("106103", 7)

				local var_296_18 = var_296_16.childCount

				for iter_296_8 = 0, var_296_18 - 1 do
					local var_296_19 = var_296_16:GetChild(iter_296_8)

					if var_296_19.name == "" or not string.find(var_296_19.name, "split") then
						var_296_19.gameObject:SetActive(true)
					else
						var_296_19.gameObject:SetActive(false)
					end
				end
			end

			local var_296_20 = 0.001

			if var_296_17 <= arg_293_1.time_ and arg_293_1.time_ < var_296_17 + var_296_20 then
				local var_296_21 = (arg_293_1.time_ - var_296_17) / var_296_20
				local var_296_22 = Vector3.New(0, -2000, 0)

				var_296_16.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos106103, var_296_22, var_296_21)
			end

			if arg_293_1.time_ >= var_296_17 + var_296_20 and arg_293_1.time_ < var_296_17 + var_296_20 + arg_296_0 then
				var_296_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_296_23 = arg_293_1.actors_["128404"].transform
			local var_296_24 = 0

			if var_296_24 < arg_293_1.time_ and arg_293_1.time_ <= var_296_24 + arg_296_0 then
				arg_293_1.var_.moveOldPos128404 = var_296_23.localPosition
				var_296_23.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("128404", 7)

				local var_296_25 = var_296_23.childCount

				for iter_296_9 = 0, var_296_25 - 1 do
					local var_296_26 = var_296_23:GetChild(iter_296_9)

					if var_296_26.name == "" or not string.find(var_296_26.name, "split") then
						var_296_26.gameObject:SetActive(true)
					else
						var_296_26.gameObject:SetActive(false)
					end
				end
			end

			local var_296_27 = 0.001

			if var_296_24 <= arg_293_1.time_ and arg_293_1.time_ < var_296_24 + var_296_27 then
				local var_296_28 = (arg_293_1.time_ - var_296_24) / var_296_27
				local var_296_29 = Vector3.New(0, -2000, 0)

				var_296_23.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos128404, var_296_29, var_296_28)
			end

			if arg_293_1.time_ >= var_296_24 + var_296_27 and arg_293_1.time_ < var_296_24 + var_296_27 + arg_296_0 then
				var_296_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_296_30 = arg_293_1.actors_["104701"].transform
			local var_296_31 = 0

			if var_296_31 < arg_293_1.time_ and arg_293_1.time_ <= var_296_31 + arg_296_0 then
				arg_293_1.var_.moveOldPos104701 = var_296_30.localPosition
				var_296_30.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("104701", 2)

				local var_296_32 = var_296_30.childCount

				for iter_296_10 = 0, var_296_32 - 1 do
					local var_296_33 = var_296_30:GetChild(iter_296_10)

					if var_296_33.name == "" or not string.find(var_296_33.name, "split") then
						var_296_33.gameObject:SetActive(true)
					else
						var_296_33.gameObject:SetActive(false)
					end
				end
			end

			local var_296_34 = 0.001

			if var_296_31 <= arg_293_1.time_ and arg_293_1.time_ < var_296_31 + var_296_34 then
				local var_296_35 = (arg_293_1.time_ - var_296_31) / var_296_34
				local var_296_36 = Vector3.New(-528.7, -386.8, -295)

				var_296_30.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos104701, var_296_36, var_296_35)
			end

			if arg_293_1.time_ >= var_296_31 + var_296_34 and arg_293_1.time_ < var_296_31 + var_296_34 + arg_296_0 then
				var_296_30.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_296_37 = 0
			local var_296_38 = 0.275

			if var_296_37 < arg_293_1.time_ and arg_293_1.time_ <= var_296_37 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_39 = arg_293_1:FormatText(StoryNameCfg[1296].name)

				arg_293_1.leftNameTxt_.text = var_296_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_40 = arg_293_1:GetWordFromCfg(926031073)
				local var_296_41 = arg_293_1:FormatText(var_296_40.content)

				arg_293_1.text_.text = var_296_41

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_42 = 11
				local var_296_43 = utf8.len(var_296_41)
				local var_296_44 = var_296_42 <= 0 and var_296_38 or var_296_38 * (var_296_43 / var_296_42)

				if var_296_44 > 0 and var_296_38 < var_296_44 then
					arg_293_1.talkMaxDuration = var_296_44

					if var_296_44 + var_296_37 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_44 + var_296_37
					end
				end

				arg_293_1.text_.text = var_296_41
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031073", "story_v_out_926031.awb") ~= 0 then
					local var_296_45 = manager.audio:GetVoiceLength("story_v_out_926031", "926031073", "story_v_out_926031.awb") / 1000

					if var_296_45 + var_296_37 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_45 + var_296_37
					end

					if var_296_40.prefab_name ~= "" and arg_293_1.actors_[var_296_40.prefab_name] ~= nil then
						local var_296_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_40.prefab_name].transform, "story_v_out_926031", "926031073", "story_v_out_926031.awb")

						arg_293_1:RecordAudio("926031073", var_296_46)
						arg_293_1:RecordAudio("926031073", var_296_46)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_926031", "926031073", "story_v_out_926031.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_926031", "926031073", "story_v_out_926031.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_47 = math.max(var_296_38, arg_293_1.talkMaxDuration)

			if var_296_37 <= arg_293_1.time_ and arg_293_1.time_ < var_296_37 + var_296_47 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_37) / var_296_47

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_37 + var_296_47 and arg_293_1.time_ < var_296_37 + var_296_47 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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
				actorName = "104701",
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
	Play926031074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 926031074
		arg_297_1.duration_ = 6.4

		local var_297_0 = {
			zh = 4.9,
			ja = 6.4
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play926031075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10144"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps10144 == nil then
				arg_297_1.var_.actorSpriteComps10144 = var_300_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_2 = 0.2

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.actorSpriteComps10144 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								local var_300_4 = Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor1.r, var_300_3)
								local var_300_5 = Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor1.g, var_300_3)
								local var_300_6 = Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor1.b, var_300_3)

								iter_300_1.color = Color.New(var_300_4, var_300_5, var_300_6)
							else
								local var_300_7 = Mathf.Lerp(iter_300_1.color.r, 1, var_300_3)

								iter_300_1.color = Color.New(var_300_7, var_300_7, var_300_7)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.actorSpriteComps10144 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_300_3 then
						if arg_297_1.isInRecall_ then
							iter_300_3.color = arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_300_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps10144 = nil
			end

			local var_300_8 = arg_297_1.actors_["104701"]
			local var_300_9 = 0

			if var_300_9 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps104701 == nil then
				arg_297_1.var_.actorSpriteComps104701 = var_300_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_10 = 0.2

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_10 and not isNil(var_300_8) then
				local var_300_11 = (arg_297_1.time_ - var_300_9) / var_300_10

				if arg_297_1.var_.actorSpriteComps104701 then
					for iter_300_4, iter_300_5 in pairs(arg_297_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_300_5 then
							if arg_297_1.isInRecall_ then
								local var_300_12 = Mathf.Lerp(iter_300_5.color.r, arg_297_1.hightColor2.r, var_300_11)
								local var_300_13 = Mathf.Lerp(iter_300_5.color.g, arg_297_1.hightColor2.g, var_300_11)
								local var_300_14 = Mathf.Lerp(iter_300_5.color.b, arg_297_1.hightColor2.b, var_300_11)

								iter_300_5.color = Color.New(var_300_12, var_300_13, var_300_14)
							else
								local var_300_15 = Mathf.Lerp(iter_300_5.color.r, 0.5, var_300_11)

								iter_300_5.color = Color.New(var_300_15, var_300_15, var_300_15)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= var_300_9 + var_300_10 and arg_297_1.time_ < var_300_9 + var_300_10 + arg_300_0 and not isNil(var_300_8) and arg_297_1.var_.actorSpriteComps104701 then
				for iter_300_6, iter_300_7 in pairs(arg_297_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_300_7 then
						if arg_297_1.isInRecall_ then
							iter_300_7.color = arg_297_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_300_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_297_1.var_.actorSpriteComps104701 = nil
			end

			local var_300_16 = arg_297_1.actors_["10144"].transform
			local var_300_17 = 0

			if var_300_17 < arg_297_1.time_ and arg_297_1.time_ <= var_300_17 + arg_300_0 then
				arg_297_1.var_.moveOldPos10144 = var_300_16.localPosition
				var_300_16.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("10144", 4)

				local var_300_18 = var_300_16.childCount

				for iter_300_8 = 0, var_300_18 - 1 do
					local var_300_19 = var_300_16:GetChild(iter_300_8)

					if var_300_19.name == "split_7" or not string.find(var_300_19.name, "split") then
						var_300_19.gameObject:SetActive(true)
					else
						var_300_19.gameObject:SetActive(false)
					end
				end
			end

			local var_300_20 = 0.001

			if var_300_17 <= arg_297_1.time_ and arg_297_1.time_ < var_300_17 + var_300_20 then
				local var_300_21 = (arg_297_1.time_ - var_300_17) / var_300_20
				local var_300_22 = Vector3.New(435.8, -381.1, -285.9)

				var_300_16.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10144, var_300_22, var_300_21)
			end

			if arg_297_1.time_ >= var_300_17 + var_300_20 and arg_297_1.time_ < var_300_17 + var_300_20 + arg_300_0 then
				var_300_16.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_300_23 = 0
			local var_300_24 = 0.55

			if var_300_23 < arg_297_1.time_ and arg_297_1.time_ <= var_300_23 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_25 = arg_297_1:FormatText(StoryNameCfg[1297].name)

				arg_297_1.leftNameTxt_.text = var_300_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_26 = arg_297_1:GetWordFromCfg(926031074)
				local var_300_27 = arg_297_1:FormatText(var_300_26.content)

				arg_297_1.text_.text = var_300_27

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_28 = 22
				local var_300_29 = utf8.len(var_300_27)
				local var_300_30 = var_300_28 <= 0 and var_300_24 or var_300_24 * (var_300_29 / var_300_28)

				if var_300_30 > 0 and var_300_24 < var_300_30 then
					arg_297_1.talkMaxDuration = var_300_30

					if var_300_30 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_30 + var_300_23
					end
				end

				arg_297_1.text_.text = var_300_27
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031074", "story_v_out_926031.awb") ~= 0 then
					local var_300_31 = manager.audio:GetVoiceLength("story_v_out_926031", "926031074", "story_v_out_926031.awb") / 1000

					if var_300_31 + var_300_23 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_31 + var_300_23
					end

					if var_300_26.prefab_name ~= "" and arg_297_1.actors_[var_300_26.prefab_name] ~= nil then
						local var_300_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_26.prefab_name].transform, "story_v_out_926031", "926031074", "story_v_out_926031.awb")

						arg_297_1:RecordAudio("926031074", var_300_32)
						arg_297_1:RecordAudio("926031074", var_300_32)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_926031", "926031074", "story_v_out_926031.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_926031", "926031074", "story_v_out_926031.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_33 = math.max(var_300_24, arg_297_1.talkMaxDuration)

			if var_300_23 <= arg_297_1.time_ and arg_297_1.time_ < var_300_23 + var_300_33 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_23) / var_300_33

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_23 + var_300_33 and arg_297_1.time_ < var_300_23 + var_300_33 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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

		arg_297_1:InitPlayNodeList()
	end,
	Play926031075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 926031075
		arg_301_1.duration_ = 6.4

		local var_301_0 = {
			zh = 4.266,
			ja = 6.4
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
				arg_301_0:Play926031076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.55

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[1297].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(926031075)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 22
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031075", "story_v_out_926031.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_926031", "926031075", "story_v_out_926031.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_926031", "926031075", "story_v_out_926031.awb")

						arg_301_1:RecordAudio("926031075", var_304_9)
						arg_301_1:RecordAudio("926031075", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_926031", "926031075", "story_v_out_926031.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_926031", "926031075", "story_v_out_926031.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play926031076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 926031076
		arg_305_1.duration_ = 5.03

		local var_305_0 = {
			zh = 3,
			ja = 5.033
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
				arg_305_0:Play926031077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["106103"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps106103 == nil then
				arg_305_1.var_.actorSpriteComps106103 = var_308_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_2 = 0.2

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.actorSpriteComps106103 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.actorSpriteComps106103 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_308_3 then
						if arg_305_1.isInRecall_ then
							iter_308_3.color = arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_308_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps106103 = nil
			end

			local var_308_8 = arg_305_1.actors_["10144"]
			local var_308_9 = 0

			if var_308_9 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps10144 == nil then
				arg_305_1.var_.actorSpriteComps10144 = var_308_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_10 = 0.2

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_10 and not isNil(var_308_8) then
				local var_308_11 = (arg_305_1.time_ - var_308_9) / var_308_10

				if arg_305_1.var_.actorSpriteComps10144 then
					for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_305_1.time_ >= var_308_9 + var_308_10 and arg_305_1.time_ < var_308_9 + var_308_10 + arg_308_0 and not isNil(var_308_8) and arg_305_1.var_.actorSpriteComps10144 then
				for iter_308_6, iter_308_7 in pairs(arg_305_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_308_7 then
						if arg_305_1.isInRecall_ then
							iter_308_7.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10144 = nil
			end

			local var_308_16 = 0
			local var_308_17 = 0.3

			if var_308_16 < arg_305_1.time_ and arg_305_1.time_ <= var_308_16 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_18 = arg_305_1:FormatText(StoryNameCfg[612].name)

				arg_305_1.leftNameTxt_.text = var_308_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_19 = arg_305_1:GetWordFromCfg(926031076)
				local var_308_20 = arg_305_1:FormatText(var_308_19.content)

				arg_305_1.text_.text = var_308_20

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_21 = 12
				local var_308_22 = utf8.len(var_308_20)
				local var_308_23 = var_308_21 <= 0 and var_308_17 or var_308_17 * (var_308_22 / var_308_21)

				if var_308_23 > 0 and var_308_17 < var_308_23 then
					arg_305_1.talkMaxDuration = var_308_23

					if var_308_23 + var_308_16 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_23 + var_308_16
					end
				end

				arg_305_1.text_.text = var_308_20
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031076", "story_v_out_926031.awb") ~= 0 then
					local var_308_24 = manager.audio:GetVoiceLength("story_v_out_926031", "926031076", "story_v_out_926031.awb") / 1000

					if var_308_24 + var_308_16 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_24 + var_308_16
					end

					if var_308_19.prefab_name ~= "" and arg_305_1.actors_[var_308_19.prefab_name] ~= nil then
						local var_308_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_19.prefab_name].transform, "story_v_out_926031", "926031076", "story_v_out_926031.awb")

						arg_305_1:RecordAudio("926031076", var_308_25)
						arg_305_1:RecordAudio("926031076", var_308_25)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_926031", "926031076", "story_v_out_926031.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_926031", "926031076", "story_v_out_926031.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_26 = math.max(var_308_17, arg_305_1.talkMaxDuration)

			if var_308_16 <= arg_305_1.time_ and arg_305_1.time_ < var_308_16 + var_308_26 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_16) / var_308_26

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_16 + var_308_26 and arg_305_1.time_ < var_308_16 + var_308_26 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play926031077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 926031077
		arg_309_1.duration_ = 3.2

		local var_309_0 = {
			zh = 2.3,
			ja = 3.2
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play926031078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["104701"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps104701 == nil then
				arg_309_1.var_.actorSpriteComps104701 = var_312_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_2 = 0.2

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.actorSpriteComps104701 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								local var_312_4 = Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor1.r, var_312_3)
								local var_312_5 = Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor1.g, var_312_3)
								local var_312_6 = Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor1.b, var_312_3)

								iter_312_1.color = Color.New(var_312_4, var_312_5, var_312_6)
							else
								local var_312_7 = Mathf.Lerp(iter_312_1.color.r, 1, var_312_3)

								iter_312_1.color = Color.New(var_312_7, var_312_7, var_312_7)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.actorSpriteComps104701 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_312_3 then
						if arg_309_1.isInRecall_ then
							iter_312_3.color = arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_312_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps104701 = nil
			end

			local var_312_8 = arg_309_1.actors_["106103"]
			local var_312_9 = 0

			if var_312_9 < arg_309_1.time_ and arg_309_1.time_ <= var_312_9 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps106103 == nil then
				arg_309_1.var_.actorSpriteComps106103 = var_312_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_10 = 0.2

			if var_312_9 <= arg_309_1.time_ and arg_309_1.time_ < var_312_9 + var_312_10 and not isNil(var_312_8) then
				local var_312_11 = (arg_309_1.time_ - var_312_9) / var_312_10

				if arg_309_1.var_.actorSpriteComps106103 then
					for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_312_5 then
							if arg_309_1.isInRecall_ then
								local var_312_12 = Mathf.Lerp(iter_312_5.color.r, arg_309_1.hightColor2.r, var_312_11)
								local var_312_13 = Mathf.Lerp(iter_312_5.color.g, arg_309_1.hightColor2.g, var_312_11)
								local var_312_14 = Mathf.Lerp(iter_312_5.color.b, arg_309_1.hightColor2.b, var_312_11)

								iter_312_5.color = Color.New(var_312_12, var_312_13, var_312_14)
							else
								local var_312_15 = Mathf.Lerp(iter_312_5.color.r, 0.5, var_312_11)

								iter_312_5.color = Color.New(var_312_15, var_312_15, var_312_15)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= var_312_9 + var_312_10 and arg_309_1.time_ < var_312_9 + var_312_10 + arg_312_0 and not isNil(var_312_8) and arg_309_1.var_.actorSpriteComps106103 then
				for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_312_7 then
						if arg_309_1.isInRecall_ then
							iter_312_7.color = arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_312_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_309_1.var_.actorSpriteComps106103 = nil
			end

			local var_312_16 = 0
			local var_312_17 = 0.25

			if var_312_16 < arg_309_1.time_ and arg_309_1.time_ <= var_312_16 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_18 = arg_309_1:FormatText(StoryNameCfg[1296].name)

				arg_309_1.leftNameTxt_.text = var_312_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_19 = arg_309_1:GetWordFromCfg(926031077)
				local var_312_20 = arg_309_1:FormatText(var_312_19.content)

				arg_309_1.text_.text = var_312_20

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_21 = 10
				local var_312_22 = utf8.len(var_312_20)
				local var_312_23 = var_312_21 <= 0 and var_312_17 or var_312_17 * (var_312_22 / var_312_21)

				if var_312_23 > 0 and var_312_17 < var_312_23 then
					arg_309_1.talkMaxDuration = var_312_23

					if var_312_23 + var_312_16 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_23 + var_312_16
					end
				end

				arg_309_1.text_.text = var_312_20
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031077", "story_v_out_926031.awb") ~= 0 then
					local var_312_24 = manager.audio:GetVoiceLength("story_v_out_926031", "926031077", "story_v_out_926031.awb") / 1000

					if var_312_24 + var_312_16 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_24 + var_312_16
					end

					if var_312_19.prefab_name ~= "" and arg_309_1.actors_[var_312_19.prefab_name] ~= nil then
						local var_312_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_19.prefab_name].transform, "story_v_out_926031", "926031077", "story_v_out_926031.awb")

						arg_309_1:RecordAudio("926031077", var_312_25)
						arg_309_1:RecordAudio("926031077", var_312_25)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_926031", "926031077", "story_v_out_926031.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_926031", "926031077", "story_v_out_926031.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_26 = math.max(var_312_17, arg_309_1.talkMaxDuration)

			if var_312_16 <= arg_309_1.time_ and arg_309_1.time_ < var_312_16 + var_312_26 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_16) / var_312_26

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_16 + var_312_26 and arg_309_1.time_ < var_312_16 + var_312_26 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play926031078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 926031078
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play926031079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["104701"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps104701 == nil then
				arg_313_1.var_.actorSpriteComps104701 = var_316_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_2 = 0.2

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.actorSpriteComps104701 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.actorSpriteComps104701 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_316_3 then
						if arg_313_1.isInRecall_ then
							iter_316_3.color = arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_316_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps104701 = nil
			end

			local var_316_8 = 0
			local var_316_9 = 0.4

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

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_11 = arg_313_1:GetWordFromCfg(926031078)
				local var_316_12 = arg_313_1:FormatText(var_316_11.content)

				arg_313_1.text_.text = var_316_12

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_13 = 16
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
	Play926031079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 926031079
		arg_317_1.duration_ = 1

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"

			SetActive(arg_317_1.choicesGo_, true)

			for iter_318_0, iter_318_1 in ipairs(arg_317_1.choices_) do
				local var_318_0 = iter_318_0 <= 3

				SetActive(iter_318_1.go, var_318_0)
			end

			arg_317_1.choices_[1].txt.text = arg_317_1:FormatText(StoryChoiceCfg[1320].name)
			arg_317_1.choices_[2].txt.text = arg_317_1:FormatText(StoryChoiceCfg[1321].name)
			arg_317_1.choices_[3].txt.text = arg_317_1:FormatText(StoryChoiceCfg[1322].name)
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play926031080(arg_317_1)
			end

			if arg_319_0 == 2 then
				arg_317_0:Play926031080(arg_317_1)
			end

			if arg_319_0 == 3 then
				arg_317_0:Play926031080(arg_317_1)
			end

			arg_317_1:RecordChoiceLog(926031079, 1320, 1321, 1322)
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			return
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play926031080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 926031080
		arg_321_1.duration_ = 2.6

		local var_321_0 = {
			zh = 2.6,
			ja = 2.533
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
				arg_321_0:Play926031081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["104701"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps104701 == nil then
				arg_321_1.var_.actorSpriteComps104701 = var_324_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_2 = 0.2

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.actorSpriteComps104701 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								local var_324_4 = Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor1.r, var_324_3)
								local var_324_5 = Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor1.g, var_324_3)
								local var_324_6 = Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor1.b, var_324_3)

								iter_324_1.color = Color.New(var_324_4, var_324_5, var_324_6)
							else
								local var_324_7 = Mathf.Lerp(iter_324_1.color.r, 1, var_324_3)

								iter_324_1.color = Color.New(var_324_7, var_324_7, var_324_7)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps104701 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_324_3 then
						if arg_321_1.isInRecall_ then
							iter_324_3.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps104701 = nil
			end

			local var_324_8 = arg_321_1.actors_["104701"].transform
			local var_324_9 = 0

			if var_324_9 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.var_.moveOldPos104701 = var_324_8.localPosition
				var_324_8.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("104701", 2)

				local var_324_10 = var_324_8.childCount

				for iter_324_4 = 0, var_324_10 - 1 do
					local var_324_11 = var_324_8:GetChild(iter_324_4)

					if var_324_11.name == "split_2" or not string.find(var_324_11.name, "split") then
						var_324_11.gameObject:SetActive(true)
					else
						var_324_11.gameObject:SetActive(false)
					end
				end
			end

			local var_324_12 = 0.001

			if var_324_9 <= arg_321_1.time_ and arg_321_1.time_ < var_324_9 + var_324_12 then
				local var_324_13 = (arg_321_1.time_ - var_324_9) / var_324_12
				local var_324_14 = Vector3.New(-528.7, -386.8, -295)

				var_324_8.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos104701, var_324_14, var_324_13)
			end

			if arg_321_1.time_ >= var_324_9 + var_324_12 and arg_321_1.time_ < var_324_9 + var_324_12 + arg_324_0 then
				var_324_8.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_324_15 = 0
			local var_324_16 = 0.25

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[1296].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(926031080)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 10
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031080", "story_v_out_926031.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_out_926031", "926031080", "story_v_out_926031.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_out_926031", "926031080", "story_v_out_926031.awb")

						arg_321_1:RecordAudio("926031080", var_324_24)
						arg_321_1:RecordAudio("926031080", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_926031", "926031080", "story_v_out_926031.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_926031", "926031080", "story_v_out_926031.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play926031081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 926031081
		arg_325_1.duration_ = 4.13

		local var_325_0 = {
			zh = 3.433,
			ja = 4.133
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
				arg_325_0:Play926031082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["128404"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps128404 == nil then
				arg_325_1.var_.actorSpriteComps128404 = var_328_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.actorSpriteComps128404 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps128404 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_328_3 then
						if arg_325_1.isInRecall_ then
							iter_328_3.color = arg_325_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_328_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps128404 = nil
			end

			local var_328_8 = arg_325_1.actors_["104701"]
			local var_328_9 = 0

			if var_328_9 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 and not isNil(var_328_8) and arg_325_1.var_.actorSpriteComps104701 == nil then
				arg_325_1.var_.actorSpriteComps104701 = var_328_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_10 = 0.2

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_10 and not isNil(var_328_8) then
				local var_328_11 = (arg_325_1.time_ - var_328_9) / var_328_10

				if arg_325_1.var_.actorSpriteComps104701 then
					for iter_328_4, iter_328_5 in pairs(arg_325_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_325_1.time_ >= var_328_9 + var_328_10 and arg_325_1.time_ < var_328_9 + var_328_10 + arg_328_0 and not isNil(var_328_8) and arg_325_1.var_.actorSpriteComps104701 then
				for iter_328_6, iter_328_7 in pairs(arg_325_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_328_7 then
						if arg_325_1.isInRecall_ then
							iter_328_7.color = arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_328_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps104701 = nil
			end

			local var_328_16 = arg_325_1.actors_["104701"].transform
			local var_328_17 = 0

			if var_328_17 < arg_325_1.time_ and arg_325_1.time_ <= var_328_17 + arg_328_0 then
				arg_325_1.var_.moveOldPos104701 = var_328_16.localPosition
				var_328_16.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("104701", 7)

				local var_328_18 = var_328_16.childCount

				for iter_328_8 = 0, var_328_18 - 1 do
					local var_328_19 = var_328_16:GetChild(iter_328_8)

					if var_328_19.name == "" or not string.find(var_328_19.name, "split") then
						var_328_19.gameObject:SetActive(true)
					else
						var_328_19.gameObject:SetActive(false)
					end
				end
			end

			local var_328_20 = 0.001

			if var_328_17 <= arg_325_1.time_ and arg_325_1.time_ < var_328_17 + var_328_20 then
				local var_328_21 = (arg_325_1.time_ - var_328_17) / var_328_20
				local var_328_22 = Vector3.New(0, -2000, 0)

				var_328_16.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos104701, var_328_22, var_328_21)
			end

			if arg_325_1.time_ >= var_328_17 + var_328_20 and arg_325_1.time_ < var_328_17 + var_328_20 + arg_328_0 then
				var_328_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_328_23 = arg_325_1.actors_["10144"].transform
			local var_328_24 = 0

			if var_328_24 < arg_325_1.time_ and arg_325_1.time_ <= var_328_24 + arg_328_0 then
				arg_325_1.var_.moveOldPos10144 = var_328_23.localPosition
				var_328_23.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("10144", 7)

				local var_328_25 = var_328_23.childCount

				for iter_328_9 = 0, var_328_25 - 1 do
					local var_328_26 = var_328_23:GetChild(iter_328_9)

					if var_328_26.name == "" or not string.find(var_328_26.name, "split") then
						var_328_26.gameObject:SetActive(true)
					else
						var_328_26.gameObject:SetActive(false)
					end
				end
			end

			local var_328_27 = 0.001

			if var_328_24 <= arg_325_1.time_ and arg_325_1.time_ < var_328_24 + var_328_27 then
				local var_328_28 = (arg_325_1.time_ - var_328_24) / var_328_27
				local var_328_29 = Vector3.New(0, -2000, 0)

				var_328_23.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10144, var_328_29, var_328_28)
			end

			if arg_325_1.time_ >= var_328_24 + var_328_27 and arg_325_1.time_ < var_328_24 + var_328_27 + arg_328_0 then
				var_328_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_328_30 = arg_325_1.actors_["128404"].transform
			local var_328_31 = 0

			if var_328_31 < arg_325_1.time_ and arg_325_1.time_ <= var_328_31 + arg_328_0 then
				arg_325_1.var_.moveOldPos128404 = var_328_30.localPosition
				var_328_30.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("128404", 3)

				local var_328_32 = var_328_30.childCount

				for iter_328_10 = 0, var_328_32 - 1 do
					local var_328_33 = var_328_30:GetChild(iter_328_10)

					if var_328_33.name == "" or not string.find(var_328_33.name, "split") then
						var_328_33.gameObject:SetActive(true)
					else
						var_328_33.gameObject:SetActive(false)
					end
				end
			end

			local var_328_34 = 0.001

			if var_328_31 <= arg_325_1.time_ and arg_325_1.time_ < var_328_31 + var_328_34 then
				local var_328_35 = (arg_325_1.time_ - var_328_31) / var_328_34
				local var_328_36 = Vector3.New(-16.1, -362, -375)

				var_328_30.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos128404, var_328_36, var_328_35)
			end

			if arg_325_1.time_ >= var_328_31 + var_328_34 and arg_325_1.time_ < var_328_31 + var_328_34 + arg_328_0 then
				var_328_30.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_328_37 = 0
			local var_328_38 = 0.475

			if var_328_37 < arg_325_1.time_ and arg_325_1.time_ <= var_328_37 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_39 = arg_325_1:FormatText(StoryNameCfg[6].name)

				arg_325_1.leftNameTxt_.text = var_328_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_40 = arg_325_1:GetWordFromCfg(926031081)
				local var_328_41 = arg_325_1:FormatText(var_328_40.content)

				arg_325_1.text_.text = var_328_41

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_42 = 19
				local var_328_43 = utf8.len(var_328_41)
				local var_328_44 = var_328_42 <= 0 and var_328_38 or var_328_38 * (var_328_43 / var_328_42)

				if var_328_44 > 0 and var_328_38 < var_328_44 then
					arg_325_1.talkMaxDuration = var_328_44

					if var_328_44 + var_328_37 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_44 + var_328_37
					end
				end

				arg_325_1.text_.text = var_328_41
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031081", "story_v_out_926031.awb") ~= 0 then
					local var_328_45 = manager.audio:GetVoiceLength("story_v_out_926031", "926031081", "story_v_out_926031.awb") / 1000

					if var_328_45 + var_328_37 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_45 + var_328_37
					end

					if var_328_40.prefab_name ~= "" and arg_325_1.actors_[var_328_40.prefab_name] ~= nil then
						local var_328_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_40.prefab_name].transform, "story_v_out_926031", "926031081", "story_v_out_926031.awb")

						arg_325_1:RecordAudio("926031081", var_328_46)
						arg_325_1:RecordAudio("926031081", var_328_46)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_926031", "926031081", "story_v_out_926031.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_926031", "926031081", "story_v_out_926031.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_47 = math.max(var_328_38, arg_325_1.talkMaxDuration)

			if var_328_37 <= arg_325_1.time_ and arg_325_1.time_ < var_328_37 + var_328_47 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_37) / var_328_47

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_37 + var_328_47 and arg_325_1.time_ < var_328_37 + var_328_47 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play926031082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 926031082
		arg_329_1.duration_ = 7.7

		local var_329_0 = {
			zh = 6.066,
			ja = 7.7
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
				arg_329_0:Play926031083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["106103"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps106103 == nil then
				arg_329_1.var_.actorSpriteComps106103 = var_332_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_2 = 0.2

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.actorSpriteComps106103 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.actorSpriteComps106103 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_332_3 then
						if arg_329_1.isInRecall_ then
							iter_332_3.color = arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_332_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps106103 = nil
			end

			local var_332_8 = arg_329_1.actors_["128404"]
			local var_332_9 = 0

			if var_332_9 < arg_329_1.time_ and arg_329_1.time_ <= var_332_9 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps128404 == nil then
				arg_329_1.var_.actorSpriteComps128404 = var_332_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_10 = 0.2

			if var_332_9 <= arg_329_1.time_ and arg_329_1.time_ < var_332_9 + var_332_10 and not isNil(var_332_8) then
				local var_332_11 = (arg_329_1.time_ - var_332_9) / var_332_10

				if arg_329_1.var_.actorSpriteComps128404 then
					for iter_332_4, iter_332_5 in pairs(arg_329_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_329_1.time_ >= var_332_9 + var_332_10 and arg_329_1.time_ < var_332_9 + var_332_10 + arg_332_0 and not isNil(var_332_8) and arg_329_1.var_.actorSpriteComps128404 then
				for iter_332_6, iter_332_7 in pairs(arg_329_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_332_7 then
						if arg_329_1.isInRecall_ then
							iter_332_7.color = arg_329_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_332_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_329_1.var_.actorSpriteComps128404 = nil
			end

			local var_332_16 = arg_329_1.actors_["128404"].transform
			local var_332_17 = 0

			if var_332_17 < arg_329_1.time_ and arg_329_1.time_ <= var_332_17 + arg_332_0 then
				arg_329_1.var_.moveOldPos128404 = var_332_16.localPosition
				var_332_16.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("128404", 7)

				local var_332_18 = var_332_16.childCount

				for iter_332_8 = 0, var_332_18 - 1 do
					local var_332_19 = var_332_16:GetChild(iter_332_8)

					if var_332_19.name == "" or not string.find(var_332_19.name, "split") then
						var_332_19.gameObject:SetActive(true)
					else
						var_332_19.gameObject:SetActive(false)
					end
				end
			end

			local var_332_20 = 0.001

			if var_332_17 <= arg_329_1.time_ and arg_329_1.time_ < var_332_17 + var_332_20 then
				local var_332_21 = (arg_329_1.time_ - var_332_17) / var_332_20
				local var_332_22 = Vector3.New(0, -2000, 0)

				var_332_16.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos128404, var_332_22, var_332_21)
			end

			if arg_329_1.time_ >= var_332_17 + var_332_20 and arg_329_1.time_ < var_332_17 + var_332_20 + arg_332_0 then
				var_332_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_332_23 = arg_329_1.actors_["106103"].transform
			local var_332_24 = 0

			if var_332_24 < arg_329_1.time_ and arg_329_1.time_ <= var_332_24 + arg_332_0 then
				arg_329_1.var_.moveOldPos106103 = var_332_23.localPosition
				var_332_23.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("106103", 3)

				local var_332_25 = var_332_23.childCount

				for iter_332_9 = 0, var_332_25 - 1 do
					local var_332_26 = var_332_23:GetChild(iter_332_9)

					if var_332_26.name == "" or not string.find(var_332_26.name, "split") then
						var_332_26.gameObject:SetActive(true)
					else
						var_332_26.gameObject:SetActive(false)
					end
				end
			end

			local var_332_27 = 0.001

			if var_332_24 <= arg_329_1.time_ and arg_329_1.time_ < var_332_24 + var_332_27 then
				local var_332_28 = (arg_329_1.time_ - var_332_24) / var_332_27
				local var_332_29 = Vector3.New(-36.6, -398.2, -333.7)

				var_332_23.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos106103, var_332_29, var_332_28)
			end

			if arg_329_1.time_ >= var_332_24 + var_332_27 and arg_329_1.time_ < var_332_24 + var_332_27 + arg_332_0 then
				var_332_23.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_332_30 = 0
			local var_332_31 = 0.675

			if var_332_30 < arg_329_1.time_ and arg_329_1.time_ <= var_332_30 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_32 = arg_329_1:FormatText(StoryNameCfg[612].name)

				arg_329_1.leftNameTxt_.text = var_332_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_33 = arg_329_1:GetWordFromCfg(926031082)
				local var_332_34 = arg_329_1:FormatText(var_332_33.content)

				arg_329_1.text_.text = var_332_34

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_35 = 27
				local var_332_36 = utf8.len(var_332_34)
				local var_332_37 = var_332_35 <= 0 and var_332_31 or var_332_31 * (var_332_36 / var_332_35)

				if var_332_37 > 0 and var_332_31 < var_332_37 then
					arg_329_1.talkMaxDuration = var_332_37

					if var_332_37 + var_332_30 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_37 + var_332_30
					end
				end

				arg_329_1.text_.text = var_332_34
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031082", "story_v_out_926031.awb") ~= 0 then
					local var_332_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031082", "story_v_out_926031.awb") / 1000

					if var_332_38 + var_332_30 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_38 + var_332_30
					end

					if var_332_33.prefab_name ~= "" and arg_329_1.actors_[var_332_33.prefab_name] ~= nil then
						local var_332_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_33.prefab_name].transform, "story_v_out_926031", "926031082", "story_v_out_926031.awb")

						arg_329_1:RecordAudio("926031082", var_332_39)
						arg_329_1:RecordAudio("926031082", var_332_39)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_926031", "926031082", "story_v_out_926031.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_926031", "926031082", "story_v_out_926031.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_40 = math.max(var_332_31, arg_329_1.talkMaxDuration)

			if var_332_30 <= arg_329_1.time_ and arg_329_1.time_ < var_332_30 + var_332_40 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_30) / var_332_40

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_30 + var_332_40 and arg_329_1.time_ < var_332_30 + var_332_40 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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
				actorName = "106103",
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
	Play926031083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 926031083
		arg_333_1.duration_ = 5.33

		local var_333_0 = {
			zh = 5.3,
			ja = 5.333
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
			arg_333_1.auto_ = false
		end

		function arg_333_1.playNext_(arg_335_0)
			arg_333_1.onStoryFinished_()
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["10144"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps10144 == nil then
				arg_333_1.var_.actorSpriteComps10144 = var_336_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_2 = 0.2

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.actorSpriteComps10144 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								local var_336_4 = Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor1.r, var_336_3)
								local var_336_5 = Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor1.g, var_336_3)
								local var_336_6 = Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor1.b, var_336_3)

								iter_336_1.color = Color.New(var_336_4, var_336_5, var_336_6)
							else
								local var_336_7 = Mathf.Lerp(iter_336_1.color.r, 1, var_336_3)

								iter_336_1.color = Color.New(var_336_7, var_336_7, var_336_7)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.actorSpriteComps10144 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_336_3 then
						if arg_333_1.isInRecall_ then
							iter_336_3.color = arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_336_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps10144 = nil
			end

			local var_336_8 = arg_333_1.actors_["106103"]
			local var_336_9 = 0

			if var_336_9 < arg_333_1.time_ and arg_333_1.time_ <= var_336_9 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps106103 == nil then
				arg_333_1.var_.actorSpriteComps106103 = var_336_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_10 = 0.2

			if var_336_9 <= arg_333_1.time_ and arg_333_1.time_ < var_336_9 + var_336_10 and not isNil(var_336_8) then
				local var_336_11 = (arg_333_1.time_ - var_336_9) / var_336_10

				if arg_333_1.var_.actorSpriteComps106103 then
					for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_336_5 then
							if arg_333_1.isInRecall_ then
								local var_336_12 = Mathf.Lerp(iter_336_5.color.r, arg_333_1.hightColor2.r, var_336_11)
								local var_336_13 = Mathf.Lerp(iter_336_5.color.g, arg_333_1.hightColor2.g, var_336_11)
								local var_336_14 = Mathf.Lerp(iter_336_5.color.b, arg_333_1.hightColor2.b, var_336_11)

								iter_336_5.color = Color.New(var_336_12, var_336_13, var_336_14)
							else
								local var_336_15 = Mathf.Lerp(iter_336_5.color.r, 0.5, var_336_11)

								iter_336_5.color = Color.New(var_336_15, var_336_15, var_336_15)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= var_336_9 + var_336_10 and arg_333_1.time_ < var_336_9 + var_336_10 + arg_336_0 and not isNil(var_336_8) and arg_333_1.var_.actorSpriteComps106103 then
				for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_336_7 then
						if arg_333_1.isInRecall_ then
							iter_336_7.color = arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_336_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_333_1.var_.actorSpriteComps106103 = nil
			end

			local var_336_16 = arg_333_1.actors_["106103"].transform
			local var_336_17 = 0

			if var_336_17 < arg_333_1.time_ and arg_333_1.time_ <= var_336_17 + arg_336_0 then
				arg_333_1.var_.moveOldPos106103 = var_336_16.localPosition
				var_336_16.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("106103", 7)

				local var_336_18 = var_336_16.childCount

				for iter_336_8 = 0, var_336_18 - 1 do
					local var_336_19 = var_336_16:GetChild(iter_336_8)

					if var_336_19.name == "" or not string.find(var_336_19.name, "split") then
						var_336_19.gameObject:SetActive(true)
					else
						var_336_19.gameObject:SetActive(false)
					end
				end
			end

			local var_336_20 = 0.001

			if var_336_17 <= arg_333_1.time_ and arg_333_1.time_ < var_336_17 + var_336_20 then
				local var_336_21 = (arg_333_1.time_ - var_336_17) / var_336_20
				local var_336_22 = Vector3.New(0, -2000, 0)

				var_336_16.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos106103, var_336_22, var_336_21)
			end

			if arg_333_1.time_ >= var_336_17 + var_336_20 and arg_333_1.time_ < var_336_17 + var_336_20 + arg_336_0 then
				var_336_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_336_23 = arg_333_1.actors_["10144"].transform
			local var_336_24 = 0

			if var_336_24 < arg_333_1.time_ and arg_333_1.time_ <= var_336_24 + arg_336_0 then
				arg_333_1.var_.moveOldPos10144 = var_336_23.localPosition
				var_336_23.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10144", 3)

				local var_336_25 = var_336_23.childCount

				for iter_336_9 = 0, var_336_25 - 1 do
					local var_336_26 = var_336_23:GetChild(iter_336_9)

					if var_336_26.name == "split_1" or not string.find(var_336_26.name, "split") then
						var_336_26.gameObject:SetActive(true)
					else
						var_336_26.gameObject:SetActive(false)
					end
				end
			end

			local var_336_27 = 0.001

			if var_336_24 <= arg_333_1.time_ and arg_333_1.time_ < var_336_24 + var_336_27 then
				local var_336_28 = (arg_333_1.time_ - var_336_24) / var_336_27
				local var_336_29 = Vector3.New(-31.5, -381.1, -285.9)

				var_336_23.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10144, var_336_29, var_336_28)
			end

			if arg_333_1.time_ >= var_336_24 + var_336_27 and arg_333_1.time_ < var_336_24 + var_336_27 + arg_336_0 then
				var_336_23.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_336_30 = 0
			local var_336_31 = 0.6

			if var_336_30 < arg_333_1.time_ and arg_333_1.time_ <= var_336_30 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_32 = arg_333_1:FormatText(StoryNameCfg[1297].name)

				arg_333_1.leftNameTxt_.text = var_336_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_33 = arg_333_1:GetWordFromCfg(926031083)
				local var_336_34 = arg_333_1:FormatText(var_336_33.content)

				arg_333_1.text_.text = var_336_34

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_35 = 24
				local var_336_36 = utf8.len(var_336_34)
				local var_336_37 = var_336_35 <= 0 and var_336_31 or var_336_31 * (var_336_36 / var_336_35)

				if var_336_37 > 0 and var_336_31 < var_336_37 then
					arg_333_1.talkMaxDuration = var_336_37

					if var_336_37 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_37 + var_336_30
					end
				end

				arg_333_1.text_.text = var_336_34
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926031", "926031083", "story_v_out_926031.awb") ~= 0 then
					local var_336_38 = manager.audio:GetVoiceLength("story_v_out_926031", "926031083", "story_v_out_926031.awb") / 1000

					if var_336_38 + var_336_30 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_38 + var_336_30
					end

					if var_336_33.prefab_name ~= "" and arg_333_1.actors_[var_336_33.prefab_name] ~= nil then
						local var_336_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_33.prefab_name].transform, "story_v_out_926031", "926031083", "story_v_out_926031.awb")

						arg_333_1:RecordAudio("926031083", var_336_39)
						arg_333_1:RecordAudio("926031083", var_336_39)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_926031", "926031083", "story_v_out_926031.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_926031", "926031083", "story_v_out_926031.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_40 = math.max(var_336_31, arg_333_1.talkMaxDuration)

			if var_336_30 <= arg_333_1.time_ and arg_333_1.time_ < var_336_30 + var_336_40 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_30) / var_336_40

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_30 + var_336_40 and arg_333_1.time_ < var_336_30 + var_336_40 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0114"
	},
	voices = {
		"story_v_out_926031.awb"
	}
}
