return {
	Play114211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114211001
		arg_1_1.duration_ = 8

		local var_1_0 = {
			ja = 6.799999999999,
			ko = 7.299999999999,
			zh = 6.199999999999,
			en = 7.999999999999
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
				arg_1_0:Play114211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F04"

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
				local var_4_5 = arg_1_1.bgs_.F04

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
					if iter_4_0 ~= "F04" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = "10015"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(var_4_23, arg_1_1.canvasGo_.transform)

					var_4_24.transform:SetSiblingIndex(1)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_25) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_26 = arg_1_1.actors_["10015"].transform
			local var_4_27 = 1.8

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPos10015 = var_4_26.localPosition
				var_4_26.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10015", 4)

				local var_4_28 = var_4_26.childCount

				for iter_4_4 = 0, var_4_28 - 1 do
					local var_4_29 = var_4_26:GetChild(iter_4_4)

					if var_4_29.name == "split_5" or not string.find(var_4_29.name, "split") then
						var_4_29.gameObject:SetActive(true)
					else
						var_4_29.gameObject:SetActive(false)
					end
				end
			end

			local var_4_30 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_27) / var_4_30
				local var_4_32 = Vector3.New(390, -350, -180)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10015, var_4_32, var_4_31)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_30 and arg_1_1.time_ < var_4_27 + var_4_30 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(390, -350, -180)
			end

			local var_4_33 = arg_1_1.actors_["10015"]
			local var_4_34 = 1.8

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10015 == nil then
				arg_1_1.var_.actorSpriteComps10015 = var_4_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_35 = 0.034

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 and not isNil(var_4_33) then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35

				if arg_1_1.var_.actorSpriteComps10015 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_37 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_36)
								local var_4_38 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_36)
								local var_4_39 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_36)

								iter_4_6.color = Color.New(var_4_37, var_4_38, var_4_39)
							else
								local var_4_40 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_36)

								iter_4_6.color = Color.New(var_4_40, var_4_40, var_4_40)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 and not isNil(var_4_33) and arg_1_1.var_.actorSpriteComps10015 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10015 = nil
			end

			local var_4_41 = arg_1_1.actors_["10015"]
			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_43 = var_4_41:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_43 then
					arg_1_1.var_.alphaOldValue10015 = var_4_43.alpha
					arg_1_1.var_.characterEffect10015 = var_4_43
				end

				arg_1_1.var_.alphaOldValue10015 = 0
			end

			local var_4_44 = 0.5

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_42) / var_4_44
				local var_4_46 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10015, 1, var_4_45)

				if arg_1_1.var_.characterEffect10015 then
					arg_1_1.var_.characterEffect10015.alpha = var_4_46
				end
			end

			if arg_1_1.time_ >= var_4_42 + var_4_44 and arg_1_1.time_ < var_4_42 + var_4_44 + arg_4_0 and arg_1_1.var_.characterEffect10015 then
				arg_1_1.var_.characterEffect10015.alpha = 1
			end

			local var_4_47 = 0
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 2
			local var_4_54 = 0.966666666666667

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_59 = 1.999999999999
			local var_4_60 = 0.575

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_61 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_61:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_62 = arg_1_1:FormatText(StoryNameCfg[208].name)

				arg_1_1.leftNameTxt_.text = var_4_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_63 = arg_1_1:GetWordFromCfg(114211001)
				local var_4_64 = arg_1_1:FormatText(var_4_63.content)

				arg_1_1.text_.text = var_4_64

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_65 = 23
				local var_4_66 = utf8.len(var_4_64)
				local var_4_67 = var_4_65 <= 0 and var_4_60 or var_4_60 * (var_4_66 / var_4_65)

				if var_4_67 > 0 and var_4_60 < var_4_67 then
					arg_1_1.talkMaxDuration = var_4_67
					var_4_59 = var_4_59 + 0.3

					if var_4_67 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_64
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211001", "story_v_out_114211.awb") ~= 0 then
					local var_4_68 = manager.audio:GetVoiceLength("story_v_out_114211", "114211001", "story_v_out_114211.awb") / 1000

					if var_4_68 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_59
					end

					if var_4_63.prefab_name ~= "" and arg_1_1.actors_[var_4_63.prefab_name] ~= nil then
						local var_4_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_63.prefab_name].transform, "story_v_out_114211", "114211001", "story_v_out_114211.awb")

						arg_1_1:RecordAudio("114211001", var_4_69)
						arg_1_1:RecordAudio("114211001", var_4_69)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114211", "114211001", "story_v_out_114211.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114211", "114211001", "story_v_out_114211.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_70 = var_4_59 + 0.3
			local var_4_71 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_70 <= arg_1_1.time_ and arg_1_1.time_ < var_4_70 + var_4_71 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_70) / var_4_71

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_70 + var_4_71 and arg_1_1.time_ < var_4_70 + var_4_71 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114211002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114211002
		arg_9_1.duration_ = 7.47

		local var_9_0 = {
			ja = 7.466,
			ko = 5.833,
			zh = 6.133,
			en = 4.9
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
				arg_9_0:Play114211003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10017"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Object.Instantiate(arg_9_1.imageGo_, arg_9_1.canvasGo_.transform)

				var_12_1.transform:SetSiblingIndex(1)

				var_12_1.name = var_12_0

				local var_12_2 = var_12_1:GetComponent(typeof(Image))

				var_12_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10017")

				var_12_2:SetNativeSize()

				var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_9_1.actors_[var_12_0] = var_12_1
			end

			local var_12_3 = arg_9_1.actors_["10017"].transform
			local var_12_4 = 0

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.var_.moveOldPos10017 = var_12_3.localPosition
				var_12_3.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10017", 2)
			end

			local var_12_5 = 0.001

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_5 then
				local var_12_6 = (arg_9_1.time_ - var_12_4) / var_12_5
				local var_12_7 = Vector3.New(-390, -350, -180)

				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10017, var_12_7, var_12_6)
			end

			if arg_9_1.time_ >= var_12_4 + var_12_5 and arg_9_1.time_ < var_12_4 + var_12_5 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_12_8 = arg_9_1.actors_["10017"]
			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 and not isNil(var_12_8) then
				local var_12_10 = var_12_8:GetComponent("Image")

				if var_12_10 then
					arg_9_1.var_.highlightMatValue10017 = var_12_10
				end
			end

			local var_12_11 = 0.034

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_11 and not isNil(var_12_8) then
				local var_12_12 = (arg_9_1.time_ - var_12_9) / var_12_11

				if arg_9_1.var_.highlightMatValue10017 then
					local var_12_13 = Mathf.Lerp(0.5, 1, var_12_12)
					local var_12_14 = arg_9_1.var_.highlightMatValue10017
					local var_12_15 = var_12_14.color

					var_12_15.r = var_12_13
					var_12_15.g = var_12_13
					var_12_15.b = var_12_13
					var_12_14.color = var_12_15
				end
			end

			if arg_9_1.time_ >= var_12_9 + var_12_11 and arg_9_1.time_ < var_12_9 + var_12_11 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.highlightMatValue10017 then
				local var_12_16 = 1

				var_12_8.transform:SetSiblingIndex(1)

				local var_12_17 = arg_9_1.var_.highlightMatValue10017
				local var_12_18 = var_12_17.color

				var_12_18.r = var_12_16
				var_12_18.g = var_12_16
				var_12_18.b = var_12_16
				var_12_17.color = var_12_18
			end

			local var_12_19 = arg_9_1.actors_["10015"]
			local var_12_20 = 0

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.actorSpriteComps10015 == nil then
				arg_9_1.var_.actorSpriteComps10015 = var_12_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_21 = 0.034

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_21 and not isNil(var_12_19) then
				local var_12_22 = (arg_9_1.time_ - var_12_20) / var_12_21

				if arg_9_1.var_.actorSpriteComps10015 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								local var_12_23 = Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, var_12_22)
								local var_12_24 = Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, var_12_22)
								local var_12_25 = Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, var_12_22)

								iter_12_1.color = Color.New(var_12_23, var_12_24, var_12_25)
							else
								local var_12_26 = Mathf.Lerp(iter_12_1.color.r, 0.5, var_12_22)

								iter_12_1.color = Color.New(var_12_26, var_12_26, var_12_26)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_20 + var_12_21 and arg_9_1.time_ < var_12_20 + var_12_21 + arg_12_0 and not isNil(var_12_19) and arg_9_1.var_.actorSpriteComps10015 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_12_3 then
						if arg_9_1.isInRecall_ then
							iter_12_3.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10015 = nil
			end

			local var_12_27 = arg_9_1.actors_["10017"]
			local var_12_28 = 0

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				local var_12_29 = var_12_27:GetComponent("Image")

				if var_12_29 then
					arg_9_1.var_.alphaMatValue10017 = var_12_29
					arg_9_1.var_.alphaOldValue10017 = var_12_29.color.a
				end

				arg_9_1.var_.alphaOldValue10017 = 0
			end

			local var_12_30 = 0.5

			if var_12_28 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_30 then
				local var_12_31 = (arg_9_1.time_ - var_12_28) / var_12_30
				local var_12_32 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10017, 1, var_12_31)

				if arg_9_1.var_.alphaMatValue10017 then
					local var_12_33 = arg_9_1.var_.alphaMatValue10017.color

					var_12_33.a = var_12_32
					arg_9_1.var_.alphaMatValue10017.color = var_12_33
				end
			end

			if arg_9_1.time_ >= var_12_28 + var_12_30 and arg_9_1.time_ < var_12_28 + var_12_30 + arg_12_0 and arg_9_1.var_.alphaMatValue10017 then
				local var_12_34 = arg_9_1.var_.alphaMatValue10017
				local var_12_35 = var_12_34.color

				var_12_35.a = 1
				var_12_34.color = var_12_35
			end

			local var_12_36 = 0
			local var_12_37 = 0.625

			if var_12_36 < arg_9_1.time_ and arg_9_1.time_ <= var_12_36 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_38 = arg_9_1:FormatText(StoryNameCfg[255].name)

				arg_9_1.leftNameTxt_.text = var_12_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_39 = arg_9_1:GetWordFromCfg(114211002)
				local var_12_40 = arg_9_1:FormatText(var_12_39.content)

				arg_9_1.text_.text = var_12_40

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_41 = 25
				local var_12_42 = utf8.len(var_12_40)
				local var_12_43 = var_12_41 <= 0 and var_12_37 or var_12_37 * (var_12_42 / var_12_41)

				if var_12_43 > 0 and var_12_37 < var_12_43 then
					arg_9_1.talkMaxDuration = var_12_43

					if var_12_43 + var_12_36 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_43 + var_12_36
					end
				end

				arg_9_1.text_.text = var_12_40
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211002", "story_v_out_114211.awb") ~= 0 then
					local var_12_44 = manager.audio:GetVoiceLength("story_v_out_114211", "114211002", "story_v_out_114211.awb") / 1000

					if var_12_44 + var_12_36 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_44 + var_12_36
					end

					if var_12_39.prefab_name ~= "" and arg_9_1.actors_[var_12_39.prefab_name] ~= nil then
						local var_12_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_39.prefab_name].transform, "story_v_out_114211", "114211002", "story_v_out_114211.awb")

						arg_9_1:RecordAudio("114211002", var_12_45)
						arg_9_1:RecordAudio("114211002", var_12_45)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114211", "114211002", "story_v_out_114211.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114211", "114211002", "story_v_out_114211.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_46 = math.max(var_12_37, arg_9_1.talkMaxDuration)

			if var_12_36 <= arg_9_1.time_ and arg_9_1.time_ < var_12_36 + var_12_46 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_36) / var_12_46

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_36 + var_12_46 and arg_9_1.time_ < var_12_36 + var_12_46 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play114211003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114211003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114211004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10017"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) then
				local var_16_2 = var_16_0:GetComponent("Image")

				if var_16_2 then
					arg_13_1.var_.highlightMatValue10017 = var_16_2
				end
			end

			local var_16_3 = 0.034

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_3 and not isNil(var_16_0) then
				local var_16_4 = (arg_13_1.time_ - var_16_1) / var_16_3

				if arg_13_1.var_.highlightMatValue10017 then
					local var_16_5 = Mathf.Lerp(1, 0.5, var_16_4)
					local var_16_6 = arg_13_1.var_.highlightMatValue10017
					local var_16_7 = var_16_6.color

					var_16_7.r = var_16_5
					var_16_7.g = var_16_5
					var_16_7.b = var_16_5
					var_16_6.color = var_16_7
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_3 and arg_13_1.time_ < var_16_1 + var_16_3 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.highlightMatValue10017 then
				local var_16_8 = 0.5
				local var_16_9 = arg_13_1.var_.highlightMatValue10017
				local var_16_10 = var_16_9.color

				var_16_10.r = var_16_8
				var_16_10.g = var_16_8
				var_16_10.b = var_16_8
				var_16_9.color = var_16_10
			end

			local var_16_11 = 0
			local var_16_12 = 0.775

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(114211003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 31
				local var_16_16 = utf8.len(var_16_14)
				local var_16_17 = var_16_15 <= 0 and var_16_12 or var_16_12 * (var_16_16 / var_16_15)

				if var_16_17 > 0 and var_16_12 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_18 and arg_13_1.time_ < var_16_11 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114211004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114211004
		arg_17_1.duration_ = 1.73

		local var_17_0 = {
			ja = 1.7,
			ko = 1.566,
			zh = 1.733,
			en = 1
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
				arg_17_0:Play114211005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10015"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10015 == nil then
				arg_17_1.var_.actorSpriteComps10015 = var_20_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_2 = 0.034

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.actorSpriteComps10015 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.actorSpriteComps10015 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_20_3 then
						if arg_17_1.isInRecall_ then
							iter_20_3.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10015 = nil
			end

			local var_20_8 = 0
			local var_20_9 = 0.05

			if var_20_8 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_10 = arg_17_1:FormatText(StoryNameCfg[208].name)

				arg_17_1.leftNameTxt_.text = var_20_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_11 = arg_17_1:GetWordFromCfg(114211004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211004", "story_v_out_114211.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_114211", "114211004", "story_v_out_114211.awb") / 1000

					if var_20_16 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_8
					end

					if var_20_11.prefab_name ~= "" and arg_17_1.actors_[var_20_11.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_11.prefab_name].transform, "story_v_out_114211", "114211004", "story_v_out_114211.awb")

						arg_17_1:RecordAudio("114211004", var_20_17)
						arg_17_1:RecordAudio("114211004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114211", "114211004", "story_v_out_114211.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114211", "114211004", "story_v_out_114211.awb")
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
	Play114211005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114211005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114211006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10015"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10015 == nil then
				arg_21_1.var_.actorSpriteComps10015 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.034

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10015 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10015 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10015 = nil
			end

			local var_24_8 = 0
			local var_24_9 = 0.975

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(114211005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_12 = 39
				local var_24_13 = utf8.len(var_24_11)
				local var_24_14 = var_24_12 <= 0 and var_24_9 or var_24_9 * (var_24_13 / var_24_12)

				if var_24_14 > 0 and var_24_9 < var_24_14 then
					arg_21_1.talkMaxDuration = var_24_14

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_15 and arg_21_1.time_ < var_24_8 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114211006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114211006
		arg_25_1.duration_ = 8.97

		local var_25_0 = {
			ja = 7.533,
			ko = 8.4,
			zh = 8.966,
			en = 7.333
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
				arg_25_0:Play114211007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10015"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10015 == nil then
				arg_25_1.var_.actorSpriteComps10015 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.034

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10015 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor1.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor1.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor1.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 1, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10015 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10015 = nil
			end

			local var_28_8 = 0
			local var_28_9 = 1.2

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[208].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_11 = arg_25_1:GetWordFromCfg(114211006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211006", "story_v_out_114211.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_114211", "114211006", "story_v_out_114211.awb") / 1000

					if var_28_16 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_8
					end

					if var_28_11.prefab_name ~= "" and arg_25_1.actors_[var_28_11.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_11.prefab_name].transform, "story_v_out_114211", "114211006", "story_v_out_114211.awb")

						arg_25_1:RecordAudio("114211006", var_28_17)
						arg_25_1:RecordAudio("114211006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114211", "114211006", "story_v_out_114211.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114211", "114211006", "story_v_out_114211.awb")
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
	Play114211007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114211007
		arg_29_1.duration_ = 9.1

		local var_29_0 = {
			ja = 6.833,
			ko = 9.1,
			zh = 7.733,
			en = 7.3
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
				arg_29_0:Play114211008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10015"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10015 == nil then
				arg_29_1.var_.actorSpriteComps10015 = var_32_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_2 = 0.034

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.actorSpriteComps10015 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								local var_32_4 = Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, var_32_3)
								local var_32_5 = Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, var_32_3)
								local var_32_6 = Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, var_32_3)

								iter_32_1.color = Color.New(var_32_4, var_32_5, var_32_6)
							else
								local var_32_7 = Mathf.Lerp(iter_32_1.color.r, 0.5, var_32_3)

								iter_32_1.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.actorSpriteComps10015 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_32_3 then
						if arg_29_1.isInRecall_ then
							iter_32_3.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10015 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.95

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_10 = arg_29_1:FormatText(StoryNameCfg[210].name)

				arg_29_1.leftNameTxt_.text = var_32_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_11 = arg_29_1:GetWordFromCfg(114211007)
				local var_32_12 = arg_29_1:FormatText(var_32_11.content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211007", "story_v_out_114211.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_114211", "114211007", "story_v_out_114211.awb") / 1000

					if var_32_16 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_8
					end

					if var_32_11.prefab_name ~= "" and arg_29_1.actors_[var_32_11.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_11.prefab_name].transform, "story_v_out_114211", "114211007", "story_v_out_114211.awb")

						arg_29_1:RecordAudio("114211007", var_32_17)
						arg_29_1:RecordAudio("114211007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114211", "114211007", "story_v_out_114211.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114211", "114211007", "story_v_out_114211.awb")
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
	Play114211008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114211008
		arg_33_1.duration_ = 6.4

		local var_33_0 = {
			ja = 6.4,
			ko = 4.166,
			zh = 4.366,
			en = 3.533
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
				arg_33_0:Play114211009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.575

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[213].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(114211008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211008", "story_v_out_114211.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_114211", "114211008", "story_v_out_114211.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_114211", "114211008", "story_v_out_114211.awb")

						arg_33_1:RecordAudio("114211008", var_36_9)
						arg_33_1:RecordAudio("114211008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114211", "114211008", "story_v_out_114211.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114211", "114211008", "story_v_out_114211.awb")
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
	Play114211009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114211009
		arg_37_1.duration_ = 7.73

		local var_37_0 = {
			ja = 6.033,
			ko = 6.8,
			zh = 7.6,
			en = 7.733
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
				arg_37_0:Play114211010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.85

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[209].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(114211009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211009", "story_v_out_114211.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_114211", "114211009", "story_v_out_114211.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_114211", "114211009", "story_v_out_114211.awb")

						arg_37_1:RecordAudio("114211009", var_40_9)
						arg_37_1:RecordAudio("114211009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114211", "114211009", "story_v_out_114211.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114211", "114211009", "story_v_out_114211.awb")
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
	Play114211010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114211010
		arg_41_1.duration_ = 1.8

		local var_41_0 = {
			ja = 0.999999999999,
			ko = 1.733,
			zh = 1.8,
			en = 1.533
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
				arg_41_0:Play114211011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10017"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) then
				local var_44_2 = var_44_0:GetComponent("Image")

				if var_44_2 then
					arg_41_1.var_.highlightMatValue10017 = var_44_2
				end
			end

			local var_44_3 = 0.034

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_3 and not isNil(var_44_0) then
				local var_44_4 = (arg_41_1.time_ - var_44_1) / var_44_3

				if arg_41_1.var_.highlightMatValue10017 then
					local var_44_5 = Mathf.Lerp(0.5, 1, var_44_4)
					local var_44_6 = arg_41_1.var_.highlightMatValue10017
					local var_44_7 = var_44_6.color

					var_44_7.r = var_44_5
					var_44_7.g = var_44_5
					var_44_7.b = var_44_5
					var_44_6.color = var_44_7
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_3 and arg_41_1.time_ < var_44_1 + var_44_3 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.highlightMatValue10017 then
				local var_44_8 = 1

				var_44_0.transform:SetSiblingIndex(1)

				local var_44_9 = arg_41_1.var_.highlightMatValue10017
				local var_44_10 = var_44_9.color

				var_44_10.r = var_44_8
				var_44_10.g = var_44_8
				var_44_10.b = var_44_8
				var_44_9.color = var_44_10
			end

			local var_44_11 = 0
			local var_44_12 = 0.05

			if var_44_11 < arg_41_1.time_ and arg_41_1.time_ <= var_44_11 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_13 = arg_41_1:FormatText(StoryNameCfg[255].name)

				arg_41_1.leftNameTxt_.text = var_44_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(114211010)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_16 = 2
				local var_44_17 = utf8.len(var_44_15)
				local var_44_18 = var_44_16 <= 0 and var_44_12 or var_44_12 * (var_44_17 / var_44_16)

				if var_44_18 > 0 and var_44_12 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18

					if var_44_18 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_11
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211010", "story_v_out_114211.awb") ~= 0 then
					local var_44_19 = manager.audio:GetVoiceLength("story_v_out_114211", "114211010", "story_v_out_114211.awb") / 1000

					if var_44_19 + var_44_11 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_11
					end

					if var_44_14.prefab_name ~= "" and arg_41_1.actors_[var_44_14.prefab_name] ~= nil then
						local var_44_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_14.prefab_name].transform, "story_v_out_114211", "114211010", "story_v_out_114211.awb")

						arg_41_1:RecordAudio("114211010", var_44_20)
						arg_41_1:RecordAudio("114211010", var_44_20)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114211", "114211010", "story_v_out_114211.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114211", "114211010", "story_v_out_114211.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_21 = math.max(var_44_12, arg_41_1.talkMaxDuration)

			if var_44_11 <= arg_41_1.time_ and arg_41_1.time_ < var_44_11 + var_44_21 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_11) / var_44_21

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_11 + var_44_21 and arg_41_1.time_ < var_44_11 + var_44_21 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114211011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114211011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114211012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10017"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				local var_48_2 = var_48_0:GetComponent("Image")

				if var_48_2 then
					arg_45_1.var_.alphaMatValue10017 = var_48_2
					arg_45_1.var_.alphaOldValue10017 = var_48_2.color.a
				end

				arg_45_1.var_.alphaOldValue10017 = 1
			end

			local var_48_3 = 0.5

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_3 then
				local var_48_4 = (arg_45_1.time_ - var_48_1) / var_48_3
				local var_48_5 = Mathf.Lerp(arg_45_1.var_.alphaOldValue10017, 0, var_48_4)

				if arg_45_1.var_.alphaMatValue10017 then
					local var_48_6 = arg_45_1.var_.alphaMatValue10017.color

					var_48_6.a = var_48_5
					arg_45_1.var_.alphaMatValue10017.color = var_48_6
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_3 and arg_45_1.time_ < var_48_1 + var_48_3 + arg_48_0 and arg_45_1.var_.alphaMatValue10017 then
				local var_48_7 = arg_45_1.var_.alphaMatValue10017
				local var_48_8 = var_48_7.color

				var_48_8.a = 0
				var_48_7.color = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["10015"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				local var_48_11 = var_48_9:GetComponentInChildren(typeof(CanvasGroup))

				if var_48_11 then
					arg_45_1.var_.alphaOldValue10015 = var_48_11.alpha
					arg_45_1.var_.characterEffect10015 = var_48_11
				end

				arg_45_1.var_.alphaOldValue10015 = 1
			end

			local var_48_12 = 0.5

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_12 then
				local var_48_13 = (arg_45_1.time_ - var_48_10) / var_48_12
				local var_48_14 = Mathf.Lerp(arg_45_1.var_.alphaOldValue10015, 0, var_48_13)

				if arg_45_1.var_.characterEffect10015 then
					arg_45_1.var_.characterEffect10015.alpha = var_48_14
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_12 and arg_45_1.time_ < var_48_10 + var_48_12 + arg_48_0 and arg_45_1.var_.characterEffect10015 then
				arg_45_1.var_.characterEffect10015.alpha = 0
			end

			local var_48_15 = 0
			local var_48_16 = 0.55

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

				local var_48_17 = arg_45_1:GetWordFromCfg(114211011)
				local var_48_18 = arg_45_1:FormatText(var_48_17.content)

				arg_45_1.text_.text = var_48_18

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_19 = 22
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

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114211012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114211012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114211013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.9

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(114211012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 36
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114211013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114211013
		arg_53_1.duration_ = 6.9

		local var_53_0 = {
			ja = 6.9,
			ko = 4.933,
			zh = 4.6,
			en = 5.2
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
				arg_53_0:Play114211014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "10022"

			if arg_53_1.actors_[var_56_0] == nil then
				local var_56_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_56_1) then
					local var_56_2 = Object.Instantiate(var_56_1, arg_53_1.canvasGo_.transform)

					var_56_2.transform:SetSiblingIndex(1)

					var_56_2.name = var_56_0
					var_56_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_53_1.actors_[var_56_0] = var_56_2

					local var_56_3 = var_56_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_53_1.isInRecall_ then
						for iter_56_0, iter_56_1 in ipairs(var_56_3) do
							iter_56_1.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_56_4 = arg_53_1.actors_["10022"].transform
			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.var_.moveOldPos10022 = var_56_4.localPosition
				var_56_4.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10022", 2)

				local var_56_6 = var_56_4.childCount

				for iter_56_2 = 0, var_56_6 - 1 do
					local var_56_7 = var_56_4:GetChild(iter_56_2)

					if var_56_7.name == "split_3" or not string.find(var_56_7.name, "split") then
						var_56_7.gameObject:SetActive(true)
					else
						var_56_7.gameObject:SetActive(false)
					end
				end
			end

			local var_56_8 = 0.001

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_8 then
				local var_56_9 = (arg_53_1.time_ - var_56_5) / var_56_8
				local var_56_10 = Vector3.New(-390, -350, -180)

				var_56_4.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10022, var_56_10, var_56_9)
			end

			if arg_53_1.time_ >= var_56_5 + var_56_8 and arg_53_1.time_ < var_56_5 + var_56_8 + arg_56_0 then
				var_56_4.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_56_11 = arg_53_1.actors_["10022"]
			local var_56_12 = 0

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.actorSpriteComps10022 == nil then
				arg_53_1.var_.actorSpriteComps10022 = var_56_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_13 = 0.034

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_13 and not isNil(var_56_11) then
				local var_56_14 = (arg_53_1.time_ - var_56_12) / var_56_13

				if arg_53_1.var_.actorSpriteComps10022 then
					for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_56_4 then
							if arg_53_1.isInRecall_ then
								local var_56_15 = Mathf.Lerp(iter_56_4.color.r, arg_53_1.hightColor1.r, var_56_14)
								local var_56_16 = Mathf.Lerp(iter_56_4.color.g, arg_53_1.hightColor1.g, var_56_14)
								local var_56_17 = Mathf.Lerp(iter_56_4.color.b, arg_53_1.hightColor1.b, var_56_14)

								iter_56_4.color = Color.New(var_56_15, var_56_16, var_56_17)
							else
								local var_56_18 = Mathf.Lerp(iter_56_4.color.r, 1, var_56_14)

								iter_56_4.color = Color.New(var_56_18, var_56_18, var_56_18)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_12 + var_56_13 and arg_53_1.time_ < var_56_12 + var_56_13 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.actorSpriteComps10022 then
				for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_56_6 then
						if arg_53_1.isInRecall_ then
							iter_56_6.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10022 = nil
			end

			local var_56_19 = arg_53_1.actors_["10022"]
			local var_56_20 = 0

			if var_56_20 < arg_53_1.time_ and arg_53_1.time_ <= var_56_20 + arg_56_0 then
				local var_56_21 = var_56_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_56_21 then
					arg_53_1.var_.alphaOldValue10022 = var_56_21.alpha
					arg_53_1.var_.characterEffect10022 = var_56_21
				end

				arg_53_1.var_.alphaOldValue10022 = 0
			end

			local var_56_22 = 0.5

			if var_56_20 <= arg_53_1.time_ and arg_53_1.time_ < var_56_20 + var_56_22 then
				local var_56_23 = (arg_53_1.time_ - var_56_20) / var_56_22
				local var_56_24 = Mathf.Lerp(arg_53_1.var_.alphaOldValue10022, 1, var_56_23)

				if arg_53_1.var_.characterEffect10022 then
					arg_53_1.var_.characterEffect10022.alpha = var_56_24
				end
			end

			if arg_53_1.time_ >= var_56_20 + var_56_22 and arg_53_1.time_ < var_56_20 + var_56_22 + arg_56_0 and arg_53_1.var_.characterEffect10022 then
				arg_53_1.var_.characterEffect10022.alpha = 1
			end

			local var_56_25 = 0
			local var_56_26 = 0.475

			if var_56_25 < arg_53_1.time_ and arg_53_1.time_ <= var_56_25 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_27 = arg_53_1:FormatText(StoryNameCfg[235].name)

				arg_53_1.leftNameTxt_.text = var_56_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_28 = arg_53_1:GetWordFromCfg(114211013)
				local var_56_29 = arg_53_1:FormatText(var_56_28.content)

				arg_53_1.text_.text = var_56_29

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_30 = 19
				local var_56_31 = utf8.len(var_56_29)
				local var_56_32 = var_56_30 <= 0 and var_56_26 or var_56_26 * (var_56_31 / var_56_30)

				if var_56_32 > 0 and var_56_26 < var_56_32 then
					arg_53_1.talkMaxDuration = var_56_32

					if var_56_32 + var_56_25 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_32 + var_56_25
					end
				end

				arg_53_1.text_.text = var_56_29
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211013", "story_v_out_114211.awb") ~= 0 then
					local var_56_33 = manager.audio:GetVoiceLength("story_v_out_114211", "114211013", "story_v_out_114211.awb") / 1000

					if var_56_33 + var_56_25 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_33 + var_56_25
					end

					if var_56_28.prefab_name ~= "" and arg_53_1.actors_[var_56_28.prefab_name] ~= nil then
						local var_56_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_28.prefab_name].transform, "story_v_out_114211", "114211013", "story_v_out_114211.awb")

						arg_53_1:RecordAudio("114211013", var_56_34)
						arg_53_1:RecordAudio("114211013", var_56_34)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114211", "114211013", "story_v_out_114211.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114211", "114211013", "story_v_out_114211.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_35 = math.max(var_56_26, arg_53_1.talkMaxDuration)

			if var_56_25 <= arg_53_1.time_ and arg_53_1.time_ < var_56_25 + var_56_35 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_25) / var_56_35

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_25 + var_56_35 and arg_53_1.time_ < var_56_25 + var_56_35 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play114211014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114211014
		arg_57_1.duration_ = 9.43

		local var_57_0 = {
			ja = 7.9,
			ko = 6.5,
			zh = 8.833,
			en = 9.433
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
				arg_57_0:Play114211015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10017"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10017 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10017", 4)
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(390, -350, -180)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10017, var_60_4, var_60_3)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_60_5 = arg_57_1.actors_["10022"]
			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps10022 == nil then
				arg_57_1.var_.actorSpriteComps10022 = var_60_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_7 = 0.034

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_7 and not isNil(var_60_5) then
				local var_60_8 = (arg_57_1.time_ - var_60_6) / var_60_7

				if arg_57_1.var_.actorSpriteComps10022 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_9 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_8)
								local var_60_10 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_8)
								local var_60_11 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_8)

								iter_60_1.color = Color.New(var_60_9, var_60_10, var_60_11)
							else
								local var_60_12 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_8)

								iter_60_1.color = Color.New(var_60_12, var_60_12, var_60_12)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps10022 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10022 = nil
			end

			local var_60_13 = arg_57_1.actors_["10017"]
			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 and not isNil(var_60_13) then
				local var_60_15 = var_60_13:GetComponent("Image")

				if var_60_15 then
					arg_57_1.var_.highlightMatValue10017 = var_60_15
				end
			end

			local var_60_16 = 0.034

			if var_60_14 <= arg_57_1.time_ and arg_57_1.time_ < var_60_14 + var_60_16 and not isNil(var_60_13) then
				local var_60_17 = (arg_57_1.time_ - var_60_14) / var_60_16

				if arg_57_1.var_.highlightMatValue10017 then
					local var_60_18 = Mathf.Lerp(0.5, 1, var_60_17)
					local var_60_19 = arg_57_1.var_.highlightMatValue10017
					local var_60_20 = var_60_19.color

					var_60_20.r = var_60_18
					var_60_20.g = var_60_18
					var_60_20.b = var_60_18
					var_60_19.color = var_60_20
				end
			end

			if arg_57_1.time_ >= var_60_14 + var_60_16 and arg_57_1.time_ < var_60_14 + var_60_16 + arg_60_0 and not isNil(var_60_13) and arg_57_1.var_.highlightMatValue10017 then
				local var_60_21 = 1

				var_60_13.transform:SetSiblingIndex(1)

				local var_60_22 = arg_57_1.var_.highlightMatValue10017
				local var_60_23 = var_60_22.color

				var_60_23.r = var_60_21
				var_60_23.g = var_60_21
				var_60_23.b = var_60_21
				var_60_22.color = var_60_23
			end

			local var_60_24 = arg_57_1.actors_["10017"]
			local var_60_25 = 0

			if var_60_25 < arg_57_1.time_ and arg_57_1.time_ <= var_60_25 + arg_60_0 then
				local var_60_26 = var_60_24:GetComponent("Image")

				if var_60_26 then
					arg_57_1.var_.alphaMatValue10017 = var_60_26
					arg_57_1.var_.alphaOldValue10017 = var_60_26.color.a
				end

				arg_57_1.var_.alphaOldValue10017 = 0
			end

			local var_60_27 = 0.5

			if var_60_25 <= arg_57_1.time_ and arg_57_1.time_ < var_60_25 + var_60_27 then
				local var_60_28 = (arg_57_1.time_ - var_60_25) / var_60_27
				local var_60_29 = Mathf.Lerp(arg_57_1.var_.alphaOldValue10017, 1, var_60_28)

				if arg_57_1.var_.alphaMatValue10017 then
					local var_60_30 = arg_57_1.var_.alphaMatValue10017.color

					var_60_30.a = var_60_29
					arg_57_1.var_.alphaMatValue10017.color = var_60_30
				end
			end

			if arg_57_1.time_ >= var_60_25 + var_60_27 and arg_57_1.time_ < var_60_25 + var_60_27 + arg_60_0 and arg_57_1.var_.alphaMatValue10017 then
				local var_60_31 = arg_57_1.var_.alphaMatValue10017
				local var_60_32 = var_60_31.color

				var_60_32.a = 1
				var_60_31.color = var_60_32
			end

			local var_60_33 = 0
			local var_60_34 = 0.95

			if var_60_33 < arg_57_1.time_ and arg_57_1.time_ <= var_60_33 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_35 = arg_57_1:FormatText(StoryNameCfg[255].name)

				arg_57_1.leftNameTxt_.text = var_60_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_36 = arg_57_1:GetWordFromCfg(114211014)
				local var_60_37 = arg_57_1:FormatText(var_60_36.content)

				arg_57_1.text_.text = var_60_37

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_38 = 38
				local var_60_39 = utf8.len(var_60_37)
				local var_60_40 = var_60_38 <= 0 and var_60_34 or var_60_34 * (var_60_39 / var_60_38)

				if var_60_40 > 0 and var_60_34 < var_60_40 then
					arg_57_1.talkMaxDuration = var_60_40

					if var_60_40 + var_60_33 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_40 + var_60_33
					end
				end

				arg_57_1.text_.text = var_60_37
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211014", "story_v_out_114211.awb") ~= 0 then
					local var_60_41 = manager.audio:GetVoiceLength("story_v_out_114211", "114211014", "story_v_out_114211.awb") / 1000

					if var_60_41 + var_60_33 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_41 + var_60_33
					end

					if var_60_36.prefab_name ~= "" and arg_57_1.actors_[var_60_36.prefab_name] ~= nil then
						local var_60_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_36.prefab_name].transform, "story_v_out_114211", "114211014", "story_v_out_114211.awb")

						arg_57_1:RecordAudio("114211014", var_60_42)
						arg_57_1:RecordAudio("114211014", var_60_42)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114211", "114211014", "story_v_out_114211.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114211", "114211014", "story_v_out_114211.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_43 = math.max(var_60_34, arg_57_1.talkMaxDuration)

			if var_60_33 <= arg_57_1.time_ and arg_57_1.time_ < var_60_33 + var_60_43 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_33) / var_60_43

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_33 + var_60_43 and arg_57_1.time_ < var_60_33 + var_60_43 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10017",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play114211015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114211015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114211016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10017"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) then
				local var_64_2 = var_64_0:GetComponent("Image")

				if var_64_2 then
					arg_61_1.var_.highlightMatValue10017 = var_64_2
				end
			end

			local var_64_3 = 0.034

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_3 and not isNil(var_64_0) then
				local var_64_4 = (arg_61_1.time_ - var_64_1) / var_64_3

				if arg_61_1.var_.highlightMatValue10017 then
					local var_64_5 = Mathf.Lerp(1, 0.5, var_64_4)
					local var_64_6 = arg_61_1.var_.highlightMatValue10017
					local var_64_7 = var_64_6.color

					var_64_7.r = var_64_5
					var_64_7.g = var_64_5
					var_64_7.b = var_64_5
					var_64_6.color = var_64_7
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_3 and arg_61_1.time_ < var_64_1 + var_64_3 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.highlightMatValue10017 then
				local var_64_8 = 0.5
				local var_64_9 = arg_61_1.var_.highlightMatValue10017
				local var_64_10 = var_64_9.color

				var_64_10.r = var_64_8
				var_64_10.g = var_64_8
				var_64_10.b = var_64_8
				var_64_9.color = var_64_10
			end

			local var_64_11 = 0
			local var_64_12 = 0.7

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_13 = arg_61_1:GetWordFromCfg(114211015)
				local var_64_14 = arg_61_1:FormatText(var_64_13.content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_15 = 28
				local var_64_16 = utf8.len(var_64_14)
				local var_64_17 = var_64_15 <= 0 and var_64_12 or var_64_12 * (var_64_16 / var_64_15)

				if var_64_17 > 0 and var_64_12 < var_64_17 then
					arg_61_1.talkMaxDuration = var_64_17

					if var_64_17 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_18 and arg_61_1.time_ < var_64_11 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114211016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114211016
		arg_65_1.duration_ = 4.9

		local var_65_0 = {
			ja = 4.9,
			ko = 3.166,
			zh = 2.5,
			en = 2.3
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
				arg_65_0:Play114211017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10022"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10022 == nil then
				arg_65_1.var_.actorSpriteComps10022 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.034

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10022 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10022 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10022 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.375

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_10 = arg_65_1:FormatText(StoryNameCfg[235].name)

				arg_65_1.leftNameTxt_.text = var_68_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_11 = arg_65_1:GetWordFromCfg(114211016)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 15
				local var_68_14 = utf8.len(var_68_12)
				local var_68_15 = var_68_13 <= 0 and var_68_9 or var_68_9 * (var_68_14 / var_68_13)

				if var_68_15 > 0 and var_68_9 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_12
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211016", "story_v_out_114211.awb") ~= 0 then
					local var_68_16 = manager.audio:GetVoiceLength("story_v_out_114211", "114211016", "story_v_out_114211.awb") / 1000

					if var_68_16 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_8
					end

					if var_68_11.prefab_name ~= "" and arg_65_1.actors_[var_68_11.prefab_name] ~= nil then
						local var_68_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_11.prefab_name].transform, "story_v_out_114211", "114211016", "story_v_out_114211.awb")

						arg_65_1:RecordAudio("114211016", var_68_17)
						arg_65_1:RecordAudio("114211016", var_68_17)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114211", "114211016", "story_v_out_114211.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114211", "114211016", "story_v_out_114211.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_18 and arg_65_1.time_ < var_68_8 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114211017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114211017
		arg_69_1.duration_ = 7.07

		local var_69_0 = {
			ja = 5.566,
			ko = 6.7,
			zh = 7.066,
			en = 6.9
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
				arg_69_0:Play114211018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10022"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10022 == nil then
				arg_69_1.var_.actorSpriteComps10022 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.034

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps10022 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps10022 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10022 = nil
			end

			local var_72_8 = arg_69_1.actors_["10017"]
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 and not isNil(var_72_8) then
				local var_72_10 = var_72_8:GetComponent("Image")

				if var_72_10 then
					arg_69_1.var_.highlightMatValue10017 = var_72_10
				end
			end

			local var_72_11 = 0.034

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_11 and not isNil(var_72_8) then
				local var_72_12 = (arg_69_1.time_ - var_72_9) / var_72_11

				if arg_69_1.var_.highlightMatValue10017 then
					local var_72_13 = Mathf.Lerp(0.5, 1, var_72_12)
					local var_72_14 = arg_69_1.var_.highlightMatValue10017
					local var_72_15 = var_72_14.color

					var_72_15.r = var_72_13
					var_72_15.g = var_72_13
					var_72_15.b = var_72_13
					var_72_14.color = var_72_15
				end
			end

			if arg_69_1.time_ >= var_72_9 + var_72_11 and arg_69_1.time_ < var_72_9 + var_72_11 + arg_72_0 and not isNil(var_72_8) and arg_69_1.var_.highlightMatValue10017 then
				local var_72_16 = 1

				var_72_8.transform:SetSiblingIndex(1)

				local var_72_17 = arg_69_1.var_.highlightMatValue10017
				local var_72_18 = var_72_17.color

				var_72_18.r = var_72_16
				var_72_18.g = var_72_16
				var_72_18.b = var_72_16
				var_72_17.color = var_72_18
			end

			local var_72_19 = 0
			local var_72_20 = 0.725

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_21 = arg_69_1:FormatText(StoryNameCfg[255].name)

				arg_69_1.leftNameTxt_.text = var_72_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_22 = arg_69_1:GetWordFromCfg(114211017)
				local var_72_23 = arg_69_1:FormatText(var_72_22.content)

				arg_69_1.text_.text = var_72_23

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_24 = 29
				local var_72_25 = utf8.len(var_72_23)
				local var_72_26 = var_72_24 <= 0 and var_72_20 or var_72_20 * (var_72_25 / var_72_24)

				if var_72_26 > 0 and var_72_20 < var_72_26 then
					arg_69_1.talkMaxDuration = var_72_26

					if var_72_26 + var_72_19 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_26 + var_72_19
					end
				end

				arg_69_1.text_.text = var_72_23
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211017", "story_v_out_114211.awb") ~= 0 then
					local var_72_27 = manager.audio:GetVoiceLength("story_v_out_114211", "114211017", "story_v_out_114211.awb") / 1000

					if var_72_27 + var_72_19 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_27 + var_72_19
					end

					if var_72_22.prefab_name ~= "" and arg_69_1.actors_[var_72_22.prefab_name] ~= nil then
						local var_72_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_22.prefab_name].transform, "story_v_out_114211", "114211017", "story_v_out_114211.awb")

						arg_69_1:RecordAudio("114211017", var_72_28)
						arg_69_1:RecordAudio("114211017", var_72_28)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114211", "114211017", "story_v_out_114211.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114211", "114211017", "story_v_out_114211.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_29 = math.max(var_72_20, arg_69_1.talkMaxDuration)

			if var_72_19 <= arg_69_1.time_ and arg_69_1.time_ < var_72_19 + var_72_29 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_19) / var_72_29

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_19 + var_72_29 and arg_69_1.time_ < var_72_19 + var_72_29 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114211018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114211018
		arg_73_1.duration_ = 6.93

		local var_73_0 = {
			ja = 6.933,
			ko = 3.533,
			zh = 2.966,
			en = 2.566
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
				arg_73_0:Play114211019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10022"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10022 == nil then
				arg_73_1.var_.actorSpriteComps10022 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.034

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10022 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 1, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10022 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10022 = nil
			end

			local var_76_8 = arg_73_1.actors_["10017"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) then
				local var_76_10 = var_76_8:GetComponent("Image")

				if var_76_10 then
					arg_73_1.var_.highlightMatValue10017 = var_76_10
				end
			end

			local var_76_11 = 0.034

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_11 and not isNil(var_76_8) then
				local var_76_12 = (arg_73_1.time_ - var_76_9) / var_76_11

				if arg_73_1.var_.highlightMatValue10017 then
					local var_76_13 = Mathf.Lerp(1, 0.5, var_76_12)
					local var_76_14 = arg_73_1.var_.highlightMatValue10017
					local var_76_15 = var_76_14.color

					var_76_15.r = var_76_13
					var_76_15.g = var_76_13
					var_76_15.b = var_76_13
					var_76_14.color = var_76_15
				end
			end

			if arg_73_1.time_ >= var_76_9 + var_76_11 and arg_73_1.time_ < var_76_9 + var_76_11 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.highlightMatValue10017 then
				local var_76_16 = 0.5
				local var_76_17 = arg_73_1.var_.highlightMatValue10017
				local var_76_18 = var_76_17.color

				var_76_18.r = var_76_16
				var_76_18.g = var_76_16
				var_76_18.b = var_76_16
				var_76_17.color = var_76_18
			end

			local var_76_19 = 0
			local var_76_20 = 0.375

			if var_76_19 < arg_73_1.time_ and arg_73_1.time_ <= var_76_19 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_21 = arg_73_1:FormatText(StoryNameCfg[235].name)

				arg_73_1.leftNameTxt_.text = var_76_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_22 = arg_73_1:GetWordFromCfg(114211018)
				local var_76_23 = arg_73_1:FormatText(var_76_22.content)

				arg_73_1.text_.text = var_76_23

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_24 = 15
				local var_76_25 = utf8.len(var_76_23)
				local var_76_26 = var_76_24 <= 0 and var_76_20 or var_76_20 * (var_76_25 / var_76_24)

				if var_76_26 > 0 and var_76_20 < var_76_26 then
					arg_73_1.talkMaxDuration = var_76_26

					if var_76_26 + var_76_19 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_26 + var_76_19
					end
				end

				arg_73_1.text_.text = var_76_23
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211018", "story_v_out_114211.awb") ~= 0 then
					local var_76_27 = manager.audio:GetVoiceLength("story_v_out_114211", "114211018", "story_v_out_114211.awb") / 1000

					if var_76_27 + var_76_19 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_27 + var_76_19
					end

					if var_76_22.prefab_name ~= "" and arg_73_1.actors_[var_76_22.prefab_name] ~= nil then
						local var_76_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_22.prefab_name].transform, "story_v_out_114211", "114211018", "story_v_out_114211.awb")

						arg_73_1:RecordAudio("114211018", var_76_28)
						arg_73_1:RecordAudio("114211018", var_76_28)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114211", "114211018", "story_v_out_114211.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114211", "114211018", "story_v_out_114211.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_29 = math.max(var_76_20, arg_73_1.talkMaxDuration)

			if var_76_19 <= arg_73_1.time_ and arg_73_1.time_ < var_76_19 + var_76_29 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_19) / var_76_29

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_19 + var_76_29 and arg_73_1.time_ < var_76_19 + var_76_29 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114211019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114211019
		arg_77_1.duration_ = 4.97

		local var_77_0 = {
			ja = 4.966,
			ko = 3.1,
			zh = 3.566,
			en = 3.466
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
				arg_77_0:Play114211020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10015"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10015 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10015", 4)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "split_1" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(390, -350, -180)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10015, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_80_7 = arg_77_1.actors_["10022"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10022 == nil then
				arg_77_1.var_.actorSpriteComps10022 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 0.034

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10022 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								local var_80_11 = Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor2.r, var_80_10)
								local var_80_12 = Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor2.g, var_80_10)
								local var_80_13 = Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor2.b, var_80_10)

								iter_80_2.color = Color.New(var_80_11, var_80_12, var_80_13)
							else
								local var_80_14 = Mathf.Lerp(iter_80_2.color.r, 0.5, var_80_10)

								iter_80_2.color = Color.New(var_80_14, var_80_14, var_80_14)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10022 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10022 = nil
			end

			local var_80_15 = arg_77_1.actors_["10015"]
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps10015 == nil then
				arg_77_1.var_.actorSpriteComps10015 = var_80_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_17 = 0.034

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 and not isNil(var_80_15) then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17

				if arg_77_1.var_.actorSpriteComps10015 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_80_6 then
							if arg_77_1.isInRecall_ then
								local var_80_19 = Mathf.Lerp(iter_80_6.color.r, arg_77_1.hightColor1.r, var_80_18)
								local var_80_20 = Mathf.Lerp(iter_80_6.color.g, arg_77_1.hightColor1.g, var_80_18)
								local var_80_21 = Mathf.Lerp(iter_80_6.color.b, arg_77_1.hightColor1.b, var_80_18)

								iter_80_6.color = Color.New(var_80_19, var_80_20, var_80_21)
							else
								local var_80_22 = Mathf.Lerp(iter_80_6.color.r, 1, var_80_18)

								iter_80_6.color = Color.New(var_80_22, var_80_22, var_80_22)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps10015 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_80_8 then
						if arg_77_1.isInRecall_ then
							iter_80_8.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10015 = nil
			end

			local var_80_23 = arg_77_1.actors_["10015"]
			local var_80_24 = 0

			if var_80_24 < arg_77_1.time_ and arg_77_1.time_ <= var_80_24 + arg_80_0 then
				local var_80_25 = var_80_23:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_25 then
					arg_77_1.var_.alphaOldValue10015 = var_80_25.alpha
					arg_77_1.var_.characterEffect10015 = var_80_25
				end

				arg_77_1.var_.alphaOldValue10015 = 0
			end

			local var_80_26 = 0.5

			if var_80_24 <= arg_77_1.time_ and arg_77_1.time_ < var_80_24 + var_80_26 then
				local var_80_27 = (arg_77_1.time_ - var_80_24) / var_80_26
				local var_80_28 = Mathf.Lerp(arg_77_1.var_.alphaOldValue10015, 1, var_80_27)

				if arg_77_1.var_.characterEffect10015 then
					arg_77_1.var_.characterEffect10015.alpha = var_80_28
				end
			end

			if arg_77_1.time_ >= var_80_24 + var_80_26 and arg_77_1.time_ < var_80_24 + var_80_26 + arg_80_0 and arg_77_1.var_.characterEffect10015 then
				arg_77_1.var_.characterEffect10015.alpha = 1
			end

			local var_80_29 = 0
			local var_80_30 = 0.4

			if var_80_29 < arg_77_1.time_ and arg_77_1.time_ <= var_80_29 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_31 = arg_77_1:FormatText(StoryNameCfg[208].name)

				arg_77_1.leftNameTxt_.text = var_80_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_32 = arg_77_1:GetWordFromCfg(114211019)
				local var_80_33 = arg_77_1:FormatText(var_80_32.content)

				arg_77_1.text_.text = var_80_33

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_34 = 16
				local var_80_35 = utf8.len(var_80_33)
				local var_80_36 = var_80_34 <= 0 and var_80_30 or var_80_30 * (var_80_35 / var_80_34)

				if var_80_36 > 0 and var_80_30 < var_80_36 then
					arg_77_1.talkMaxDuration = var_80_36

					if var_80_36 + var_80_29 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_36 + var_80_29
					end
				end

				arg_77_1.text_.text = var_80_33
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211019", "story_v_out_114211.awb") ~= 0 then
					local var_80_37 = manager.audio:GetVoiceLength("story_v_out_114211", "114211019", "story_v_out_114211.awb") / 1000

					if var_80_37 + var_80_29 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_37 + var_80_29
					end

					if var_80_32.prefab_name ~= "" and arg_77_1.actors_[var_80_32.prefab_name] ~= nil then
						local var_80_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_32.prefab_name].transform, "story_v_out_114211", "114211019", "story_v_out_114211.awb")

						arg_77_1:RecordAudio("114211019", var_80_38)
						arg_77_1:RecordAudio("114211019", var_80_38)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114211", "114211019", "story_v_out_114211.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114211", "114211019", "story_v_out_114211.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_39 = math.max(var_80_30, arg_77_1.talkMaxDuration)

			if var_80_29 <= arg_77_1.time_ and arg_77_1.time_ < var_80_29 + var_80_39 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_29) / var_80_39

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_29 + var_80_39 and arg_77_1.time_ < var_80_29 + var_80_39 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114211020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114211020
		arg_81_1.duration_ = 2.03

		local var_81_0 = {
			ja = 2,
			ko = 1.166,
			zh = 2.033,
			en = 1.166
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
				arg_81_0:Play114211021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10022"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10022 == nil then
				arg_81_1.var_.actorSpriteComps10022 = var_84_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_2 = 0.034

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.actorSpriteComps10022 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.actorSpriteComps10022 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_84_3 then
						if arg_81_1.isInRecall_ then
							iter_84_3.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10022 = nil
			end

			local var_84_8 = arg_81_1.actors_["10015"]
			local var_84_9 = 0

			if var_84_9 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10015 == nil then
				arg_81_1.var_.actorSpriteComps10015 = var_84_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_10 = 0.034

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 and not isNil(var_84_8) then
				local var_84_11 = (arg_81_1.time_ - var_84_9) / var_84_10

				if arg_81_1.var_.actorSpriteComps10015 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.actorSpriteComps10015 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_84_7 then
						if arg_81_1.isInRecall_ then
							iter_84_7.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10015 = nil
			end

			local var_84_16 = arg_81_1.actors_["10022"].transform
			local var_84_17 = 0

			if var_84_17 < arg_81_1.time_ and arg_81_1.time_ <= var_84_17 + arg_84_0 then
				arg_81_1.var_.moveOldPos10022 = var_84_16.localPosition
				var_84_16.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10022", 2)

				local var_84_18 = var_84_16.childCount

				for iter_84_8 = 0, var_84_18 - 1 do
					local var_84_19 = var_84_16:GetChild(iter_84_8)

					if var_84_19.name == "split_6" or not string.find(var_84_19.name, "split") then
						var_84_19.gameObject:SetActive(true)
					else
						var_84_19.gameObject:SetActive(false)
					end
				end
			end

			local var_84_20 = 0.001

			if var_84_17 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_20 then
				local var_84_21 = (arg_81_1.time_ - var_84_17) / var_84_20
				local var_84_22 = Vector3.New(-390, -350, -180)

				var_84_16.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10022, var_84_22, var_84_21)
			end

			if arg_81_1.time_ >= var_84_17 + var_84_20 and arg_81_1.time_ < var_84_17 + var_84_20 + arg_84_0 then
				var_84_16.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_84_23 = 0
			local var_84_24 = 0.1

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[235].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(114211020)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211020", "story_v_out_114211.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_114211", "114211020", "story_v_out_114211.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_114211", "114211020", "story_v_out_114211.awb")

						arg_81_1:RecordAudio("114211020", var_84_32)
						arg_81_1:RecordAudio("114211020", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114211", "114211020", "story_v_out_114211.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114211", "114211020", "story_v_out_114211.awb")
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
				actorName = "10022",
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
	Play114211021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114211021
		arg_85_1.duration_ = 7.1

		local var_85_0 = {
			ja = 7.1,
			ko = 5.8,
			zh = 4.366,
			en = 4.033
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
				arg_85_0:Play114211022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10022"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10022 == nil then
				arg_85_1.var_.actorSpriteComps10022 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.034

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10022 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10022 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10022 = nil
			end

			local var_88_8 = arg_85_1.actors_["10015"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10015 == nil then
				arg_85_1.var_.actorSpriteComps10015 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.034

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps10015 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor1.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor1.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor1.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 1, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps10015 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10015 = nil
			end

			local var_88_16 = 0
			local var_88_17 = 0.575

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_18 = arg_85_1:FormatText(StoryNameCfg[208].name)

				arg_85_1.leftNameTxt_.text = var_88_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(114211021)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_114211", "114211021", "story_v_out_114211.awb") ~= 0 then
					local var_88_24 = manager.audio:GetVoiceLength("story_v_out_114211", "114211021", "story_v_out_114211.awb") / 1000

					if var_88_24 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_114211", "114211021", "story_v_out_114211.awb")

						arg_85_1:RecordAudio("114211021", var_88_25)
						arg_85_1:RecordAudio("114211021", var_88_25)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114211", "114211021", "story_v_out_114211.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114211", "114211021", "story_v_out_114211.awb")
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
	Play114211022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114211022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
			arg_89_1.auto_ = false
		end

		function arg_89_1.playNext_(arg_91_0)
			arg_89_1.onStoryFinished_()
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10022"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				local var_92_2 = var_92_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_92_2 then
					arg_89_1.var_.alphaOldValue10022 = var_92_2.alpha
					arg_89_1.var_.characterEffect10022 = var_92_2
				end

				arg_89_1.var_.alphaOldValue10022 = 1
			end

			local var_92_3 = 0.5

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_3 then
				local var_92_4 = (arg_89_1.time_ - var_92_1) / var_92_3
				local var_92_5 = Mathf.Lerp(arg_89_1.var_.alphaOldValue10022, 0, var_92_4)

				if arg_89_1.var_.characterEffect10022 then
					arg_89_1.var_.characterEffect10022.alpha = var_92_5
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_3 and arg_89_1.time_ < var_92_1 + var_92_3 + arg_92_0 and arg_89_1.var_.characterEffect10022 then
				arg_89_1.var_.characterEffect10022.alpha = 0
			end

			local var_92_6 = 0
			local var_92_7 = 1.325

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(114211022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 53
				local var_92_11 = utf8.len(var_92_9)
				local var_92_12 = var_92_10 <= 0 and var_92_7 or var_92_7 * (var_92_11 / var_92_10)

				if var_92_12 > 0 and var_92_7 < var_92_12 then
					arg_89_1.talkMaxDuration = var_92_12

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_13 and arg_89_1.time_ < var_92_6 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04"
	},
	voices = {
		"story_v_out_114211.awb"
	}
}
