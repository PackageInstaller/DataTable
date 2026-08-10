return {
	Play413112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413112001
		arg_1_1.duration_ = 5.67

		local var_1_0 = {
			zh = 4.93333333333333,
			ja = 5.66633333333333
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
				arg_1_0:Play413112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F10g"

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
				local var_4_5 = arg_1_1.bgs_.F10g

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
					if iter_4_0 ~= "F10g" then
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

			local var_4_24 = "10092_1"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092_1")

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

			local var_4_28 = arg_1_1.actors_["10092_1"].transform
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.var_.moveOldPos10092_1 = var_4_28.localPosition
				var_4_28.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10092_1", 3)

				local var_4_30 = var_4_28.childCount

				for iter_4_4 = 0, var_4_30 - 1 do
					local var_4_31 = var_4_28:GetChild(iter_4_4)

					if var_4_31.name == "split_8" or not string.find(var_4_31.name, "split") then
						var_4_31.gameObject:SetActive(true)
					else
						var_4_31.gameObject:SetActive(false)
					end
				end
			end

			local var_4_32 = 0.001

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_29) / var_4_32
				local var_4_34 = Vector3.New(0, -300, -295)

				var_4_28.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10092_1, var_4_34, var_4_33)
			end

			if arg_1_1.time_ >= var_4_29 + var_4_32 and arg_1_1.time_ < var_4_29 + var_4_32 + arg_4_0 then
				var_4_28.localPosition = Vector3.New(0, -300, -295)
			end

			local var_4_35 = arg_1_1.actors_["10092_1"]
			local var_4_36 = 1.8

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10092_1 == nil then
				arg_1_1.var_.actorSpriteComps10092_1 = var_4_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_37 = 2

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 and not isNil(var_4_35) then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37

				if arg_1_1.var_.actorSpriteComps10092_1 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								local var_4_39 = Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, var_4_38)
								local var_4_40 = Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, var_4_38)
								local var_4_41 = Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, var_4_38)

								iter_4_6.color = Color.New(var_4_39, var_4_40, var_4_41)
							else
								local var_4_42 = Mathf.Lerp(iter_4_6.color.r, 1, var_4_38)

								iter_4_6.color = Color.New(var_4_42, var_4_42, var_4_42)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 and not isNil(var_4_35) and arg_1_1.var_.actorSpriteComps10092_1 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_4_8 then
						if arg_1_1.isInRecall_ then
							iter_4_8.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_4_43 = arg_1_1.actors_["10092_1"]
			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_45 = var_4_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_45 then
					arg_1_1.var_.alphaOldValue10092_1 = var_4_45.alpha
					arg_1_1.var_.characterEffect10092_1 = var_4_45
				end

				arg_1_1.var_.alphaOldValue10092_1 = 0
			end

			local var_4_46 = 0.2

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_44) / var_4_46
				local var_4_48 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10092_1, 1, var_4_47)

				if arg_1_1.var_.characterEffect10092_1 then
					arg_1_1.var_.characterEffect10092_1.alpha = var_4_48
				end
			end

			if arg_1_1.time_ >= var_4_44 + var_4_46 and arg_1_1.time_ < var_4_44 + var_4_46 + arg_4_0 and arg_1_1.var_.characterEffect10092_1 then
				arg_1_1.var_.characterEffect10092_1.alpha = 1
			end

			local var_4_49 = 0
			local var_4_50 = 0.433333333333333

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

			local var_4_55 = 1.26666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_3_4_story_deckbridge", "bgm_activity_3_4_story_deckbridge")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_61 = 2.13333333333333
			local var_4_62 = 0.275

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[996].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(413112001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 11
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_62 or var_4_62 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_62 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69
					var_4_61 = var_4_61 + 0.3

					if var_4_69 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112001", "story_v_out_413112.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_413112", "413112001", "story_v_out_413112.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_413112", "413112001", "story_v_out_413112.awb")

						arg_1_1:RecordAudio("413112001", var_4_71)
						arg_1_1:RecordAudio("413112001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413112", "413112001", "story_v_out_413112.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413112", "413112001", "story_v_out_413112.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = var_4_61 + 0.3
			local var_4_73 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_72 <= arg_1_1.time_ and arg_1_1.time_ < var_4_72 + var_4_73 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_72) / var_4_73

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_72 + var_4_73 and arg_1_1.time_ < var_4_72 + var_4_73 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413112002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413112002
		arg_9_1.duration_ = 6.63

		local var_9_0 = {
			zh = 6.633,
			ja = 4.9
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
				arg_9_0:Play413112003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "10093"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

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

			local var_12_4 = arg_9_1.actors_["10093"].transform
			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.var_.moveOldPos10093 = var_12_4.localPosition
				var_12_4.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10093", 4)

				local var_12_6 = var_12_4.childCount

				for iter_12_2 = 0, var_12_6 - 1 do
					local var_12_7 = var_12_4:GetChild(iter_12_2)

					if var_12_7.name == "split_4" or not string.find(var_12_7.name, "split") then
						var_12_7.gameObject:SetActive(true)
					else
						var_12_7.gameObject:SetActive(false)
					end
				end
			end

			local var_12_8 = 0.001

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_5) / var_12_8
				local var_12_10 = Vector3.New(390, -345, -245)

				var_12_4.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10093, var_12_10, var_12_9)
			end

			if arg_9_1.time_ >= var_12_5 + var_12_8 and arg_9_1.time_ < var_12_5 + var_12_8 + arg_12_0 then
				var_12_4.localPosition = Vector3.New(390, -345, -245)
			end

			local var_12_11 = arg_9_1.actors_["10092_1"].transform
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.var_.moveOldPos10092_1 = var_12_11.localPosition
				var_12_11.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10092_1", 2)

				local var_12_13 = var_12_11.childCount

				for iter_12_3 = 0, var_12_13 - 1 do
					local var_12_14 = var_12_11:GetChild(iter_12_3)

					if var_12_14.name == "split_8" or not string.find(var_12_14.name, "split") then
						var_12_14.gameObject:SetActive(true)
					else
						var_12_14.gameObject:SetActive(false)
					end
				end
			end

			local var_12_15 = 0.001

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_15 then
				local var_12_16 = (arg_9_1.time_ - var_12_12) / var_12_15
				local var_12_17 = Vector3.New(-389.49, -300, -295)

				var_12_11.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10092_1, var_12_17, var_12_16)
			end

			if arg_9_1.time_ >= var_12_12 + var_12_15 and arg_9_1.time_ < var_12_12 + var_12_15 + arg_12_0 then
				var_12_11.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_12_18 = arg_9_1.actors_["10093"]
			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.actorSpriteComps10093 == nil then
				arg_9_1.var_.actorSpriteComps10093 = var_12_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_20 = 2

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_20 and not isNil(var_12_18) then
				local var_12_21 = (arg_9_1.time_ - var_12_19) / var_12_20

				if arg_9_1.var_.actorSpriteComps10093 then
					for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_12_5 then
							if arg_9_1.isInRecall_ then
								local var_12_22 = Mathf.Lerp(iter_12_5.color.r, arg_9_1.hightColor1.r, var_12_21)
								local var_12_23 = Mathf.Lerp(iter_12_5.color.g, arg_9_1.hightColor1.g, var_12_21)
								local var_12_24 = Mathf.Lerp(iter_12_5.color.b, arg_9_1.hightColor1.b, var_12_21)

								iter_12_5.color = Color.New(var_12_22, var_12_23, var_12_24)
							else
								local var_12_25 = Mathf.Lerp(iter_12_5.color.r, 1, var_12_21)

								iter_12_5.color = Color.New(var_12_25, var_12_25, var_12_25)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_19 + var_12_20 and arg_9_1.time_ < var_12_19 + var_12_20 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.actorSpriteComps10093 then
				for iter_12_6, iter_12_7 in pairs(arg_9_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_12_7 then
						if arg_9_1.isInRecall_ then
							iter_12_7.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10093 = nil
			end

			local var_12_26 = arg_9_1.actors_["10092_1"]
			local var_12_27 = 0

			if var_12_27 < arg_9_1.time_ and arg_9_1.time_ <= var_12_27 + arg_12_0 and not isNil(var_12_26) and arg_9_1.var_.actorSpriteComps10092_1 == nil then
				arg_9_1.var_.actorSpriteComps10092_1 = var_12_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_28 = 2

			if var_12_27 <= arg_9_1.time_ and arg_9_1.time_ < var_12_27 + var_12_28 and not isNil(var_12_26) then
				local var_12_29 = (arg_9_1.time_ - var_12_27) / var_12_28

				if arg_9_1.var_.actorSpriteComps10092_1 then
					for iter_12_8, iter_12_9 in pairs(arg_9_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_12_9 then
							if arg_9_1.isInRecall_ then
								local var_12_30 = Mathf.Lerp(iter_12_9.color.r, arg_9_1.hightColor2.r, var_12_29)
								local var_12_31 = Mathf.Lerp(iter_12_9.color.g, arg_9_1.hightColor2.g, var_12_29)
								local var_12_32 = Mathf.Lerp(iter_12_9.color.b, arg_9_1.hightColor2.b, var_12_29)

								iter_12_9.color = Color.New(var_12_30, var_12_31, var_12_32)
							else
								local var_12_33 = Mathf.Lerp(iter_12_9.color.r, 0.5, var_12_29)

								iter_12_9.color = Color.New(var_12_33, var_12_33, var_12_33)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_27 + var_12_28 and arg_9_1.time_ < var_12_27 + var_12_28 + arg_12_0 and not isNil(var_12_26) and arg_9_1.var_.actorSpriteComps10092_1 then
				for iter_12_10, iter_12_11 in pairs(arg_9_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_12_11 then
						if arg_9_1.isInRecall_ then
							iter_12_11.color = arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_12_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_12_34 = 0
			local var_12_35 = 0.775

			if var_12_34 < arg_9_1.time_ and arg_9_1.time_ <= var_12_34 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_36 = arg_9_1:FormatText(StoryNameCfg[28].name)

				arg_9_1.leftNameTxt_.text = var_12_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_37 = arg_9_1:GetWordFromCfg(413112002)
				local var_12_38 = arg_9_1:FormatText(var_12_37.content)

				arg_9_1.text_.text = var_12_38

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_39 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112002", "story_v_out_413112.awb") ~= 0 then
					local var_12_42 = manager.audio:GetVoiceLength("story_v_out_413112", "413112002", "story_v_out_413112.awb") / 1000

					if var_12_42 + var_12_34 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_42 + var_12_34
					end

					if var_12_37.prefab_name ~= "" and arg_9_1.actors_[var_12_37.prefab_name] ~= nil then
						local var_12_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_37.prefab_name].transform, "story_v_out_413112", "413112002", "story_v_out_413112.awb")

						arg_9_1:RecordAudio("413112002", var_12_43)
						arg_9_1:RecordAudio("413112002", var_12_43)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413112", "413112002", "story_v_out_413112.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413112", "413112002", "story_v_out_413112.awb")
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413112003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413112003
		arg_13_1.duration_ = 6.17

		local var_13_0 = {
			zh = 4.1,
			ja = 6.166
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
				arg_13_0:Play413112004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10092_1"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos10092_1 = var_16_0.localPosition
				var_16_0.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10092_1", 2)

				local var_16_2 = var_16_0.childCount

				for iter_16_0 = 0, var_16_2 - 1 do
					local var_16_3 = var_16_0:GetChild(iter_16_0)

					if var_16_3.name == "split_2" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_4 then
				local var_16_5 = (arg_13_1.time_ - var_16_1) / var_16_4
				local var_16_6 = Vector3.New(-389.49, -300, -295)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10092_1, var_16_6, var_16_5)
			end

			if arg_13_1.time_ >= var_16_1 + var_16_4 and arg_13_1.time_ < var_16_1 + var_16_4 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_16_7 = arg_13_1.actors_["10092_1"]
			local var_16_8 = 0

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10092_1 == nil then
				arg_13_1.var_.actorSpriteComps10092_1 = var_16_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 2

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_9 and not isNil(var_16_7) then
				local var_16_10 = (arg_13_1.time_ - var_16_8) / var_16_9

				if arg_13_1.var_.actorSpriteComps10092_1 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_16_2 then
							if arg_13_1.isInRecall_ then
								local var_16_11 = Mathf.Lerp(iter_16_2.color.r, arg_13_1.hightColor1.r, var_16_10)
								local var_16_12 = Mathf.Lerp(iter_16_2.color.g, arg_13_1.hightColor1.g, var_16_10)
								local var_16_13 = Mathf.Lerp(iter_16_2.color.b, arg_13_1.hightColor1.b, var_16_10)

								iter_16_2.color = Color.New(var_16_11, var_16_12, var_16_13)
							else
								local var_16_14 = Mathf.Lerp(iter_16_2.color.r, 1, var_16_10)

								iter_16_2.color = Color.New(var_16_14, var_16_14, var_16_14)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_8 + var_16_9 and arg_13_1.time_ < var_16_8 + var_16_9 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.actorSpriteComps10092_1 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_16_4 then
						if arg_13_1.isInRecall_ then
							iter_16_4.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_16_15 = arg_13_1.actors_["10093"]
			local var_16_16 = 0

			if var_16_16 < arg_13_1.time_ and arg_13_1.time_ <= var_16_16 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.actorSpriteComps10093 == nil then
				arg_13_1.var_.actorSpriteComps10093 = var_16_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_17 = 2

			if var_16_16 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 and not isNil(var_16_15) then
				local var_16_18 = (arg_13_1.time_ - var_16_16) / var_16_17

				if arg_13_1.var_.actorSpriteComps10093 then
					for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_16_6 then
							if arg_13_1.isInRecall_ then
								local var_16_19 = Mathf.Lerp(iter_16_6.color.r, arg_13_1.hightColor2.r, var_16_18)
								local var_16_20 = Mathf.Lerp(iter_16_6.color.g, arg_13_1.hightColor2.g, var_16_18)
								local var_16_21 = Mathf.Lerp(iter_16_6.color.b, arg_13_1.hightColor2.b, var_16_18)

								iter_16_6.color = Color.New(var_16_19, var_16_20, var_16_21)
							else
								local var_16_22 = Mathf.Lerp(iter_16_6.color.r, 0.5, var_16_18)

								iter_16_6.color = Color.New(var_16_22, var_16_22, var_16_22)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 and not isNil(var_16_15) and arg_13_1.var_.actorSpriteComps10093 then
				for iter_16_7, iter_16_8 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_16_8 then
						if arg_13_1.isInRecall_ then
							iter_16_8.color = arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_16_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10093 = nil
			end

			local var_16_23 = 0
			local var_16_24 = 0.425

			if var_16_23 < arg_13_1.time_ and arg_13_1.time_ <= var_16_23 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_25 = arg_13_1:FormatText(StoryNameCfg[996].name)

				arg_13_1.leftNameTxt_.text = var_16_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_26 = arg_13_1:GetWordFromCfg(413112003)
				local var_16_27 = arg_13_1:FormatText(var_16_26.content)

				arg_13_1.text_.text = var_16_27

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_28 = 17
				local var_16_29 = utf8.len(var_16_27)
				local var_16_30 = var_16_28 <= 0 and var_16_24 or var_16_24 * (var_16_29 / var_16_28)

				if var_16_30 > 0 and var_16_24 < var_16_30 then
					arg_13_1.talkMaxDuration = var_16_30

					if var_16_30 + var_16_23 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_30 + var_16_23
					end
				end

				arg_13_1.text_.text = var_16_27
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112003", "story_v_out_413112.awb") ~= 0 then
					local var_16_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112003", "story_v_out_413112.awb") / 1000

					if var_16_31 + var_16_23 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_31 + var_16_23
					end

					if var_16_26.prefab_name ~= "" and arg_13_1.actors_[var_16_26.prefab_name] ~= nil then
						local var_16_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_26.prefab_name].transform, "story_v_out_413112", "413112003", "story_v_out_413112.awb")

						arg_13_1:RecordAudio("413112003", var_16_32)
						arg_13_1:RecordAudio("413112003", var_16_32)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413112", "413112003", "story_v_out_413112.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413112", "413112003", "story_v_out_413112.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_33 = math.max(var_16_24, arg_13_1.talkMaxDuration)

			if var_16_23 <= arg_13_1.time_ and arg_13_1.time_ < var_16_23 + var_16_33 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_23) / var_16_33

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_23 + var_16_33 and arg_13_1.time_ < var_16_23 + var_16_33 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play413112004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413112004
		arg_17_1.duration_ = 8

		local var_17_0 = {
			zh = 6.966,
			ja = 8
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
				arg_17_0:Play413112005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.85

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[996].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(413112004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 34
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112004", "story_v_out_413112.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112004", "story_v_out_413112.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_413112", "413112004", "story_v_out_413112.awb")

						arg_17_1:RecordAudio("413112004", var_20_9)
						arg_17_1:RecordAudio("413112004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413112", "413112004", "story_v_out_413112.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413112", "413112004", "story_v_out_413112.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play413112005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413112005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play413112006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10092_1"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos10092_1 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10092_1", 6)

				local var_24_2 = var_24_0.childCount

				for iter_24_0 = 0, var_24_2 - 1 do
					local var_24_3 = var_24_0:GetChild(iter_24_0)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_4 then
				local var_24_5 = (arg_21_1.time_ - var_24_1) / var_24_4
				local var_24_6 = Vector3.New(1500, -300, -295)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10092_1, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_24_7 = arg_21_1.actors_["10093"].transform
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.var_.moveOldPos10093 = var_24_7.localPosition
				var_24_7.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10093", 6)

				local var_24_9 = var_24_7.childCount

				for iter_24_1 = 0, var_24_9 - 1 do
					local var_24_10 = var_24_7:GetChild(iter_24_1)

					if var_24_10.name == "" or not string.find(var_24_10.name, "split") then
						var_24_10.gameObject:SetActive(true)
					else
						var_24_10.gameObject:SetActive(false)
					end
				end
			end

			local var_24_11 = 0.001

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_11 then
				local var_24_12 = (arg_21_1.time_ - var_24_8) / var_24_11
				local var_24_13 = Vector3.New(1500, -345, -245)

				var_24_7.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10093, var_24_13, var_24_12)
			end

			if arg_21_1.time_ >= var_24_8 + var_24_11 and arg_21_1.time_ < var_24_8 + var_24_11 + arg_24_0 then
				var_24_7.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_24_14 = arg_21_1.actors_["10092_1"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps10092_1 == nil then
				arg_21_1.var_.actorSpriteComps10092_1 = var_24_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_16 = 2

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.actorSpriteComps10092_1 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								local var_24_18 = Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor2.r, var_24_17)
								local var_24_19 = Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor2.g, var_24_17)
								local var_24_20 = Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor2.b, var_24_17)

								iter_24_3.color = Color.New(var_24_18, var_24_19, var_24_20)
							else
								local var_24_21 = Mathf.Lerp(iter_24_3.color.r, 0.5, var_24_17)

								iter_24_3.color = Color.New(var_24_21, var_24_21, var_24_21)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.actorSpriteComps10092_1 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_24_5 then
						if arg_21_1.isInRecall_ then
							iter_24_5.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_24_22 = arg_21_1.actors_["10093"]
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps10093 == nil then
				arg_21_1.var_.actorSpriteComps10093 = var_24_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_24 = 2

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_24 and not isNil(var_24_22) then
				local var_24_25 = (arg_21_1.time_ - var_24_23) / var_24_24

				if arg_21_1.var_.actorSpriteComps10093 then
					for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_24_7 then
							if arg_21_1.isInRecall_ then
								local var_24_26 = Mathf.Lerp(iter_24_7.color.r, arg_21_1.hightColor2.r, var_24_25)
								local var_24_27 = Mathf.Lerp(iter_24_7.color.g, arg_21_1.hightColor2.g, var_24_25)
								local var_24_28 = Mathf.Lerp(iter_24_7.color.b, arg_21_1.hightColor2.b, var_24_25)

								iter_24_7.color = Color.New(var_24_26, var_24_27, var_24_28)
							else
								local var_24_29 = Mathf.Lerp(iter_24_7.color.r, 0.5, var_24_25)

								iter_24_7.color = Color.New(var_24_29, var_24_29, var_24_29)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_23 + var_24_24 and arg_21_1.time_ < var_24_23 + var_24_24 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.actorSpriteComps10093 then
				for iter_24_8, iter_24_9 in pairs(arg_21_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_24_9 then
						if arg_21_1.isInRecall_ then
							iter_24_9.color = arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_24_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10093 = nil
			end

			local var_24_30 = 0
			local var_24_31 = 1

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_32 = arg_21_1:GetWordFromCfg(413112005)
				local var_24_33 = arg_21_1:FormatText(var_24_32.content)

				arg_21_1.text_.text = var_24_33

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_34 = 40
				local var_24_35 = utf8.len(var_24_33)
				local var_24_36 = var_24_34 <= 0 and var_24_31 or var_24_31 * (var_24_35 / var_24_34)

				if var_24_36 > 0 and var_24_31 < var_24_36 then
					arg_21_1.talkMaxDuration = var_24_36

					if var_24_36 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_36 + var_24_30
					end
				end

				arg_21_1.text_.text = var_24_33
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_37 = math.max(var_24_31, arg_21_1.talkMaxDuration)

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_37 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_30) / var_24_37

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_30 + var_24_37 and arg_21_1.time_ < var_24_30 + var_24_37 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413112006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413112006
		arg_25_1.duration_ = 5

		local var_25_0 = {
			zh = 5,
			ja = 4.433
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
				arg_25_0:Play413112007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10022"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(var_28_1, arg_25_1.canvasGo_.transform)

					var_28_2.transform:SetSiblingIndex(1)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_25_1.isInRecall_ then
						for iter_28_0, iter_28_1 in ipairs(var_28_3) do
							iter_28_1.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_28_4 = arg_25_1.actors_["10022"].transform
			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.var_.moveOldPos10022 = var_28_4.localPosition
				var_28_4.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10022", 3)

				local var_28_6 = var_28_4.childCount

				for iter_28_2 = 0, var_28_6 - 1 do
					local var_28_7 = var_28_4:GetChild(iter_28_2)

					if var_28_7.name == "split_6" or not string.find(var_28_7.name, "split") then
						var_28_7.gameObject:SetActive(true)
					else
						var_28_7.gameObject:SetActive(false)
					end
				end
			end

			local var_28_8 = 0.001

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_8 then
				local var_28_9 = (arg_25_1.time_ - var_28_5) / var_28_8
				local var_28_10 = Vector3.New(0, -315, -320)

				var_28_4.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10022, var_28_10, var_28_9)
			end

			if arg_25_1.time_ >= var_28_5 + var_28_8 and arg_25_1.time_ < var_28_5 + var_28_8 + arg_28_0 then
				var_28_4.localPosition = Vector3.New(0, -315, -320)
			end

			local var_28_11 = arg_25_1.actors_["10022"]
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.actorSpriteComps10022 == nil then
				arg_25_1.var_.actorSpriteComps10022 = var_28_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_13 = 2

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_13 and not isNil(var_28_11) then
				local var_28_14 = (arg_25_1.time_ - var_28_12) / var_28_13

				if arg_25_1.var_.actorSpriteComps10022 then
					for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_28_4 then
							if arg_25_1.isInRecall_ then
								local var_28_15 = Mathf.Lerp(iter_28_4.color.r, arg_25_1.hightColor1.r, var_28_14)
								local var_28_16 = Mathf.Lerp(iter_28_4.color.g, arg_25_1.hightColor1.g, var_28_14)
								local var_28_17 = Mathf.Lerp(iter_28_4.color.b, arg_25_1.hightColor1.b, var_28_14)

								iter_28_4.color = Color.New(var_28_15, var_28_16, var_28_17)
							else
								local var_28_18 = Mathf.Lerp(iter_28_4.color.r, 1, var_28_14)

								iter_28_4.color = Color.New(var_28_18, var_28_18, var_28_18)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_12 + var_28_13 and arg_25_1.time_ < var_28_12 + var_28_13 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.actorSpriteComps10022 then
				for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_28_6 then
						if arg_25_1.isInRecall_ then
							iter_28_6.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10022 = nil
			end

			local var_28_19 = 0
			local var_28_20 = 0.5

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_21 = arg_25_1:FormatText(StoryNameCfg[614].name)

				arg_25_1.leftNameTxt_.text = var_28_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_22 = arg_25_1:GetWordFromCfg(413112006)
				local var_28_23 = arg_25_1:FormatText(var_28_22.content)

				arg_25_1.text_.text = var_28_23

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_24 = 20
				local var_28_25 = utf8.len(var_28_23)
				local var_28_26 = var_28_24 <= 0 and var_28_20 or var_28_20 * (var_28_25 / var_28_24)

				if var_28_26 > 0 and var_28_20 < var_28_26 then
					arg_25_1.talkMaxDuration = var_28_26

					if var_28_26 + var_28_19 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_26 + var_28_19
					end
				end

				arg_25_1.text_.text = var_28_23
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112006", "story_v_out_413112.awb") ~= 0 then
					local var_28_27 = manager.audio:GetVoiceLength("story_v_out_413112", "413112006", "story_v_out_413112.awb") / 1000

					if var_28_27 + var_28_19 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_19
					end

					if var_28_22.prefab_name ~= "" and arg_25_1.actors_[var_28_22.prefab_name] ~= nil then
						local var_28_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_22.prefab_name].transform, "story_v_out_413112", "413112006", "story_v_out_413112.awb")

						arg_25_1:RecordAudio("413112006", var_28_28)
						arg_25_1:RecordAudio("413112006", var_28_28)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413112", "413112006", "story_v_out_413112.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413112", "413112006", "story_v_out_413112.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_29 = math.max(var_28_20, arg_25_1.talkMaxDuration)

			if var_28_19 <= arg_25_1.time_ and arg_25_1.time_ < var_28_19 + var_28_29 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_19) / var_28_29

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_19 + var_28_29 and arg_25_1.time_ < var_28_19 + var_28_29 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play413112007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413112007
		arg_29_1.duration_ = 4.3

		local var_29_0 = {
			zh = 3.433,
			ja = 4.3
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
				arg_29_0:Play413112008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.425

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[614].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:GetWordFromCfg(413112007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112007", "story_v_out_413112.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112007", "story_v_out_413112.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_413112", "413112007", "story_v_out_413112.awb")

						arg_29_1:RecordAudio("413112007", var_32_9)
						arg_29_1:RecordAudio("413112007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413112", "413112007", "story_v_out_413112.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413112", "413112007", "story_v_out_413112.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play413112008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413112008
		arg_33_1.duration_ = 5.83

		local var_33_0 = {
			zh = 5.833,
			ja = 3.633
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
				arg_33_0:Play413112009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10092_1"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10092_1 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10092_1", 4)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "split_1_1" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(390, -300, -295)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10092_1, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_36_7 = arg_33_1.actors_["10022"].transform
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.var_.moveOldPos10022 = var_36_7.localPosition
				var_36_7.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10022", 2)

				local var_36_9 = var_36_7.childCount

				for iter_36_1 = 0, var_36_9 - 1 do
					local var_36_10 = var_36_7:GetChild(iter_36_1)

					if var_36_10.name == "" or not string.find(var_36_10.name, "split") then
						var_36_10.gameObject:SetActive(true)
					else
						var_36_10.gameObject:SetActive(false)
					end
				end
			end

			local var_36_11 = 0.001

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_11 then
				local var_36_12 = (arg_33_1.time_ - var_36_8) / var_36_11
				local var_36_13 = Vector3.New(-390, -315, -320)

				var_36_7.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10022, var_36_13, var_36_12)
			end

			if arg_33_1.time_ >= var_36_8 + var_36_11 and arg_33_1.time_ < var_36_8 + var_36_11 + arg_36_0 then
				var_36_7.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_36_14 = arg_33_1.actors_["10092_1"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.actorSpriteComps10092_1 == nil then
				arg_33_1.var_.actorSpriteComps10092_1 = var_36_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_16 = 2

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.actorSpriteComps10092_1 then
					for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_36_3 then
							if arg_33_1.isInRecall_ then
								local var_36_18 = Mathf.Lerp(iter_36_3.color.r, arg_33_1.hightColor1.r, var_36_17)
								local var_36_19 = Mathf.Lerp(iter_36_3.color.g, arg_33_1.hightColor1.g, var_36_17)
								local var_36_20 = Mathf.Lerp(iter_36_3.color.b, arg_33_1.hightColor1.b, var_36_17)

								iter_36_3.color = Color.New(var_36_18, var_36_19, var_36_20)
							else
								local var_36_21 = Mathf.Lerp(iter_36_3.color.r, 1, var_36_17)

								iter_36_3.color = Color.New(var_36_21, var_36_21, var_36_21)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.actorSpriteComps10092_1 then
				for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_36_5 then
						if arg_33_1.isInRecall_ then
							iter_36_5.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_36_22 = arg_33_1.actors_["10022"]
			local var_36_23 = 0

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 and not isNil(var_36_22) and arg_33_1.var_.actorSpriteComps10022 == nil then
				arg_33_1.var_.actorSpriteComps10022 = var_36_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_24 = 2

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_24 and not isNil(var_36_22) then
				local var_36_25 = (arg_33_1.time_ - var_36_23) / var_36_24

				if arg_33_1.var_.actorSpriteComps10022 then
					for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_36_7 then
							if arg_33_1.isInRecall_ then
								local var_36_26 = Mathf.Lerp(iter_36_7.color.r, arg_33_1.hightColor2.r, var_36_25)
								local var_36_27 = Mathf.Lerp(iter_36_7.color.g, arg_33_1.hightColor2.g, var_36_25)
								local var_36_28 = Mathf.Lerp(iter_36_7.color.b, arg_33_1.hightColor2.b, var_36_25)

								iter_36_7.color = Color.New(var_36_26, var_36_27, var_36_28)
							else
								local var_36_29 = Mathf.Lerp(iter_36_7.color.r, 0.5, var_36_25)

								iter_36_7.color = Color.New(var_36_29, var_36_29, var_36_29)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_23 + var_36_24 and arg_33_1.time_ < var_36_23 + var_36_24 + arg_36_0 and not isNil(var_36_22) and arg_33_1.var_.actorSpriteComps10022 then
				for iter_36_8, iter_36_9 in pairs(arg_33_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_36_9 then
						if arg_33_1.isInRecall_ then
							iter_36_9.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10022 = nil
			end

			local var_36_30 = 0
			local var_36_31 = 0.75

			if var_36_30 < arg_33_1.time_ and arg_33_1.time_ <= var_36_30 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_32 = arg_33_1:FormatText(StoryNameCfg[996].name)

				arg_33_1.leftNameTxt_.text = var_36_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_33 = arg_33_1:GetWordFromCfg(413112008)
				local var_36_34 = arg_33_1:FormatText(var_36_33.content)

				arg_33_1.text_.text = var_36_34

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_35 = 30
				local var_36_36 = utf8.len(var_36_34)
				local var_36_37 = var_36_35 <= 0 and var_36_31 or var_36_31 * (var_36_36 / var_36_35)

				if var_36_37 > 0 and var_36_31 < var_36_37 then
					arg_33_1.talkMaxDuration = var_36_37

					if var_36_37 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_37 + var_36_30
					end
				end

				arg_33_1.text_.text = var_36_34
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112008", "story_v_out_413112.awb") ~= 0 then
					local var_36_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112008", "story_v_out_413112.awb") / 1000

					if var_36_38 + var_36_30 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_38 + var_36_30
					end

					if var_36_33.prefab_name ~= "" and arg_33_1.actors_[var_36_33.prefab_name] ~= nil then
						local var_36_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_33.prefab_name].transform, "story_v_out_413112", "413112008", "story_v_out_413112.awb")

						arg_33_1:RecordAudio("413112008", var_36_39)
						arg_33_1:RecordAudio("413112008", var_36_39)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413112", "413112008", "story_v_out_413112.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413112", "413112008", "story_v_out_413112.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_40 = math.max(var_36_31, arg_33_1.talkMaxDuration)

			if var_36_30 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_40 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_40

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_40 and arg_33_1.time_ < var_36_30 + var_36_40 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_33_1:InitPlayNodeList()
	end,
	Play413112009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413112009
		arg_37_1.duration_ = 6.3

		local var_37_0 = {
			zh = 6.3,
			ja = 5.266
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
				arg_37_0:Play413112010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10022"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10022 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10022", 2)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_2" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(-390, -315, -320)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10022, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_40_7 = arg_37_1.actors_["10022"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10022 == nil then
				arg_37_1.var_.actorSpriteComps10022 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps10022 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								local var_40_11 = Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, var_40_10)
								local var_40_12 = Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, var_40_10)
								local var_40_13 = Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, var_40_10)

								iter_40_2.color = Color.New(var_40_11, var_40_12, var_40_13)
							else
								local var_40_14 = Mathf.Lerp(iter_40_2.color.r, 1, var_40_10)

								iter_40_2.color = Color.New(var_40_14, var_40_14, var_40_14)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10022 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10022 = nil
			end

			local var_40_15 = arg_37_1.actors_["10092_1"]
			local var_40_16 = 0

			if var_40_16 < arg_37_1.time_ and arg_37_1.time_ <= var_40_16 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.actorSpriteComps10092_1 == nil then
				arg_37_1.var_.actorSpriteComps10092_1 = var_40_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_17 = 2

			if var_40_16 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 and not isNil(var_40_15) then
				local var_40_18 = (arg_37_1.time_ - var_40_16) / var_40_17

				if arg_37_1.var_.actorSpriteComps10092_1 then
					for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_40_6 then
							if arg_37_1.isInRecall_ then
								local var_40_19 = Mathf.Lerp(iter_40_6.color.r, arg_37_1.hightColor2.r, var_40_18)
								local var_40_20 = Mathf.Lerp(iter_40_6.color.g, arg_37_1.hightColor2.g, var_40_18)
								local var_40_21 = Mathf.Lerp(iter_40_6.color.b, arg_37_1.hightColor2.b, var_40_18)

								iter_40_6.color = Color.New(var_40_19, var_40_20, var_40_21)
							else
								local var_40_22 = Mathf.Lerp(iter_40_6.color.r, 0.5, var_40_18)

								iter_40_6.color = Color.New(var_40_22, var_40_22, var_40_22)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 and not isNil(var_40_15) and arg_37_1.var_.actorSpriteComps10092_1 then
				for iter_40_7, iter_40_8 in pairs(arg_37_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_40_8 then
						if arg_37_1.isInRecall_ then
							iter_40_8.color = arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_40_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_40_23 = 0
			local var_40_24 = 0.875

			if var_40_23 < arg_37_1.time_ and arg_37_1.time_ <= var_40_23 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_25 = arg_37_1:FormatText(StoryNameCfg[614].name)

				arg_37_1.leftNameTxt_.text = var_40_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_26 = arg_37_1:GetWordFromCfg(413112009)
				local var_40_27 = arg_37_1:FormatText(var_40_26.content)

				arg_37_1.text_.text = var_40_27

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_28 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112009", "story_v_out_413112.awb") ~= 0 then
					local var_40_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112009", "story_v_out_413112.awb") / 1000

					if var_40_31 + var_40_23 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_31 + var_40_23
					end

					if var_40_26.prefab_name ~= "" and arg_37_1.actors_[var_40_26.prefab_name] ~= nil then
						local var_40_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_26.prefab_name].transform, "story_v_out_413112", "413112009", "story_v_out_413112.awb")

						arg_37_1:RecordAudio("413112009", var_40_32)
						arg_37_1:RecordAudio("413112009", var_40_32)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413112", "413112009", "story_v_out_413112.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413112", "413112009", "story_v_out_413112.awb")
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
				actorName = "10022",
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
	Play413112010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413112010
		arg_41_1.duration_ = 13.1

		local var_41_0 = {
			zh = 7.633,
			ja = 13.1
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
				arg_41_0:Play413112011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10092_1"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10092_1 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10092_1", 4)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "split_7" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(390, -300, -295)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10092_1, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_44_7 = arg_41_1.actors_["10092_1"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10092_1 == nil then
				arg_41_1.var_.actorSpriteComps10092_1 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 2

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps10092_1 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 1, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10092_1 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_44_15 = arg_41_1.actors_["10022"]
			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.actorSpriteComps10022 == nil then
				arg_41_1.var_.actorSpriteComps10022 = var_44_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_17 = 2

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 and not isNil(var_44_15) then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17

				if arg_41_1.var_.actorSpriteComps10022 then
					for iter_44_5, iter_44_6 in pairs(arg_41_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_44_6 then
							if arg_41_1.isInRecall_ then
								local var_44_19 = Mathf.Lerp(iter_44_6.color.r, arg_41_1.hightColor2.r, var_44_18)
								local var_44_20 = Mathf.Lerp(iter_44_6.color.g, arg_41_1.hightColor2.g, var_44_18)
								local var_44_21 = Mathf.Lerp(iter_44_6.color.b, arg_41_1.hightColor2.b, var_44_18)

								iter_44_6.color = Color.New(var_44_19, var_44_20, var_44_21)
							else
								local var_44_22 = Mathf.Lerp(iter_44_6.color.r, 0.5, var_44_18)

								iter_44_6.color = Color.New(var_44_22, var_44_22, var_44_22)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 and not isNil(var_44_15) and arg_41_1.var_.actorSpriteComps10022 then
				for iter_44_7, iter_44_8 in pairs(arg_41_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_44_8 then
						if arg_41_1.isInRecall_ then
							iter_44_8.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10022 = nil
			end

			local var_44_23 = 0
			local var_44_24 = 0.925

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_25 = arg_41_1:FormatText(StoryNameCfg[996].name)

				arg_41_1.leftNameTxt_.text = var_44_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_26 = arg_41_1:GetWordFromCfg(413112010)
				local var_44_27 = arg_41_1:FormatText(var_44_26.content)

				arg_41_1.text_.text = var_44_27

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_28 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112010", "story_v_out_413112.awb") ~= 0 then
					local var_44_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112010", "story_v_out_413112.awb") / 1000

					if var_44_31 + var_44_23 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_31 + var_44_23
					end

					if var_44_26.prefab_name ~= "" and arg_41_1.actors_[var_44_26.prefab_name] ~= nil then
						local var_44_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_26.prefab_name].transform, "story_v_out_413112", "413112010", "story_v_out_413112.awb")

						arg_41_1:RecordAudio("413112010", var_44_32)
						arg_41_1:RecordAudio("413112010", var_44_32)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_413112", "413112010", "story_v_out_413112.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_413112", "413112010", "story_v_out_413112.awb")
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
				actorName = "10092_1",
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
	Play413112011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 413112011
		arg_45_1.duration_ = 11.07

		local var_45_0 = {
			zh = 9.5,
			ja = 11.066
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
				arg_45_0:Play413112012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10022"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos10022 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10022", 2)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "split_8" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(-390, -315, -320)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10022, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_48_7 = arg_45_1.actors_["10022"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10022 == nil then
				arg_45_1.var_.actorSpriteComps10022 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 2

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps10022 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								local var_48_11 = Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, var_48_10)
								local var_48_12 = Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, var_48_10)
								local var_48_13 = Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, var_48_10)

								iter_48_2.color = Color.New(var_48_11, var_48_12, var_48_13)
							else
								local var_48_14 = Mathf.Lerp(iter_48_2.color.r, 1, var_48_10)

								iter_48_2.color = Color.New(var_48_14, var_48_14, var_48_14)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps10022 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10022 = nil
			end

			local var_48_15 = arg_45_1.actors_["10092_1"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps10092_1 == nil then
				arg_45_1.var_.actorSpriteComps10092_1 = var_48_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 2

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.actorSpriteComps10092_1 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								local var_48_19 = Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, var_48_18)
								local var_48_20 = Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, var_48_18)
								local var_48_21 = Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, var_48_18)

								iter_48_6.color = Color.New(var_48_19, var_48_20, var_48_21)
							else
								local var_48_22 = Mathf.Lerp(iter_48_6.color.r, 0.5, var_48_18)

								iter_48_6.color = Color.New(var_48_22, var_48_22, var_48_22)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps10092_1 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_48_23 = 0
			local var_48_24 = 1.25

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[614].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(413112011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 50
				local var_48_29 = utf8.len(var_48_27)
				local var_48_30 = var_48_28 <= 0 and var_48_24 or var_48_24 * (var_48_29 / var_48_28)

				if var_48_30 > 0 and var_48_24 < var_48_30 then
					arg_45_1.talkMaxDuration = var_48_30

					if var_48_30 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_23
					end
				end

				arg_45_1.text_.text = var_48_27
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112011", "story_v_out_413112.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112011", "story_v_out_413112.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_413112", "413112011", "story_v_out_413112.awb")

						arg_45_1:RecordAudio("413112011", var_48_32)
						arg_45_1:RecordAudio("413112011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_413112", "413112011", "story_v_out_413112.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_413112", "413112011", "story_v_out_413112.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_33 = math.max(var_48_24, arg_45_1.talkMaxDuration)

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_33 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_23) / var_48_33

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_23 + var_48_33 and arg_45_1.time_ < var_48_23 + var_48_33 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play413112012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413112012
		arg_49_1.duration_ = 12.7

		local var_49_0 = {
			zh = 5.9,
			ja = 12.7
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
				arg_49_0:Play413112013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10092_1"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos10092_1 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10092_1", 4)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(390, -300, -295)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10092_1, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_52_7 = arg_49_1.actors_["10092_1"]
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10092_1 == nil then
				arg_49_1.var_.actorSpriteComps10092_1 = var_52_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_9 = 2

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 and not isNil(var_52_7) then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9

				if arg_49_1.var_.actorSpriteComps10092_1 then
					for iter_52_1, iter_52_2 in pairs(arg_49_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_52_2 then
							if arg_49_1.isInRecall_ then
								local var_52_11 = Mathf.Lerp(iter_52_2.color.r, arg_49_1.hightColor1.r, var_52_10)
								local var_52_12 = Mathf.Lerp(iter_52_2.color.g, arg_49_1.hightColor1.g, var_52_10)
								local var_52_13 = Mathf.Lerp(iter_52_2.color.b, arg_49_1.hightColor1.b, var_52_10)

								iter_52_2.color = Color.New(var_52_11, var_52_12, var_52_13)
							else
								local var_52_14 = Mathf.Lerp(iter_52_2.color.r, 1, var_52_10)

								iter_52_2.color = Color.New(var_52_14, var_52_14, var_52_14)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 and not isNil(var_52_7) and arg_49_1.var_.actorSpriteComps10092_1 then
				for iter_52_3, iter_52_4 in pairs(arg_49_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_52_4 then
						if arg_49_1.isInRecall_ then
							iter_52_4.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_52_15 = arg_49_1.actors_["10022"]
			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps10022 == nil then
				arg_49_1.var_.actorSpriteComps10022 = var_52_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_17 = 2

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 and not isNil(var_52_15) then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17

				if arg_49_1.var_.actorSpriteComps10022 then
					for iter_52_5, iter_52_6 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_52_6 then
							if arg_49_1.isInRecall_ then
								local var_52_19 = Mathf.Lerp(iter_52_6.color.r, arg_49_1.hightColor2.r, var_52_18)
								local var_52_20 = Mathf.Lerp(iter_52_6.color.g, arg_49_1.hightColor2.g, var_52_18)
								local var_52_21 = Mathf.Lerp(iter_52_6.color.b, arg_49_1.hightColor2.b, var_52_18)

								iter_52_6.color = Color.New(var_52_19, var_52_20, var_52_21)
							else
								local var_52_22 = Mathf.Lerp(iter_52_6.color.r, 0.5, var_52_18)

								iter_52_6.color = Color.New(var_52_22, var_52_22, var_52_22)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 and not isNil(var_52_15) and arg_49_1.var_.actorSpriteComps10022 then
				for iter_52_7, iter_52_8 in pairs(arg_49_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_52_8 then
						if arg_49_1.isInRecall_ then
							iter_52_8.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10022 = nil
			end

			local var_52_23 = 0
			local var_52_24 = 0.55

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[996].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(413112012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 22
				local var_52_29 = utf8.len(var_52_27)
				local var_52_30 = var_52_28 <= 0 and var_52_24 or var_52_24 * (var_52_29 / var_52_28)

				if var_52_30 > 0 and var_52_24 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30

					if var_52_30 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_23
					end
				end

				arg_49_1.text_.text = var_52_27
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112012", "story_v_out_413112.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112012", "story_v_out_413112.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_413112", "413112012", "story_v_out_413112.awb")

						arg_49_1:RecordAudio("413112012", var_52_32)
						arg_49_1:RecordAudio("413112012", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413112", "413112012", "story_v_out_413112.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413112", "413112012", "story_v_out_413112.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_33 = math.max(var_52_24, arg_49_1.talkMaxDuration)

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_33 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_23) / var_52_33

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_23 + var_52_33 and arg_49_1.time_ < var_52_23 + var_52_33 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413112013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413112013
		arg_53_1.duration_ = 8.53

		local var_53_0 = {
			zh = 8.533,
			ja = 8.4
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
				arg_53_0:Play413112014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10022"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos10022 = var_56_0.localPosition
				var_56_0.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10022", 2)

				local var_56_2 = var_56_0.childCount

				for iter_56_0 = 0, var_56_2 - 1 do
					local var_56_3 = var_56_0:GetChild(iter_56_0)

					if var_56_3.name == "split_6" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_4 then
				local var_56_5 = (arg_53_1.time_ - var_56_1) / var_56_4
				local var_56_6 = Vector3.New(-390, -315, -320)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10022, var_56_6, var_56_5)
			end

			if arg_53_1.time_ >= var_56_1 + var_56_4 and arg_53_1.time_ < var_56_1 + var_56_4 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_56_7 = arg_53_1.actors_["10022"]
			local var_56_8 = 0

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10022 == nil then
				arg_53_1.var_.actorSpriteComps10022 = var_56_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_9 = 2

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_9 and not isNil(var_56_7) then
				local var_56_10 = (arg_53_1.time_ - var_56_8) / var_56_9

				if arg_53_1.var_.actorSpriteComps10022 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								local var_56_11 = Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, var_56_10)
								local var_56_12 = Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, var_56_10)
								local var_56_13 = Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, var_56_10)

								iter_56_2.color = Color.New(var_56_11, var_56_12, var_56_13)
							else
								local var_56_14 = Mathf.Lerp(iter_56_2.color.r, 1, var_56_10)

								iter_56_2.color = Color.New(var_56_14, var_56_14, var_56_14)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_8 + var_56_9 and arg_53_1.time_ < var_56_8 + var_56_9 + arg_56_0 and not isNil(var_56_7) and arg_53_1.var_.actorSpriteComps10022 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_56_4 then
						if arg_53_1.isInRecall_ then
							iter_56_4.color = arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_56_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10022 = nil
			end

			local var_56_15 = arg_53_1.actors_["10092_1"]
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.actorSpriteComps10092_1 == nil then
				arg_53_1.var_.actorSpriteComps10092_1 = var_56_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_17 = 2

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 and not isNil(var_56_15) then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17

				if arg_53_1.var_.actorSpriteComps10092_1 then
					for iter_56_5, iter_56_6 in pairs(arg_53_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_56_6 then
							if arg_53_1.isInRecall_ then
								local var_56_19 = Mathf.Lerp(iter_56_6.color.r, arg_53_1.hightColor2.r, var_56_18)
								local var_56_20 = Mathf.Lerp(iter_56_6.color.g, arg_53_1.hightColor2.g, var_56_18)
								local var_56_21 = Mathf.Lerp(iter_56_6.color.b, arg_53_1.hightColor2.b, var_56_18)

								iter_56_6.color = Color.New(var_56_19, var_56_20, var_56_21)
							else
								local var_56_22 = Mathf.Lerp(iter_56_6.color.r, 0.5, var_56_18)

								iter_56_6.color = Color.New(var_56_22, var_56_22, var_56_22)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.actorSpriteComps10092_1 then
				for iter_56_7, iter_56_8 in pairs(arg_53_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_56_8 then
						if arg_53_1.isInRecall_ then
							iter_56_8.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_56_23 = 0
			local var_56_24 = 0.775

			if var_56_23 < arg_53_1.time_ and arg_53_1.time_ <= var_56_23 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_25 = arg_53_1:FormatText(StoryNameCfg[614].name)

				arg_53_1.leftNameTxt_.text = var_56_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_26 = arg_53_1:GetWordFromCfg(413112013)
				local var_56_27 = arg_53_1:FormatText(var_56_26.content)

				arg_53_1.text_.text = var_56_27

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_28 = 31
				local var_56_29 = utf8.len(var_56_27)
				local var_56_30 = var_56_28 <= 0 and var_56_24 or var_56_24 * (var_56_29 / var_56_28)

				if var_56_30 > 0 and var_56_24 < var_56_30 then
					arg_53_1.talkMaxDuration = var_56_30

					if var_56_30 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_30 + var_56_23
					end
				end

				arg_53_1.text_.text = var_56_27
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112013", "story_v_out_413112.awb") ~= 0 then
					local var_56_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112013", "story_v_out_413112.awb") / 1000

					if var_56_31 + var_56_23 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_31 + var_56_23
					end

					if var_56_26.prefab_name ~= "" and arg_53_1.actors_[var_56_26.prefab_name] ~= nil then
						local var_56_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_26.prefab_name].transform, "story_v_out_413112", "413112013", "story_v_out_413112.awb")

						arg_53_1:RecordAudio("413112013", var_56_32)
						arg_53_1:RecordAudio("413112013", var_56_32)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413112", "413112013", "story_v_out_413112.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413112", "413112013", "story_v_out_413112.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_33 = math.max(var_56_24, arg_53_1.talkMaxDuration)

			if var_56_23 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_33 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_23) / var_56_33

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_23 + var_56_33 and arg_53_1.time_ < var_56_23 + var_56_33 + arg_56_0 then
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
	Play413112014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413112014
		arg_57_1.duration_ = 9.6

		local var_57_0 = {
			zh = 6.1,
			ja = 9.6
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
				arg_57_0:Play413112015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10022"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10022 == nil then
				arg_57_1.var_.actorSpriteComps10022 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10022 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10022 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10022 = nil
			end

			local var_60_8 = arg_57_1.actors_["10092_1"]
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10092_1 == nil then
				arg_57_1.var_.actorSpriteComps10092_1 = var_60_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_10 = 2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 and not isNil(var_60_8) then
				local var_60_11 = (arg_57_1.time_ - var_60_9) / var_60_10

				if arg_57_1.var_.actorSpriteComps10092_1 then
					for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_60_5 then
							if arg_57_1.isInRecall_ then
								local var_60_12 = Mathf.Lerp(iter_60_5.color.r, arg_57_1.hightColor2.r, var_60_11)
								local var_60_13 = Mathf.Lerp(iter_60_5.color.g, arg_57_1.hightColor2.g, var_60_11)
								local var_60_14 = Mathf.Lerp(iter_60_5.color.b, arg_57_1.hightColor2.b, var_60_11)

								iter_60_5.color = Color.New(var_60_12, var_60_13, var_60_14)
							else
								local var_60_15 = Mathf.Lerp(iter_60_5.color.r, 0.5, var_60_11)

								iter_60_5.color = Color.New(var_60_15, var_60_15, var_60_15)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 and not isNil(var_60_8) and arg_57_1.var_.actorSpriteComps10092_1 then
				for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_60_7 then
						if arg_57_1.isInRecall_ then
							iter_60_7.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_60_16 = 0
			local var_60_17 = 0.7

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_18 = arg_57_1:FormatText(StoryNameCfg[614].name)

				arg_57_1.leftNameTxt_.text = var_60_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_19 = arg_57_1:GetWordFromCfg(413112014)
				local var_60_20 = arg_57_1:FormatText(var_60_19.content)

				arg_57_1.text_.text = var_60_20

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_21 = 28
				local var_60_22 = utf8.len(var_60_20)
				local var_60_23 = var_60_21 <= 0 and var_60_17 or var_60_17 * (var_60_22 / var_60_21)

				if var_60_23 > 0 and var_60_17 < var_60_23 then
					arg_57_1.talkMaxDuration = var_60_23

					if var_60_23 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_23 + var_60_16
					end
				end

				arg_57_1.text_.text = var_60_20
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112014", "story_v_out_413112.awb") ~= 0 then
					local var_60_24 = manager.audio:GetVoiceLength("story_v_out_413112", "413112014", "story_v_out_413112.awb") / 1000

					if var_60_24 + var_60_16 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_16
					end

					if var_60_19.prefab_name ~= "" and arg_57_1.actors_[var_60_19.prefab_name] ~= nil then
						local var_60_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_19.prefab_name].transform, "story_v_out_413112", "413112014", "story_v_out_413112.awb")

						arg_57_1:RecordAudio("413112014", var_60_25)
						arg_57_1:RecordAudio("413112014", var_60_25)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413112", "413112014", "story_v_out_413112.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413112", "413112014", "story_v_out_413112.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_26 = math.max(var_60_17, arg_57_1.talkMaxDuration)

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_26 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_16) / var_60_26

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_16 + var_60_26 and arg_57_1.time_ < var_60_16 + var_60_26 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play413112015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413112015
		arg_61_1.duration_ = 6.73

		local var_61_0 = {
			zh = 5.8,
			ja = 6.733
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
				arg_61_0:Play413112016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10092_1"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10092_1 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10092_1", 4)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "split_1_1" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(390, -300, -295)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10092_1, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_64_7 = arg_61_1.actors_["10092_1"]
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps10092_1 == nil then
				arg_61_1.var_.actorSpriteComps10092_1 = var_64_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 2

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 and not isNil(var_64_7) then
				local var_64_10 = (arg_61_1.time_ - var_64_8) / var_64_9

				if arg_61_1.var_.actorSpriteComps10092_1 then
					for iter_64_1, iter_64_2 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_64_2 then
							if arg_61_1.isInRecall_ then
								local var_64_11 = Mathf.Lerp(iter_64_2.color.r, arg_61_1.hightColor1.r, var_64_10)
								local var_64_12 = Mathf.Lerp(iter_64_2.color.g, arg_61_1.hightColor1.g, var_64_10)
								local var_64_13 = Mathf.Lerp(iter_64_2.color.b, arg_61_1.hightColor1.b, var_64_10)

								iter_64_2.color = Color.New(var_64_11, var_64_12, var_64_13)
							else
								local var_64_14 = Mathf.Lerp(iter_64_2.color.r, 1, var_64_10)

								iter_64_2.color = Color.New(var_64_14, var_64_14, var_64_14)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.actorSpriteComps10092_1 then
				for iter_64_3, iter_64_4 in pairs(arg_61_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_64_4 then
						if arg_61_1.isInRecall_ then
							iter_64_4.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_64_15 = arg_61_1.actors_["10022"]
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.actorSpriteComps10022 == nil then
				arg_61_1.var_.actorSpriteComps10022 = var_64_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_17 = 2

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 and not isNil(var_64_15) then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17

				if arg_61_1.var_.actorSpriteComps10022 then
					for iter_64_5, iter_64_6 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_64_6 then
							if arg_61_1.isInRecall_ then
								local var_64_19 = Mathf.Lerp(iter_64_6.color.r, arg_61_1.hightColor2.r, var_64_18)
								local var_64_20 = Mathf.Lerp(iter_64_6.color.g, arg_61_1.hightColor2.g, var_64_18)
								local var_64_21 = Mathf.Lerp(iter_64_6.color.b, arg_61_1.hightColor2.b, var_64_18)

								iter_64_6.color = Color.New(var_64_19, var_64_20, var_64_21)
							else
								local var_64_22 = Mathf.Lerp(iter_64_6.color.r, 0.5, var_64_18)

								iter_64_6.color = Color.New(var_64_22, var_64_22, var_64_22)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 and not isNil(var_64_15) and arg_61_1.var_.actorSpriteComps10022 then
				for iter_64_7, iter_64_8 in pairs(arg_61_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_64_8 then
						if arg_61_1.isInRecall_ then
							iter_64_8.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10022 = nil
			end

			local var_64_23 = 0
			local var_64_24 = 0.65

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_25 = arg_61_1:FormatText(StoryNameCfg[996].name)

				arg_61_1.leftNameTxt_.text = var_64_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_26 = arg_61_1:GetWordFromCfg(413112015)
				local var_64_27 = arg_61_1:FormatText(var_64_26.content)

				arg_61_1.text_.text = var_64_27

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_28 = 26
				local var_64_29 = utf8.len(var_64_27)
				local var_64_30 = var_64_28 <= 0 and var_64_24 or var_64_24 * (var_64_29 / var_64_28)

				if var_64_30 > 0 and var_64_24 < var_64_30 then
					arg_61_1.talkMaxDuration = var_64_30

					if var_64_30 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_30 + var_64_23
					end
				end

				arg_61_1.text_.text = var_64_27
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112015", "story_v_out_413112.awb") ~= 0 then
					local var_64_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112015", "story_v_out_413112.awb") / 1000

					if var_64_31 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_31 + var_64_23
					end

					if var_64_26.prefab_name ~= "" and arg_61_1.actors_[var_64_26.prefab_name] ~= nil then
						local var_64_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_26.prefab_name].transform, "story_v_out_413112", "413112015", "story_v_out_413112.awb")

						arg_61_1:RecordAudio("413112015", var_64_32)
						arg_61_1:RecordAudio("413112015", var_64_32)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_413112", "413112015", "story_v_out_413112.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_413112", "413112015", "story_v_out_413112.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_33 = math.max(var_64_24, arg_61_1.talkMaxDuration)

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_33 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_23) / var_64_33

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_23 + var_64_33 and arg_61_1.time_ < var_64_23 + var_64_33 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413112016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413112016
		arg_65_1.duration_ = 4.9

		local var_65_0 = {
			zh = 4.333,
			ja = 4.9
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
				arg_65_0:Play413112017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10022"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10022 == nil then
				arg_65_1.var_.actorSpriteComps10022 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 2

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

			local var_68_8 = arg_65_1.actors_["10092_1"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10092_1 == nil then
				arg_65_1.var_.actorSpriteComps10092_1 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps10092_1 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
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

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10092_1 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.525

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[614].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(413112016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 21
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_17 or var_68_17 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_17 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112016", "story_v_out_413112.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_out_413112", "413112016", "story_v_out_413112.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_out_413112", "413112016", "story_v_out_413112.awb")

						arg_65_1:RecordAudio("413112016", var_68_25)
						arg_65_1:RecordAudio("413112016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413112", "413112016", "story_v_out_413112.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413112", "413112016", "story_v_out_413112.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_26 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_26 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_26

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_26 and arg_65_1.time_ < var_68_16 + var_68_26 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play413112017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413112017
		arg_69_1.duration_ = 7.5

		local var_69_0 = {
			zh = 4.966,
			ja = 7.5
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
				arg_69_0:Play413112018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10022"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10022 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10022", 2)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "split_6" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(-390, -315, -320)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10022, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_72_7 = arg_69_1.actors_["10022"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10022 == nil then
				arg_69_1.var_.actorSpriteComps10022 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps10022 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 1, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps10022 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10022 = nil
			end

			local var_72_15 = arg_69_1.actors_["10092_1"]
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps10092_1 == nil then
				arg_69_1.var_.actorSpriteComps10092_1 = var_72_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_17 = 2

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 and not isNil(var_72_15) then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17

				if arg_69_1.var_.actorSpriteComps10092_1 then
					for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_72_6 then
							if arg_69_1.isInRecall_ then
								local var_72_19 = Mathf.Lerp(iter_72_6.color.r, arg_69_1.hightColor2.r, var_72_18)
								local var_72_20 = Mathf.Lerp(iter_72_6.color.g, arg_69_1.hightColor2.g, var_72_18)
								local var_72_21 = Mathf.Lerp(iter_72_6.color.b, arg_69_1.hightColor2.b, var_72_18)

								iter_72_6.color = Color.New(var_72_19, var_72_20, var_72_21)
							else
								local var_72_22 = Mathf.Lerp(iter_72_6.color.r, 0.5, var_72_18)

								iter_72_6.color = Color.New(var_72_22, var_72_22, var_72_22)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps10092_1 then
				for iter_72_7, iter_72_8 in pairs(arg_69_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_72_8 then
						if arg_69_1.isInRecall_ then
							iter_72_8.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_72_23 = 0
			local var_72_24 = 0.7

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_25 = arg_69_1:FormatText(StoryNameCfg[614].name)

				arg_69_1.leftNameTxt_.text = var_72_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:GetWordFromCfg(413112017)
				local var_72_27 = arg_69_1:FormatText(var_72_26.content)

				arg_69_1.text_.text = var_72_27

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 28
				local var_72_29 = utf8.len(var_72_27)
				local var_72_30 = var_72_28 <= 0 and var_72_24 or var_72_24 * (var_72_29 / var_72_28)

				if var_72_30 > 0 and var_72_24 < var_72_30 then
					arg_69_1.talkMaxDuration = var_72_30

					if var_72_30 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_30 + var_72_23
					end
				end

				arg_69_1.text_.text = var_72_27
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112017", "story_v_out_413112.awb") ~= 0 then
					local var_72_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112017", "story_v_out_413112.awb") / 1000

					if var_72_31 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_31 + var_72_23
					end

					if var_72_26.prefab_name ~= "" and arg_69_1.actors_[var_72_26.prefab_name] ~= nil then
						local var_72_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_26.prefab_name].transform, "story_v_out_413112", "413112017", "story_v_out_413112.awb")

						arg_69_1:RecordAudio("413112017", var_72_32)
						arg_69_1:RecordAudio("413112017", var_72_32)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413112", "413112017", "story_v_out_413112.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413112", "413112017", "story_v_out_413112.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_33 = math.max(var_72_24, arg_69_1.talkMaxDuration)

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_33 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_23) / var_72_33

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_23 + var_72_33 and arg_69_1.time_ < var_72_23 + var_72_33 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play413112018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413112018
		arg_73_1.duration_ = 10.2

		local var_73_0 = {
			zh = 5.9,
			ja = 10.2
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
				arg_73_0:Play413112019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10092_1"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10092_1 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10092_1", 4)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "split_2" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(390, -300, -295)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10092_1, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_76_7 = arg_73_1.actors_["10092_1"]
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10092_1 == nil then
				arg_73_1.var_.actorSpriteComps10092_1 = var_76_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 and not isNil(var_76_7) then
				local var_76_10 = (arg_73_1.time_ - var_76_8) / var_76_9

				if arg_73_1.var_.actorSpriteComps10092_1 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								local var_76_11 = Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor1.r, var_76_10)
								local var_76_12 = Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor1.g, var_76_10)
								local var_76_13 = Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor1.b, var_76_10)

								iter_76_2.color = Color.New(var_76_11, var_76_12, var_76_13)
							else
								local var_76_14 = Mathf.Lerp(iter_76_2.color.r, 1, var_76_10)

								iter_76_2.color = Color.New(var_76_14, var_76_14, var_76_14)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.actorSpriteComps10092_1 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_76_4 then
						if arg_73_1.isInRecall_ then
							iter_76_4.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_76_15 = arg_73_1.actors_["10022"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10022 == nil then
				arg_73_1.var_.actorSpriteComps10022 = var_76_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_17 = 2

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.actorSpriteComps10022 then
					for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_76_6 then
							if arg_73_1.isInRecall_ then
								local var_76_19 = Mathf.Lerp(iter_76_6.color.r, arg_73_1.hightColor2.r, var_76_18)
								local var_76_20 = Mathf.Lerp(iter_76_6.color.g, arg_73_1.hightColor2.g, var_76_18)
								local var_76_21 = Mathf.Lerp(iter_76_6.color.b, arg_73_1.hightColor2.b, var_76_18)

								iter_76_6.color = Color.New(var_76_19, var_76_20, var_76_21)
							else
								local var_76_22 = Mathf.Lerp(iter_76_6.color.r, 0.5, var_76_18)

								iter_76_6.color = Color.New(var_76_22, var_76_22, var_76_22)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.actorSpriteComps10022 then
				for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_76_8 then
						if arg_73_1.isInRecall_ then
							iter_76_8.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10022 = nil
			end

			local var_76_23 = 0
			local var_76_24 = 0.825

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_25 = arg_73_1:FormatText(StoryNameCfg[996].name)

				arg_73_1.leftNameTxt_.text = var_76_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_26 = arg_73_1:GetWordFromCfg(413112018)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 33
				local var_76_29 = utf8.len(var_76_27)
				local var_76_30 = var_76_28 <= 0 and var_76_24 or var_76_24 * (var_76_29 / var_76_28)

				if var_76_30 > 0 and var_76_24 < var_76_30 then
					arg_73_1.talkMaxDuration = var_76_30

					if var_76_30 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_23
					end
				end

				arg_73_1.text_.text = var_76_27
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112018", "story_v_out_413112.awb") ~= 0 then
					local var_76_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112018", "story_v_out_413112.awb") / 1000

					if var_76_31 + var_76_23 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_31 + var_76_23
					end

					if var_76_26.prefab_name ~= "" and arg_73_1.actors_[var_76_26.prefab_name] ~= nil then
						local var_76_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_26.prefab_name].transform, "story_v_out_413112", "413112018", "story_v_out_413112.awb")

						arg_73_1:RecordAudio("413112018", var_76_32)
						arg_73_1:RecordAudio("413112018", var_76_32)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413112", "413112018", "story_v_out_413112.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413112", "413112018", "story_v_out_413112.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_33 = math.max(var_76_24, arg_73_1.talkMaxDuration)

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_33 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_23) / var_76_33

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_23 + var_76_33 and arg_73_1.time_ < var_76_23 + var_76_33 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413112019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413112019
		arg_77_1.duration_ = 7.07

		local var_77_0 = {
			zh = 7.066,
			ja = 5.566
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
				arg_77_0:Play413112020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10022"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10022 == nil then
				arg_77_1.var_.actorSpriteComps10022 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps10022 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps10022 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10022 = nil
			end

			local var_80_8 = arg_77_1.actors_["10092_1"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10092_1 == nil then
				arg_77_1.var_.actorSpriteComps10092_1 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps10092_1 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								local var_80_12 = Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, var_80_11)
								local var_80_13 = Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, var_80_11)
								local var_80_14 = Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, var_80_11)

								iter_80_5.color = Color.New(var_80_12, var_80_13, var_80_14)
							else
								local var_80_15 = Mathf.Lerp(iter_80_5.color.r, 0.5, var_80_11)

								iter_80_5.color = Color.New(var_80_15, var_80_15, var_80_15)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10092_1 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_80_16 = 0
			local var_80_17 = 0.925

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_18 = arg_77_1:FormatText(StoryNameCfg[614].name)

				arg_77_1.leftNameTxt_.text = var_80_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_19 = arg_77_1:GetWordFromCfg(413112019)
				local var_80_20 = arg_77_1:FormatText(var_80_19.content)

				arg_77_1.text_.text = var_80_20

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_21 = 37
				local var_80_22 = utf8.len(var_80_20)
				local var_80_23 = var_80_21 <= 0 and var_80_17 or var_80_17 * (var_80_22 / var_80_21)

				if var_80_23 > 0 and var_80_17 < var_80_23 then
					arg_77_1.talkMaxDuration = var_80_23

					if var_80_23 + var_80_16 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_16
					end
				end

				arg_77_1.text_.text = var_80_20
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112019", "story_v_out_413112.awb") ~= 0 then
					local var_80_24 = manager.audio:GetVoiceLength("story_v_out_413112", "413112019", "story_v_out_413112.awb") / 1000

					if var_80_24 + var_80_16 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_24 + var_80_16
					end

					if var_80_19.prefab_name ~= "" and arg_77_1.actors_[var_80_19.prefab_name] ~= nil then
						local var_80_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_19.prefab_name].transform, "story_v_out_413112", "413112019", "story_v_out_413112.awb")

						arg_77_1:RecordAudio("413112019", var_80_25)
						arg_77_1:RecordAudio("413112019", var_80_25)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413112", "413112019", "story_v_out_413112.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413112", "413112019", "story_v_out_413112.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_26 = math.max(var_80_17, arg_77_1.talkMaxDuration)

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_26 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_16) / var_80_26

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_16 + var_80_26 and arg_77_1.time_ < var_80_16 + var_80_26 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play413112020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413112020
		arg_81_1.duration_ = 4.87

		local var_81_0 = {
			zh = 4.833,
			ja = 4.866
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
				arg_81_0:Play413112021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10092_1"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10092_1 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10092_1", 4)

				local var_84_2 = var_84_0.childCount

				for iter_84_0 = 0, var_84_2 - 1 do
					local var_84_3 = var_84_0:GetChild(iter_84_0)

					if var_84_3.name == "split_1_1" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_4 then
				local var_84_5 = (arg_81_1.time_ - var_84_1) / var_84_4
				local var_84_6 = Vector3.New(390, -300, -295)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10092_1, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_84_7 = arg_81_1.actors_["10092_1"]
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps10092_1 == nil then
				arg_81_1.var_.actorSpriteComps10092_1 = var_84_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 2

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_9 and not isNil(var_84_7) then
				local var_84_10 = (arg_81_1.time_ - var_84_8) / var_84_9

				if arg_81_1.var_.actorSpriteComps10092_1 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								local var_84_11 = Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, var_84_10)
								local var_84_12 = Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, var_84_10)
								local var_84_13 = Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, var_84_10)

								iter_84_2.color = Color.New(var_84_11, var_84_12, var_84_13)
							else
								local var_84_14 = Mathf.Lerp(iter_84_2.color.r, 1, var_84_10)

								iter_84_2.color = Color.New(var_84_14, var_84_14, var_84_14)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_8 + var_84_9 and arg_81_1.time_ < var_84_8 + var_84_9 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps10092_1 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_84_4 then
						if arg_81_1.isInRecall_ then
							iter_84_4.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_84_15 = arg_81_1.actors_["10022"]
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.actorSpriteComps10022 == nil then
				arg_81_1.var_.actorSpriteComps10022 = var_84_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_17 = 2

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 and not isNil(var_84_15) then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17

				if arg_81_1.var_.actorSpriteComps10022 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								local var_84_19 = Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, var_84_18)
								local var_84_20 = Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, var_84_18)
								local var_84_21 = Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, var_84_18)

								iter_84_6.color = Color.New(var_84_19, var_84_20, var_84_21)
							else
								local var_84_22 = Mathf.Lerp(iter_84_6.color.r, 0.5, var_84_18)

								iter_84_6.color = Color.New(var_84_22, var_84_22, var_84_22)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.actorSpriteComps10022 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_84_8 then
						if arg_81_1.isInRecall_ then
							iter_84_8.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10022 = nil
			end

			local var_84_23 = 0
			local var_84_24 = 0.65

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[996].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(413112020)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112020", "story_v_out_413112.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112020", "story_v_out_413112.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_413112", "413112020", "story_v_out_413112.awb")

						arg_81_1:RecordAudio("413112020", var_84_32)
						arg_81_1:RecordAudio("413112020", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413112", "413112020", "story_v_out_413112.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413112", "413112020", "story_v_out_413112.awb")
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
				actorName = "10092_1",
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
	Play413112021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413112021
		arg_85_1.duration_ = 11.6

		local var_85_0 = {
			zh = 7.6,
			ja = 11.6
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
				arg_85_0:Play413112022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10092_1"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092_1 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092_1", 4)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "split_2" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(390, -300, -295)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092_1, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_88_7 = arg_85_1.actors_["10092_1"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10092_1 == nil then
				arg_85_1.var_.actorSpriteComps10092_1 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 2

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps10092_1 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 1, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10092_1 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_88_15 = arg_85_1.actors_["10022"]
			local var_88_16 = 0

			if var_88_16 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps10022 == nil then
				arg_85_1.var_.actorSpriteComps10022 = var_88_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_17 = 2

			if var_88_16 <= arg_85_1.time_ and arg_85_1.time_ < var_88_16 + var_88_17 and not isNil(var_88_15) then
				local var_88_18 = (arg_85_1.time_ - var_88_16) / var_88_17

				if arg_85_1.var_.actorSpriteComps10022 then
					for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_88_6 then
							if arg_85_1.isInRecall_ then
								local var_88_19 = Mathf.Lerp(iter_88_6.color.r, arg_85_1.hightColor2.r, var_88_18)
								local var_88_20 = Mathf.Lerp(iter_88_6.color.g, arg_85_1.hightColor2.g, var_88_18)
								local var_88_21 = Mathf.Lerp(iter_88_6.color.b, arg_85_1.hightColor2.b, var_88_18)

								iter_88_6.color = Color.New(var_88_19, var_88_20, var_88_21)
							else
								local var_88_22 = Mathf.Lerp(iter_88_6.color.r, 0.5, var_88_18)

								iter_88_6.color = Color.New(var_88_22, var_88_22, var_88_22)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_16 + var_88_17 and arg_85_1.time_ < var_88_16 + var_88_17 + arg_88_0 and not isNil(var_88_15) and arg_85_1.var_.actorSpriteComps10022 then
				for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_88_8 then
						if arg_85_1.isInRecall_ then
							iter_88_8.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10022 = nil
			end

			local var_88_23 = 0
			local var_88_24 = 0.9

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[996].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(413112021)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 36
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112021", "story_v_out_413112.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112021", "story_v_out_413112.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_413112", "413112021", "story_v_out_413112.awb")

						arg_85_1:RecordAudio("413112021", var_88_32)
						arg_85_1:RecordAudio("413112021", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413112", "413112021", "story_v_out_413112.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413112", "413112021", "story_v_out_413112.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413112022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413112022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play413112023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10092_1"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10092_1 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10092_1", 6)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(1500, -300, -295)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10092_1, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_92_7 = arg_89_1.actors_["10022"].transform
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.var_.moveOldPos10022 = var_92_7.localPosition
				var_92_7.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10022", 6)

				local var_92_9 = var_92_7.childCount

				for iter_92_1 = 0, var_92_9 - 1 do
					local var_92_10 = var_92_7:GetChild(iter_92_1)

					if var_92_10.name == "" or not string.find(var_92_10.name, "split") then
						var_92_10.gameObject:SetActive(true)
					else
						var_92_10.gameObject:SetActive(false)
					end
				end
			end

			local var_92_11 = 0.001

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_11 then
				local var_92_12 = (arg_89_1.time_ - var_92_8) / var_92_11
				local var_92_13 = Vector3.New(1500, -315, -320)

				var_92_7.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10022, var_92_13, var_92_12)
			end

			if arg_89_1.time_ >= var_92_8 + var_92_11 and arg_89_1.time_ < var_92_8 + var_92_11 + arg_92_0 then
				var_92_7.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_92_14 = arg_89_1.actors_["10092_1"]
			local var_92_15 = 0

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.actorSpriteComps10092_1 == nil then
				arg_89_1.var_.actorSpriteComps10092_1 = var_92_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_16 = 2

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_16 and not isNil(var_92_14) then
				local var_92_17 = (arg_89_1.time_ - var_92_15) / var_92_16

				if arg_89_1.var_.actorSpriteComps10092_1 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								local var_92_18 = Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor2.r, var_92_17)
								local var_92_19 = Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor2.g, var_92_17)
								local var_92_20 = Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor2.b, var_92_17)

								iter_92_3.color = Color.New(var_92_18, var_92_19, var_92_20)
							else
								local var_92_21 = Mathf.Lerp(iter_92_3.color.r, 0.5, var_92_17)

								iter_92_3.color = Color.New(var_92_21, var_92_21, var_92_21)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_15 + var_92_16 and arg_89_1.time_ < var_92_15 + var_92_16 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.actorSpriteComps10092_1 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_92_5 then
						if arg_89_1.isInRecall_ then
							iter_92_5.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_92_22 = arg_89_1.actors_["10022"]
			local var_92_23 = 0

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 and not isNil(var_92_22) and arg_89_1.var_.actorSpriteComps10022 == nil then
				arg_89_1.var_.actorSpriteComps10022 = var_92_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_24 = 2

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_24 and not isNil(var_92_22) then
				local var_92_25 = (arg_89_1.time_ - var_92_23) / var_92_24

				if arg_89_1.var_.actorSpriteComps10022 then
					for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_92_7 then
							if arg_89_1.isInRecall_ then
								local var_92_26 = Mathf.Lerp(iter_92_7.color.r, arg_89_1.hightColor2.r, var_92_25)
								local var_92_27 = Mathf.Lerp(iter_92_7.color.g, arg_89_1.hightColor2.g, var_92_25)
								local var_92_28 = Mathf.Lerp(iter_92_7.color.b, arg_89_1.hightColor2.b, var_92_25)

								iter_92_7.color = Color.New(var_92_26, var_92_27, var_92_28)
							else
								local var_92_29 = Mathf.Lerp(iter_92_7.color.r, 0.5, var_92_25)

								iter_92_7.color = Color.New(var_92_29, var_92_29, var_92_29)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_23 + var_92_24 and arg_89_1.time_ < var_92_23 + var_92_24 + arg_92_0 and not isNil(var_92_22) and arg_89_1.var_.actorSpriteComps10022 then
				for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_92_9 then
						if arg_89_1.isInRecall_ then
							iter_92_9.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10022 = nil
			end

			local var_92_30 = 0
			local var_92_31 = 1.075

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_32 = arg_89_1:GetWordFromCfg(413112022)
				local var_92_33 = arg_89_1:FormatText(var_92_32.content)

				arg_89_1.text_.text = var_92_33

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_34 = 43
				local var_92_35 = utf8.len(var_92_33)
				local var_92_36 = var_92_34 <= 0 and var_92_31 or var_92_31 * (var_92_35 / var_92_34)

				if var_92_36 > 0 and var_92_31 < var_92_36 then
					arg_89_1.talkMaxDuration = var_92_36

					if var_92_36 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_36 + var_92_30
					end
				end

				arg_89_1.text_.text = var_92_33
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_37 = math.max(var_92_31, arg_89_1.talkMaxDuration)

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_37 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_30) / var_92_37

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_30 + var_92_37 and arg_89_1.time_ < var_92_30 + var_92_37 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_89_1:InitPlayNodeList()
	end,
	Play413112023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413112023
		arg_93_1.duration_ = 4.6

		local var_93_0 = {
			zh = 2.133,
			ja = 4.6
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
				arg_93_0:Play413112024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10022"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10022 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10022", 2)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(-390, -315, -320)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10022, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_96_7 = arg_93_1.actors_["10022"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10022 == nil then
				arg_93_1.var_.actorSpriteComps10022 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps10022 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								local var_96_11 = Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor1.r, var_96_10)
								local var_96_12 = Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor1.g, var_96_10)
								local var_96_13 = Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor1.b, var_96_10)

								iter_96_2.color = Color.New(var_96_11, var_96_12, var_96_13)
							else
								local var_96_14 = Mathf.Lerp(iter_96_2.color.r, 1, var_96_10)

								iter_96_2.color = Color.New(var_96_14, var_96_14, var_96_14)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10022 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10022 = nil
			end

			local var_96_15 = 0
			local var_96_16 = 0.325

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_17 = arg_93_1:FormatText(StoryNameCfg[614].name)

				arg_93_1.leftNameTxt_.text = var_96_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_18 = arg_93_1:GetWordFromCfg(413112023)
				local var_96_19 = arg_93_1:FormatText(var_96_18.content)

				arg_93_1.text_.text = var_96_19

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_20 = 13
				local var_96_21 = utf8.len(var_96_19)
				local var_96_22 = var_96_20 <= 0 and var_96_16 or var_96_16 * (var_96_21 / var_96_20)

				if var_96_22 > 0 and var_96_16 < var_96_22 then
					arg_93_1.talkMaxDuration = var_96_22

					if var_96_22 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_22 + var_96_15
					end
				end

				arg_93_1.text_.text = var_96_19
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112023", "story_v_out_413112.awb") ~= 0 then
					local var_96_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112023", "story_v_out_413112.awb") / 1000

					if var_96_23 + var_96_15 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_15
					end

					if var_96_18.prefab_name ~= "" and arg_93_1.actors_[var_96_18.prefab_name] ~= nil then
						local var_96_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_18.prefab_name].transform, "story_v_out_413112", "413112023", "story_v_out_413112.awb")

						arg_93_1:RecordAudio("413112023", var_96_24)
						arg_93_1:RecordAudio("413112023", var_96_24)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413112", "413112023", "story_v_out_413112.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413112", "413112023", "story_v_out_413112.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_25 = math.max(var_96_16, arg_93_1.talkMaxDuration)

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_25 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_15) / var_96_25

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_15 + var_96_25 and arg_93_1.time_ < var_96_15 + var_96_25 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play413112024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413112024
		arg_97_1.duration_ = 3.43

		local var_97_0 = {
			zh = 3.433,
			ja = 2.466
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
				arg_97_0:Play413112025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10022"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10022 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10022", 2)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(-390, -315, -320)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10022, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_100_7 = arg_97_1.actors_["10093"].transform
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.var_.moveOldPos10093 = var_100_7.localPosition
				var_100_7.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10093", 4)

				local var_100_9 = var_100_7.childCount

				for iter_100_1 = 0, var_100_9 - 1 do
					local var_100_10 = var_100_7:GetChild(iter_100_1)

					if var_100_10.name == "" or not string.find(var_100_10.name, "split") then
						var_100_10.gameObject:SetActive(true)
					else
						var_100_10.gameObject:SetActive(false)
					end
				end
			end

			local var_100_11 = 0.001

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_11 then
				local var_100_12 = (arg_97_1.time_ - var_100_8) / var_100_11
				local var_100_13 = Vector3.New(390, -345, -245)

				var_100_7.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10093, var_100_13, var_100_12)
			end

			if arg_97_1.time_ >= var_100_8 + var_100_11 and arg_97_1.time_ < var_100_8 + var_100_11 + arg_100_0 then
				var_100_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_100_14 = arg_97_1.actors_["10022"]
			local var_100_15 = 0

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.actorSpriteComps10022 == nil then
				arg_97_1.var_.actorSpriteComps10022 = var_100_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_16 = 2

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_16 and not isNil(var_100_14) then
				local var_100_17 = (arg_97_1.time_ - var_100_15) / var_100_16

				if arg_97_1.var_.actorSpriteComps10022 then
					for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_100_3 then
							if arg_97_1.isInRecall_ then
								local var_100_18 = Mathf.Lerp(iter_100_3.color.r, arg_97_1.hightColor2.r, var_100_17)
								local var_100_19 = Mathf.Lerp(iter_100_3.color.g, arg_97_1.hightColor2.g, var_100_17)
								local var_100_20 = Mathf.Lerp(iter_100_3.color.b, arg_97_1.hightColor2.b, var_100_17)

								iter_100_3.color = Color.New(var_100_18, var_100_19, var_100_20)
							else
								local var_100_21 = Mathf.Lerp(iter_100_3.color.r, 0.5, var_100_17)

								iter_100_3.color = Color.New(var_100_21, var_100_21, var_100_21)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_15 + var_100_16 and arg_97_1.time_ < var_100_15 + var_100_16 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.actorSpriteComps10022 then
				for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_100_5 then
						if arg_97_1.isInRecall_ then
							iter_100_5.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10022 = nil
			end

			local var_100_22 = arg_97_1.actors_["10093"]
			local var_100_23 = 0

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 and not isNil(var_100_22) and arg_97_1.var_.actorSpriteComps10093 == nil then
				arg_97_1.var_.actorSpriteComps10093 = var_100_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_24 = 2

			if var_100_23 <= arg_97_1.time_ and arg_97_1.time_ < var_100_23 + var_100_24 and not isNil(var_100_22) then
				local var_100_25 = (arg_97_1.time_ - var_100_23) / var_100_24

				if arg_97_1.var_.actorSpriteComps10093 then
					for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_100_7 then
							if arg_97_1.isInRecall_ then
								local var_100_26 = Mathf.Lerp(iter_100_7.color.r, arg_97_1.hightColor1.r, var_100_25)
								local var_100_27 = Mathf.Lerp(iter_100_7.color.g, arg_97_1.hightColor1.g, var_100_25)
								local var_100_28 = Mathf.Lerp(iter_100_7.color.b, arg_97_1.hightColor1.b, var_100_25)

								iter_100_7.color = Color.New(var_100_26, var_100_27, var_100_28)
							else
								local var_100_29 = Mathf.Lerp(iter_100_7.color.r, 1, var_100_25)

								iter_100_7.color = Color.New(var_100_29, var_100_29, var_100_29)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_23 + var_100_24 and arg_97_1.time_ < var_100_23 + var_100_24 + arg_100_0 and not isNil(var_100_22) and arg_97_1.var_.actorSpriteComps10093 then
				for iter_100_8, iter_100_9 in pairs(arg_97_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_100_9 then
						if arg_97_1.isInRecall_ then
							iter_100_9.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10093 = nil
			end

			local var_100_30 = 0
			local var_100_31 = 0.425

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_32 = arg_97_1:FormatText(StoryNameCfg[28].name)

				arg_97_1.leftNameTxt_.text = var_100_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_33 = arg_97_1:GetWordFromCfg(413112024)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 17
				local var_100_36 = utf8.len(var_100_34)
				local var_100_37 = var_100_35 <= 0 and var_100_31 or var_100_31 * (var_100_36 / var_100_35)

				if var_100_37 > 0 and var_100_31 < var_100_37 then
					arg_97_1.talkMaxDuration = var_100_37

					if var_100_37 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_37 + var_100_30
					end
				end

				arg_97_1.text_.text = var_100_34
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112024", "story_v_out_413112.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112024", "story_v_out_413112.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_out_413112", "413112024", "story_v_out_413112.awb")

						arg_97_1:RecordAudio("413112024", var_100_39)
						arg_97_1:RecordAudio("413112024", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413112", "413112024", "story_v_out_413112.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413112", "413112024", "story_v_out_413112.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_40 = math.max(var_100_31, arg_97_1.talkMaxDuration)

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_40 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_30) / var_100_40

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_30 + var_100_40 and arg_97_1.time_ < var_100_30 + var_100_40 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413112025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413112025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413112026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10022"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10022 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10022", 6)

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
				local var_104_6 = Vector3.New(1500, -315, -320)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10022, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_104_7 = arg_101_1.actors_["10093"].transform
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = var_104_7.localPosition
				var_104_7.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 6)

				local var_104_9 = var_104_7.childCount

				for iter_104_1 = 0, var_104_9 - 1 do
					local var_104_10 = var_104_7:GetChild(iter_104_1)

					if var_104_10.name == "" or not string.find(var_104_10.name, "split") then
						var_104_10.gameObject:SetActive(true)
					else
						var_104_10.gameObject:SetActive(false)
					end
				end
			end

			local var_104_11 = 0.001

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_11 then
				local var_104_12 = (arg_101_1.time_ - var_104_8) / var_104_11
				local var_104_13 = Vector3.New(1500, -345, -245)

				var_104_7.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, var_104_13, var_104_12)
			end

			if arg_101_1.time_ >= var_104_8 + var_104_11 and arg_101_1.time_ < var_104_8 + var_104_11 + arg_104_0 then
				var_104_7.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_104_14 = arg_101_1.actors_["10022"]
			local var_104_15 = 0

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 and not isNil(var_104_14) and arg_101_1.var_.actorSpriteComps10022 == nil then
				arg_101_1.var_.actorSpriteComps10022 = var_104_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_16 = 2

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_16 and not isNil(var_104_14) then
				local var_104_17 = (arg_101_1.time_ - var_104_15) / var_104_16

				if arg_101_1.var_.actorSpriteComps10022 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								local var_104_18 = Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor2.r, var_104_17)
								local var_104_19 = Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor2.g, var_104_17)
								local var_104_20 = Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor2.b, var_104_17)

								iter_104_3.color = Color.New(var_104_18, var_104_19, var_104_20)
							else
								local var_104_21 = Mathf.Lerp(iter_104_3.color.r, 0.5, var_104_17)

								iter_104_3.color = Color.New(var_104_21, var_104_21, var_104_21)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_15 + var_104_16 and arg_101_1.time_ < var_104_15 + var_104_16 + arg_104_0 and not isNil(var_104_14) and arg_101_1.var_.actorSpriteComps10022 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_104_5 then
						if arg_101_1.isInRecall_ then
							iter_104_5.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10022 = nil
			end

			local var_104_22 = arg_101_1.actors_["10093"]
			local var_104_23 = 0

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 and not isNil(var_104_22) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_24 = 2

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_24 and not isNil(var_104_22) then
				local var_104_25 = (arg_101_1.time_ - var_104_23) / var_104_24

				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_7 then
							if arg_101_1.isInRecall_ then
								local var_104_26 = Mathf.Lerp(iter_104_7.color.r, arg_101_1.hightColor2.r, var_104_25)
								local var_104_27 = Mathf.Lerp(iter_104_7.color.g, arg_101_1.hightColor2.g, var_104_25)
								local var_104_28 = Mathf.Lerp(iter_104_7.color.b, arg_101_1.hightColor2.b, var_104_25)

								iter_104_7.color = Color.New(var_104_26, var_104_27, var_104_28)
							else
								local var_104_29 = Mathf.Lerp(iter_104_7.color.r, 0.5, var_104_25)

								iter_104_7.color = Color.New(var_104_29, var_104_29, var_104_29)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_23 + var_104_24 and arg_101_1.time_ < var_104_23 + var_104_24 + arg_104_0 and not isNil(var_104_22) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_8, iter_104_9 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_9 then
						if arg_101_1.isInRecall_ then
							iter_104_9.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_30 = 0
			local var_104_31 = 1

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				local var_104_32 = "play"
				local var_104_33 = "effect"

				arg_101_1:AudioAction(var_104_32, var_104_33, "se_story_135_01", "se_story_135_01_jump", "")
			end

			local var_104_34 = 0
			local var_104_35 = 1.275

			if var_104_34 < arg_101_1.time_ and arg_101_1.time_ <= var_104_34 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_36 = arg_101_1:GetWordFromCfg(413112025)
				local var_104_37 = arg_101_1:FormatText(var_104_36.content)

				arg_101_1.text_.text = var_104_37

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_38 = 51
				local var_104_39 = utf8.len(var_104_37)
				local var_104_40 = var_104_38 <= 0 and var_104_35 or var_104_35 * (var_104_39 / var_104_38)

				if var_104_40 > 0 and var_104_35 < var_104_40 then
					arg_101_1.talkMaxDuration = var_104_40

					if var_104_40 + var_104_34 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_40 + var_104_34
					end
				end

				arg_101_1.text_.text = var_104_37
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_41 = math.max(var_104_35, arg_101_1.talkMaxDuration)

			if var_104_34 <= arg_101_1.time_ and arg_101_1.time_ < var_104_34 + var_104_41 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_34) / var_104_41

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_34 + var_104_41 and arg_101_1.time_ < var_104_34 + var_104_41 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413112026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413112026
		arg_105_1.duration_ = 2

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play413112027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10022"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10022 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10022", 3)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "split_4" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(0, -315, -320)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10022, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_108_7 = arg_105_1.actors_["10022"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10022 == nil then
				arg_105_1.var_.actorSpriteComps10022 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps10022 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								local var_108_11 = Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, var_108_10)
								local var_108_12 = Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, var_108_10)
								local var_108_13 = Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, var_108_10)

								iter_108_2.color = Color.New(var_108_11, var_108_12, var_108_13)
							else
								local var_108_14 = Mathf.Lerp(iter_108_2.color.r, 1, var_108_10)

								iter_108_2.color = Color.New(var_108_14, var_108_14, var_108_14)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps10022 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10022 = nil
			end

			local var_108_15 = 0
			local var_108_16 = 0.075

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[614].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(413112026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 3
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112026", "story_v_out_413112.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112026", "story_v_out_413112.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_out_413112", "413112026", "story_v_out_413112.awb")

						arg_105_1:RecordAudio("413112026", var_108_24)
						arg_105_1:RecordAudio("413112026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413112", "413112026", "story_v_out_413112.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413112", "413112026", "story_v_out_413112.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play413112027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413112027
		arg_109_1.duration_ = 8.73

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play413112028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = "F09f"

			if arg_109_1.bgs_[var_112_0] == nil then
				local var_112_1 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_0)
				var_112_1.name = var_112_0
				var_112_1.transform.parent = arg_109_1.stage_.transform
				var_112_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_0] = var_112_1
			end

			local var_112_2 = 2

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				local var_112_3 = manager.ui.mainCamera.transform.localPosition
				local var_112_4 = Vector3.New(0, 0, 10) + Vector3.New(var_112_3.x, var_112_3.y, 0)
				local var_112_5 = arg_109_1.bgs_.F09f

				var_112_5.transform.localPosition = var_112_4
				var_112_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_6 = var_112_5:GetComponent("SpriteRenderer")

				if var_112_6 and var_112_6.sprite then
					local var_112_7 = (var_112_5.transform.localPosition - var_112_3).z
					local var_112_8 = manager.ui.mainCameraCom_
					local var_112_9 = 2 * var_112_7 * Mathf.Tan(var_112_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_112_10 = var_112_9 * var_112_8.aspect
					local var_112_11 = var_112_6.sprite.bounds.size.x
					local var_112_12 = var_112_6.sprite.bounds.size.y
					local var_112_13 = var_112_10 / var_112_11
					local var_112_14 = var_112_9 / var_112_12
					local var_112_15 = var_112_14 < var_112_13 and var_112_13 or var_112_14

					var_112_5.transform.localScale = Vector3.New(var_112_15, var_112_15, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "F09f" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_16 = 4

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			local var_112_17 = 0.3

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			local var_112_18 = 0

			if var_112_18 < arg_109_1.time_ and arg_109_1.time_ <= var_112_18 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_19 = 2

			if var_112_18 <= arg_109_1.time_ and arg_109_1.time_ < var_112_18 + var_112_19 then
				local var_112_20 = (arg_109_1.time_ - var_112_18) / var_112_19
				local var_112_21 = Color.New(0, 0, 0)

				var_112_21.a = Mathf.Lerp(0, 1, var_112_20)
				arg_109_1.mask_.color = var_112_21
			end

			if arg_109_1.time_ >= var_112_18 + var_112_19 and arg_109_1.time_ < var_112_18 + var_112_19 + arg_112_0 then
				local var_112_22 = Color.New(0, 0, 0)

				var_112_22.a = 1
				arg_109_1.mask_.color = var_112_22
			end

			local var_112_23 = 2

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_24 = 2

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_24 then
				local var_112_25 = (arg_109_1.time_ - var_112_23) / var_112_24
				local var_112_26 = Color.New(0, 0, 0)

				var_112_26.a = Mathf.Lerp(1, 0, var_112_25)
				arg_109_1.mask_.color = var_112_26
			end

			if arg_109_1.time_ >= var_112_23 + var_112_24 and arg_109_1.time_ < var_112_23 + var_112_24 + arg_112_0 then
				local var_112_27 = Color.New(0, 0, 0)
				local var_112_28 = 0

				arg_109_1.mask_.enabled = false
				var_112_27.a = var_112_28
				arg_109_1.mask_.color = var_112_27
			end

			local var_112_29 = arg_109_1.actors_["10022"].transform
			local var_112_30 = 2

			if var_112_30 < arg_109_1.time_ and arg_109_1.time_ <= var_112_30 + arg_112_0 then
				arg_109_1.var_.moveOldPos10022 = var_112_29.localPosition
				var_112_29.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10022", 7)

				local var_112_31 = var_112_29.childCount

				for iter_112_2 = 0, var_112_31 - 1 do
					local var_112_32 = var_112_29:GetChild(iter_112_2)

					if var_112_32.name == "split_4" or not string.find(var_112_32.name, "split") then
						var_112_32.gameObject:SetActive(true)
					else
						var_112_32.gameObject:SetActive(false)
					end
				end
			end

			local var_112_33 = 0.001

			if var_112_30 <= arg_109_1.time_ and arg_109_1.time_ < var_112_30 + var_112_33 then
				local var_112_34 = (arg_109_1.time_ - var_112_30) / var_112_33
				local var_112_35 = Vector3.New(0, -2000, 0)

				var_112_29.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10022, var_112_35, var_112_34)
			end

			if arg_109_1.time_ >= var_112_30 + var_112_33 and arg_109_1.time_ < var_112_30 + var_112_33 + arg_112_0 then
				var_112_29.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_36 = 3.73333333333333
			local var_112_37 = 1.025

			if var_112_36 < arg_109_1.time_ and arg_109_1.time_ <= var_112_36 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_38 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_38:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_39 = arg_109_1:GetWordFromCfg(413112027)
				local var_112_40 = arg_109_1:FormatText(var_112_39.content)

				arg_109_1.text_.text = var_112_40

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_41 = 41
				local var_112_42 = utf8.len(var_112_40)
				local var_112_43 = var_112_41 <= 0 and var_112_37 or var_112_37 * (var_112_42 / var_112_41)

				if var_112_43 > 0 and var_112_37 < var_112_43 then
					arg_109_1.talkMaxDuration = var_112_43
					var_112_36 = var_112_36 + 0.3

					if var_112_43 + var_112_36 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_43 + var_112_36
					end
				end

				arg_109_1.text_.text = var_112_40
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_44 = var_112_36 + 0.3
			local var_112_45 = math.max(var_112_37, arg_109_1.talkMaxDuration)

			if var_112_44 <= arg_109_1.time_ and arg_109_1.time_ < var_112_44 + var_112_45 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_44) / var_112_45

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_44 + var_112_45 and arg_109_1.time_ < var_112_44 + var_112_45 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play413112028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413112028
		arg_115_1.duration_ = 9.87

		local var_115_0 = {
			zh = 4.866,
			ja = 9.866
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
				arg_115_0:Play413112029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = "10096"

			if arg_115_1.actors_[var_118_0] == nil then
				local var_118_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

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

			local var_118_4 = arg_115_1.actors_["10096"].transform
			local var_118_5 = 0

			if var_118_5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.var_.moveOldPos10096 = var_118_4.localPosition
				var_118_4.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10096", 2)

				local var_118_6 = var_118_4.childCount

				for iter_118_2 = 0, var_118_6 - 1 do
					local var_118_7 = var_118_4:GetChild(iter_118_2)

					if var_118_7.name == "" or not string.find(var_118_7.name, "split") then
						var_118_7.gameObject:SetActive(true)
					else
						var_118_7.gameObject:SetActive(false)
					end
				end
			end

			local var_118_8 = 0.001

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_8 then
				local var_118_9 = (arg_115_1.time_ - var_118_5) / var_118_8
				local var_118_10 = Vector3.New(-390, -350, -210)

				var_118_4.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10096, var_118_10, var_118_9)
			end

			if arg_115_1.time_ >= var_118_5 + var_118_8 and arg_115_1.time_ < var_118_5 + var_118_8 + arg_118_0 then
				var_118_4.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_118_11 = arg_115_1.actors_["10096"]
			local var_118_12 = 0

			if var_118_12 < arg_115_1.time_ and arg_115_1.time_ <= var_118_12 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps10096 == nil then
				arg_115_1.var_.actorSpriteComps10096 = var_118_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_13 = 2

			if var_118_12 <= arg_115_1.time_ and arg_115_1.time_ < var_118_12 + var_118_13 and not isNil(var_118_11) then
				local var_118_14 = (arg_115_1.time_ - var_118_12) / var_118_13

				if arg_115_1.var_.actorSpriteComps10096 then
					for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_118_4 then
							if arg_115_1.isInRecall_ then
								local var_118_15 = Mathf.Lerp(iter_118_4.color.r, arg_115_1.hightColor1.r, var_118_14)
								local var_118_16 = Mathf.Lerp(iter_118_4.color.g, arg_115_1.hightColor1.g, var_118_14)
								local var_118_17 = Mathf.Lerp(iter_118_4.color.b, arg_115_1.hightColor1.b, var_118_14)

								iter_118_4.color = Color.New(var_118_15, var_118_16, var_118_17)
							else
								local var_118_18 = Mathf.Lerp(iter_118_4.color.r, 1, var_118_14)

								iter_118_4.color = Color.New(var_118_18, var_118_18, var_118_18)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= var_118_12 + var_118_13 and arg_115_1.time_ < var_118_12 + var_118_13 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.actorSpriteComps10096 then
				for iter_118_5, iter_118_6 in pairs(arg_115_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_118_6 then
						if arg_115_1.isInRecall_ then
							iter_118_6.color = arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_118_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_115_1.var_.actorSpriteComps10096 = nil
			end

			local var_118_19 = 0
			local var_118_20 = 0.425

			if var_118_19 < arg_115_1.time_ and arg_115_1.time_ <= var_118_19 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_21 = arg_115_1:FormatText(StoryNameCfg[36].name)

				arg_115_1.leftNameTxt_.text = var_118_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_22 = arg_115_1:GetWordFromCfg(413112028)
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112028", "story_v_out_413112.awb") ~= 0 then
					local var_118_27 = manager.audio:GetVoiceLength("story_v_out_413112", "413112028", "story_v_out_413112.awb") / 1000

					if var_118_27 + var_118_19 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_27 + var_118_19
					end

					if var_118_22.prefab_name ~= "" and arg_115_1.actors_[var_118_22.prefab_name] ~= nil then
						local var_118_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_22.prefab_name].transform, "story_v_out_413112", "413112028", "story_v_out_413112.awb")

						arg_115_1:RecordAudio("413112028", var_118_28)
						arg_115_1:RecordAudio("413112028", var_118_28)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413112", "413112028", "story_v_out_413112.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413112", "413112028", "story_v_out_413112.awb")
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
				actorName = "10096",
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
	Play413112029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413112029
		arg_119_1.duration_ = 3.8

		local var_119_0 = {
			zh = 2.033,
			ja = 3.8
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
				arg_119_0:Play413112030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = "10094"

			if arg_119_1.actors_[var_122_0] == nil then
				local var_122_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_122_1) then
					local var_122_2 = Object.Instantiate(var_122_1, arg_119_1.canvasGo_.transform)

					var_122_2.transform:SetSiblingIndex(1)

					var_122_2.name = var_122_0
					var_122_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_119_1.actors_[var_122_0] = var_122_2

					local var_122_3 = var_122_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_119_1.isInRecall_ then
						for iter_122_0, iter_122_1 in ipairs(var_122_3) do
							iter_122_1.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_122_4 = arg_119_1.actors_["10094"].transform
			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.var_.moveOldPos10094 = var_122_4.localPosition
				var_122_4.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10094", 4)

				local var_122_6 = var_122_4.childCount

				for iter_122_2 = 0, var_122_6 - 1 do
					local var_122_7 = var_122_4:GetChild(iter_122_2)

					if var_122_7.name == "" or not string.find(var_122_7.name, "split") then
						var_122_7.gameObject:SetActive(true)
					else
						var_122_7.gameObject:SetActive(false)
					end
				end
			end

			local var_122_8 = 0.001

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_8 then
				local var_122_9 = (arg_119_1.time_ - var_122_5) / var_122_8
				local var_122_10 = Vector3.New(390, -340, -414)

				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10094, var_122_10, var_122_9)
			end

			if arg_119_1.time_ >= var_122_5 + var_122_8 and arg_119_1.time_ < var_122_5 + var_122_8 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(390, -340, -414)
			end

			local var_122_11 = arg_119_1.actors_["10096"].transform
			local var_122_12 = 0

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.var_.moveOldPos10096 = var_122_11.localPosition
				var_122_11.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10096", 2)

				local var_122_13 = var_122_11.childCount

				for iter_122_3 = 0, var_122_13 - 1 do
					local var_122_14 = var_122_11:GetChild(iter_122_3)

					if var_122_14.name == "" or not string.find(var_122_14.name, "split") then
						var_122_14.gameObject:SetActive(true)
					else
						var_122_14.gameObject:SetActive(false)
					end
				end
			end

			local var_122_15 = 0.001

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_15 then
				local var_122_16 = (arg_119_1.time_ - var_122_12) / var_122_15
				local var_122_17 = Vector3.New(-390, -350, -210)

				var_122_11.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10096, var_122_17, var_122_16)
			end

			if arg_119_1.time_ >= var_122_12 + var_122_15 and arg_119_1.time_ < var_122_12 + var_122_15 + arg_122_0 then
				var_122_11.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_122_18 = arg_119_1.actors_["10094"]
			local var_122_19 = 0

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 and not isNil(var_122_18) and arg_119_1.var_.actorSpriteComps10094 == nil then
				arg_119_1.var_.actorSpriteComps10094 = var_122_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_20 = 2

			if var_122_19 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_20 and not isNil(var_122_18) then
				local var_122_21 = (arg_119_1.time_ - var_122_19) / var_122_20

				if arg_119_1.var_.actorSpriteComps10094 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								local var_122_22 = Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor1.r, var_122_21)
								local var_122_23 = Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor1.g, var_122_21)
								local var_122_24 = Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor1.b, var_122_21)

								iter_122_5.color = Color.New(var_122_22, var_122_23, var_122_24)
							else
								local var_122_25 = Mathf.Lerp(iter_122_5.color.r, 1, var_122_21)

								iter_122_5.color = Color.New(var_122_25, var_122_25, var_122_25)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_19 + var_122_20 and arg_119_1.time_ < var_122_19 + var_122_20 + arg_122_0 and not isNil(var_122_18) and arg_119_1.var_.actorSpriteComps10094 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_122_7 then
						if arg_119_1.isInRecall_ then
							iter_122_7.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10094 = nil
			end

			local var_122_26 = arg_119_1.actors_["10096"]
			local var_122_27 = 0

			if var_122_27 < arg_119_1.time_ and arg_119_1.time_ <= var_122_27 + arg_122_0 and not isNil(var_122_26) and arg_119_1.var_.actorSpriteComps10096 == nil then
				arg_119_1.var_.actorSpriteComps10096 = var_122_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_28 = 2

			if var_122_27 <= arg_119_1.time_ and arg_119_1.time_ < var_122_27 + var_122_28 and not isNil(var_122_26) then
				local var_122_29 = (arg_119_1.time_ - var_122_27) / var_122_28

				if arg_119_1.var_.actorSpriteComps10096 then
					for iter_122_8, iter_122_9 in pairs(arg_119_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_122_9 then
							if arg_119_1.isInRecall_ then
								local var_122_30 = Mathf.Lerp(iter_122_9.color.r, arg_119_1.hightColor2.r, var_122_29)
								local var_122_31 = Mathf.Lerp(iter_122_9.color.g, arg_119_1.hightColor2.g, var_122_29)
								local var_122_32 = Mathf.Lerp(iter_122_9.color.b, arg_119_1.hightColor2.b, var_122_29)

								iter_122_9.color = Color.New(var_122_30, var_122_31, var_122_32)
							else
								local var_122_33 = Mathf.Lerp(iter_122_9.color.r, 0.5, var_122_29)

								iter_122_9.color = Color.New(var_122_33, var_122_33, var_122_33)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_27 + var_122_28 and arg_119_1.time_ < var_122_27 + var_122_28 + arg_122_0 and not isNil(var_122_26) and arg_119_1.var_.actorSpriteComps10096 then
				for iter_122_10, iter_122_11 in pairs(arg_119_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_122_11 then
						if arg_119_1.isInRecall_ then
							iter_122_11.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10096 = nil
			end

			local var_122_34 = 0
			local var_122_35 = 0.275

			if var_122_34 < arg_119_1.time_ and arg_119_1.time_ <= var_122_34 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_36 = arg_119_1:FormatText(StoryNameCfg[259].name)

				arg_119_1.leftNameTxt_.text = var_122_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_37 = arg_119_1:GetWordFromCfg(413112029)
				local var_122_38 = arg_119_1:FormatText(var_122_37.content)

				arg_119_1.text_.text = var_122_38

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_39 = 11
				local var_122_40 = utf8.len(var_122_38)
				local var_122_41 = var_122_39 <= 0 and var_122_35 or var_122_35 * (var_122_40 / var_122_39)

				if var_122_41 > 0 and var_122_35 < var_122_41 then
					arg_119_1.talkMaxDuration = var_122_41

					if var_122_41 + var_122_34 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_41 + var_122_34
					end
				end

				arg_119_1.text_.text = var_122_38
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112029", "story_v_out_413112.awb") ~= 0 then
					local var_122_42 = manager.audio:GetVoiceLength("story_v_out_413112", "413112029", "story_v_out_413112.awb") / 1000

					if var_122_42 + var_122_34 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_42 + var_122_34
					end

					if var_122_37.prefab_name ~= "" and arg_119_1.actors_[var_122_37.prefab_name] ~= nil then
						local var_122_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_37.prefab_name].transform, "story_v_out_413112", "413112029", "story_v_out_413112.awb")

						arg_119_1:RecordAudio("413112029", var_122_43)
						arg_119_1:RecordAudio("413112029", var_122_43)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413112", "413112029", "story_v_out_413112.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413112", "413112029", "story_v_out_413112.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_44 = math.max(var_122_35, arg_119_1.talkMaxDuration)

			if var_122_34 <= arg_119_1.time_ and arg_119_1.time_ < var_122_34 + var_122_44 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_34) / var_122_44

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_34 + var_122_44 and arg_119_1.time_ < var_122_34 + var_122_44 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413112030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413112030
		arg_123_1.duration_ = 3.67

		local var_123_0 = {
			zh = 1.999999999999,
			ja = 3.666
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
				arg_123_0:Play413112031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10096"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10096 = var_126_0.localPosition
				var_126_0.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10096", 2)

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
				local var_126_6 = Vector3.New(-390, -350, -210)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10096, var_126_6, var_126_5)
			end

			if arg_123_1.time_ >= var_126_1 + var_126_4 and arg_123_1.time_ < var_126_1 + var_126_4 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_126_7 = arg_123_1.actors_["10094"].transform
			local var_126_8 = 0

			if var_126_8 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.var_.moveOldPos10094 = var_126_7.localPosition
				var_126_7.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10094", 4)

				local var_126_9 = var_126_7.childCount

				for iter_126_1 = 0, var_126_9 - 1 do
					local var_126_10 = var_126_7:GetChild(iter_126_1)

					if var_126_10.name == "" or not string.find(var_126_10.name, "split") then
						var_126_10.gameObject:SetActive(true)
					else
						var_126_10.gameObject:SetActive(false)
					end
				end
			end

			local var_126_11 = 0.001

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_11 then
				local var_126_12 = (arg_123_1.time_ - var_126_8) / var_126_11
				local var_126_13 = Vector3.New(390, -340, -414)

				var_126_7.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10094, var_126_13, var_126_12)
			end

			if arg_123_1.time_ >= var_126_8 + var_126_11 and arg_123_1.time_ < var_126_8 + var_126_11 + arg_126_0 then
				var_126_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_126_14 = arg_123_1.actors_["10096"]
			local var_126_15 = 0

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 and not isNil(var_126_14) and arg_123_1.var_.actorSpriteComps10096 == nil then
				arg_123_1.var_.actorSpriteComps10096 = var_126_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_16 = 2

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_16 and not isNil(var_126_14) then
				local var_126_17 = (arg_123_1.time_ - var_126_15) / var_126_16

				if arg_123_1.var_.actorSpriteComps10096 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								local var_126_18 = Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor1.r, var_126_17)
								local var_126_19 = Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor1.g, var_126_17)
								local var_126_20 = Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor1.b, var_126_17)

								iter_126_3.color = Color.New(var_126_18, var_126_19, var_126_20)
							else
								local var_126_21 = Mathf.Lerp(iter_126_3.color.r, 1, var_126_17)

								iter_126_3.color = Color.New(var_126_21, var_126_21, var_126_21)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_15 + var_126_16 and arg_123_1.time_ < var_126_15 + var_126_16 + arg_126_0 and not isNil(var_126_14) and arg_123_1.var_.actorSpriteComps10096 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_126_5 then
						if arg_123_1.isInRecall_ then
							iter_126_5.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_126_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10096 = nil
			end

			local var_126_22 = arg_123_1.actors_["10094"]
			local var_126_23 = 0

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 and not isNil(var_126_22) and arg_123_1.var_.actorSpriteComps10094 == nil then
				arg_123_1.var_.actorSpriteComps10094 = var_126_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_24 = 2

			if var_126_23 <= arg_123_1.time_ and arg_123_1.time_ < var_126_23 + var_126_24 and not isNil(var_126_22) then
				local var_126_25 = (arg_123_1.time_ - var_126_23) / var_126_24

				if arg_123_1.var_.actorSpriteComps10094 then
					for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_126_7 then
							if arg_123_1.isInRecall_ then
								local var_126_26 = Mathf.Lerp(iter_126_7.color.r, arg_123_1.hightColor2.r, var_126_25)
								local var_126_27 = Mathf.Lerp(iter_126_7.color.g, arg_123_1.hightColor2.g, var_126_25)
								local var_126_28 = Mathf.Lerp(iter_126_7.color.b, arg_123_1.hightColor2.b, var_126_25)

								iter_126_7.color = Color.New(var_126_26, var_126_27, var_126_28)
							else
								local var_126_29 = Mathf.Lerp(iter_126_7.color.r, 0.5, var_126_25)

								iter_126_7.color = Color.New(var_126_29, var_126_29, var_126_29)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= var_126_23 + var_126_24 and arg_123_1.time_ < var_126_23 + var_126_24 + arg_126_0 and not isNil(var_126_22) and arg_123_1.var_.actorSpriteComps10094 then
				for iter_126_8, iter_126_9 in pairs(arg_123_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_126_9 then
						if arg_123_1.isInRecall_ then
							iter_126_9.color = arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_126_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_123_1.var_.actorSpriteComps10094 = nil
			end

			local var_126_30 = 0
			local var_126_31 = 0.15

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_32 = arg_123_1:FormatText(StoryNameCfg[36].name)

				arg_123_1.leftNameTxt_.text = var_126_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_33 = arg_123_1:GetWordFromCfg(413112030)
				local var_126_34 = arg_123_1:FormatText(var_126_33.content)

				arg_123_1.text_.text = var_126_34

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_35 = 6
				local var_126_36 = utf8.len(var_126_34)
				local var_126_37 = var_126_35 <= 0 and var_126_31 or var_126_31 * (var_126_36 / var_126_35)

				if var_126_37 > 0 and var_126_31 < var_126_37 then
					arg_123_1.talkMaxDuration = var_126_37

					if var_126_37 + var_126_30 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_37 + var_126_30
					end
				end

				arg_123_1.text_.text = var_126_34
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112030", "story_v_out_413112.awb") ~= 0 then
					local var_126_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112030", "story_v_out_413112.awb") / 1000

					if var_126_38 + var_126_30 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_38 + var_126_30
					end

					if var_126_33.prefab_name ~= "" and arg_123_1.actors_[var_126_33.prefab_name] ~= nil then
						local var_126_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_33.prefab_name].transform, "story_v_out_413112", "413112030", "story_v_out_413112.awb")

						arg_123_1:RecordAudio("413112030", var_126_39)
						arg_123_1:RecordAudio("413112030", var_126_39)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413112", "413112030", "story_v_out_413112.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413112", "413112030", "story_v_out_413112.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_40 = math.max(var_126_31, arg_123_1.talkMaxDuration)

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_40 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_30) / var_126_40

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_30 + var_126_40 and arg_123_1.time_ < var_126_30 + var_126_40 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413112031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413112031
		arg_127_1.duration_ = 18.67

		local var_127_0 = {
			zh = 10.1,
			ja = 18.666
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
				arg_127_0:Play413112032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.925

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[36].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:GetWordFromCfg(413112031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112031", "story_v_out_413112.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112031", "story_v_out_413112.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_413112", "413112031", "story_v_out_413112.awb")

						arg_127_1:RecordAudio("413112031", var_130_9)
						arg_127_1:RecordAudio("413112031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413112", "413112031", "story_v_out_413112.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413112", "413112031", "story_v_out_413112.awb")
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
	Play413112032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413112032
		arg_131_1.duration_ = 8.33

		local var_131_0 = {
			zh = 8.2,
			ja = 8.333
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
				arg_131_0:Play413112033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10094"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10094 = var_134_0.localPosition
				var_134_0.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10094", 4)

				local var_134_2 = var_134_0.childCount

				for iter_134_0 = 0, var_134_2 - 1 do
					local var_134_3 = var_134_0:GetChild(iter_134_0)

					if var_134_3.name == "" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_4 then
				local var_134_5 = (arg_131_1.time_ - var_134_1) / var_134_4
				local var_134_6 = Vector3.New(390, -340, -414)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10094, var_134_6, var_134_5)
			end

			if arg_131_1.time_ >= var_134_1 + var_134_4 and arg_131_1.time_ < var_134_1 + var_134_4 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_134_7 = arg_131_1.actors_["10096"].transform
			local var_134_8 = 0

			if var_134_8 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.var_.moveOldPos10096 = var_134_7.localPosition
				var_134_7.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10096", 2)

				local var_134_9 = var_134_7.childCount

				for iter_134_1 = 0, var_134_9 - 1 do
					local var_134_10 = var_134_7:GetChild(iter_134_1)

					if var_134_10.name == "" or not string.find(var_134_10.name, "split") then
						var_134_10.gameObject:SetActive(true)
					else
						var_134_10.gameObject:SetActive(false)
					end
				end
			end

			local var_134_11 = 0.001

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_11 then
				local var_134_12 = (arg_131_1.time_ - var_134_8) / var_134_11
				local var_134_13 = Vector3.New(-390, -350, -210)

				var_134_7.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10096, var_134_13, var_134_12)
			end

			if arg_131_1.time_ >= var_134_8 + var_134_11 and arg_131_1.time_ < var_134_8 + var_134_11 + arg_134_0 then
				var_134_7.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_134_14 = arg_131_1.actors_["10094"]
			local var_134_15 = 0

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 and not isNil(var_134_14) and arg_131_1.var_.actorSpriteComps10094 == nil then
				arg_131_1.var_.actorSpriteComps10094 = var_134_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_16 = 2

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_16 and not isNil(var_134_14) then
				local var_134_17 = (arg_131_1.time_ - var_134_15) / var_134_16

				if arg_131_1.var_.actorSpriteComps10094 then
					for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_134_3 then
							if arg_131_1.isInRecall_ then
								local var_134_18 = Mathf.Lerp(iter_134_3.color.r, arg_131_1.hightColor1.r, var_134_17)
								local var_134_19 = Mathf.Lerp(iter_134_3.color.g, arg_131_1.hightColor1.g, var_134_17)
								local var_134_20 = Mathf.Lerp(iter_134_3.color.b, arg_131_1.hightColor1.b, var_134_17)

								iter_134_3.color = Color.New(var_134_18, var_134_19, var_134_20)
							else
								local var_134_21 = Mathf.Lerp(iter_134_3.color.r, 1, var_134_17)

								iter_134_3.color = Color.New(var_134_21, var_134_21, var_134_21)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_15 + var_134_16 and arg_131_1.time_ < var_134_15 + var_134_16 + arg_134_0 and not isNil(var_134_14) and arg_131_1.var_.actorSpriteComps10094 then
				for iter_134_4, iter_134_5 in pairs(arg_131_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_134_5 then
						if arg_131_1.isInRecall_ then
							iter_134_5.color = arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_134_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10094 = nil
			end

			local var_134_22 = arg_131_1.actors_["10096"]
			local var_134_23 = 0

			if var_134_23 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 and not isNil(var_134_22) and arg_131_1.var_.actorSpriteComps10096 == nil then
				arg_131_1.var_.actorSpriteComps10096 = var_134_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_24 = 2

			if var_134_23 <= arg_131_1.time_ and arg_131_1.time_ < var_134_23 + var_134_24 and not isNil(var_134_22) then
				local var_134_25 = (arg_131_1.time_ - var_134_23) / var_134_24

				if arg_131_1.var_.actorSpriteComps10096 then
					for iter_134_6, iter_134_7 in pairs(arg_131_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_134_7 then
							if arg_131_1.isInRecall_ then
								local var_134_26 = Mathf.Lerp(iter_134_7.color.r, arg_131_1.hightColor2.r, var_134_25)
								local var_134_27 = Mathf.Lerp(iter_134_7.color.g, arg_131_1.hightColor2.g, var_134_25)
								local var_134_28 = Mathf.Lerp(iter_134_7.color.b, arg_131_1.hightColor2.b, var_134_25)

								iter_134_7.color = Color.New(var_134_26, var_134_27, var_134_28)
							else
								local var_134_29 = Mathf.Lerp(iter_134_7.color.r, 0.5, var_134_25)

								iter_134_7.color = Color.New(var_134_29, var_134_29, var_134_29)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= var_134_23 + var_134_24 and arg_131_1.time_ < var_134_23 + var_134_24 + arg_134_0 and not isNil(var_134_22) and arg_131_1.var_.actorSpriteComps10096 then
				for iter_134_8, iter_134_9 in pairs(arg_131_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_134_9 then
						if arg_131_1.isInRecall_ then
							iter_134_9.color = arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_134_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_131_1.var_.actorSpriteComps10096 = nil
			end

			local var_134_30 = 0
			local var_134_31 = 0.9

			if var_134_30 < arg_131_1.time_ and arg_131_1.time_ <= var_134_30 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_32 = arg_131_1:FormatText(StoryNameCfg[259].name)

				arg_131_1.leftNameTxt_.text = var_134_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_33 = arg_131_1:GetWordFromCfg(413112032)
				local var_134_34 = arg_131_1:FormatText(var_134_33.content)

				arg_131_1.text_.text = var_134_34

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_35 = 36
				local var_134_36 = utf8.len(var_134_34)
				local var_134_37 = var_134_35 <= 0 and var_134_31 or var_134_31 * (var_134_36 / var_134_35)

				if var_134_37 > 0 and var_134_31 < var_134_37 then
					arg_131_1.talkMaxDuration = var_134_37

					if var_134_37 + var_134_30 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_37 + var_134_30
					end
				end

				arg_131_1.text_.text = var_134_34
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112032", "story_v_out_413112.awb") ~= 0 then
					local var_134_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112032", "story_v_out_413112.awb") / 1000

					if var_134_38 + var_134_30 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_38 + var_134_30
					end

					if var_134_33.prefab_name ~= "" and arg_131_1.actors_[var_134_33.prefab_name] ~= nil then
						local var_134_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_33.prefab_name].transform, "story_v_out_413112", "413112032", "story_v_out_413112.awb")

						arg_131_1:RecordAudio("413112032", var_134_39)
						arg_131_1:RecordAudio("413112032", var_134_39)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413112", "413112032", "story_v_out_413112.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413112", "413112032", "story_v_out_413112.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_40 = math.max(var_134_31, arg_131_1.talkMaxDuration)

			if var_134_30 <= arg_131_1.time_ and arg_131_1.time_ < var_134_30 + var_134_40 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_30) / var_134_40

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_30 + var_134_40 and arg_131_1.time_ < var_134_30 + var_134_40 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413112033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413112033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play413112034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10094"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10094 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10094", 6)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(1500, -340, -414)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10094, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_138_7 = arg_135_1.actors_["10096"].transform
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.var_.moveOldPos10096 = var_138_7.localPosition
				var_138_7.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10096", 6)

				local var_138_9 = var_138_7.childCount

				for iter_138_1 = 0, var_138_9 - 1 do
					local var_138_10 = var_138_7:GetChild(iter_138_1)

					if var_138_10.name == "" or not string.find(var_138_10.name, "split") then
						var_138_10.gameObject:SetActive(true)
					else
						var_138_10.gameObject:SetActive(false)
					end
				end
			end

			local var_138_11 = 0.001

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_11 then
				local var_138_12 = (arg_135_1.time_ - var_138_8) / var_138_11
				local var_138_13 = Vector3.New(1500, -350, -210)

				var_138_7.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10096, var_138_13, var_138_12)
			end

			if arg_135_1.time_ >= var_138_8 + var_138_11 and arg_135_1.time_ < var_138_8 + var_138_11 + arg_138_0 then
				var_138_7.localPosition = Vector3.New(1500, -350, -210)
			end

			local var_138_14 = arg_135_1.actors_["10094"]
			local var_138_15 = 0

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 and not isNil(var_138_14) and arg_135_1.var_.actorSpriteComps10094 == nil then
				arg_135_1.var_.actorSpriteComps10094 = var_138_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_16 = 2

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_16 and not isNil(var_138_14) then
				local var_138_17 = (arg_135_1.time_ - var_138_15) / var_138_16

				if arg_135_1.var_.actorSpriteComps10094 then
					for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_138_3 then
							if arg_135_1.isInRecall_ then
								local var_138_18 = Mathf.Lerp(iter_138_3.color.r, arg_135_1.hightColor2.r, var_138_17)
								local var_138_19 = Mathf.Lerp(iter_138_3.color.g, arg_135_1.hightColor2.g, var_138_17)
								local var_138_20 = Mathf.Lerp(iter_138_3.color.b, arg_135_1.hightColor2.b, var_138_17)

								iter_138_3.color = Color.New(var_138_18, var_138_19, var_138_20)
							else
								local var_138_21 = Mathf.Lerp(iter_138_3.color.r, 0.5, var_138_17)

								iter_138_3.color = Color.New(var_138_21, var_138_21, var_138_21)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_15 + var_138_16 and arg_135_1.time_ < var_138_15 + var_138_16 + arg_138_0 and not isNil(var_138_14) and arg_135_1.var_.actorSpriteComps10094 then
				for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_138_5 then
						if arg_135_1.isInRecall_ then
							iter_138_5.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10094 = nil
			end

			local var_138_22 = arg_135_1.actors_["10096"]
			local var_138_23 = 0

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 and not isNil(var_138_22) and arg_135_1.var_.actorSpriteComps10096 == nil then
				arg_135_1.var_.actorSpriteComps10096 = var_138_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_24 = 2

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_24 and not isNil(var_138_22) then
				local var_138_25 = (arg_135_1.time_ - var_138_23) / var_138_24

				if arg_135_1.var_.actorSpriteComps10096 then
					for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_138_7 then
							if arg_135_1.isInRecall_ then
								local var_138_26 = Mathf.Lerp(iter_138_7.color.r, arg_135_1.hightColor2.r, var_138_25)
								local var_138_27 = Mathf.Lerp(iter_138_7.color.g, arg_135_1.hightColor2.g, var_138_25)
								local var_138_28 = Mathf.Lerp(iter_138_7.color.b, arg_135_1.hightColor2.b, var_138_25)

								iter_138_7.color = Color.New(var_138_26, var_138_27, var_138_28)
							else
								local var_138_29 = Mathf.Lerp(iter_138_7.color.r, 0.5, var_138_25)

								iter_138_7.color = Color.New(var_138_29, var_138_29, var_138_29)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_23 + var_138_24 and arg_135_1.time_ < var_138_23 + var_138_24 + arg_138_0 and not isNil(var_138_22) and arg_135_1.var_.actorSpriteComps10096 then
				for iter_138_8, iter_138_9 in pairs(arg_135_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_138_9 then
						if arg_135_1.isInRecall_ then
							iter_138_9.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10096 = nil
			end

			local var_138_30 = 0
			local var_138_31 = 1

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 then
				local var_138_32 = "play"
				local var_138_33 = "effect"

				arg_135_1:AudioAction(var_138_32, var_138_33, "se_story", "se_story_quakeloop", "")
			end

			local var_138_34 = 0
			local var_138_35 = 1.325

			if var_138_34 < arg_135_1.time_ and arg_135_1.time_ <= var_138_34 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_36 = arg_135_1:GetWordFromCfg(413112033)
				local var_138_37 = arg_135_1:FormatText(var_138_36.content)

				arg_135_1.text_.text = var_138_37

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_38 = 53
				local var_138_39 = utf8.len(var_138_37)
				local var_138_40 = var_138_38 <= 0 and var_138_35 or var_138_35 * (var_138_39 / var_138_38)

				if var_138_40 > 0 and var_138_35 < var_138_40 then
					arg_135_1.talkMaxDuration = var_138_40

					if var_138_40 + var_138_34 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_40 + var_138_34
					end
				end

				arg_135_1.text_.text = var_138_37
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_41 = math.max(var_138_35, arg_135_1.talkMaxDuration)

			if var_138_34 <= arg_135_1.time_ and arg_135_1.time_ < var_138_34 + var_138_41 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_34) / var_138_41

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_34 + var_138_41 and arg_135_1.time_ < var_138_34 + var_138_41 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413112034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413112034
		arg_139_1.duration_ = 3.93

		local var_139_0 = {
			zh = 3.9,
			ja = 3.933
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
				arg_139_0:Play413112035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10094"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos10094 = var_142_0.localPosition
				var_142_0.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10094", 4)

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
				local var_142_6 = Vector3.New(390, -340, -414)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10094, var_142_6, var_142_5)
			end

			if arg_139_1.time_ >= var_142_1 + var_142_4 and arg_139_1.time_ < var_142_1 + var_142_4 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_142_7 = arg_139_1.actors_["10096"].transform
			local var_142_8 = 0

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.var_.moveOldPos10096 = var_142_7.localPosition
				var_142_7.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10096", 7)

				local var_142_9 = var_142_7.childCount

				for iter_142_1 = 0, var_142_9 - 1 do
					local var_142_10 = var_142_7:GetChild(iter_142_1)

					if var_142_10.name == "" or not string.find(var_142_10.name, "split") then
						var_142_10.gameObject:SetActive(true)
					else
						var_142_10.gameObject:SetActive(false)
					end
				end
			end

			local var_142_11 = 0.001

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_11 then
				local var_142_12 = (arg_139_1.time_ - var_142_8) / var_142_11
				local var_142_13 = Vector3.New(0, -2000, 0)

				var_142_7.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10096, var_142_13, var_142_12)
			end

			if arg_139_1.time_ >= var_142_8 + var_142_11 and arg_139_1.time_ < var_142_8 + var_142_11 + arg_142_0 then
				var_142_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_142_14 = arg_139_1.actors_["10094"]
			local var_142_15 = 0

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.actorSpriteComps10094 == nil then
				arg_139_1.var_.actorSpriteComps10094 = var_142_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_16 = 2

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_16 and not isNil(var_142_14) then
				local var_142_17 = (arg_139_1.time_ - var_142_15) / var_142_16

				if arg_139_1.var_.actorSpriteComps10094 then
					for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_142_3 then
							if arg_139_1.isInRecall_ then
								local var_142_18 = Mathf.Lerp(iter_142_3.color.r, arg_139_1.hightColor1.r, var_142_17)
								local var_142_19 = Mathf.Lerp(iter_142_3.color.g, arg_139_1.hightColor1.g, var_142_17)
								local var_142_20 = Mathf.Lerp(iter_142_3.color.b, arg_139_1.hightColor1.b, var_142_17)

								iter_142_3.color = Color.New(var_142_18, var_142_19, var_142_20)
							else
								local var_142_21 = Mathf.Lerp(iter_142_3.color.r, 1, var_142_17)

								iter_142_3.color = Color.New(var_142_21, var_142_21, var_142_21)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_15 + var_142_16 and arg_139_1.time_ < var_142_15 + var_142_16 + arg_142_0 and not isNil(var_142_14) and arg_139_1.var_.actorSpriteComps10094 then
				for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_142_5 then
						if arg_139_1.isInRecall_ then
							iter_142_5.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10094 = nil
			end

			local var_142_22 = arg_139_1.actors_["10096"]
			local var_142_23 = 0

			if var_142_23 < arg_139_1.time_ and arg_139_1.time_ <= var_142_23 + arg_142_0 and not isNil(var_142_22) and arg_139_1.var_.actorSpriteComps10096 == nil then
				arg_139_1.var_.actorSpriteComps10096 = var_142_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_24 = 2

			if var_142_23 <= arg_139_1.time_ and arg_139_1.time_ < var_142_23 + var_142_24 and not isNil(var_142_22) then
				local var_142_25 = (arg_139_1.time_ - var_142_23) / var_142_24

				if arg_139_1.var_.actorSpriteComps10096 then
					for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_142_7 then
							if arg_139_1.isInRecall_ then
								local var_142_26 = Mathf.Lerp(iter_142_7.color.r, arg_139_1.hightColor2.r, var_142_25)
								local var_142_27 = Mathf.Lerp(iter_142_7.color.g, arg_139_1.hightColor2.g, var_142_25)
								local var_142_28 = Mathf.Lerp(iter_142_7.color.b, arg_139_1.hightColor2.b, var_142_25)

								iter_142_7.color = Color.New(var_142_26, var_142_27, var_142_28)
							else
								local var_142_29 = Mathf.Lerp(iter_142_7.color.r, 0.5, var_142_25)

								iter_142_7.color = Color.New(var_142_29, var_142_29, var_142_29)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_23 + var_142_24 and arg_139_1.time_ < var_142_23 + var_142_24 + arg_142_0 and not isNil(var_142_22) and arg_139_1.var_.actorSpriteComps10096 then
				for iter_142_8, iter_142_9 in pairs(arg_139_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_142_9 then
						if arg_139_1.isInRecall_ then
							iter_142_9.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10096 = nil
			end

			local var_142_30 = 0
			local var_142_31 = 0.425

			if var_142_30 < arg_139_1.time_ and arg_139_1.time_ <= var_142_30 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_32 = arg_139_1:FormatText(StoryNameCfg[259].name)

				arg_139_1.leftNameTxt_.text = var_142_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_33 = arg_139_1:GetWordFromCfg(413112034)
				local var_142_34 = arg_139_1:FormatText(var_142_33.content)

				arg_139_1.text_.text = var_142_34

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_35 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112034", "story_v_out_413112.awb") ~= 0 then
					local var_142_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112034", "story_v_out_413112.awb") / 1000

					if var_142_38 + var_142_30 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_38 + var_142_30
					end

					if var_142_33.prefab_name ~= "" and arg_139_1.actors_[var_142_33.prefab_name] ~= nil then
						local var_142_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_33.prefab_name].transform, "story_v_out_413112", "413112034", "story_v_out_413112.awb")

						arg_139_1:RecordAudio("413112034", var_142_39)
						arg_139_1:RecordAudio("413112034", var_142_39)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413112", "413112034", "story_v_out_413112.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413112", "413112034", "story_v_out_413112.awb")
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
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413112035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413112035
		arg_143_1.duration_ = 6.7

		local var_143_0 = {
			zh = 6.7,
			ja = 6.466
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
				arg_143_0:Play413112036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10096"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos10096 = var_146_0.localPosition
				var_146_0.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10096", 2)

				local var_146_2 = var_146_0.childCount

				for iter_146_0 = 0, var_146_2 - 1 do
					local var_146_3 = var_146_0:GetChild(iter_146_0)

					if var_146_3.name == "" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_4 then
				local var_146_5 = (arg_143_1.time_ - var_146_1) / var_146_4
				local var_146_6 = Vector3.New(-390, -350, -210)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10096, var_146_6, var_146_5)
			end

			if arg_143_1.time_ >= var_146_1 + var_146_4 and arg_143_1.time_ < var_146_1 + var_146_4 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_146_7 = arg_143_1.actors_["10094"].transform
			local var_146_8 = 0

			if var_146_8 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.var_.moveOldPos10094 = var_146_7.localPosition
				var_146_7.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10094", 4)

				local var_146_9 = var_146_7.childCount

				for iter_146_1 = 0, var_146_9 - 1 do
					local var_146_10 = var_146_7:GetChild(iter_146_1)

					if var_146_10.name == "" or not string.find(var_146_10.name, "split") then
						var_146_10.gameObject:SetActive(true)
					else
						var_146_10.gameObject:SetActive(false)
					end
				end
			end

			local var_146_11 = 0.001

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_11 then
				local var_146_12 = (arg_143_1.time_ - var_146_8) / var_146_11
				local var_146_13 = Vector3.New(390, -340, -414)

				var_146_7.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10094, var_146_13, var_146_12)
			end

			if arg_143_1.time_ >= var_146_8 + var_146_11 and arg_143_1.time_ < var_146_8 + var_146_11 + arg_146_0 then
				var_146_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_146_14 = arg_143_1.actors_["10096"]
			local var_146_15 = 0

			if var_146_15 < arg_143_1.time_ and arg_143_1.time_ <= var_146_15 + arg_146_0 and not isNil(var_146_14) and arg_143_1.var_.actorSpriteComps10096 == nil then
				arg_143_1.var_.actorSpriteComps10096 = var_146_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_16 = 2

			if var_146_15 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_16 and not isNil(var_146_14) then
				local var_146_17 = (arg_143_1.time_ - var_146_15) / var_146_16

				if arg_143_1.var_.actorSpriteComps10096 then
					for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_146_3 then
							if arg_143_1.isInRecall_ then
								local var_146_18 = Mathf.Lerp(iter_146_3.color.r, arg_143_1.hightColor1.r, var_146_17)
								local var_146_19 = Mathf.Lerp(iter_146_3.color.g, arg_143_1.hightColor1.g, var_146_17)
								local var_146_20 = Mathf.Lerp(iter_146_3.color.b, arg_143_1.hightColor1.b, var_146_17)

								iter_146_3.color = Color.New(var_146_18, var_146_19, var_146_20)
							else
								local var_146_21 = Mathf.Lerp(iter_146_3.color.r, 1, var_146_17)

								iter_146_3.color = Color.New(var_146_21, var_146_21, var_146_21)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_15 + var_146_16 and arg_143_1.time_ < var_146_15 + var_146_16 + arg_146_0 and not isNil(var_146_14) and arg_143_1.var_.actorSpriteComps10096 then
				for iter_146_4, iter_146_5 in pairs(arg_143_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_146_5 then
						if arg_143_1.isInRecall_ then
							iter_146_5.color = arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_146_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10096 = nil
			end

			local var_146_22 = arg_143_1.actors_["10094"]
			local var_146_23 = 0

			if var_146_23 < arg_143_1.time_ and arg_143_1.time_ <= var_146_23 + arg_146_0 and not isNil(var_146_22) and arg_143_1.var_.actorSpriteComps10094 == nil then
				arg_143_1.var_.actorSpriteComps10094 = var_146_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_24 = 2

			if var_146_23 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_24 and not isNil(var_146_22) then
				local var_146_25 = (arg_143_1.time_ - var_146_23) / var_146_24

				if arg_143_1.var_.actorSpriteComps10094 then
					for iter_146_6, iter_146_7 in pairs(arg_143_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_146_7 then
							if arg_143_1.isInRecall_ then
								local var_146_26 = Mathf.Lerp(iter_146_7.color.r, arg_143_1.hightColor2.r, var_146_25)
								local var_146_27 = Mathf.Lerp(iter_146_7.color.g, arg_143_1.hightColor2.g, var_146_25)
								local var_146_28 = Mathf.Lerp(iter_146_7.color.b, arg_143_1.hightColor2.b, var_146_25)

								iter_146_7.color = Color.New(var_146_26, var_146_27, var_146_28)
							else
								local var_146_29 = Mathf.Lerp(iter_146_7.color.r, 0.5, var_146_25)

								iter_146_7.color = Color.New(var_146_29, var_146_29, var_146_29)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= var_146_23 + var_146_24 and arg_143_1.time_ < var_146_23 + var_146_24 + arg_146_0 and not isNil(var_146_22) and arg_143_1.var_.actorSpriteComps10094 then
				for iter_146_8, iter_146_9 in pairs(arg_143_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_146_9 then
						if arg_143_1.isInRecall_ then
							iter_146_9.color = arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_146_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_143_1.var_.actorSpriteComps10094 = nil
			end

			local var_146_30 = 0
			local var_146_31 = 0.425

			if var_146_30 < arg_143_1.time_ and arg_143_1.time_ <= var_146_30 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_32 = arg_143_1:FormatText(StoryNameCfg[36].name)

				arg_143_1.leftNameTxt_.text = var_146_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_33 = arg_143_1:GetWordFromCfg(413112035)
				local var_146_34 = arg_143_1:FormatText(var_146_33.content)

				arg_143_1.text_.text = var_146_34

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_35 = 17
				local var_146_36 = utf8.len(var_146_34)
				local var_146_37 = var_146_35 <= 0 and var_146_31 or var_146_31 * (var_146_36 / var_146_35)

				if var_146_37 > 0 and var_146_31 < var_146_37 then
					arg_143_1.talkMaxDuration = var_146_37

					if var_146_37 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_37 + var_146_30
					end
				end

				arg_143_1.text_.text = var_146_34
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112035", "story_v_out_413112.awb") ~= 0 then
					local var_146_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112035", "story_v_out_413112.awb") / 1000

					if var_146_38 + var_146_30 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_38 + var_146_30
					end

					if var_146_33.prefab_name ~= "" and arg_143_1.actors_[var_146_33.prefab_name] ~= nil then
						local var_146_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_33.prefab_name].transform, "story_v_out_413112", "413112035", "story_v_out_413112.awb")

						arg_143_1:RecordAudio("413112035", var_146_39)
						arg_143_1:RecordAudio("413112035", var_146_39)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413112", "413112035", "story_v_out_413112.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413112", "413112035", "story_v_out_413112.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_40 = math.max(var_146_31, arg_143_1.talkMaxDuration)

			if var_146_30 <= arg_143_1.time_ and arg_143_1.time_ < var_146_30 + var_146_40 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_30) / var_146_40

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_30 + var_146_40 and arg_143_1.time_ < var_146_30 + var_146_40 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play413112036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413112036
		arg_147_1.duration_ = 2

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play413112037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10094"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10094 = var_150_0.localPosition
				var_150_0.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10094", 4)

				local var_150_2 = var_150_0.childCount

				for iter_150_0 = 0, var_150_2 - 1 do
					local var_150_3 = var_150_0:GetChild(iter_150_0)

					if var_150_3.name == "" or not string.find(var_150_3.name, "split") then
						var_150_3.gameObject:SetActive(true)
					else
						var_150_3.gameObject:SetActive(false)
					end
				end
			end

			local var_150_4 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_4 then
				local var_150_5 = (arg_147_1.time_ - var_150_1) / var_150_4
				local var_150_6 = Vector3.New(390, -340, -414)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10094, var_150_6, var_150_5)
			end

			if arg_147_1.time_ >= var_150_1 + var_150_4 and arg_147_1.time_ < var_150_1 + var_150_4 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_150_7 = arg_147_1.actors_["10096"].transform
			local var_150_8 = 0

			if var_150_8 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.var_.moveOldPos10096 = var_150_7.localPosition
				var_150_7.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10096", 2)

				local var_150_9 = var_150_7.childCount

				for iter_150_1 = 0, var_150_9 - 1 do
					local var_150_10 = var_150_7:GetChild(iter_150_1)

					if var_150_10.name == "" or not string.find(var_150_10.name, "split") then
						var_150_10.gameObject:SetActive(true)
					else
						var_150_10.gameObject:SetActive(false)
					end
				end
			end

			local var_150_11 = 0.001

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_11 then
				local var_150_12 = (arg_147_1.time_ - var_150_8) / var_150_11
				local var_150_13 = Vector3.New(-390, -350, -210)

				var_150_7.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10096, var_150_13, var_150_12)
			end

			if arg_147_1.time_ >= var_150_8 + var_150_11 and arg_147_1.time_ < var_150_8 + var_150_11 + arg_150_0 then
				var_150_7.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_150_14 = arg_147_1.actors_["10094"]
			local var_150_15 = 0

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.actorSpriteComps10094 == nil then
				arg_147_1.var_.actorSpriteComps10094 = var_150_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_16 = 2

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_16 and not isNil(var_150_14) then
				local var_150_17 = (arg_147_1.time_ - var_150_15) / var_150_16

				if arg_147_1.var_.actorSpriteComps10094 then
					for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_150_3 then
							if arg_147_1.isInRecall_ then
								local var_150_18 = Mathf.Lerp(iter_150_3.color.r, arg_147_1.hightColor1.r, var_150_17)
								local var_150_19 = Mathf.Lerp(iter_150_3.color.g, arg_147_1.hightColor1.g, var_150_17)
								local var_150_20 = Mathf.Lerp(iter_150_3.color.b, arg_147_1.hightColor1.b, var_150_17)

								iter_150_3.color = Color.New(var_150_18, var_150_19, var_150_20)
							else
								local var_150_21 = Mathf.Lerp(iter_150_3.color.r, 1, var_150_17)

								iter_150_3.color = Color.New(var_150_21, var_150_21, var_150_21)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_15 + var_150_16 and arg_147_1.time_ < var_150_15 + var_150_16 + arg_150_0 and not isNil(var_150_14) and arg_147_1.var_.actorSpriteComps10094 then
				for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_150_5 then
						if arg_147_1.isInRecall_ then
							iter_150_5.color = arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_150_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10094 = nil
			end

			local var_150_22 = arg_147_1.actors_["10096"]
			local var_150_23 = 0

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.actorSpriteComps10096 == nil then
				arg_147_1.var_.actorSpriteComps10096 = var_150_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_24 = 2

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_24 and not isNil(var_150_22) then
				local var_150_25 = (arg_147_1.time_ - var_150_23) / var_150_24

				if arg_147_1.var_.actorSpriteComps10096 then
					for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_150_7 then
							if arg_147_1.isInRecall_ then
								local var_150_26 = Mathf.Lerp(iter_150_7.color.r, arg_147_1.hightColor2.r, var_150_25)
								local var_150_27 = Mathf.Lerp(iter_150_7.color.g, arg_147_1.hightColor2.g, var_150_25)
								local var_150_28 = Mathf.Lerp(iter_150_7.color.b, arg_147_1.hightColor2.b, var_150_25)

								iter_150_7.color = Color.New(var_150_26, var_150_27, var_150_28)
							else
								local var_150_29 = Mathf.Lerp(iter_150_7.color.r, 0.5, var_150_25)

								iter_150_7.color = Color.New(var_150_29, var_150_29, var_150_29)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= var_150_23 + var_150_24 and arg_147_1.time_ < var_150_23 + var_150_24 + arg_150_0 and not isNil(var_150_22) and arg_147_1.var_.actorSpriteComps10096 then
				for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_150_9 then
						if arg_147_1.isInRecall_ then
							iter_150_9.color = arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_150_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_147_1.var_.actorSpriteComps10096 = nil
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_30 = 0.566666666666667
			local var_150_31 = 0.1

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_32 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_32:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_33 = arg_147_1:FormatText(StoryNameCfg[259].name)

				arg_147_1.leftNameTxt_.text = var_150_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_34 = arg_147_1:GetWordFromCfg(413112036)
				local var_150_35 = arg_147_1:FormatText(var_150_34.content)

				arg_147_1.text_.text = var_150_35

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_36 = 4
				local var_150_37 = utf8.len(var_150_35)
				local var_150_38 = var_150_36 <= 0 and var_150_31 or var_150_31 * (var_150_37 / var_150_36)

				if var_150_38 > 0 and var_150_31 < var_150_38 then
					arg_147_1.talkMaxDuration = var_150_38
					var_150_30 = var_150_30 + 0.3

					if var_150_38 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_38 + var_150_30
					end
				end

				arg_147_1.text_.text = var_150_35
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112036", "story_v_out_413112.awb") ~= 0 then
					local var_150_39 = manager.audio:GetVoiceLength("story_v_out_413112", "413112036", "story_v_out_413112.awb") / 1000

					if var_150_39 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_39 + var_150_30
					end

					if var_150_34.prefab_name ~= "" and arg_147_1.actors_[var_150_34.prefab_name] ~= nil then
						local var_150_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_34.prefab_name].transform, "story_v_out_413112", "413112036", "story_v_out_413112.awb")

						arg_147_1:RecordAudio("413112036", var_150_40)
						arg_147_1:RecordAudio("413112036", var_150_40)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413112", "413112036", "story_v_out_413112.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413112", "413112036", "story_v_out_413112.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_41 = var_150_30 + 0.3
			local var_150_42 = math.max(var_150_31, arg_147_1.talkMaxDuration)

			if var_150_41 <= arg_147_1.time_ and arg_147_1.time_ < var_150_41 + var_150_42 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_41) / var_150_42

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_41 + var_150_42 and arg_147_1.time_ < var_150_41 + var_150_42 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413112037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413112037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play413112038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10094"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos10094 = var_156_0.localPosition
				var_156_0.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10094", 7)

				local var_156_2 = var_156_0.childCount

				for iter_156_0 = 0, var_156_2 - 1 do
					local var_156_3 = var_156_0:GetChild(iter_156_0)

					if var_156_3.name == "" or not string.find(var_156_3.name, "split") then
						var_156_3.gameObject:SetActive(true)
					else
						var_156_3.gameObject:SetActive(false)
					end
				end
			end

			local var_156_4 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_4 then
				local var_156_5 = (arg_153_1.time_ - var_156_1) / var_156_4
				local var_156_6 = Vector3.New(0, -2000, 0)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10094, var_156_6, var_156_5)
			end

			if arg_153_1.time_ >= var_156_1 + var_156_4 and arg_153_1.time_ < var_156_1 + var_156_4 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_7 = arg_153_1.actors_["10096"].transform
			local var_156_8 = 0

			if var_156_8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.var_.moveOldPos10096 = var_156_7.localPosition
				var_156_7.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10096", 7)

				local var_156_9 = var_156_7.childCount

				for iter_156_1 = 0, var_156_9 - 1 do
					local var_156_10 = var_156_7:GetChild(iter_156_1)

					if var_156_10.name == "" or not string.find(var_156_10.name, "split") then
						var_156_10.gameObject:SetActive(true)
					else
						var_156_10.gameObject:SetActive(false)
					end
				end
			end

			local var_156_11 = 0.001

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_11 then
				local var_156_12 = (arg_153_1.time_ - var_156_8) / var_156_11
				local var_156_13 = Vector3.New(0, -2000, 0)

				var_156_7.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10096, var_156_13, var_156_12)
			end

			if arg_153_1.time_ >= var_156_8 + var_156_11 and arg_153_1.time_ < var_156_8 + var_156_11 + arg_156_0 then
				var_156_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_156_14 = 0
			local var_156_15 = 1.15

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_16 = arg_153_1:GetWordFromCfg(413112037)
				local var_156_17 = arg_153_1:FormatText(var_156_16.content)

				arg_153_1.text_.text = var_156_17

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_18 = 46
				local var_156_19 = utf8.len(var_156_17)
				local var_156_20 = var_156_18 <= 0 and var_156_15 or var_156_15 * (var_156_19 / var_156_18)

				if var_156_20 > 0 and var_156_15 < var_156_20 then
					arg_153_1.talkMaxDuration = var_156_20

					if var_156_20 + var_156_14 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_20 + var_156_14
					end
				end

				arg_153_1.text_.text = var_156_17
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_21 = math.max(var_156_15, arg_153_1.talkMaxDuration)

			if var_156_14 <= arg_153_1.time_ and arg_153_1.time_ < var_156_14 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_14) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_14 + var_156_21 and arg_153_1.time_ < var_156_14 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
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
	Play413112038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413112038
		arg_157_1.duration_ = 6.87

		local var_157_0 = {
			zh = 5.6,
			ja = 6.866
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play413112039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10096"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10096 = var_160_0.localPosition
				var_160_0.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10096", 3)

				local var_160_2 = var_160_0.childCount

				for iter_160_0 = 0, var_160_2 - 1 do
					local var_160_3 = var_160_0:GetChild(iter_160_0)

					if var_160_3.name == "" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_4 then
				local var_160_5 = (arg_157_1.time_ - var_160_1) / var_160_4
				local var_160_6 = Vector3.New(0, -350, -210)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10096, var_160_6, var_160_5)
			end

			if arg_157_1.time_ >= var_160_1 + var_160_4 and arg_157_1.time_ < var_160_1 + var_160_4 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_160_7 = arg_157_1.actors_["10096"]
			local var_160_8 = 0

			if var_160_8 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10096 == nil then
				arg_157_1.var_.actorSpriteComps10096 = var_160_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 2

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 and not isNil(var_160_7) then
				local var_160_10 = (arg_157_1.time_ - var_160_8) / var_160_9

				if arg_157_1.var_.actorSpriteComps10096 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								local var_160_11 = Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, var_160_10)
								local var_160_12 = Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, var_160_10)
								local var_160_13 = Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, var_160_10)

								iter_160_2.color = Color.New(var_160_11, var_160_12, var_160_13)
							else
								local var_160_14 = Mathf.Lerp(iter_160_2.color.r, 1, var_160_10)

								iter_160_2.color = Color.New(var_160_14, var_160_14, var_160_14)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.actorSpriteComps10096 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_160_4 then
						if arg_157_1.isInRecall_ then
							iter_160_4.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_160_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_157_1.var_.actorSpriteComps10096 = nil
			end

			local var_160_15 = 0
			local var_160_16 = 0.55

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_17 = arg_157_1:FormatText(StoryNameCfg[36].name)

				arg_157_1.leftNameTxt_.text = var_160_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_18 = arg_157_1:GetWordFromCfg(413112038)
				local var_160_19 = arg_157_1:FormatText(var_160_18.content)

				arg_157_1.text_.text = var_160_19

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_20 = 22
				local var_160_21 = utf8.len(var_160_19)
				local var_160_22 = var_160_20 <= 0 and var_160_16 or var_160_16 * (var_160_21 / var_160_20)

				if var_160_22 > 0 and var_160_16 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22

					if var_160_22 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_19
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112038", "story_v_out_413112.awb") ~= 0 then
					local var_160_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112038", "story_v_out_413112.awb") / 1000

					if var_160_23 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_23 + var_160_15
					end

					if var_160_18.prefab_name ~= "" and arg_157_1.actors_[var_160_18.prefab_name] ~= nil then
						local var_160_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_18.prefab_name].transform, "story_v_out_413112", "413112038", "story_v_out_413112.awb")

						arg_157_1:RecordAudio("413112038", var_160_24)
						arg_157_1:RecordAudio("413112038", var_160_24)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413112", "413112038", "story_v_out_413112.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413112", "413112038", "story_v_out_413112.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_25 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_25 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_15) / var_160_25

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_15 + var_160_25 and arg_157_1.time_ < var_160_15 + var_160_25 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play413112039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413112039
		arg_161_1.duration_ = 15.57

		local var_161_0 = {
			zh = 10.166,
			ja = 15.566
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
				arg_161_0:Play413112040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.725

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[36].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(413112039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112039", "story_v_out_413112.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112039", "story_v_out_413112.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_413112", "413112039", "story_v_out_413112.awb")

						arg_161_1:RecordAudio("413112039", var_164_9)
						arg_161_1:RecordAudio("413112039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_413112", "413112039", "story_v_out_413112.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_413112", "413112039", "story_v_out_413112.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play413112040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413112040
		arg_165_1.duration_ = 11.63

		local var_165_0 = {
			zh = 11.633,
			ja = 10
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
				arg_165_0:Play413112041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10096"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10096 == nil then
				arg_165_1.var_.actorSpriteComps10096 = var_168_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_2 = 2

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.actorSpriteComps10096 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.actorSpriteComps10096 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_168_3 then
						if arg_165_1.isInRecall_ then
							iter_168_3.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_168_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_165_1.var_.actorSpriteComps10096 = nil
			end

			local var_168_8 = 0
			local var_168_9 = 0.95

			if var_168_8 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_10 = arg_165_1:FormatText(StoryNameCfg[36].name)

				arg_165_1.leftNameTxt_.text = var_168_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_11 = arg_165_1:GetWordFromCfg(413112040)
				local var_168_12 = arg_165_1:FormatText(var_168_11.content)

				arg_165_1.text_.text = var_168_12

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_13 = 38
				local var_168_14 = utf8.len(var_168_12)
				local var_168_15 = var_168_13 <= 0 and var_168_9 or var_168_9 * (var_168_14 / var_168_13)

				if var_168_15 > 0 and var_168_9 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_8
					end
				end

				arg_165_1.text_.text = var_168_12
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112040", "story_v_out_413112.awb") ~= 0 then
					local var_168_16 = manager.audio:GetVoiceLength("story_v_out_413112", "413112040", "story_v_out_413112.awb") / 1000

					if var_168_16 + var_168_8 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_8
					end

					if var_168_11.prefab_name ~= "" and arg_165_1.actors_[var_168_11.prefab_name] ~= nil then
						local var_168_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_11.prefab_name].transform, "story_v_out_413112", "413112040", "story_v_out_413112.awb")

						arg_165_1:RecordAudio("413112040", var_168_17)
						arg_165_1:RecordAudio("413112040", var_168_17)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_413112", "413112040", "story_v_out_413112.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_413112", "413112040", "story_v_out_413112.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_18 = math.max(var_168_9, arg_165_1.talkMaxDuration)

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_18 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_8) / var_168_18

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_8 + var_168_18 and arg_165_1.time_ < var_168_8 + var_168_18 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play413112041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 413112041
		arg_169_1.duration_ = 5.7

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play413112042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10096"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10096 = var_172_0.localPosition
				var_172_0.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10096", 3)

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
				local var_172_6 = Vector3.New(0, -350, -210)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10096, var_172_6, var_172_5)
			end

			if arg_169_1.time_ >= var_172_1 + var_172_4 and arg_169_1.time_ < var_172_1 + var_172_4 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -350, -210)
			end

			local var_172_7 = arg_169_1.actors_["10096"].transform
			local var_172_8 = 0.7

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				arg_169_1.var_.moveOldPos10096 = var_172_7.localPosition
				var_172_7.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10096", 7)

				local var_172_9 = var_172_7.childCount

				for iter_172_1 = 0, var_172_9 - 1 do
					local var_172_10 = var_172_7:GetChild(iter_172_1)

					if var_172_10.name == "" or not string.find(var_172_10.name, "split") then
						var_172_10.gameObject:SetActive(true)
					else
						var_172_10.gameObject:SetActive(false)
					end
				end
			end

			local var_172_11 = 0.001

			if var_172_8 <= arg_169_1.time_ and arg_169_1.time_ < var_172_8 + var_172_11 then
				local var_172_12 = (arg_169_1.time_ - var_172_8) / var_172_11
				local var_172_13 = Vector3.New(0, -2000, 0)

				var_172_7.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10096, var_172_13, var_172_12)
			end

			if arg_169_1.time_ >= var_172_8 + var_172_11 and arg_169_1.time_ < var_172_8 + var_172_11 + arg_172_0 then
				var_172_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_172_14 = arg_169_1.actors_["10096"]
			local var_172_15 = 0

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 and not isNil(var_172_14) and arg_169_1.var_.actorSpriteComps10096 == nil then
				arg_169_1.var_.actorSpriteComps10096 = var_172_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_16 = 2

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_16 and not isNil(var_172_14) then
				local var_172_17 = (arg_169_1.time_ - var_172_15) / var_172_16

				if arg_169_1.var_.actorSpriteComps10096 then
					for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_172_3 then
							if arg_169_1.isInRecall_ then
								local var_172_18 = Mathf.Lerp(iter_172_3.color.r, arg_169_1.hightColor2.r, var_172_17)
								local var_172_19 = Mathf.Lerp(iter_172_3.color.g, arg_169_1.hightColor2.g, var_172_17)
								local var_172_20 = Mathf.Lerp(iter_172_3.color.b, arg_169_1.hightColor2.b, var_172_17)

								iter_172_3.color = Color.New(var_172_18, var_172_19, var_172_20)
							else
								local var_172_21 = Mathf.Lerp(iter_172_3.color.r, 0.5, var_172_17)

								iter_172_3.color = Color.New(var_172_21, var_172_21, var_172_21)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_15 + var_172_16 and arg_169_1.time_ < var_172_15 + var_172_16 + arg_172_0 and not isNil(var_172_14) and arg_169_1.var_.actorSpriteComps10096 then
				for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_172_5 then
						if arg_169_1.isInRecall_ then
							iter_172_5.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps10096 = nil
			end

			local var_172_22 = arg_169_1.actors_["10096"]
			local var_172_23 = 0

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 then
				local var_172_24 = var_172_22:GetComponentInChildren(typeof(CanvasGroup))

				if var_172_24 then
					arg_169_1.var_.alphaOldValue10096 = var_172_24.alpha
					arg_169_1.var_.characterEffect10096 = var_172_24
				end

				arg_169_1.var_.alphaOldValue10096 = 1
			end

			local var_172_25 = 0.333333333333333

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_25 then
				local var_172_26 = (arg_169_1.time_ - var_172_23) / var_172_25
				local var_172_27 = Mathf.Lerp(arg_169_1.var_.alphaOldValue10096, 0, var_172_26)

				if arg_169_1.var_.characterEffect10096 then
					arg_169_1.var_.characterEffect10096.alpha = var_172_27
				end
			end

			if arg_169_1.time_ >= var_172_23 + var_172_25 and arg_169_1.time_ < var_172_23 + var_172_25 + arg_172_0 and arg_169_1.var_.characterEffect10096 then
				arg_169_1.var_.characterEffect10096.alpha = 0
			end

			local var_172_28 = manager.ui.mainCamera.transform
			local var_172_29 = 0

			if var_172_29 < arg_169_1.time_ and arg_169_1.time_ <= var_172_29 + arg_172_0 then
				local var_172_30 = arg_169_1.var_.effectxiaosan1
				local var_172_31
				local var_172_32 = var_172_28

				if not var_172_30 then
					var_172_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_172_32)
					var_172_30.name = "xiaosan1"
					arg_169_1.var_.effectxiaosan1 = var_172_30
				else
					var_172_30.transform:SetParent(var_172_32)
				end

				var_172_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_172_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_33 = 0.7
			local var_172_34 = 0.575

			if var_172_33 < arg_169_1.time_ and arg_169_1.time_ <= var_172_33 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_35 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_35:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_36 = arg_169_1:GetWordFromCfg(413112041)
				local var_172_37 = arg_169_1:FormatText(var_172_36.content)

				arg_169_1.text_.text = var_172_37

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_38 = 23
				local var_172_39 = utf8.len(var_172_37)
				local var_172_40 = var_172_38 <= 0 and var_172_34 or var_172_34 * (var_172_39 / var_172_38)

				if var_172_40 > 0 and var_172_34 < var_172_40 then
					arg_169_1.talkMaxDuration = var_172_40
					var_172_33 = var_172_33 + 0.3

					if var_172_40 + var_172_33 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_40 + var_172_33
					end
				end

				arg_169_1.text_.text = var_172_37
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_41 = var_172_33 + 0.3
			local var_172_42 = math.max(var_172_34, arg_169_1.talkMaxDuration)

			if var_172_41 <= arg_169_1.time_ and arg_169_1.time_ < var_172_41 + var_172_42 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_41) / var_172_42

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_41 + var_172_42 and arg_169_1.time_ < var_172_41 + var_172_42 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play413112042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413112042
		arg_175_1.duration_ = 7.27

		local var_175_0 = {
			zh = 5.866,
			ja = 7.266
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
				arg_175_0:Play413112043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = manager.ui.mainCamera.transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				local var_178_2 = arg_175_1.var_.effectxiaosan1

				if var_178_2 then
					Object.Destroy(var_178_2)

					arg_175_1.var_.effectxiaosan1 = nil
				end
			end

			local var_178_3 = 0
			local var_178_4 = 0.3

			if var_178_3 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_5 = arg_175_1:FormatText(StoryNameCfg[36].name)

				arg_175_1.leftNameTxt_.text = var_178_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_6 = arg_175_1:GetWordFromCfg(413112042)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_8 = 12
				local var_178_9 = utf8.len(var_178_7)
				local var_178_10 = var_178_8 <= 0 and var_178_4 or var_178_4 * (var_178_9 / var_178_8)

				if var_178_10 > 0 and var_178_4 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_3
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112042", "story_v_out_413112.awb") ~= 0 then
					local var_178_11 = manager.audio:GetVoiceLength("story_v_out_413112", "413112042", "story_v_out_413112.awb") / 1000

					if var_178_11 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_3
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_413112", "413112042", "story_v_out_413112.awb")

						arg_175_1:RecordAudio("413112042", var_178_12)
						arg_175_1:RecordAudio("413112042", var_178_12)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_413112", "413112042", "story_v_out_413112.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_413112", "413112042", "story_v_out_413112.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_4, arg_175_1.talkMaxDuration)

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_3) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_3 + var_178_13 and arg_175_1.time_ < var_178_3 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play413112043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413112043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play413112044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.825

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(413112043)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 33
				local var_182_5 = utf8.len(var_182_3)
				local var_182_6 = var_182_4 <= 0 and var_182_1 or var_182_1 * (var_182_5 / var_182_4)

				if var_182_6 > 0 and var_182_1 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_7 and arg_179_1.time_ < var_182_0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play413112044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 413112044
		arg_183_1.duration_ = 8.5

		local var_183_0 = {
			zh = 5.166,
			ja = 8.5
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
				arg_183_0:Play413112045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10094"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10094 = var_186_0.localPosition
				var_186_0.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10094", 3)

				local var_186_2 = var_186_0.childCount

				for iter_186_0 = 0, var_186_2 - 1 do
					local var_186_3 = var_186_0:GetChild(iter_186_0)

					if var_186_3.name == "split_2" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_4 then
				local var_186_5 = (arg_183_1.time_ - var_186_1) / var_186_4
				local var_186_6 = Vector3.New(0, -340, -414)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10094, var_186_6, var_186_5)
			end

			if arg_183_1.time_ >= var_186_1 + var_186_4 and arg_183_1.time_ < var_186_1 + var_186_4 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_186_7 = arg_183_1.actors_["10094"]
			local var_186_8 = 0

			if var_186_8 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 and not isNil(var_186_7) and arg_183_1.var_.actorSpriteComps10094 == nil then
				arg_183_1.var_.actorSpriteComps10094 = var_186_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_9 = 2

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_9 and not isNil(var_186_7) then
				local var_186_10 = (arg_183_1.time_ - var_186_8) / var_186_9

				if arg_183_1.var_.actorSpriteComps10094 then
					for iter_186_1, iter_186_2 in pairs(arg_183_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_186_2 then
							if arg_183_1.isInRecall_ then
								local var_186_11 = Mathf.Lerp(iter_186_2.color.r, arg_183_1.hightColor1.r, var_186_10)
								local var_186_12 = Mathf.Lerp(iter_186_2.color.g, arg_183_1.hightColor1.g, var_186_10)
								local var_186_13 = Mathf.Lerp(iter_186_2.color.b, arg_183_1.hightColor1.b, var_186_10)

								iter_186_2.color = Color.New(var_186_11, var_186_12, var_186_13)
							else
								local var_186_14 = Mathf.Lerp(iter_186_2.color.r, 1, var_186_10)

								iter_186_2.color = Color.New(var_186_14, var_186_14, var_186_14)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= var_186_8 + var_186_9 and arg_183_1.time_ < var_186_8 + var_186_9 + arg_186_0 and not isNil(var_186_7) and arg_183_1.var_.actorSpriteComps10094 then
				for iter_186_3, iter_186_4 in pairs(arg_183_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_186_4 then
						if arg_183_1.isInRecall_ then
							iter_186_4.color = arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_186_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_183_1.var_.actorSpriteComps10094 = nil
			end

			local var_186_15 = 0
			local var_186_16 = 0.525

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[259].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(413112044)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 21
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112044", "story_v_out_413112.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112044", "story_v_out_413112.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_413112", "413112044", "story_v_out_413112.awb")

						arg_183_1:RecordAudio("413112044", var_186_24)
						arg_183_1:RecordAudio("413112044", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_413112", "413112044", "story_v_out_413112.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_413112", "413112044", "story_v_out_413112.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play413112045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413112045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play413112046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10094"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos10094 = var_190_0.localPosition
				var_190_0.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("10094", 7)

				local var_190_2 = var_190_0.childCount

				for iter_190_0 = 0, var_190_2 - 1 do
					local var_190_3 = var_190_0:GetChild(iter_190_0)

					if var_190_3.name == "" or not string.find(var_190_3.name, "split") then
						var_190_3.gameObject:SetActive(true)
					else
						var_190_3.gameObject:SetActive(false)
					end
				end
			end

			local var_190_4 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_4 then
				local var_190_5 = (arg_187_1.time_ - var_190_1) / var_190_4
				local var_190_6 = Vector3.New(0, -2000, 0)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10094, var_190_6, var_190_5)
			end

			if arg_187_1.time_ >= var_190_1 + var_190_4 and arg_187_1.time_ < var_190_1 + var_190_4 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_190_7 = arg_187_1.actors_["10094"]
			local var_190_8 = 0

			if var_190_8 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps10094 == nil then
				arg_187_1.var_.actorSpriteComps10094 = var_190_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_9 = 2

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_9 and not isNil(var_190_7) then
				local var_190_10 = (arg_187_1.time_ - var_190_8) / var_190_9

				if arg_187_1.var_.actorSpriteComps10094 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								local var_190_11 = Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor2.r, var_190_10)
								local var_190_12 = Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor2.g, var_190_10)
								local var_190_13 = Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor2.b, var_190_10)

								iter_190_2.color = Color.New(var_190_11, var_190_12, var_190_13)
							else
								local var_190_14 = Mathf.Lerp(iter_190_2.color.r, 0.5, var_190_10)

								iter_190_2.color = Color.New(var_190_14, var_190_14, var_190_14)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= var_190_8 + var_190_9 and arg_187_1.time_ < var_190_8 + var_190_9 + arg_190_0 and not isNil(var_190_7) and arg_187_1.var_.actorSpriteComps10094 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_190_4 then
						if arg_187_1.isInRecall_ then
							iter_190_4.color = arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_190_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_187_1.var_.actorSpriteComps10094 = nil
			end

			local var_190_15 = 0
			local var_190_16 = 0.95

			if var_190_15 < arg_187_1.time_ and arg_187_1.time_ <= var_190_15 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_17 = arg_187_1:GetWordFromCfg(413112045)
				local var_190_18 = arg_187_1:FormatText(var_190_17.content)

				arg_187_1.text_.text = var_190_18

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_19 = 38
				local var_190_20 = utf8.len(var_190_18)
				local var_190_21 = var_190_19 <= 0 and var_190_16 or var_190_16 * (var_190_20 / var_190_19)

				if var_190_21 > 0 and var_190_16 < var_190_21 then
					arg_187_1.talkMaxDuration = var_190_21

					if var_190_21 + var_190_15 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_21 + var_190_15
					end
				end

				arg_187_1.text_.text = var_190_18
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_16, arg_187_1.talkMaxDuration)

			if var_190_15 <= arg_187_1.time_ and arg_187_1.time_ < var_190_15 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_15) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_15 + var_190_22 and arg_187_1.time_ < var_190_15 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play413112046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 413112046
		arg_191_1.duration_ = 6.4

		local var_191_0 = {
			zh = 2.3,
			ja = 6.4
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
				arg_191_0:Play413112047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10094"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10094 = var_194_0.localPosition
				var_194_0.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10094", 3)

				local var_194_2 = var_194_0.childCount

				for iter_194_0 = 0, var_194_2 - 1 do
					local var_194_3 = var_194_0:GetChild(iter_194_0)

					if var_194_3.name == "split_2" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_4 then
				local var_194_5 = (arg_191_1.time_ - var_194_1) / var_194_4
				local var_194_6 = Vector3.New(0, -340, -414)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10094, var_194_6, var_194_5)
			end

			if arg_191_1.time_ >= var_194_1 + var_194_4 and arg_191_1.time_ < var_194_1 + var_194_4 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_194_7 = arg_191_1.actors_["10094"]
			local var_194_8 = 0

			if var_194_8 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 and not isNil(var_194_7) and arg_191_1.var_.actorSpriteComps10094 == nil then
				arg_191_1.var_.actorSpriteComps10094 = var_194_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_9 = 2

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_9 and not isNil(var_194_7) then
				local var_194_10 = (arg_191_1.time_ - var_194_8) / var_194_9

				if arg_191_1.var_.actorSpriteComps10094 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								local var_194_11 = Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor1.r, var_194_10)
								local var_194_12 = Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor1.g, var_194_10)
								local var_194_13 = Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor1.b, var_194_10)

								iter_194_2.color = Color.New(var_194_11, var_194_12, var_194_13)
							else
								local var_194_14 = Mathf.Lerp(iter_194_2.color.r, 1, var_194_10)

								iter_194_2.color = Color.New(var_194_14, var_194_14, var_194_14)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= var_194_8 + var_194_9 and arg_191_1.time_ < var_194_8 + var_194_9 + arg_194_0 and not isNil(var_194_7) and arg_191_1.var_.actorSpriteComps10094 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_194_4 then
						if arg_191_1.isInRecall_ then
							iter_194_4.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_194_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_191_1.var_.actorSpriteComps10094 = nil
			end

			local var_194_15 = 0
			local var_194_16 = 0.3

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[259].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(413112046)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 12
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112046", "story_v_out_413112.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112046", "story_v_out_413112.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_out_413112", "413112046", "story_v_out_413112.awb")

						arg_191_1:RecordAudio("413112046", var_194_24)
						arg_191_1:RecordAudio("413112046", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_413112", "413112046", "story_v_out_413112.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_413112", "413112046", "story_v_out_413112.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
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
	Play413112047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 413112047
		arg_195_1.duration_ = 8.3

		local var_195_0 = {
			zh = 6.566,
			ja = 8.3
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
				arg_195_0:Play413112048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 2

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				local var_198_1 = manager.ui.mainCamera.transform.localPosition
				local var_198_2 = Vector3.New(0, 0, 10) + Vector3.New(var_198_1.x, var_198_1.y, 0)
				local var_198_3 = arg_195_1.bgs_.F10g

				var_198_3.transform.localPosition = var_198_2
				var_198_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_4 = var_198_3:GetComponent("SpriteRenderer")

				if var_198_4 and var_198_4.sprite then
					local var_198_5 = (var_198_3.transform.localPosition - var_198_1).z
					local var_198_6 = manager.ui.mainCameraCom_
					local var_198_7 = 2 * var_198_5 * Mathf.Tan(var_198_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_198_8 = var_198_7 * var_198_6.aspect
					local var_198_9 = var_198_4.sprite.bounds.size.x
					local var_198_10 = var_198_4.sprite.bounds.size.y
					local var_198_11 = var_198_8 / var_198_9
					local var_198_12 = var_198_7 / var_198_10
					local var_198_13 = var_198_12 < var_198_11 and var_198_11 or var_198_12

					var_198_3.transform.localScale = Vector3.New(var_198_13, var_198_13, 0)
				end

				for iter_198_0, iter_198_1 in pairs(arg_195_1.bgs_) do
					if iter_198_0 ~= "F10g" then
						iter_198_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_15 = 2

			if var_198_14 <= arg_195_1.time_ and arg_195_1.time_ < var_198_14 + var_198_15 then
				local var_198_16 = (arg_195_1.time_ - var_198_14) / var_198_15
				local var_198_17 = Color.New(0, 0, 0)

				var_198_17.a = Mathf.Lerp(0, 1, var_198_16)
				arg_195_1.mask_.color = var_198_17
			end

			if arg_195_1.time_ >= var_198_14 + var_198_15 and arg_195_1.time_ < var_198_14 + var_198_15 + arg_198_0 then
				local var_198_18 = Color.New(0, 0, 0)

				var_198_18.a = 1
				arg_195_1.mask_.color = var_198_18
			end

			local var_198_19 = 2

			if var_198_19 < arg_195_1.time_ and arg_195_1.time_ <= var_198_19 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_20 = 2

			if var_198_19 <= arg_195_1.time_ and arg_195_1.time_ < var_198_19 + var_198_20 then
				local var_198_21 = (arg_195_1.time_ - var_198_19) / var_198_20
				local var_198_22 = Color.New(0, 0, 0)

				var_198_22.a = Mathf.Lerp(1, 0, var_198_21)
				arg_195_1.mask_.color = var_198_22
			end

			if arg_195_1.time_ >= var_198_19 + var_198_20 and arg_195_1.time_ < var_198_19 + var_198_20 + arg_198_0 then
				local var_198_23 = Color.New(0, 0, 0)
				local var_198_24 = 0

				arg_195_1.mask_.enabled = false
				var_198_23.a = var_198_24
				arg_195_1.mask_.color = var_198_23
			end

			local var_198_25 = arg_195_1.actors_["10094"].transform
			local var_198_26 = 3.7

			if var_198_26 < arg_195_1.time_ and arg_195_1.time_ <= var_198_26 + arg_198_0 then
				arg_195_1.var_.moveOldPos10094 = var_198_25.localPosition
				var_198_25.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10094", 3)

				local var_198_27 = var_198_25.childCount

				for iter_198_2 = 0, var_198_27 - 1 do
					local var_198_28 = var_198_25:GetChild(iter_198_2)

					if var_198_28.name == "" or not string.find(var_198_28.name, "split") then
						var_198_28.gameObject:SetActive(true)
					else
						var_198_28.gameObject:SetActive(false)
					end
				end
			end

			local var_198_29 = 0.001

			if var_198_26 <= arg_195_1.time_ and arg_195_1.time_ < var_198_26 + var_198_29 then
				local var_198_30 = (arg_195_1.time_ - var_198_26) / var_198_29
				local var_198_31 = Vector3.New(0, -340, -414)

				var_198_25.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10094, var_198_31, var_198_30)
			end

			if arg_195_1.time_ >= var_198_26 + var_198_29 and arg_195_1.time_ < var_198_26 + var_198_29 + arg_198_0 then
				var_198_25.localPosition = Vector3.New(0, -340, -414)
			end

			local var_198_32 = arg_195_1.actors_["10094"]
			local var_198_33 = 3.7

			if var_198_33 < arg_195_1.time_ and arg_195_1.time_ <= var_198_33 + arg_198_0 and not isNil(var_198_32) and arg_195_1.var_.actorSpriteComps10094 == nil then
				arg_195_1.var_.actorSpriteComps10094 = var_198_32:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_34 = 2

			if var_198_33 <= arg_195_1.time_ and arg_195_1.time_ < var_198_33 + var_198_34 and not isNil(var_198_32) then
				local var_198_35 = (arg_195_1.time_ - var_198_33) / var_198_34

				if arg_195_1.var_.actorSpriteComps10094 then
					for iter_198_3, iter_198_4 in pairs(arg_195_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_198_4 then
							if arg_195_1.isInRecall_ then
								local var_198_36 = Mathf.Lerp(iter_198_4.color.r, arg_195_1.hightColor1.r, var_198_35)
								local var_198_37 = Mathf.Lerp(iter_198_4.color.g, arg_195_1.hightColor1.g, var_198_35)
								local var_198_38 = Mathf.Lerp(iter_198_4.color.b, arg_195_1.hightColor1.b, var_198_35)

								iter_198_4.color = Color.New(var_198_36, var_198_37, var_198_38)
							else
								local var_198_39 = Mathf.Lerp(iter_198_4.color.r, 1, var_198_35)

								iter_198_4.color = Color.New(var_198_39, var_198_39, var_198_39)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= var_198_33 + var_198_34 and arg_195_1.time_ < var_198_33 + var_198_34 + arg_198_0 and not isNil(var_198_32) and arg_195_1.var_.actorSpriteComps10094 then
				for iter_198_5, iter_198_6 in pairs(arg_195_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_198_6 then
						if arg_195_1.isInRecall_ then
							iter_198_6.color = arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_198_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_195_1.var_.actorSpriteComps10094 = nil
			end

			local var_198_40 = arg_195_1.actors_["10094"].transform
			local var_198_41 = 2

			if var_198_41 < arg_195_1.time_ and arg_195_1.time_ <= var_198_41 + arg_198_0 then
				arg_195_1.var_.moveOldPos10094 = var_198_40.localPosition
				var_198_40.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10094", 7)

				local var_198_42 = var_198_40.childCount

				for iter_198_7 = 0, var_198_42 - 1 do
					local var_198_43 = var_198_40:GetChild(iter_198_7)

					if var_198_43.name == "" or not string.find(var_198_43.name, "split") then
						var_198_43.gameObject:SetActive(true)
					else
						var_198_43.gameObject:SetActive(false)
					end
				end
			end

			local var_198_44 = 0.001

			if var_198_41 <= arg_195_1.time_ and arg_195_1.time_ < var_198_41 + var_198_44 then
				local var_198_45 = (arg_195_1.time_ - var_198_41) / var_198_44
				local var_198_46 = Vector3.New(0, -2000, 0)

				var_198_40.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10094, var_198_46, var_198_45)
			end

			if arg_195_1.time_ >= var_198_41 + var_198_44 and arg_195_1.time_ < var_198_41 + var_198_44 + arg_198_0 then
				var_198_40.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_47 = arg_195_1.actors_["10094"]
			local var_198_48 = 3.7

			if var_198_48 < arg_195_1.time_ and arg_195_1.time_ <= var_198_48 + arg_198_0 then
				local var_198_49 = var_198_47:GetComponentInChildren(typeof(CanvasGroup))

				if var_198_49 then
					arg_195_1.var_.alphaOldValue10094 = var_198_49.alpha
					arg_195_1.var_.characterEffect10094 = var_198_49
				end

				arg_195_1.var_.alphaOldValue10094 = 0
			end

			local var_198_50 = 0.2

			if var_198_48 <= arg_195_1.time_ and arg_195_1.time_ < var_198_48 + var_198_50 then
				local var_198_51 = (arg_195_1.time_ - var_198_48) / var_198_50
				local var_198_52 = Mathf.Lerp(arg_195_1.var_.alphaOldValue10094, 1, var_198_51)

				if arg_195_1.var_.characterEffect10094 then
					arg_195_1.var_.characterEffect10094.alpha = var_198_52
				end
			end

			if arg_195_1.time_ >= var_198_48 + var_198_50 and arg_195_1.time_ < var_198_48 + var_198_50 + arg_198_0 and arg_195_1.var_.characterEffect10094 then
				arg_195_1.var_.characterEffect10094.alpha = 1
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_53 = 4
			local var_198_54 = 0.35

			if var_198_53 < arg_195_1.time_ and arg_195_1.time_ <= var_198_53 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_55 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_55:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_56 = arg_195_1:FormatText(StoryNameCfg[259].name)

				arg_195_1.leftNameTxt_.text = var_198_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_57 = arg_195_1:GetWordFromCfg(413112047)
				local var_198_58 = arg_195_1:FormatText(var_198_57.content)

				arg_195_1.text_.text = var_198_58

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_59 = 14
				local var_198_60 = utf8.len(var_198_58)
				local var_198_61 = var_198_59 <= 0 and var_198_54 or var_198_54 * (var_198_60 / var_198_59)

				if var_198_61 > 0 and var_198_54 < var_198_61 then
					arg_195_1.talkMaxDuration = var_198_61
					var_198_53 = var_198_53 + 0.3

					if var_198_61 + var_198_53 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_61 + var_198_53
					end
				end

				arg_195_1.text_.text = var_198_58
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112047", "story_v_out_413112.awb") ~= 0 then
					local var_198_62 = manager.audio:GetVoiceLength("story_v_out_413112", "413112047", "story_v_out_413112.awb") / 1000

					if var_198_62 + var_198_53 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_62 + var_198_53
					end

					if var_198_57.prefab_name ~= "" and arg_195_1.actors_[var_198_57.prefab_name] ~= nil then
						local var_198_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_57.prefab_name].transform, "story_v_out_413112", "413112047", "story_v_out_413112.awb")

						arg_195_1:RecordAudio("413112047", var_198_63)
						arg_195_1:RecordAudio("413112047", var_198_63)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_413112", "413112047", "story_v_out_413112.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_413112", "413112047", "story_v_out_413112.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_64 = var_198_53 + 0.3
			local var_198_65 = math.max(var_198_54, arg_195_1.talkMaxDuration)

			if var_198_64 <= arg_195_1.time_ and arg_195_1.time_ < var_198_64 + var_198_65 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_64) / var_198_65

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_64 + var_198_65 and arg_195_1.time_ < var_198_64 + var_198_65 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play413112048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413112048
		arg_201_1.duration_ = 7.3

		local var_201_0 = {
			zh = 2.933,
			ja = 7.3
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
				arg_201_0:Play413112049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10094"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos10094 = var_204_0.localPosition
				var_204_0.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10094", 2)

				local var_204_2 = var_204_0.childCount

				for iter_204_0 = 0, var_204_2 - 1 do
					local var_204_3 = var_204_0:GetChild(iter_204_0)

					if var_204_3.name == "" or not string.find(var_204_3.name, "split") then
						var_204_3.gameObject:SetActive(true)
					else
						var_204_3.gameObject:SetActive(false)
					end
				end
			end

			local var_204_4 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_4 then
				local var_204_5 = (arg_201_1.time_ - var_204_1) / var_204_4
				local var_204_6 = Vector3.New(-390, -340, -414)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10094, var_204_6, var_204_5)
			end

			if arg_201_1.time_ >= var_204_1 + var_204_4 and arg_201_1.time_ < var_204_1 + var_204_4 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_204_7 = arg_201_1.actors_["10022"].transform
			local var_204_8 = 0

			if var_204_8 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.var_.moveOldPos10022 = var_204_7.localPosition
				var_204_7.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10022", 4)

				local var_204_9 = var_204_7.childCount

				for iter_204_1 = 0, var_204_9 - 1 do
					local var_204_10 = var_204_7:GetChild(iter_204_1)

					if var_204_10.name == "" or not string.find(var_204_10.name, "split") then
						var_204_10.gameObject:SetActive(true)
					else
						var_204_10.gameObject:SetActive(false)
					end
				end
			end

			local var_204_11 = 0.001

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_11 then
				local var_204_12 = (arg_201_1.time_ - var_204_8) / var_204_11
				local var_204_13 = Vector3.New(390, -315, -320)

				var_204_7.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10022, var_204_13, var_204_12)
			end

			if arg_201_1.time_ >= var_204_8 + var_204_11 and arg_201_1.time_ < var_204_8 + var_204_11 + arg_204_0 then
				var_204_7.localPosition = Vector3.New(390, -315, -320)
			end

			local var_204_14 = arg_201_1.actors_["10094"]
			local var_204_15 = 0

			if var_204_15 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 and not isNil(var_204_14) and arg_201_1.var_.actorSpriteComps10094 == nil then
				arg_201_1.var_.actorSpriteComps10094 = var_204_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_16 = 2

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_16 and not isNil(var_204_14) then
				local var_204_17 = (arg_201_1.time_ - var_204_15) / var_204_16

				if arg_201_1.var_.actorSpriteComps10094 then
					for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_204_3 then
							if arg_201_1.isInRecall_ then
								local var_204_18 = Mathf.Lerp(iter_204_3.color.r, arg_201_1.hightColor2.r, var_204_17)
								local var_204_19 = Mathf.Lerp(iter_204_3.color.g, arg_201_1.hightColor2.g, var_204_17)
								local var_204_20 = Mathf.Lerp(iter_204_3.color.b, arg_201_1.hightColor2.b, var_204_17)

								iter_204_3.color = Color.New(var_204_18, var_204_19, var_204_20)
							else
								local var_204_21 = Mathf.Lerp(iter_204_3.color.r, 0.5, var_204_17)

								iter_204_3.color = Color.New(var_204_21, var_204_21, var_204_21)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_15 + var_204_16 and arg_201_1.time_ < var_204_15 + var_204_16 + arg_204_0 and not isNil(var_204_14) and arg_201_1.var_.actorSpriteComps10094 then
				for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_204_5 then
						if arg_201_1.isInRecall_ then
							iter_204_5.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10094 = nil
			end

			local var_204_22 = arg_201_1.actors_["10022"]
			local var_204_23 = 0

			if var_204_23 < arg_201_1.time_ and arg_201_1.time_ <= var_204_23 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.actorSpriteComps10022 == nil then
				arg_201_1.var_.actorSpriteComps10022 = var_204_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_24 = 2

			if var_204_23 <= arg_201_1.time_ and arg_201_1.time_ < var_204_23 + var_204_24 and not isNil(var_204_22) then
				local var_204_25 = (arg_201_1.time_ - var_204_23) / var_204_24

				if arg_201_1.var_.actorSpriteComps10022 then
					for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_204_7 then
							if arg_201_1.isInRecall_ then
								local var_204_26 = Mathf.Lerp(iter_204_7.color.r, arg_201_1.hightColor1.r, var_204_25)
								local var_204_27 = Mathf.Lerp(iter_204_7.color.g, arg_201_1.hightColor1.g, var_204_25)
								local var_204_28 = Mathf.Lerp(iter_204_7.color.b, arg_201_1.hightColor1.b, var_204_25)

								iter_204_7.color = Color.New(var_204_26, var_204_27, var_204_28)
							else
								local var_204_29 = Mathf.Lerp(iter_204_7.color.r, 1, var_204_25)

								iter_204_7.color = Color.New(var_204_29, var_204_29, var_204_29)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_23 + var_204_24 and arg_201_1.time_ < var_204_23 + var_204_24 + arg_204_0 and not isNil(var_204_22) and arg_201_1.var_.actorSpriteComps10022 then
				for iter_204_8, iter_204_9 in pairs(arg_201_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_204_9 then
						if arg_201_1.isInRecall_ then
							iter_204_9.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10022 = nil
			end

			local var_204_30 = 0
			local var_204_31 = 0.425

			if var_204_30 < arg_201_1.time_ and arg_201_1.time_ <= var_204_30 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_32 = arg_201_1:FormatText(StoryNameCfg[614].name)

				arg_201_1.leftNameTxt_.text = var_204_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_33 = arg_201_1:GetWordFromCfg(413112048)
				local var_204_34 = arg_201_1:FormatText(var_204_33.content)

				arg_201_1.text_.text = var_204_34

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_35 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112048", "story_v_out_413112.awb") ~= 0 then
					local var_204_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112048", "story_v_out_413112.awb") / 1000

					if var_204_38 + var_204_30 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_38 + var_204_30
					end

					if var_204_33.prefab_name ~= "" and arg_201_1.actors_[var_204_33.prefab_name] ~= nil then
						local var_204_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_33.prefab_name].transform, "story_v_out_413112", "413112048", "story_v_out_413112.awb")

						arg_201_1:RecordAudio("413112048", var_204_39)
						arg_201_1:RecordAudio("413112048", var_204_39)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413112", "413112048", "story_v_out_413112.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413112", "413112048", "story_v_out_413112.awb")
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
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_201_1:InitPlayNodeList()
	end,
	Play413112049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413112049
		arg_205_1.duration_ = 7.97

		local var_205_0 = {
			zh = 5.733,
			ja = 7.966
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
				arg_205_0:Play413112050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10022"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10022 = var_208_0.localPosition
				var_208_0.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10022", 4)

				local var_208_2 = var_208_0.childCount

				for iter_208_0 = 0, var_208_2 - 1 do
					local var_208_3 = var_208_0:GetChild(iter_208_0)

					if var_208_3.name == "split_3" or not string.find(var_208_3.name, "split") then
						var_208_3.gameObject:SetActive(true)
					else
						var_208_3.gameObject:SetActive(false)
					end
				end
			end

			local var_208_4 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_4 then
				local var_208_5 = (arg_205_1.time_ - var_208_1) / var_208_4
				local var_208_6 = Vector3.New(390, -315, -320)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10022, var_208_6, var_208_5)
			end

			if arg_205_1.time_ >= var_208_1 + var_208_4 and arg_205_1.time_ < var_208_1 + var_208_4 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(390, -315, -320)
			end

			local var_208_7 = arg_205_1.actors_["10022"]
			local var_208_8 = 0

			if var_208_8 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10022 == nil then
				arg_205_1.var_.actorSpriteComps10022 = var_208_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_9 = 2

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 and not isNil(var_208_7) then
				local var_208_10 = (arg_205_1.time_ - var_208_8) / var_208_9

				if arg_205_1.var_.actorSpriteComps10022 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								local var_208_11 = Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, var_208_10)
								local var_208_12 = Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, var_208_10)
								local var_208_13 = Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, var_208_10)

								iter_208_2.color = Color.New(var_208_11, var_208_12, var_208_13)
							else
								local var_208_14 = Mathf.Lerp(iter_208_2.color.r, 1, var_208_10)

								iter_208_2.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 and not isNil(var_208_7) and arg_205_1.var_.actorSpriteComps10022 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_208_4 then
						if arg_205_1.isInRecall_ then
							iter_208_4.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10022 = nil
			end

			local var_208_15 = 0
			local var_208_16 = 0.6

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_17 = arg_205_1:FormatText(StoryNameCfg[614].name)

				arg_205_1.leftNameTxt_.text = var_208_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_18 = arg_205_1:GetWordFromCfg(413112049)
				local var_208_19 = arg_205_1:FormatText(var_208_18.content)

				arg_205_1.text_.text = var_208_19

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_20 = 24
				local var_208_21 = utf8.len(var_208_19)
				local var_208_22 = var_208_20 <= 0 and var_208_16 or var_208_16 * (var_208_21 / var_208_20)

				if var_208_22 > 0 and var_208_16 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22

					if var_208_22 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_15
					end
				end

				arg_205_1.text_.text = var_208_19
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112049", "story_v_out_413112.awb") ~= 0 then
					local var_208_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112049", "story_v_out_413112.awb") / 1000

					if var_208_23 + var_208_15 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_15
					end

					if var_208_18.prefab_name ~= "" and arg_205_1.actors_[var_208_18.prefab_name] ~= nil then
						local var_208_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_18.prefab_name].transform, "story_v_out_413112", "413112049", "story_v_out_413112.awb")

						arg_205_1:RecordAudio("413112049", var_208_24)
						arg_205_1:RecordAudio("413112049", var_208_24)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413112", "413112049", "story_v_out_413112.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413112", "413112049", "story_v_out_413112.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_25 = math.max(var_208_16, arg_205_1.talkMaxDuration)

			if var_208_15 <= arg_205_1.time_ and arg_205_1.time_ < var_208_15 + var_208_25 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_15) / var_208_25

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_15 + var_208_25 and arg_205_1.time_ < var_208_15 + var_208_25 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play413112050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413112050
		arg_209_1.duration_ = 7

		local var_209_0 = {
			zh = 4.9,
			ja = 7
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
				arg_209_0:Play413112051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10022"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10022 = var_212_0.localPosition
				var_212_0.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10022", 6)

				local var_212_2 = var_212_0.childCount

				for iter_212_0 = 0, var_212_2 - 1 do
					local var_212_3 = var_212_0:GetChild(iter_212_0)

					if var_212_3.name == "" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_4 then
				local var_212_5 = (arg_209_1.time_ - var_212_1) / var_212_4
				local var_212_6 = Vector3.New(1500, -315, -320)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10022, var_212_6, var_212_5)
			end

			if arg_209_1.time_ >= var_212_1 + var_212_4 and arg_209_1.time_ < var_212_1 + var_212_4 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_212_7 = arg_209_1.actors_["10092_1"].transform
			local var_212_8 = 0

			if var_212_8 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.var_.moveOldPos10092_1 = var_212_7.localPosition
				var_212_7.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10092_1", 3)

				local var_212_9 = var_212_7.childCount

				for iter_212_1 = 0, var_212_9 - 1 do
					local var_212_10 = var_212_7:GetChild(iter_212_1)

					if var_212_10.name == "split_2" or not string.find(var_212_10.name, "split") then
						var_212_10.gameObject:SetActive(true)
					else
						var_212_10.gameObject:SetActive(false)
					end
				end
			end

			local var_212_11 = 0.001

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_11 then
				local var_212_12 = (arg_209_1.time_ - var_212_8) / var_212_11
				local var_212_13 = Vector3.New(0, -300, -295)

				var_212_7.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10092_1, var_212_13, var_212_12)
			end

			if arg_209_1.time_ >= var_212_8 + var_212_11 and arg_209_1.time_ < var_212_8 + var_212_11 + arg_212_0 then
				var_212_7.localPosition = Vector3.New(0, -300, -295)
			end

			local var_212_14 = arg_209_1.actors_["10022"]
			local var_212_15 = 0

			if var_212_15 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 and not isNil(var_212_14) and arg_209_1.var_.actorSpriteComps10022 == nil then
				arg_209_1.var_.actorSpriteComps10022 = var_212_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_16 = 2

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_16 and not isNil(var_212_14) then
				local var_212_17 = (arg_209_1.time_ - var_212_15) / var_212_16

				if arg_209_1.var_.actorSpriteComps10022 then
					for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_212_3 then
							if arg_209_1.isInRecall_ then
								local var_212_18 = Mathf.Lerp(iter_212_3.color.r, arg_209_1.hightColor2.r, var_212_17)
								local var_212_19 = Mathf.Lerp(iter_212_3.color.g, arg_209_1.hightColor2.g, var_212_17)
								local var_212_20 = Mathf.Lerp(iter_212_3.color.b, arg_209_1.hightColor2.b, var_212_17)

								iter_212_3.color = Color.New(var_212_18, var_212_19, var_212_20)
							else
								local var_212_21 = Mathf.Lerp(iter_212_3.color.r, 0.5, var_212_17)

								iter_212_3.color = Color.New(var_212_21, var_212_21, var_212_21)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_15 + var_212_16 and arg_209_1.time_ < var_212_15 + var_212_16 + arg_212_0 and not isNil(var_212_14) and arg_209_1.var_.actorSpriteComps10022 then
				for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_212_5 then
						if arg_209_1.isInRecall_ then
							iter_212_5.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10022 = nil
			end

			local var_212_22 = arg_209_1.actors_["10092_1"]
			local var_212_23 = 0

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 and not isNil(var_212_22) and arg_209_1.var_.actorSpriteComps10092_1 == nil then
				arg_209_1.var_.actorSpriteComps10092_1 = var_212_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_24 = 2

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_24 and not isNil(var_212_22) then
				local var_212_25 = (arg_209_1.time_ - var_212_23) / var_212_24

				if arg_209_1.var_.actorSpriteComps10092_1 then
					for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_212_7 then
							if arg_209_1.isInRecall_ then
								local var_212_26 = Mathf.Lerp(iter_212_7.color.r, arg_209_1.hightColor1.r, var_212_25)
								local var_212_27 = Mathf.Lerp(iter_212_7.color.g, arg_209_1.hightColor1.g, var_212_25)
								local var_212_28 = Mathf.Lerp(iter_212_7.color.b, arg_209_1.hightColor1.b, var_212_25)

								iter_212_7.color = Color.New(var_212_26, var_212_27, var_212_28)
							else
								local var_212_29 = Mathf.Lerp(iter_212_7.color.r, 1, var_212_25)

								iter_212_7.color = Color.New(var_212_29, var_212_29, var_212_29)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_23 + var_212_24 and arg_209_1.time_ < var_212_23 + var_212_24 + arg_212_0 and not isNil(var_212_22) and arg_209_1.var_.actorSpriteComps10092_1 then
				for iter_212_8, iter_212_9 in pairs(arg_209_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_212_9 then
						if arg_209_1.isInRecall_ then
							iter_212_9.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_212_30 = arg_209_1.actors_["10094"].transform
			local var_212_31 = 0

			if var_212_31 < arg_209_1.time_ and arg_209_1.time_ <= var_212_31 + arg_212_0 then
				arg_209_1.var_.moveOldPos10094 = var_212_30.localPosition
				var_212_30.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10094", 7)

				local var_212_32 = var_212_30.childCount

				for iter_212_10 = 0, var_212_32 - 1 do
					local var_212_33 = var_212_30:GetChild(iter_212_10)

					if var_212_33.name == "" or not string.find(var_212_33.name, "split") then
						var_212_33.gameObject:SetActive(true)
					else
						var_212_33.gameObject:SetActive(false)
					end
				end
			end

			local var_212_34 = 0.001

			if var_212_31 <= arg_209_1.time_ and arg_209_1.time_ < var_212_31 + var_212_34 then
				local var_212_35 = (arg_209_1.time_ - var_212_31) / var_212_34
				local var_212_36 = Vector3.New(0, -2000, 0)

				var_212_30.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10094, var_212_36, var_212_35)
			end

			if arg_209_1.time_ >= var_212_31 + var_212_34 and arg_209_1.time_ < var_212_31 + var_212_34 + arg_212_0 then
				var_212_30.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_212_37 = 0
			local var_212_38 = 0.65

			if var_212_37 < arg_209_1.time_ and arg_209_1.time_ <= var_212_37 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_39 = arg_209_1:FormatText(StoryNameCfg[996].name)

				arg_209_1.leftNameTxt_.text = var_212_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_40 = arg_209_1:GetWordFromCfg(413112050)
				local var_212_41 = arg_209_1:FormatText(var_212_40.content)

				arg_209_1.text_.text = var_212_41

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_42 = 26
				local var_212_43 = utf8.len(var_212_41)
				local var_212_44 = var_212_42 <= 0 and var_212_38 or var_212_38 * (var_212_43 / var_212_42)

				if var_212_44 > 0 and var_212_38 < var_212_44 then
					arg_209_1.talkMaxDuration = var_212_44

					if var_212_44 + var_212_37 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_44 + var_212_37
					end
				end

				arg_209_1.text_.text = var_212_41
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112050", "story_v_out_413112.awb") ~= 0 then
					local var_212_45 = manager.audio:GetVoiceLength("story_v_out_413112", "413112050", "story_v_out_413112.awb") / 1000

					if var_212_45 + var_212_37 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_45 + var_212_37
					end

					if var_212_40.prefab_name ~= "" and arg_209_1.actors_[var_212_40.prefab_name] ~= nil then
						local var_212_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_40.prefab_name].transform, "story_v_out_413112", "413112050", "story_v_out_413112.awb")

						arg_209_1:RecordAudio("413112050", var_212_46)
						arg_209_1:RecordAudio("413112050", var_212_46)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413112", "413112050", "story_v_out_413112.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413112", "413112050", "story_v_out_413112.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_47 = math.max(var_212_38, arg_209_1.talkMaxDuration)

			if var_212_37 <= arg_209_1.time_ and arg_209_1.time_ < var_212_37 + var_212_47 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_37) / var_212_47

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_37 + var_212_47 and arg_209_1.time_ < var_212_37 + var_212_47 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413112051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413112051
		arg_213_1.duration_ = 3.97

		local var_213_0 = {
			zh = 3.966,
			ja = 3.133
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
				arg_213_0:Play413112052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10092_1"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10092_1 = var_216_0.localPosition
				var_216_0.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10092_1", 3)

				local var_216_2 = var_216_0.childCount

				for iter_216_0 = 0, var_216_2 - 1 do
					local var_216_3 = var_216_0:GetChild(iter_216_0)

					if var_216_3.name == "split_1_1" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_4 then
				local var_216_5 = (arg_213_1.time_ - var_216_1) / var_216_4
				local var_216_6 = Vector3.New(0, -300, -295)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10092_1, var_216_6, var_216_5)
			end

			if arg_213_1.time_ >= var_216_1 + var_216_4 and arg_213_1.time_ < var_216_1 + var_216_4 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_216_7 = arg_213_1.actors_["10092_1"]
			local var_216_8 = 0

			if var_216_8 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps10092_1 == nil then
				arg_213_1.var_.actorSpriteComps10092_1 = var_216_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_9 = 2

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_9 and not isNil(var_216_7) then
				local var_216_10 = (arg_213_1.time_ - var_216_8) / var_216_9

				if arg_213_1.var_.actorSpriteComps10092_1 then
					for iter_216_1, iter_216_2 in pairs(arg_213_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_216_2 then
							if arg_213_1.isInRecall_ then
								local var_216_11 = Mathf.Lerp(iter_216_2.color.r, arg_213_1.hightColor1.r, var_216_10)
								local var_216_12 = Mathf.Lerp(iter_216_2.color.g, arg_213_1.hightColor1.g, var_216_10)
								local var_216_13 = Mathf.Lerp(iter_216_2.color.b, arg_213_1.hightColor1.b, var_216_10)

								iter_216_2.color = Color.New(var_216_11, var_216_12, var_216_13)
							else
								local var_216_14 = Mathf.Lerp(iter_216_2.color.r, 1, var_216_10)

								iter_216_2.color = Color.New(var_216_14, var_216_14, var_216_14)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_8 + var_216_9 and arg_213_1.time_ < var_216_8 + var_216_9 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.actorSpriteComps10092_1 then
				for iter_216_3, iter_216_4 in pairs(arg_213_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_216_4 then
						if arg_213_1.isInRecall_ then
							iter_216_4.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_216_15 = 0
			local var_216_16 = 0.525

			if var_216_15 < arg_213_1.time_ and arg_213_1.time_ <= var_216_15 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_17 = arg_213_1:FormatText(StoryNameCfg[996].name)

				arg_213_1.leftNameTxt_.text = var_216_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_18 = arg_213_1:GetWordFromCfg(413112051)
				local var_216_19 = arg_213_1:FormatText(var_216_18.content)

				arg_213_1.text_.text = var_216_19

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_20 = 21
				local var_216_21 = utf8.len(var_216_19)
				local var_216_22 = var_216_20 <= 0 and var_216_16 or var_216_16 * (var_216_21 / var_216_20)

				if var_216_22 > 0 and var_216_16 < var_216_22 then
					arg_213_1.talkMaxDuration = var_216_22

					if var_216_22 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_22 + var_216_15
					end
				end

				arg_213_1.text_.text = var_216_19
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112051", "story_v_out_413112.awb") ~= 0 then
					local var_216_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112051", "story_v_out_413112.awb") / 1000

					if var_216_23 + var_216_15 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_15
					end

					if var_216_18.prefab_name ~= "" and arg_213_1.actors_[var_216_18.prefab_name] ~= nil then
						local var_216_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_18.prefab_name].transform, "story_v_out_413112", "413112051", "story_v_out_413112.awb")

						arg_213_1:RecordAudio("413112051", var_216_24)
						arg_213_1:RecordAudio("413112051", var_216_24)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413112", "413112051", "story_v_out_413112.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413112", "413112051", "story_v_out_413112.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_25 = math.max(var_216_16, arg_213_1.talkMaxDuration)

			if var_216_15 <= arg_213_1.time_ and arg_213_1.time_ < var_216_15 + var_216_25 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_15) / var_216_25

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_15 + var_216_25 and arg_213_1.time_ < var_216_15 + var_216_25 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413112052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413112052
		arg_217_1.duration_ = 5.3

		local var_217_0 = {
			zh = 2.966,
			ja = 5.3
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
				arg_217_0:Play413112053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10092_1"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos10092_1 = var_220_0.localPosition
				var_220_0.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10092_1", 7)

				local var_220_2 = var_220_0.childCount

				for iter_220_0 = 0, var_220_2 - 1 do
					local var_220_3 = var_220_0:GetChild(iter_220_0)

					if var_220_3.name == "" or not string.find(var_220_3.name, "split") then
						var_220_3.gameObject:SetActive(true)
					else
						var_220_3.gameObject:SetActive(false)
					end
				end
			end

			local var_220_4 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_4 then
				local var_220_5 = (arg_217_1.time_ - var_220_1) / var_220_4
				local var_220_6 = Vector3.New(0, -2000, 0)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10092_1, var_220_6, var_220_5)
			end

			if arg_217_1.time_ >= var_220_1 + var_220_4 and arg_217_1.time_ < var_220_1 + var_220_4 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_220_7 = arg_217_1.actors_["10094"].transform
			local var_220_8 = 0

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.var_.moveOldPos10094 = var_220_7.localPosition
				var_220_7.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10094", 3)

				local var_220_9 = var_220_7.childCount

				for iter_220_1 = 0, var_220_9 - 1 do
					local var_220_10 = var_220_7:GetChild(iter_220_1)

					if var_220_10.name == "" or not string.find(var_220_10.name, "split") then
						var_220_10.gameObject:SetActive(true)
					else
						var_220_10.gameObject:SetActive(false)
					end
				end
			end

			local var_220_11 = 0.001

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_11 then
				local var_220_12 = (arg_217_1.time_ - var_220_8) / var_220_11
				local var_220_13 = Vector3.New(0, -340, -414)

				var_220_7.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10094, var_220_13, var_220_12)
			end

			if arg_217_1.time_ >= var_220_8 + var_220_11 and arg_217_1.time_ < var_220_8 + var_220_11 + arg_220_0 then
				var_220_7.localPosition = Vector3.New(0, -340, -414)
			end

			local var_220_14 = arg_217_1.actors_["10092_1"]
			local var_220_15 = 0

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 and not isNil(var_220_14) and arg_217_1.var_.actorSpriteComps10092_1 == nil then
				arg_217_1.var_.actorSpriteComps10092_1 = var_220_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_16 = 2

			if var_220_15 <= arg_217_1.time_ and arg_217_1.time_ < var_220_15 + var_220_16 and not isNil(var_220_14) then
				local var_220_17 = (arg_217_1.time_ - var_220_15) / var_220_16

				if arg_217_1.var_.actorSpriteComps10092_1 then
					for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_220_3 then
							if arg_217_1.isInRecall_ then
								local var_220_18 = Mathf.Lerp(iter_220_3.color.r, arg_217_1.hightColor2.r, var_220_17)
								local var_220_19 = Mathf.Lerp(iter_220_3.color.g, arg_217_1.hightColor2.g, var_220_17)
								local var_220_20 = Mathf.Lerp(iter_220_3.color.b, arg_217_1.hightColor2.b, var_220_17)

								iter_220_3.color = Color.New(var_220_18, var_220_19, var_220_20)
							else
								local var_220_21 = Mathf.Lerp(iter_220_3.color.r, 0.5, var_220_17)

								iter_220_3.color = Color.New(var_220_21, var_220_21, var_220_21)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_15 + var_220_16 and arg_217_1.time_ < var_220_15 + var_220_16 + arg_220_0 and not isNil(var_220_14) and arg_217_1.var_.actorSpriteComps10092_1 then
				for iter_220_4, iter_220_5 in pairs(arg_217_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_220_5 then
						if arg_217_1.isInRecall_ then
							iter_220_5.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_220_22 = arg_217_1.actors_["10094"]
			local var_220_23 = 0

			if var_220_23 < arg_217_1.time_ and arg_217_1.time_ <= var_220_23 + arg_220_0 and not isNil(var_220_22) and arg_217_1.var_.actorSpriteComps10094 == nil then
				arg_217_1.var_.actorSpriteComps10094 = var_220_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_24 = 2

			if var_220_23 <= arg_217_1.time_ and arg_217_1.time_ < var_220_23 + var_220_24 and not isNil(var_220_22) then
				local var_220_25 = (arg_217_1.time_ - var_220_23) / var_220_24

				if arg_217_1.var_.actorSpriteComps10094 then
					for iter_220_6, iter_220_7 in pairs(arg_217_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_220_7 then
							if arg_217_1.isInRecall_ then
								local var_220_26 = Mathf.Lerp(iter_220_7.color.r, arg_217_1.hightColor1.r, var_220_25)
								local var_220_27 = Mathf.Lerp(iter_220_7.color.g, arg_217_1.hightColor1.g, var_220_25)
								local var_220_28 = Mathf.Lerp(iter_220_7.color.b, arg_217_1.hightColor1.b, var_220_25)

								iter_220_7.color = Color.New(var_220_26, var_220_27, var_220_28)
							else
								local var_220_29 = Mathf.Lerp(iter_220_7.color.r, 1, var_220_25)

								iter_220_7.color = Color.New(var_220_29, var_220_29, var_220_29)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_23 + var_220_24 and arg_217_1.time_ < var_220_23 + var_220_24 + arg_220_0 and not isNil(var_220_22) and arg_217_1.var_.actorSpriteComps10094 then
				for iter_220_8, iter_220_9 in pairs(arg_217_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_220_9 then
						if arg_217_1.isInRecall_ then
							iter_220_9.color = arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_220_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10094 = nil
			end

			local var_220_30 = 0
			local var_220_31 = 0.375

			if var_220_30 < arg_217_1.time_ and arg_217_1.time_ <= var_220_30 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_32 = arg_217_1:FormatText(StoryNameCfg[259].name)

				arg_217_1.leftNameTxt_.text = var_220_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_33 = arg_217_1:GetWordFromCfg(413112052)
				local var_220_34 = arg_217_1:FormatText(var_220_33.content)

				arg_217_1.text_.text = var_220_34

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_35 = 15
				local var_220_36 = utf8.len(var_220_34)
				local var_220_37 = var_220_35 <= 0 and var_220_31 or var_220_31 * (var_220_36 / var_220_35)

				if var_220_37 > 0 and var_220_31 < var_220_37 then
					arg_217_1.talkMaxDuration = var_220_37

					if var_220_37 + var_220_30 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_37 + var_220_30
					end
				end

				arg_217_1.text_.text = var_220_34
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112052", "story_v_out_413112.awb") ~= 0 then
					local var_220_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112052", "story_v_out_413112.awb") / 1000

					if var_220_38 + var_220_30 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_38 + var_220_30
					end

					if var_220_33.prefab_name ~= "" and arg_217_1.actors_[var_220_33.prefab_name] ~= nil then
						local var_220_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_33.prefab_name].transform, "story_v_out_413112", "413112052", "story_v_out_413112.awb")

						arg_217_1:RecordAudio("413112052", var_220_39)
						arg_217_1:RecordAudio("413112052", var_220_39)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413112", "413112052", "story_v_out_413112.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413112", "413112052", "story_v_out_413112.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_40 = math.max(var_220_31, arg_217_1.talkMaxDuration)

			if var_220_30 <= arg_217_1.time_ and arg_217_1.time_ < var_220_30 + var_220_40 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_30) / var_220_40

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_30 + var_220_40 and arg_217_1.time_ < var_220_30 + var_220_40 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
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
	Play413112053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413112053
		arg_221_1.duration_ = 6.5

		local var_221_0 = {
			zh = 4.3,
			ja = 6.5
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
				arg_221_0:Play413112054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10094"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10094 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10094", 3)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(0, -340, -414)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10094, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_224_7 = arg_221_1.actors_["10094"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10094 == nil then
				arg_221_1.var_.actorSpriteComps10094 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 2

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps10094 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								local var_224_11 = Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, var_224_10)
								local var_224_12 = Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, var_224_10)
								local var_224_13 = Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, var_224_10)

								iter_224_2.color = Color.New(var_224_11, var_224_12, var_224_13)
							else
								local var_224_14 = Mathf.Lerp(iter_224_2.color.r, 1, var_224_10)

								iter_224_2.color = Color.New(var_224_14, var_224_14, var_224_14)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10094 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10094 = nil
			end

			local var_224_15 = 0
			local var_224_16 = 0.525

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[259].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(413112053)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112053", "story_v_out_413112.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112053", "story_v_out_413112.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_413112", "413112053", "story_v_out_413112.awb")

						arg_221_1:RecordAudio("413112053", var_224_24)
						arg_221_1:RecordAudio("413112053", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413112", "413112053", "story_v_out_413112.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413112", "413112053", "story_v_out_413112.awb")
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
				actorName = "10094",
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
	Play413112054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413112054
		arg_225_1.duration_ = 3.77

		local var_225_0 = {
			zh = 3.766,
			ja = 3.2
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
				arg_225_0:Play413112055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10094"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10094 = var_228_0.localPosition
				var_228_0.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10094", 2)

				local var_228_2 = var_228_0.childCount

				for iter_228_0 = 0, var_228_2 - 1 do
					local var_228_3 = var_228_0:GetChild(iter_228_0)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_4 then
				local var_228_5 = (arg_225_1.time_ - var_228_1) / var_228_4
				local var_228_6 = Vector3.New(-390, -340, -414)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10094, var_228_6, var_228_5)
			end

			if arg_225_1.time_ >= var_228_1 + var_228_4 and arg_225_1.time_ < var_228_1 + var_228_4 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_228_7 = arg_225_1.actors_["10094"]
			local var_228_8 = 0

			if var_228_8 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps10094 == nil then
				arg_225_1.var_.actorSpriteComps10094 = var_228_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_9 = 2

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_9 and not isNil(var_228_7) then
				local var_228_10 = (arg_225_1.time_ - var_228_8) / var_228_9

				if arg_225_1.var_.actorSpriteComps10094 then
					for iter_228_1, iter_228_2 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_228_2 then
							if arg_225_1.isInRecall_ then
								local var_228_11 = Mathf.Lerp(iter_228_2.color.r, arg_225_1.hightColor2.r, var_228_10)
								local var_228_12 = Mathf.Lerp(iter_228_2.color.g, arg_225_1.hightColor2.g, var_228_10)
								local var_228_13 = Mathf.Lerp(iter_228_2.color.b, arg_225_1.hightColor2.b, var_228_10)

								iter_228_2.color = Color.New(var_228_11, var_228_12, var_228_13)
							else
								local var_228_14 = Mathf.Lerp(iter_228_2.color.r, 0.5, var_228_10)

								iter_228_2.color = Color.New(var_228_14, var_228_14, var_228_14)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_8 + var_228_9 and arg_225_1.time_ < var_228_8 + var_228_9 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.actorSpriteComps10094 then
				for iter_228_3, iter_228_4 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_228_4 then
						if arg_225_1.isInRecall_ then
							iter_228_4.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10094 = nil
			end

			local var_228_15 = arg_225_1.actors_["10022"]
			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.actorSpriteComps10022 == nil then
				arg_225_1.var_.actorSpriteComps10022 = var_228_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_17 = 2

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 and not isNil(var_228_15) then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17

				if arg_225_1.var_.actorSpriteComps10022 then
					for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_228_6 then
							if arg_225_1.isInRecall_ then
								local var_228_19 = Mathf.Lerp(iter_228_6.color.r, arg_225_1.hightColor1.r, var_228_18)
								local var_228_20 = Mathf.Lerp(iter_228_6.color.g, arg_225_1.hightColor1.g, var_228_18)
								local var_228_21 = Mathf.Lerp(iter_228_6.color.b, arg_225_1.hightColor1.b, var_228_18)

								iter_228_6.color = Color.New(var_228_19, var_228_20, var_228_21)
							else
								local var_228_22 = Mathf.Lerp(iter_228_6.color.r, 1, var_228_18)

								iter_228_6.color = Color.New(var_228_22, var_228_22, var_228_22)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 and not isNil(var_228_15) and arg_225_1.var_.actorSpriteComps10022 then
				for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_228_8 then
						if arg_225_1.isInRecall_ then
							iter_228_8.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10022 = nil
			end

			local var_228_23 = arg_225_1.actors_["10022"].transform
			local var_228_24 = 0

			if var_228_24 < arg_225_1.time_ and arg_225_1.time_ <= var_228_24 + arg_228_0 then
				arg_225_1.var_.moveOldPos10022 = var_228_23.localPosition
				var_228_23.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10022", 4)

				local var_228_25 = var_228_23.childCount

				for iter_228_9 = 0, var_228_25 - 1 do
					local var_228_26 = var_228_23:GetChild(iter_228_9)

					if var_228_26.name == "split_3" or not string.find(var_228_26.name, "split") then
						var_228_26.gameObject:SetActive(true)
					else
						var_228_26.gameObject:SetActive(false)
					end
				end
			end

			local var_228_27 = 0.001

			if var_228_24 <= arg_225_1.time_ and arg_225_1.time_ < var_228_24 + var_228_27 then
				local var_228_28 = (arg_225_1.time_ - var_228_24) / var_228_27
				local var_228_29 = Vector3.New(390, -315, -320)

				var_228_23.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10022, var_228_29, var_228_28)
			end

			if arg_225_1.time_ >= var_228_24 + var_228_27 and arg_225_1.time_ < var_228_24 + var_228_27 + arg_228_0 then
				var_228_23.localPosition = Vector3.New(390, -315, -320)
			end

			local var_228_30 = 0
			local var_228_31 = 0.433333333333333

			if var_228_30 < arg_225_1.time_ and arg_225_1.time_ <= var_228_30 + arg_228_0 then
				local var_228_32 = "play"
				local var_228_33 = "music"

				arg_225_1:AudioAction(var_228_32, var_228_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_228_34 = ""
				local var_228_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_228_35 ~= "" then
					if arg_225_1.bgmTxt_.text ~= var_228_35 and arg_225_1.bgmTxt_.text ~= "" then
						if arg_225_1.bgmTxt2_.text ~= "" then
							arg_225_1.bgmTxt_.text = arg_225_1.bgmTxt2_.text
						end

						arg_225_1.bgmTxt2_.text = var_228_35

						arg_225_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_225_1.bgmTxt_.text = var_228_35
						arg_225_1.bgmTxt2_.text = var_228_35
					end

					if arg_225_1.bgmTimer then
						arg_225_1.bgmTimer:Stop()

						arg_225_1.bgmTimer = nil
					end

					if arg_225_1.settingData.show_music_name == 1 then
						arg_225_1.musicController:SetSelectedState("show")
						arg_225_1.musicAnimator_:Play("open", 0, 0)

						if arg_225_1.settingData.music_time ~= 0 then
							arg_225_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_225_1.settingData.music_time), function()
								if arg_225_1 == nil or isNil(arg_225_1.bgmTxt_) then
									return
								end

								arg_225_1.musicController:SetSelectedState("hide")
								arg_225_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_228_36 = 0
			local var_228_37 = 0.425

			if var_228_36 < arg_225_1.time_ and arg_225_1.time_ <= var_228_36 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_38 = arg_225_1:FormatText(StoryNameCfg[614].name)

				arg_225_1.leftNameTxt_.text = var_228_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_39 = arg_225_1:GetWordFromCfg(413112054)
				local var_228_40 = arg_225_1:FormatText(var_228_39.content)

				arg_225_1.text_.text = var_228_40

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_41 = 17
				local var_228_42 = utf8.len(var_228_40)
				local var_228_43 = var_228_41 <= 0 and var_228_37 or var_228_37 * (var_228_42 / var_228_41)

				if var_228_43 > 0 and var_228_37 < var_228_43 then
					arg_225_1.talkMaxDuration = var_228_43

					if var_228_43 + var_228_36 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_43 + var_228_36
					end
				end

				arg_225_1.text_.text = var_228_40
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112054", "story_v_out_413112.awb") ~= 0 then
					local var_228_44 = manager.audio:GetVoiceLength("story_v_out_413112", "413112054", "story_v_out_413112.awb") / 1000

					if var_228_44 + var_228_36 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_44 + var_228_36
					end

					if var_228_39.prefab_name ~= "" and arg_225_1.actors_[var_228_39.prefab_name] ~= nil then
						local var_228_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_39.prefab_name].transform, "story_v_out_413112", "413112054", "story_v_out_413112.awb")

						arg_225_1:RecordAudio("413112054", var_228_45)
						arg_225_1:RecordAudio("413112054", var_228_45)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413112", "413112054", "story_v_out_413112.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413112", "413112054", "story_v_out_413112.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_46 = math.max(var_228_37, arg_225_1.talkMaxDuration)

			if var_228_36 <= arg_225_1.time_ and arg_225_1.time_ < var_228_36 + var_228_46 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_36) / var_228_46

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_36 + var_228_46 and arg_225_1.time_ < var_228_36 + var_228_46 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_225_1:InitPlayNodeList()
	end,
	Play413112055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 413112055
		arg_230_1.duration_ = 5.7

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play413112056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10094"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos10094 = var_233_0.localPosition
				var_233_0.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10094", 6)

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
				local var_233_6 = Vector3.New(1500, -340, -414)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10094, var_233_6, var_233_5)
			end

			if arg_230_1.time_ >= var_233_1 + var_233_4 and arg_230_1.time_ < var_233_1 + var_233_4 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(1500, -340, -414)
			end

			local var_233_7 = arg_230_1.actors_["10022"].transform
			local var_233_8 = 0

			if var_233_8 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.var_.moveOldPos10022 = var_233_7.localPosition
				var_233_7.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("10022", 7)

				local var_233_9 = var_233_7.childCount

				for iter_233_1 = 0, var_233_9 - 1 do
					local var_233_10 = var_233_7:GetChild(iter_233_1)

					if var_233_10.name == "" or not string.find(var_233_10.name, "split") then
						var_233_10.gameObject:SetActive(true)
					else
						var_233_10.gameObject:SetActive(false)
					end
				end
			end

			local var_233_11 = 0.001

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_11 then
				local var_233_12 = (arg_230_1.time_ - var_233_8) / var_233_11
				local var_233_13 = Vector3.New(0, -2000, 0)

				var_233_7.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10022, var_233_13, var_233_12)
			end

			if arg_230_1.time_ >= var_233_8 + var_233_11 and arg_230_1.time_ < var_233_8 + var_233_11 + arg_233_0 then
				var_233_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_233_14 = 0

			if var_233_14 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_15 = 0.533333333333333

			if var_233_14 <= arg_230_1.time_ and arg_230_1.time_ < var_233_14 + var_233_15 then
				local var_233_16 = (arg_230_1.time_ - var_233_14) / var_233_15
				local var_233_17 = Color.New(1, 1, 1)

				var_233_17.a = Mathf.Lerp(1, 0, var_233_16)
				arg_230_1.mask_.color = var_233_17
			end

			if arg_230_1.time_ >= var_233_14 + var_233_15 and arg_230_1.time_ < var_233_14 + var_233_15 + arg_233_0 then
				local var_233_18 = Color.New(1, 1, 1)
				local var_233_19 = 0

				arg_230_1.mask_.enabled = false
				var_233_18.a = var_233_19
				arg_230_1.mask_.color = var_233_18
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_20 = 0.7
			local var_233_21 = 0.675

			if var_233_20 < arg_230_1.time_ and arg_230_1.time_ <= var_233_20 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_22 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_22:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_23 = arg_230_1:GetWordFromCfg(413112055)
				local var_233_24 = arg_230_1:FormatText(var_233_23.content)

				arg_230_1.text_.text = var_233_24

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_25 = 27
				local var_233_26 = utf8.len(var_233_24)
				local var_233_27 = var_233_25 <= 0 and var_233_21 or var_233_21 * (var_233_26 / var_233_25)

				if var_233_27 > 0 and var_233_21 < var_233_27 then
					arg_230_1.talkMaxDuration = var_233_27
					var_233_20 = var_233_20 + 0.3

					if var_233_27 + var_233_20 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_27 + var_233_20
					end
				end

				arg_230_1.text_.text = var_233_24
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_28 = var_233_20 + 0.3
			local var_233_29 = math.max(var_233_21, arg_230_1.talkMaxDuration)

			if var_233_28 <= arg_230_1.time_ and arg_230_1.time_ < var_233_28 + var_233_29 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_28) / var_233_29

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_28 + var_233_29 and arg_230_1.time_ < var_233_28 + var_233_29 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_230_1:InitPlayNodeList()
	end,
	Play413112056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413112056
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play413112057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 1.1

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_2 = arg_236_1:GetWordFromCfg(413112056)
				local var_239_3 = arg_236_1:FormatText(var_239_2.content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 44
				local var_239_5 = utf8.len(var_239_3)
				local var_239_6 = var_239_4 <= 0 and var_239_1 or var_239_1 * (var_239_5 / var_239_4)

				if var_239_6 > 0 and var_239_1 < var_239_6 then
					arg_236_1.talkMaxDuration = var_239_6

					if var_239_6 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_7 and arg_236_1.time_ < var_239_0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play413112057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413112057
		arg_240_1.duration_ = 9.54

		local var_240_0 = {
			zh = 9.541,
			ja = 3.841
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
				arg_240_0:Play413112058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = manager.ui.mainCamera.transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				local var_243_2 = arg_240_1.var_.effect456
				local var_243_3
				local var_243_4 = var_243_0

				if not var_243_2 then
					var_243_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_243_4)
					var_243_2.name = "456"
					arg_240_1.var_.effect456 = var_243_2
				else
					var_243_2.transform:SetParent(var_243_4)
				end

				var_243_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_243_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_243_5 = manager.ui.mainCamera.transform
			local var_243_6 = 0.733333333333333

			if var_243_6 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				local var_243_7 = arg_240_1.var_.effect456

				if var_243_7 then
					Object.Destroy(var_243_7)

					arg_240_1.var_.effect456 = nil
				end
			end

			local var_243_8 = 0
			local var_243_9 = 0.433333333333333

			if var_243_8 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				local var_243_10 = "play"
				local var_243_11 = "music"

				arg_240_1:AudioAction(var_243_10, var_243_11, "ui_battle", "ui_battle_stopbgm", "")

				local var_243_12 = ""
				local var_243_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_243_13 ~= "" then
					if arg_240_1.bgmTxt_.text ~= var_243_13 and arg_240_1.bgmTxt_.text ~= "" then
						if arg_240_1.bgmTxt2_.text ~= "" then
							arg_240_1.bgmTxt_.text = arg_240_1.bgmTxt2_.text
						end

						arg_240_1.bgmTxt2_.text = var_243_13

						arg_240_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_240_1.bgmTxt_.text = var_243_13
						arg_240_1.bgmTxt2_.text = var_243_13
					end

					if arg_240_1.bgmTimer then
						arg_240_1.bgmTimer:Stop()

						arg_240_1.bgmTimer = nil
					end

					if arg_240_1.settingData.show_music_name == 1 then
						arg_240_1.musicController:SetSelectedState("show")
						arg_240_1.musicAnimator_:Play("open", 0, 0)

						if arg_240_1.settingData.music_time ~= 0 then
							arg_240_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_240_1.settingData.music_time), function()
								if arg_240_1 == nil or isNil(arg_240_1.bgmTxt_) then
									return
								end

								arg_240_1.musicController:SetSelectedState("hide")
								arg_240_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_243_14 = 0.466666666666667
			local var_243_15 = 0.633333333333333

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				local var_243_16 = "play"
				local var_243_17 = "music"

				arg_240_1:AudioAction(var_243_16, var_243_17, "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_243_18 = ""
				local var_243_19 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if var_243_19 ~= "" then
					if arg_240_1.bgmTxt_.text ~= var_243_19 and arg_240_1.bgmTxt_.text ~= "" then
						if arg_240_1.bgmTxt2_.text ~= "" then
							arg_240_1.bgmTxt_.text = arg_240_1.bgmTxt2_.text
						end

						arg_240_1.bgmTxt2_.text = var_243_19

						arg_240_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_240_1.bgmTxt_.text = var_243_19
						arg_240_1.bgmTxt2_.text = var_243_19
					end

					if arg_240_1.bgmTimer then
						arg_240_1.bgmTimer:Stop()

						arg_240_1.bgmTimer = nil
					end

					if arg_240_1.settingData.show_music_name == 1 then
						arg_240_1.musicController:SetSelectedState("show")
						arg_240_1.musicAnimator_:Play("open", 0, 0)

						if arg_240_1.settingData.music_time ~= 0 then
							arg_240_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_240_1.settingData.music_time), function()
								if arg_240_1 == nil or isNil(arg_240_1.bgmTxt_) then
									return
								end

								arg_240_1.musicController:SetSelectedState("hide")
								arg_240_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_240_1.frameCnt_ <= 1 then
				arg_240_1.dialog_:SetActive(false)
			end

			local var_243_20 = 0.775
			local var_243_21 = 0.225

			if var_243_20 < arg_240_1.time_ and arg_240_1.time_ <= var_243_20 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0

				arg_240_1.dialog_:SetActive(true)

				arg_240_1.dialogCg_.alpha = 0

				local var_243_22 = LeanTween.value(arg_240_1.dialog_, 0, 1, 0.3)

				var_243_22:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_240_1.dialogCg_.alpha = arg_246_0
				end))
				var_243_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_240_1.dialog_)
					var_243_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_240_1.duration_ = arg_240_1.duration_ + 0.3

				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_23 = arg_240_1:FormatText(StoryNameCfg[36].name)

				arg_240_1.leftNameTxt_.text = var_243_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_24 = arg_240_1:GetWordFromCfg(413112057)
				local var_243_25 = arg_240_1:FormatText(var_243_24.content)

				arg_240_1.text_.text = var_243_25

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_26 = 9
				local var_243_27 = utf8.len(var_243_25)
				local var_243_28 = var_243_26 <= 0 and var_243_21 or var_243_21 * (var_243_27 / var_243_26)

				if var_243_28 > 0 and var_243_21 < var_243_28 then
					arg_240_1.talkMaxDuration = var_243_28
					var_243_20 = var_243_20 + 0.3

					if var_243_28 + var_243_20 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_28 + var_243_20
					end
				end

				arg_240_1.text_.text = var_243_25
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112057", "story_v_out_413112.awb") ~= 0 then
					local var_243_29 = manager.audio:GetVoiceLength("story_v_out_413112", "413112057", "story_v_out_413112.awb") / 1000

					if var_243_29 + var_243_20 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_29 + var_243_20
					end

					if var_243_24.prefab_name ~= "" and arg_240_1.actors_[var_243_24.prefab_name] ~= nil then
						local var_243_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_24.prefab_name].transform, "story_v_out_413112", "413112057", "story_v_out_413112.awb")

						arg_240_1:RecordAudio("413112057", var_243_30)
						arg_240_1:RecordAudio("413112057", var_243_30)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_413112", "413112057", "story_v_out_413112.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_413112", "413112057", "story_v_out_413112.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_31 = var_243_20 + 0.3
			local var_243_32 = math.max(var_243_21, arg_240_1.talkMaxDuration)

			if var_243_31 <= arg_240_1.time_ and arg_240_1.time_ < var_243_31 + var_243_32 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_31) / var_243_32

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_31 + var_243_32 and arg_240_1.time_ < var_243_31 + var_243_32 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play413112058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 413112058
		arg_248_1.duration_ = 2.7

		local var_248_0 = {
			zh = 2.333,
			ja = 2.7
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
				arg_248_0:Play413112059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10022"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos10022 = var_251_0.localPosition
				var_251_0.localScale = Vector3.New(1, 1, 1)

				arg_248_1:CheckSpriteTmpPos("10022", 3)

				local var_251_2 = var_251_0.childCount

				for iter_251_0 = 0, var_251_2 - 1 do
					local var_251_3 = var_251_0:GetChild(iter_251_0)

					if var_251_3.name == "split_6" or not string.find(var_251_3.name, "split") then
						var_251_3.gameObject:SetActive(true)
					else
						var_251_3.gameObject:SetActive(false)
					end
				end
			end

			local var_251_4 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_4 then
				local var_251_5 = (arg_248_1.time_ - var_251_1) / var_251_4
				local var_251_6 = Vector3.New(0, -315, -320)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10022, var_251_6, var_251_5)
			end

			if arg_248_1.time_ >= var_251_1 + var_251_4 and arg_248_1.time_ < var_251_1 + var_251_4 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_251_7 = arg_248_1.actors_["10022"]
			local var_251_8 = 0

			if var_251_8 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 and not isNil(var_251_7) and arg_248_1.var_.actorSpriteComps10022 == nil then
				arg_248_1.var_.actorSpriteComps10022 = var_251_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_9 = 2

			if var_251_8 <= arg_248_1.time_ and arg_248_1.time_ < var_251_8 + var_251_9 and not isNil(var_251_7) then
				local var_251_10 = (arg_248_1.time_ - var_251_8) / var_251_9

				if arg_248_1.var_.actorSpriteComps10022 then
					for iter_251_1, iter_251_2 in pairs(arg_248_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_251_2 then
							if arg_248_1.isInRecall_ then
								local var_251_11 = Mathf.Lerp(iter_251_2.color.r, arg_248_1.hightColor1.r, var_251_10)
								local var_251_12 = Mathf.Lerp(iter_251_2.color.g, arg_248_1.hightColor1.g, var_251_10)
								local var_251_13 = Mathf.Lerp(iter_251_2.color.b, arg_248_1.hightColor1.b, var_251_10)

								iter_251_2.color = Color.New(var_251_11, var_251_12, var_251_13)
							else
								local var_251_14 = Mathf.Lerp(iter_251_2.color.r, 1, var_251_10)

								iter_251_2.color = Color.New(var_251_14, var_251_14, var_251_14)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= var_251_8 + var_251_9 and arg_248_1.time_ < var_251_8 + var_251_9 + arg_251_0 and not isNil(var_251_7) and arg_248_1.var_.actorSpriteComps10022 then
				for iter_251_3, iter_251_4 in pairs(arg_248_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_251_4 then
						if arg_248_1.isInRecall_ then
							iter_251_4.color = arg_248_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_251_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_248_1.var_.actorSpriteComps10022 = nil
			end

			local var_251_15 = 0
			local var_251_16 = 0.325

			if var_251_15 < arg_248_1.time_ and arg_248_1.time_ <= var_251_15 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_17 = arg_248_1:FormatText(StoryNameCfg[614].name)

				arg_248_1.leftNameTxt_.text = var_251_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_18 = arg_248_1:GetWordFromCfg(413112058)
				local var_251_19 = arg_248_1:FormatText(var_251_18.content)

				arg_248_1.text_.text = var_251_19

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_20 = 13
				local var_251_21 = utf8.len(var_251_19)
				local var_251_22 = var_251_20 <= 0 and var_251_16 or var_251_16 * (var_251_21 / var_251_20)

				if var_251_22 > 0 and var_251_16 < var_251_22 then
					arg_248_1.talkMaxDuration = var_251_22

					if var_251_22 + var_251_15 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_22 + var_251_15
					end
				end

				arg_248_1.text_.text = var_251_19
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112058", "story_v_out_413112.awb") ~= 0 then
					local var_251_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112058", "story_v_out_413112.awb") / 1000

					if var_251_23 + var_251_15 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_23 + var_251_15
					end

					if var_251_18.prefab_name ~= "" and arg_248_1.actors_[var_251_18.prefab_name] ~= nil then
						local var_251_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_18.prefab_name].transform, "story_v_out_413112", "413112058", "story_v_out_413112.awb")

						arg_248_1:RecordAudio("413112058", var_251_24)
						arg_248_1:RecordAudio("413112058", var_251_24)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_413112", "413112058", "story_v_out_413112.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_413112", "413112058", "story_v_out_413112.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_25 = math.max(var_251_16, arg_248_1.talkMaxDuration)

			if var_251_15 <= arg_248_1.time_ and arg_248_1.time_ < var_251_15 + var_251_25 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_15) / var_251_25

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_15 + var_251_25 and arg_248_1.time_ < var_251_15 + var_251_25 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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

		arg_248_1:InitPlayNodeList()
	end,
	Play413112059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 413112059
		arg_252_1.duration_ = 4.13

		local var_252_0 = {
			zh = 3.666,
			ja = 4.133
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play413112060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10022"].transform
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.var_.moveOldPos10022 = var_255_0.localPosition
				var_255_0.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10022", 2)

				local var_255_2 = var_255_0.childCount

				for iter_255_0 = 0, var_255_2 - 1 do
					local var_255_3 = var_255_0:GetChild(iter_255_0)

					if var_255_3.name == "split_6" or not string.find(var_255_3.name, "split") then
						var_255_3.gameObject:SetActive(true)
					else
						var_255_3.gameObject:SetActive(false)
					end
				end
			end

			local var_255_4 = 0.001

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_4 then
				local var_255_5 = (arg_252_1.time_ - var_255_1) / var_255_4
				local var_255_6 = Vector3.New(-390, -315, -320)

				var_255_0.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10022, var_255_6, var_255_5)
			end

			if arg_252_1.time_ >= var_255_1 + var_255_4 and arg_252_1.time_ < var_255_1 + var_255_4 + arg_255_0 then
				var_255_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_255_7 = arg_252_1.actors_["10092_1"].transform
			local var_255_8 = 0

			if var_255_8 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.var_.moveOldPos10092_1 = var_255_7.localPosition
				var_255_7.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10092_1", 4)

				local var_255_9 = var_255_7.childCount

				for iter_255_1 = 0, var_255_9 - 1 do
					local var_255_10 = var_255_7:GetChild(iter_255_1)

					if var_255_10.name == "split_1_1" or not string.find(var_255_10.name, "split") then
						var_255_10.gameObject:SetActive(true)
					else
						var_255_10.gameObject:SetActive(false)
					end
				end
			end

			local var_255_11 = 0.001

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_11 then
				local var_255_12 = (arg_252_1.time_ - var_255_8) / var_255_11
				local var_255_13 = Vector3.New(390, -300, -295)

				var_255_7.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10092_1, var_255_13, var_255_12)
			end

			if arg_252_1.time_ >= var_255_8 + var_255_11 and arg_252_1.time_ < var_255_8 + var_255_11 + arg_255_0 then
				var_255_7.localPosition = Vector3.New(390, -300, -295)
			end

			local var_255_14 = arg_252_1.actors_["10022"]
			local var_255_15 = 0

			if var_255_15 < arg_252_1.time_ and arg_252_1.time_ <= var_255_15 + arg_255_0 and not isNil(var_255_14) and arg_252_1.var_.actorSpriteComps10022 == nil then
				arg_252_1.var_.actorSpriteComps10022 = var_255_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_16 = 2

			if var_255_15 <= arg_252_1.time_ and arg_252_1.time_ < var_255_15 + var_255_16 and not isNil(var_255_14) then
				local var_255_17 = (arg_252_1.time_ - var_255_15) / var_255_16

				if arg_252_1.var_.actorSpriteComps10022 then
					for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_255_3 then
							if arg_252_1.isInRecall_ then
								local var_255_18 = Mathf.Lerp(iter_255_3.color.r, arg_252_1.hightColor2.r, var_255_17)
								local var_255_19 = Mathf.Lerp(iter_255_3.color.g, arg_252_1.hightColor2.g, var_255_17)
								local var_255_20 = Mathf.Lerp(iter_255_3.color.b, arg_252_1.hightColor2.b, var_255_17)

								iter_255_3.color = Color.New(var_255_18, var_255_19, var_255_20)
							else
								local var_255_21 = Mathf.Lerp(iter_255_3.color.r, 0.5, var_255_17)

								iter_255_3.color = Color.New(var_255_21, var_255_21, var_255_21)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_15 + var_255_16 and arg_252_1.time_ < var_255_15 + var_255_16 + arg_255_0 and not isNil(var_255_14) and arg_252_1.var_.actorSpriteComps10022 then
				for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_255_5 then
						if arg_252_1.isInRecall_ then
							iter_255_5.color = arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_255_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10022 = nil
			end

			local var_255_22 = arg_252_1.actors_["10092_1"]
			local var_255_23 = 0

			if var_255_23 < arg_252_1.time_ and arg_252_1.time_ <= var_255_23 + arg_255_0 and not isNil(var_255_22) and arg_252_1.var_.actorSpriteComps10092_1 == nil then
				arg_252_1.var_.actorSpriteComps10092_1 = var_255_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_24 = 2

			if var_255_23 <= arg_252_1.time_ and arg_252_1.time_ < var_255_23 + var_255_24 and not isNil(var_255_22) then
				local var_255_25 = (arg_252_1.time_ - var_255_23) / var_255_24

				if arg_252_1.var_.actorSpriteComps10092_1 then
					for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_255_7 then
							if arg_252_1.isInRecall_ then
								local var_255_26 = Mathf.Lerp(iter_255_7.color.r, arg_252_1.hightColor1.r, var_255_25)
								local var_255_27 = Mathf.Lerp(iter_255_7.color.g, arg_252_1.hightColor1.g, var_255_25)
								local var_255_28 = Mathf.Lerp(iter_255_7.color.b, arg_252_1.hightColor1.b, var_255_25)

								iter_255_7.color = Color.New(var_255_26, var_255_27, var_255_28)
							else
								local var_255_29 = Mathf.Lerp(iter_255_7.color.r, 1, var_255_25)

								iter_255_7.color = Color.New(var_255_29, var_255_29, var_255_29)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_23 + var_255_24 and arg_252_1.time_ < var_255_23 + var_255_24 + arg_255_0 and not isNil(var_255_22) and arg_252_1.var_.actorSpriteComps10092_1 then
				for iter_255_8, iter_255_9 in pairs(arg_252_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_255_9 then
						if arg_252_1.isInRecall_ then
							iter_255_9.color = arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_255_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_255_30 = 0
			local var_255_31 = 0.475

			if var_255_30 < arg_252_1.time_ and arg_252_1.time_ <= var_255_30 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_32 = arg_252_1:FormatText(StoryNameCfg[996].name)

				arg_252_1.leftNameTxt_.text = var_255_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_33 = arg_252_1:GetWordFromCfg(413112059)
				local var_255_34 = arg_252_1:FormatText(var_255_33.content)

				arg_252_1.text_.text = var_255_34

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_35 = 19
				local var_255_36 = utf8.len(var_255_34)
				local var_255_37 = var_255_35 <= 0 and var_255_31 or var_255_31 * (var_255_36 / var_255_35)

				if var_255_37 > 0 and var_255_31 < var_255_37 then
					arg_252_1.talkMaxDuration = var_255_37

					if var_255_37 + var_255_30 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_37 + var_255_30
					end
				end

				arg_252_1.text_.text = var_255_34
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112059", "story_v_out_413112.awb") ~= 0 then
					local var_255_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112059", "story_v_out_413112.awb") / 1000

					if var_255_38 + var_255_30 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_38 + var_255_30
					end

					if var_255_33.prefab_name ~= "" and arg_252_1.actors_[var_255_33.prefab_name] ~= nil then
						local var_255_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_33.prefab_name].transform, "story_v_out_413112", "413112059", "story_v_out_413112.awb")

						arg_252_1:RecordAudio("413112059", var_255_39)
						arg_252_1:RecordAudio("413112059", var_255_39)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_413112", "413112059", "story_v_out_413112.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_413112", "413112059", "story_v_out_413112.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_40 = math.max(var_255_31, arg_252_1.talkMaxDuration)

			if var_255_30 <= arg_252_1.time_ and arg_252_1.time_ < var_255_30 + var_255_40 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_30) / var_255_40

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_30 + var_255_40 and arg_252_1.time_ < var_255_30 + var_255_40 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
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
	Play413112060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 413112060
		arg_256_1.duration_ = 7.87

		local var_256_0 = {
			zh = 7.866,
			ja = 4.366
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play413112061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10092_1"].transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.moveOldPos10092_1 = var_259_0.localPosition
				var_259_0.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("10092_1", 7)

				local var_259_2 = var_259_0.childCount

				for iter_259_0 = 0, var_259_2 - 1 do
					local var_259_3 = var_259_0:GetChild(iter_259_0)

					if var_259_3.name == "" or not string.find(var_259_3.name, "split") then
						var_259_3.gameObject:SetActive(true)
					else
						var_259_3.gameObject:SetActive(false)
					end
				end
			end

			local var_259_4 = 0.001

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_4 then
				local var_259_5 = (arg_256_1.time_ - var_259_1) / var_259_4
				local var_259_6 = Vector3.New(0, -2000, 0)

				var_259_0.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10092_1, var_259_6, var_259_5)
			end

			if arg_256_1.time_ >= var_259_1 + var_259_4 and arg_256_1.time_ < var_259_1 + var_259_4 + arg_259_0 then
				var_259_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_259_7 = arg_256_1.actors_["10022"].transform
			local var_259_8 = 0

			if var_259_8 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1.var_.moveOldPos10022 = var_259_7.localPosition
				var_259_7.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("10022", 7)

				local var_259_9 = var_259_7.childCount

				for iter_259_1 = 0, var_259_9 - 1 do
					local var_259_10 = var_259_7:GetChild(iter_259_1)

					if var_259_10.name == "" or not string.find(var_259_10.name, "split") then
						var_259_10.gameObject:SetActive(true)
					else
						var_259_10.gameObject:SetActive(false)
					end
				end
			end

			local var_259_11 = 0.001

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_11 then
				local var_259_12 = (arg_256_1.time_ - var_259_8) / var_259_11
				local var_259_13 = Vector3.New(0, -2000, 0)

				var_259_7.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10022, var_259_13, var_259_12)
			end

			if arg_256_1.time_ >= var_259_8 + var_259_11 and arg_256_1.time_ < var_259_8 + var_259_11 + arg_259_0 then
				var_259_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_259_14 = 0
			local var_259_15 = 0.3

			if var_259_14 < arg_256_1.time_ and arg_256_1.time_ <= var_259_14 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_16 = arg_256_1:FormatText(StoryNameCfg[36].name)

				arg_256_1.leftNameTxt_.text = var_259_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_17 = arg_256_1:GetWordFromCfg(413112060)
				local var_259_18 = arg_256_1:FormatText(var_259_17.content)

				arg_256_1.text_.text = var_259_18

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_19 = 12
				local var_259_20 = utf8.len(var_259_18)
				local var_259_21 = var_259_19 <= 0 and var_259_15 or var_259_15 * (var_259_20 / var_259_19)

				if var_259_21 > 0 and var_259_15 < var_259_21 then
					arg_256_1.talkMaxDuration = var_259_21

					if var_259_21 + var_259_14 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_21 + var_259_14
					end
				end

				arg_256_1.text_.text = var_259_18
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112060", "story_v_out_413112.awb") ~= 0 then
					local var_259_22 = manager.audio:GetVoiceLength("story_v_out_413112", "413112060", "story_v_out_413112.awb") / 1000

					if var_259_22 + var_259_14 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_22 + var_259_14
					end

					if var_259_17.prefab_name ~= "" and arg_256_1.actors_[var_259_17.prefab_name] ~= nil then
						local var_259_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_17.prefab_name].transform, "story_v_out_413112", "413112060", "story_v_out_413112.awb")

						arg_256_1:RecordAudio("413112060", var_259_23)
						arg_256_1:RecordAudio("413112060", var_259_23)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_413112", "413112060", "story_v_out_413112.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_413112", "413112060", "story_v_out_413112.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_24 = math.max(var_259_15, arg_256_1.talkMaxDuration)

			if var_259_14 <= arg_256_1.time_ and arg_256_1.time_ < var_259_14 + var_259_24 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_14) / var_259_24

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_14 + var_259_24 and arg_256_1.time_ < var_259_14 + var_259_24 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_256_1:InitPlayNodeList()
	end,
	Play413112061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 413112061
		arg_260_1.duration_ = 3.27

		local var_260_0 = {
			zh = 1.999999999999,
			ja = 3.266
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
				arg_260_0:Play413112062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["10093"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos10093 = var_263_0.localPosition
				var_263_0.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10093", 3)

				local var_263_2 = var_263_0.childCount

				for iter_263_0 = 0, var_263_2 - 1 do
					local var_263_3 = var_263_0:GetChild(iter_263_0)

					if var_263_3.name == "split_3" or not string.find(var_263_3.name, "split") then
						var_263_3.gameObject:SetActive(true)
					else
						var_263_3.gameObject:SetActive(false)
					end
				end
			end

			local var_263_4 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_4 then
				local var_263_5 = (arg_260_1.time_ - var_263_1) / var_263_4
				local var_263_6 = Vector3.New(0, -345, -245)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10093, var_263_6, var_263_5)
			end

			if arg_260_1.time_ >= var_263_1 + var_263_4 and arg_260_1.time_ < var_263_1 + var_263_4 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_263_7 = arg_260_1.actors_["10093"]
			local var_263_8 = 0

			if var_263_8 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 and not isNil(var_263_7) and arg_260_1.var_.actorSpriteComps10093 == nil then
				arg_260_1.var_.actorSpriteComps10093 = var_263_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_9 = 2

			if var_263_8 <= arg_260_1.time_ and arg_260_1.time_ < var_263_8 + var_263_9 and not isNil(var_263_7) then
				local var_263_10 = (arg_260_1.time_ - var_263_8) / var_263_9

				if arg_260_1.var_.actorSpriteComps10093 then
					for iter_263_1, iter_263_2 in pairs(arg_260_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_263_2 then
							if arg_260_1.isInRecall_ then
								local var_263_11 = Mathf.Lerp(iter_263_2.color.r, arg_260_1.hightColor1.r, var_263_10)
								local var_263_12 = Mathf.Lerp(iter_263_2.color.g, arg_260_1.hightColor1.g, var_263_10)
								local var_263_13 = Mathf.Lerp(iter_263_2.color.b, arg_260_1.hightColor1.b, var_263_10)

								iter_263_2.color = Color.New(var_263_11, var_263_12, var_263_13)
							else
								local var_263_14 = Mathf.Lerp(iter_263_2.color.r, 1, var_263_10)

								iter_263_2.color = Color.New(var_263_14, var_263_14, var_263_14)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= var_263_8 + var_263_9 and arg_260_1.time_ < var_263_8 + var_263_9 + arg_263_0 and not isNil(var_263_7) and arg_260_1.var_.actorSpriteComps10093 then
				for iter_263_3, iter_263_4 in pairs(arg_260_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_263_4 then
						if arg_260_1.isInRecall_ then
							iter_263_4.color = arg_260_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_263_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_260_1.var_.actorSpriteComps10093 = nil
			end

			local var_263_15 = 0
			local var_263_16 = 0.275

			if var_263_15 < arg_260_1.time_ and arg_260_1.time_ <= var_263_15 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_17 = arg_260_1:FormatText(StoryNameCfg[28].name)

				arg_260_1.leftNameTxt_.text = var_263_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_18 = arg_260_1:GetWordFromCfg(413112061)
				local var_263_19 = arg_260_1:FormatText(var_263_18.content)

				arg_260_1.text_.text = var_263_19

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_20 = 11
				local var_263_21 = utf8.len(var_263_19)
				local var_263_22 = var_263_20 <= 0 and var_263_16 or var_263_16 * (var_263_21 / var_263_20)

				if var_263_22 > 0 and var_263_16 < var_263_22 then
					arg_260_1.talkMaxDuration = var_263_22

					if var_263_22 + var_263_15 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_22 + var_263_15
					end
				end

				arg_260_1.text_.text = var_263_19
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112061", "story_v_out_413112.awb") ~= 0 then
					local var_263_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112061", "story_v_out_413112.awb") / 1000

					if var_263_23 + var_263_15 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_23 + var_263_15
					end

					if var_263_18.prefab_name ~= "" and arg_260_1.actors_[var_263_18.prefab_name] ~= nil then
						local var_263_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_18.prefab_name].transform, "story_v_out_413112", "413112061", "story_v_out_413112.awb")

						arg_260_1:RecordAudio("413112061", var_263_24)
						arg_260_1:RecordAudio("413112061", var_263_24)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_413112", "413112061", "story_v_out_413112.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_413112", "413112061", "story_v_out_413112.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_25 = math.max(var_263_16, arg_260_1.talkMaxDuration)

			if var_263_15 <= arg_260_1.time_ and arg_260_1.time_ < var_263_15 + var_263_25 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_15) / var_263_25

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_15 + var_263_25 and arg_260_1.time_ < var_263_15 + var_263_25 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play413112062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 413112062
		arg_264_1.duration_ = 12.7

		local var_264_0 = {
			zh = 12.7,
			ja = 7.366
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play413112063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10093"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos10093 = var_267_0.localPosition
				var_267_0.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("10093", 3)

				local var_267_2 = var_267_0.childCount

				for iter_267_0 = 0, var_267_2 - 1 do
					local var_267_3 = var_267_0:GetChild(iter_267_0)

					if var_267_3.name == "" or not string.find(var_267_3.name, "split") then
						var_267_3.gameObject:SetActive(true)
					else
						var_267_3.gameObject:SetActive(false)
					end
				end
			end

			local var_267_4 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_4 then
				local var_267_5 = (arg_264_1.time_ - var_267_1) / var_267_4
				local var_267_6 = Vector3.New(0, -345, -245)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10093, var_267_6, var_267_5)
			end

			if arg_264_1.time_ >= var_267_1 + var_267_4 and arg_264_1.time_ < var_267_1 + var_267_4 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_267_7 = arg_264_1.actors_["10093"]
			local var_267_8 = 0

			if var_267_8 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 and not isNil(var_267_7) and arg_264_1.var_.actorSpriteComps10093 == nil then
				arg_264_1.var_.actorSpriteComps10093 = var_267_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_9 = 2

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_9 and not isNil(var_267_7) then
				local var_267_10 = (arg_264_1.time_ - var_267_8) / var_267_9

				if arg_264_1.var_.actorSpriteComps10093 then
					for iter_267_1, iter_267_2 in pairs(arg_264_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_267_2 then
							if arg_264_1.isInRecall_ then
								local var_267_11 = Mathf.Lerp(iter_267_2.color.r, arg_264_1.hightColor2.r, var_267_10)
								local var_267_12 = Mathf.Lerp(iter_267_2.color.g, arg_264_1.hightColor2.g, var_267_10)
								local var_267_13 = Mathf.Lerp(iter_267_2.color.b, arg_264_1.hightColor2.b, var_267_10)

								iter_267_2.color = Color.New(var_267_11, var_267_12, var_267_13)
							else
								local var_267_14 = Mathf.Lerp(iter_267_2.color.r, 0.5, var_267_10)

								iter_267_2.color = Color.New(var_267_14, var_267_14, var_267_14)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= var_267_8 + var_267_9 and arg_264_1.time_ < var_267_8 + var_267_9 + arg_267_0 and not isNil(var_267_7) and arg_264_1.var_.actorSpriteComps10093 then
				for iter_267_3, iter_267_4 in pairs(arg_264_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_267_4 then
						if arg_264_1.isInRecall_ then
							iter_267_4.color = arg_264_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_267_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_264_1.var_.actorSpriteComps10093 = nil
			end

			local var_267_15 = 0
			local var_267_16 = 0.45

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_17 = arg_264_1:FormatText(StoryNameCfg[36].name)

				arg_264_1.leftNameTxt_.text = var_267_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_18 = arg_264_1:GetWordFromCfg(413112062)
				local var_267_19 = arg_264_1:FormatText(var_267_18.content)

				arg_264_1.text_.text = var_267_19

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_20 = 18
				local var_267_21 = utf8.len(var_267_19)
				local var_267_22 = var_267_20 <= 0 and var_267_16 or var_267_16 * (var_267_21 / var_267_20)

				if var_267_22 > 0 and var_267_16 < var_267_22 then
					arg_264_1.talkMaxDuration = var_267_22

					if var_267_22 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_22 + var_267_15
					end
				end

				arg_264_1.text_.text = var_267_19
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112062", "story_v_out_413112.awb") ~= 0 then
					local var_267_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112062", "story_v_out_413112.awb") / 1000

					if var_267_23 + var_267_15 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_23 + var_267_15
					end

					if var_267_18.prefab_name ~= "" and arg_264_1.actors_[var_267_18.prefab_name] ~= nil then
						local var_267_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_18.prefab_name].transform, "story_v_out_413112", "413112062", "story_v_out_413112.awb")

						arg_264_1:RecordAudio("413112062", var_267_24)
						arg_264_1:RecordAudio("413112062", var_267_24)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_413112", "413112062", "story_v_out_413112.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_413112", "413112062", "story_v_out_413112.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_25 = math.max(var_267_16, arg_264_1.talkMaxDuration)

			if var_267_15 <= arg_264_1.time_ and arg_264_1.time_ < var_267_15 + var_267_25 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_15) / var_267_25

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_15 + var_267_25 and arg_264_1.time_ < var_267_15 + var_267_25 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play413112063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 413112063
		arg_268_1.duration_ = 7.67

		local var_268_0 = {
			zh = 7.666,
			ja = 5.066
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play413112064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["10093"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos10093 = var_271_0.localPosition
				var_271_0.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10093", 6)

				local var_271_2 = var_271_0.childCount

				for iter_271_0 = 0, var_271_2 - 1 do
					local var_271_3 = var_271_0:GetChild(iter_271_0)

					if var_271_3.name == "" or not string.find(var_271_3.name, "split") then
						var_271_3.gameObject:SetActive(true)
					else
						var_271_3.gameObject:SetActive(false)
					end
				end
			end

			local var_271_4 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_4 then
				local var_271_5 = (arg_268_1.time_ - var_271_1) / var_271_4
				local var_271_6 = Vector3.New(1500, -345, -245)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10093, var_271_6, var_271_5)
			end

			if arg_268_1.time_ >= var_271_1 + var_271_4 and arg_268_1.time_ < var_271_1 + var_271_4 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_271_7 = arg_268_1.actors_["10092_1"].transform
			local var_271_8 = 0

			if var_271_8 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.var_.moveOldPos10092_1 = var_271_7.localPosition
				var_271_7.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10092_1", 6)

				local var_271_9 = var_271_7.childCount

				for iter_271_1 = 0, var_271_9 - 1 do
					local var_271_10 = var_271_7:GetChild(iter_271_1)

					if var_271_10.name == "" or not string.find(var_271_10.name, "split") then
						var_271_10.gameObject:SetActive(true)
					else
						var_271_10.gameObject:SetActive(false)
					end
				end
			end

			local var_271_11 = 0.001

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_11 then
				local var_271_12 = (arg_268_1.time_ - var_271_8) / var_271_11
				local var_271_13 = Vector3.New(1500, -300, -295)

				var_271_7.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10092_1, var_271_13, var_271_12)
			end

			if arg_268_1.time_ >= var_271_8 + var_271_11 and arg_268_1.time_ < var_271_8 + var_271_11 + arg_271_0 then
				var_271_7.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_271_14 = arg_268_1.actors_["10093"]
			local var_271_15 = 0

			if var_271_15 < arg_268_1.time_ and arg_268_1.time_ <= var_271_15 + arg_271_0 and not isNil(var_271_14) and arg_268_1.var_.actorSpriteComps10093 == nil then
				arg_268_1.var_.actorSpriteComps10093 = var_271_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_16 = 2

			if var_271_15 <= arg_268_1.time_ and arg_268_1.time_ < var_271_15 + var_271_16 and not isNil(var_271_14) then
				local var_271_17 = (arg_268_1.time_ - var_271_15) / var_271_16

				if arg_268_1.var_.actorSpriteComps10093 then
					for iter_271_2, iter_271_3 in pairs(arg_268_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_271_3 then
							if arg_268_1.isInRecall_ then
								local var_271_18 = Mathf.Lerp(iter_271_3.color.r, arg_268_1.hightColor2.r, var_271_17)
								local var_271_19 = Mathf.Lerp(iter_271_3.color.g, arg_268_1.hightColor2.g, var_271_17)
								local var_271_20 = Mathf.Lerp(iter_271_3.color.b, arg_268_1.hightColor2.b, var_271_17)

								iter_271_3.color = Color.New(var_271_18, var_271_19, var_271_20)
							else
								local var_271_21 = Mathf.Lerp(iter_271_3.color.r, 0.5, var_271_17)

								iter_271_3.color = Color.New(var_271_21, var_271_21, var_271_21)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_15 + var_271_16 and arg_268_1.time_ < var_271_15 + var_271_16 + arg_271_0 and not isNil(var_271_14) and arg_268_1.var_.actorSpriteComps10093 then
				for iter_271_4, iter_271_5 in pairs(arg_268_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_271_5 then
						if arg_268_1.isInRecall_ then
							iter_271_5.color = arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_271_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps10093 = nil
			end

			local var_271_22 = arg_268_1.actors_["10092_1"]
			local var_271_23 = 0

			if var_271_23 < arg_268_1.time_ and arg_268_1.time_ <= var_271_23 + arg_271_0 and not isNil(var_271_22) and arg_268_1.var_.actorSpriteComps10092_1 == nil then
				arg_268_1.var_.actorSpriteComps10092_1 = var_271_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_24 = 2

			if var_271_23 <= arg_268_1.time_ and arg_268_1.time_ < var_271_23 + var_271_24 and not isNil(var_271_22) then
				local var_271_25 = (arg_268_1.time_ - var_271_23) / var_271_24

				if arg_268_1.var_.actorSpriteComps10092_1 then
					for iter_271_6, iter_271_7 in pairs(arg_268_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_271_7 then
							if arg_268_1.isInRecall_ then
								local var_271_26 = Mathf.Lerp(iter_271_7.color.r, arg_268_1.hightColor2.r, var_271_25)
								local var_271_27 = Mathf.Lerp(iter_271_7.color.g, arg_268_1.hightColor2.g, var_271_25)
								local var_271_28 = Mathf.Lerp(iter_271_7.color.b, arg_268_1.hightColor2.b, var_271_25)

								iter_271_7.color = Color.New(var_271_26, var_271_27, var_271_28)
							else
								local var_271_29 = Mathf.Lerp(iter_271_7.color.r, 0.5, var_271_25)

								iter_271_7.color = Color.New(var_271_29, var_271_29, var_271_29)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_23 + var_271_24 and arg_268_1.time_ < var_271_23 + var_271_24 + arg_271_0 and not isNil(var_271_22) and arg_268_1.var_.actorSpriteComps10092_1 then
				for iter_271_8, iter_271_9 in pairs(arg_268_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_271_9 then
						if arg_268_1.isInRecall_ then
							iter_271_9.color = arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_271_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_271_30 = manager.ui.mainCamera.transform
			local var_271_31 = 0

			if var_271_31 < arg_268_1.time_ and arg_268_1.time_ <= var_271_31 + arg_271_0 then
				arg_268_1.var_.shakeOldPos = var_271_30.localPosition
			end

			local var_271_32 = 0.6

			if var_271_31 <= arg_268_1.time_ and arg_268_1.time_ < var_271_31 + var_271_32 then
				local var_271_33 = (arg_268_1.time_ - var_271_31) / 0.066
				local var_271_34, var_271_35 = math.modf(var_271_33)

				var_271_30.localPosition = Vector3.New(var_271_35 * 0.13, var_271_35 * 0.13, var_271_35 * 0.13) + arg_268_1.var_.shakeOldPos
			end

			if arg_268_1.time_ >= var_271_31 + var_271_32 and arg_268_1.time_ < var_271_31 + var_271_32 + arg_271_0 then
				var_271_30.localPosition = arg_268_1.var_.shakeOldPos
			end

			local var_271_36 = 0

			if var_271_36 < arg_268_1.time_ and arg_268_1.time_ <= var_271_36 + arg_271_0 then
				arg_268_1.allBtn_.enabled = false
			end

			local var_271_37 = 0.6

			if arg_268_1.time_ >= var_271_36 + var_271_37 and arg_268_1.time_ < var_271_36 + var_271_37 + arg_271_0 then
				arg_268_1.allBtn_.enabled = true
			end

			local var_271_38 = 0
			local var_271_39 = 0.3

			if var_271_38 < arg_268_1.time_ and arg_268_1.time_ <= var_271_38 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_40 = arg_268_1:FormatText(StoryNameCfg[36].name)

				arg_268_1.leftNameTxt_.text = var_271_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_41 = arg_268_1:GetWordFromCfg(413112063)
				local var_271_42 = arg_268_1:FormatText(var_271_41.content)

				arg_268_1.text_.text = var_271_42

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_43 = 12
				local var_271_44 = utf8.len(var_271_42)
				local var_271_45 = var_271_43 <= 0 and var_271_39 or var_271_39 * (var_271_44 / var_271_43)

				if var_271_45 > 0 and var_271_39 < var_271_45 then
					arg_268_1.talkMaxDuration = var_271_45

					if var_271_45 + var_271_38 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_45 + var_271_38
					end
				end

				arg_268_1.text_.text = var_271_42
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112063", "story_v_out_413112.awb") ~= 0 then
					local var_271_46 = manager.audio:GetVoiceLength("story_v_out_413112", "413112063", "story_v_out_413112.awb") / 1000

					if var_271_46 + var_271_38 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_46 + var_271_38
					end

					if var_271_41.prefab_name ~= "" and arg_268_1.actors_[var_271_41.prefab_name] ~= nil then
						local var_271_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_41.prefab_name].transform, "story_v_out_413112", "413112063", "story_v_out_413112.awb")

						arg_268_1:RecordAudio("413112063", var_271_47)
						arg_268_1:RecordAudio("413112063", var_271_47)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_413112", "413112063", "story_v_out_413112.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_413112", "413112063", "story_v_out_413112.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_48 = math.max(var_271_39, arg_268_1.talkMaxDuration)

			if var_271_38 <= arg_268_1.time_ and arg_268_1.time_ < var_271_38 + var_271_48 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_38) / var_271_48

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_38 + var_271_48 and arg_268_1.time_ < var_271_38 + var_271_48 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play413112064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 413112064
		arg_272_1.duration_ = 5.87

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play413112065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.mask_.enabled = true
				arg_272_1.mask_.raycastTarget = true

				arg_272_1:SetGaussion(false)
			end

			local var_275_1 = 0.3

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_1 then
				local var_275_2 = (arg_272_1.time_ - var_275_0) / var_275_1
				local var_275_3 = Color.New(1, 1, 1)

				var_275_3.a = Mathf.Lerp(1, 0, var_275_2)
				arg_272_1.mask_.color = var_275_3
			end

			if arg_272_1.time_ >= var_275_0 + var_275_1 and arg_272_1.time_ < var_275_0 + var_275_1 + arg_275_0 then
				local var_275_4 = Color.New(1, 1, 1)
				local var_275_5 = 0

				arg_272_1.mask_.enabled = false
				var_275_4.a = var_275_5
				arg_272_1.mask_.color = var_275_4
			end

			local var_275_6 = 0.3

			if var_275_6 < arg_272_1.time_ and arg_272_1.time_ <= var_275_6 + arg_275_0 then
				arg_272_1.mask_.enabled = true
				arg_272_1.mask_.raycastTarget = true

				arg_272_1:SetGaussion(false)
			end

			local var_275_7 = 0.3

			if var_275_6 <= arg_272_1.time_ and arg_272_1.time_ < var_275_6 + var_275_7 then
				local var_275_8 = (arg_272_1.time_ - var_275_6) / var_275_7
				local var_275_9 = Color.New(1, 1, 1)

				var_275_9.a = Mathf.Lerp(1, 0, var_275_8)
				arg_272_1.mask_.color = var_275_9
			end

			if arg_272_1.time_ >= var_275_6 + var_275_7 and arg_272_1.time_ < var_275_6 + var_275_7 + arg_275_0 then
				local var_275_10 = Color.New(1, 1, 1)
				local var_275_11 = 0

				arg_272_1.mask_.enabled = false
				var_275_10.a = var_275_11
				arg_272_1.mask_.color = var_275_10
			end

			local var_275_12 = manager.ui.mainCamera.transform
			local var_275_13 = 0.3

			if var_275_13 < arg_272_1.time_ and arg_272_1.time_ <= var_275_13 + arg_275_0 then
				arg_272_1.var_.shakeOldPos = var_275_12.localPosition
			end

			local var_275_14 = 0.7

			if var_275_13 <= arg_272_1.time_ and arg_272_1.time_ < var_275_13 + var_275_14 then
				local var_275_15 = (arg_272_1.time_ - var_275_13) / 0.066
				local var_275_16, var_275_17 = math.modf(var_275_15)

				var_275_12.localPosition = Vector3.New(var_275_17 * 0.13, var_275_17 * 0.13, var_275_17 * 0.13) + arg_272_1.var_.shakeOldPos
			end

			if arg_272_1.time_ >= var_275_13 + var_275_14 and arg_272_1.time_ < var_275_13 + var_275_14 + arg_275_0 then
				var_275_12.localPosition = arg_272_1.var_.shakeOldPos
			end

			local var_275_18 = 0.3
			local var_275_19 = 1

			if var_275_18 < arg_272_1.time_ and arg_272_1.time_ <= var_275_18 + arg_275_0 then
				local var_275_20 = "play"
				local var_275_21 = "effect"

				arg_272_1:AudioAction(var_275_20, var_275_21, "se_story_135_01", "se_story_135_01_scream", "")
			end

			if arg_272_1.frameCnt_ <= 1 then
				arg_272_1.dialog_:SetActive(false)
			end

			local var_275_22 = 0.866666666666667
			local var_275_23 = 1.025

			if var_275_22 < arg_272_1.time_ and arg_272_1.time_ <= var_275_22 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0

				arg_272_1.dialog_:SetActive(true)

				arg_272_1.dialogCg_.alpha = 0

				local var_275_24 = LeanTween.value(arg_272_1.dialog_, 0, 1, 0.3)

				var_275_24:setOnUpdate(LuaHelper.FloatAction(function(arg_276_0)
					arg_272_1.dialogCg_.alpha = arg_276_0
				end))
				var_275_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_272_1.dialog_)
					var_275_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_272_1.duration_ = arg_272_1.duration_ + 0.3

				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_25 = arg_272_1:GetWordFromCfg(413112064)
				local var_275_26 = arg_272_1:FormatText(var_275_25.content)

				arg_272_1.text_.text = var_275_26

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_27 = 41
				local var_275_28 = utf8.len(var_275_26)
				local var_275_29 = var_275_27 <= 0 and var_275_23 or var_275_23 * (var_275_28 / var_275_27)

				if var_275_29 > 0 and var_275_23 < var_275_29 then
					arg_272_1.talkMaxDuration = var_275_29
					var_275_22 = var_275_22 + 0.3

					if var_275_29 + var_275_22 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_29 + var_275_22
					end
				end

				arg_272_1.text_.text = var_275_26
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_30 = var_275_22 + 0.3
			local var_275_31 = math.max(var_275_23, arg_272_1.talkMaxDuration)

			if var_275_30 <= arg_272_1.time_ and arg_272_1.time_ < var_275_30 + var_275_31 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_30) / var_275_31

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_30 + var_275_31 and arg_272_1.time_ < var_275_30 + var_275_31 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play413112065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 413112065
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play413112066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.175

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(413112065)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 47
				local var_281_5 = utf8.len(var_281_3)
				local var_281_6 = var_281_4 <= 0 and var_281_1 or var_281_1 * (var_281_5 / var_281_4)

				if var_281_6 > 0 and var_281_1 < var_281_6 then
					arg_278_1.talkMaxDuration = var_281_6

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_7 and arg_278_1.time_ < var_281_0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play413112066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 413112066
		arg_282_1.duration_ = 2.2

		local var_282_0 = {
			zh = 2.2,
			ja = 1.999999999999
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
				arg_282_0:Play413112067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10022"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos10022 = var_285_0.localPosition
				var_285_0.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("10022", 3)

				local var_285_2 = var_285_0.childCount

				for iter_285_0 = 0, var_285_2 - 1 do
					local var_285_3 = var_285_0:GetChild(iter_285_0)

					if var_285_3.name == "split_3" or not string.find(var_285_3.name, "split") then
						var_285_3.gameObject:SetActive(true)
					else
						var_285_3.gameObject:SetActive(false)
					end
				end
			end

			local var_285_4 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_4 then
				local var_285_5 = (arg_282_1.time_ - var_285_1) / var_285_4
				local var_285_6 = Vector3.New(0, -315, -320)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10022, var_285_6, var_285_5)
			end

			if arg_282_1.time_ >= var_285_1 + var_285_4 and arg_282_1.time_ < var_285_1 + var_285_4 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_285_7 = arg_282_1.actors_["10022"]
			local var_285_8 = 0

			if var_285_8 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 and not isNil(var_285_7) and arg_282_1.var_.actorSpriteComps10022 == nil then
				arg_282_1.var_.actorSpriteComps10022 = var_285_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_9 = 2

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_9 and not isNil(var_285_7) then
				local var_285_10 = (arg_282_1.time_ - var_285_8) / var_285_9

				if arg_282_1.var_.actorSpriteComps10022 then
					for iter_285_1, iter_285_2 in pairs(arg_282_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_285_2 then
							if arg_282_1.isInRecall_ then
								local var_285_11 = Mathf.Lerp(iter_285_2.color.r, arg_282_1.hightColor1.r, var_285_10)
								local var_285_12 = Mathf.Lerp(iter_285_2.color.g, arg_282_1.hightColor1.g, var_285_10)
								local var_285_13 = Mathf.Lerp(iter_285_2.color.b, arg_282_1.hightColor1.b, var_285_10)

								iter_285_2.color = Color.New(var_285_11, var_285_12, var_285_13)
							else
								local var_285_14 = Mathf.Lerp(iter_285_2.color.r, 1, var_285_10)

								iter_285_2.color = Color.New(var_285_14, var_285_14, var_285_14)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_8 + var_285_9 and arg_282_1.time_ < var_285_8 + var_285_9 + arg_285_0 and not isNil(var_285_7) and arg_282_1.var_.actorSpriteComps10022 then
				for iter_285_3, iter_285_4 in pairs(arg_282_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_285_4 then
						if arg_282_1.isInRecall_ then
							iter_285_4.color = arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_285_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps10022 = nil
			end

			local var_285_15 = 0
			local var_285_16 = 0.2

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_17 = arg_282_1:FormatText(StoryNameCfg[614].name)

				arg_282_1.leftNameTxt_.text = var_285_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_18 = arg_282_1:GetWordFromCfg(413112066)
				local var_285_19 = arg_282_1:FormatText(var_285_18.content)

				arg_282_1.text_.text = var_285_19

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_20 = 8
				local var_285_21 = utf8.len(var_285_19)
				local var_285_22 = var_285_20 <= 0 and var_285_16 or var_285_16 * (var_285_21 / var_285_20)

				if var_285_22 > 0 and var_285_16 < var_285_22 then
					arg_282_1.talkMaxDuration = var_285_22

					if var_285_22 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_22 + var_285_15
					end
				end

				arg_282_1.text_.text = var_285_19
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112066", "story_v_out_413112.awb") ~= 0 then
					local var_285_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112066", "story_v_out_413112.awb") / 1000

					if var_285_23 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_15
					end

					if var_285_18.prefab_name ~= "" and arg_282_1.actors_[var_285_18.prefab_name] ~= nil then
						local var_285_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_18.prefab_name].transform, "story_v_out_413112", "413112066", "story_v_out_413112.awb")

						arg_282_1:RecordAudio("413112066", var_285_24)
						arg_282_1:RecordAudio("413112066", var_285_24)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_413112", "413112066", "story_v_out_413112.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_413112", "413112066", "story_v_out_413112.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_25 = math.max(var_285_16, arg_282_1.talkMaxDuration)

			if var_285_15 <= arg_282_1.time_ and arg_282_1.time_ < var_285_15 + var_285_25 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_15) / var_285_25

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_15 + var_285_25 and arg_282_1.time_ < var_285_15 + var_285_25 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
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

		arg_282_1:InitPlayNodeList()
	end,
	Play413112067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 413112067
		arg_286_1.duration_ = 4.33

		local var_286_0 = {
			zh = 4.333,
			ja = 3.766
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play413112068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["10022"].transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.moveOldPos10022 = var_289_0.localPosition
				var_289_0.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10022", 3)

				local var_289_2 = var_289_0.childCount

				for iter_289_0 = 0, var_289_2 - 1 do
					local var_289_3 = var_289_0:GetChild(iter_289_0)

					if var_289_3.name == "split_2" or not string.find(var_289_3.name, "split") then
						var_289_3.gameObject:SetActive(true)
					else
						var_289_3.gameObject:SetActive(false)
					end
				end
			end

			local var_289_4 = 0.001

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_4 then
				local var_289_5 = (arg_286_1.time_ - var_289_1) / var_289_4
				local var_289_6 = Vector3.New(0, -315, -320)

				var_289_0.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10022, var_289_6, var_289_5)
			end

			if arg_286_1.time_ >= var_289_1 + var_289_4 and arg_286_1.time_ < var_289_1 + var_289_4 + arg_289_0 then
				var_289_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_289_7 = arg_286_1.actors_["10022"]
			local var_289_8 = 0

			if var_289_8 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 and not isNil(var_289_7) and arg_286_1.var_.actorSpriteComps10022 == nil then
				arg_286_1.var_.actorSpriteComps10022 = var_289_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_9 = 2

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_9 and not isNil(var_289_7) then
				local var_289_10 = (arg_286_1.time_ - var_289_8) / var_289_9

				if arg_286_1.var_.actorSpriteComps10022 then
					for iter_289_1, iter_289_2 in pairs(arg_286_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_289_2 then
							if arg_286_1.isInRecall_ then
								local var_289_11 = Mathf.Lerp(iter_289_2.color.r, arg_286_1.hightColor1.r, var_289_10)
								local var_289_12 = Mathf.Lerp(iter_289_2.color.g, arg_286_1.hightColor1.g, var_289_10)
								local var_289_13 = Mathf.Lerp(iter_289_2.color.b, arg_286_1.hightColor1.b, var_289_10)

								iter_289_2.color = Color.New(var_289_11, var_289_12, var_289_13)
							else
								local var_289_14 = Mathf.Lerp(iter_289_2.color.r, 1, var_289_10)

								iter_289_2.color = Color.New(var_289_14, var_289_14, var_289_14)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_8 + var_289_9 and arg_286_1.time_ < var_289_8 + var_289_9 + arg_289_0 and not isNil(var_289_7) and arg_286_1.var_.actorSpriteComps10022 then
				for iter_289_3, iter_289_4 in pairs(arg_286_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_289_4 then
						if arg_286_1.isInRecall_ then
							iter_289_4.color = arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_289_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps10022 = nil
			end

			local var_289_15 = 0
			local var_289_16 = 0.5

			if var_289_15 < arg_286_1.time_ and arg_286_1.time_ <= var_289_15 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_17 = arg_286_1:FormatText(StoryNameCfg[614].name)

				arg_286_1.leftNameTxt_.text = var_289_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_18 = arg_286_1:GetWordFromCfg(413112067)
				local var_289_19 = arg_286_1:FormatText(var_289_18.content)

				arg_286_1.text_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_20 = 20
				local var_289_21 = utf8.len(var_289_19)
				local var_289_22 = var_289_20 <= 0 and var_289_16 or var_289_16 * (var_289_21 / var_289_20)

				if var_289_22 > 0 and var_289_16 < var_289_22 then
					arg_286_1.talkMaxDuration = var_289_22

					if var_289_22 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_22 + var_289_15
					end
				end

				arg_286_1.text_.text = var_289_19
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112067", "story_v_out_413112.awb") ~= 0 then
					local var_289_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112067", "story_v_out_413112.awb") / 1000

					if var_289_23 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_23 + var_289_15
					end

					if var_289_18.prefab_name ~= "" and arg_286_1.actors_[var_289_18.prefab_name] ~= nil then
						local var_289_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_18.prefab_name].transform, "story_v_out_413112", "413112067", "story_v_out_413112.awb")

						arg_286_1:RecordAudio("413112067", var_289_24)
						arg_286_1:RecordAudio("413112067", var_289_24)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_413112", "413112067", "story_v_out_413112.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_413112", "413112067", "story_v_out_413112.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_25 = math.max(var_289_16, arg_286_1.talkMaxDuration)

			if var_289_15 <= arg_286_1.time_ and arg_286_1.time_ < var_289_15 + var_289_25 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_15) / var_289_25

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_15 + var_289_25 and arg_286_1.time_ < var_289_15 + var_289_25 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play413112068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 413112068
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play413112069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["10022"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos10022 = var_293_0.localPosition
				var_293_0.localScale = Vector3.New(1, 1, 1)

				arg_290_1:CheckSpriteTmpPos("10022", 6)

				local var_293_2 = var_293_0.childCount

				for iter_293_0 = 0, var_293_2 - 1 do
					local var_293_3 = var_293_0:GetChild(iter_293_0)

					if var_293_3.name == "" or not string.find(var_293_3.name, "split") then
						var_293_3.gameObject:SetActive(true)
					else
						var_293_3.gameObject:SetActive(false)
					end
				end
			end

			local var_293_4 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_4 then
				local var_293_5 = (arg_290_1.time_ - var_293_1) / var_293_4
				local var_293_6 = Vector3.New(1500, -315, -320)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10022, var_293_6, var_293_5)
			end

			if arg_290_1.time_ >= var_293_1 + var_293_4 and arg_290_1.time_ < var_293_1 + var_293_4 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(1500, -315, -320)
			end

			local var_293_7 = arg_290_1.actors_["10022"]
			local var_293_8 = 0

			if var_293_8 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 and not isNil(var_293_7) and arg_290_1.var_.actorSpriteComps10022 == nil then
				arg_290_1.var_.actorSpriteComps10022 = var_293_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_9 = 2

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_9 and not isNil(var_293_7) then
				local var_293_10 = (arg_290_1.time_ - var_293_8) / var_293_9

				if arg_290_1.var_.actorSpriteComps10022 then
					for iter_293_1, iter_293_2 in pairs(arg_290_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_293_2 then
							if arg_290_1.isInRecall_ then
								local var_293_11 = Mathf.Lerp(iter_293_2.color.r, arg_290_1.hightColor2.r, var_293_10)
								local var_293_12 = Mathf.Lerp(iter_293_2.color.g, arg_290_1.hightColor2.g, var_293_10)
								local var_293_13 = Mathf.Lerp(iter_293_2.color.b, arg_290_1.hightColor2.b, var_293_10)

								iter_293_2.color = Color.New(var_293_11, var_293_12, var_293_13)
							else
								local var_293_14 = Mathf.Lerp(iter_293_2.color.r, 0.5, var_293_10)

								iter_293_2.color = Color.New(var_293_14, var_293_14, var_293_14)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_8 + var_293_9 and arg_290_1.time_ < var_293_8 + var_293_9 + arg_293_0 and not isNil(var_293_7) and arg_290_1.var_.actorSpriteComps10022 then
				for iter_293_3, iter_293_4 in pairs(arg_290_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_293_4 then
						if arg_290_1.isInRecall_ then
							iter_293_4.color = arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_293_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps10022 = nil
			end

			local var_293_15 = 0
			local var_293_16 = 1.25

			if var_293_15 < arg_290_1.time_ and arg_290_1.time_ <= var_293_15 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_17 = arg_290_1:GetWordFromCfg(413112068)
				local var_293_18 = arg_290_1:FormatText(var_293_17.content)

				arg_290_1.text_.text = var_293_18

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_19 = 50
				local var_293_20 = utf8.len(var_293_18)
				local var_293_21 = var_293_19 <= 0 and var_293_16 or var_293_16 * (var_293_20 / var_293_19)

				if var_293_21 > 0 and var_293_16 < var_293_21 then
					arg_290_1.talkMaxDuration = var_293_21

					if var_293_21 + var_293_15 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_21 + var_293_15
					end
				end

				arg_290_1.text_.text = var_293_18
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_22 = math.max(var_293_16, arg_290_1.talkMaxDuration)

			if var_293_15 <= arg_290_1.time_ and arg_290_1.time_ < var_293_15 + var_293_22 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_15) / var_293_22

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_15 + var_293_22 and arg_290_1.time_ < var_293_15 + var_293_22 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
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

		arg_290_1:InitPlayNodeList()
	end,
	Play413112069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 413112069
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play413112070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 1.65

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_2 = arg_294_1:GetWordFromCfg(413112069)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 66
				local var_297_5 = utf8.len(var_297_3)
				local var_297_6 = var_297_4 <= 0 and var_297_1 or var_297_1 * (var_297_5 / var_297_4)

				if var_297_6 > 0 and var_297_1 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_7 and arg_294_1.time_ < var_297_0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play413112070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 413112070
		arg_298_1.duration_ = 6.23

		local var_298_0 = {
			zh = 6.233,
			ja = 2.8
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
				arg_298_0:Play413112071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["10092_1"].transform
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
				arg_298_1.var_.moveOldPos10092_1 = var_301_0.localPosition
				var_301_0.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("10092_1", 3)

				local var_301_2 = var_301_0.childCount

				for iter_301_0 = 0, var_301_2 - 1 do
					local var_301_3 = var_301_0:GetChild(iter_301_0)

					if var_301_3.name == "split_8" or not string.find(var_301_3.name, "split") then
						var_301_3.gameObject:SetActive(true)
					else
						var_301_3.gameObject:SetActive(false)
					end
				end
			end

			local var_301_4 = 0.001

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_4 then
				local var_301_5 = (arg_298_1.time_ - var_301_1) / var_301_4
				local var_301_6 = Vector3.New(0, -300, -295)

				var_301_0.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10092_1, var_301_6, var_301_5)
			end

			if arg_298_1.time_ >= var_301_1 + var_301_4 and arg_298_1.time_ < var_301_1 + var_301_4 + arg_301_0 then
				var_301_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_301_7 = arg_298_1.actors_["10092_1"]
			local var_301_8 = 0

			if var_301_8 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 and not isNil(var_301_7) and arg_298_1.var_.actorSpriteComps10092_1 == nil then
				arg_298_1.var_.actorSpriteComps10092_1 = var_301_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_9 = 2

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_9 and not isNil(var_301_7) then
				local var_301_10 = (arg_298_1.time_ - var_301_8) / var_301_9

				if arg_298_1.var_.actorSpriteComps10092_1 then
					for iter_301_1, iter_301_2 in pairs(arg_298_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_301_2 then
							if arg_298_1.isInRecall_ then
								local var_301_11 = Mathf.Lerp(iter_301_2.color.r, arg_298_1.hightColor1.r, var_301_10)
								local var_301_12 = Mathf.Lerp(iter_301_2.color.g, arg_298_1.hightColor1.g, var_301_10)
								local var_301_13 = Mathf.Lerp(iter_301_2.color.b, arg_298_1.hightColor1.b, var_301_10)

								iter_301_2.color = Color.New(var_301_11, var_301_12, var_301_13)
							else
								local var_301_14 = Mathf.Lerp(iter_301_2.color.r, 1, var_301_10)

								iter_301_2.color = Color.New(var_301_14, var_301_14, var_301_14)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_8 + var_301_9 and arg_298_1.time_ < var_301_8 + var_301_9 + arg_301_0 and not isNil(var_301_7) and arg_298_1.var_.actorSpriteComps10092_1 then
				for iter_301_3, iter_301_4 in pairs(arg_298_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_301_4 then
						if arg_298_1.isInRecall_ then
							iter_301_4.color = arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_301_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_301_15 = 0
			local var_301_16 = 0.35

			if var_301_15 < arg_298_1.time_ and arg_298_1.time_ <= var_301_15 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_17 = arg_298_1:FormatText(StoryNameCfg[996].name)

				arg_298_1.leftNameTxt_.text = var_301_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_18 = arg_298_1:GetWordFromCfg(413112070)
				local var_301_19 = arg_298_1:FormatText(var_301_18.content)

				arg_298_1.text_.text = var_301_19

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112070", "story_v_out_413112.awb") ~= 0 then
					local var_301_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112070", "story_v_out_413112.awb") / 1000

					if var_301_23 + var_301_15 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_23 + var_301_15
					end

					if var_301_18.prefab_name ~= "" and arg_298_1.actors_[var_301_18.prefab_name] ~= nil then
						local var_301_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_18.prefab_name].transform, "story_v_out_413112", "413112070", "story_v_out_413112.awb")

						arg_298_1:RecordAudio("413112070", var_301_24)
						arg_298_1:RecordAudio("413112070", var_301_24)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_413112", "413112070", "story_v_out_413112.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_413112", "413112070", "story_v_out_413112.awb")
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
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play413112071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 413112071
		arg_302_1.duration_ = 8.83

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play413112072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = "SS1308"

			if arg_302_1.bgs_[var_305_0] == nil then
				local var_305_1 = Object.Instantiate(arg_302_1.paintGo_)

				var_305_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_305_0)
				var_305_1.name = var_305_0
				var_305_1.transform.parent = arg_302_1.stage_.transform
				var_305_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.bgs_[var_305_0] = var_305_1
			end

			local var_305_2 = 1.966

			if var_305_2 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				local var_305_3 = manager.ui.mainCamera.transform.localPosition
				local var_305_4 = Vector3.New(0, 0, 10) + Vector3.New(var_305_3.x, var_305_3.y, 0)
				local var_305_5 = arg_302_1.bgs_.SS1308

				var_305_5.transform.localPosition = var_305_4
				var_305_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_305_6 = var_305_5:GetComponent("SpriteRenderer")

				if var_305_6 and var_305_6.sprite then
					local var_305_7 = (var_305_5.transform.localPosition - var_305_3).z
					local var_305_8 = manager.ui.mainCameraCom_
					local var_305_9 = 2 * var_305_7 * Mathf.Tan(var_305_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_305_10 = var_305_9 * var_305_8.aspect
					local var_305_11 = var_305_6.sprite.bounds.size.x
					local var_305_12 = var_305_6.sprite.bounds.size.y
					local var_305_13 = var_305_10 / var_305_11
					local var_305_14 = var_305_9 / var_305_12
					local var_305_15 = var_305_14 < var_305_13 and var_305_13 or var_305_14

					var_305_5.transform.localScale = Vector3.New(var_305_15, var_305_15, 0)
				end

				for iter_305_0, iter_305_1 in pairs(arg_302_1.bgs_) do
					if iter_305_0 ~= "SS1308" then
						iter_305_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_305_16 = 3.83333333333333

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			local var_305_17 = 0.3

			if arg_302_1.time_ >= var_305_16 + var_305_17 and arg_302_1.time_ < var_305_16 + var_305_17 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end

			local var_305_18 = 0

			if var_305_18 < arg_302_1.time_ and arg_302_1.time_ <= var_305_18 + arg_305_0 then
				arg_302_1.mask_.enabled = true
				arg_302_1.mask_.raycastTarget = true

				arg_302_1:SetGaussion(false)
			end

			local var_305_19 = 2

			if var_305_18 <= arg_302_1.time_ and arg_302_1.time_ < var_305_18 + var_305_19 then
				local var_305_20 = (arg_302_1.time_ - var_305_18) / var_305_19
				local var_305_21 = Color.New(0, 0, 0)

				var_305_21.a = Mathf.Lerp(0, 1, var_305_20)
				arg_302_1.mask_.color = var_305_21
			end

			if arg_302_1.time_ >= var_305_18 + var_305_19 and arg_302_1.time_ < var_305_18 + var_305_19 + arg_305_0 then
				local var_305_22 = Color.New(0, 0, 0)

				var_305_22.a = 1
				arg_302_1.mask_.color = var_305_22
			end

			local var_305_23 = 2

			if var_305_23 < arg_302_1.time_ and arg_302_1.time_ <= var_305_23 + arg_305_0 then
				arg_302_1.mask_.enabled = true
				arg_302_1.mask_.raycastTarget = true

				arg_302_1:SetGaussion(false)
			end

			local var_305_24 = 2

			if var_305_23 <= arg_302_1.time_ and arg_302_1.time_ < var_305_23 + var_305_24 then
				local var_305_25 = (arg_302_1.time_ - var_305_23) / var_305_24
				local var_305_26 = Color.New(0, 0, 0)

				var_305_26.a = Mathf.Lerp(1, 0, var_305_25)
				arg_302_1.mask_.color = var_305_26
			end

			if arg_302_1.time_ >= var_305_23 + var_305_24 and arg_302_1.time_ < var_305_23 + var_305_24 + arg_305_0 then
				local var_305_27 = Color.New(0, 0, 0)
				local var_305_28 = 0

				arg_302_1.mask_.enabled = false
				var_305_27.a = var_305_28
				arg_302_1.mask_.color = var_305_27
			end

			local var_305_29 = arg_302_1.actors_["10092_1"].transform
			local var_305_30 = 2

			if var_305_30 < arg_302_1.time_ and arg_302_1.time_ <= var_305_30 + arg_305_0 then
				arg_302_1.var_.moveOldPos10092_1 = var_305_29.localPosition
				var_305_29.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("10092_1", 6)

				local var_305_31 = var_305_29.childCount

				for iter_305_2 = 0, var_305_31 - 1 do
					local var_305_32 = var_305_29:GetChild(iter_305_2)

					if var_305_32.name == "" or not string.find(var_305_32.name, "split") then
						var_305_32.gameObject:SetActive(true)
					else
						var_305_32.gameObject:SetActive(false)
					end
				end
			end

			local var_305_33 = 0.001

			if var_305_30 <= arg_302_1.time_ and arg_302_1.time_ < var_305_30 + var_305_33 then
				local var_305_34 = (arg_302_1.time_ - var_305_30) / var_305_33
				local var_305_35 = Vector3.New(1500, -300, -295)

				var_305_29.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10092_1, var_305_35, var_305_34)
			end

			if arg_302_1.time_ >= var_305_30 + var_305_33 and arg_302_1.time_ < var_305_30 + var_305_33 + arg_305_0 then
				var_305_29.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_305_36 = arg_302_1.bgs_.SS1308.transform
			local var_305_37 = 2

			if var_305_37 < arg_302_1.time_ and arg_302_1.time_ <= var_305_37 + arg_305_0 then
				arg_302_1.var_.moveOldPosSS1308 = var_305_36.localPosition
			end

			local var_305_38 = 0.001

			if var_305_37 <= arg_302_1.time_ and arg_302_1.time_ < var_305_37 + var_305_38 then
				local var_305_39 = (arg_302_1.time_ - var_305_37) / var_305_38
				local var_305_40 = Vector3.New(0, -0.5, 0)

				var_305_36.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPosSS1308, var_305_40, var_305_39)
			end

			if arg_302_1.time_ >= var_305_37 + var_305_38 and arg_302_1.time_ < var_305_37 + var_305_38 + arg_305_0 then
				var_305_36.localPosition = Vector3.New(0, -0.5, 0)
			end

			local var_305_41 = arg_302_1.bgs_.SS1308.transform
			local var_305_42 = 2.034

			if var_305_42 < arg_302_1.time_ and arg_302_1.time_ <= var_305_42 + arg_305_0 then
				arg_302_1.var_.moveOldPosSS1308 = var_305_41.localPosition
			end

			local var_305_43 = 6

			if var_305_42 <= arg_302_1.time_ and arg_302_1.time_ < var_305_42 + var_305_43 then
				local var_305_44 = (arg_302_1.time_ - var_305_42) / var_305_43
				local var_305_45 = Vector3.New(0, -0.5, -0.5)

				var_305_41.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPosSS1308, var_305_45, var_305_44)
			end

			if arg_302_1.time_ >= var_305_42 + var_305_43 and arg_302_1.time_ < var_305_42 + var_305_43 + arg_305_0 then
				var_305_41.localPosition = Vector3.New(0, -0.5, -0.5)
			end

			local var_305_46 = 4

			if var_305_46 < arg_302_1.time_ and arg_302_1.time_ <= var_305_46 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			local var_305_47 = 4.034

			if arg_302_1.time_ >= var_305_46 + var_305_47 and arg_302_1.time_ < var_305_46 + var_305_47 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end

			if arg_302_1.frameCnt_ <= 1 then
				arg_302_1.dialog_:SetActive(false)
			end

			local var_305_48 = 3.83333333333333
			local var_305_49 = 1.45

			if var_305_48 < arg_302_1.time_ and arg_302_1.time_ <= var_305_48 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				arg_302_1.dialog_:SetActive(true)

				arg_302_1.dialogCg_.alpha = 0

				local var_305_50 = LeanTween.value(arg_302_1.dialog_, 0, 1, 0.3)

				var_305_50:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_302_1.dialogCg_.alpha = arg_306_0
				end))
				var_305_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_302_1.dialog_)
					var_305_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_302_1.duration_ = arg_302_1.duration_ + 0.3

				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_51 = arg_302_1:GetWordFromCfg(413112071)
				local var_305_52 = arg_302_1:FormatText(var_305_51.content)

				arg_302_1.text_.text = var_305_52

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_53 = 58
				local var_305_54 = utf8.len(var_305_52)
				local var_305_55 = var_305_53 <= 0 and var_305_49 or var_305_49 * (var_305_54 / var_305_53)

				if var_305_55 > 0 and var_305_49 < var_305_55 then
					arg_302_1.talkMaxDuration = var_305_55
					var_305_48 = var_305_48 + 0.3

					if var_305_55 + var_305_48 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_55 + var_305_48
					end
				end

				arg_302_1.text_.text = var_305_52
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_56 = var_305_48 + 0.3
			local var_305_57 = math.max(var_305_49, arg_302_1.talkMaxDuration)

			if var_305_56 <= arg_302_1.time_ and arg_302_1.time_ < var_305_56 + var_305_57 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_56) / var_305_57

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_56 + var_305_57 and arg_302_1.time_ < var_305_56 + var_305_57 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1308",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1308",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play413112072 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 413112072
		arg_308_1.duration_ = 11.6

		local var_308_0 = {
			zh = 11.6,
			ja = 7.966
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play413112073(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.3

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_2 = arg_308_1:FormatText(StoryNameCfg[1001].name)

				arg_308_1.leftNameTxt_.text = var_311_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_4")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_3 = arg_308_1:GetWordFromCfg(413112072)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 12
				local var_311_6 = utf8.len(var_311_4)
				local var_311_7 = var_311_5 <= 0 and var_311_1 or var_311_1 * (var_311_6 / var_311_5)

				if var_311_7 > 0 and var_311_1 < var_311_7 then
					arg_308_1.talkMaxDuration = var_311_7

					if var_311_7 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112072", "story_v_out_413112.awb") ~= 0 then
					local var_311_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112072", "story_v_out_413112.awb") / 1000

					if var_311_8 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_8 + var_311_0
					end

					if var_311_3.prefab_name ~= "" and arg_308_1.actors_[var_311_3.prefab_name] ~= nil then
						local var_311_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_3.prefab_name].transform, "story_v_out_413112", "413112072", "story_v_out_413112.awb")

						arg_308_1:RecordAudio("413112072", var_311_9)
						arg_308_1:RecordAudio("413112072", var_311_9)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_413112", "413112072", "story_v_out_413112.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_413112", "413112072", "story_v_out_413112.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_10 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_10 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_10

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_10 and arg_308_1.time_ < var_311_0 + var_311_10 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play413112073 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 413112073
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play413112074(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 1

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_2 = arg_312_1:GetWordFromCfg(413112073)
				local var_315_3 = arg_312_1:FormatText(var_315_2.content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 40
				local var_315_5 = utf8.len(var_315_3)
				local var_315_6 = var_315_4 <= 0 and var_315_1 or var_315_1 * (var_315_5 / var_315_4)

				if var_315_6 > 0 and var_315_1 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_7 and arg_312_1.time_ < var_315_0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play413112074 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 413112074
		arg_316_1.duration_ = 15.97

		local var_316_0 = {
			zh = 12.166,
			ja = 15.966
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play413112075(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.4

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[1001].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_4")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(413112074)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 16
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112074", "story_v_out_413112.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112074", "story_v_out_413112.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_413112", "413112074", "story_v_out_413112.awb")

						arg_316_1:RecordAudio("413112074", var_319_9)
						arg_316_1:RecordAudio("413112074", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_413112", "413112074", "story_v_out_413112.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_413112", "413112074", "story_v_out_413112.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play413112075 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 413112075
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play413112076(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 1.125

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_2 = arg_320_1:GetWordFromCfg(413112075)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 45
				local var_323_5 = utf8.len(var_323_3)
				local var_323_6 = var_323_4 <= 0 and var_323_1 or var_323_1 * (var_323_5 / var_323_4)

				if var_323_6 > 0 and var_323_1 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_3
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_7 and arg_320_1.time_ < var_323_0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play413112076 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 413112076
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play413112077(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 1.275

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_2 = arg_324_1:GetWordFromCfg(413112076)
				local var_327_3 = arg_324_1:FormatText(var_327_2.content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 51
				local var_327_5 = utf8.len(var_327_3)
				local var_327_6 = var_327_4 <= 0 and var_327_1 or var_327_1 * (var_327_5 / var_327_4)

				if var_327_6 > 0 and var_327_1 < var_327_6 then
					arg_324_1.talkMaxDuration = var_327_6

					if var_327_6 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_6 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_7 and arg_324_1.time_ < var_327_0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play413112077 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 413112077
		arg_328_1.duration_ = 12.73

		local var_328_0 = {
			zh = 12.733,
			ja = 11.233
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
				arg_328_0:Play413112078(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.45

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[1001].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_4")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(413112077)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 18
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112077", "story_v_out_413112.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112077", "story_v_out_413112.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_413112", "413112077", "story_v_out_413112.awb")

						arg_328_1:RecordAudio("413112077", var_331_9)
						arg_328_1:RecordAudio("413112077", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_413112", "413112077", "story_v_out_413112.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_413112", "413112077", "story_v_out_413112.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play413112078 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 413112078
		arg_332_1.duration_ = 7.3

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play413112079(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.bgs_.SS1308.transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPosSS1308 = var_335_0.localPosition
			end

			local var_335_2 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2
				local var_335_4 = Vector3.New(0, 0.99, 7.94)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPosSS1308, var_335_4, var_335_3)
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, 0.99, 7.94)
			end

			local var_335_5 = arg_332_1.bgs_.SS1308.transform
			local var_335_6 = 0.034

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.var_.moveOldPosSS1308 = var_335_5.localPosition
			end

			local var_335_7 = 2.47469050063193

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_7 then
				local var_335_8 = (arg_332_1.time_ - var_335_6) / var_335_7
				local var_335_9 = Vector3.New(0, 1, 10)

				var_335_5.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPosSS1308, var_335_9, var_335_8)
			end

			if arg_332_1.time_ >= var_335_6 + var_335_7 and arg_332_1.time_ < var_335_6 + var_335_7 + arg_335_0 then
				var_335_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_335_10 = 0

			if var_335_10 < arg_332_1.time_ and arg_332_1.time_ <= var_335_10 + arg_335_0 then
				arg_332_1.allBtn_.enabled = false
			end

			local var_335_11 = 2.50869050063193

			if arg_332_1.time_ >= var_335_10 + var_335_11 and arg_332_1.time_ < var_335_10 + var_335_11 + arg_335_0 then
				arg_332_1.allBtn_.enabled = true
			end

			local var_335_12 = manager.ui.mainCamera.transform
			local var_335_13 = 0

			if var_335_13 < arg_332_1.time_ and arg_332_1.time_ <= var_335_13 + arg_335_0 then
				local var_335_14 = arg_332_1.var_.effectjianjiao1
				local var_335_15
				local var_335_16 = var_335_12

				if not var_335_14 then
					var_335_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_335_16)
					var_335_14.name = "jianjiao1"
					arg_332_1.var_.effectjianjiao1 = var_335_14
				else
					var_335_14.transform:SetParent(var_335_16)
				end

				var_335_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_335_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_335_17 = manager.ui.mainCamera.transform
			local var_335_18 = 1

			if var_335_18 < arg_332_1.time_ and arg_332_1.time_ <= var_335_18 + arg_335_0 then
				local var_335_19 = arg_332_1.var_.effectjianjiao1

				if var_335_19 then
					Object.Destroy(var_335_19)

					arg_332_1.var_.effectjianjiao1 = nil
				end
			end

			if arg_332_1.frameCnt_ <= 1 then
				arg_332_1.dialog_:SetActive(false)
			end

			local var_335_20 = 2.3
			local var_335_21 = 1.475

			if var_335_20 < arg_332_1.time_ and arg_332_1.time_ <= var_335_20 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0

				arg_332_1.dialog_:SetActive(true)

				arg_332_1.dialogCg_.alpha = 0

				local var_335_22 = LeanTween.value(arg_332_1.dialog_, 0, 1, 0.3)

				var_335_22:setOnUpdate(LuaHelper.FloatAction(function(arg_336_0)
					arg_332_1.dialogCg_.alpha = arg_336_0
				end))
				var_335_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_332_1.dialog_)
					var_335_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_332_1.duration_ = arg_332_1.duration_ + 0.3

				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_23 = arg_332_1:GetWordFromCfg(413112078)
				local var_335_24 = arg_332_1:FormatText(var_335_23.content)

				arg_332_1.text_.text = var_335_24

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_25 = 59
				local var_335_26 = utf8.len(var_335_24)
				local var_335_27 = var_335_25 <= 0 and var_335_21 or var_335_21 * (var_335_26 / var_335_25)

				if var_335_27 > 0 and var_335_21 < var_335_27 then
					arg_332_1.talkMaxDuration = var_335_27
					var_335_20 = var_335_20 + 0.3

					if var_335_27 + var_335_20 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_27 + var_335_20
					end
				end

				arg_332_1.text_.text = var_335_24
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_28 = var_335_20 + 0.3
			local var_335_29 = math.max(var_335_21, arg_332_1.talkMaxDuration)

			if var_335_28 <= arg_332_1.time_ and arg_332_1.time_ < var_335_28 + var_335_29 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_28) / var_335_29

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_28 + var_335_29 and arg_332_1.time_ < var_335_28 + var_335_29 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1308",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1308",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.47469050063193,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play413112079 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 413112079
		arg_338_1.duration_ = 6.23

		local var_338_0 = {
			zh = 6.233,
			ja = 5.3
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play413112080(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0
			local var_341_1 = 0.2

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_2 = arg_338_1:FormatText(StoryNameCfg[1001].name)

				arg_338_1.leftNameTxt_.text = var_341_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_4")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_3 = arg_338_1:GetWordFromCfg(413112079)
				local var_341_4 = arg_338_1:FormatText(var_341_3.content)

				arg_338_1.text_.text = var_341_4

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 8
				local var_341_6 = utf8.len(var_341_4)
				local var_341_7 = var_341_5 <= 0 and var_341_1 or var_341_1 * (var_341_6 / var_341_5)

				if var_341_7 > 0 and var_341_1 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_0
					end
				end

				arg_338_1.text_.text = var_341_4
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112079", "story_v_out_413112.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112079", "story_v_out_413112.awb") / 1000

					if var_341_8 + var_341_0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_0
					end

					if var_341_3.prefab_name ~= "" and arg_338_1.actors_[var_341_3.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_3.prefab_name].transform, "story_v_out_413112", "413112079", "story_v_out_413112.awb")

						arg_338_1:RecordAudio("413112079", var_341_9)
						arg_338_1:RecordAudio("413112079", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_413112", "413112079", "story_v_out_413112.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_413112", "413112079", "story_v_out_413112.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_1, arg_338_1.talkMaxDuration)

			if var_341_0 <= arg_338_1.time_ and arg_338_1.time_ < var_341_0 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_0) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_0 + var_341_10 and arg_338_1.time_ < var_341_0 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play413112080 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 413112080
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play413112081(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 1.425

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_2 = arg_342_1:GetWordFromCfg(413112080)
				local var_345_3 = arg_342_1:FormatText(var_345_2.content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 57
				local var_345_5 = utf8.len(var_345_3)
				local var_345_6 = var_345_4 <= 0 and var_345_1 or var_345_1 * (var_345_5 / var_345_4)

				if var_345_6 > 0 and var_345_1 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_7 and arg_342_1.time_ < var_345_0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play413112081 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 413112081
		arg_346_1.duration_ = 15.43

		local var_346_0 = {
			zh = 15.433,
			ja = 13.866
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play413112082(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.5

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[1001].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_2")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(413112081)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 20
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112081", "story_v_out_413112.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112081", "story_v_out_413112.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_out_413112", "413112081", "story_v_out_413112.awb")

						arg_346_1:RecordAudio("413112081", var_349_9)
						arg_346_1:RecordAudio("413112081", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_413112", "413112081", "story_v_out_413112.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_413112", "413112081", "story_v_out_413112.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_10 and arg_346_1.time_ < var_349_0 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play413112082 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 413112082
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play413112083(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 1.2

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_2 = arg_350_1:GetWordFromCfg(413112082)
				local var_353_3 = arg_350_1:FormatText(var_353_2.content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_4 = 48
				local var_353_5 = utf8.len(var_353_3)
				local var_353_6 = var_353_4 <= 0 and var_353_1 or var_353_1 * (var_353_5 / var_353_4)

				if var_353_6 > 0 and var_353_1 < var_353_6 then
					arg_350_1.talkMaxDuration = var_353_6

					if var_353_6 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_6 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_7 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_7 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_7

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_7 and arg_350_1.time_ < var_353_0 + var_353_7 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play413112083 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 413112083
		arg_354_1.duration_ = 4.63

		local var_354_0 = {
			zh = 2.033,
			ja = 4.633
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play413112084(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = manager.ui.mainCamera.transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.shakeOldPos = var_357_0.localPosition
			end

			local var_357_2 = 0.5

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / 0.066
				local var_357_4, var_357_5 = math.modf(var_357_3)

				var_357_0.localPosition = Vector3.New(var_357_5 * 0.13, var_357_5 * 0.13, var_357_5 * 0.13) + arg_354_1.var_.shakeOldPos
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 then
				var_357_0.localPosition = arg_354_1.var_.shakeOldPos
			end

			local var_357_6 = 0

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			local var_357_7 = 0.5

			if arg_354_1.time_ >= var_357_6 + var_357_7 and arg_354_1.time_ < var_357_6 + var_357_7 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_8 = 0.5
			local var_357_9 = 0.1

			if var_357_8 < arg_354_1.time_ and arg_354_1.time_ <= var_357_8 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_10 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_10:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_354_1.dialogCg_.alpha = arg_358_0
				end))
				var_357_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_11 = arg_354_1:FormatText(StoryNameCfg[996].name)

				arg_354_1.leftNameTxt_.text = var_357_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_1_split_3")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_12 = arg_354_1:GetWordFromCfg(413112083)
				local var_357_13 = arg_354_1:FormatText(var_357_12.content)

				arg_354_1.text_.text = var_357_13

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_14 = 4
				local var_357_15 = utf8.len(var_357_13)
				local var_357_16 = var_357_14 <= 0 and var_357_9 or var_357_9 * (var_357_15 / var_357_14)

				if var_357_16 > 0 and var_357_9 < var_357_16 then
					arg_354_1.talkMaxDuration = var_357_16
					var_357_8 = var_357_8 + 0.3

					if var_357_16 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_16 + var_357_8
					end
				end

				arg_354_1.text_.text = var_357_13
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112083", "story_v_out_413112.awb") ~= 0 then
					local var_357_17 = manager.audio:GetVoiceLength("story_v_out_413112", "413112083", "story_v_out_413112.awb") / 1000

					if var_357_17 + var_357_8 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_17 + var_357_8
					end

					if var_357_12.prefab_name ~= "" and arg_354_1.actors_[var_357_12.prefab_name] ~= nil then
						local var_357_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_12.prefab_name].transform, "story_v_out_413112", "413112083", "story_v_out_413112.awb")

						arg_354_1:RecordAudio("413112083", var_357_18)
						arg_354_1:RecordAudio("413112083", var_357_18)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_413112", "413112083", "story_v_out_413112.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_413112", "413112083", "story_v_out_413112.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_19 = var_357_8 + 0.3
			local var_357_20 = math.max(var_357_9, arg_354_1.talkMaxDuration)

			if var_357_19 <= arg_354_1.time_ and arg_354_1.time_ < var_357_19 + var_357_20 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_19) / var_357_20

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_19 + var_357_20 and arg_354_1.time_ < var_357_19 + var_357_20 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play413112084 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 413112084
		arg_360_1.duration_ = 2.27

		local var_360_0 = {
			zh = 1.4,
			ja = 2.266
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
				arg_360_0:Play413112085(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.175

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_2 = arg_360_1:FormatText(StoryNameCfg[28].name)

				arg_360_1.leftNameTxt_.text = var_363_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_3")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(413112084)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 7
				local var_363_6 = utf8.len(var_363_4)
				local var_363_7 = var_363_5 <= 0 and var_363_1 or var_363_1 * (var_363_6 / var_363_5)

				if var_363_7 > 0 and var_363_1 < var_363_7 then
					arg_360_1.talkMaxDuration = var_363_7

					if var_363_7 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112084", "story_v_out_413112.awb") ~= 0 then
					local var_363_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112084", "story_v_out_413112.awb") / 1000

					if var_363_8 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_0
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_413112", "413112084", "story_v_out_413112.awb")

						arg_360_1:RecordAudio("413112084", var_363_9)
						arg_360_1:RecordAudio("413112084", var_363_9)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_413112", "413112084", "story_v_out_413112.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_413112", "413112084", "story_v_out_413112.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_10 and arg_360_1.time_ < var_363_0 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play413112085 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 413112085
		arg_364_1.duration_ = 5.27

		local var_364_0 = {
			zh = 5.266,
			ja = 5
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
				arg_364_0:Play413112086(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.4

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[996].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_1_split_3")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(413112085)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 16
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112085", "story_v_out_413112.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_413112", "413112085", "story_v_out_413112.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_413112", "413112085", "story_v_out_413112.awb")

						arg_364_1:RecordAudio("413112085", var_367_9)
						arg_364_1:RecordAudio("413112085", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_413112", "413112085", "story_v_out_413112.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_413112", "413112085", "story_v_out_413112.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play413112086 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 413112086
		arg_368_1.duration_ = 5.93

		local var_368_0 = {
			zh = 5.933,
			ja = 5.766
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
				arg_368_0:Play413112087(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 2

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				local var_371_1 = manager.ui.mainCamera.transform.localPosition
				local var_371_2 = Vector3.New(0, 0, 10) + Vector3.New(var_371_1.x, var_371_1.y, 0)
				local var_371_3 = arg_368_1.bgs_.F10g

				var_371_3.transform.localPosition = var_371_2
				var_371_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_371_4 = var_371_3:GetComponent("SpriteRenderer")

				if var_371_4 and var_371_4.sprite then
					local var_371_5 = (var_371_3.transform.localPosition - var_371_1).z
					local var_371_6 = manager.ui.mainCameraCom_
					local var_371_7 = 2 * var_371_5 * Mathf.Tan(var_371_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_371_8 = var_371_7 * var_371_6.aspect
					local var_371_9 = var_371_4.sprite.bounds.size.x
					local var_371_10 = var_371_4.sprite.bounds.size.y
					local var_371_11 = var_371_8 / var_371_9
					local var_371_12 = var_371_7 / var_371_10
					local var_371_13 = var_371_12 < var_371_11 and var_371_11 or var_371_12

					var_371_3.transform.localScale = Vector3.New(var_371_13, var_371_13, 0)
				end

				for iter_371_0, iter_371_1 in pairs(arg_368_1.bgs_) do
					if iter_371_0 ~= "F10g" then
						iter_371_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_371_14 = 4

			if var_371_14 < arg_368_1.time_ and arg_368_1.time_ <= var_371_14 + arg_371_0 then
				arg_368_1.allBtn_.enabled = false
			end

			local var_371_15 = 0.3

			if arg_368_1.time_ >= var_371_14 + var_371_15 and arg_368_1.time_ < var_371_14 + var_371_15 + arg_371_0 then
				arg_368_1.allBtn_.enabled = true
			end

			local var_371_16 = 0

			if var_371_16 < arg_368_1.time_ and arg_368_1.time_ <= var_371_16 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_17 = 2

			if var_371_16 <= arg_368_1.time_ and arg_368_1.time_ < var_371_16 + var_371_17 then
				local var_371_18 = (arg_368_1.time_ - var_371_16) / var_371_17
				local var_371_19 = Color.New(0, 0, 0)

				var_371_19.a = Mathf.Lerp(0, 1, var_371_18)
				arg_368_1.mask_.color = var_371_19
			end

			if arg_368_1.time_ >= var_371_16 + var_371_17 and arg_368_1.time_ < var_371_16 + var_371_17 + arg_371_0 then
				local var_371_20 = Color.New(0, 0, 0)

				var_371_20.a = 1
				arg_368_1.mask_.color = var_371_20
			end

			local var_371_21 = 2

			if var_371_21 < arg_368_1.time_ and arg_368_1.time_ <= var_371_21 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_22 = 2

			if var_371_21 <= arg_368_1.time_ and arg_368_1.time_ < var_371_21 + var_371_22 then
				local var_371_23 = (arg_368_1.time_ - var_371_21) / var_371_22
				local var_371_24 = Color.New(0, 0, 0)

				var_371_24.a = Mathf.Lerp(1, 0, var_371_23)
				arg_368_1.mask_.color = var_371_24
			end

			if arg_368_1.time_ >= var_371_21 + var_371_22 and arg_368_1.time_ < var_371_21 + var_371_22 + arg_371_0 then
				local var_371_25 = Color.New(0, 0, 0)
				local var_371_26 = 0

				arg_368_1.mask_.enabled = false
				var_371_25.a = var_371_26
				arg_368_1.mask_.color = var_371_25
			end

			local var_371_27 = arg_368_1.actors_["10094"].transform
			local var_371_28 = 3.73333333333333

			if var_371_28 < arg_368_1.time_ and arg_368_1.time_ <= var_371_28 + arg_371_0 then
				arg_368_1.var_.moveOldPos10094 = var_371_27.localPosition
				var_371_27.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("10094", 3)

				local var_371_29 = var_371_27.childCount

				for iter_371_2 = 0, var_371_29 - 1 do
					local var_371_30 = var_371_27:GetChild(iter_371_2)

					if var_371_30.name == "" or not string.find(var_371_30.name, "split") then
						var_371_30.gameObject:SetActive(true)
					else
						var_371_30.gameObject:SetActive(false)
					end
				end
			end

			local var_371_31 = 0.001

			if var_371_28 <= arg_368_1.time_ and arg_368_1.time_ < var_371_28 + var_371_31 then
				local var_371_32 = (arg_368_1.time_ - var_371_28) / var_371_31
				local var_371_33 = Vector3.New(0, -340, -414)

				var_371_27.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos10094, var_371_33, var_371_32)
			end

			if arg_368_1.time_ >= var_371_28 + var_371_31 and arg_368_1.time_ < var_371_28 + var_371_31 + arg_371_0 then
				var_371_27.localPosition = Vector3.New(0, -340, -414)
			end

			local var_371_34 = arg_368_1.actors_["10094"]
			local var_371_35 = 3.73333333333333

			if var_371_35 < arg_368_1.time_ and arg_368_1.time_ <= var_371_35 + arg_371_0 and not isNil(var_371_34) and arg_368_1.var_.actorSpriteComps10094 == nil then
				arg_368_1.var_.actorSpriteComps10094 = var_371_34:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_36 = 2

			if var_371_35 <= arg_368_1.time_ and arg_368_1.time_ < var_371_35 + var_371_36 and not isNil(var_371_34) then
				local var_371_37 = (arg_368_1.time_ - var_371_35) / var_371_36

				if arg_368_1.var_.actorSpriteComps10094 then
					for iter_371_3, iter_371_4 in pairs(arg_368_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_371_4 then
							if arg_368_1.isInRecall_ then
								local var_371_38 = Mathf.Lerp(iter_371_4.color.r, arg_368_1.hightColor1.r, var_371_37)
								local var_371_39 = Mathf.Lerp(iter_371_4.color.g, arg_368_1.hightColor1.g, var_371_37)
								local var_371_40 = Mathf.Lerp(iter_371_4.color.b, arg_368_1.hightColor1.b, var_371_37)

								iter_371_4.color = Color.New(var_371_38, var_371_39, var_371_40)
							else
								local var_371_41 = Mathf.Lerp(iter_371_4.color.r, 1, var_371_37)

								iter_371_4.color = Color.New(var_371_41, var_371_41, var_371_41)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= var_371_35 + var_371_36 and arg_368_1.time_ < var_371_35 + var_371_36 + arg_371_0 and not isNil(var_371_34) and arg_368_1.var_.actorSpriteComps10094 then
				for iter_371_5, iter_371_6 in pairs(arg_368_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_371_6 then
						if arg_368_1.isInRecall_ then
							iter_371_6.color = arg_368_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_371_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_368_1.var_.actorSpriteComps10094 = nil
			end

			local var_371_42 = arg_368_1.actors_["10094"]
			local var_371_43 = 3.73333333333333

			if var_371_43 < arg_368_1.time_ and arg_368_1.time_ <= var_371_43 + arg_371_0 then
				local var_371_44 = var_371_42:GetComponentInChildren(typeof(CanvasGroup))

				if var_371_44 then
					arg_368_1.var_.alphaOldValue10094 = var_371_44.alpha
					arg_368_1.var_.characterEffect10094 = var_371_44
				end

				arg_368_1.var_.alphaOldValue10094 = 0
			end

			local var_371_45 = 0.266666666666667

			if var_371_43 <= arg_368_1.time_ and arg_368_1.time_ < var_371_43 + var_371_45 then
				local var_371_46 = (arg_368_1.time_ - var_371_43) / var_371_45
				local var_371_47 = Mathf.Lerp(arg_368_1.var_.alphaOldValue10094, 1, var_371_46)

				if arg_368_1.var_.characterEffect10094 then
					arg_368_1.var_.characterEffect10094.alpha = var_371_47
				end
			end

			if arg_368_1.time_ >= var_371_43 + var_371_45 and arg_368_1.time_ < var_371_43 + var_371_45 + arg_371_0 and arg_368_1.var_.characterEffect10094 then
				arg_368_1.var_.characterEffect10094.alpha = 1
			end

			if arg_368_1.frameCnt_ <= 1 then
				arg_368_1.dialog_:SetActive(false)
			end

			local var_371_48 = 4
			local var_371_49 = 0.2

			if var_371_48 < arg_368_1.time_ and arg_368_1.time_ <= var_371_48 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				arg_368_1.dialog_:SetActive(true)

				arg_368_1.dialogCg_.alpha = 0

				local var_371_50 = LeanTween.value(arg_368_1.dialog_, 0, 1, 0.3)

				var_371_50:setOnUpdate(LuaHelper.FloatAction(function(arg_372_0)
					arg_368_1.dialogCg_.alpha = arg_372_0
				end))
				var_371_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_368_1.dialog_)
					var_371_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_368_1.duration_ = arg_368_1.duration_ + 0.3

				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_51 = arg_368_1:FormatText(StoryNameCfg[259].name)

				arg_368_1.leftNameTxt_.text = var_371_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_52 = arg_368_1:GetWordFromCfg(413112086)
				local var_371_53 = arg_368_1:FormatText(var_371_52.content)

				arg_368_1.text_.text = var_371_53

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_54 = 8
				local var_371_55 = utf8.len(var_371_53)
				local var_371_56 = var_371_54 <= 0 and var_371_49 or var_371_49 * (var_371_55 / var_371_54)

				if var_371_56 > 0 and var_371_49 < var_371_56 then
					arg_368_1.talkMaxDuration = var_371_56
					var_371_48 = var_371_48 + 0.3

					if var_371_56 + var_371_48 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_56 + var_371_48
					end
				end

				arg_368_1.text_.text = var_371_53
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112086", "story_v_out_413112.awb") ~= 0 then
					local var_371_57 = manager.audio:GetVoiceLength("story_v_out_413112", "413112086", "story_v_out_413112.awb") / 1000

					if var_371_57 + var_371_48 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_57 + var_371_48
					end

					if var_371_52.prefab_name ~= "" and arg_368_1.actors_[var_371_52.prefab_name] ~= nil then
						local var_371_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_52.prefab_name].transform, "story_v_out_413112", "413112086", "story_v_out_413112.awb")

						arg_368_1:RecordAudio("413112086", var_371_58)
						arg_368_1:RecordAudio("413112086", var_371_58)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_413112", "413112086", "story_v_out_413112.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_413112", "413112086", "story_v_out_413112.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_59 = var_371_48 + 0.3
			local var_371_60 = math.max(var_371_49, arg_368_1.talkMaxDuration)

			if var_371_59 <= arg_368_1.time_ and arg_368_1.time_ < var_371_59 + var_371_60 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_59) / var_371_60

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_59 + var_371_60 and arg_368_1.time_ < var_371_59 + var_371_60 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play413112087 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 413112087
		arg_374_1.duration_ = 7.3

		local var_374_0 = {
			zh = 6,
			ja = 7.3
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play413112088(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["10094"].transform
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 then
				arg_374_1.var_.moveOldPos10094 = var_377_0.localPosition
				var_377_0.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("10094", 3)

				local var_377_2 = var_377_0.childCount

				for iter_377_0 = 0, var_377_2 - 1 do
					local var_377_3 = var_377_0:GetChild(iter_377_0)

					if var_377_3.name == "" or not string.find(var_377_3.name, "split") then
						var_377_3.gameObject:SetActive(true)
					else
						var_377_3.gameObject:SetActive(false)
					end
				end
			end

			local var_377_4 = 0.001

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_4 then
				local var_377_5 = (arg_374_1.time_ - var_377_1) / var_377_4
				local var_377_6 = Vector3.New(0, -340, -414)

				var_377_0.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos10094, var_377_6, var_377_5)
			end

			if arg_374_1.time_ >= var_377_1 + var_377_4 and arg_374_1.time_ < var_377_1 + var_377_4 + arg_377_0 then
				var_377_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_377_7 = arg_374_1.actors_["10094"]
			local var_377_8 = 0

			if var_377_8 < arg_374_1.time_ and arg_374_1.time_ <= var_377_8 + arg_377_0 and not isNil(var_377_7) and arg_374_1.var_.actorSpriteComps10094 == nil then
				arg_374_1.var_.actorSpriteComps10094 = var_377_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_9 = 2

			if var_377_8 <= arg_374_1.time_ and arg_374_1.time_ < var_377_8 + var_377_9 and not isNil(var_377_7) then
				local var_377_10 = (arg_374_1.time_ - var_377_8) / var_377_9

				if arg_374_1.var_.actorSpriteComps10094 then
					for iter_377_1, iter_377_2 in pairs(arg_374_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_377_2 then
							if arg_374_1.isInRecall_ then
								local var_377_11 = Mathf.Lerp(iter_377_2.color.r, arg_374_1.hightColor1.r, var_377_10)
								local var_377_12 = Mathf.Lerp(iter_377_2.color.g, arg_374_1.hightColor1.g, var_377_10)
								local var_377_13 = Mathf.Lerp(iter_377_2.color.b, arg_374_1.hightColor1.b, var_377_10)

								iter_377_2.color = Color.New(var_377_11, var_377_12, var_377_13)
							else
								local var_377_14 = Mathf.Lerp(iter_377_2.color.r, 1, var_377_10)

								iter_377_2.color = Color.New(var_377_14, var_377_14, var_377_14)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= var_377_8 + var_377_9 and arg_374_1.time_ < var_377_8 + var_377_9 + arg_377_0 and not isNil(var_377_7) and arg_374_1.var_.actorSpriteComps10094 then
				for iter_377_3, iter_377_4 in pairs(arg_374_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_377_4 then
						if arg_374_1.isInRecall_ then
							iter_377_4.color = arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_377_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_374_1.var_.actorSpriteComps10094 = nil
			end

			local var_377_15 = 0
			local var_377_16 = 0.8

			if var_377_15 < arg_374_1.time_ and arg_374_1.time_ <= var_377_15 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_17 = arg_374_1:FormatText(StoryNameCfg[259].name)

				arg_374_1.leftNameTxt_.text = var_377_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_18 = arg_374_1:GetWordFromCfg(413112087)
				local var_377_19 = arg_374_1:FormatText(var_377_18.content)

				arg_374_1.text_.text = var_377_19

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_20 = 32
				local var_377_21 = utf8.len(var_377_19)
				local var_377_22 = var_377_20 <= 0 and var_377_16 or var_377_16 * (var_377_21 / var_377_20)

				if var_377_22 > 0 and var_377_16 < var_377_22 then
					arg_374_1.talkMaxDuration = var_377_22

					if var_377_22 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_22 + var_377_15
					end
				end

				arg_374_1.text_.text = var_377_19
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112087", "story_v_out_413112.awb") ~= 0 then
					local var_377_23 = manager.audio:GetVoiceLength("story_v_out_413112", "413112087", "story_v_out_413112.awb") / 1000

					if var_377_23 + var_377_15 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_23 + var_377_15
					end

					if var_377_18.prefab_name ~= "" and arg_374_1.actors_[var_377_18.prefab_name] ~= nil then
						local var_377_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_18.prefab_name].transform, "story_v_out_413112", "413112087", "story_v_out_413112.awb")

						arg_374_1:RecordAudio("413112087", var_377_24)
						arg_374_1:RecordAudio("413112087", var_377_24)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_413112", "413112087", "story_v_out_413112.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_413112", "413112087", "story_v_out_413112.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_25 = math.max(var_377_16, arg_374_1.talkMaxDuration)

			if var_377_15 <= arg_374_1.time_ and arg_374_1.time_ < var_377_15 + var_377_25 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_15) / var_377_25

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_15 + var_377_25 and arg_374_1.time_ < var_377_15 + var_377_25 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play413112088 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 413112088
		arg_378_1.duration_ = 7.17

		local var_378_0 = {
			zh = 7.166,
			ja = 4.666
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play413112089(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["10094"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos10094 = var_381_0.localPosition
				var_381_0.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10094", 2)

				local var_381_2 = var_381_0.childCount

				for iter_381_0 = 0, var_381_2 - 1 do
					local var_381_3 = var_381_0:GetChild(iter_381_0)

					if var_381_3.name == "" or not string.find(var_381_3.name, "split") then
						var_381_3.gameObject:SetActive(true)
					else
						var_381_3.gameObject:SetActive(false)
					end
				end
			end

			local var_381_4 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_4 then
				local var_381_5 = (arg_378_1.time_ - var_381_1) / var_381_4
				local var_381_6 = Vector3.New(-390, -340, -414)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10094, var_381_6, var_381_5)
			end

			if arg_378_1.time_ >= var_381_1 + var_381_4 and arg_378_1.time_ < var_381_1 + var_381_4 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_381_7 = arg_378_1.actors_["10092_1"].transform
			local var_381_8 = 0

			if var_381_8 < arg_378_1.time_ and arg_378_1.time_ <= var_381_8 + arg_381_0 then
				arg_378_1.var_.moveOldPos10092_1 = var_381_7.localPosition
				var_381_7.localScale = Vector3.New(1, 1, 1)

				arg_378_1:CheckSpriteTmpPos("10092_1", 4)

				local var_381_9 = var_381_7.childCount

				for iter_381_1 = 0, var_381_9 - 1 do
					local var_381_10 = var_381_7:GetChild(iter_381_1)

					if var_381_10.name == "split_4" or not string.find(var_381_10.name, "split") then
						var_381_10.gameObject:SetActive(true)
					else
						var_381_10.gameObject:SetActive(false)
					end
				end
			end

			local var_381_11 = 0.001

			if var_381_8 <= arg_378_1.time_ and arg_378_1.time_ < var_381_8 + var_381_11 then
				local var_381_12 = (arg_378_1.time_ - var_381_8) / var_381_11
				local var_381_13 = Vector3.New(390, -300, -295)

				var_381_7.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos10092_1, var_381_13, var_381_12)
			end

			if arg_378_1.time_ >= var_381_8 + var_381_11 and arg_378_1.time_ < var_381_8 + var_381_11 + arg_381_0 then
				var_381_7.localPosition = Vector3.New(390, -300, -295)
			end

			local var_381_14 = arg_378_1.actors_["10094"]
			local var_381_15 = 0

			if var_381_15 < arg_378_1.time_ and arg_378_1.time_ <= var_381_15 + arg_381_0 and not isNil(var_381_14) and arg_378_1.var_.actorSpriteComps10094 == nil then
				arg_378_1.var_.actorSpriteComps10094 = var_381_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_16 = 2

			if var_381_15 <= arg_378_1.time_ and arg_378_1.time_ < var_381_15 + var_381_16 and not isNil(var_381_14) then
				local var_381_17 = (arg_378_1.time_ - var_381_15) / var_381_16

				if arg_378_1.var_.actorSpriteComps10094 then
					for iter_381_2, iter_381_3 in pairs(arg_378_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_381_3 then
							if arg_378_1.isInRecall_ then
								local var_381_18 = Mathf.Lerp(iter_381_3.color.r, arg_378_1.hightColor2.r, var_381_17)
								local var_381_19 = Mathf.Lerp(iter_381_3.color.g, arg_378_1.hightColor2.g, var_381_17)
								local var_381_20 = Mathf.Lerp(iter_381_3.color.b, arg_378_1.hightColor2.b, var_381_17)

								iter_381_3.color = Color.New(var_381_18, var_381_19, var_381_20)
							else
								local var_381_21 = Mathf.Lerp(iter_381_3.color.r, 0.5, var_381_17)

								iter_381_3.color = Color.New(var_381_21, var_381_21, var_381_21)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= var_381_15 + var_381_16 and arg_378_1.time_ < var_381_15 + var_381_16 + arg_381_0 and not isNil(var_381_14) and arg_378_1.var_.actorSpriteComps10094 then
				for iter_381_4, iter_381_5 in pairs(arg_378_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_381_5 then
						if arg_378_1.isInRecall_ then
							iter_381_5.color = arg_378_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_381_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_378_1.var_.actorSpriteComps10094 = nil
			end

			local var_381_22 = arg_378_1.actors_["10092_1"]
			local var_381_23 = 0

			if var_381_23 < arg_378_1.time_ and arg_378_1.time_ <= var_381_23 + arg_381_0 and not isNil(var_381_22) and arg_378_1.var_.actorSpriteComps10092_1 == nil then
				arg_378_1.var_.actorSpriteComps10092_1 = var_381_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_381_24 = 2

			if var_381_23 <= arg_378_1.time_ and arg_378_1.time_ < var_381_23 + var_381_24 and not isNil(var_381_22) then
				local var_381_25 = (arg_378_1.time_ - var_381_23) / var_381_24

				if arg_378_1.var_.actorSpriteComps10092_1 then
					for iter_381_6, iter_381_7 in pairs(arg_378_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_381_7 then
							if arg_378_1.isInRecall_ then
								local var_381_26 = Mathf.Lerp(iter_381_7.color.r, arg_378_1.hightColor1.r, var_381_25)
								local var_381_27 = Mathf.Lerp(iter_381_7.color.g, arg_378_1.hightColor1.g, var_381_25)
								local var_381_28 = Mathf.Lerp(iter_381_7.color.b, arg_378_1.hightColor1.b, var_381_25)

								iter_381_7.color = Color.New(var_381_26, var_381_27, var_381_28)
							else
								local var_381_29 = Mathf.Lerp(iter_381_7.color.r, 1, var_381_25)

								iter_381_7.color = Color.New(var_381_29, var_381_29, var_381_29)
							end
						end
					end
				end
			end

			if arg_378_1.time_ >= var_381_23 + var_381_24 and arg_378_1.time_ < var_381_23 + var_381_24 + arg_381_0 and not isNil(var_381_22) and arg_378_1.var_.actorSpriteComps10092_1 then
				for iter_381_8, iter_381_9 in pairs(arg_378_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_381_9 then
						if arg_378_1.isInRecall_ then
							iter_381_9.color = arg_378_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_381_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_378_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_381_30 = 0
			local var_381_31 = 0.65

			if var_381_30 < arg_378_1.time_ and arg_378_1.time_ <= var_381_30 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_32 = arg_378_1:FormatText(StoryNameCfg[996].name)

				arg_378_1.leftNameTxt_.text = var_381_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_33 = arg_378_1:GetWordFromCfg(413112088)
				local var_381_34 = arg_378_1:FormatText(var_381_33.content)

				arg_378_1.text_.text = var_381_34

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_35 = 26
				local var_381_36 = utf8.len(var_381_34)
				local var_381_37 = var_381_35 <= 0 and var_381_31 or var_381_31 * (var_381_36 / var_381_35)

				if var_381_37 > 0 and var_381_31 < var_381_37 then
					arg_378_1.talkMaxDuration = var_381_37

					if var_381_37 + var_381_30 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_37 + var_381_30
					end
				end

				arg_378_1.text_.text = var_381_34
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112088", "story_v_out_413112.awb") ~= 0 then
					local var_381_38 = manager.audio:GetVoiceLength("story_v_out_413112", "413112088", "story_v_out_413112.awb") / 1000

					if var_381_38 + var_381_30 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_38 + var_381_30
					end

					if var_381_33.prefab_name ~= "" and arg_378_1.actors_[var_381_33.prefab_name] ~= nil then
						local var_381_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_33.prefab_name].transform, "story_v_out_413112", "413112088", "story_v_out_413112.awb")

						arg_378_1:RecordAudio("413112088", var_381_39)
						arg_378_1:RecordAudio("413112088", var_381_39)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_413112", "413112088", "story_v_out_413112.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_413112", "413112088", "story_v_out_413112.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_40 = math.max(var_381_31, arg_378_1.talkMaxDuration)

			if var_381_30 <= arg_378_1.time_ and arg_378_1.time_ < var_381_30 + var_381_40 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_30) / var_381_40

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_30 + var_381_40 and arg_378_1.time_ < var_381_30 + var_381_40 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play413112089 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 413112089
		arg_382_1.duration_ = 6.07

		local var_382_0 = {
			zh = 2.033,
			ja = 6.066
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play413112090(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["10094"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps10094 == nil then
				arg_382_1.var_.actorSpriteComps10094 = var_385_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_2 = 2

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.actorSpriteComps10094 then
					for iter_385_0, iter_385_1 in pairs(arg_382_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_385_1 then
							if arg_382_1.isInRecall_ then
								local var_385_4 = Mathf.Lerp(iter_385_1.color.r, arg_382_1.hightColor1.r, var_385_3)
								local var_385_5 = Mathf.Lerp(iter_385_1.color.g, arg_382_1.hightColor1.g, var_385_3)
								local var_385_6 = Mathf.Lerp(iter_385_1.color.b, arg_382_1.hightColor1.b, var_385_3)

								iter_385_1.color = Color.New(var_385_4, var_385_5, var_385_6)
							else
								local var_385_7 = Mathf.Lerp(iter_385_1.color.r, 1, var_385_3)

								iter_385_1.color = Color.New(var_385_7, var_385_7, var_385_7)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.actorSpriteComps10094 then
				for iter_385_2, iter_385_3 in pairs(arg_382_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_385_3 then
						if arg_382_1.isInRecall_ then
							iter_385_3.color = arg_382_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_385_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps10094 = nil
			end

			local var_385_8 = arg_382_1.actors_["10092_1"]
			local var_385_9 = 0

			if var_385_9 < arg_382_1.time_ and arg_382_1.time_ <= var_385_9 + arg_385_0 and not isNil(var_385_8) and arg_382_1.var_.actorSpriteComps10092_1 == nil then
				arg_382_1.var_.actorSpriteComps10092_1 = var_385_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_385_10 = 2

			if var_385_9 <= arg_382_1.time_ and arg_382_1.time_ < var_385_9 + var_385_10 and not isNil(var_385_8) then
				local var_385_11 = (arg_382_1.time_ - var_385_9) / var_385_10

				if arg_382_1.var_.actorSpriteComps10092_1 then
					for iter_385_4, iter_385_5 in pairs(arg_382_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_385_5 then
							if arg_382_1.isInRecall_ then
								local var_385_12 = Mathf.Lerp(iter_385_5.color.r, arg_382_1.hightColor2.r, var_385_11)
								local var_385_13 = Mathf.Lerp(iter_385_5.color.g, arg_382_1.hightColor2.g, var_385_11)
								local var_385_14 = Mathf.Lerp(iter_385_5.color.b, arg_382_1.hightColor2.b, var_385_11)

								iter_385_5.color = Color.New(var_385_12, var_385_13, var_385_14)
							else
								local var_385_15 = Mathf.Lerp(iter_385_5.color.r, 0.5, var_385_11)

								iter_385_5.color = Color.New(var_385_15, var_385_15, var_385_15)
							end
						end
					end
				end
			end

			if arg_382_1.time_ >= var_385_9 + var_385_10 and arg_382_1.time_ < var_385_9 + var_385_10 + arg_385_0 and not isNil(var_385_8) and arg_382_1.var_.actorSpriteComps10092_1 then
				for iter_385_6, iter_385_7 in pairs(arg_382_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_385_7 then
						if arg_382_1.isInRecall_ then
							iter_385_7.color = arg_382_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_385_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_382_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_385_16 = 0
			local var_385_17 = 0.275

			if var_385_16 < arg_382_1.time_ and arg_382_1.time_ <= var_385_16 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_18 = arg_382_1:FormatText(StoryNameCfg[259].name)

				arg_382_1.leftNameTxt_.text = var_385_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_19 = arg_382_1:GetWordFromCfg(413112089)
				local var_385_20 = arg_382_1:FormatText(var_385_19.content)

				arg_382_1.text_.text = var_385_20

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_21 = 11
				local var_385_22 = utf8.len(var_385_20)
				local var_385_23 = var_385_21 <= 0 and var_385_17 or var_385_17 * (var_385_22 / var_385_21)

				if var_385_23 > 0 and var_385_17 < var_385_23 then
					arg_382_1.talkMaxDuration = var_385_23

					if var_385_23 + var_385_16 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_23 + var_385_16
					end
				end

				arg_382_1.text_.text = var_385_20
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112089", "story_v_out_413112.awb") ~= 0 then
					local var_385_24 = manager.audio:GetVoiceLength("story_v_out_413112", "413112089", "story_v_out_413112.awb") / 1000

					if var_385_24 + var_385_16 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_24 + var_385_16
					end

					if var_385_19.prefab_name ~= "" and arg_382_1.actors_[var_385_19.prefab_name] ~= nil then
						local var_385_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_19.prefab_name].transform, "story_v_out_413112", "413112089", "story_v_out_413112.awb")

						arg_382_1:RecordAudio("413112089", var_385_25)
						arg_382_1:RecordAudio("413112089", var_385_25)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_413112", "413112089", "story_v_out_413112.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_413112", "413112089", "story_v_out_413112.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_26 = math.max(var_385_17, arg_382_1.talkMaxDuration)

			if var_385_16 <= arg_382_1.time_ and arg_382_1.time_ < var_385_16 + var_385_26 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_16) / var_385_26

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_16 + var_385_26 and arg_382_1.time_ < var_385_16 + var_385_26 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play413112090 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 413112090
		arg_386_1.duration_ = 8.03

		local var_386_0 = {
			zh = 5.366,
			ja = 8.033
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play413112091(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["10094"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.actorSpriteComps10094 == nil then
				arg_386_1.var_.actorSpriteComps10094 = var_389_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_2 = 2

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.actorSpriteComps10094 then
					for iter_389_0, iter_389_1 in pairs(arg_386_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_389_1 then
							if arg_386_1.isInRecall_ then
								local var_389_4 = Mathf.Lerp(iter_389_1.color.r, arg_386_1.hightColor2.r, var_389_3)
								local var_389_5 = Mathf.Lerp(iter_389_1.color.g, arg_386_1.hightColor2.g, var_389_3)
								local var_389_6 = Mathf.Lerp(iter_389_1.color.b, arg_386_1.hightColor2.b, var_389_3)

								iter_389_1.color = Color.New(var_389_4, var_389_5, var_389_6)
							else
								local var_389_7 = Mathf.Lerp(iter_389_1.color.r, 0.5, var_389_3)

								iter_389_1.color = Color.New(var_389_7, var_389_7, var_389_7)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.actorSpriteComps10094 then
				for iter_389_2, iter_389_3 in pairs(arg_386_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_389_3 then
						if arg_386_1.isInRecall_ then
							iter_389_3.color = arg_386_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_389_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_386_1.var_.actorSpriteComps10094 = nil
			end

			local var_389_8 = arg_386_1.actors_["10092_1"]
			local var_389_9 = 0

			if var_389_9 < arg_386_1.time_ and arg_386_1.time_ <= var_389_9 + arg_389_0 and not isNil(var_389_8) and arg_386_1.var_.actorSpriteComps10092_1 == nil then
				arg_386_1.var_.actorSpriteComps10092_1 = var_389_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_389_10 = 2

			if var_389_9 <= arg_386_1.time_ and arg_386_1.time_ < var_389_9 + var_389_10 and not isNil(var_389_8) then
				local var_389_11 = (arg_386_1.time_ - var_389_9) / var_389_10

				if arg_386_1.var_.actorSpriteComps10092_1 then
					for iter_389_4, iter_389_5 in pairs(arg_386_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_389_5 then
							if arg_386_1.isInRecall_ then
								local var_389_12 = Mathf.Lerp(iter_389_5.color.r, arg_386_1.hightColor1.r, var_389_11)
								local var_389_13 = Mathf.Lerp(iter_389_5.color.g, arg_386_1.hightColor1.g, var_389_11)
								local var_389_14 = Mathf.Lerp(iter_389_5.color.b, arg_386_1.hightColor1.b, var_389_11)

								iter_389_5.color = Color.New(var_389_12, var_389_13, var_389_14)
							else
								local var_389_15 = Mathf.Lerp(iter_389_5.color.r, 1, var_389_11)

								iter_389_5.color = Color.New(var_389_15, var_389_15, var_389_15)
							end
						end
					end
				end
			end

			if arg_386_1.time_ >= var_389_9 + var_389_10 and arg_386_1.time_ < var_389_9 + var_389_10 + arg_389_0 and not isNil(var_389_8) and arg_386_1.var_.actorSpriteComps10092_1 then
				for iter_389_6, iter_389_7 in pairs(arg_386_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_389_7 then
						if arg_386_1.isInRecall_ then
							iter_389_7.color = arg_386_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_389_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_386_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_389_16 = 0
			local var_389_17 = 0.725

			if var_389_16 < arg_386_1.time_ and arg_386_1.time_ <= var_389_16 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_18 = arg_386_1:FormatText(StoryNameCfg[996].name)

				arg_386_1.leftNameTxt_.text = var_389_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_19 = arg_386_1:GetWordFromCfg(413112090)
				local var_389_20 = arg_386_1:FormatText(var_389_19.content)

				arg_386_1.text_.text = var_389_20

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_21 = 29
				local var_389_22 = utf8.len(var_389_20)
				local var_389_23 = var_389_21 <= 0 and var_389_17 or var_389_17 * (var_389_22 / var_389_21)

				if var_389_23 > 0 and var_389_17 < var_389_23 then
					arg_386_1.talkMaxDuration = var_389_23

					if var_389_23 + var_389_16 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_23 + var_389_16
					end
				end

				arg_386_1.text_.text = var_389_20
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112090", "story_v_out_413112.awb") ~= 0 then
					local var_389_24 = manager.audio:GetVoiceLength("story_v_out_413112", "413112090", "story_v_out_413112.awb") / 1000

					if var_389_24 + var_389_16 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_24 + var_389_16
					end

					if var_389_19.prefab_name ~= "" and arg_386_1.actors_[var_389_19.prefab_name] ~= nil then
						local var_389_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_19.prefab_name].transform, "story_v_out_413112", "413112090", "story_v_out_413112.awb")

						arg_386_1:RecordAudio("413112090", var_389_25)
						arg_386_1:RecordAudio("413112090", var_389_25)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_413112", "413112090", "story_v_out_413112.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_413112", "413112090", "story_v_out_413112.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_26 = math.max(var_389_17, arg_386_1.talkMaxDuration)

			if var_389_16 <= arg_386_1.time_ and arg_386_1.time_ < var_389_16 + var_389_26 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_16) / var_389_26

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_16 + var_389_26 and arg_386_1.time_ < var_389_16 + var_389_26 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play413112091 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 413112091
		arg_390_1.duration_ = 3.9

		local var_390_0 = {
			zh = 1.999999999999,
			ja = 3.9
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
			arg_390_1.auto_ = false
		end

		function arg_390_1.playNext_(arg_392_0)
			arg_390_1.onStoryFinished_()
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["10092_1"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos10092_1 = var_393_0.localPosition
				var_393_0.localScale = Vector3.New(1, 1, 1)

				arg_390_1:CheckSpriteTmpPos("10092_1", 4)

				local var_393_2 = var_393_0.childCount

				for iter_393_0 = 0, var_393_2 - 1 do
					local var_393_3 = var_393_0:GetChild(iter_393_0)

					if var_393_3.name == "split_4" or not string.find(var_393_3.name, "split") then
						var_393_3.gameObject:SetActive(true)
					else
						var_393_3.gameObject:SetActive(false)
					end
				end
			end

			local var_393_4 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_4 then
				local var_393_5 = (arg_390_1.time_ - var_393_1) / var_393_4
				local var_393_6 = Vector3.New(390, -300, -295)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos10092_1, var_393_6, var_393_5)
			end

			if arg_390_1.time_ >= var_393_1 + var_393_4 and arg_390_1.time_ < var_393_1 + var_393_4 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(390, -300, -295)
			end

			local var_393_7 = arg_390_1.actors_["10094"]
			local var_393_8 = 0

			if var_393_8 < arg_390_1.time_ and arg_390_1.time_ <= var_393_8 + arg_393_0 and not isNil(var_393_7) and arg_390_1.var_.actorSpriteComps10094 == nil then
				arg_390_1.var_.actorSpriteComps10094 = var_393_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_9 = 2

			if var_393_8 <= arg_390_1.time_ and arg_390_1.time_ < var_393_8 + var_393_9 and not isNil(var_393_7) then
				local var_393_10 = (arg_390_1.time_ - var_393_8) / var_393_9

				if arg_390_1.var_.actorSpriteComps10094 then
					for iter_393_1, iter_393_2 in pairs(arg_390_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_393_2 then
							if arg_390_1.isInRecall_ then
								local var_393_11 = Mathf.Lerp(iter_393_2.color.r, arg_390_1.hightColor2.r, var_393_10)
								local var_393_12 = Mathf.Lerp(iter_393_2.color.g, arg_390_1.hightColor2.g, var_393_10)
								local var_393_13 = Mathf.Lerp(iter_393_2.color.b, arg_390_1.hightColor2.b, var_393_10)

								iter_393_2.color = Color.New(var_393_11, var_393_12, var_393_13)
							else
								local var_393_14 = Mathf.Lerp(iter_393_2.color.r, 0.5, var_393_10)

								iter_393_2.color = Color.New(var_393_14, var_393_14, var_393_14)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_8 + var_393_9 and arg_390_1.time_ < var_393_8 + var_393_9 + arg_393_0 and not isNil(var_393_7) and arg_390_1.var_.actorSpriteComps10094 then
				for iter_393_3, iter_393_4 in pairs(arg_390_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_393_4 then
						if arg_390_1.isInRecall_ then
							iter_393_4.color = arg_390_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_393_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps10094 = nil
			end

			local var_393_15 = arg_390_1.actors_["10092_1"]
			local var_393_16 = 0

			if var_393_16 < arg_390_1.time_ and arg_390_1.time_ <= var_393_16 + arg_393_0 and not isNil(var_393_15) and arg_390_1.var_.actorSpriteComps10092_1 == nil then
				arg_390_1.var_.actorSpriteComps10092_1 = var_393_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_393_17 = 2

			if var_393_16 <= arg_390_1.time_ and arg_390_1.time_ < var_393_16 + var_393_17 and not isNil(var_393_15) then
				local var_393_18 = (arg_390_1.time_ - var_393_16) / var_393_17

				if arg_390_1.var_.actorSpriteComps10092_1 then
					for iter_393_5, iter_393_6 in pairs(arg_390_1.var_.actorSpriteComps10092_1:ToTable()) do
						if iter_393_6 then
							if arg_390_1.isInRecall_ then
								local var_393_19 = Mathf.Lerp(iter_393_6.color.r, arg_390_1.hightColor1.r, var_393_18)
								local var_393_20 = Mathf.Lerp(iter_393_6.color.g, arg_390_1.hightColor1.g, var_393_18)
								local var_393_21 = Mathf.Lerp(iter_393_6.color.b, arg_390_1.hightColor1.b, var_393_18)

								iter_393_6.color = Color.New(var_393_19, var_393_20, var_393_21)
							else
								local var_393_22 = Mathf.Lerp(iter_393_6.color.r, 1, var_393_18)

								iter_393_6.color = Color.New(var_393_22, var_393_22, var_393_22)
							end
						end
					end
				end
			end

			if arg_390_1.time_ >= var_393_16 + var_393_17 and arg_390_1.time_ < var_393_16 + var_393_17 + arg_393_0 and not isNil(var_393_15) and arg_390_1.var_.actorSpriteComps10092_1 then
				for iter_393_7, iter_393_8 in pairs(arg_390_1.var_.actorSpriteComps10092_1:ToTable()) do
					if iter_393_8 then
						if arg_390_1.isInRecall_ then
							iter_393_8.color = arg_390_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_393_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_390_1.var_.actorSpriteComps10092_1 = nil
			end

			local var_393_23 = 0
			local var_393_24 = 0.075

			if var_393_23 < arg_390_1.time_ and arg_390_1.time_ <= var_393_23 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_25 = arg_390_1:FormatText(StoryNameCfg[996].name)

				arg_390_1.leftNameTxt_.text = var_393_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_26 = arg_390_1:GetWordFromCfg(413112091)
				local var_393_27 = arg_390_1:FormatText(var_393_26.content)

				arg_390_1.text_.text = var_393_27

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_28 = 3
				local var_393_29 = utf8.len(var_393_27)
				local var_393_30 = var_393_28 <= 0 and var_393_24 or var_393_24 * (var_393_29 / var_393_28)

				if var_393_30 > 0 and var_393_24 < var_393_30 then
					arg_390_1.talkMaxDuration = var_393_30

					if var_393_30 + var_393_23 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_30 + var_393_23
					end
				end

				arg_390_1.text_.text = var_393_27
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413112", "413112091", "story_v_out_413112.awb") ~= 0 then
					local var_393_31 = manager.audio:GetVoiceLength("story_v_out_413112", "413112091", "story_v_out_413112.awb") / 1000

					if var_393_31 + var_393_23 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_31 + var_393_23
					end

					if var_393_26.prefab_name ~= "" and arg_390_1.actors_[var_393_26.prefab_name] ~= nil then
						local var_393_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_26.prefab_name].transform, "story_v_out_413112", "413112091", "story_v_out_413112.awb")

						arg_390_1:RecordAudio("413112091", var_393_32)
						arg_390_1:RecordAudio("413112091", var_393_32)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_413112", "413112091", "story_v_out_413112.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_413112", "413112091", "story_v_out_413112.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_33 = math.max(var_393_24, arg_390_1.talkMaxDuration)

			if var_393_23 <= arg_390_1.time_ and arg_390_1.time_ < var_393_23 + var_393_33 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_23) / var_393_33

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_23 + var_393_33 and arg_390_1.time_ < var_393_23 + var_393_33 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F10g",
		"TextureConfig/Background/F09f",
		"TextureConfig/Background/SS1308"
	},
	voices = {
		"story_v_out_413112.awb"
	}
}
